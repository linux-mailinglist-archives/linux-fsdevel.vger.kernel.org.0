Return-Path: <linux-fsdevel+bounces-53776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171DAF6CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74591174870
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511E2D0C6F;
	Thu,  3 Jul 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ig+Afur7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC59142E73;
	Thu,  3 Jul 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531217; cv=none; b=QqKuTWTp2n5EiNXHIKNUbtQ7kVB+cazjkutA/+6X9eg7GvSUwWxsgS7uR269AABlrG5avuIERw8i7qIwZs1OYWWgnPvJbGpvwgIhtirrWLqJNmduL/Mf1E0rfK7J1iTccTNIagMHWqdPPvquJkIgEit/DHuUO9Wwo+NNvc0GCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531217; c=relaxed/simple;
	bh=cUemAdl0pJFO3XhOtVB6A8y95UFvRCY+2B/W4wwbJes=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PkEDv44GSSm2vl0M4OKiitWPdmLOGGgr1wDNSsXIPJkqV14d/2v049/aXVfyRO0bAchyvm/E1l2PSmn5DF489manzIaUOWIIIXcPMVukdm3upLB5r7t4TAEMMk3cc8QS+xrbcQCKFWSTPAbymez6mZFXt0RJ8GRHTvszzEtS8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ig+Afur7; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751530899;
	bh=ASyOgRuJCzYSYIfacN+EeOsknl3jO/Wltql91XIph7U=;
	h=From:To:Cc:Subject:Date;
	b=ig+Afur7MFoF4HFpsMq+w3wy3pFg6wTtt8NbtaSGmRB3JfnhgUIz9ZpqlvoBhvMzM
	 Zxy+MYN92Hg0qzb9mmIq+3XOjQN32HoF3JgogJECWoh7M1+Wb4uo0cb2xoNOm+w2EQ
	 mKyo9pgJE4RU5HQlVvAXVNaerNl/T+lMHvpwH39A=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.154])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 56438CDA; Thu, 03 Jul 2025 16:21:36 +0800
