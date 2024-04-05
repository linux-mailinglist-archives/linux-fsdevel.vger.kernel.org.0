Return-Path: <linux-fsdevel+bounces-16183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E718C899C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DCCB21B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7616D4DD;
	Fri,  5 Apr 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sDloi5iX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3416C85E;
	Fri,  5 Apr 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319248; cv=none; b=WZm5t3d6ks1JCew/XOdUBcJ0Ko4257U++2zgb5jVaL7XaiAp2P3Oqz2sC4uUn/CoHKB3RNOZMe+2hTWRTOCrboWmGnshMb2xRjLmsUzfo5qbTOpEnHTHK+5aRJ/lrFWkNpp92gTeuimJ2S0BWZ2JL3XBlAS8LlAgRMOz+P0UHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319248; c=relaxed/simple;
	bh=9qh1y4JVe985uO0lqk1EDdTzU0Or+8CTkIgpVaInUzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoS7fz9GUGgGvrQYyHGbGl3U8tOyKvM4zHEJho9xNtTB+w2EcAzJJgosi3D+H15/+MJpv8iETaE3eaIasbwXA+kldkzFWvb7FFPh4lM3uGEHYH3lUdlUsogTaAysz1fy24r/rM4M05KU42/9VgUoYvXf4bsbkWtjHC25jvEQiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sDloi5iX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712319244;
	bh=9qh1y4JVe985uO0lqk1EDdTzU0Or+8CTkIgpVaInUzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDloi5iX1DUGvTXKzsVkv+J+RCTln+x7P0dAgAwiyBeeProuG+ZTeCHkwUO6FAfP4
	 BqpOucBmT8toIK7qN/4/sIcJOeCOKaCdIcRdLpiceOk1PVCI7SMFFPAnC79jXXplAk
	 JiAyYmbrUYYxJRLO/+GhT92L1TGlsaPY0xQkQ+nqyBskpZa7+2GUsEnrxDx9C1EyKO
	 KIH5n19RP4F65JKc7XciEpZW0gZErBGQZcUrKWvFaWPMU8vOQsFb6VfT+bdiw8nIYi
	 BF2s5xYKCDf6zl1EwHtQBGsBVXl9TsPiPEKhMj54yQs75Jw15Xa4mzh7S0oc/EUz46
	 5rvTZpoHALzaQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A7F8F3782132;
	Fri,  5 Apr 2024 12:14:03 +0000 (UTC)
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
	ebiggers@kernel.org,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v16 3/9] libfs: Introduce case-insensitive string comparison helper
Date: Fri,  5 Apr 2024 15:13:26 +0300
Message-Id: <20240405121332.689228-4-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

generic_ci_match can be used by case-insensitive filesystems to compare
strings under lookup with dirents in a case-insensitive way.  This
function is currently reimplemented by each filesystem supporting
casefolding, so this reduces code duplication in filesystem-specific
code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: rework to first test the exact match]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/libfs.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +++
 2 files changed, 77 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..88fcd19685a3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1811,6 +1811,79 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
 #endif
 };
+
+/**
+ * generic_ci_match() - Match a name (case-insensitively) with a dirent.
+ * This is a filesystem helper for comparison with directory entries.
+ * generic_ci_d_compare should be used in VFS' ->d_compare instead.
+ *
+ * @parent: Inode of the parent of the dirent under comparison
+ * @name: name under lookup.
+ * @folded_name: Optional pre-folded name under lookup
+ * @de_name: Dirent name.
+ * @de_name_len: dirent name length.
+ *
+ * Test whether a case-insensitive directory entry matches the filename
+ * being searched.  If @folded_name is provided, it is used instead of
+ * recalculating the casefold of @name.
+ *
+ * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
+ * < 0 on error.
+ */
+int generic_ci_match(const struct inode *parent,
+		     const struct qstr *name,
+		     const struct qstr *folded_name,
+		     const u8 *de_name, u32 de_name_len)
+{
+	const struct super_block *sb = parent->i_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
+	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
+	int res = 0;
+
+	if (IS_ENCRYPTED(parent)) {
+		const struct fscrypt_str encrypted_name =
+			FSTR_INIT((u8 *) de_name, de_name_len);
+
+		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
+			return -EINVAL;
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (res < 0)
+			goto out;
+		dirent.name = decrypted_name.name;
+		dirent.len = decrypted_name.len;
+	}
+
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 */
+	if (folded_name->name) {
+		if (dirent.len == folded_name->len &&
+		    !memcmp(folded_name->name, dirent.name, dirent.len))
+			goto out;
+		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
+	} else {
+		if (dirent.len == name->len &&
+		    !memcmp(name->name, dirent.name, dirent.len) &&
+		    (!sb_has_strict_encoding(sb) || !utf8_validate(um, name)))
+			goto out;
+		res = utf8_strncasecmp(um, name, &dirent);
+	}
+
+out:
+	kfree(decrypted_name.name);
+	if (res < 0 && sb_has_strict_encoding(sb))
+		return res;
+	return !res;
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 883b72478f61..422488ed24cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3346,6 +3346,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_sb_d_ops(struct super_block *sb);
+extern int generic_ci_match(const struct inode *parent,
+			    const struct qstr *name,
+			    const struct qstr *folded_name,
+			    const u8 *de_name, u32 de_name_len);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.34.1


