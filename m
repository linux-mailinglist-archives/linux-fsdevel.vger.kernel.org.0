Return-Path: <linux-fsdevel+bounces-55683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F06B0DA4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134FB3B9B49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823122EA15B;
	Tue, 22 Jul 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAvRkcKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E12E9753;
	Tue, 22 Jul 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189106; cv=none; b=CIjsQVxwHPFocve2mtsMng3WcNFoLC1rpVPr2iWQWC1Nk0SbASksGGqWi/ia61o8Vsh+JuFt+3A8Jwb8l+UztuZHOT00z94R9uRdqHI063DUqG+LA8AUbEto4VlWaUDr/nbZTKEnDJ4gnr1iz/4f/0/oX76abA4Vgw4oki/up5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189106; c=relaxed/simple;
	bh=0koc/G19kYt4+44exWmQEtBUv0evHA3NBQHONq1gV0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsFLLvgh7HI9eWf3cSTEDj432OASbioAdMtKsxE4tvYL02qBcyXgWsX5DtFm50m6k2jxic21eQKXj27NFwH/mC/6qCkWZ9yMe8L7CphNLBflA42TONIPB8nYeD6GmahEAypmA9N+oSrNWJ26/HHUftRx6EASwdnmae7k6oDKJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAvRkcKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C49C4AF09;
	Tue, 22 Jul 2025 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189105;
	bh=0koc/G19kYt4+44exWmQEtBUv0evHA3NBQHONq1gV0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAvRkcKazz4lW1QM18B/BmDpYvnzIdC8yDG6zECmUCZCI+QxzXsE+JeRgRC1RJ0Ph
	 hMFRiuae9XNdAPs1H0iCCHa7yZwjQpUMcWLfsvHXCD3adt+JshahMG3wHypfDCsy9R
	 PCtwXTz0+bVmEjMEFoip+wmcn1J9f6EBQkdeEsIiiDUZe4Czwhjaz90jzDbVPfosQN
	 VuCeqioqA54NDw1rAEi9bZDo67jpVWSBmyFVOUUPFFPFTUkOnpIuMymkX9buoeuGxY
	 A8LjwF4hKdcZJrcswLix9omhIe5DJrOXxSPoqgYjR9Nhn23c0W1C83IutLcR4ZaI3A
	 YurP6WWmkfc4w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 13/13] fs: drop i_verity_info from struct inode
