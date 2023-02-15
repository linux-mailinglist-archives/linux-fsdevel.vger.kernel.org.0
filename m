Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E2697D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBONfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBONfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:35:45 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343C358D;
        Wed, 15 Feb 2023 05:35:41 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E50212147;
        Wed, 15 Feb 2023 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467889;
        bh=9YwbKHsq6zCe7UxAvvfw0U9eC4NOBc0GrYuoyaOiRsg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=DCV2Dvw82s3o6RFPyqyYN0Tnm6u8pD6i3IJSiPZUUIXT3hcm7S3DQEb9Y1bzjjcdz
         LCThTW9xJt3J468JQtSS21GJ/DKuAXcBOajsvy3AOPGr7R26wX/Jihnc3ykI3Dk2O2
         99JLC3TidCsoz1mdujuofcMB4u0gn/FUe5KzlJzQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4284E1E70;
        Wed, 15 Feb 2023 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468139;
        bh=9YwbKHsq6zCe7UxAvvfw0U9eC4NOBc0GrYuoyaOiRsg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=A5o+lDtsQrQ0900S8R3zH3VMIsH9utchJww8A5uyU3NI92M6w0w1nnJpraji5665l
         +Z8SdrIKWlLBh3fU5Zha0/t3ltjjYuvPyNEaExoUgGanC+ybbCMD1xiIclZaxeAvgR
         6GfjVL/y9spCDnHctON3r7vcp9dfCP6QY6jN3GvU=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:35:38 +0300
Message-ID: <d9c83c8e-b08d-1c26-b601-705d4a5edf75@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:35:37 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 03/11] fs/ntfs3: Fix ntfs_create_inode()
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
In-Reply-To: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previous variant creates an inode that requires update the parent directory
(ea_packed_size). Operations in ntfs_create_inode have been rearranged
so we insert new directory entry with correct ea_packed_size and
new created inode does not require update it's parent directory.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c    |  2 +-
  fs/ntfs3/inode.c   | 83 ++++++++++++++++++++++++----------------------
  fs/ntfs3/ntfs_fs.h |  2 +-
  fs/ntfs3/xattr.c   | 20 ++++++-----
  4 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9cef189fc0c5..df7b76d1c127 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -703,7 +703,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, 
struct dentry *dentry,
      }

      if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE))
-        ntfs_save_wsl_perm(inode);
+        ntfs_save_wsl_perm(inode, NULL);
      mark_inode_dirty(inode);
  out:
      return err;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 51e342ad79fd..752ad17685c0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1320,8 +1320,7 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      inode_init_owner(mnt_userns, inode, dir, mode);
      mode = inode->i_mode;

-    inode->i_atime = inode->i_mtime = inode->i_ctime = ni->i_crtime =
-        current_time(inode);
+    ni->i_crtime = current_time(inode);

      rec = ni->mi.mrec;
      rec->hard_links = cpu_to_le16(1);
@@ -1362,10 +1361,9 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      attr->res.data_size = cpu_to_le32(dsize);

      std5->cr_time = std5->m_time = std5->c_time = std5->a_time =
-        kernel2nt(&inode->i_atime);
+        kernel2nt(&ni->i_crtime);

-    ni->std_fa = fa;
-    std5->fa = fa;
+    std5->fa = ni->std_fa = fa;

      attr = Add2Ptr(attr, asize);

@@ -1564,11 +1562,15 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
              }

              asize = SIZEOF_NONRESIDENT + ALIGN(err, 8);
+            /* Write non resident data. */
+            err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp,
+                        nsize, 0);
+            if (err)
+                goto out5;
          } else {
              attr->res.data_off = SIZEOF_RESIDENT_LE;
              attr->res.data_size = cpu_to_le32(nsize);
              memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), rp, nsize);
-            nsize = 0;
          }
          /* Size of symlink equals the length of input string. */
          inode->i_size = size;
@@ -1589,19 +1591,8 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      rec->used = cpu_to_le32(PtrOffset(rec, attr) + 8);
      rec->next_attr_id = cpu_to_le16(aid);

-    /* Step 2: Add new name in index. */
-    err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd, 0);
-    if (err)
-        goto out6;
-
-    /* Unlock parent directory before ntfs_init_acl. */
-    if (!fnd)
-        ni_unlock(dir_ni);
-
      inode->i_generation = le16_to_cpu(rec->seq);

-    dir->i_mtime = dir->i_ctime = inode->i_atime;
-
      if (S_ISDIR(mode)) {
          inode->i_op = &ntfs_dir_inode_operations;
          inode->i_fop = &ntfs_dir_operations;
@@ -1626,41 +1617,58 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      if (!S_ISLNK(mode) && (sb->s_flags & SB_POSIXACL)) {
          err = ntfs_init_acl(mnt_userns, inode, dir);
          if (err)
-            goto out7;
+            goto out5;
      } else
  #endif
      {
          inode->i_flags |= S_NOSEC;
      }

-    /* Write non resident data. */
-    if (nsize) {
-        err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize, 0);
-        if (err)
-            goto out7;
+    /*
+     * ntfs_init_acl and ntfs_save_wsl_perm update extended attribute.
+     * The packed size of extended attribute is stored in direntry too.
+     * 'fname' here points to inside new_de.
+     */
+    ntfs_save_wsl_perm(inode, &fname->dup.ea_size);
+
+    /*
+     * update ea_size in file_name attribute too.
+     * Use ni_find_attr cause layout of MFT record may be changed
+     * in ntfs_init_acl and ntfs_save_wsl_perm.
+     */
+    attr = ni_find_attr(ni, NULL, NULL, ATTR_NAME, NULL, 0, NULL, NULL);
+    if (attr) {
+        struct ATTR_FILE_NAME *fn;
+
+        fn = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+        if (fn)
+            fn->dup.ea_size = fname->dup.ea_size;
      }

+    /* We do not need to update parent directory later */
+    ni->ni_flags &= ~NI_FLAG_UPDATE_PARENT;
+
+    /* Step 2: Add new name in index. */
+    err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd, 0);
+    if (err)
+        goto out6;
+
      /*
       * Call 'd_instantiate' after inode->i_op is set
       * but before finish_open.
       */
      d_instantiate(dentry, inode);

