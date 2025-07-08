Return-Path: <linux-fsdevel+bounces-54219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E6AFC2FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 08:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5707A3A8873
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E922578C;
	Tue,  8 Jul 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mI7aBuKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224B221579;
	Tue,  8 Jul 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956933; cv=none; b=BftD4WROdcqsdMUE3voI7fWOmJuETq3QjhDTA3rdypsgUmsACLCMrgShtlgJ6RR9lhra39xpSc5eEh/Et1gSkohyTm1aNeNEWrGypr7WSTojZZ5ymbyNhF/kIHKksO4zOEDWA2CJez/m1KuGRgtSb2WaHcnvqO5xeSk4qbWTVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956933; c=relaxed/simple;
	bh=e9lWMzUorQ1Xy+szibNpC6r2jnMweK5HHXxTyIE1Y78=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gvQF+dNsaJ1fQwdvASnLI8RFqCHgXdcQ/KRmhAtVifbwajqH+HgxKNH07aL8RHr4xD/cCtWPS8Gg1opRPibMp+U+cdjBhyik/M50F6rH2OqswoQlJuuRnP2K0EQ0NYC7eM3SkvWjq2DDo2BJS6+IJtlVZEO+yuTs1VWaJA4CQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mI7aBuKv; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751956923;
	bh=vdIyDvJNm1JguBw4F+puzOvkcznPiEpm8HbrDr1/ue4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mI7aBuKvGvOXvPD2OOqVTOXl5AWl74Tc0Bmd3BPeWlRKGzA/xUp14R2qzUYcdhPXy
	 nvrWdikVU51As5z9kUFxwG99Y8PZ/NzXabUkLVLb4jYLvCypvODNnJyitg8rSeYcbd
	 SdQevvBDUd3KC5Lp6xNZyt38YyVfvnaRTfbTh0H4=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.73])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id A6890ACF; Tue, 08 Jul 2025 14:41:40 +0800
X-QQ-mid: xmsmtpt1751956900tianq68yj
Message-ID: <tencent_5A2FE78BA54BA148917B62FCC4B5E4FC2505@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne9o+Gb8aezNKf5Psbb6m1VxRKSa2JVhARcEcyjV0y21AATnjgl7
	 oizaZTfuyqmRXnTMmfneAkENDMc6Vu1RT/u8y9XIcloKbgBjkaXNPNPyOdWZTtKQRknWjxdHD2AW
	 Sxgq2JvE7RtnIPYwfGSnNyH1mB1OwRZuGMtOQLvCqC8xovQ9tTe4k6GZOTarq55quNN9JBvAwcx7
	 qOOrO8zFVVOtW8ByOD/9YbFHisQllOFlMfxdZfKTHY7kfUA5b3iNz7IH5iekXOfv05fNAUos0KO4
	 hG4bRM9n5Y1MMg+BCnvNLaLAEfpZFdbe7LtFQ6PMmt8I+JlYm8wWKKmc44W15m8vwTX6/ajAxNoK
	 pJ7x01omadan2ex1F6frWPgiNrQ0jtrISb2TecrhIYkIPne4VzgpS984JHYZ+BqkiEEXOM2wRVNW
	 TziMC+RzIXO92IOj7DDAb2t23XrnZQVN4GfRybb168MKM9QMZprVF+2aDDn0qtZBsUkFz7qqOrZK
	 Jhz0cP1tY3My2A+Vt4BFYCD6IeAeZamAMf/mngWvv6j3Ea7tT/d77Uam4W7nlPnDjTaj262LmeLx
	 zSs8fWTrGFAPEabL7LEOgyla55q6+dUSE8/GRAwF7fbyTTxEn6YNA0q7FeJocUjtIvy3l+b33H3R
	 +OZAyL3Zj1qn3xR9aOw8E7SNXqT8rnbqkvjY79yCyW0w/rNQNHRmiWXVWV9V/0u4JgtLWhnIjRhL
	 AeVKW7P90HPwCCAzsjEISF5L1Voz8SYgIiX/vRxbnGNZzkiKMpdsjHavXPxgIav54NVD4WcDWAgu
	 VlSobte6LbHPRN4QJEYUJOZKvlfPrOl8Xc2S9yoXvnv4omGu/+E2Vo/86vTKrUmh3aA83Fzhc0Gt
	 JBDpm2iPOgnR2TB9x+3rTsAune/cMl1qz/rA1Oriqev5G5LbttRZCHsz0Kyas4SqSpRrkH2Exqap
	 CGb4v1Y7Zz4kAt1OMWipz5zkHocBmrKjEOAIYte+QXcFDqtKzaerx4H+9mQ+iR7A5wMR8cIuW+i0
	 u5Z93q4jO5MGvWsSKKw5qxS3dDfwHRVht2RKF/Dw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: adilger.kernel@dilger.ca,
	brauner@kernel.org,
	chao@kernel.org,
	jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk
Subject: [PATCH v4 1/2] libfs: reduce the number of memory allocations in generic_ci_match
Date: Tue,  8 Jul 2025 14:41:35 +0800
X-OQ-MSGID: <20250708064135.844552-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
References: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During path traversal, the generic_ci_match function may be called
multiple times. The number of memory allocations and releases
in it accounts for a relatively high proportion in the flamegraph.
This patch significantly reduces the number of memory allocations
in generic_ci_match through pre - allocation.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/ext4/namei.c    |  2 +-
 fs/f2fs/dir.c      |  2 +-
 fs/libfs.c         | 33 ++++++++++++++++++++++++++++++---
 include/linux/fs.h |  8 +++++++-
 4 files changed, 39 insertions(+), 6 deletions(-)

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
index c36b3b22bfffd..4c6611fbd9574 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -197,7 +197,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 	if (fname->cf_name.name)
 		return generic_ci_match(dir, fname->usr_fname,
 					&fname->cf_name,
-					de_name, de_name_len);
+					de_name, de_name_len, NULL);
 
 #endif
 	f.usr_fname = fname->usr_fname;
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a81..293b605971bbf 100644
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
+	if (prealloc->name && wantlen <= prealloc->namelen)
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
@@ -1873,6 +1893,7 @@ static const struct dentry_operations generic_ci_dentry_ops = {
  * @folded_name: Optional pre-folded name under lookup
  * @de_name: Dirent name.
  * @de_name_len: dirent name length.
+ * @prealloc: decrypted name memory buffer
  *
  * Test whether a case-insensitive directory entry matches the filename
  * being searched.  If @folded_name is provided, it is used instead of
@@ -1884,7 +1905,8 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 int generic_ci_match(const struct inode *parent,
 		     const struct qstr *name,
 		     const struct qstr *folded_name,
-		     const u8 *de_name, u32 de_name_len)
+		     const u8 *de_name, u32 de_name_len,
+		     struct decrypted_name_prealloc *prealloc)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1899,7 +1921,11 @@ int generic_ci_match(const struct inode *parent,
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
@@ -1928,7 +1954,8 @@ int generic_ci_match(const struct inode *parent,
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


