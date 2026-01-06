Return-Path: <linux-fsdevel+bounces-72503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97585CF887E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF5F30EA2C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5F33032F;
	Tue,  6 Jan 2026 13:25:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214E331206
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705940; cv=none; b=qZ2j2CP6YRVbPzGYhHXmoqbR/MIadMI1imnp1y8Q+iGzEcXbVLlHmRmfi7brxpzTlgXMoyycmev9v7Hm65JjKjD6UPyvfDFSVPVWrVY2BgBK+SbKKhIHoh4KwndbavqJdGYiddu3/bdeAs3e9S/OsJRkhmM8IzbZ8GlDbsqteCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705940; c=relaxed/simple;
	bh=l7111KH+2gJsvzXtqwzURcWGGNuKtLrLjTIaEbwMagA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJ0IY6M/GK1ILKwkusWN/gFoYtEUcMoLo3EzHruRkbXnIWN+XtUMEe3DA2KspMMhvoTJ7/AlTKSMiiLlj5INWRLRS5Put4gv2wkPrTf0wEsw6nSsFjvquqeVpncvL2sPsn2nMHBgUIauPuRvaFocziesY8mNj9M8Hsvns53TKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1060075b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767705937; x=1768310737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2IIqWSlCxaEQELx0gVhCezJOR2HmRjSbONTvJvt6WE=;
        b=A+1fhBBpFQbqYF39YJnhCfUVAG9Yd0mpeVN82EQy6L/8kd8dD2TTdceu2l1MhzbzmI
         EsZ4JdtCy3Aj7SR+ElJP4v73Dbrjn3IwQwxUN1yAzGAGAWH2tnt+0AkCqCAzgiFIjhD5
         f7m2un82/KJbsd55D1v7YebLxJfT+T76drT+EjYg4JW5JM2V7d58i542uAU/myhBEUrQ
         VRnn2wTRABzAsHks6mzQeZNiMfGsnqksSGfU2k0pcqiLV9ifgJKGK34wbWgDUNLm1Kgt
         tf4cfcj47YJacu0XIL4hT7qcJRa0vFwyi3/M8arWKgOZW8Gzr5WQSAanTEZ/YIH0IgFQ
         VgKQ==
X-Gm-Message-State: AOJu0YzINqNSROXXHHAP2NsFsEOJFuw00PXs9M0Qujvcbb7ToZWX6G4f
	Pv3OFfL84AQkr1/RQOIQcWyaaf044H39qgXQ+ZkStlkSb+OV0l1J+Nga
X-Gm-Gg: AY/fxX4qQw3zTABZDsHR4oODAdT1ozYzCI8FWg2pL03/9OEo9izijeK2/oe7nV+6Vd/
	A8R9qbYy6RCXvTY25TCoYifyYQmsnwp7oaJIXU6+M3IoLg9C8zyyjLDR25qUtTW+/MpWSlXXL2m
	S6Y7gwMEz+Sv72Yz3T9XbRnywF7OUIQu9u9Aj+UYMVsT0XRDMlAOtPi6E6GFPInL1JvcS6o8t3W
	66M/pAIKkMRa3+OxvYkqX5Dnx3KOh2iZN6N4cxmw4nUCS0ExHarFPb2Fw3ywiBd3s14pIWnuKlc
	Pp7yv723P5KhPqJLszduC7Vu1bf4ga58+XCQkVo2nHybJqN3fx7MfCYTuu83pW4hNsQElB4PBhs
	+Z93Wqn1TLy5vGZMz0j7oLKCJSTqFCuCMZ31ffhM3HKWUjqc6WN6yUO+HuRJ6NC41IFRws7FixU
	62X7aRZ768LlVVUQhcRe1g+H13eA==
