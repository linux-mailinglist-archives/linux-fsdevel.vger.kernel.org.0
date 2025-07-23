Return-Path: <linux-fsdevel+bounces-55809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A374DB0F096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01F3542E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9F2DCF5B;
	Wed, 23 Jul 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIWz/2B2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012D254844;
	Wed, 23 Jul 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268308; cv=none; b=poG/RZadxkxVDVaqhyiwKjmAX3hCiwgMIizpxwJnKDYWGgGJLm+PhbMrP75yWsLNWwlzAVLRLER+Oh8lETztIXxT9pNaTjlNVH+w9rquUh206z/ezx0lfLHr5zJryIUS1/AAT7oq2oTdPSujKhBx9qz7nP+0yIu5DOJEZHB5VeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268308; c=relaxed/simple;
	bh=YMDDCw02zzDBbeEnRy7KoD9b8f8RiMt++a+EgD//YDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4kbjd5bBzB++lJ84fbj2DLHSwV8YqPLmrJjOb8BMTz+jYzMgXbg9aXcUBnZPCye0VvzMBTX4936sIjBbIv5SbrWkD+oZ6PZLLV0SZ7r7Y05uxGRH7ew9D7b+wClWSrJsCgVRteooMsiKECizUPtB8aesHZ0gx4f0TAV6alZFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIWz/2B2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7647BC4CEF6;
	Wed, 23 Jul 2025 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268308;
	bh=YMDDCw02zzDBbeEnRy7KoD9b8f8RiMt++a+EgD//YDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIWz/2B2+5szOhxaqAZZblSbevrfdAPxxj6sun1wkK5uuIAhPx0gzgMyWrxm0HJrs
	 WMaEDS0NYGwJxDIy9W5AuGYzQVAJbEFmWxMT5ErEjT8mlemympE4OJplK7o+JIo0hl
	 a0+D/x5Xx/EVNKtKnoZd90pIScM0QFw67jk4Qe2FytjWdfEjXk92oWEJMs6Vqk5Qt8
	 +gwun+KKb6QCA02IEvc9Z9YmHJiKHTSwbj0dSwDACMKWj9u65+O4U6v9xBu9u84+xY
	 t4ZSrFx1lQpcfZW5zGuai5kPDbdp8ycUjqs8KipH5jknaIdMDjQBiJYGBtXjiprKsJ
	 hLu2urFvMPfdw==
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
Subject: [PATCH v4 08/15] fscrypt: rephrase documentation and comments
Date: Wed, 23 Jul 2025 12:57:46 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-8-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=5946; i=brauner@kernel.org; h=from:subject:message-id; bh=YMDDCw02zzDBbeEnRy7KoD9b8f8RiMt++a+EgD//YDU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNDK31N8o3nD3eDLb+7rtoaKlfZb5qUyiBa8/51uc 2HPsuPlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPR6mD4X8w37ZOrmHyIdPTE UxMyTuWabTt/6fC2mBBGtiUct34bvGP4p2nVIz73uY7Zap3s5unT96mHXzGvMTirUR6nMfXYifx MTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we moved fscrypt out of struct inode update the comments to not
imply that it's still located in there.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/crypto/fscrypt_private.h |  4 ++--
 fs/crypto/keysetup.c        | 31 +++++++++++++++++--------------
 include/linux/fscrypt.h     | 16 +++++++++-------
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index c1d92074b65c..691009df5689 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -231,8 +231,8 @@ struct fscrypt_prepared_key {
  * fscrypt_inode_info - the "encryption key" for an inode
  *
  * When an encrypted file's key is made available, an instance of this struct is
- * allocated and stored in ->i_crypt_info.  Once created, it remains until the
- * inode is evicted.
+ * allocated and stored in the inode's fscrypt info.  Once created, it remains
+ * until the inode is evicted.
  */
 struct fscrypt_inode_info {
 
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 352d0cfda17d..86bf7724dd27 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -639,15 +639,16 @@ fscrypt_setup_encryption_info(struct inode *inode,
 		goto out;
 
 	/*
-	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
-	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
-	 * a RELEASE barrier so that other tasks can ACQUIRE it.
+	 * For existing inodes, multiple tasks may race to set the inode's
+	 * fscrypt info. So use cmpxchg_release().  This pairs with the
+	 * smp_load_acquire() in fscrypt_get_inode_info().  I.e., here we
+	 * publish the inode's fscrypt info with a RELEASE barrier so that
+	 * other tasks can ACQUIRE it.
 	 */
 	if (fscrypt_set_inode_info(inode, crypt_info)) {
 		/*
-		 * We won the race and set ->i_crypt_info to our crypt_info.
-		 * Now link it into the master key's inode list.
+		 * We won the race and set the inode's fscrypt info to our
+		 * crypt_info. Now link it into the master key's inode list.
 		 */
 		if (mk) {
 			crypt_info->ci_master_key = mk;
@@ -678,14 +679,16 @@ fscrypt_setup_encryption_info(struct inode *inode,
  *		       %false unless the operation being performed is needed in
  *		       order for files (or directories) to be deleted.
  *
- * Set up ->i_crypt_info, if it hasn't already been done.
+ * Set up the inode's fscrypt info, if it hasn't already been done.
  *
- * Note: unless ->i_crypt_info is already set, this isn't %GFP_NOFS-safe.  So
- * generally this shouldn't be called from within a filesystem transaction.
+ * Note: unless the inode's fscrypt info is already set, this isn't
+ * %GFP_NOFS-safe.  So generally this shouldn't be called from within a
+ * filesystem transaction.
  *
- * Return: 0 if ->i_crypt_info was set or was already set, *or* if the
- *	   encryption key is unavailable.  (Use fscrypt_has_encryption_key() to
- *	   distinguish these cases.)  Also can return another -errno code.
+ * Return: 0 if the inode's fscrypt info was set or was already set, *or* if
+ *         the encryption key is unavailable.  (Use
+ *         fscrypt_has_encryption_key() to distinguish these cases.)  Also can
+ *         return another -errno code.
  */
 int fscrypt_get_encryption_info(struct inode *inode, bool allow_unsupported)
 {
@@ -738,9 +741,9 @@ int fscrypt_get_encryption_info(struct inode *inode, bool allow_unsupported)
  *	   ->i_ino doesn't need to be set yet.
  * @encrypt_ret: (output) set to %true if the new inode will be encrypted
  *
- * If the directory is encrypted, set up its ->i_crypt_info in preparation for
+ * If the directory is encrypted, set up its fscrypt info in preparation for
  * encrypting the name of the new file.  Also, if the new inode will be
- * encrypted, set up its ->i_crypt_info and set *encrypt_ret=true.
+ * encrypted, set up its fscrypt info and set *encrypt_ret=true.
  *
  * This isn't %GFP_NOFS-safe, and therefore it should be called before starting
  * any filesystem transaction to create the inode.  For this reason, ->i_ino
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a62879456873..9a333fd6fe7a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -209,10 +209,11 @@ static inline bool fscrypt_set_inode_info(struct inode *inode,
 					  struct fscrypt_inode_info *crypt_info)
 {
 	/*
-	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
-	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
-	 * a RELEASE barrier so that other tasks can ACQUIRE it.
+	 * For existing inodes, multiple tasks may race to set up the inode's
+	 * fscrypt info. So use cmpxchg_release().  This pairs with the
+	 * smp_load_acquire() in fscrypt_get_inode_info().  I.e., here we
+	 * publish the inode's fscrypt info with a RELEASE barrier so that
+	 * other tasks can ACQUIRE it.
 	 */
 	return cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info) == NULL;
 }
@@ -230,9 +231,10 @@ fscrypt_get_inode_info(const struct inode *inode)
 {
 	/*
 	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
-	 * I.e., another task may publish ->i_crypt_info concurrently, executing
-	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
-	 * ACQUIRE the memory the other task published.
+	 * I.e., another task may publish the inode's fscrypt info
+	 * concurrently, executing a RELEASE barrier.  We need to use
+	 * smp_load_acquire() here to safely ACQUIRE the memory the other task
+	 * published.
 	 */
 	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop);
 	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop->inode_info_offs);

-- 
2.47.2


