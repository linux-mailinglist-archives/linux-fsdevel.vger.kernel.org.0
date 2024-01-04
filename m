Return-Path: <linux-fsdevel+bounces-7392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5A824605
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CA0B23C9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9A24B2B;
	Thu,  4 Jan 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTEY3bMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058F24B25;
	Thu,  4 Jan 2024 16:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C145C433C7;
	Thu,  4 Jan 2024 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385144;
	bh=r/dCDyVPVjRJZWtpmAX8vVDttoXSpUaXT0VdMiN7efg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aTEY3bMTt5wNp+f9msfrACtI8eZpsyc8H9CtN5wrvAtH9zcw38/UgAwLBkFrOjTAj
	 7J0HCDLSN4Ub6axzX/eAlWKSIQIjr/ROTLQ+OqFgX9KfEenKxs9+gzhXovi2sXi4qA
	 je9NyrQvIICgQX+yejYY5OjK5sknp41LKRarJadKmdPVmbKyy8sW9q1BUXuTvDE10P
	 Ifa4u2x7nvbmOsBkGP2B2ZQwNuS2xpTDt6NNrieT43M6lj78g+pRXgs2vPjzOzUqtM
	 TnVklAyuDwNf4GevJygByeZRGjn0wB4z+qGKfmBsfOoDF0osPf2sebH+9fPLch7rGh
	 68/5pLKJZ/Dlg==
Subject: [PATCH v3 2/2] fs: Create a generic is_dot_dotdot() utility
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Thu, 04 Jan 2024 11:19:02 -0500
Message-ID: 
 <170438514228.129184.8854845947814287856.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
References: 
 <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

De-duplicate the same functionality in several places by hoisting
the is_dot_dotdot() utility function into linux/fs.h.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/crypto/fname.c    |    8 +-------
 fs/ecryptfs/crypto.c |   10 ----------
 fs/exportfs/expfs.c  |    4 +---
 fs/f2fs/f2fs.h       |   11 -----------
 fs/namei.c           |    6 ++----
 include/linux/fs.h   |   15 +++++++++++++++
 6 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 7b3fc189593a..0ad52fbe51c9 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -74,13 +74,7 @@ struct fscrypt_nokey_name {
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
-	if (str->len == 1 && str->name[0] == '.')
-		return true;
-
-	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
-		return true;
-
-	return false;
+	return is_dot_dotdot(str->name, str->len);
 }
 
 /**
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 03bd55069d86..2fe0f3af1a08 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1949,16 +1949,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	return rc;
 }
 
-static bool is_dot_dotdot(const char *name, size_t name_size)
-{
-	if (name_size == 1 && name[0] == '.')
-		return true;
-	else if (name_size == 2 && name[0] == '.' && name[1] == '.')
-		return true;
-
-	return false;
-}
-
 /**
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 84af58eaf2ca..07ea3d62b298 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -255,9 +255,7 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 		container_of(ctx, struct getdents_callback, ctx);
 
 	buf->sequence++;
-	/* Ignore the '.' and '..' entries */
-	if ((len > 2 || name[0] != '.' || (len == 2 && name[1] != '.')) &&
-	    buf->ino == ino && len <= NAME_MAX) {
+	if (buf->ino == ino && len <= NAME_MAX && !is_dot_dotdot(name, len)) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..322a3b8a3533 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3368,17 +3368,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
 }
 
-static inline bool is_dot_dotdot(const u8 *name, size_t len)
-{
-	if (len == 1 && name[0] == '.')
-		return true;
-
-	if (len == 2 && name[0] == '.' && name[1] == '.')
-		return true;
-
-	return false;
-}
-
 static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..2386a70667fa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2667,10 +2667,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
 	if (!len)
 		return -EACCES;
 
-	if (unlikely(name[0] == '.')) {
-		if (len < 2 || (len == 2 && name[1] == '.'))
-			return -EACCES;
-	}
+	if (is_dot_dotdot(name, len))
+		return -EACCES;
 
 	while (len--) {
 		unsigned int c = *(const unsigned char *)name++;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..750c95a2b572 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2846,6 +2846,21 @@ extern bool path_is_under(const struct path *, const struct path *);
 
 extern char *file_path(struct file *, char *, int);
 
+/**
+ * is_dot_dotdot - returns true only if @name is "." or ".."
+ * @name: file name to check
+ * @len: length of file name, in bytes
+ *
+ * Coded for efficiency.
+ */
+static inline bool is_dot_dotdot(const char *name, size_t len)
+{
+	if (unlikely(name[0] == '.'))
+		if (len < 2 || (len == 2 && name[1] == '.'))
+			return true;
+	return false;
+}
+
 #include <linux/err.h>
 
 /* needed for stackable file system support */



