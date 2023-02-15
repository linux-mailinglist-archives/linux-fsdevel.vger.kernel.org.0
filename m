Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F4697D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBONfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBONe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:34:58 -0500
X-Greylist: delayed 85 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 05:34:56 PST
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B23A92;
        Wed, 15 Feb 2023 05:34:56 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 565C72147;
        Wed, 15 Feb 2023 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467844;
        bh=cRbFAcsOeNInjJ/7aNI+flXOVb7jAlQp1y5wkLFBBeE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=SM6lEK6RBNg0roCsqmraz/E86Mlrmp5zFPFxVPk0W/vslDtU9jZTljAGe7xmvMu+5
         v1G2ot0abrwTUAkmqgKxwJFZ/H1/WR0aoseMoZ5BaG9ihYD3xc6ZTJHmVmadoXf2yf
         7PEKU5DxGSPdCOEUuuyZ2jkUn4eeuqi7e4njZBeA=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:34:54 +0300
Message-ID: <331371f5-6c34-65aa-f81e-c27e428b9d4e@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:34:53 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 02/11] fs/ntfs3: Remove noacsrules
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

Currently, this option does not work properly. Its use leads to unstable 
results.
If we figure out how to implement it without errors, we will add it later.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  Documentation/filesystems/ntfs3.rst | 11 -----------
  fs/ntfs3/file.c                     | 11 -----------
  fs/ntfs3/inode.c                    |  1 -
  fs/ntfs3/namei.c                    |  1 -
  fs/ntfs3/ntfs_fs.h                  |  3 ---
  fs/ntfs3/super.c                    |  9 +--------
  fs/ntfs3/xattr.c                    | 14 --------------
  7 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/Documentation/filesystems/ntfs3.rst 
b/Documentation/filesystems/ntfs3.rst
index 5aa102bd72c2..f0cf05cad2ba 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -61,17 +61,6 @@ this table marked with no it means default is without 
**no**.
         directories, fmask applies only to files and dmask only to 
directories.
     * - fmask=

-   * - noacsrules
-     - "No access rules" mount option sets access rights for 
files/folders to
-       777 and owner/group to root. This mount option absorbs all other
-       permissions.
-
-       - Permissions change for files/folders will be reported as 
successful,
-     but they will remain 777.
-
-       - Owner/group change will be reported as successful, butthey 
will stay
-     as root.
-
     * - nohidden
       - Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN) 
attribute
         will not be shown under Linux.
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index d37df7376543..9cef189fc0c5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -654,22 +654,12 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
  int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry 
