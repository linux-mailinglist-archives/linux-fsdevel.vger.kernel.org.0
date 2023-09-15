Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140657A24E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjIORfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjIORfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575A2119;
        Fri, 15 Sep 2023 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zr43CSw65EnjfQ3u7TtafvX2UuJW5qLawwZhg5XAazA=; b=pMQrDHnnrPY6z+D04I0GnD8daK
        wgzW/Go3oREj/4XZ7t15I7DgC9cM0q5UKY1h2V8sby2aAJJHVPWv6NzzFWgnAxeUBo7KwJNXFKaAi
        G8DTWTuhJOY1zf4s28WvH4+SDBzWNn0+0dSZr0W4pHUtI9azu2tA7PMD7snUP4GbcwRZB0Xjpzqco
        yrFRpocG3gJMcjK+VLP31N+/saoIyv/pQqn4t4iCPsowtWnKsE9ongWMyH9YIvtEvXtDm+25ZQluP
        ARErEUHuUC/UkcJqHA6kr660NApAtpymVRjjen+A5ln8XV7fCDzLUWWTiDQwSv0wtrdvlbtseRJ9/
        6JVXwhRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhChE-00B5ZE-Bp; Fri, 15 Sep 2023 17:33:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nfs: Convert nfs_symlink() to use a folio
Date:   Fri, 15 Sep 2023 18:33:33 +0100
Message-Id: <20230915173333.2642994-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the folio APIs, saving about four calls to compound_head().
Convert back to a page in each of the individual protocol implementations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/dir.c            | 29 ++++++++++++-----------------
 fs/nfs/nfs3proc.c       |  3 ++-
 fs/nfs/nfs4proc.c       |  7 ++++---
 fs/nfs/proc.c           |  3 ++-
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e6a51fd94fea..13dffe4201e6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2532,7 +2532,7 @@ EXPORT_SYMBOL_GPL(nfs_unlink);
 int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *symname)
 {
-	struct page *page;
+	struct folio *folio;
 	char *kaddr;
 	struct iattr attr;
 	unsigned int pathlen = strlen(symname);
@@ -2547,24 +2547,24 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	attr.ia_mode = S_IFLNK | S_IRWXUGO;
 	attr.ia_valid = ATTR_MODE;
 
-	page = alloc_page(GFP_USER);
-	if (!page)
+	folio = folio_alloc(GFP_USER, 0);
+	if (!folio)
 		return -ENOMEM;
 
-	kaddr = page_address(page);
+	kaddr = folio_address(folio);
 	memcpy(kaddr, symname, pathlen);
 	if (pathlen < PAGE_SIZE)
 		memset(kaddr + pathlen, 0, PAGE_SIZE - pathlen);
 
 	trace_nfs_symlink_enter(dir, dentry);
-	error = NFS_PROTO(dir)->symlink(dir, dentry, page, pathlen, &attr);
+	error = NFS_PROTO(dir)->symlink(dir, dentry, folio, pathlen, &attr);
 	trace_nfs_symlink_exit(dir, dentry, error);
 	if (error != 0) {
 		dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s) error %d\n",
 			dir->i_sb->s_id, dir->i_ino,
 			dentry, symname, error);
 		d_drop(dentry);
-		__free_page(page);
+		folio_put(folio);
 		return error;
 	}
 
@@ -2574,18 +2574,13 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 * No big deal if we can't add this page to the page cache here.
 	 * READLINK will get the missing page from the server if needed.
 	 */
-	if (!add_to_page_cache_lru(page, d_inode(dentry)->i_mapping, 0,
-							GFP_KERNEL)) {
-		SetPageUptodate(page);
-		unlock_page(page);
-		/*
-		 * add_to_page_cache_lru() grabs an extra page refcount.
-		 * Drop it here to avoid leaking this page later.
-		 */
-		put_page(page);
-	} else
-		__free_page(page);
+	if (filemap_add_folio(d_inode(dentry)->i_mapping, folio, 0,
+							GFP_KERNEL) == 0) {
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+	}
 
+	folio_put(folio);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_symlink);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 4bf208a0a8e9..2de66e4e8280 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -543,9 +543,10 @@ nfs3_proc_link(struct inode *inode, struct inode *dir, const struct qstr *name)
 }
 
 static int
-nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
+nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct folio *folio,
 		  unsigned int len, struct iattr *sattr)
 {
+	struct page *page = &folio->page;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 794343790ea8..3f449e40b178 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5007,9 +5007,10 @@ static void nfs4_free_createdata(struct nfs4_createdata *data)
 }
 
 static int _nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
-		struct page *page, unsigned int len, struct iattr *sattr,
+		struct folio *folio, unsigned int len, struct iattr *sattr,
 		struct nfs4_label *label)
 {
+	struct page *page = &folio->page;
 	struct nfs4_createdata *data;
 	int status = -ENAMETOOLONG;
 
@@ -5034,7 +5035,7 @@ static int _nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 static int nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
-		struct page *page, unsigned int len, struct iattr *sattr)
+		struct folio *folio, unsigned int len, struct iattr *sattr)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
@@ -5045,7 +5046,7 @@ static int nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 	label = nfs4_label_init_security(dir, dentry, sattr, &l);
 
 	do {
-		err = _nfs4_proc_symlink(dir, dentry, page, len, sattr, label);
+		err = _nfs4_proc_symlink(dir, dentry, folio, len, sattr, label);
 		trace_nfs4_symlink(dir, &dentry->d_name, err);
 		err = nfs4_handle_exception(NFS_SERVER(dir), err,
 				&exception);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index e3570c656b0f..ad3a321ae997 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -396,9 +396,10 @@ nfs_proc_link(struct inode *inode, struct inode *dir, const struct qstr *name)
 }
 
 static int
-nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
+nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct folio *folio,
 		 unsigned int len, struct iattr *sattr)
 {
+	struct page *page = &folio->page;
 	struct nfs_fh *fh;
 	struct nfs_fattr *fattr;
 	struct nfs_symlinkargs	arg = {
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12bbb5c63664..539b57fbf3ce 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1772,7 +1772,7 @@ struct nfs_rpc_ops {
 	void	(*rename_rpc_prepare)(struct rpc_task *task, struct nfs_renamedata *);
 	int	(*rename_done) (struct rpc_task *task, struct inode *old_dir, struct inode *new_dir);
 	int	(*link)    (struct inode *, struct inode *, const struct qstr *);
-	int	(*symlink) (struct inode *, struct dentry *, struct page *,
+	int	(*symlink) (struct inode *, struct dentry *, struct folio *,
 			    unsigned int, struct iattr *);
 	int	(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
 	int	(*rmdir)   (struct inode *, const struct qstr *);
-- 
2.40.1

