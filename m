Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753394AFE59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiBIUXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B6E040DFC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dRSNPvRPmNf+uSU/RGLzd5bJNMQyxHGxBGnjWcVLYvI=; b=F0CB0nRe9U0hdNgzoS71piTWXN
        6L5ToZUFjAAYiiyiWSW0FOsGhllyTuH5xt43He8wJqT+Um/z33Urp4DgOrUydUTA8Ql6KXzNFbpRT
        iRY8vA7G6Bpq7VCdNV/COQy9ul1/6dwm750vRamK4HGDuT+7BNNuwZ1aOMAAjA9ns6T+67eCAw5bI
        XTmUH7j6NWHsy7Caz7LvMFavSUxX85hEdjn6druSdShzWvjwT97zjH2KZlykNZcJGlnN+93BkbKY/
        sol/JEMuHwKwoPMAjaZk4EfMzEij03mtYCq/zaL3JFOQAAslHN+6qiR3vGIn3Jq0XknZkkKhksuJD
        qq1AH24g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008csm-4g; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 44/56] fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio
Date:   Wed,  9 Feb 2022 20:22:03 +0000
Message-Id: <20220209202215.2055748-45-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These filesystems use __set_page_dirty_nobuffers() either directly or
with a very thin wrapper; convert them en masse.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/inode.c        |  7 +------
 fs/ext4/inode.c         | 21 +++++++++++----------
 fs/fuse/file.c          |  2 +-
 fs/gfs2/aops.c          |  2 +-
 fs/hostfs/hostfs_kern.c |  2 +-
 fs/jfs/jfs_metapage.c   |  2 +-
 fs/nfs/file.c           |  2 +-
 fs/ntfs/aops.c          |  4 +---
 fs/orangefs/inode.c     |  2 +-
 fs/vboxsf/file.c        |  2 +-
 fs/xfs/xfs_aops.c       |  2 +-
 fs/zonefs/super.c       |  2 +-
 12 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9046c14f76af..0b2150f97a95 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10077,11 +10077,6 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
-static int btrfs_set_page_dirty(struct page *page)
-{
-	return __set_page_dirty_nobuffers(page);
-}
-
 static int btrfs_permission(struct user_namespace *mnt_userns,
 			    struct inode *inode, int mask)
 {
@@ -10644,7 +10639,7 @@ static const struct address_space_operations btrfs_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= btrfs_migratepage,
 #endif
-	.set_page_dirty	= btrfs_set_page_dirty,
+	.dirty_folio	= filemap_dirty_folio,
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate	= btrfs_swap_activate,
 	.swap_deactivate = btrfs_swap_deactivate,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 678ba122f8b1..c48dbbf0e9b2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3541,22 +3541,23 @@ const struct iomap_ops ext4_iomap_report_ops = {
 };
 
 /*
- * Pages can be marked dirty completely asynchronously from ext4's journalling
- * activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.  We cannot do
- * much here because ->set_page_dirty is called under VFS locks.  The page is
- * not necessarily locked.
+ * Folios can be marked dirty completely asynchronously from ext4's
+ * journalling activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.
+ * We cannot do much here because ->dirty_folio may be called with the
+ * page table lock held.  The folio is not necessarily locked.
  *
- * We cannot just dirty the page and leave attached buffers clean, because the
+ * We cannot just dirty the folio and leave attached buffers clean, because the
  * buffers' dirty state is "definitive".  We cannot just set the buffers dirty
  * or jbddirty because all the journalling code will explode.
  *
- * So what we do is to mark the page "pending dirty" and next time writepage
+ * So what we do is to mark the folio "pending dirty" and next time writepage
  * is called, propagate that into the buffers appropriately.
  */
-static int ext4_journalled_set_page_dirty(struct page *page)
+static bool ext4_journalled_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	SetPageChecked(page);
-	return __set_page_dirty_nobuffers(page);
+	folio_set_checked(folio);
+	return filemap_dirty_folio(mapping, folio);
 }
 
 static int ext4_set_page_dirty(struct page *page)
@@ -3598,7 +3599,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
 	.write_end		= ext4_journalled_write_end,
-	.set_page_dirty		= ext4_journalled_set_page_dirty,
+	.dirty_folio		= ext4_journalled_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.releasepage		= ext4_releasepage,
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index aed0d5dcd022..48062c2506bd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3162,7 +3162,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.writepage	= fuse_writepage,
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
-	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.dirty_folio	= filemap_dirty_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
 	.write_begin	= fuse_write_begin,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 119cb38d99a7..7c096a75d703 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -780,7 +780,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
 	.readahead = gfs2_readahead,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.dirty_folio = filemap_dirty_folio,
 	.releasepage = iomap_releasepage,
 	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index ef481c3d9019..a6b19794bc11 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -504,7 +504,7 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 static const struct address_space_operations hostfs_aops = {
 	.writepage 	= hostfs_writepage,
 	.readpage	= hostfs_readpage,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.dirty_folio	= filemap_dirty_folio,
 	.write_begin	= hostfs_write_begin,
 	.write_end	= hostfs_write_end,
 };
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index d856aee3eec3..4e9fd49e1b90 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -570,7 +570,7 @@ const struct address_space_operations jfs_metapage_aops = {
 	.writepage	= metapage_writepage,
 	.releasepage	= metapage_releasepage,
 	.invalidate_folio = metapage_invalidate_folio,
-	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.dirty_folio	= filemap_dirty_folio,
 };
 
 struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ce4fa598ddfa..b747e3d4c354 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -515,7 +515,7 @@ static void nfs_swap_deactivate(struct file *file)
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readahead = nfs_readahead,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.dirty_folio = filemap_dirty_folio,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.write_begin = nfs_write_begin,
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 6858bf6df49a..dd71f6ac0272 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1684,9 +1684,7 @@ const struct address_space_operations ntfs_mst_aops = {
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
-	.set_page_dirty	= __set_page_dirty_nobuffers,	/* Set the page dirty
-						   without touching the buffers
-						   belonging to the page. */
+	.dirty_folio	= filemap_dirty_folio,
 #endif /* NTFS_RW */
 	.migratepage	= buffer_migrate_page,
 	.is_partially_uptodate	= block_is_partially_uptodate,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 8a9bbbbdf406..79c1025d18ea 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -634,7 +634,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.readahead = orangefs_readahead,
 	.readpage = orangefs_readpage,
 	.writepages = orangefs_writepages,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.dirty_folio = filemap_dirty_folio,
 	.write_begin = orangefs_write_begin,
 	.write_end = orangefs_write_end,
 	.invalidate_folio = orangefs_invalidate_folio,
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 864c2fad23be..d74e0d336995 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -354,7 +354,7 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations vboxsf_reg_aops = {
 	.readpage = vboxsf_readpage,
 	.writepage = vboxsf_writepage,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.dirty_folio = filemap_dirty_folio,
 	.write_begin = simple_write_begin,
 	.write_end = vboxsf_write_end,
 };
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 7dd314f2288f..37b03675b8c3 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -567,7 +567,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.readpage		= xfs_vm_readpage,
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
-	.set_page_dirty		= __set_page_dirty_nobuffers,
+	.dirty_folio		= filemap_dirty_folio,
 	.releasepage		= iomap_releasepage,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 887b39553eb4..360db85afd85 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -185,7 +185,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.readahead		= zonefs_readahead,
 	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
-	.set_page_dirty		= __set_page_dirty_nobuffers,
+	.dirty_folio		= filemap_dirty_folio,
 	.releasepage		= iomap_releasepage,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migratepage		= iomap_migrate_page,
-- 
2.34.1

