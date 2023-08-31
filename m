Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FE78EAC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbjHaKqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbjHaKqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:46:31 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0CE54;
        Thu, 31 Aug 2023 03:46:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbyDq4xJNz9xFPm;
        Thu, 31 Aug 2023 18:33:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S15;
        Thu, 31 Aug 2023 11:45:08 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 13/25] security: Introduce inode_post_removexattr hook
Date:   Thu, 31 Aug 2023 12:41:24 +0200
Message-Id: <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S15
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kAryUXr15XrW7tw4xWFg_yoWrGF1rpF
        s8K3Z3Gr4rJFy7WryktF4Duw4I9FW3Wry7J3y2gw12yFn7Jr1IqFZxCFyUCry5JrWjgFyq
        q3ZFkrs5Cr15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49c5wAFsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_removexattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/xattr.c                    |  9 +++++----
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e7bbb7f57557..4a0280295686 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 		goto out;
 
 	error = __vfs_removexattr(idmap, dentry, name);
+	if (error)
+		goto out;
 
-	if (!error) {
-		fsnotify_xattr(dentry);
-		evm_inode_post_removexattr(dentry, name);
-	}
+	fsnotify_xattr(dentry);
+	security_inode_post_removexattr(dentry, name);
+	evm_inode_post_removexattr(dentry, name);
 
 out:
 	return error;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 995d30336cfa..1153e7163b8b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
+	 const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 820899db5276..665bba3e0081 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
+void security_inode_post_removexattr(struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
 	return cap_inode_removexattr(idmap, dentry, name);
 }
 
+static inline void security_inode_post_removexattr(struct dentry *dentry,
+						   const char *name)
+{ }
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 764a6f28b3b9..3947159ba5e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	return evm_inode_removexattr(idmap, dentry, name);
 }
 
+/**
+ * security_inode_post_removexattr() - Update the inode after a removexattr op
+ * @dentry: file
+ * @name: xattr name
+ *
+ * Update the inode after a successful removexattr operation.
+ */
+void security_inode_post_removexattr(struct dentry *dentry, const char *name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_removexattr, dentry, name);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry
-- 
2.34.1

