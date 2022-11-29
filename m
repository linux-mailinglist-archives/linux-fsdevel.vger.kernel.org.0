Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC063B715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 02:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiK2BW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 20:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiK2BWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B342F56;
        Mon, 28 Nov 2022 17:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFBF361195;
        Tue, 29 Nov 2022 01:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E7BC433D6;
        Tue, 29 Nov 2022 01:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669684923;
        bh=J1bUv5N+o2pBz4zrbz+h04R0Qnbsu21Wh5lla/Wk28M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6GCFi6IXMYJ2fiflzu5FKoz1x1fecOX8Kug1V0WHOWV/epsh/f8+lu+i0Rhz97tF
         4hVnAo42tDOXqPjPCMBcYtwJZbGpL26dSS81XQacGkL1GkLk78y4SQrV5vS8qiKnMY
         3jzVlFD/u784Ok8reGH3dlFPWcEtqkFtK4z4/wINU77bwEFNppvN8QbeiJi2QYQLgP
         N2NkO7iz8p7GnQlQiZ9dv9Vv41bZhdDUV5w8tGnLAb91f+VjrDNDDXLkqNBFZJ+bi7
         zItmvFH4KqsNhHPvMtqnqtkuFgTxCzXci0rArPL3VZB5vv4XuWnc8p3JdXOVhx+CIt
         N12sGM/Iup3yQ==
Date:   Mon, 28 Nov 2022 17:22:02 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/9] xfs: add debug knob to slow down write for fun
Message-ID: <Y4VeuqfVBU4/x9aB@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3dj5qvpKSQuNM@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4U3dj5qvpKSQuNM@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new error injection knob so that we can arbitrarily slow down
pagecahe writes to test for race conditions and aberrant reclaim
behavior if the writeback mechanisms are slow to issue writeback.  This
will enable functional testing for the ifork sequence counters
introduced in commit XXXXXXXXXXXX that fixes write racing with reclaim
writeback.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v2: this time with tracepoints
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/xfs_error.c           |    3 +++
 fs/xfs/xfs_iomap.c           |   14 ++++++++++++--
 fs/xfs/xfs_trace.h           |   42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index f5f629174eca..01a9e86b3037 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -62,7 +62,8 @@
 #define XFS_ERRTAG_DA_LEAF_SPLIT			40
 #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
 #define XFS_ERRTAG_WB_DELAY_MS				42
-#define XFS_ERRTAG_MAX					43
+#define XFS_ERRTAG_WRITE_DELAY_MS			43
+#define XFS_ERRTAG_MAX					44
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -109,5 +110,6 @@
 #define XFS_RANDOM_DA_LEAF_SPLIT			1
 #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
 #define XFS_RANDOM_WB_DELAY_MS				3000
+#define XFS_RANDOM_WRITE_DELAY_MS			3000
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 13ac52e7f9e5..d9f9ee969fab 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -61,6 +61,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_DA_LEAF_SPLIT,
 	XFS_RANDOM_ATTR_LEAF_TO_NODE,
 	XFS_RANDOM_WB_DELAY_MS,
+	XFS_RANDOM_WRITE_DELAY_MS,
 };
 
 struct xfs_errortag_attr {
@@ -177,6 +178,7 @@ XFS_ERRORTAG_ATTR_RW(larp,		XFS_ERRTAG_LARP);
 XFS_ERRORTAG_ATTR_RW(da_leaf_split,	XFS_ERRTAG_DA_LEAF_SPLIT);
 XFS_ERRORTAG_ATTR_RW(attr_leaf_to_node,	XFS_ERRTAG_ATTR_LEAF_TO_NODE);
 XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
+XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -221,6 +223,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(da_leaf_split),
 	XFS_ERRORTAG_ATTR_LIST(attr_leaf_to_node),
 	XFS_ERRORTAG_ATTR_LIST(wb_delay_ms),
+	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1bdd7afc1010..1005f1e36545 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,8 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -71,8 +73,16 @@ xfs_iomap_valid(
 	struct inode		*inode,
 	const struct iomap	*iomap)
 {
-	return iomap->validity_cookie ==
-			xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (iomap->validity_cookie !=
+			xfs_iomap_inode_sequence(ip, iomap->flags)) {
+		trace_xfs_iomap_invalid(ip, iomap);
+		return false;
+	}
+
+	XFS_ERRORTAG_DELAY(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
+	return true;
 }
 
 const struct iomap_page_ops xfs_iomap_page_ops = {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index c9ada9577a4a..421d1e504ac4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3396,6 +3396,48 @@ DEFINE_EVENT(xfs_wb_invalid_class, name, \
 DEFINE_WB_INVALID_EVENT(xfs_wb_cow_iomap_invalid);
 DEFINE_WB_INVALID_EVENT(xfs_wb_data_iomap_invalid);
 
+DECLARE_EVENT_CLASS(xfs_iomap_invalid_class,
+	TP_PROTO(struct xfs_inode *ip, const struct iomap *iomap),
+	TP_ARGS(ip, iomap),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, addr)
+		__field(loff_t, pos)
+		__field(u64, len)
+		__field(u64, validity_cookie)
+		__field(u64, inodeseq)
+		__field(u16, type)
+		__field(u16, flags)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->addr = iomap->addr;
+		__entry->pos = iomap->offset;
+		__entry->len = iomap->length;
+		__entry->validity_cookie = iomap->validity_cookie;
+		__entry->type = iomap->type;
+		__entry->flags = iomap->flags;
+		__entry->inodeseq = xfs_iomap_inode_sequence(ip, iomap->flags);
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx addr 0x%llx bytecount 0x%llx type 0x%x flags 0x%x validity_cookie 0x%llx inodeseq 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->addr,
+		  __entry->len,
+		  __entry->type,
+		  __entry->flags,
+		  __entry->validity_cookie,
+		  __entry->inodeseq)
+);
+#define DEFINE_IOMAP_INVALID_EVENT(name) \
+DEFINE_EVENT(xfs_iomap_invalid_class, name, \
+	TP_PROTO(struct xfs_inode *ip, const struct iomap *iomap), \
+	TP_ARGS(ip, iomap))
+DEFINE_IOMAP_INVALID_EVENT(xfs_iomap_invalid);
+
 /* refcount/reflink tracepoint definitions */
 
 /* reflink tracepoints */
