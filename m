Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432AE6A9E91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCCSXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCCSXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:23:13 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979B60A92;
        Fri,  3 Mar 2023 10:22:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PSx1p6jFvz9v7JB;
        Sat,  4 Mar 2023 02:14:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S21;
        Fri, 03 Mar 2023 19:22:24 +0100 (CET)
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
Subject: [PATCH 19/28] security: Introduce inode_post_create_tmpfile hook
Date:   Fri,  3 Mar 2023 19:18:33 +0100
Message-Id: <20230303181842.1087717-20-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S21
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fWrW8KF47uryUury8Krg_yoWrJw4xpF
        WxK3W3Grs5XFy7WryvyF4Uuw1S9aySgrW7JrZagwn0yFn7tr1ftF4S9r12kFy3JrW8Wr12
        q3ZxKrZxGr17tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
        U0189tUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4otWQABsO
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
the inode_post_create_tmpfile hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                    |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 18 ++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 3f2747521d3..8c4fdfd81d4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3624,6 +3624,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
+	security_inode_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
 	ima_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32c801a3ea2..5dc2a7c3d9a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -120,6 +120,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
+	 struct inode *dir, struct dentry *dentry, umode_t mode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
 	 struct dentry *new_dentry)
 LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index fb6e9d434c6..b3e201404dc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -337,6 +337,9 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *dir,
+					struct dentry *dentry, umode_t mode);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry);
 int security_inode_unlink(struct inode *dir, struct dentry *dentry);
@@ -787,6 +790,11 @@ static inline int security_inode_create(struct inode *dir,
 	return 0;
 }
 
+static inline void
+security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
+				   struct dentry *dentry, umode_t mode)
+{ }
+
 static inline int security_inode_link(struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
diff --git a/security/security.c b/security/security.c
index f5f367e2064..8883082b686 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1971,6 +1971,24 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+/**
+ * security_inode_post_create_tmpfile() - Update inode sec after tmpfile created
+ * @idmap: idmap of the mount
+ * @dir: the inode of the base directory
+ * @dentry: the dentry of the new tmpfile
+ * @mode: the mode of the new tmpfile
+ *
+ * Update inode security field after a tmpfile has been created.
+ */
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *dir,
+					struct dentry *dentry, umode_t mode)
+{
+	if (unlikely(IS_PRIVATE(dir)))
+		return;
+	call_void_hook(inode_post_create_tmpfile, idmap, dir, dentry, mode);
+}
+
 /**
  * security_inode_link() - Check if creating a hard link is allowed
  * @old_dentry: existing file
-- 
2.25.1

