Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49E16F7E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjEEIOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjEEINk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:13:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6091636D;
        Fri,  5 May 2023 01:13:38 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCNcc6Nc2zTkCY;
        Fri,  5 May 2023 16:09:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:13:35 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dhowells@redhat.com>, <code@tyhicks.com>,
        <hirofumi@mail.parknet.co.jp>, <linkinjeon@kernel.org>,
        <sfrench@samba.org>, <senozhatsky@chromium.org>, <tom@talpey.com>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>,
        <miklos@szeredi.hu>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <casey@schaufler-ca.com>,
        <dchinner@redhat.com>, <john.johansen@canonical.com>,
        <mcgrof@kernel.org>, <mortonm@chromium.org>, <fred@cloudflare.com>,
        <mic@digikod.net>, <mpe@ellerman.id.au>, <nathanl@linux.ibm.com>,
        <gnoack3000@gmail.com>, <roberto.sassu@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-cachefs@redhat.com>, <ecryptfs@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next 2/2] lsm: Change inode_setattr hook to take struct path argument
Date:   Fri, 5 May 2023 16:12:00 +0800
Message-ID: <20230505081200.254449-3-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505081200.254449-1-xiujianfeng@huawei.com>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For path-based LSMs such as Landlock, struct path instead of struct
dentry is required to make sense of attr/xattr accesses. So change the
argument of lsm hook inode_setattr() from struct dentry * to struct
path *.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 fs/attr.c                     |  2 +-
 fs/fat/file.c                 |  2 +-
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  4 ++--
 security/security.c           | 10 +++++-----
 security/selinux/hooks.c      |  3 ++-
 security/smack/smack_lsm.c    |  5 +++--
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index eecd78944b83..54d4334c350f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -473,7 +473,7 @@ int notify_change(struct mnt_idmap *idmap, const struct path *path,
 	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
 		return -EOVERFLOW;
 
-	error = security_inode_setattr(idmap, dentry, attr);
+	error = security_inode_setattr(idmap, path, attr);
 	if (error)
 		return error;
 	error = try_break_deleg(inode, delegated_inode);
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 795a4fad5c40..bb31663f99b5 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -91,7 +91,7 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	 * module, just because it maps to a file mode.
 	 */
 	err = security_inode_setattr(file_mnt_idmap(file),
-				     file->f_path.dentry, &ia);
+				     &file->f_path, &ia);
 	if (err)
 		goto out_unlock_inode;
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..542fa6ab87c5 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -134,7 +134,7 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 	 bool rcu)
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
-LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
+LSM_HOOK(int, 0, inode_setattr, const struct path *path, struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..9121f86feed1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -353,7 +353,7 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu);
 int security_inode_permission(struct inode *inode, int mask);
 int security_inode_setattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, struct iattr *attr);
+			   const struct path *path, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
@@ -849,7 +849,7 @@ static inline int security_inode_permission(struct inode *inode, int mask)
 }
 
 static inline int security_inode_setattr(struct mnt_idmap *idmap,
-					 struct dentry *dentry,
+					 const struct path *path,
 					 struct iattr *attr)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..2ce7194fdb5c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2075,7 +2075,7 @@ int security_inode_permission(struct inode *inode, int mask)
 /**
  * security_inode_setattr() - Check if setting file attributes is allowed
  * @idmap: idmap of the mount
- * @dentry: file
+ * @path: path of file
  * @attr: new attributes
  *
  * Check permission before setting file attributes.  Note that the kernel call
@@ -2086,16 +2086,16 @@ int security_inode_permission(struct inode *inode, int mask)
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_setattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, struct iattr *attr)
+			   const struct path *path, struct iattr *attr)
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, 0, path, attr);
 	if (ret)
 		return ret;
-	return evm_inode_setattr(idmap, dentry, attr);
+	return evm_inode_setattr(idmap, path->dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..81abaea4dd63 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3051,9 +3051,10 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	return rc;
 }
 
-static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int selinux_inode_setattr(const struct path *path, struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
 	__u32 av = FILE__WRITE;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7a3e9ab137d8..0b2931c87507 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1147,14 +1147,15 @@ static int smack_inode_permission(struct inode *inode, int mask)
 
 /**
  * smack_inode_setattr - Smack check for setting attributes
- * @dentry: the object
+ * @path: path of the object
  * @iattr: for the force flag
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int smack_inode_setattr(const struct path *path, struct iattr *iattr)
 {
 	struct smk_audit_info ad;
+	struct dentry *dentry = path->dentry;
 	int rc;
 
 	/*
-- 
2.17.1

