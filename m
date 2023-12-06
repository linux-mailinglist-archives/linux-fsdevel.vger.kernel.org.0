Return-Path: <linux-fsdevel+bounces-5018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF15807538
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F61F2157A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAA487AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="eDwoUKNx";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Ku8/Redg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797FD5E;
	Wed,  6 Dec 2023 07:13:34 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8507D1E1A;
	Wed,  6 Dec 2023 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875228;
	bh=uJ8yXb35Y3nvlXGaUfbKb2hU6mLxvvg7KJ352HRIl1g=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=eDwoUKNxnC3Mgo5YqMg62nEwQlIzs9ZN6vkl1Oj/N6/RT0nvXp72F+JN+rfgOMvXZ
	 foAWQKxkFIIu8YklSD8zsvXh7Y6NfK7Y2fLZ8YkDkPMmdNYLJax5arNk3jQiZY1W5r
	 cPNFAPUzgIEbNaip/DtL7zgWlJgjCSwWstIw/ml0=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C75A42117;
	Wed,  6 Dec 2023 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875612;
	bh=uJ8yXb35Y3nvlXGaUfbKb2hU6mLxvvg7KJ352HRIl1g=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=Ku8/RedgSWDEvC1aHorRRbeFaxRRq9RroNtmTSCrs4SWXGRQM6g37ggHj/tEIDN7b
	 3EUjBCU0mnJo9y1wgCDSBcr/wdKVNjL3KM0gP50TDKsOV84HDSDA9jUQFNyBmpKVpy
	 Qr3UwRwAkk39i6GpMLxR/4D3cv1L7zyyfGVMbXNM=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:13:32 +0300
