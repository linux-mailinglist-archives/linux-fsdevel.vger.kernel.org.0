Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0570878EAB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjHaKqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjHaKqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:46:14 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EF10F5;
        Thu, 31 Aug 2023 03:45:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RbyDd0FLdz9xGmS;
        Thu, 31 Aug 2023 18:33:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S14;
        Thu, 31 Aug 2023 11:44:55 +0100 (CET)
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
Subject: [PATCH v2 12/25] security: Introduce inode_post_setattr hook
Date:   Thu, 31 Aug 2023 12:41:23 +0200
Message-Id: <20230831104136.903180-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S14
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4DKry7Kw15Xw4fKrWUXFb_yoWrJF47pF
        W8t3WUKw4rWFy7Wr1kJa17ua1SgFy5urWUXrZ0gwn0yFn7tw1aqF43K34UCr13GrW8Gr9a
        q3ZFvrsxCr15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49c5wAEsB
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
the inode_post_setattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/attr.c                     |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index 431f667726c7..3c309eb456c6 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -486,6 +486,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
+		security_inode_post_setattr(idmap, dentry, ia_valid);
 		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fdf075a6b1bb..995d30336cfa 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -136,6 +136,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
 	 struct iattr *attr)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
+	 struct dentry *dentry, int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
diff --git a/include/linux/security.h b/include/linux/security.h
index dcb3604ffab8..820899db5276 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -355,6 +355,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 int security_inode_permission(struct inode *inode, int mask);
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr);
+void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 int ia_valid);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
@@ -856,6 +858,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void
+security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid)
+{ }
+
 static inline int security_inode_getattr(const struct path *path)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 2b24d01cf181..764a6f28b3b9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2124,6 +2124,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
+/**
+ * security_inode_post_setattr() - Update the inode after a setattr operation
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @ia_valid: file attributes set
+ *
+ * Update inode security field after successful setting file attributes.
+ */
+void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 int ia_valid)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
+}
+
 /**
  * security_inode_getattr() - Check if getting file attributes is allowed
  * @path: file
-- 
2.34.1

