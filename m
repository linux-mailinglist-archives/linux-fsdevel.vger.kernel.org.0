Return-Path: <linux-fsdevel+bounces-7240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D9823065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30D3283799
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFF1B291;
	Wed,  3 Jan 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYoB6jtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9971B278;
	Wed,  3 Jan 2024 15:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9164CC433C7;
	Wed,  3 Jan 2024 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295186;
	bh=KduI9in51OItaVjmNcwiR5rDC975JQ1mclQc1Lgd3VA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TYoB6jtCxQ4JvvqePm+gFrBAdjoDkrg/8Qwi1aC7RmNXNUfypPXVBXs/8qfdGQ87C
	 optTIxb0AH070xa7U8K/iOstpfaUJN0OYf0bEaRfgQK+fXfFa6cb8IFz6F8vp6THJ5
	 oeaAIOuJyNnVqlAO6Q2T94ClkUj3sX4TkJp5YC2OPIsPhr6O7ckpvLlYr0eWzyUuVy
	 qGgn0artNxK3YEVoqYH4s7J3XJhVEBu0fAfCwjDRhxx1Bvz8qZwe3AtOTOrs/ShNTm
	 BRvKxvfpQruuzk1MB5erZWaFeVtcK6D1k9KUiRdw/bO3+YsktlDu+4SfzkDSmGY7tY
	 Jr2nc+pToQCNQ==
Subject: [PATCH v2 2/2] fs: Create a generic is_dot_dotdot() utility
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Date: Wed, 03 Jan 2024 10:19:44 -0500
Message-ID: 
 <170429518465.50646.9482690519449281531.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
References: 
 <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
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
the is_dot_dotdot() function into linux/fs.h.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/crypto/fname.c    |    8 +-------
 fs/ecryptfs/crypto.c |   10 ----------
 fs/exportfs/expfs.c  |    4 +---
 fs/f2fs/f2fs.h       |   11 -----------
 include/linux/fs.h   |    9 +++++++++
 5 files changed, 11 insertions(+), 31 deletions(-)

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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..179eea797c22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2846,6 +2846,15 @@ extern bool path_is_under(const struct path *, const struct path *);
 
 extern char *file_path(struct file *, char *, int);
 
+static inline bool is_dot_dotdot(const char *name, size_t len)
+{
+	if (len == 1 && name[0] == '.')
+		return true;
+	if (len == 2 && name[0] == '.' && name[1] == '.')
+		return true;
+	return false;
+}
+
 #include <linux/err.h>
 
 /* needed for stackable file system support */



