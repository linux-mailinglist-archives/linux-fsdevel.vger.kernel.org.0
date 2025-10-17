Return-Path: <linux-fsdevel+bounces-64450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E5BE8095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899025678D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD65311979;
	Fri, 17 Oct 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="KTn18YvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BF30F931;
	Fri, 17 Oct 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696287; cv=none; b=oaOG/y2KSc8xbKruwTvjvn+uCruiffXdmy+Jq2nB8W07us49lo4hBn9QMcPP4xBhIDhx728KMoslQc8m4mhT1QLoTnTd5oTRc3sgjlJFHCwrwzz1C15ckjf5VbijiI7hI+9upz+6Ajj0ELwG+IfjQMaTJdptLh5wV6C2ABhpURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696287; c=relaxed/simple;
	bh=3Df7CyvAxnI9HxCcLYwM+Vg6ITAM4z29AKwEm7pnrY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKbKgvmiC9mnX9lkADAUX6Wf1j8acdRPSWd80Bg6smjZwFacCXo24i+ZdkfYhHy8DCBWCH64wdr0Y77nGOyX9fqic1QYHvR1A4/wFzJUOQG8J3EYTp59qKb/vCKQStga9O7jTtxh0V9UIqGiACZzvLZUH7J/UyJHmi+LFQtAEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=KTn18YvL; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 483021D24;
	Fri, 17 Oct 2025 10:15:08 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=KTn18YvL;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C0B1A2421;
	Fri, 17 Oct 2025 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1760696282;
	bh=x33vq9JJUd0pZ0LYTsA42rcKn2H19xuQvmLQnuFD7Nw=;
	h=From:To:CC:Subject:Date;
	b=KTn18YvL7x9TqXU2+FMFfRBkhNZAFLIfL5zzC5r6EME49N4Diw8p8CKcYb6DbU7BL
	 10OsjSS3llAR1LrP3vYMm93X2RB2h1I+TaQdLLYHbqRKo9CbvB//ma7kJS/WJgwz7j
	 EB9hGSAW6UE9VPWRtC9LBK+VImeseyTf5fk4tgWg=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Oct 2025 13:18:00 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Reformat code and update terminology
Date: Fri, 17 Oct 2025 12:17:51 +0200
Message-ID: <20251017101751.5841-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Reformatted the driver code according to the current .clang-format rules
and updated description of used terminology. No functional changes
intended.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     |  3 +--
 fs/ntfs3/file.c    |  8 +++-----
 fs/ntfs3/frecord.c |  7 ++++---
 fs/ntfs3/inode.c   | 19 +++++++++++--------
 fs/ntfs3/namei.c   |  6 +++---
 fs/ntfs3/ntfs_fs.h |  6 +++---
 fs/ntfs3/super.c   | 31 +++++++++++++++++--------------
 7 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 1b5c865a0339..b98e95d6b4d9 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -332,8 +332,7 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
 	 * It does additional locks/reads just to get the type of name.
 	 * Should we use additional mount option to enable branch below?
 	 */