X-QQ-mid: xmsmtpt1751530896t0w1lu6bh
Message-ID: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
X-QQ-XMAILINFO: OQm4EXGVKR2Op0CCaGHiy832U8Vj3jDNN3G+6xng4BLs3psTUApV2iKhACvF8R
	 afOoYx669Uy3LXl1AyFwCADZF9Hh8lARxVQOLjNMNQMd2m505PjYc7gfilH3o960tQgk3oWymVrq
	 jbkoc/c8L2Q5su9Mzu0qUZjvWNLlKhnY3h8Oun39R7CQzh980XqnOs1GXHu5d2SvdU6FSIZ26DP/
	 zaNIq69Wp8lG2NdQBdyJNusUrHmMSz4E/oTFiF8MwEekX56+FGGiqcznSTqpt6nOmMQ4d6Pw98lz
	 LXHxTdp6jDGNkYqn0odMGufMyfFgi/z4s65wrqeQZl8zQvRDVKxmmJ7DjRgvyXcG1Ra08xqu+x70
	 ZUJdfeEUz8ESV0nVGWPLx12CAMf0Y3bIIw0iXZvE1XiZ4xUSya7Hpafve+bpZWrnI4Z1MN65nRAx
	 ETDcuyJSdwkeCECO3jEUKXujysTdfNn2gPnlgk939zEHyRN0Hypx+wib72pZs+ygG1BLOvdaerGC
	 /mCl8aa3vTpOlyky0F3YVIrQw3nLUK8fxZ13k9vVd8xA9ksi9iw7z/QxmEVdD7dy07LQrF5wwjSz
	 RJkLotbfqg9H/J31D6FWpQvDKJxE4kGYxe+byNyHP3a1UZcK+zUnRzUsful6OiQ8qXBlz6K3H9Lr
	 21pIzM0oqQZBRmlIZ0t/uBfNrbWD8Aqv/RZdG5zgiI2eiGcuNGTud8PhbWJPlNtT8VFJ0qgyAOmc
	 iptrWcGEcSSxuoWN89RGUno0Dm8YPbjceaJt8rAAdAk2yfHc/Bc1CKRXFlvzRNfyaEO5fG+njBx1
	 wRo47RXnlZABZnCv+zH482toREjIaSHbuCarBsZ/8WN1kUtEjILsoM+XQh1zQ0IQQxlZ8o7yGi1N
	 yYB8swWik73uCItZAKe5cwUWUqlE3m0KHdnojv0fGMQBxlX5ftEwzkBgeV8QUhiqRaM7ySwkkZFl
	 fxxs1v5uefV8n2CU4YoRSViiEoyZOHJMmomiyPaB2F3MwsSZ7h/85ZEQg0ZOtAByuprHLnOHTycQ
	 fRDNEK1gHsmhCW4eM2
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH] f2fs: improve the performance of f2fs_lookup
Date: Thu,  3 Jul 2025 16:21:30 +0800
X-OQ-MSGID: <20250703082130.3797733-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Android system, the file creation operation will call
the f2fs_lookup function. When there are too many files in a
directory, the generic_ci_match operation will be called
repeatedly in large quantities. In extreme cases, the file
creation speed will drop to three times per second.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/ext4/namei.c    |  2 +-
 fs/f2fs/dir.c      | 24 +++++++++++++++++-------
 fs/f2fs/f2fs.h     |  3 ++-
 fs/f2fs/inline.c   |  3 ++-
 fs/libfs.c         | 32 +++++++++++++++++++++++++++++---
 include/linux/fs.h |  8 +++++++-
 6 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac2294895..f235693bd71aa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1443,7 +1443,7 @@ static bool ext4_match(struct inode *parent,
 
 		return generic_ci_match(parent, fname->usr_fname,
 					&fname->cf_name, de->name,
-					de->name_len) > 0;
+					de->name_len, NULL) > 0;
 	}
 #endif
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c36b3b22bfffd..ee0cbeb80debd 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -176,6 +176,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct folio *dentry_folio,
 				const struct f2fs_filename *fname,
 				int *max_slots,
+				struct decrypted_name_prealloc *prealloc,
 				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
@@ -184,12 +185,13 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	dentry_blk = folio_address(dentry_folio);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
+	return f2fs_find_target_dentry(&d, fname, max_slots, prealloc, use_hash);
 }
 
 static inline int f2fs_match_name(const struct inode *dir,
 				   const struct f2fs_filename *fname,
-				   const u8 *de_name, u32 de_name_len)
+				   const u8 *de_name, u32 de_name_len,
+				   struct decrypted_name_prealloc *prealloc)
 {
 	struct fscrypt_name f;
 
@@ -197,7 +199,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 	if (fname->cf_name.name)
 		return generic_ci_match(dir, fname->usr_fname,
 					&fname->cf_name,
-					de_name, de_name_len);
+					de_name, de_name_len, prealloc);
 
 #endif
 	f.usr_fname = fname->usr_fname;
@@ -210,6 +212,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			const struct f2fs_filename *fname, int *max_slots,
+			struct decrypted_name_prealloc *prealloc,
 			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
@@ -236,7 +239,8 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
-					      le16_to_cpu(de->name_len));
+					      le16_to_cpu(de->name_len),
+					      prealloc);
 			if (res < 0)
 				return ERR_PTR(res);
 			if (res)
@@ -261,6 +265,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
 					struct folio **res_folio,
+					struct decrypted_name_prealloc *prealloc,
 					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
@@ -296,7 +301,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
+		de = find_in_block(dir, dentry_folio, fname, &max_slots, prealloc,
+				   use_hash);
 		if (IS_ERR(de)) {
 			*res_folio = ERR_CAST(de);
 			de = NULL;
@@ -336,6 +342,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 	bool use_hash = true;
+	struct decrypted_name_prealloc prealloc = {0};
 
 	*res_folio = NULL;
 
@@ -343,7 +350,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 start_find_entry:
 #endif
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_folio, use_hash);
+		de = f2fs_find_in_inline_dir(dir, fname, res_folio, &prealloc,
+					     use_hash);
 		goto out;
 	}
 
