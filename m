Return-Path: <linux-fsdevel+bounces-17137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB298A83CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52B51F2110E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DB13D60E;
	Wed, 17 Apr 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="dQxfV0hr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C47D071;
	Wed, 17 Apr 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359244; cv=none; b=o6GrxWJ4eLsCbEEp9TGuNcH5mx00h6RbTzTU7gq6SOlkO4pII/qU3Z/oZfFfBnOYbqeErunvJ/aUJv/FY2gu8o4TDnIa/ApjJMWc/j0HJJ0lFZSdOSM+T4SD1BxmZyYDYEB2y8XqZAiZ0eD/VuIFr2OwGYeoK4FntxBc/I1I88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359244; c=relaxed/simple;
	bh=z0IW3/Brxpfkh18MS9+cTaxXo9NVdBoBJ3n5eEgmBjM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VV8aDs4vSZdCVDZP7HRaTWHtXQsQn0wQ8Sz0eLtLDZarG+XzkSiwIFCMjD/GT3S7UBwSrdoX7SnyiGzg6PC0s750Ys8cl8Umq2KE3OLA1QjXlKxkE/swOnO3aCacz+4GW1OwTiRsCkRJQmsmG5TWRXeuZOLchyDc6hQUIEZZ6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=dQxfV0hr; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CEC6E2126;
	Wed, 17 Apr 2024 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358790;
	bh=+s6MrL/MryqHMryIwr1o1fGOI0TS7160OkRPd7Inyqg=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=dQxfV0hr+dNtRjMRJ3grudsr3sK5G3NrH0Fv0CHTXEs5+wsSk/7rco53658zI44gb
	 TPUz6tMEnL44M6kzO6jp8l3WMOGsnvrBO0zbR5rwDOEks5xLr/EOA69zoYWO682EOy
	 Q0pvareU23Hr6O6ycMeuQT/WQxAB3JPGEYdpZwBE=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:07:19 +0300
Message-ID: <d282dfd1-82d0-4eda-8b9d-7b762f62a3dc@paragon-software.com>
Date: Wed, 17 Apr 2024 16:07:18 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 06/11] fs/ntfs3: Redesign ntfs_create_inode to return error
 code instead of inode
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c   | 22 +++++++++++-----------
  fs/ntfs3/namei.c   | 31 ++++++++-----------------------
  fs/ntfs3/ntfs_fs.h |  9 ++++-----
  3 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..85a10d4a74c4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1210,11 +1210,10 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info 
*sbi, const char *symname,
   *
   * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
   */
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
-                struct dentry *dentry,
-                const struct cpu_str *uni, umode_t mode,
-                dev_t dev, const char *symname, u32 size,
-                struct ntfs_fnd *fnd)
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+              struct dentry *dentry, const struct cpu_str *uni,
+              umode_t mode, dev_t dev, const char *symname, u32 size,
+              struct ntfs_fnd *fnd)
  {
      int err;
      struct super_block *sb = dir->i_sb;
@@ -1239,6 +1238,9 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
      struct REPARSE_DATA_BUFFER *rp = NULL;
      bool rp_inserted = false;

+    /* New file will be resident or non resident. */
+    const bool new_file_resident = 1;
+
      if (!fnd)
          ni_lock_dir(dir_ni);

@@ -1478,7 +1480,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
          attr->size = cpu_to_le32(SIZEOF_RESIDENT);
          attr->name_off = SIZEOF_RESIDENT_LE;
          attr->res.data_off = SIZEOF_RESIDENT_LE;
-    } else if (S_ISREG(mode)) {
+    } else if (!new_file_resident && S_ISREG(mode)) {
          /*
           * Regular file. Create empty non resident data attribute.
           */
@@ -1715,12 +1717,10 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
      if (!fnd)
          ni_unlock(dir_ni);

-    if (err)
-        return ERR_PTR(err);
-
-    unlock_new_inode(inode);
+    if (!err)
+        unlock_new_inode(inode);

-    return inode;
+    return err;
  }

  int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index edb6a7141246..71498421ce60 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -107,12 +107,8 @@ static struct dentry *ntfs_lookup(struct inode 
*dir, struct dentry *dentry,
  static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
                 struct dentry *dentry, umode_t mode, bool excl)
  {
-    struct inode *inode;
-
-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
-                  NULL, 0, NULL);
-
-    return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+    return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
+                 NULL, 0, NULL);
  }

  /*
@@ -123,12 +119,8 @@ static int ntfs_create(struct mnt_idmap *idmap, 
struct inode *dir,
  static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
                struct dentry *dentry, umode_t mode, dev_t rdev)
  {
-    struct inode *inode;
-
-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, 
NULL, 0,
-                  NULL);
-
-    return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+    return ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, NULL, 0,
+                 NULL);
  }

  /*
@@ -200,15 +192,12 @@ static int ntfs_symlink(struct mnt_idmap *idmap, 
struct inode *dir,
              struct dentry *dentry, const char *symname)
  {
      u32 size = strlen(symname);
-    struct inode *inode;

      if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
          return -EIO;

-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
-                  symname, size, NULL);
-
-    return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+    return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
+                 symname, size, NULL);
  }

  /*
@@ -217,12 +206,8 @@ static int ntfs_symlink(struct mnt_idmap *idmap, 
struct inode *dir,
  static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
                struct dentry *dentry, umode_t mode)
  {
-    struct inode *inode;
-
-    inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
-                  NULL, 0, NULL);
-
-    return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+    return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
+                 NULL, 0, NULL);
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
-                struct dentry *dentry,
-                const struct cpu_str *uni, umode_t mode,
-                dev_t dev, const char *symname, u32 size,
-                struct ntfs_fnd *fnd);
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+              struct dentry *dentry, const struct cpu_str *uni,
+              umode_t mode, dev_t dev, const char *symname, u32 size,
+              struct ntfs_fnd *fnd);
  int ntfs_link_inode(struct inode *inode, struct dentry *dentry);
  int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry);
  void ntfs_evict_inode(struct inode *inode);
-- 
2.34.1


