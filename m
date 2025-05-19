Return-Path: <linux-fsdevel+bounces-49388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D65ABBA6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CCE164C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDA1EFFB7;
	Mon, 19 May 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hLYZSdTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369C22339;
	Mon, 19 May 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648669; cv=none; b=op3bdUfBTinJAZodZWbLuvLZv9wUxzDwcP/MQyeb4ytcs2BovpXJGcyAh0Vuqhe75a5m+Ikm3wUZNb7M6O5vyJL0/WDErqRkrauIenHADgaUc+WATzvLX+tl+ey73BuUn6oXNjkheNghHffPLw5HK6QqyqP0ee8ZemWvcutHpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648669; c=relaxed/simple;
	bh=HLha9xRI5pvss0EaDr0J9AREHPgtRsrauXR6teBEEV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gx/9zKviSZnwmMbijs7qNfwA28HtMe2crO/LYNwAAqRugLVHhv7ajXBwNF6mvP/n9afzGyQ/VPnBF7H79DEIuG/ojsiLjbojTQWFoQsWf6CMaFBT6PRYIV10NfHvYCGi5fOY2vUUfKlz+4TzaWmp2lbl4HdxIfcW0JUHa6lKCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=hLYZSdTJ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2C095241;
	Mon, 19 May 2025 09:47:40 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=hLYZSdTJ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8FF7F2194;
	Mon, 19 May 2025 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1747648071;
	bh=rGbbeS8sVLc/DotY5+25Ybg//jmIEKuMJKh3NadtSkE=;
	h=From:To:CC:Subject:Date;
	b=hLYZSdTJZrXgKLeHCyMFsNipIyk6fas5Bm1MdLYEVxf+VmyAEJEyoK47qX4ZQN+TA
	 3c5x/A4NOE+52Nio+sfyiuEsDC+5g1SKYGpqlwy32Ly6Htbhibj6c4txUc9/BXvnS6
	 0g9ZQIHYiGQQG04aSxLamypoLpT+FXS0OCui9keQ=
Received: from localhost.localdomain (172.30.20.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 19 May 2025 12:47:50 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: remove ability to change compression on mounted volume
Date: Mon, 19 May 2025 11:47:41 +0200
Message-ID: <20250519094741.7136-1-almaz.alexandrovich@paragon-software.com>
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

Remove all the code related to changing compression on the fly because
it's not safe and not maintainable.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 72 --------------------------------------
 fs/ntfs3/file.c    | 87 ----------------------------------------------
 fs/ntfs3/frecord.c | 74 ---------------------------------------
 fs/ntfs3/namei.c   |  2 --
 fs/ntfs3/ntfs_fs.h |  5 ---
 5 files changed, 240 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e946f75eb540..eced9013a881 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2605,75 +2605,3 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 
 	return err;
 }
-
-/*
- * Change the compression of data attribute
- */
-int attr_set_compress(struct ntfs_inode *ni, bool compr)
-{
-	struct ATTRIB *attr;
-	struct mft_inode *mi;
-
-	attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, &mi);
-	if (!attr)
-		return -ENOENT;
-
-	if (is_attr_compressed(attr) == !!compr) {
-		/* Already required compressed state. */
-		return 0;
-	}
-
-	if (attr->non_res) {
-		u16 run_off;
-		u32 run_size;
-		char *run;
-
-		if (attr->nres.data_size) {
-			/*
-			 * There are rare cases when it possible to change
-			 * compress state without big changes.
-			 * TODO: Process these cases.
-			 */
-			return -EOPNOTSUPP;
-		}
-
-		run_off = le16_to_cpu(attr->nres.run_off);
-		run_size = le32_to_cpu(attr->size) - run_off;
-		run = Add2Ptr(attr, run_off);
-
-		if (!compr) {
-			/* remove field 'attr->nres.total_size'. */
-			memmove(run - 8, run, run_size);
-			run_off -= 8;
-		}
-
-		if (!mi_resize_attr(mi, attr, compr ? +8 : -8)) {
-			/*
-			 * Ignore rare case when there are no 8 bytes in record with attr.
-			 * TODO: split attribute.
-			 */
-			return -EOPNOTSUPP;
-		}
-
-		if (compr) {
-			/* Make a gap for 'attr->nres.total_size'. */
-			memmove(run + 8, run, run_size);
-			run_off += 8;
-			attr->nres.total_size = attr->nres.alloc_size;
-		}
-		attr->nres.run_off = cpu_to_le16(run_off);
-	}
-
-	/* Update attribute flags. */
-	if (compr) {
-		attr->flags &= ~ATTR_FLAG_SPARSED;
-		attr->flags |= ATTR_FLAG_COMPRESSED;
-		attr->nres.c_unit = NTFS_LZNT_CUNIT;
-	} else {
-		attr->flags &= ~ATTR_FLAG_COMPRESSED;
-		attr->nres.c_unit = 0;
-	}
-	mi->dirty = true;
-
-	return 0;
-}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9b6a3f8d2e7c..34ed242e1063 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -49,90 +49,6 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 	return 0;
 }
 