Date: Tue, 22 Jul 2025 14:57:19 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-13-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=6714; i=brauner@kernel.org; h=from:subject:message-id; bh=0koc/G19kYt4+44exWmQEtBUv0evHA3NBQHONq1gV0M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd22uFmYLbZOqczNI7kngPZJVnpemwlO+Y8GP+mnX1 2ROD8zoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMiDZkaGo5eXyH+/umLFcZsF cdI+otLJKWe71m/jkK53+1vrFturx/A/r9BV7r7dpaPXXFIM3GZ/tMnYWr1XQIzlcBjbFq7rs56 xAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that all filesystems store the fsverity data pointer in their
private inode, drop the data pointer from struct inode itself freeing up
8 bytes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/verity/enable.c           |  2 +-
 fs/verity/fsverity_private.h |  2 +-
 fs/verity/open.c             | 18 +++++-------------
 include/linux/fs.h           |  4 ----
 include/linux/fsverity.h     | 14 +++++++-------
 5 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..255cf73f6c03 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -287,7 +287,7 @@ static int enable_verity(struct file *filp,
 		/* Successfully enabled verity */
 
 		/*
-		 * Readers can start using ->i_verity_info immediately, so it
+		 * Readers can start using ->i_fsverity_info immediately, so it
 		 * can't be rolled back once set.  So don't set it until just
 		 * after the filesystem has successfully enabled verity.
 		 */
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..358cbc3aa7ea 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -58,7 +58,7 @@ struct merkle_tree_params {
  * fsverity_info - cached verity metadata for an inode
  *
  * When a verity file is first opened, an instance of this struct is allocated
- * and stored in ->i_verity_info; it remains until the inode is evicted.  It
+ * and stored in ->i_fsverity_info; it remains until the inode is evicted.  It
  * caches information about the Merkle tree that's needed to efficiently verify
  * data read from the file.  It also caches the file digest.  The Merkle tree
  * pages themselves are not cached here, but the filesystem may cache them.
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 2b9da08754f3..e7b6d658b0dc 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -250,24 +250,18 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 {
-	void *p;
-
 	/*
-	 * Multiple tasks may race to set ->i_verity_info, so use
+	 * Multiple tasks may race to set ->i_fsverity_info, so use
 	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fsverity_get_info().  I.e., here we publish ->i_verity_info with a
+	 * fsverity_get_info().  I.e., here we publish ->i_fsverity_info with a
 	 * RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
 
-	if (inode->i_op->i_fsverity)
-		p = cmpxchg_release(fsverity_addr(inode), NULL, vi);
-	else
-		p = cmpxchg_release(&inode->i_verity_info, NULL, vi);
-	if (p != NULL) {
+	if (cmpxchg_release(fsverity_addr(inode), NULL, vi) != NULL) {
 		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
 		/*
-		 * Afterwards, the caller may access ->i_verity_info directly,
+		 * Afterwards, the caller may access ->i_fsverity_info directly,
 		 * so make sure to ACQUIRE the winning fsverity_info.
 		 */
 		(void)fsverity_get_info(inode);
@@ -364,7 +358,7 @@ int fsverity_get_descriptor(struct inode *inode,
 	return 0;
 }
 
-/* Ensure the inode has an ->i_verity_info */
+/* Ensure the inode has an ->i_fsverity_info */
 static int ensure_verity_info(struct inode *inode)
 {
 	struct fsverity_info *vi = fsverity_get_info(inode);
@@ -412,8 +406,6 @@ void __fsverity_cleanup_inode(struct inode *inode)
 	struct fsverity_info **vi;
 
 	vi = fsverity_addr(inode);
-	if (!*vi)
-		vi = &inode->i_verity_info;
 	fsverity_free_info(*vi);
 	*vi = NULL;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b933b8d75f50..027f760f306a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -778,10 +778,6 @@ struct inode {
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info	*i_verity_info;
-#endif
-
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 3f15d22c03d6..9815158517dc 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -133,13 +133,13 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
 	/*
 	 * Pairs with the cmpxchg_release() in fsverity_set_info().
-	 * I.e., another task may publish ->i_verity_info concurrently,
+	 * I.e., another task may publish ->i_fsverity_info concurrently,
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
 	if (inode->i_op->i_fsverity)
 		return smp_load_acquire(fsverity_addr(inode));
-	return smp_load_acquire(&inode->i_verity_info);
+	return NULL;
 }
 
 /* enable.c */
@@ -163,11 +163,11 @@ void __fsverity_cleanup_inode(struct inode *inode);
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted
  *
- * Filesystems must call this on inode eviction to free ->i_verity_info.
+ * Filesystems must call this on inode eviction to free ->i_fsverity_info.
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (inode->i_verity_info || inode->i_op->i_fsverity)
+	if (inode->i_op->i_fsverity)
 		__fsverity_cleanup_inode(inode);
 }
 
@@ -274,12 +274,12 @@ static inline bool fsverity_verify_page(struct page *page)
  * fsverity_active() - do reads from the inode need to go through fs-verity?
  * @inode: inode to check
  *
- * This checks whether ->i_verity_info has been set.
+ * This checks whether ->i_fsverity_info has been set.
  *
  * Filesystems call this from ->readahead() to check whether the pages need to
  * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
  * a race condition where the file is being read concurrently with
- * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before ->i_verity_info.)
+ * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before ->i_fsverity_info.)
  *
  * Return: true if reads need to go through fs-verity, otherwise false
  */
@@ -294,7 +294,7 @@ static inline bool fsverity_active(const struct inode *inode)
  * @filp: the struct file being set up
  *
  * When opening a verity file, deny the open if it is for writing.  Otherwise,
- * set up the inode's ->i_verity_info if not already done.
+ * set up the inode's ->i_fsverity_info if not already done.
  *
  * When combined with fscrypt, this must be called after fscrypt_file_open().
  * Otherwise, we won't have the key set up to decrypt the verity metadata.

-- 
2.47.2


