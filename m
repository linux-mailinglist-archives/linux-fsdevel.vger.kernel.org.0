Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682007918C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353130AbjIDNjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353191AbjIDNjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:39:45 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353A10F2;
        Mon,  4 Sep 2023 06:39:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfTtq4Wfgz9xqwV;
        Mon,  4 Sep 2023 21:26:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHerrf3PVkUqceAg--.16511S21;
        Mon, 04 Sep 2023 14:38:24 +0100 (CET)
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
Subject: [PATCH v3 19/25] security: Introduce inode_post_remove_acl hook
Date:   Mon,  4 Sep 2023 15:34:09 +0200
Message-Id: <20230904133415.1799503-20-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHerrf3PVkUqceAg--.16511S21
X-Coremail-Antispam: 1UD129KBjvJXoWxArW3JrWUXryxtr4ktFyUAwb_yoWrAr45pF
        sIg3ZxWw4rXFy2gryktFWDuw4SvFWFgry7Z3y2gws2yFn7Ar12qFsxGFyUCry5ArW8KF1q
        qF1aqrsxC343Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4+BXAAAsv
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
the inode_post_remove_acl hook.

It is useful for EVM to recalculate the HMAC on the remaining POSIX ACLs
and other file metadata, after it verified the HMAC of current file
metadata with the inode_remove_acl hook.

LSMs should use the new hook instead of inode_remove_acl, when they need to
know that the operation was done successfully (not known in
inode_remove_acl). The new hook cannot return an error and cannot cause the
operation to be reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 3b7dbea5c3ff..2a2a2750b3e9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1246,6 +1246,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		security_inode_post_remove_acl(idmap, dentry, acl_name);
 		evm_inode_post_remove_acl(idmap, dentry, acl_name);
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bba1fbd97207..eedc26790a07 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -163,6 +163,8 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index 556d019ebe5c..e543ae80309b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -373,6 +373,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
 int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name);
+void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+				    struct dentry *dentry,
+				    const char *acl_name);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
@@ -915,6 +918,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+						  struct dentry *dentry,
+						  const char *acl_name)
+{ }
+
 static inline void security_inode_post_setxattr(struct dentry *dentry,
 		const char *name, const void *value, size_t size, int flags)
 { }
diff --git a/security/security.c b/security/security.c
index aabace9e24d9..554f4925323d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2323,6 +2323,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
 }
 
+/**
+ * security_inode_post_remove_acl() - Update inode sec after remove_acl op
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @acl_name: acl name
+ *
+ * Update inode security field after successful remove_acl operation on @dentry
+ * in @idmap. The posix acls are identified by @acl_name.
+ */
+void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+				    struct dentry *dentry, const char *acl_name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
+}
+
 /**
  * security_inode_post_setxattr() - Update the inode after a setxattr operation
  * @dentry: file
-- 
2.34.1

