Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A27918C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353192AbjIDNjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353123AbjIDNjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:39:37 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274FFE72;
        Mon,  4 Sep 2023 06:39:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RfTtf0jFBz9xtn9;
        Mon,  4 Sep 2023 21:26:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHerrf3PVkUqceAg--.16511S20;
        Mon, 04 Sep 2023 14:38:12 +0100 (CET)
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
Subject: [PATCH v3 18/25] security: Introduce inode_post_set_acl hook
Date:   Mon,  4 Sep 2023 15:34:08 +0200
Message-Id: <20230904133415.1799503-19-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHerrf3PVkUqceAg--.16511S20
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kKr4xWrW8XFy8JryUGFg_yoWrWr1kpF
        4ft3Za93yrXFW2gryktFWDu34SqFyFg347J392gw1SyFn7tr1jqFsIkF1YkFyrArW8GF1v
        qF4agrsxC345Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5OBdQAAsZ
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
the inode_post_set_acl hook.

It is useful for EVM to recalculate the HMAC on the modified POSIX ACL and
other file metadata, after it verified the HMAC of current file metadata
with the inode_set_acl hook.

LSMs should use the new hook instead of inode_set_acl, when they need to
know that the operation was done successfully (not known in inode_set_acl).
The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
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
index aa6274c90147..aabace9e24d9 100644
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

