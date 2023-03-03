Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE426A9E99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjCCSX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjCCSXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:23:19 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B11BB93;
        Fri,  3 Mar 2023 10:22:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSx1R3s6cz9v7Nx;
        Sat,  4 Mar 2023 02:13:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S22;
        Fri, 03 Mar 2023 19:22:34 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 20/28] security: Introduce inode_post_set_acl hook
Date:   Fri,  3 Mar 2023 19:18:34 +0100
Message-Id: <20230303181842.1087717-21-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S22
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fWrW8WFW8CFy5AF4xJFb_yoW5KFW8pF
        s7t3Zak3yrXFy2gryktFWDC3s2qFyYgry7J3y0gwnayFn7tr1qqFsIkFyYkryrArW8GF1v
        ganI9rsxCw13Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_GcCE3s1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F
        4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j7
        GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4YvegAAsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_set_acl hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5a76fb35923..acddf2dff4c 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1102,6 +1102,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EOPNOTSUPP;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		security_inode_post_set_acl(dentry, acl_name, kacl);
 		evm_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 5dc2a7c3d9a..9a3e14db0af 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -156,6 +156,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
+	 const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index b3e201404dc..b0691bf7237 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -366,6 +366,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl);
+void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl);
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
 int security_inode_remove_acl(struct mnt_idmap *idmap,
@@ -893,6 +895,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void security_inode_post_set_acl(struct dentry *dentry,
+					       const char *acl_name,
+					       struct posix_acl *kacl)
+{ }
+
 static inline int security_inode_get_acl(struct mnt_idmap *idmap,
 					 struct dentry *dentry,
 					 const char *acl_name)
diff --git a/security/security.c b/security/security.c
index 8883082b686..fc11d70bb02 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2310,6 +2310,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
 }
 
+/**
+ * security_inode_post_set_acl() - Update inode sec after set_acl operation
+ * @dentry: file
+ * @acl_name: acl name
+ * @kacl: acl struct
+ *
+ * Update inode security field after successful set_acl operation on @dentry.
+ * The posix acls in @kacl are identified by @acl_name.
+ */
+void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
+}
+
 /**
  * security_inode_get_acl() - Check if reading posix acls is allowed
  * @idmap: idmap of the mount
-- 
2.25.1

