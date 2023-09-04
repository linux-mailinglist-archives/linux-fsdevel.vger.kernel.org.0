Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C07918E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352094AbjIDNmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351984AbjIDNmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:42:42 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11449CDB;
        Mon,  4 Sep 2023 06:42:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfTvt4kBHz9xGZ7;
        Mon,  4 Sep 2023 21:27:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCXSblt3vVkorkeAg--.30599S4;
        Mon, 04 Sep 2023 14:41:37 +0100 (CET)
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
Subject: [PATCH v3 22/25] ima: Move IMA-Appraisal to LSM infrastructure
Date:   Mon,  4 Sep 2023 15:40:46 +0200
Message-Id: <20230904134049.1802006-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCXSblt3vVkorkeAg--.30599S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtryDJrWDGr13AFyDuryDWrg_yoWDJr45pF
        s5K3WkC34rXFy7Wry0yFWDuwsY9r1UWry7X3y0ganayFnxJr1jqFyftFy2yry5Cry0gF1v
        qF4qqrsxCr15tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbp6wtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5OBfgACsQ
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

Do the registration of IMA-Appraisal functions separately from the rest of
IMA functions, as appraisal is a separate feature not necessarily enabled
in the kernel configuration.

Reuse the same approach as for other IMA functions, remove hardcoded calls
from the LSM infrastructure or the other places, declare the functions as
static and register them as hook implementations in
init_ima_appraise_lsm(), called by init_ima_lsm() to chain the
initialization.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/attr.c                             |  2 -
 include/linux/ima.h                   | 55 ---------------------------
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
 security/integrity/ima/ima_main.c     |  1 +
 security/security.c                   | 13 -------
 6 files changed, 35 insertions(+), 79 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 3c309eb456c6..63fb60195409 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,7 +17,6 @@
 #include <linux/filelock.h>
 #include <linux/security.h>
 #include <linux/evm.h>
-#include <linux/ima.h>
 
 #include "internal.h"
 
@@ -487,7 +486,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
-		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 58591b5cbdb4..586e2e18e494 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -98,66 +98,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry, int ia_valid);
-int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len, int flags);
-extern int ima_inode_set_acl(struct mnt_idmap *idmap,
-			     struct dentry *dentry, const char *acl_name,
-			     struct posix_acl *kacl);
-static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
-}
-
-int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			  const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
 	return 0;
 }
-
-static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
-					  struct dentry *dentry, int ia_valid)
-{
-	return;
-}
-
-static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
-				     struct dentry *dentry,
-				     const char *xattr_name,
-				     const void *xattr_value,
-				     size_t xattr_value_len,
-				     int flags)
-{
-	return 0;
-}
-
-static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
-				    struct dentry *dentry, const char *acl_name,
-				    struct posix_acl *kacl)
-{
-
-	return 0;
-}
-
-static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
-					struct dentry *dentry,
-					const char *xattr_name)
-{
-	return 0;
-}
-
-static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return 0;
-}
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c0412100023e..d19aa9c068da 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
+void __init init_ima_appraise_lsm(void);
 
 #else
 static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
@@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline void __init init_ima_appraise_lsm(void)
+{
+}
+
 #endif /* CONFIG_IMA_APPRAISE */
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index c35e3537eb87..8fe6ea70f02b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -634,8 +634,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void ima_inode_post_setattr(struct mnt_idmap *idmap,
-			    struct dentry *dentry, int ia_valid)
+static void ima_inode_post_setattr(struct mnt_idmap *idmap,
+				   struct dentry *dentry, int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
@@ -748,9 +748,9 @@ static int validate_hash_algo(struct dentry *dentry,
 	return -EACCES;
 }
 
-int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len, int flags)
+static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const char *xattr_name, const void *xattr_value,
+			      size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
 	int digsig = 0;
@@ -779,8 +779,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return result;
 }
 
-int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const char *acl_name, struct posix_acl *kacl)
+static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
@@ -788,8 +788,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
-int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			  const char *xattr_name)
+static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 const char *xattr_name)
 {
 	int result;
 
@@ -801,3 +801,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 	return result;
 }
+
+static int ima_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+				const char *acl_name)
+{
+	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
+}
+
+static struct security_hook_list ima_appraise_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_post_setattr, ima_inode_post_setattr),
+	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
+	LSM_HOOK_INIT(inode_set_acl, ima_inode_set_acl),
+	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
+	LSM_HOOK_INIT(inode_remove_acl, ima_inode_remove_acl),
+};
+
+void __init init_ima_appraise_lsm(void)
+{
+	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
+			   "integrity");
+}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0e4f882fcdce..c31e11a5bc31 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1141,6 +1141,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 void __init init_ima_lsm(void)
 {
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");
+	init_ima_appraise_lsm();
 }
 
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/security.c b/security/security.c
index 0b196d3f01b8..eb686f9471ea 100644
--- a/security/security.c
+++ b/security/security.c
@@ -20,7 +20,6 @@
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
-#include <linux/ima.h>
 #include <linux/evm.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
@@ -2217,9 +2216,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
@@ -2247,9 +2243,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
-	if (ret)
-		return ret;
-	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
@@ -2310,9 +2303,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
-	if (ret)
-		return ret;
-	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
 	if (ret)
 		return ret;
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
@@ -2412,9 +2402,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(idmap, dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(idmap, dentry, name);
-- 
2.34.1