-/*
- * ntfs_fileattr_get - inode_operations::fileattr_get
- */
-int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-	struct ntfs_inode *ni = ntfs_i(inode);
-	u32 flags = 0;
-
-	if (inode->i_flags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-
-	if (inode->i_flags & S_APPEND)
-		flags |= FS_APPEND_FL;
-
-	if (is_compressed(ni))
-		flags |= FS_COMPR_FL;
-
-	if (is_encrypted(ni))
-		flags |= FS_ENCRYPT_FL;
-
-	fileattr_fill_flags(fa, flags);
-
-	return 0;
-}
-
-/*
- * ntfs_fileattr_set - inode_operations::fileattr_set
- */
-int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		      struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-	struct ntfs_inode *ni = ntfs_i(inode);
-	u32 flags = fa->flags;
-	unsigned int new_fl = 0;
-
-	if (fileattr_has_fsx(fa))
-		return -EOPNOTSUPP;
-
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_COMPR_FL))
-		return -EOPNOTSUPP;
-
-	if (flags & FS_IMMUTABLE_FL)
-		new_fl |= S_IMMUTABLE;
-
-	if (flags & FS_APPEND_FL)
-		new_fl |= S_APPEND;
-
-	/* Allowed to change compression for empty files and for directories only. */
-	if (!is_dedup(ni) && !is_encrypted(ni) &&
-	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		int err = 0;
-		struct address_space *mapping = inode->i_mapping;
-
-		/* write out all data and wait. */
-		filemap_invalidate_lock(mapping);
-		err = filemap_write_and_wait(mapping);
-
-		if (err >= 0) {
-			/* Change compress state. */
-			bool compr = flags & FS_COMPR_FL;
-			err = ni_set_compress(inode, compr);
-
-			/* For files change a_ops too. */
-			if (!err)
-				mapping->a_ops = compr ? &ntfs_aops_cmpr :
-							 &ntfs_aops;
-		}
-
-		filemap_invalidate_unlock(mapping);
-
-		if (err)
-			return err;
-	}
-
-	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
-
-	inode_set_ctime_current(inode);
-	mark_inode_dirty(inode);
-
-	return 0;
-}
-
 /*
  * ntfs_ioctl - file_operations::unlocked_ioctl
  */
@@ -430,7 +346,6 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
-		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
@@ -1409,8 +1324,6 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
-	.fileattr_get	= ntfs_fileattr_get,
-	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b7a83200f2cc..756e1306fe6c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3327,77 +3327,3 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 
 	return 0;
 }
-
-/*
- * ni_set_compress
- *
- * Helper for 'ntfs_fileattr_set'.
- * Changes compression for empty files and directories only.
- */
-int ni_set_compress(struct inode *inode, bool compr)
-{
-	int err;
-	struct ntfs_inode *ni = ntfs_i(inode);
-	struct ATTR_STD_INFO *std;
-	const char *bad_inode;
-
-	if (is_compressed(ni) == !!compr)
-		return 0;
-
-	if (is_sparsed(ni)) {
-		/* sparse and compress not compatible. */
-		return -EOPNOTSUPP;
-	}
-
-	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
-		/*Skip other inodes. (symlink,fifo,...) */
-		return -EOPNOTSUPP;
-	}
-
-	bad_inode = NULL;
-
-	ni_lock(ni);
-
-	std = ni_std(ni);
-	if (!std) {
-		bad_inode = "no std";
-		goto out;
-	}
-
-	if (S_ISREG(inode->i_mode)) {
-		err = attr_set_compress(ni, compr);
-		if (err) {
-			if (err == -ENOENT) {
-				/* Fix on the fly? */
-				/* Each file must contain data attribute. */
-				bad_inode = "no data attribute";
-			}
-			goto out;
-		}
-	}
-
-	ni->std_fa = std->fa;
-	if (compr) {
-		std->fa &= ~FILE_ATTRIBUTE_SPARSE_FILE;
-		std->fa |= FILE_ATTRIBUTE_COMPRESSED;
-	} else {
-		std->fa &= ~FILE_ATTRIBUTE_COMPRESSED;
-	}
-
-	if (ni->std_fa != std->fa) {
-		ni->std_fa = std->fa;
-		ni->mi.dirty = true;
-	}
-	/* update duplicate information and directory entries in ni_write_inode.*/
-	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
-	err = 0;
-
-out:
-	ni_unlock(ni);
-	if (bad_inode) {
-		ntfs_bad_inode(inode, bad_inode);
-		err = -EINVAL;
-	}
-
-	return err;
-}
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 652735a0b0c4..b807744fc6a9 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -507,8 +507,6 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
-	.fileattr_get	= ntfs_fileattr_get,
-	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d628977e2556..36b8052660d5 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -454,7 +454,6 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size);
 int attr_force_nonresident(struct ntfs_inode *ni);
-int attr_set_compress(struct ntfs_inode *ni, bool compr);
 
 /* Functions from attrlist.c */
 void al_destroy(struct ntfs_inode *ni);
@@ -497,9 +496,6 @@ extern const struct file_operations ntfs_dir_operations;
 extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
-int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		      struct fileattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
@@ -585,7 +581,6 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	      bool *is_bad);
 
 bool ni_is_dirty(struct inode *inode);
-int ni_set_compress(struct inode *inode, bool compr);
 
 /* Globals from fslog.c */
 bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
-- 
2.43.0


