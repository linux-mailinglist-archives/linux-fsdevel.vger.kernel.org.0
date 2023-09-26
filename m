Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320357AE9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjIZJ4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjIZJ4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:56:25 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5D136;
        Tue, 26 Sep 2023 02:56:18 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 85E7D21BC;
        Tue, 26 Sep 2023 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721826;
        bh=T9vkfkHcNvq5d6thJXCI0YPqyqz/uUcgdijYO65TaHI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=dNKcbWWY4JBplqmHwYV1MO3bNpKVXPJ6gu7Kq4kobN7Ue7QKfFrCtHszoJbQY2W9B
         wj4WQTHy9EJl7MTokBKsui/7JOZn6BU4bQNh3D5oKEqlHeZy9xS2M2g1Pw19OSnxPr
         3nXnDyxOjxgsyIb2+jOuIUHSbHTwKyN/mklkX9ec=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CF4DB2196;
        Tue, 26 Sep 2023 09:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695722176;
        bh=T9vkfkHcNvq5d6thJXCI0YPqyqz/uUcgdijYO65TaHI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=DcUNAJblr1CcjhmuYcHUghgHIbUu8CxaGNbF3lNDg/GZvhDdOLtng6d9QG580euDq
         6fv+QREl/Gcd2yUE0uGTka6RDW54edlYTvctMbKKYg1Tfre0wYrBhOmY1f89CH1HUP
         kyezymUxjGGk9z+VwOthc36L0cDNBdz2C3aP24XA=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:56:16 +0300
Message-ID: <1c6bcea6-3d7a-4f01-ae67-fab917344a00@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:56:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/8] fs/ntfs3: Refactoring and comments
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
In-Reply-To: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  |  6 +++---
  fs/ntfs3/file.c    |  4 ++--
  fs/ntfs3/inode.c   |  3 ++-
  fs/ntfs3/namei.c   |  6 +++---
  fs/ntfs3/ntfs.h    |  2 +-
  fs/ntfs3/ntfs_fs.h |  2 --
  fs/ntfs3/record.c  |  6 ++++++
  fs/ntfs3/super.c   | 19 ++++++++-----------
  8 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index a9d82bbb4729..e16487764282 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1106,10 +1106,10 @@ int attr_data_get_block(struct ntfs_inode *ni, 
CLST vcn, CLST clen, CLST *lcn,
          }
      }

-    /*
+    /*
       * The code below may require additional cluster (to extend 
attribute list)
-     * and / or one MFT record
-     * It is too complex to undo operations if -ENOSPC occurs deep inside
+     * and / or one MFT record
+     * It is too complex to undo operations if -ENOSPC occurs deep inside
       * in 'ni_insert_nonresident'.
       * Return in advance -ENOSPC here if there are no free cluster and 
no free MFT.
       */
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 962f12ce6c0a..1f7a194983c5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -745,8 +745,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb 
*iocb, struct iov_iter *iter)
  }

  static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
