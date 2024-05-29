Return-Path: <linux-fsdevel+bounces-20418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A780D8D3152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95E61C2280F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581C16EBEF;
	Wed, 29 May 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TgscUdLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4C16C6A0;
	Wed, 29 May 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971213; cv=none; b=G1GYqvNCXq+kGpbJFqCyxWij9Ip39DFDsb54JuVeY5sFYqiY6EXS/A3Ax34M2QdXsssST9UlVKcyy20ScB6hqq5DekPEXA/nYTKL5jwq3sq6wPkwJfrDvmIt9rH7KFjnECDa2skbLhiAz+ihzJK/6BwmM/ZlniAYLoqUByXlAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971213; c=relaxed/simple;
	bh=ff8DpzwAZfEYeJk9vvRifefq2qMJjx4JWhXWjCFPTAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sspZqZGSpxAnsMvB54xu4dUNAWCi0kly9JNj8lwvrtxrE2urf3NE5dGbVf4bpHSYsnCo+jZga8k+9KuAh+yiw1EixpD2xhrRfiFIhGjh+K7JscnkFpIk+OUw4iXlGxxIqAGlQr4eQHE5T9k4tvHs4czws7bSmv4HzNu4BBwjLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TgscUdLP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716971209;
	bh=ff8DpzwAZfEYeJk9vvRifefq2qMJjx4JWhXWjCFPTAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgscUdLPTsXKCd/PWwa9rhjQr2RlhAHZp/RKeQKh8bm7yk6+gS5aMrGWdE/OSQGgB
	 f6YhJVLnCMscTqSMIs56F9K2lqjSbmVQ1RBnVgJTAru7MMTB2ncO0TPODrxEpmLuuT
	 OgHu+LZ5hpVGGeAn4JjmAfQ4hdPff9EFMRQSoWGJWOYx9u6tmmMYbF/Iz+yuMh0g8E
	 tAZCePmbKXC+9nHmDSWc9NuCq7gZszcOiK9ioE8PJ3vGS0YZhhJcrxokI/ZAa+N34m
	 hmYKMvXMKvludVUSCQM3R2hpzdu2ReB2EVNzRvCUzlwyWK982qkGAoPD7bN9yo1BNT
	 jmTeX8jVca0Fg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B5C7D378216D;
	Wed, 29 May 2024 08:26:48 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiggers@google.com,
	krisman@suse.de,
	kernel@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v17 3/7] libfs: Introduce case-insensitive string comparison helper
Date: Wed, 29 May 2024 11:26:30 +0300
Message-Id: <20240529082634.141286-4-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082634.141286-1-eugen.hristev@collabora.com>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
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
[eugen.hristev@collabora.com: rework to first test the exact match, cleanup
and add error message]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/libfs.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +++
 2 files changed, 78 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index b635ee5adbcc..6a6cfa2d7d93 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1854,6 +1854,80 @@ static const struct dentry_operations generic_ci_dentry_ops = {
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
+		if (res < 0) {
+			kfree(decrypted_name.name);
+			return res;
+		}
+		dirent.name = decrypted_name.name;
+		dirent.len = decrypted_name.len;
+	}
+
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 */
+
+	if (dirent.len == (folded_name->name ? folded_name->len : name->len) &&
+	    !memcmp(name->name, dirent.name, dirent.len))
+		goto out;
+
+	if (folded_name->name)
+		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
+	else
+		res = utf8_strncasecmp(um, name, &dirent);
+
+out:
+	kfree(decrypted_name.name);
+	if (res < 0 && sb_has_strict_encoding(sb)) {
+		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
+		return 0;
+	}
+	return !res;
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 639885621608..f8ca264a0edc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3367,6 +3367,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
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


