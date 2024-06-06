Return-Path: <linux-fsdevel+bounces-21096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2988FDFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E08285071
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FE13FD6C;
	Thu,  6 Jun 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QDorgE9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864F13E058;
	Thu,  6 Jun 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659286; cv=none; b=TDVDmJlQ/TdsH8bjybj2G79AAMZoteGbKeLN7PQVwmlTIwGa4Ci0vkThkydkLLqzyOlsINnzsscSBV892JCR9F/SZ1Qwx5seg3inFXJnC/Uds32uMmPuUdOxxpoKWL6E/Dmmwzh5R85tYGiyOxlQJTstJl8nlZVDvfF2efbjfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659286; c=relaxed/simple;
	bh=2QuIxtKrX4JQURCSM13krZkPpuVxMNuAzViQSE1zWAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpiUBIytMF1NR6uOFNG2b8FUWtmdnDkrwgUHCjoIlYdrDvpNc1wlZ3vL077QJxtl+DWTU8lxePJXswxcE5YJ1T3Fx7FOx9D+dbOlz4ratd6iDPZFGCoyKejBaJJWhhtCHIOGIFRjrTQcjNRUb0AP8a3oxctI2ixcSjGLFI4ggpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QDorgE9P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717659283;
	bh=2QuIxtKrX4JQURCSM13krZkPpuVxMNuAzViQSE1zWAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDorgE9PL4QNpGF8WG36TqanKGvV4rHpz6ItFIrdm6K9swNLY7hwZUcc/TBDXKwXt
	 O6RYvUUruh0+xYtof/3pm6ssXyXUiMxCnxCBXUC3lSnYj7FBKCK5AKdefLtjsGN1YO
	 JRC7BgDya5bWPAshfITWulQsTtpcaunELwn298eTU3sXk1ob9Qt9ZmyV1k/LO0bdaR
	 WcP2gSOkEd9niuiyizGwmQCLXwe8cTVxtUr6/nX+rEf4uFJJPQd6qCOnaoK+jQhb6I
	 vWYllAHNWiYgRNCUKw7T/tEZtf3s66lkCccJ6/9GqaW8mOIUnkicjUsIhu0ZpJ0MNU
	 o8bd21ZdLtfqQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A4E637821D8;
	Thu,  6 Jun 2024 07:34:42 +0000 (UTC)
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
Subject: [PATCH v18 7/7] f2fs: Move CONFIG_UNICODE defguards into the code flow
Date: Thu,  6 Jun 2024 10:33:53 +0300
Message-Id: <20240606073353.47130-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.10-rc1]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/namei.c | 10 ++++------
 fs/f2fs/super.c |  8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e54f8c08bda8..1ecde2b45e99 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -576,8 +576,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -586,7 +585,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		trace_f2fs_lookup_end(dir, dentry, ino, err);
 		return NULL;
 	}
-#endif
+
 	new = d_splice_alias(inode, dentry);
 	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
 				ino, IS_ERR(new) ? PTR_ERR(new) : err);
@@ -639,16 +638,15 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at f2fs_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
+
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f1b3647a998..df4cf31f93df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -321,7 +321,7 @@ struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
-							F2FS_NAME_LEN);
+						   F2FS_NAME_LEN);
 	return f2fs_cf_name_slab ? 0 : -ENOMEM;
 }
 
@@ -1326,13 +1326,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (f2fs_sb_has_casefold(sbi)) {
+
+	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
-#endif
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
-- 
2.34.1


