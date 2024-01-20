Return-Path: <linux-fsdevel+bounces-8354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63388334EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546062828EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A07FBFD;
	Sat, 20 Jan 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2kVm46p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271EFBE8;
	Sat, 20 Jan 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705759076; cv=none; b=BH2DrvIgqiQpuyviocH63R1nkILyDPRJPfN+R3hfndaKFOsevVfSyqtd0YBBKdJaKUorgnVoNt5DnK3y2ArPd5hMoPThJNHBv4wOV9ZX85Q2fTJeLcbTMWGpiaUYqWMa9xl8Q31Jc6jAylH+ciysxckiAZfuRyuYeZkSfUUwwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705759076; c=relaxed/simple;
	bh=nUcUjCnWlSTXF8Wr/JGV6vWcMzXAjhzjR0l/hIz7G9o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aby2b63LztRcDL8B3AzbgXgePy4JHlTEIKAzSFg13j0jGEEa4miun94G/U/kvTMn7L7yaDlTlKDlwfu6cbx163Fvk1En3CoXL7E6UTzlCF2vO4F2hr4/5h1ihrnA5SiGGl5u6vuUAPuNWSWgzD/DUm42SUPI4+0ipZkAVpsoV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2kVm46p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE31C433F1;
	Sat, 20 Jan 2024 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705759076;
	bh=nUcUjCnWlSTXF8Wr/JGV6vWcMzXAjhzjR0l/hIz7G9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E2kVm46pb0xEJ24CurL7o4mpkHwjMF9bqq2nBrV8NmNDzwWjUefxBkV7cnRCdMj6Y
	 EoMTzs6iEEVVAZIVnz8LMB9kt3/jLk+azIhJGvLrtu63kg1F2+j9ngtgRJOTDl3b7/
	 gX2B3Vs+S/GS6trEpUTnCbZ0dtJuOg9dH07Yi/X4gISabepl7UVrGUrcqCe3AQzUKj
	 JDfeFtW5iSLw4BhIstBslZy1GoYXZJ4kiyeKJMPOOr+3CMZce7dR0IYQJR9V0G47Ce
	 FGc8Cj27KIb+DswRVgqZYBoVVBTf3brL7V5l4GE2QCafkDlzsiNgkNfBRROQc6N2zS
	 Xi7fS+duNHwTw==
Subject: [PATCH v5 2/2] fs: Create a generic is_dot_dotdot() utility
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: trondmy@hammerspace.com, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Sat, 20 Jan 2024 08:57:54 -0500
Message-ID: 
 <170575907468.22911.10976023123447238559.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
References: 
 <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/crypto/fname.c    |    8 +-------
 fs/ecryptfs/crypto.c |   10 ----------
 fs/exportfs/expfs.c  |   10 ----------
 fs/f2fs/f2fs.h       |   11 -----------
 fs/namei.c           |    6 ++----
 include/linux/fs.h   |   11 +++++++++++
 6 files changed, 14 insertions(+), 42 deletions(-)

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
index dcf7d86c2ce4..07ea3d62b298 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -244,16 +244,6 @@ struct getdents_callback {
 	int sequence;		/* sequence counter */
 };
 
-/* Copied from lookup_one_common() */
-static inline bool is_dot_dotdot(const char *name, size_t len)
-{
-	if (unlikely(name[0] == '.')) {
-		if (len < 2 || (len == 2 && name[1] == '.'))
-			return true;
-	}
-	return false;
-}
-
 /*
  * A rather strange filldir function to capture
  * the name matching the specified inode number.
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
index 98b7a7a8c42e..baa64344a308 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2846,6 +2846,17 @@ extern bool path_is_under(const struct path *, const struct path *);
 
 extern char *file_path(struct file *, char *, int);
 
+/**
+ * is_dot_dotdot - returns true only if @name is "." or ".."
+ * @name: file name to check
+ * @len: length of file name, in bytes
+ */
+static inline bool is_dot_dotdot(const char *name, size_t len)
+{
+	return len && unlikely(name[0] == '.') &&
+		(len == 1 || (len == 2 && name[1] == '.'));
+}
+
 #include <linux/err.h>
 
 /* needed for stackable file system support */



