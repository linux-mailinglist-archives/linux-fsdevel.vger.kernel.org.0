Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A409697D96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBONi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBONi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:38:58 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C77D88;
        Wed, 15 Feb 2023 05:38:57 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1EFC02147;
        Wed, 15 Feb 2023 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468085;
        bh=v58AXW2jaHRye0+maSOsTkJ3+nH0kdM/rFc7zhel7Rc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=W4yAraG/LFxRU1llz2bytqvNtGnqOkDAsNUSflnIdSqi2WB4dmyV07Vp9gmL7aBzA
         RLOcoQ3v00omyOCC4OtsDJzX//VF+mkYcGp8YdRXKA+jBpvUt5L+mV6diBi5Di8M9R
         azxBZlm0LhyBv5C1t8ozsOdC6sfk0D8cjgvL7yic=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:38:55 +0300
Message-ID: <2f017ba3-78a9-211d-2a61-f8a1c90c3cab@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:38:54 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 08/11] fs/ntfs3: Changed ntfs_get_acl() to use dentry
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

ntfs_get_acl changed to match new interface in struct inode_operations.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c    |  2 +-
  fs/ntfs3/namei.c   |  4 ++--
  fs/ntfs3/ntfs_fs.h |  3 ++-
  fs/ntfs3/xattr.c   | 26 +++++++++-----------------
  4 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index df7b76d1c127..09b7931e6be3 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1143,7 +1143,7 @@ const struct inode_operations 
ntfs_file_inode_operations = {
      .getattr    = ntfs_getattr,
      .setattr    = ntfs3_setattr,
      .listxattr    = ntfs_listxattr,
-    .get_inode_acl    = ntfs_get_acl,
+    .get_acl    = ntfs_get_acl,
      .set_acl    = ntfs_set_acl,
      .fiemap        = ntfs_fiemap,
  };
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 5d5fe2f1f77c..8b68ead5cc1f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -607,7 +607,7 @@ const struct inode_operations 
ntfs_dir_inode_operations = {
      .rmdir        = ntfs_rmdir,
      .mknod        = ntfs_mknod,
      .rename        = ntfs_rename,
-    .get_inode_acl    = ntfs_get_acl,
+    .get_acl    = ntfs_get_acl,
      .set_acl    = ntfs_set_acl,
      .setattr    = ntfs3_setattr,
      .getattr    = ntfs_getattr,
@@ -620,7 +620,7 @@ const struct inode_operations 
ntfs_special_inode_operations = {
      .setattr    = ntfs3_setattr,
      .getattr    = ntfs_getattr,
      .listxattr    = ntfs_listxattr,
-    .get_inode_acl    = ntfs_get_acl,
+    .get_acl    = ntfs_get_acl,
      .set_acl    = ntfs_set_acl,
  };

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 26957dbfe471..b7782107ce8a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -855,7 +855,8 @@ unsigned long ntfs_names_hash(const u16 *name, 
size_t len, const u16 *upcase,

  /* globals from xattr.c */
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *ntfs_get_acl(struct user_namespace *mnt_userns,
+         struct dentry *dentry, int type);
  int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
           struct posix_acl *acl, int type);
  int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index e7a66225361d..95c479d7ebba 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -520,9 +520,14 @@ static noinline int ntfs_set_ea(struct inode 
*inode, const char *name,
  }

  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
-                     int locked)
+
+/*
+ * ntfs_get_acl - inode_operations::get_acl
+ */
+struct posix_acl *ntfs_get_acl(struct user_namespace *mnt_userns,
+                   struct dentry *dentry, int type)
  {
+    struct inode *inode = d_inode(dentry);
      struct ntfs_inode *ni = ntfs_i(inode);
      const char *name;
      size_t name_len;
@@ -545,13 +550,11 @@ static struct posix_acl *ntfs_get_acl_ex(struct 
inode *inode, int type,
          name_len = sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1;
      }

-    if (!locked)
-        ni_lock(ni);
+    ni_lock(ni);

      err = ntfs_get_ea(inode, name, name_len, buf, PATH_MAX, &req);

-    if (!locked)
-        ni_unlock(ni);
+    ni_unlock(ni);

      /* Translate extended attribute to acl. */
      if (err >= 0) {
@@ -570,17 +573,6 @@ static struct posix_acl *ntfs_get_acl_ex(struct 
inode *inode, int type,
      return acl;
  }

-/*
- * ntfs_get_acl - inode_operations::get_acl
- */
-struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
-{
-    if (rcu)
-        return ERR_PTR(-ECHILD);
-
-    return ntfs_get_acl_ex(inode, type, 0);
-}
-
  static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
                      struct inode *inode, struct posix_acl *acl,
                      int type, bool init_acl)
-- 
2.34.1