-    ntfs_save_wsl_perm(inode);
+    /* Set original time. inode times (i_ctime) may be changed in 
ntfs_init_acl. */
+    inode->i_atime = inode->i_mtime = inode->i_ctime = dir->i_mtime =
+        dir->i_ctime = ni->i_crtime;
+
      mark_inode_dirty(dir);
      mark_inode_dirty(inode);

      /* Normal exit. */
      goto out2;

-out7:
-
-    /* Undo 'indx_insert_entry'. */
-    if (!fnd)
-        ni_lock_dir(dir_ni);
-    indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
-              le16_to_cpu(new_de->key_size), sbi);
-    /* ni_unlock(dir_ni); will be called later. */
  out6:
      if (rp_inserted)
          ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
@@ -1682,11 +1690,11 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      kfree(rp);

  out1:
-    if (err) {
-        if (!fnd)
-            ni_unlock(dir_ni);
+    if (!fnd)
+        ni_unlock(dir_ni);
+
+    if (err)
          return ERR_PTR(err);
-    }

      unlock_new_inode(inode);

@@ -1783,9 +1791,6 @@ void ntfs_evict_inode(struct inode *inode)
  {
      truncate_inode_pages_final(&inode->i_data);

-    if (inode->i_nlink)
-        _ni_write_inode(inode, inode_needs_sync(inode));
-
      invalidate_inode_buffers(inode);
      clear_inode(inode);

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 556b76f526cb..73a639716b45 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -870,7 +870,7 @@ int ntfs_acl_chmod(struct user_namespace 
*mnt_userns, struct dentry *dentry);
  ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
  extern const struct xattr_handler *ntfs_xattr_handlers[];

-int ntfs_save_wsl_perm(struct inode *inode);
+int ntfs_save_wsl_perm(struct inode *inode, __le16 *ea_size);
  void ntfs_get_wsl_perm(struct inode *inode);

  /* globals from lznt.c */
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index c42fbc56eb39..e7a66225361d 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -296,7 +296,8 @@ static int ntfs_get_ea(struct inode *inode, const 
char *name, size_t name_len,

  static noinline int ntfs_set_ea(struct inode *inode, const char *name,
                  size_t name_len, const void *value,
-                size_t val_size, int flags, bool locked)
+                size_t val_size, int flags, bool locked,
+                __le16 *ea_size)
  {
      struct ntfs_inode *ni = ntfs_i(inode);
      struct ntfs_sb_info *sbi = ni->mi.sbi;
@@ -504,6 +505,8 @@ static noinline int ntfs_set_ea(struct inode *inode, 
const char *name,

      if (ea_info.size_pack != size_pack)
          ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+    if (ea_size)
+        *ea_size = ea_info.size_pack;
      mark_inode_dirty(&ni->vfs_inode);

  out:
@@ -633,7 +636,7 @@ static noinline int ntfs_set_acl_ex(struct 
user_namespace *mnt_userns,
          flags = 0;
      }

-    err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
+    err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0, NULL);
      if (err == -ENODATA && !size)
          err = 0; /* Removing non existed xattr. */
      if (!err) {
@@ -923,7 +926,8 @@ static noinline int ntfs_setxattr(const struct 
xattr_handler *handler,
      }

      /* Deal with NTFS extended attribute. */
-    err = ntfs_set_ea(inode, name, strlen(name), value, size, flags, 0);
+    err = ntfs_set_ea(inode, name, strlen(name), value, size, flags, 0,
+              NULL);

  out:
      inode->i_ctime = current_time(inode);
@@ -937,7 +941,7 @@ static noinline int ntfs_setxattr(const struct 
xattr_handler *handler,
   *
   * save uid/gid/mode in xattr
   */
-int ntfs_save_wsl_perm(struct inode *inode)
+int ntfs_save_wsl_perm(struct inode *inode, __le16 *ea_size)
  {
      int err;
      __le32 value;
@@ -946,26 +950,26 @@ int ntfs_save_wsl_perm(struct inode *inode)
      ni_lock(ni);
      value = cpu_to_le32(i_uid_read(inode));
      err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &value,
-              sizeof(value), 0, true); /* true == already locked. */
+              sizeof(value), 0, true, ea_size);
      if (err)
          goto out;

      value = cpu_to_le32(i_gid_read(inode));
      err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &value,
-              sizeof(value), 0, true);
+              sizeof(value), 0, true, ea_size);
      if (err)
          goto out;

      value = cpu_to_le32(inode->i_mode);
      err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &value,
-              sizeof(value), 0, true);
+              sizeof(value), 0, true, ea_size);
      if (err)
          goto out;

      if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
          value = cpu_to_le32(inode->i_rdev);
          err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &value,
-                  sizeof(value), 0, true);
+                  sizeof(value), 0, true, ea_size);
          if (err)
              goto out;
      }
-- 
2.34.1