Message-ID: <4f013a0c-9f3f-4a4a-88fa-17460abd702e@paragon-software.com>
Date: Wed, 6 Dec 2023 18:13:32 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 12/16] fs/ntfs3: Implement super_operations::shutdown
Content-Language: en-US
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c    | 18 ++++++++++++++++++
  fs/ntfs3/frecord.c |  3 +++
  fs/ntfs3/inode.c   | 21 +++++++++++++++++++--
  fs/ntfs3/namei.c   | 12 ++++++++++++
  fs/ntfs3/ntfs_fs.h |  9 ++++++++-
  fs/ntfs3/super.c   | 12 ++++++++++++
  fs/ntfs3/xattr.c   |  3 +++
  7 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 0ff5d3af2889..07ed3d946e7c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -260,6 +260,9 @@ static int ntfs_file_mmap(struct file *file, struct 
vm_area_struct *vma)
      bool rw = vma->vm_flags & VM_WRITE;
      int err;

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      if (is_encrypted(ni)) {
          ntfs_inode_warn(inode, "mmap encrypted not supported");
          return -EOPNOTSUPP;
@@ -677,6 +680,9 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
      umode_t mode = inode->i_mode;
      int err;

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      err = setattr_prepare(idmap, dentry, attr);
      if (err)
          goto out;
@@ -732,6 +738,9 @@ static ssize_t ntfs_file_read_iter(struct kiocb 
*iocb, struct iov_iter *iter)
      struct inode *inode = file->f_mapping->host;
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      if (is_encrypted(ni)) {
          ntfs_inode_warn(inode, "encrypted i/o not supported");
          return -EOPNOTSUPP;
@@ -766,6 +775,9 @@ static ssize_t ntfs_file_splice_read(struct file 
*in, loff_t *ppos,
      struct inode *inode = in->f_mapping->host;
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      if (is_encrypted(ni)) {
          ntfs_inode_warn(inode, "encrypted i/o not supported");
          return -EOPNOTSUPP;
@@ -1058,6 +1070,9 @@ static ssize_t ntfs_file_write_iter(struct kiocb 
*iocb, struct iov_iter *from)
      int err;
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      if (is_encrypted(ni)) {
          ntfs_inode_warn(inode, "encrypted i/o not supported");
          return -EOPNOTSUPP;
@@ -1118,6 +1133,9 @@ int ntfs_file_open(struct inode *inode, struct 
file *file)
  {
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      if (unlikely((is_compressed(ni) || is_encrypted(ni)) &&
               (file->f_flags & O_DIRECT))) {
          return -EOPNOTSUPP;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3df2d9e34b91..8744ba36d422 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3259,6 +3259,9 @@ int ni_write_inode(struct inode *inode, int sync, 
const char *hint)
      if (is_bad_inode(inode) || sb_rdonly(sb))
          return 0;

+    if (unlikely(ntfs3_forced_shutdown(sb)))
+        return -EIO;
+
      if (!ni_trylock(ni)) {
          /* 'ni' is under modification, skip for now. */
          mark_inode_dirty_sync(inode);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bba0208c4afd..85452a6b1d40 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -852,9 +852,13 @@ static int ntfs_resident_writepage(struct folio *folio,
                     struct writeback_control *wbc, void *data)
  {
      struct address_space *mapping = data;
-    struct ntfs_inode *ni = ntfs_i(mapping->host);
+    struct inode *inode = mapping->host;
+    struct ntfs_inode *ni = ntfs_i(inode);
      int ret;

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      ni_lock(ni);
      ret = attr_data_write_resident(ni, &folio->page);
      ni_unlock(ni);
@@ -868,7 +872,12 @@ static int ntfs_resident_writepage(struct folio *folio,
  static int ntfs_writepages(struct address_space *mapping,
                 struct writeback_control *wbc)
  {
-    if (is_resident(ntfs_i(mapping->host)))
+    struct inode *inode = mapping->host;
+
+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
+    if (is_resident(ntfs_i(inode)))
          return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
                       mapping);
      return mpage_writepages(mapping, wbc, ntfs_get_block);
@@ -888,6 +897,9 @@ int ntfs_write_begin(struct file *file, struct 
address_space *mapping,
      struct inode *inode = mapping->host;
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      *pagep = NULL;
      if (is_resident(ni)) {
          struct page *page =
@@ -1305,6 +1317,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
          goto out1;
      }

+    if (unlikely(ntfs3_forced_shutdown(sb))) {
+        err = -EIO;
+        goto out2;
+    }
+
      /* Mark rw ntfs as dirty. it will be cleared at umount. */
      ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ee3093be5170..cae41db0aaa7 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -181,6 +181,9 @@ static int ntfs_unlink(struct inode *dir, struct 
dentry *dentry)
      struct ntfs_inode *ni = ntfs_i(dir);
      int err;

+    if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+        return -EIO;
+
      ni_lock_dir(ni);

      err = ntfs_unlink_inode(dir, dentry);
@@ -199,6 +202,9 @@ static int ntfs_symlink(struct mnt_idmap *idmap, 
struct inode *dir,
      u32 size = strlen(symname);
      struct inode *inode;

+    if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+        return -EIO;
+
      inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
                    symname, size, NULL);

@@ -227,6 +233,9 @@ static int ntfs_rmdir(struct inode *dir, struct 
dentry *dentry)
      struct ntfs_inode *ni = ntfs_i(dir);
      int err;

+    if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+        return -EIO;
+
      ni_lock_dir(ni);

      err = ntfs_unlink_inode(dir, dentry);
@@ -264,6 +273,9 @@ static int ntfs_rename(struct mnt_idmap *idmap, 
struct inode *dir,
                1024);
      static_assert(PATH_MAX >= 4 * 1024);

+    if (unlikely(ntfs3_forced_shutdown(sb)))
+        return -EIO;
+
      if (flags & ~RENAME_NOREPLACE)
          return -EINVAL;

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f6706143d14b..d40bc7669ae5 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -61,6 +61,8 @@ enum utf16_endian;

  /* sbi->flags */
  #define NTFS_FLAGS_NODISCARD        0x00000001
+/* ntfs in shutdown state. */
+#define NTFS_FLAGS_SHUTDOWN        0x00000002
  /* Set when LogFile is replaying. */
  #define NTFS_FLAGS_LOG_REPLAYING    0x00000008
  /* Set when we changed first MFT's which copy must be updated in 
$MftMirr. */
@@ -226,7 +228,7 @@ struct ntfs_sb_info {
      u64 maxbytes; // Maximum size for normal files.
      u64 maxbytes_sparse; // Maximum size for sparse file.

-    u32 flags; // See NTFS_FLAGS_XXX.
+    unsigned long flags; // See NTFS_FLAGS_

      CLST zone_max; // Maximum MFT zone length in clusters
      CLST bad_clusters; // The count of marked bad clusters.
@@ -999,6 +1001,11 @@ static inline struct ntfs_sb_info *ntfs_sb(struct 
super_block *sb)
      return sb->s_fs_info;
  }

+static inline bool ntfs3_forced_shutdown(struct super_block *sb)
+{
+    return test_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
  /*
   * ntfs_up_cluster - Align up on cluster boundary.
   */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 09d61c6c90aa..af8521a6ed95 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -714,6 +714,14 @@ static int ntfs_show_options(struct seq_file *m, 
struct dentry *root)
      return 0;
  }

+/*
+ * ntfs_shutdown - super_operations::shutdown
+ */
+static void ntfs_shutdown(struct super_block *sb)
+{
+    set_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
  /*
   * ntfs_sync_fs - super_operations::sync_fs
   */
@@ -724,6 +732,9 @@ static int ntfs_sync_fs(struct super_block *sb, int 
wait)
      struct ntfs_inode *ni;
      struct inode *inode;

+    if (unlikely(ntfs3_forced_shutdown(sb)))
+        return -EIO;
+
      ni = sbi->security.ni;
      if (ni) {
          inode = &ni->vfs_inode;
@@ -763,6 +774,7 @@ static const struct super_operations ntfs_sops = {
      .put_super = ntfs_put_super,
      .statfs = ntfs_statfs,
      .show_options = ntfs_show_options,
+    .shutdown = ntfs_shutdown,
      .sync_fs = ntfs_sync_fs,
      .write_inode = ntfs3_write_inode,
  };
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4274b6f31cfa..071356d096d8 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -744,6 +744,9 @@ static int ntfs_getxattr(const struct xattr_handler 
*handler, struct dentry *de,
      int err;
      struct ntfs_inode *ni = ntfs_i(inode);

+    if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+        return -EIO;
+
      /* Dispatch request. */
      if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
          /* system.dos_attrib */
-- 
2.34.1


