Return-Path: <linux-fsdevel+bounces-55677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83682B0DA4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C77170875
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF982E9EB8;
	Tue, 22 Jul 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECWQ4pU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451332E92C7;
	Tue, 22 Jul 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189088; cv=none; b=dwZskfezR739qtx5FTEQS0JAZ2CPWBOFmqk5/2nH2baeQTWsA+mngj8AKoRlkteIVQjIiRliALurfrJHfWFCBZdnOfF0c/BkHEMWqXDccApn3AS/X80Eqru7aWYpAmOW4FwHX7SOgjBhhjVWI8/7qxKxvb5OQgiCC/0MhbcY8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189088; c=relaxed/simple;
	bh=aYhMOolYt9XWJu5DvK/YO7Uq2LcpIMn8D444qlrjdlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sADMZhYBIVDM8CBAyhFcgrLfFDHIJ0jKS7Z1zIc152Xuk6cPUTsi5IxVZf5f6wJlhACh0vM47hooZYyYi3pA+utsmXiRJjMYX5iUYcE+Dbz3vBYdiZkQb3QO61jU2mwoIwU87N7ISNFCJm0WpFHOrZV+EJy56JNT78X4AVj9+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECWQ4pU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EE9C4CEEB;
	Tue, 22 Jul 2025 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189087;
	bh=aYhMOolYt9XWJu5DvK/YO7Uq2LcpIMn8D444qlrjdlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECWQ4pU4yt1DxOwrRrgFgSvRlShg5YXbu871a5TefEC9Tuy04xmFO1wExrYj6Ridt
	 LCL0ITtyRdIhGh9+eQnFMdUYQtFLte7g0s/roiGKkr8ERuLCSIh6Z9drp3dYtuqXXN
	 Zf9GiC5W/TsPvuLw6r8h4PqBmtGbUSUYuRclyUlCrzoB16N/40s80MUU1+fF8rbtkv
	 9dDy6PpMSLYCLWj18Go45qmFRvUKmz5JsOplyMnyzLcb72sN7rqjPuLfMwLiMcfLWp
	 RWyXWkLccxNtKRY3ZDezY6+bc4YkMEpuD9nxornn2zDVM6hnbcqCyLTkaqfOmHAy96
	 7tbXWQYoMNG6A==
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
Subject: [PATCH RFC DRAFT v2 07/13] fs: drop i_crypt_info from struct inode
Date: Tue, 22 Jul 2025 14:57:13 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-7-782f1fdeaeba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6578; i=brauner@kernel.org; h=from:subject:message-id; bh=aYhMOolYt9XWJu5DvK/YO7Uq2LcpIMn8D444qlrjdlU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd2366fJxftOmuArnNfl7bO788tx5fIXcj2L//RPv5 KXkBh5T7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/O0M/1S4D/le3ny28WQ3 y3Tfxbfdzxivnyz8fIHQvdOfH83t3b6HkeHu7bXHdrUuPzkx3lv+x2tzQ8NOe6tVEX3W2dyKWZl KF9gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that all filesystems store the fscrypt data pointer in their private
inode, drop the data pointer from struct inode itself freeing up 8
bytes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/crypto/fscrypt_private.h |  2 +-
 fs/crypto/keysetup.c        | 25 ++++++++++++-------------
 include/linux/fs.h          |  4 ----
 include/linux/fscrypt.h     | 21 ++++++---------------
 4 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index c1d92074b65c..53a72dc909d9 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -231,7 +231,7 @@ struct fscrypt_prepared_key {
  * fscrypt_inode_info - the "encryption key" for an inode
  *
  * When an encrypted file's key is made available, an instance of this struct is
- * allocated and stored in ->i_crypt_info.  Once created, it remains until the
+ * allocated and stored in ->i_fscrypt_info.  Once created, it remains until the
  * inode is evicted.
  */
 struct fscrypt_inode_info {
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 76a5c7aafd89..e520712431f6 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -639,14 +639,14 @@ fscrypt_setup_encryption_info(struct inode *inode,
 		goto out;
 
 	/*
-	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
+	 * For existing inodes, multiple tasks may race to set ->i_fscrypt_info.
 	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
+	 * fscrypt_get_inode_info().  I.e., here we publish ->i_fscrypt_info with
 	 * a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
 	if (fscrypt_set_inode_info(inode, crypt_info)) {
 		/*
-		 * We won the race and set ->i_crypt_info to our crypt_info.
+		 * We won the race and set ->i_fscrypt_info to our crypt_info.
 		 * Now link it into the master key's inode list.
 		 */
 		if (mk) {
@@ -678,12 +678,12 @@ fscrypt_setup_encryption_info(struct inode *inode,
  *		       %false unless the operation being performed is needed in
  *		       order for files (or directories) to be deleted.
  *
- * Set up ->i_crypt_info, if it hasn't already been done.
+ * Set up ->i_fscrypt_info, if it hasn't already been done.
  *
- * Note: unless ->i_crypt_info is already set, this isn't %GFP_NOFS-safe.  So
+ * Note: unless ->i_fscrypt_info is already set, this isn't %GFP_NOFS-safe.  So
  * generally this shouldn't be called from within a filesystem transaction.
  *
- * Return: 0 if ->i_crypt_info was set or was already set, *or* if the
+ * Return: 0 if ->i_fscrypt_info was set or was already set, *or* if the
  *	   encryption key is unavailable.  (Use fscrypt_has_encryption_key() to
  *	   distinguish these cases.)  Also can return another -errno code.
  */
@@ -738,9 +738,9 @@ int fscrypt_get_encryption_info(struct inode *inode, bool allow_unsupported)
  *	   ->i_ino doesn't need to be set yet.
  * @encrypt_ret: (output) set to %true if the new inode will be encrypted
  *
- * If the directory is encrypted, set up its ->i_crypt_info in preparation for
+ * If the directory is encrypted, set up its ->i_fscrypt_info in preparation for
  * encrypting the name of the new file.  Also, if the new inode will be
- * encrypted, set up its ->i_crypt_info and set *encrypt_ret=true.
+ * encrypted, set up its ->i_fscrypt_info and set *encrypt_ret=true.
  *
  * This isn't %GFP_NOFS-safe, and therefore it should be called before starting
  * any filesystem transaction to create the inode.  For this reason, ->i_ino
@@ -799,12 +799,11 @@ void fscrypt_put_encryption_info(struct inode *inode)
 {
 	struct fscrypt_inode_info **crypt_info;
 
-	if (inode->i_op->i_fscrypt)
+	if (inode->i_op->i_fscrypt) {
 		crypt_info = fscrypt_addr(inode);
-	else
-		crypt_info = &inode->i_crypt_info;
-	put_crypt_info(*crypt_info);
-	*crypt_info = NULL;
+		put_crypt_info(*crypt_info);
+		*crypt_info = NULL;
+	}
 }
 EXPORT_SYMBOL(fscrypt_put_encryption_info);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82678b523720..ea5d3d3356c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -778,10 +778,6 @@ struct inode {
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_inode_info	*i_crypt_info;
-#endif
-
 #ifdef CONFIG_FS_VERITY
 	struct fsverity_info	*i_verity_info;
 #endif
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index fe48dfe171e4..fb9c8da4420f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -203,28 +203,20 @@ static inline struct fscrypt_inode_info **fscrypt_addr(const struct inode *inode
 static inline bool fscrypt_set_inode_info(struct inode *inode,
 					  struct fscrypt_inode_info *crypt_info)
 {
-	void *p;
-
 	/*
-	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
+	 * For existing inodes, multiple tasks may race to set ->i_fscrypt_info.
 	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
+	 * fscrypt_get_inode_info().  I.e., here we publish ->i_fscrypt_info with
 	 * a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
 
-	if (inode->i_op->i_fscrypt)
-		p = cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info);
-	else
-		p = cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info);
-	return p == NULL;
+	return cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info) == NULL;
 }
 
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info_raw(const struct inode *inode)
 {
-	if (inode->i_op->i_fscrypt)
-		return *fscrypt_addr(inode);
-	return inode->i_crypt_info;
+	return *fscrypt_addr(inode);
 }
 
 static inline struct fscrypt_inode_info *
@@ -232,15 +224,14 @@ fscrypt_get_inode_info(const struct inode *inode)
 {
 	/*
 	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
-	 * I.e., another task may publish ->i_crypt_info concurrently, executing
+	 * I.e., another task may publish ->i_fscrypt_info concurrently, executing
 	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
 	 * ACQUIRE the memory the other task published.
 	 */
 
 	if (inode->i_op->i_fscrypt)
 		return smp_load_acquire(fscrypt_addr(inode));
-
-	return smp_load_acquire(&inode->i_crypt_info);
+	return NULL;
 }
 
 /**

-- 
2.47.2


