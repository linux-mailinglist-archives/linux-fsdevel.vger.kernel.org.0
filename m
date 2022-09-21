Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1A5BF943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIUIaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUIaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:30:10 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427AE12765;
        Wed, 21 Sep 2022 01:30:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 24A2211010A1;
        Wed, 21 Sep 2022 18:30:06 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oav7M-00AKcy-H0; Wed, 21 Sep 2022 18:30:04 +1000
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oav7M-005vTb-1Y;
        Wed, 21 Sep 2022 18:30:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached iomaps
Date:   Wed, 21 Sep 2022 18:29:59 +1000
Message-Id: <20220921082959.1411675-3-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921082959.1411675-1-david@fromorbit.com>
References: <20220921082959.1411675-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=632acb8e
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=xOM3xZuef0cA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=9OLnYhGjAqVIL6cWKtQA:9 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that iomap supports a mechanism to validate cached iomaps for
buffered write operations, hook it up to the XFS buffered write ops
so that we can avoid data corruptions that result from stale cached
iomaps. See:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

or the ->iomap_valid() introduction commit for exact details of the
corruption vector.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_iomap.c | 53 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 07da03976ec1..2e77ae817e6b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -91,6 +91,12 @@ xfs_bmbt_to_iomap(
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
+
+	/*
+	 * Sample the extent tree sequence so that we can detect if the tree
+	 * changes while the iomap is still being used.
+	 */
+	*((int *)&iomap->private) = READ_ONCE(ip->i_df.if_seq);
 	return 0;
 }
 
@@ -915,6 +921,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u16			remap_flags = 0;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -926,6 +933,20 @@ xfs_buffered_write_iomap_begin(
 
 	ASSERT(!XFS_IS_REALTIME_INODE(ip));
 
+	/*
+	 * If we are remapping a stale iomap, preserve the IOMAP_F_NEW flag
+	 * if it is passed to us. This will only be set if we are remapping a
+	 * range that we just allocated and hence had set IOMAP_F_NEW on. We
+	 * need to set it again here so any further writes over this newly
+	 * allocated region we are remapping are preserved.
+	 *
+	 * This pairs with the code in xfs_buffered_write_iomap_end() that skips
+	 * punching newly allocated delalloc regions that have iomaps marked as
+	 * stale.
+	 */
+	if (iomap->flags & IOMAP_F_STALE)
+		remap_flags = iomap->flags & IOMAP_F_NEW;
+
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -1100,7 +1121,7 @@ xfs_buffered_write_iomap_begin(
 
 found_imap:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, remap_flags);
 
 found_cow:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1160,13 +1181,20 @@ xfs_buffered_write_iomap_end(
 
 	/*
 	 * Trim delalloc blocks if they were allocated by this write and we
-	 * didn't manage to write the whole range.
+	 * didn't manage to write the whole range. If the iomap was marked stale
+	 * because it is no longer valid, we are going to remap this range
+	 * immediately, so don't punch it out.
 	 *
-	 * We don't need to care about racing delalloc as we hold i_mutex
+	 * XXX (dgc): This next comment and assumption is totally bogus because
+	 * iomap_page_mkwrite() runs through here and it doesn't hold the
+	 * i_rwsem. Hence this whole error handling path may be badly broken.
+	 *
+	 * We don't need to care about racing delalloc as we hold i_rwsem
 	 * across the reserve/allocate/unreserve calls. If there are delalloc
 	 * blocks in the range, they are ours.
 	 */
-	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
+	if (((iomap->flags & (IOMAP_F_NEW | IOMAP_F_STALE)) == IOMAP_F_NEW) &&
+	    start_fsb < end_fsb) {
 		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
 					 XFS_FSB_TO_B(mp, end_fsb) - 1);
 
@@ -1182,9 +1210,26 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+/*
+ * Check that the iomap passed to us is still valid for the given offset and
+ * length.
+ */
+static bool
+xfs_buffered_write_iomap_valid(
+	struct inode		*inode,
+	const struct iomap	*iomap)
+{
+	int			seq = *((int *)&iomap->private);
+
+	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
+		return false;
+	return true;
+}
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
 	.iomap_begin		= xfs_buffered_write_iomap_begin,
 	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_valid		= xfs_buffered_write_iomap_valid,
 };
 
 static int
-- 
2.37.2