-	if (fname->dup.extend_data &&
-	    ino != ni->mi.rno) {
+	if (fname->dup.extend_data && ino != ni->mi.rno) {
 		struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
 		if (!IS_ERR_OR_NULL(inode)) {
 			dt_type = fs_umode_to_dtype(inode->i_mode);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..a9ba37758944 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -503,8 +503,6 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	if (dirty)
 		mark_inode_dirty(inode);
 
-	/*ntfs_flush_inodes(inode->i_sb, inode, NULL);*/
-
 	return 0;
 }
 
@@ -1114,8 +1112,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 			size_t cp, tail = PAGE_SIZE - off;
 
 			folio = page_folio(pages[ip]);
-			cp = copy_folio_from_iter_atomic(folio, off,
-							min(tail, bytes), from);
+			cp = copy_folio_from_iter_atomic(
+				folio, off, min(tail, bytes), from);
 			flush_dcache_folio(folio);
 
 			copied += cp;
@@ -1312,7 +1310,7 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	if (sbi->options->prealloc &&
 	    ((file->f_mode & FMODE_WRITE) &&
 	     atomic_read(&inode->i_writecount) == 1)
-	   /*
+	    /*
 	    * The only file when inode->i_fop = &ntfs_file_operations and
 	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
 	    *
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..c1c2ddaeb1e7 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3026,8 +3026,8 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	err = ni_add_name(new_dir_ni, ni, new_de);
 	if (!err) {
 		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
-		WARN_ON(err && ni_remove_name(new_dir_ni, ni, new_de, &de2,
-			&undo));
+		WARN_ON(err &&
+			ni_remove_name(new_dir_ni, ni, new_de, &de2, &undo));
 	}
 
 	/*
@@ -3127,7 +3127,8 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (attr) {
 			const struct REPARSE_POINT *rp;
 
-			rp = resident_data_ex(attr, sizeof(struct REPARSE_POINT));
+			rp = resident_data_ex(attr,
+					      sizeof(struct REPARSE_POINT));
 			/* If ATTR_REPARSE exists 'rp' can't be NULL. */
 			if (rp)
 				dup->extend_data = rp->ReparseTag;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..b741a697e572 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -975,9 +975,9 @@ int ntfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 /*
  * ntfs_write_end - Address_space_operations::write_end.
  */
-int ntfs_write_end(const struct kiocb *iocb,
-		   struct address_space *mapping, loff_t pos,
-		   u32 len, u32 copied, struct folio *folio, void *fsdata)
+int ntfs_write_end(const struct kiocb *iocb, struct address_space *mapping,
+		   loff_t pos, u32 len, u32 copied, struct folio *folio,
+		   void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
@@ -1099,7 +1099,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	typeof(rp->SymbolicLinkReparseBuffer) *rs;
 	bool is_absolute;
 
-	is_absolute = (strlen(symname) > 1 && symname[1] == ':');
+	is_absolute = symname[0] && symname[1] == ':';
 
 	rp = kzalloc(ntfs_reparse_bytes(2 * size + 2, is_absolute), GFP_NOFS);
 	if (!rp)
@@ -1136,17 +1136,19 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 
 	/* PrintName + SubstituteName. */
 	rs->SubstituteNameOffset = cpu_to_le16(sizeof(short) * err);
-	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + (is_absolute ? 8 : 0));
+	rs->SubstituteNameLength =
+		cpu_to_le16(sizeof(short) * err + (is_absolute ? 8 : 0));
 	rs->PrintNameLength = rs->SubstituteNameOffset;
 
 	/*
 	 * TODO: Use relative path if possible to allow Windows to
 	 * parse this path.
-	 * 0-absolute path 1- relative path (SYMLINK_FLAG_RELATIVE).
+	 * 0-absolute path, 1- relative path (SYMLINK_FLAG_RELATIVE).
 	 */
 	rs->Flags = cpu_to_le32(is_absolute ? 0 : SYMLINK_FLAG_RELATIVE);
 
-	memmove(rp_name + err + (is_absolute ? 4 : 0), rp_name, sizeof(short) * err);
+	memmove(rp_name + err + (is_absolute ? 4 : 0), rp_name,
+		sizeof(short) * err);
 
 	if (is_absolute) {
 		/* Decorate SubstituteName. */
@@ -1635,7 +1637,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		 * Use ni_find_attr cause layout of MFT record may be changed
 		 * in ntfs_init_acl and ntfs_save_wsl_perm.
 		 */
-		attr = ni_find_attr(ni, NULL, NULL, ATTR_NAME, NULL, 0, NULL, NULL);
+		attr = ni_find_attr(ni, NULL, NULL, ATTR_NAME, NULL, 0, NULL,
+				    NULL);
 		if (attr) {
 			struct ATTR_FILE_NAME *fn;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 82c8ae56beee..3b24ca02de61 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -207,13 +207,13 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /*
- * ntfs_mkdir- inode_operations::mkdir
+ * ntfs_mkdir - inode_operations::mkdir
  */
 static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
-	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
-					 NULL, 0, NULL));
+	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL,
+					 S_IFDIR | mode, 0, NULL, 0, NULL));
 }
 
 /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2649fbe16669..6a7594d3f3eb 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -584,7 +584,8 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		struct NTFS_DE *de);
 
 int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
