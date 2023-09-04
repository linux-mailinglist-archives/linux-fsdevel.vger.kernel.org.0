Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A87918F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353214AbjIDNnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353136AbjIDNm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:42:57 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD941981;
        Mon,  4 Sep 2023 06:42:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfTwL1PD6z9xGYt;
        Mon,  4 Sep 2023 21:28:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCXSblt3vVkorkeAg--.30599S6;
        Mon, 04 Sep 2023 14:42:01 +0100 (CET)
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
Subject: [PATCH v3 24/25] integrity: Move integrity functions to the LSM infrastructure
Date:   Mon,  4 Sep 2023 15:40:48 +0200
Message-Id: <20230904134049.1802006-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCXSblt3vVkorkeAg--.30599S6
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13XF1xGFWxAFyxGFyfWFg_yoW7Ar15pF
        srKayUGrn5ZFyIkFWkAF13ua1fK3yqgrW7Wws8Cw1ktFyqvr10qF4DJry5uFy3WrWrtr1I
        qrsIgr1UCw1DtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4+BZAABsW
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

Remove hardcoded calls to integrity functions from the LSM infrastructure.
Also move the global declaration of integrity_inode_get() to
security/integrity/integrity.h, so that the function can be still called by
IMA.

Register integrity functions as hook implementations in
integrity_lsm_init().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/integrity.h      | 26 --------------------------
 security/integrity/iint.c      | 11 ++++++++++-
 security/integrity/integrity.h |  7 +++++++
 security/security.c            |  9 +--------
 4 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..afaae7ad26f4 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -21,38 +21,12 @@ enum integrity_status {
 
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
-extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
 extern void __init integrity_load_keys(void);
 
 #else
-static inline struct integrity_iint_cache *
-				integrity_inode_get(struct inode *inode)
-{
-	return NULL;
-}
-
-static inline void integrity_inode_free(struct inode *inode)
-{
-	return;
-}
-
 static inline void integrity_load_keys(void)
 {
 }
 #endif /* CONFIG_INTEGRITY */
 
-#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-
-extern int integrity_kernel_module_request(char *kmod_name);
-
-#else
-
-static inline int integrity_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
-
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index dd03f978b45c..70ee803a33ea 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -138,7 +138,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
  *
  * Free the integrity information(iint) associated with an inode.
  */
-void integrity_inode_free(struct inode *inode)
+static void integrity_inode_free(struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
 
@@ -167,12 +167,21 @@ static void init_once(void *foo)
 	mutex_init(&iint->mutex);
 }
 
+static struct security_hook_list integrity_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
+#endif
+};
+
 static int __init integrity_lsm_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
 
+	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks),
+			   "integrity");
 	init_ima_lsm();
 	init_evm_lsm();
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 83a465ac9013..e020c365997b 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -178,6 +178,7 @@ struct integrity_iint_cache {
  * integrity data associated with an inode.
  */
 struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
+struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
 
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
@@ -251,12 +252,18 @@ static inline int __init integrity_load_cert(const unsigned int id,
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 int asymmetric_verify(struct key *keyring, const char *sig,
 		      int siglen, const char *data, int datalen);
+int integrity_kernel_module_request(char *kmod_name);
 #else
 static inline int asymmetric_verify(struct key *keyring, const char *sig,
 				    int siglen, const char *data, int datalen)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int integrity_kernel_module_request(char *kmod_name)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
diff --git a/security/security.c b/security/security.c
index 5e700557e434..5f26a0c16d48 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/integrity.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
@@ -1497,7 +1496,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
  */
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -3090,12 +3088,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
  */
 int security_kernel_module_request(char *kmod_name)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
-	if (ret)
-		return ret;
-	return integrity_kernel_module_request(kmod_name);
+	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
 /**
-- 
2.34.1

