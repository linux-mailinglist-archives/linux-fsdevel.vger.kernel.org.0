Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2459898B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbiHRRAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiHRRA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A691C12C0;
        Thu, 18 Aug 2022 10:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EB546163F;
        Thu, 18 Aug 2022 17:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C28C43470;
        Thu, 18 Aug 2022 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842017;
        bh=4alT+1kcW0AynTw4CzIKjHnkkcstzi9mfOYgPu9672k=;
        h=Date:From:To:Cc:Subject:From;
        b=LAdvY8HWNTKDjWAYsDasqK2xyXkUL5AdcRrhffJlzOahe/Nthx9qZv02KrOQhM2F6
         BKVXCJusocInSjVo0c2x/ExHLwoJIbWAo31cpvumUUcm2yewTjEjKoSyeW5uLyjMn5
         MWxgjt2y0iQWSVQSxl7rA2tnIOs9sk27Q/DhS2L3YG+eCnnUq/nXxVuK9elVqhal0z
         lGWPg70nVFUqE742DkI6Z4OjizVs+BLISNz8iLdeHVkX0to/b7ad8qyL1kq3DLXtk8
         KXSyI0LSHzOzTtnJ7aDzLLTOwPq0l3kNJ7uE6yVCdxXtWyZKGdmguQisnc5feZ3yGw
         BUngpS41E2yRg==
Date:   Thu, 18 Aug 2022 10:00:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: [PATCH] xfs: on memory failure, only shut down fs after scanning all
 mappings
Message-ID: <Yv5wIa2crHioYeRr@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

xfs_dax_failure_fn is used to scan the filesystem during a memory
failure event to look for memory mappings to revoke.  Unfortunately, if
it encounters an rmap record for filesystem metadata, it will shut down
the filesystem and the scan immediately.  This means that we don't
complete the mapping revocation scan and instead leave live mappings to
failed memory.  Fix the function to defer the shutdown until after we've
finished culling mappings.

While we're at it, add the usual "xfs_" prefix to struct failure_info,
and actually initialize mf_flags.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_notify_failure.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 69d9c83ea4b2..65d5eb20878e 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -23,17 +23,18 @@
 #include <linux/mm.h>
 #include <linux/dax.h>
 
-struct failure_info {
+struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
 	int			mf_flags;
+	bool			want_shutdown;
 };
 
 static pgoff_t
 xfs_failure_pgoff(
 	struct xfs_mount		*mp,
 	const struct xfs_rmap_irec	*rec,
-	const struct failure_info	*notify)
+	const struct xfs_failure_info	*notify)
 {
 	loff_t				pos = XFS_FSB_TO_B(mp, rec->rm_offset);
 
@@ -47,7 +48,7 @@ static unsigned long
 xfs_failure_pgcnt(
 	struct xfs_mount		*mp,
 	const struct xfs_rmap_irec	*rec,
-	const struct failure_info	*notify)
+	const struct xfs_failure_info	*notify)
 {
 	xfs_agblock_t			end_rec;
 	xfs_agblock_t			end_notify;
@@ -71,13 +72,13 @@ xfs_dax_failure_fn(
 {
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_inode		*ip;
-	struct failure_info		*notify = data;
+	struct xfs_failure_info		*notify = data;
 	int				error = 0;
 
 	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
-		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
-		return -EFSCORRUPTED;
+		notify->want_shutdown = true;
+		return 0;
 	}
 
 	/* Get files that incore, filter out others that are not in use. */
@@ -86,8 +87,10 @@ xfs_dax_failure_fn(
 	/* Continue the rmap query if the inode isn't incore */
 	if (error == -ENODATA)
 		return 0;
-	if (error)
-		return error;
+	if (error) {
+		notify->want_shutdown = true;
+		return 0;
+	}
 
 	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
 				  xfs_failure_pgoff(mp, rec, notify),
@@ -104,6 +107,7 @@ xfs_dax_notify_ddev_failure(
 	xfs_daddr_t		bblen,
 	int			mf_flags)
 {
+	struct xfs_failure_info	notify = { .mf_flags = mf_flags };
 	struct xfs_trans	*tp = NULL;
 	struct xfs_btree_cur	*cur = NULL;
 	struct xfs_buf		*agf_bp = NULL;
@@ -120,7 +124,6 @@ xfs_dax_notify_ddev_failure(
 	for (; agno <= end_agno; agno++) {
 		struct xfs_rmap_irec	ri_low = { };
 		struct xfs_rmap_irec	ri_high;
-		struct failure_info	notify;
 		struct xfs_agf		*agf;
 		xfs_agblock_t		agend;
 		struct xfs_perag	*pag;
@@ -161,6 +164,11 @@ xfs_dax_notify_ddev_failure(
 	}
 
 	xfs_trans_cancel(tp);
+	if (error || notify.want_shutdown) {
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+		if (!error)
+			error = -EFSCORRUPTED;
+	}
 	return error;
 }
 
