Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C951F18F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiEHUhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiEHUgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354411C07
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uG6QVxqrPlR4Z4BOCaAKEGFzoV4/j5qZjuxmrlfYktQ=; b=D0bgsilrkcZj45pMrhBOb4rRu8
        Rj2V8sjNLxivq4IuwjTRscKADTGYngJH5XL3+JSuy5IinY9zSezHhhNG4Oooc3SKysynZI7bOKtvc
        osl3mGgGD096YyONWyDOY+jYcGOLrACGiN2tSeujW1bocJLlYt2kGWjGLCkmvg1JBcwEJ1zSDzyL/
        2hASZs4CbXbGZqRwKy3cAJuqdptFw861V6y0NXhp1AVl7d6R0d4u2Yo9QxIRrniRBMq34MKWH9Rjd
        rPoAf6UmZcc5MZYoKXspIZK8FV7XpFEjEpRrz73Qb+kVpsphkSH1ouFRGxncdaIzlR+auT/shAKib
        Uu3mN3cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o11-9K; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/26] afs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:25 +0100
Message-Id: <20220508203247.668791-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

A straightforward conversion as they already work in terms of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/dir.c      |  7 +++----
 fs/afs/file.c     | 11 +++++------
 fs/afs/internal.h |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 932e61e28e5d..94aa7356248e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -41,7 +41,7 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags);
-static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
+static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags);
 static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
 				   size_t length);
 
@@ -75,7 +75,7 @@ const struct inode_operations afs_dir_inode_operations = {
 
 const struct address_space_operations afs_dir_aops = {
 	.dirty_folio	= afs_dir_dirty_folio,
-	.releasepage	= afs_dir_releasepage,
+	.release_folio	= afs_dir_release_folio,
 	.invalidate_folio = afs_dir_invalidate_folio,
 };
 
@@ -2002,9 +2002,8 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
  * Release a directory folio and clean up its private state if it's not busy
  * - return true if the folio can now be released, false if not
  */
-static int afs_dir_releasepage(struct page *subpage, gfp_t gfp_flags)
+static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	struct folio *folio = page_folio(subpage);
 	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
 
 	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio_index(folio));
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 65ef69a1f78e..a8e8832179e4 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -22,7 +22,7 @@ static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 static int afs_symlink_read_folio(struct file *file, struct folio *folio);
 static void afs_invalidate_folio(struct folio *folio, size_t offset,
 			       size_t length);
-static int afs_releasepage(struct page *page, gfp_t gfp_flags);
+static bool afs_release_folio(struct folio *folio, gfp_t gfp_flags);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 static void afs_vm_open(struct vm_area_struct *area);
@@ -54,7 +54,7 @@ const struct address_space_operations afs_file_aops = {
 	.readahead	= netfs_readahead,
 	.dirty_folio	= afs_dirty_folio,
 	.launder_folio	= afs_launder_folio,
-	.releasepage	= afs_releasepage,
+	.release_folio	= afs_release_folio,
 	.invalidate_folio = afs_invalidate_folio,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
@@ -64,7 +64,7 @@ const struct address_space_operations afs_file_aops = {
 
 const struct address_space_operations afs_symlink_aops = {
 	.read_folio	= afs_symlink_read_folio,
-	.releasepage	= afs_releasepage,
+	.release_folio	= afs_release_folio,
 	.invalidate_folio = afs_invalidate_folio,
 };
 
@@ -481,16 +481,15 @@ static void afs_invalidate_folio(struct folio *folio, size_t offset,
  * release a page and clean up its private state if it's not busy
  * - return true if the page can now be released, false if not
  */
-static int afs_releasepage(struct page *page, gfp_t gfp)
+static bool afs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct folio *folio = page_folio(page);
 	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
 
 	_enter("{{%llx:%llu}[%lu],%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio), folio->flags,
 	       gfp);
 
-	/* deny if page is being written to the cache and the caller hasn't
+	/* deny if folio is being written to the cache and the caller hasn't
 	 * elected to wait */
 #ifdef CONFIG_AFS_FSCACHE
 	if (folio_test_fscache(folio)) {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7a72e9c60423..a30995901266 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -311,7 +311,7 @@ struct afs_net {
 	atomic_t		n_lookup;	/* Number of lookups done */
 	atomic_t		n_reval;	/* Number of dentries needing revalidation */
 	atomic_t		n_inval;	/* Number of invalidations by the server */
-	atomic_t		n_relpg;	/* Number of invalidations by releasepage */
+	atomic_t		n_relpg;	/* Number of invalidations by release_folio */
 	atomic_t		n_read_dir;	/* Number of directory pages read */
 	atomic_t		n_dir_cr;	/* Number of directory entry creation edits */
 	atomic_t		n_dir_rm;	/* Number of directory entry removal edits */
-- 
2.34.1

