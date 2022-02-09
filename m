Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD224AFE5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiBIUXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688CE040DC8
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nSlOmbyLhv3GLKCV9QiFGhCK9bac1XRaB3F5sqOZK6g=; b=kPhSzWVlRtdROFvLcRuaVWc/1C
        tj8R2extCS+riZWJNGxnSKFoUtdLa0UqfsVxrrK9N8I/YvYXYerDpfjKHmBi+nVsUtJ/SiFjRGUvN
        YAZcfbvMXsFgPEp1NBPJBTAdZonq9hS94YD6KZybjIXb8x3DWYW8SNA8U46SnAQmsfEGIaEss/Sl2
        RJmaOnCIIAr8wRJ4fitdmApadK1Xxb4wtnUyAcLB/ngg+pIpk/eKAJLyHrgEFYFfqBIEQvdpw6Gdg
        RhwUonkB3PriwjoW0yibyjF/6ydaWZNxm+70NVffa50+ua8m7ULBrs+wJocQlMVtWD93UZyX0NHQ3
        wxOvIXKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008ctm-G6; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 54/56] fs: Convert __set_page_dirty_no_writeback to noop_dirty_folio
Date:   Wed,  9 Feb 2022 20:22:13 +0000
Message-Id: <20220209202215.2055748-55-willy@infradead.org>
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

This is a mechanical change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/dax/device.c    |  2 +-
 fs/aio.c                |  2 +-
 fs/ext2/inode.c         |  2 +-
 fs/ext4/inode.c         |  2 +-
 fs/fuse/dax.c           |  2 +-
 fs/hugetlbfs/inode.c    |  2 +-
 fs/libfs.c              |  4 ++--
 fs/xfs/xfs_aops.c       |  2 +-
 include/linux/pagemap.h |  2 +-
 mm/page-writeback.c     | 10 +++++-----
 mm/page_io.c            |  2 +-
 mm/secretmem.c          |  2 +-
 mm/shmem.c              |  2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 7a59ca51217e..5494d745ced5 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -346,7 +346,7 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 }
 
 static const struct address_space_operations dev_dax_aops = {
-	.set_page_dirty		= __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 };
 
 static int dax_open(struct inode *inode, struct file *filp)
diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13a7db0..d6b7160c2a77 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -478,7 +478,7 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 #endif
 
 static const struct address_space_operations aio_ctx_aops = {
-	.set_page_dirty = __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 #if IS_ENABLED(CONFIG_MIGRATION)
 	.migratepage	= aio_migratepage,
 #endif
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index d9452a051198..52377a0ee735 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1000,7 +1000,7 @@ const struct address_space_operations ext2_nobh_aops = {
 static const struct address_space_operations ext2_dax_aops = {
 	.writepages		= ext2_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= __set_page_dirty_no_writeback,
+	.dirty_folio		= noop_dirty_folio,
 };
 
 /*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c34104a94f0..436efd31cc27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3630,7 +3630,7 @@ static const struct address_space_operations ext4_da_aops = {
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= __set_page_dirty_no_writeback,
+	.dirty_folio		= noop_dirty_folio,
 	.bmap			= ext4_bmap,
 	.swap_activate		= ext4_iomap_swap_activate,
 };
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index b11fa10b88d8..d7d3a7f06862 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1326,7 +1326,7 @@ bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi)
 static const struct address_space_operations fuse_dax_file_aops  = {
 	.writepages	= fuse_dax_writepages,
 	.direct_IO	= noop_direct_IO,
-	.set_page_dirty	= __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 };
 
 static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a7c6c7498be0..f544f622598d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1144,7 +1144,7 @@ static void hugetlbfs_destroy_inode(struct inode *inode)
 static const struct address_space_operations hugetlbfs_aops = {
 	.write_begin	= hugetlbfs_write_begin,
 	.write_end	= hugetlbfs_write_end,
-	.set_page_dirty	=  __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 	.migratepage    = hugetlbfs_migrate_page,
 	.error_remove_page	= hugetlbfs_error_remove_page,
 };
diff --git a/fs/libfs.c b/fs/libfs.c
index 4e047841e61d..e64bdedef168 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -631,7 +631,7 @@ const struct address_space_operations ram_aops = {
 	.readpage	= simple_readpage,
 	.write_begin	= simple_write_begin,
 	.write_end	= simple_write_end,
-	.set_page_dirty	= __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 };
 EXPORT_SYMBOL(ram_aops);
 
@@ -1220,7 +1220,7 @@ EXPORT_SYMBOL(kfree_link);
 struct inode *alloc_anon_inode(struct super_block *s)
 {
 	static const struct address_space_operations anon_aops = {
-		.set_page_dirty = __set_page_dirty_no_writeback,
+		.dirty_folio	= noop_dirty_folio,
 	};
 	struct inode *inode = new_inode_pseudo(s);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 37b03675b8c3..90b7f4d127de 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -581,6 +581,6 @@ const struct address_space_operations xfs_address_space_operations = {
 const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
 	.direct_IO		= noop_direct_IO,
-	.set_page_dirty		= __set_page_dirty_no_writeback,
+	.dirty_folio		= noop_dirty_folio,
 	.swap_activate		= xfs_iomap_swapfile_activate,
 };
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7cd0c01fe533..9cd504542c31 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -917,7 +917,7 @@ static inline int __must_check write_one_page(struct page *page)
 }
 
 int __set_page_dirty_nobuffers(struct page *page);
-int __set_page_dirty_no_writeback(struct page *page);
+bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e890db239fae..4557a8d3dfea 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2430,13 +2430,13 @@ EXPORT_SYMBOL(folio_write_one);
 /*
  * For address_spaces which do not use buffers nor write back.
  */
-int __set_page_dirty_no_writeback(struct page *page)
+bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	if (!PageDirty(page))
-		return !TestSetPageDirty(page);
-	return 0;
+	if (!folio_test_dirty(folio))
+		return !folio_test_set_dirty(folio);
+	return false;
 }
-EXPORT_SYMBOL(__set_page_dirty_no_writeback);
+EXPORT_SYMBOL(noop_dirty_folio);
 
 /*
  * Helper function for set_page_dirty family.
diff --git a/mm/page_io.c b/mm/page_io.c
index 8f20f4dad289..e3333973335e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -453,6 +453,6 @@ bool swap_dirty_folio(struct address_space *mapping, struct folio *folio)
 			return aops->dirty_folio(mapping, folio);
 		return aops->set_page_dirty(&folio->page);
 	} else {
-		return __set_page_dirty_no_writeback(&folio->page);
+		return noop_dirty_folio(mapping, folio);
 	}
 }
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 22b310adb53d..098638d3b8a4 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -152,7 +152,7 @@ static void secretmem_freepage(struct page *page)
 }
 
 const struct address_space_operations secretmem_aops = {
-	.set_page_dirty	= __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 	.freepage	= secretmem_freepage,
 	.migratepage	= secretmem_migratepage,
 	.isolate_page	= secretmem_isolate_page,
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..5944159bc43e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3753,7 +3753,7 @@ static int shmem_error_remove_page(struct address_space *mapping,
 
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
-	.set_page_dirty	= __set_page_dirty_no_writeback,
+	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
 	.write_begin	= shmem_write_begin,
 	.write_end	= shmem_write_end,
-- 
2.34.1

