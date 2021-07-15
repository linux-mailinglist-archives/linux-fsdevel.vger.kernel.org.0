Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282A3C984F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhGOFZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOFZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:25:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4AC06175F;
        Wed, 14 Jul 2021 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OEayz0vZXxwwb3sWZ+SAgeiLQoq44uIs+KhQN0qQl24=; b=FmtWYY/oWmGpoEUgYE/RHzdYLy
        ocgOBwztS7HKoxdwelwFUgCnm37OXO30npMu8yaN3dlK1TusdwbGwYkdNGV3ePZORrwRm7G1YSvX/
        gcln7h/IOxpmG/DdGZYaQFH9e7SeBiZ4tajKEPjtEYypq11HKvMHe3rVQT7ERSao4d3Q2JoBuWvKf
        h3BP6IU7GXmQDdf+iYuCwZnx6IhqYrd9jHxi89BE9Cy/PnTHxvHSiIcOpHHRS9lmwnGmHbrn/34zk
        IZR11hom7n94NMOoPOYAVxpEXuNLgSPQ3lHvCPlNoVvro4r8y6EW/59T+544uTjLYUvNi9nG7071g
        xOaxAGgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tnc-0030rA-2g; Thu, 15 Jul 2021 05:20:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 129/138] xfs: Support THPs
Date:   Thu, 15 Jul 2021 04:36:55 +0100
Message-Id: <20210715033704.692967-130-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is one place which assumes the size of a page; fix it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_aops.c  | 11 ++++++-----
 fs/xfs/xfs_super.c |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index cb4e0fcf4c76..9ffbd116592a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -432,10 +432,11 @@ xfs_discard_page(
 	struct page		*page,
 	loff_t			fileoff)
 {
-	struct inode		*inode = page->mapping->host;
+	struct folio		*folio = page_folio(page);
+	struct inode		*inode = folio->mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	unsigned int		pageoff = offset_in_page(fileoff);
+	size_t			pageoff = offset_in_folio(folio, fileoff);
 	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
 	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
 	int			error;
@@ -445,14 +446,14 @@ xfs_discard_page(
 
 	xfs_alert_ratelimited(mp,
 		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
-			page, ip->i_ino, fileoff);
+			folio, ip->i_ino, fileoff);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			i_blocks_per_page(inode, page) - pageoff_fsb);
+			i_blocks_per_folio(inode, folio) - pageoff_fsb);
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
+	iomap_invalidatepage(&folio->page, pageoff, folio_size(folio) - pageoff);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2c9e26a44546..24adea02b887 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1891,7 +1891,8 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | \
+				  FS_THP_SUPPORT,
 };
 MODULE_ALIAS_FS("xfs");
 
-- 
2.30.2