@@ -359,7 +367,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_folio, use_hash);
+		de = find_in_level(dir, level, fname, res_folio, &prealloc,
+				   use_hash);
 		if (de || IS_ERR(*res_folio))
 			break;
 	}
@@ -372,6 +381,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 		goto start_find_entry;
 	}
 #endif
+	kfree(prealloc.name);
 	/* This is to increase the speed of f2fs_create */
 	if (!de)
 		F2FS_I(dir)->task = current;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01e..dfbd2215310fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3673,6 +3673,7 @@ int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			const struct f2fs_filename *fname, int *max_slots,
+			struct decrypted_name_prealloc *prealloc,
 			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
@@ -4316,7 +4317,7 @@ int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 		const struct f2fs_filename *fname, struct folio **res_folio,
-		bool use_hash);
+		struct decrypted_name_prealloc *prealloc, bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct folio *ifolio);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 901c630685ced..d02ff6c26d70a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -353,6 +353,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio)
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
 					struct folio **res_folio,
+					struct decrypted_name_prealloc *prealloc,
 					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
@@ -370,7 +371,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	inline_dentry = inline_data_addr(dir, ifolio);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
+	de = f2fs_find_target_dentry(&d, fname, NULL, prealloc, use_hash);
 	folio_unlock(ifolio);
 	if (IS_ERR(de)) {
 		*res_folio = ERR_CAST(de);
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a81..cab3d86483835 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1863,6 +1863,26 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 #endif
 };
 
+#define DECRYPTED_NAME_PREALLOC_MIN_LEN 64
+static inline char *decrypted_name_prealloc_resize(
+		struct decrypted_name_prealloc *prealloc,
+		size_t wantlen)
+{
+	char *retbuf = NULL;
+
+	if (prealloc->name && wantlen >= prealloc->namelen)
+		return prealloc->name;
+
+	retbuf = kmalloc(wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN, GFP_KERNEL);
+	if (!retbuf)
+		return NULL;
+
+	kfree(prealloc->name);
+	prealloc->name = retbuf;
+	prealloc->namelen = wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN;
+	return retbuf;
+}
+
 /**
  * generic_ci_match() - Match a name (case-insensitively) with a dirent.
  * This is a filesystem helper for comparison with directory entries.
@@ -1884,7 +1904,8 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 int generic_ci_match(const struct inode *parent,
 		     const struct qstr *name,
 		     const struct qstr *folded_name,
-		     const u8 *de_name, u32 de_name_len)
+		     const u8 *de_name, u32 de_name_len,
+		     struct decrypted_name_prealloc *prealloc)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1899,7 +1920,11 @@ int generic_ci_match(const struct inode *parent,
 		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
 			return -EINVAL;
 
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!prealloc)
+			decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		else
+			decrypted_name.name = decrypted_name_prealloc_resize(
+					prealloc, de_name_len);
 		if (!decrypted_name.name)
 			return -ENOMEM;
 		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
@@ -1928,7 +1953,8 @@ int generic_ci_match(const struct inode *parent,
 		res = utf8_strncasecmp(um, name, &dirent);
 
 out:
-	kfree(decrypted_name.name);
+	if (!prealloc)
+		kfree(decrypted_name.name);
 	if (res < 0 && sb_has_strict_encoding(sb)) {
 		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
 		return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ec77da65f144..65307c8c11485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3651,10 +3651,16 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_sb_d_ops(struct super_block *sb);
+
+struct decrypted_name_prealloc {
+	char *name;
+	size_t namelen;
+};
 extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *name,
 			    const struct qstr *folded_name,
-			    const u8 *de_name, u32 de_name_len);
+			    const u8 *de_name, u32 de_name_len,
+			    struct decrypted_name_prealloc *prealloc);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
-- 
2.34.1


