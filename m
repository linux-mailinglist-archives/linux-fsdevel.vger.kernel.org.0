Return-Path: <linux-fsdevel+bounces-15893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7278958AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01DBB27BAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26869134733;
	Tue,  2 Apr 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oezluZpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6E133293;
	Tue,  2 Apr 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072934; cv=none; b=NB74rhUyvliplDkk0SS5wVJHQvGL/8BXQMcl9x9HXZhxJf4CSnaiZso8seXQcFR93IKHMTK/8CRejRlCQvAsVsAa0Fzzv0qOCVluGSy2YWre/51J9PnnuSqVjrURKIohTFAEyH8iTspBHnMI2P4XfGKvPFc7iUg3Tf634C50opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072934; c=relaxed/simple;
	bh=xSyEV4LtFGP/kO7x7ObAfwPN8BqJBTpWs53KUvMRUNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuVw+ptV3NlwtHx6AJvIi52DvPxvQC3yLVTsIlYdpCL/v9R4nL1jl4XbTZKngOULHDe5ZM+EqIWL8xCb7NM0Gb1PhSAT0hQeYAQwJVBXKM0k2ehB/b7kq7LwF73q7qgydH30zyjWDc/RPw1VaKEs/ysii2ultMOGl5zoZxaQYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oezluZpt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712072931;
	bh=xSyEV4LtFGP/kO7x7ObAfwPN8BqJBTpWs53KUvMRUNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oezluZptzZxPoHTPXZdDEfbgG3zBvsKwDW32Vq6gZi98XXLCl5XihdirTfsZ55SDO
	 cJq9/d66Coj71YhlQ3e9V1zvFM1I1ZTc3U55Asgajr9IHmABnWIiNE41/SxnCSMt7e
	 WvYnZBFQ5z4+bS1I2aVNFwfcy5iMSwa0SkOKZxo/NPU2by73HPyAw/0pkuUDFeWIP8
	 8G0ujMwq5e0hz8TkvPHPRq8Xh5S8ux+reW7q8c0K4Gc6Hsab2eQBs5JVEprWFcly5X
	 FaHbSemHwGe30Zm9jR7VfMNxxkSnWgGZXySkQn6BGZxa4kE7QBAd9VIdYQsX/g0HX9
	 H6lMqLPF6ujgg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF9453782017;
	Tue,  2 Apr 2024 15:48:49 +0000 (UTC)
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
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v15 2/9] f2fs: Simplify the handling of cached insensitive names
Date: Tue,  2 Apr 2024 18:48:35 +0300
Message-Id: <20240402154842.508032-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402154842.508032-1-eugen.hristev@collabora.com>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Keeping it as qstr avoids the unnecessary conversion in f2fs_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.8-rc3 and minor changes]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c      | 53 ++++++++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h     | 16 +++++++++++++-
 fs/f2fs/recovery.c |  5 +----
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 042593aed1ec..3b454f355f15 100644
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
index 65294e3b0bef..4f68c58718fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -524,7 +524,7 @@ struct f2fs_filename {
 	 * internal operation where usr_fname is also NULL.  In all these cases
 	 * we fall back to treating the name as an opaque byte sequence.
 	 */
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
@@ -3528,8 +3528,22 @@ int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 /*
  * dir.c
  */
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
index d0f24ccbd1ac..7e53abf6d216 100644
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


