Return-Path: <linux-fsdevel+bounces-12118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6F85B62A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE31C21293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB360BB1;
	Tue, 20 Feb 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r2FsOhsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA364CD4;
	Tue, 20 Feb 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419183; cv=none; b=ngH8HYVoKXQxE3nDI35YuDXNO0EkHkvsyiB34oIsknh/L5wF4+vqOjPa+gmAo2GDKPNoHFvT8iLypuhAqcS+g+qtertuGn5VpN/MSVis0V/ZBo4emn+qxXQuuF1Z2giPn7N/mOZz46pT7Wh6j6Kgc7ad/u6iRAnBdZ7yDB/XbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419183; c=relaxed/simple;
	bh=qz8S7xFJa6xuAqtF97SRmEiApDWkUqTqYZBa3wZStlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hT3Qw61z4zsSYDWTmLugO55dsYFirPaCZZVcgrYR5VmXT4aOxWCznYGo/e+eL19eKrO98fg13YpSqHQtbiuH1PoHZ6K2uS/ZUFGUqPBh7gCXtJoRWCK4tviJqqSjgJ35YstKqqoxh6YKj/QMksrgsDLGwZAgbSpvYrS5IfIGWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r2FsOhsD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419180;
	bh=qz8S7xFJa6xuAqtF97SRmEiApDWkUqTqYZBa3wZStlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2FsOhsDV17dEdnUaHnl/6eCD3lZQNMyYpTmVh7wY+kByukIJ+krZQnvAHwBs/nC2
	 hckAqCDGtOlKWbPUsChcJyVNIrEiUxOV80Co77FyxiTP6IDYTirX6pMp4f/x0rYgUj
	 TyNCw4MB8BQ1g7I3MjTGPNrHPwoXQmNf17aCnPqCOD7A/LeenllTgTE1S6uBmoEXLp
	 r5YDLgvlukcY/BLfm1sazLzwHxnH4U/B4bT2lU9TRj8efvtQK6RnHNEG52gz+oSSJG
	 WiyFBDLqIq8LULh8LULBfDFx9LHff/d+NnQeFPNoobQnvC/cs2wLaGcQkNh3BuW7P+
	 Y2u2jQ8oVcOcg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 91313378208D;
	Tue, 20 Feb 2024 08:52:56 +0000 (UTC)
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
Subject: [PATCH v12 3/8] libfs: Introduce case-insensitive string comparison helper
Date: Tue, 20 Feb 2024 10:52:30 +0200
Message-Id: <20240220085235.71132-4-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220085235.71132-1-eugen.hristev@collabora.com>
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
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
 fs/libfs.c         | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +++
 2 files changed, 89 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index bb18884ff20e..65e2fb17a2b6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1773,6 +1773,91 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
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
+	int res, match = 0;
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
+	 *
+	 * This comparison is safe under RCU because the caller
+	 * guarantees the consistency between str and len. See
+	 * __d_lookup_rcu_op_compare() for details.
+	 */
+	if (folded_name->name) {
+		if (dirent.len == folded_name->len &&
+		    !memcmp(folded_name->name, dirent.name, dirent.len)) {
+			match = 1;
+			goto out;
+		}
+		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
+	} else {
+		if (dirent.len == name->len &&
+		    !memcmp(name->name, dirent.name, dirent.len) &&
+		    (!sb_has_strict_encoding(sb) || !utf8_validate(um, name))) {
+			match = 1;
+			goto out;
+		}
+		res = utf8_strncasecmp(um, name, &dirent);
+	}
+
+out:
+	kfree(decrypted_name.name);
+	if (match) /* matched by direct comparison */
+		return 1;
+	else if (!res) /* matched by utf8 comparison */
+		return 1;
+	else if (res < 0) /* error on utf8 comparison */
+		return res;
+	return 0; /* no match */
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 820b93b2917f..7af691ff8d44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3296,6 +3296,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern int generic_ci_match(const struct inode *parent,
+			    const struct qstr *name,
+			    const struct qstr *folded_name,
+			    const u8 *de_name, u32 de_name_len);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.34.1