-                     struct pipe_inode_info *pipe,
-                     size_t len, unsigned int flags)
+                     struct pipe_inode_info *pipe, size_t len,
+                     unsigned int flags)
  {
      struct inode *inode = in->f_mapping->host;
      struct ntfs_inode *ni = ntfs_i(inode);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 2f76dc055c1f..d6d021e19aaa 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1660,7 +1660,8 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
      d_instantiate(dentry, inode);

      /* Set original time. inode times (i_ctime) may be changed in 
ntfs_init_acl. */
-    inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode, 
ni->i_crtime);
+    inode->i_atime = inode->i_mtime =
+        inode_set_ctime_to_ts(inode, ni->i_crtime);
      dir->i_mtime = inode_set_ctime_to_ts(dir, ni->i_crtime);

      mark_inode_dirty(dir);
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ad430d50bd79..eedacf94edd8 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -156,8 +156,8 @@ static int ntfs_link(struct dentry *ode, struct 
inode *dir, struct dentry *de)
      err = ntfs_link_inode(inode, de);

      if (!err) {
-        dir->i_mtime = inode_set_ctime_to_ts(inode,
-                             inode_set_ctime_current(dir));
+        dir->i_mtime = inode_set_ctime_to_ts(
+            inode, inode_set_ctime_current(dir));
          mark_inode_dirty(inode);
          mark_inode_dirty(dir);
          d_instantiate(de, inode);
@@ -373,7 +373,7 @@ static int ntfs_atomic_open(struct inode *dir, 
struct dentry *dentry,

  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
      if (IS_POSIXACL(dir)) {
-        /*
+        /*
           * Load in cache current acl to avoid ni_lock(dir):
           * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
           * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 98b76d1b09e7..86aecbb01a92 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -847,7 +847,7 @@ struct OBJECT_ID {
      // Birth Volume Id is the Object Id of the Volume on.
      // which the Object Id was allocated. It never changes.
      struct GUID BirthVolumeId; //0x10:
-
+
      // Birth Object Id is the first Object Id that was
      // ever assigned to this MFT Record. I.e. If the Object Id
      // is changed for some reason, this field will reflect the
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 788567d71d93..0e6a2777870c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -497,8 +497,6 @@ int ntfs_getattr(struct mnt_idmap *idmap, const 
struct path *path,
           struct kstat *stat, u32 request_mask, u32 flags);
  int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
            struct iattr *attr);
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-             CLST len);
  int ntfs_file_open(struct inode *inode, struct file *file);
  int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
          __u64 start, __u64 len);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 02cc91ed8835..53629b1f65e9 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -189,6 +189,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
      return err;
  }

+/*
+ * mi_enum_attr - start/continue attributes enumeration in record.
+ *
+ * NOTE: mi->mrec - memory of size sbi->record_size
+ * here we sure that mi->mrec->total == sbi->record_size (see mi_read)
+ */
  struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
  {
      const struct MFT_REC *rec = mi->mrec;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d2951b23f52a..f9a214367113 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -488,7 +488,6 @@ static ssize_t ntfs3_label_write(struct file *file, 
const char __user *buffer,
  {
      int err;
      struct super_block *sb = pde_data(file_inode(file));
-    struct ntfs_sb_info *sbi = sb->s_fs_info;
      ssize_t ret = count;
      u8 *label = kmalloc(count, GFP_NOFS);

@@ -502,7 +501,7 @@ static ssize_t ntfs3_label_write(struct file *file, 
const char __user *buffer,
      while (ret > 0 && label[ret - 1] == '\n')
          ret -= 1;

-    err = ntfs_set_label(sbi, label, ret);
+    err = ntfs_set_label(sb->s_fs_info, label, ret);

      if (err < 0) {
          ntfs_err(sb, "failed (%d) to write label", err);
@@ -1082,10 +1081,10 @@ static int ntfs_init_from_boot(struct 
super_block *sb, u32 sector_size,

      if (bh->b_blocknr && !sb_rdonly(sb)) {
          /*
-         * Alternative boot is ok but primary is not ok.
-         * Do not update primary boot here 'cause it may be faked boot.
-         * Let ntfs to be mounted and update boot later.
-         */
+          * Alternative boot is ok but primary is not ok.
+          * Do not update primary boot here 'cause it may be faked boot.
+          * Let ntfs to be mounted and update boot later.
+         */
          *boot2 = kmemdup(boot, sizeof(*boot), GFP_NOFS | __GFP_NOWARN);
      }

@@ -1549,9 +1548,9 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

      if (boot2) {
          /*
-         * Alternative boot is ok but primary is not ok.
-         * Volume is recognized as NTFS. Update primary boot.
-         */
+          * Alternative boot is ok but primary is not ok.
+          * Volume is recognized as NTFS. Update primary boot.
+         */
          struct buffer_head *bh0 = sb_getblk(sb, 0);
          if (bh0) {
              if (buffer_locked(bh0))
@@ -1785,7 +1784,6 @@ static int __init init_ntfs_fs(void)
      if (IS_ENABLED(CONFIG_NTFS3_LZX_XPRESS))
          pr_info("ntfs3: Read-only LZX/Xpress compression included\n");

-
  #ifdef CONFIG_PROC_FS
      /* Create "/proc/fs/ntfs3" */
      proc_info_root = proc_mkdir("fs/ntfs3", NULL);
@@ -1827,7 +1825,6 @@ static void __exit exit_ntfs_fs(void)
      if (proc_info_root)
          remove_proc_entry("fs/ntfs3", NULL);
  #endif
-
  }

  MODULE_LICENSE("GPL");
-- 
2.34.1