*dentry,
            struct iattr *attr)
  {
-    struct super_block *sb = dentry->d_sb;
-    struct ntfs_sb_info *sbi = sb->s_fs_info;
      struct inode *inode = d_inode(dentry);
      struct ntfs_inode *ni = ntfs_i(inode);
      u32 ia_valid = attr->ia_valid;
      umode_t mode = inode->i_mode;
      int err;

-    if (sbi->options->noacsrules) {
-        /* "No access rules" - Force any changes of time etc. */
-        attr->ia_valid |= ATTR_FORCE;
-        /* and disable for editing some attributes. */
-        attr->ia_valid &= ~(ATTR_UID | ATTR_GID | ATTR_MODE);
-        ia_valid = attr->ia_valid;
-    }
-
      err = setattr_prepare(mnt_userns, dentry, attr);
      if (err)
          goto out;
@@ -1153,7 +1143,6 @@ const struct inode_operations 
ntfs_file_inode_operations = {
      .getattr    = ntfs_getattr,
      .setattr    = ntfs3_setattr,
      .listxattr    = ntfs_listxattr,
-    .permission    = ntfs_permission,
      .get_inode_acl    = ntfs_get_acl,
      .set_acl    = ntfs_set_acl,
      .fiemap        = ntfs_fiemap,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5e06299591ed..51e342ad79fd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2070,7 +2070,6 @@ const struct inode_operations 
ntfs_link_inode_operations = {
      .get_link    = ntfs_get_link,
      .setattr    = ntfs3_setattr,
      .listxattr    = ntfs_listxattr,
-    .permission    = ntfs_permission,
  };

  const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 53ddea219e37..5d5fe2f1f77c 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -607,7 +607,6 @@ const struct inode_operations 
ntfs_dir_inode_operations = {
      .rmdir        = ntfs_rmdir,
      .mknod        = ntfs_mknod,
      .rename        = ntfs_rename,
-    .permission    = ntfs_permission,
      .get_inode_acl    = ntfs_get_acl,
      .set_acl    = ntfs_set_acl,
      .setattr    = ntfs3_setattr,
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2050eb3f6a5a..556b76f526cb 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -100,7 +100,6 @@ struct ntfs_mount_options {
      unsigned hide_dot_files : 1; /* Set hidden flag on dot files. */
      unsigned windows_names : 1; /* Disallow names forbidden by Windows. */
      unsigned force : 1; /* RW mount dirty volume. */
-    unsigned noacsrules : 1; /* Exclude acs rules. */
      unsigned prealloc : 1; /* Preallocate space when file is growing. */
      unsigned nocase : 1; /* case insensitive. */
  };
@@ -868,8 +867,6 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, 
struct inode *inode,
  #endif

  int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct dentry 
*dentry);
-int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
-            int mask);
  ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
  extern const struct xattr_handler *ntfs_xattr_handlers[];

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 19d0889b131f..10c019ef7da3 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -253,7 +253,6 @@ enum Opt {
      Opt_acl,
      Opt_iocharset,
      Opt_prealloc,
-    Opt_noacsrules,
      Opt_nocase,
      Opt_err,
  };
@@ -274,7 +273,6 @@ static const struct fs_parameter_spec 
ntfs_fs_parameters[] = {
      fsparam_flag_no("acl",            Opt_acl),
      fsparam_flag_no("showmeta",        Opt_showmeta),
      fsparam_flag_no("prealloc",        Opt_prealloc),
-    fsparam_flag_no("acsrules",        Opt_noacsrules),
      fsparam_flag_no("nocase",        Opt_nocase),
      fsparam_string("iocharset",        Opt_iocharset),
      {}
@@ -387,9 +385,6 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
      case Opt_prealloc:
          opts->prealloc = result.negated ? 0 : 1;
          break;
-    case Opt_noacsrules:
-        opts->noacsrules = result.negated ? 1 : 0;
-        break;
      case Opt_nocase:
          opts->nocase = result.negated ? 1 : 0;
          break;
@@ -572,8 +567,6 @@ static int ntfs_show_options(struct seq_file *m, 
struct dentry *root)
          seq_puts(m, ",hide_dot_files");
      if (opts->force)
          seq_puts(m, ",force");
-    if (opts->noacsrules)
-        seq_puts(m, ",noacsrules");
      if (opts->prealloc)
          seq_puts(m, ",prealloc");
      if (sb->s_flags & SB_POSIXACL)
@@ -791,7 +784,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      if (boot_sector_size != sector_size) {
          ntfs_warn(
              sb,
-            "Different NTFS' sector size (%u) and media sector size (%u)",
+            "Different NTFS sector size (%u) and media sector size (%u)",
              boot_sector_size, sector_size);
          dev_size += sector_size - 1;
      }
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 3fa48c8f68d9..c42fbc56eb39 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -711,20 +711,6 @@ int ntfs_acl_chmod(struct user_namespace 
*mnt_userns, struct dentry *dentry)
      return posix_acl_chmod(mnt_userns, dentry, inode->i_mode);
  }

-/*
- * ntfs_permission - inode_operations::permission
- */
-int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
-            int mask)
-{
-    if (ntfs_sb(inode->i_sb)->options->noacsrules) {
-        /* "No access rules" mode - Allow all changes. */
-        return 0;
-    }
-
-    return generic_permission(mnt_userns, inode, mask);
-}
-
  /*
   * ntfs_listxattr - inode_operations::listxattr
   */
-- 
2.34.1