X-Google-Smtp-Source: AGHT+IEx0elFD7CoNSXqziG9w9zeif62/B1E4ll8ibBooLUxvF+NZvfAzkwi4W2gp2J2uo8uU2bekA==
X-Received: by 2002:a05:6a20:938e:b0:35f:c643:105e with SMTP id adf61e73a8af0-3898230a600mr2707998637.34.1767705937463;
        Tue, 06 Jan 2026 05:25:37 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5c66sm2409570a12.24.2026.01.06.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:25:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 12/14] ntfs3: remove legacy ntfs driver support
Date: Tue,  6 Jan 2026 22:11:08 +0900
Message-Id: <20260106131110.46687-13-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106131110.46687-1-linkinjeon@kernel.org>
References: <20260106131110.46687-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reverts the following commits that introduced legacy ntfs
driver alias and related support code:

74871791ffa9 ntfs3: serve as alias for the legacy ntfs driver
1ff2e956608c fs/ntfs3: Redesign legacy ntfs support
9b872cc50daa ntfs3: add legacy ntfs file operations
d55f90e9b243 ntfs3: enforce read-only when used as legacy ntfs driver

The legacy ntfs driver has been remade as a new implementation, so the
alias and related codes in ntfs3 are no longer needed.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs3/Kconfig   |  9 --------
 fs/ntfs3/dir.c     |  9 --------
 fs/ntfs3/file.c    | 10 ---------
 fs/ntfs3/inode.c   | 16 ++++----------
 fs/ntfs3/ntfs_fs.h | 11 ----------
 fs/ntfs3/super.c   | 52 ----------------------------------------------
 6 files changed, 4 insertions(+), 103 deletions(-)

diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index 7bc31d69f680..cdfdf51e55d7 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -46,12 +46,3 @@ config NTFS3_FS_POSIX_ACL
 	  NOTE: this is linux only feature. Windows will ignore these ACLs.
 
 	  If you don't know what Access Control Lists are, say N.
