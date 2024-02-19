Return-Path: <linux-fsdevel+bounces-11980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE15859D49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 08:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB85B22775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C04224F5;
	Mon, 19 Feb 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uq9QFaPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2495224EC;
	Mon, 19 Feb 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328721; cv=none; b=gbLEA8O6YQirtVi009PtGXV5SCpnuxnSlEwm0G9YqTQVQ4S4eonAbkA1FDiXhzPZeCrgvuBPR8CDWEeQ4Z4OORmSaXVlhOhSrPhZxJoNQd+4o9MelYtmzTi1C+ERM0dySN5L1yPXly1IDcSqXvfsHPM7Fu9Ai0EaM/Rp1j/87tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328721; c=relaxed/simple;
	bh=ZmbHA48mdcAgo9rPreneBpGW4T17Nyg3IwTQS03RZdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nelm3R1B/Kw2IdWRV52knYCQxi1gTDLghWJ+vswf49h1PKlAj1cMd8hRQL90tpNHsrcw3mVCvYgnP+2SjUrkt+V5rGZCE4hM4Q+Xw60KoCrjgYqQ1LjtE7BCCDcTkKW2TjakL9+fIFn7Eo+8VuM+Qq5BjzGiAx2Pa/Bq504O644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uq9QFaPX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708328718;
	bh=ZmbHA48mdcAgo9rPreneBpGW4T17Nyg3IwTQS03RZdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq9QFaPXRa34aDTzykslqcdjsR3Da/Z95l8Iinpkgmvl6s6v0YCZFJMqZzJ5FKKKr
	 AQkRezSJzXP9LSZ/fABMpUtqI97y17bKf+sSFrHEyiXplzSie5kG7mOXfV78P3xj4T
	 Xt5A4PhRuczGC7taoCFx4V63KALnRhBO7iBlrXKtpdssmmokVGPQYA/E+1CCxqGjhb
	 uOeSwqauRhKlFQ7Ugy+5/IaoZZmwDuoiTpkKS1zeMcNwv5dGnB9O04/lLGvgGf7+GD
	 /CioDSifYqgehrqZf2AIJJQXlOSC3i+SxaoOfkF+IJbFxaM6jorfs3CdzJQUZQnYar
	 tK9apEStsMwiA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC7053782084;
	Mon, 19 Feb 2024 07:45:13 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v11 2/8] f2fs: Simplify the handling of cached insensitive names
Date: Mon, 19 Feb 2024 09:44:51 +0200
Message-Id: <20240219074457.24578-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219074457.24578-1-eugen.hristev@collabora.com>
References: <20240219074457.24578-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Keeping it as qstr avoids the unnecessary conversion in f2fs_match

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.8-rc3]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c      | 53 ++++++++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h     | 17 ++++++++++++++-
 fs/f2fs/recovery.c |  5 +----
 3 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3f20d94e12f9..f5b65cf36393 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -42,35 +42,49 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
+#if IS_ENABLED(CONFIG_UNICODE)
 /* If @dir is casefolded, initialize @fname->cf_name from @fname->usr_fname. */
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
 	struct super_block *sb = dir->i_sb;
+	unsigned char *buf;
+	int len;
 
 	if (IS_CASEFOLDED(dir) &&
 	    !is_dot_dotdot(fname->usr_fname->name, fname->usr_fname->len)) {
-		fname->cf_name.name = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
-					GFP_NOFS, false, F2FS_SB(sb));
-		if (!fname->cf_name.name)
+		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
+					    GFP_NOFS, false, F2FS_SB(sb));
+		if (!buf)
 			return -ENOMEM;
-		fname->cf_name.len = utf8_casefold(sb->s_encoding,
-						   fname->usr_fname,
-						   fname->cf_name.name,
-						   F2FS_NAME_LEN);
-		if ((int)fname->cf_name.len <= 0) {
-			kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
-			fname->cf_name.name = NULL;
+
+		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
+				    buf, F2FS_NAME_LEN);
+		if (len <= 0) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
+			return 0;
 		}
+		fname->cf_name.name = buf;
+		fname->cf_name.len = len;
 	}
-#endif
+
 	return 0;
 }
 
+void f2fs_free_casefolded_name(struct f2fs_filename *fname)
+{
+	unsigned char *buf = (unsigned char *)fname->cf_name.name;
+
+	if (buf) {
+		kmem_cache_free(f2fs_cf_name_slab, buf);
+		fname->cf_name.name = NULL;
+	}
+}
+#endif /* CONFIG_UNICODE */
+
 static int __f2fs_setup_filename(const struct inode *dir,
 				 const struct fscrypt_name *crypt_name,
 				 struct f2fs_filename *fname)
@@ -142,12 +156,7 @@ void f2fs_free_filename(struct f2fs_filename *fname)
 	kfree(fname->crypto_buf.name);
 	fname->crypto_buf.name = NULL;
 #endif
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name) {
-		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
-		fname->cf_name.name = NULL;
-	}
-#endif
+	f2fs_free_casefolded_name(fname);
 }
 
 static unsigned long dir_block_index(unsigned int level,
@@ -235,11 +244,9 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name) {
-		struct qstr cf = FSTR_TO_QSTR(&fname->cf_name);
-
-		return f2fs_match_ci_name(dir, &cf, de_name, de_name_len);
-	}
+	if (fname->cf_name.name)
+		return f2fs_match_ci_name(dir, &fname->cf_name,
+					  de_name, de_name_len);
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 84c9fead3ad4..2ff8e52642ec 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -530,7 +530,7 @@ struct f2fs_filename {
 	 * internal operation where usr_fname is also NULL.  In all these cases
 	 * we fall back to treating the name as an opaque byte sequence.
 	 */
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
@@ -3533,8 +3533,23 @@ int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 /*
  * dir.c
  */
+unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de);
+#if IS_ENABLED(CONFIG_UNICODE)
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname);
+void f2fs_free_casefolded_name(struct f2fs_filename *fname);
+#else
+static inline int f2fs_init_casefolded_name(const struct inode *dir,
+					    struct f2fs_filename *fname)
+{
+	return 0;
+}
+
+static inline void f2fs_free_casefolded_name(struct f2fs_filename *fname)
+{
+}
+#endif /* CONFIG_UNICODE */
+
 int f2fs_setup_filename(struct inode *dir, const struct qstr *iname,
 			int lookup, struct f2fs_filename *fname);
 int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index aad1d1a9b3d6..8e8501a3a8e0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -153,11 +153,8 @@ static int init_recovered_filename(const struct inode *dir,
 		if (err)
 			return err;
 		f2fs_hash_filename(dir, fname);
-#if IS_ENABLED(CONFIG_UNICODE)
 		/* Case-sensitive match is fine for recovery */
-		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
-		fname->cf_name.name = NULL;
-#endif
+		f2fs_free_casefolded_name(fname);
 	} else {
 		f2fs_hash_filename(dir, fname);
 	}
-- 
2.34.1


