Return-Path: <linux-fsdevel+bounces-4520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914E800044
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C903D280F22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C157125C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924851734;
	Thu, 30 Nov 2023 15:20:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4ShBfK2XSCz9y9TC;
	Fri,  1 Dec 2023 07:07:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3ECC214074C;
	Fri,  1 Dec 2023 07:20:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3OdGGllXRuuAQ--.2350S5;
	Fri, 01 Dec 2023 00:20:47 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 22/23] integrity: Remove 'integrity' LSM and move integrity functions to 'ima' LSM
Date: Fri,  1 Dec 2023 00:19:47 +0100
Message-Id: <20231130231948.2545638-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130231948.2545638-1-roberto.sassu@huaweicloud.com>
References: <20231130231948.2545638-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXU3OdGGllXRuuAQ--.2350S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWDJFW7JF4kWw4ktF1rtFb_yoWxZw4xpF
	sFgayUJr1rZFy29FWkAFy5uF4fK39Ygry7Wws8Cw1vyFyvvr1jqF4DAryUZFy3WFWrt3WI
	yrs0gr45Cw1DtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj5ceSwAAsn

From: Roberto Sassu <roberto.sassu@huawei.com>

Move the 'integrity' LSM tasks to the 'ima' LSM, and remove the former.

In particular, let 'ima' manage integrity metadata by reserving space in
the security blob for a pointer to the integrity_iint_cache structure, by
initializing the corresponding memory cache, and by registering
integrity_inode_free() for the inode_free_security LSM hook.

Also move the global declaration of integrity_inode_get() and
integrity_inode_free() to security/integrity/integrity.h, so that they can
be still called by IMA.

Finally, register integrity_kernel_module_request() in 'ima' for the
kernel_module_request LSM hook, since it is the one affected by the crypto
subsystem trying to load kernel modules, and remove the 'integrity' LSM.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/integrity.h         | 26 --------------------------
 security/integrity/iint.c         | 19 ++++++++++++-------
 security/integrity/ima/ima_main.c |  5 +++++
 security/integrity/integrity.h    |  9 +++++++++
 security/security.c               |  9 +--------
 5 files changed, 27 insertions(+), 41 deletions(-)

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
index d4419a2a1e24..c36054041b84 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -127,6 +127,13 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
 
+	/*
+	 * After removing the 'integrity' LSM, the 'ima' LSM calls
+	 * integrity_iintcache_init() to initialize iint_cache.
+	 */
+	if (!IS_ENABLED(CONFIG_IMA))
+		return NULL;
+
 	iint = integrity_iint_find(inode);
 	if (iint)
 		return iint;
@@ -193,19 +200,17 @@ static void iint_init_once(void *foo)
 	memset(iint, 0, sizeof(*iint));
 }
 
-static int __init integrity_iintcache_init(void)
+/*
+ * Initialize the integrity metadata cache from IMA, since it is the only LSM
+ * that really needs it. EVM can work without it.
+ */
+int __init integrity_iintcache_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, iint_init_once);
 	return 0;
 }
-DEFINE_LSM(integrity) = {
-	.name = "integrity",
-	.init = integrity_iintcache_init,
-	.order = LSM_ORDER_LAST,
-};
-
 
 /*
  * integrity_kernel_read - read data from the file
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 079f629bf369..3f59cce3fa02 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1138,6 +1138,10 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #endif
 #ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
+#endif
+	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
 #endif
 };
 
@@ -1148,6 +1152,7 @@ static const struct lsm_id ima_lsmid = {
 
 static int __init init_ima_lsm(void)
 {
+	integrity_iintcache_init();
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
 	init_ima_appraise_lsm(&ima_lsmid);
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 59eaddd84434..26d3b08dca1c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -180,6 +180,9 @@ struct integrity_iint_cache {
  * integrity data associated with an inode.
  */
 struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
+struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
+void integrity_inode_free(struct inode *inode);
+int __init integrity_iintcache_init(void);
 
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
@@ -236,12 +239,18 @@ static inline int __init integrity_load_cert(const unsigned int id,
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
index 778043a626a6..351a124b771c 100644
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
@@ -1597,7 +1596,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
  */
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -3182,12 +3180,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
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