-
-config NTFS_FS
-	tristate "NTFS file system support"
-	select NTFS3_FS
-	select BUFFER_HEAD
-	select NLS
-	help
-	  This config option is here only for backward compatibility. NTFS
-	  filesystem is now handled by the NTFS3 driver.
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index b98e95d6b4d9..fc39e7330365 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -631,13 +631,4 @@ const struct file_operations ntfs_dir_operations = {
 	.compat_ioctl   = ntfs_compat_ioctl,
 #endif
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_dir_operations = {
-	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
-	.iterate_shared	= ntfs_readdir,
-	.open		= ntfs_file_open,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..0faa856fc470 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1478,14 +1478,4 @@ const struct file_operations ntfs_file_operations = {
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_file_operations = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= ntfs_file_read_iter,
-	.splice_read	= ntfs_file_splice_read,
-	.open		= ntfs_file_open,
-	.release	= ntfs_file_release,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0a9ac5efeb67..826840c257d3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -444,9 +444,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		 * Usually a hard links to directories are disabled.
 		 */
 		inode->i_op = &ntfs_dir_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_dir_operations :
-				       &ntfs_dir_operations;
+		inode->i_fop = &ntfs_dir_operations;
 		ni->i_valid = 0;
 	} else if (S_ISLNK(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
@@ -456,9 +454,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	} else if (S_ISREG(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_file_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_file_operations :
-				       &ntfs_file_operations;
+		inode->i_fop = &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		if (ino != MFT_REC_MFT)
@@ -1590,9 +1586,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (S_ISDIR(mode)) {
 		inode->i_op = &ntfs_dir_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_dir_operations :
-				       &ntfs_dir_operations;
+		inode->i_fop = &ntfs_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
@@ -1601,9 +1595,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
 		inode->i_op = &ntfs_file_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_file_operations :
-				       &ntfs_file_operations;
+		inode->i_fop = &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		init_rwsem(&ni->file.run_lock);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a4559c9f64e6..326644d23110 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -501,7 +501,6 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 			   struct ntfs_fnd *fnd);
 bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
-extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
@@ -516,7 +515,6 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg);
 extern const struct inode_operations ntfs_special_inode_operations;
 extern const struct inode_operations ntfs_file_inode_operations;
 extern const struct file_operations ntfs_file_operations;
-extern const struct file_operations ntfs_legacy_file_operations;
 
 /* Globals from frecord.c */
 void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
@@ -1160,13 +1158,4 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
 	*var = cpu_to_le64(le64_to_cpu(*var) - val);
 }
 
-#if IS_ENABLED(CONFIG_NTFS_FS)
-bool is_legacy_ntfs(struct super_block *sb);
-#else
-static inline bool is_legacy_ntfs(struct super_block *sb)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_NTFS3_NTFS_FS_H */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72..d6fd14c191a9 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -415,12 +415,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 	struct ntfs_mount_options *new_opts = fc->fs_private;
 	int ro_rw;
 
-	/* If ntfs3 is used as legacy ntfs enforce read-only mode. */
-	if (is_legacy_ntfs(sb)) {
-		fc->sb_flags |= SB_RDONLY;
-		goto out;
-	}
-
 	ro_rw = sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
 	if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
 		errorf(fc,
@@ -447,7 +441,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 		return -EINVAL;
 	}
 
-out:
 	sync_filesystem(sb);
 	swap(sbi->options, fc->fs_private);
 
@@ -1670,8 +1663,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	ntfs_create_procdir(sb);
 
-	if (is_legacy_ntfs(sb))
-		sb->s_flags |= SB_RDONLY;
 	return 0;
 
 put_inode_out:
@@ -1876,47 +1867,6 @@ static struct file_system_type ntfs_fs_type = {
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 
-#if IS_ENABLED(CONFIG_NTFS_FS)
-static int ntfs_legacy_init_fs_context(struct fs_context *fc)
-{
-	int ret;
-
-	ret = __ntfs_init_fs_context(fc);
-	/* If ntfs3 is used as legacy ntfs enforce read-only mode. */
-	fc->sb_flags |= SB_RDONLY;
-	return ret;
-}
-
-static struct file_system_type ntfs_legacy_fs_type = {
-	.owner			= THIS_MODULE,
-	.name			= "ntfs",
-	.init_fs_context	= ntfs_legacy_init_fs_context,
-	.parameters		= ntfs_fs_parameters,
-	.kill_sb		= ntfs3_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
-};
-MODULE_ALIAS_FS("ntfs");
-
-static inline void register_as_ntfs_legacy(void)
-{
-	int err = register_filesystem(&ntfs_legacy_fs_type);
-	if (err)
-		pr_warn("ntfs3: Failed to register legacy ntfs filesystem driver: %d\n", err);
-}
-
-static inline void unregister_as_ntfs_legacy(void)
-{
-	unregister_filesystem(&ntfs_legacy_fs_type);
-}
-bool is_legacy_ntfs(struct super_block *sb)
-{
-	return sb->s_type == &ntfs_legacy_fs_type;
-}
-#else
-static inline void register_as_ntfs_legacy(void) {}
-static inline void unregister_as_ntfs_legacy(void) {}
-#endif
-
 // clang-format on
 
 static int __init init_ntfs_fs(void)
@@ -1945,7 +1895,6 @@ static int __init init_ntfs_fs(void)
 		goto out1;
 	}
 
-	register_as_ntfs_legacy();
 	err = register_filesystem(&ntfs_fs_type);
 	if (err)
 		goto out;
@@ -1965,7 +1914,6 @@ static void __exit exit_ntfs_fs(void)
 	rcu_barrier();
 	kmem_cache_destroy(ntfs_inode_cachep);
 	unregister_filesystem(&ntfs_fs_type);
-	unregister_as_ntfs_legacy();
 	ntfs3_exit_bitmap();
 	ntfs_remove_proc_root();
 }
-- 
2.25.1


