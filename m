Return-Path: <linux-fsdevel+bounces-17468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9D8ADDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518B61F22FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048F53384;
	Tue, 23 Apr 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="BN6tKBhY";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="srybzOEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF451C52;
	Tue, 23 Apr 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854728; cv=none; b=DYQ0XwuMm/Y85ogwDdv9odnxaeOGQ3HOoGK96j4ds+Y3tvlmSSsCvvzaglT2J/5ICekp7TnIalHm3Nsnqk8jQ/JDM/TxdQtGdQHW+S/GOArVZi2H65O8xM+8aO4zKWBh/sD5v6mczTrT2YcU8+/uTJjitrEvw2ZEb/nqvOvHGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854728; c=relaxed/simple;
	bh=OEvsy72w2/oHIHyWTeUFOvZzoFVDn27729yVj2nfqE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLDb3gvuAKnZezxgs4qBgQMRFa2tGaBZTjXzHqLRGN4h7RwKKot7BKDoOZ+8FZxkYVTyy1HuUQy7I7wbhL94+RspiYjBWE2oaollosXdHotyaOpouuHth9IqIODkTPOQELq+pSgg13EP9gkYNp359fTlIH6g+ZchVrUrIr8cmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=BN6tKBhY; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=srybzOEg; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5B2541F9F;
	Tue, 23 Apr 2024 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854272;
	bh=WYhMvnTLAQTUHZ0POkyI6ill1C+PyV1o7dPY2X+1+50=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BN6tKBhYFyRWc6HoWwY/eWu7rOZuExi9R29wC2U7P71BzzCZh1AIIDz7Sy4JbYG+C
	 CMXQyihmcimUGfuf+lu1xrZS86LDI28I+3gdIGf6ipH6GjehPMDEODA3Vklr+7j/Kr
	 vY5OJoTwMRsXPtpqgFn71drVDKECd5wN1FADT25U=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1F54B214E;
	Tue, 23 Apr 2024 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854724;
	bh=WYhMvnTLAQTUHZ0POkyI6ill1C+PyV1o7dPY2X+1+50=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=srybzOEghBD/m1cvyaiYx8dKlYqVGsFAo3QVocISdPbpUab0s0OB6nFNx9fhAv1hn
	 EJYleJJPFJ/q8VGjFvjX3zXCr57+Ejt7nxC6bXpLrfRhPfT9kBj5IMs/SA1NOnkxRz
	 xeXLZDUS6QGK4zdCiuc/Pchs9ztliu+yJIiQZsGU=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:23 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Al Viro
	<viro@zeniv.linux.org.uk>
Subject: [PATCH 7/9] fs/ntfs3: Redesign ntfs_create_inode to return error code instead of inode
Date: Tue, 23 Apr 2024 09:44:26 +0300
Message-ID: <20240423064428.8289-8-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
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

As Al Viro correctly pointed out, there is no need to return
the whole structure to check the error.
https://lore.kernel.org/ntfs3/20240322023515.GK538574@ZenIV/

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c   | 22 +++++++++++-----------
 fs/ntfs3/namei.c   | 31 ++++++++-----------------------
 fs/ntfs3/ntfs_fs.h |  9 ++++-----
 3 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 502a527e51cd..8fdcf37b3186 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1216,11 +1216,10 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
  *
  * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
  */
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
-				struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd)
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd)
 {
 	int err;
 	struct super_block *sb = dir->i_sb;
@@ -1245,6 +1244,9 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	struct REPARSE_DATA_BUFFER *rp = NULL;
 	bool rp_inserted = false;
 
+	/* New file will be resident or non resident. */
+	const bool new_file_resident = 1;
+
 	if (!fnd)
 		ni_lock_dir(dir_ni);
 
@@ -1484,7 +1486,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		attr->size = cpu_to_le32(SIZEOF_RESIDENT);
 		attr->name_off = SIZEOF_RESIDENT_LE;
 		attr->res.data_off = SIZEOF_RESIDENT_LE;
-	} else if (S_ISREG(mode)) {
+	} else if (!new_file_resident && S_ISREG(mode)) {
 		/*
 		 * Regular file. Create empty non resident data attribute.
 		 */
@@ -1721,12 +1723,10 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fnd)
 		ni_unlock(dir_ni);
 
-	if (err)
-		return ERR_PTR(err);
-
-	unlock_new_inode(inode);
+	if (!err)
+		unlock_new_inode(inode);
 
-	return inode;
+	return err;
 }
 
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index edb6a7141246..71498421ce60 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -107,12 +107,8 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
-				  NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
+				 NULL, 0, NULL);
 }
 
 /*
@@ -123,12 +119,8 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, NULL, 0,
-				  NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, NULL, 0,
+				 NULL);
 }
 
 /*
@@ -200,15 +192,12 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	u32 size = strlen(symname);
-	struct inode *inode;
 
 	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
-				  symname, size, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
+				 symname, size, NULL);
 }
 
 /*
@@ -217,12 +206,8 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
-				  NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
+				 NULL, 0, NULL);
 }
 
 /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 79356fd29a14..3db6a61f61dc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -714,11 +714,10 @@ int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
 int inode_write_data(struct inode *inode, const void *data, size_t bytes);
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
-				struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd);
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd);
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry);
 int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry);
 void ntfs_evict_inode(struct inode *inode);
-- 
2.34.1


