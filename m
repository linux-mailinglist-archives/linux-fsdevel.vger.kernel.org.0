Return-Path: <linux-fsdevel+bounces-15894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704A8958B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A601F2290C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ABF1353E4;
	Tue,  2 Apr 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="At6Y/fkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0713398E;
	Tue,  2 Apr 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072935; cv=none; b=sNFMLsxtwfxtSfeXFRWIl2OdekPxjYzsX3LklEBknQhgMWlNvE45u26yLcGdPFITyrlqWXNacS8DJzWNwp+3m+icGgLKRSfQkoEz+SIPBYsPXOE70snRL+EaYWJJmhqDLAGx96Les5fRyMCwtQpGy4Qe+RG05WDzsw9BO9Apm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072935; c=relaxed/simple;
	bh=upTn9VDPH4ATj696dO2v0HAAxcgXeQncdfgIxpTDi8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyIihCfurzQ8OGva5tarVQvSr/+CjZ2h5gEJUn8IFoxhnqBd69UVeBiQAFvipiDgWuEPviW57jdNHsf+NdI1ZTqVp7pj0yty7YQ05OT+ylwR+m1vL/rYoZfXXjyOCdq20GyKpvYKW6Dm0UFP6XDLKG76W4DQTCi4GEoDq8Rcgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=At6Y/fkM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712072932;
	bh=upTn9VDPH4ATj696dO2v0HAAxcgXeQncdfgIxpTDi8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=At6Y/fkMPPh7NBpLbP7gT7+bSmI28T5D4dzO8VJBNOUGsTZxktpxHDM98g3MntF5f
	 m5TOqJ7gc2i8eYm3AS6qmhk91epofuEbKzju3tj13nCgvP69GYQSAFakBgK0oKJwhd
	 8XRIua8emh7dh/OTIlgILTmd8tyaUDWlHino9Ipv4INIlCMUX+dXHCQEVFchljezWu
	 t7WJLydJDV8jGMfUtSuvydhIL98xzzLljwXCE1WtqBioT0286Se3zouSW7W2fAH5sI
	 o3eDK/bzu52uaZeeng7ZbS4gkS3Z6VGhMa8++2N+RYibxf4OHvab8CeXR35T7mL760
	 vv/fCpUeQa/4Q==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30CD037820EF;
	Tue,  2 Apr 2024 15:48:51 +0000 (UTC)
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
Subject: [PATCH v15 3/9] libfs: Introduce case-insensitive string comparison helper
Date: Tue,  2 Apr 2024 18:48:36 +0300
Message-Id: <20240402154842.508032-4-eugen.hristev@collabora.com>
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

generic_ci_match can be used by case-insensitive filesystems to compare
strings under lookup with dirents in a case-insensitive way.  This
function is currently reimplemented by each filesystem supporting
casefolding, so this reduces code duplication in filesystem-specific
code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: rework to first test the exact match]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/libfs.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +++
 2 files changed, 81 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index c297953db948..711eecc125bd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1776,6 +1776,83 @@ static const struct dentry_operations generic_ci_dentry_ops = {
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
+	int res = 0, match = 0;
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
+	if (res < 0)
+		return res;
+	return (match || !res);
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ff1338109b54..690b37e1db95 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
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


