Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7142078EAFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjHaKsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbjHaKsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:48:11 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C1CFA;
        Thu, 31 Aug 2023 03:47:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbyG36xkkz9xrdd;
        Thu, 31 Aug 2023 18:34:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S20;
        Thu, 31 Aug 2023 11:46:12 +0100 (CET)
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
Subject: [PATCH v2 18/25] security: Introduce inode_post_set_acl hook
Date:   Thu, 31 Aug 2023 12:41:29 +0200
Message-Id: <20230831104136.903180-19-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S20
X-Coremail-Antispam: 1UD129KBjvJXoWxGw13Kw1xWF1fuw45WFyUKFg_yoWrJr4fpF
        s3t3Za93yrXFy2gryktFWUC34IqFWFgry7J3y0gw1SyFn7tr1qqFsIkF1YkFyrArW8GF1v
        gF4a9rsxC343Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
        kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
        WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
        07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5Nc0wABsv
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
the inode_post_set_acl hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7fa1b738bbab..3b7dbea5c3ff 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1137,6 +1137,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		security_inode_post_set_acl(dentry, acl_name, kacl);
 		evm_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9ae573b83737..bba1fbd97207 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
+	 const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f296761883f..556d019ebe5c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -367,6 +367,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl);
+void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl);
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
 int security_inode_remove_acl(struct mnt_idmap *idmap,
@@ -894,6 +896,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
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
index e5acb11f6ebd..4392fd878d58 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2260,6 +2260,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
 }
 
+/**
+ * security_inode_post_set_acl() - Update inode security after set_acl()
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
2.34.1