-	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de);
+	      struct ntfs_inode *ni, struct NTFS_DE *de,
+	      struct NTFS_DE *new_de);
 
 bool ni_is_dirty(struct inode *inode);
 
@@ -709,8 +710,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size);
 int ntfs_get_block(struct inode *inode, sector_t vbn,
 		   struct buffer_head *bh_result, int create);
 int ntfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
-		     loff_t pos, u32 len, struct folio **foliop,
-		     void **fsdata);
+		     loff_t pos, u32 len, struct folio **foliop, void **fsdata);
 int ntfs_write_end(const struct kiocb *iocb, struct address_space *mapping,
 		   loff_t pos, u32 len, u32 copied, struct folio *folio,
 		   void *fsdata);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ddff94c091b8..9f69316d77b6 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -16,6 +16,13 @@
  * mi  - MFT inode               - One MFT record(usually 1024 bytes or 4K), consists of attributes.
  * ni  - NTFS inode              - Extends linux inode. consists of one or more mft inodes.
  * index - unit inside directory - 2K, 4K, <=page size, does not depend on cluster size.
+ * resident attribute            - Attribute with content stored directly in the MFT record
+ * non-resident attribute        - Attribute with content stored in clusters
+ * data_size                     - Size of attribute content in bytes. Equal to inode->i_size
+ * valid_size                    - Number of bytes written to the non-resident attribute
+ * allocated_size                - Total size of clusters allocated for non-resident content
+ * total_size                    - Actual size of allocated clusters for sparse or compressed attributes
+ *                               - Constraint: valid_size <= data_size <= allocated_size
  *
  * WSL - Windows Subsystem for Linux
  * https://docs.microsoft.com/en-us/windows/wsl/file-permissions
@@ -288,10 +295,8 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 /*
  * Load nls table or if @nls is utf8 then return NULL.
  *
- * It is good idea to use here "const char *nls".
- * But load_nls accepts "char*".
  */
-static struct nls_table *ntfs_load_nls(char *nls)
+static struct nls_table *ntfs_load_nls(const char *nls)
 {
 	struct nls_table *ret;
 
@@ -566,10 +571,8 @@ static void ntfs_create_procdir(struct super_block *sb)
 	if (e) {
 		struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-		proc_create_data("volinfo", 0444, e,
-				 &ntfs3_volinfo_fops, sb);
-		proc_create_data("label", 0644, e,
-				 &ntfs3_label_fops, sb);
+		proc_create_data("volinfo", 0444, e, &ntfs3_volinfo_fops, sb);
+		proc_create_data("label", 0644, e, &ntfs3_label_fops, sb);
 		sbi->procdir = e;
 	}
 }
@@ -600,10 +603,12 @@ static void ntfs_remove_proc_root(void)
 	}
 }
 #else
-static void ntfs_create_procdir(struct super_block *sb) {}
-static void ntfs_remove_procdir(struct super_block *sb) {}
-static void ntfs_create_proc_root(void) {}
-static void ntfs_remove_proc_root(void) {}
+// clang-format off
+static void ntfs_create_procdir(struct super_block *sb){}
+static void ntfs_remove_procdir(struct super_block *sb){}
+static void ntfs_create_proc_root(void){}
+static void ntfs_remove_proc_root(void){}
+// clang-format on
 #endif
 
 static struct kmem_cache *ntfs_inode_cachep;
@@ -1223,8 +1228,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	if (options->nocase)
-		set_default_d_op(sb, &ntfs_dentry_ops);
+	set_default_d_op(sb, options->nocase ? &ntfs_dentry_ops : NULL);
 
 	options->nls = ntfs_load_nls(options->nls_name);
 	if (IS_ERR(options->nls)) {
@@ -1643,7 +1647,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 out:
 	ntfs3_put_sbi(sbi);
 	kfree(boot2);
-	ntfs3_put_sbi(sbi);
 	return err;
 }
 
-- 
2.43.0


