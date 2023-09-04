Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353137918B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353127AbjIDNjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjIDNjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:39:31 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211519BC;
        Mon,  4 Sep 2023 06:39:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RfTtQ2HtDz9xtn5;
        Mon,  4 Sep 2023 21:26:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHerrf3PVkUqceAg--.16511S19;
        Mon, 04 Sep 2023 14:38:01 +0100 (CET)
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 17/25] security: Introduce inode_post_create_tmpfile hook
Date:   Mon,  4 Sep 2023 15:34:07 +0200
Message-Id: <20230904133415.1799503-18-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHerrf3PVkUqceAg--.16511S19
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18tF1fGr1UGF45try3twb_yoWrWF18pF
        4fK3W5Grs5XFy2gr1kAF4Uuw1SqayagrWUJrZagwn0yFn7tw1ftF4Skr12kF13JrW8Gw12
        qFnrKrZxGr1UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4+BWQABsr
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_create_tmpfile hook.

It is useful for IMA to mark new temp files as successfully appraised and
let them be subsequently opened for further modification.

LSMs can benefit from this hook to update the inode state after a temp file
has been successfully created. The new hook cannot return an error and
cannot cause the operation to be canceled.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                    |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 18 ++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c8c4ab26b52a..efed0e1e93f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3700,6 +3700,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
+	security_inode_post_create_tmpfile(idmap, dir, file, mode);
 	ima_post_create_tmpfile(idmap, dir, file, mode);
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index b1634b5de98c..9ae573b83737 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
+	 struct inode *dir, struct file *file, umode_t mode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
 	 struct dentry *new_dentry)
 LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index f210bd66e939..5f296761883f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,9 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *dir, struct file *file,
+					umode_t mode);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry);
 int security_inode_unlink(struct inode *dir, struct dentry *dentry);
@@ -788,6 +791,11 @@ static inline int security_inode_create(struct inode *dir,
 	return 0;
 }
 
+static inline void
+security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
+				   struct file *file, umode_t mode)
+{ }
+
 static inline int security_inode_link(struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
diff --git a/security/security.c b/security/security.c
index 78aeb24efedb..aa6274c90147 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1920,6 +1920,24 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+/**
+ * security_inode_post_create_tmpfile() - Update inode security field after creation of tmpfile
+ * @idmap: idmap of the mount
+ * @dir: the inode of the base directory
+ * @file: file descriptor of the new tmpfile
+ * @mode: the mode of the new tmpfile
+ *
+ * Update inode security field after a tmpfile has been created.
+ */
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *dir,
+					struct file *file, umode_t mode)
+{
+	if (unlikely(IS_PRIVATE(dir)))
+		return;
+	call_void_hook(inode_post_create_tmpfile, idmap, dir, file, mode);
+}
+
 /**
  * security_inode_link() - Check if creating a hard link is allowed
  * @old_dentry: existing file
-- 
2.34.1

