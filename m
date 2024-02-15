Return-Path: <linux-fsdevel+bounces-11691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1985600C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDF280E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B712FF98;
	Thu, 15 Feb 2024 10:39:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A312FF73;
	Thu, 15 Feb 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993540; cv=none; b=giEJFI8Lwhmn5OClmjhqWB+awBuNARHLoJXw3HK0ODKyD/rG81rZsfg4iRjNvmdi4cbQq+PnUeUO6z5d8AuTE9JcPZ7nXY2xOBHroR8DSQNz+VJ4lOmcFyLq/jQVJciMCCuAqXwuzmZbb9hENtPZF745keLgDcqsGTEaSBFytDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993540; c=relaxed/simple;
	bh=d90Wk88D9MLxJNwgoxAatbz1le5As7ZOKygbQybgkq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkDZ9Po5HifscaQz1VId5Hf+SOKIu648N5xlQ5bXfkulAHWU/P16QQwAV8mPKVVwTcfie/TEWWm3j2uW8H+oRQpGz0C7tpNQrwQcJ80Mxio5lHUjKXDDrE46IdtxIr8JgWP0Q7+yAcnollSaRJkaP0js2yC+7MIHVntKhSqyu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb9zQ5XQsz9xxng;
	Thu, 15 Feb 2024 18:19:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 52B8714059B;
	Thu, 15 Feb 2024 18:38:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHABmc6c1lwxGNAg--.11795S3;
	Thu, 15 Feb 2024 11:38:49 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
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
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 21/25] ima: Move IMA-Appraisal to LSM infrastructure
Date: Thu, 15 Feb 2024 11:31:09 +0100
Message-Id: <20240215103113.2369171-22-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHABmc6c1lwxGNAg--.11795S3
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFWfKFy7uFykJryxGF4kZwb_yoWDAFy7pF
	s5K3WUC34rXFy7Wry0yFWDuwsY9ryYgry7X3y0ganayFn3Ar1jqFyftFy2yry5Cry8KF1v
	qF4qqrnxCr15trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UGZXrUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf5wAAsX

From: Roberto Sassu <roberto.sassu@huawei.com>

A few additional IMA hooks are needed to reset the cached appraisal
status, causing the file's integrity to be re-evaluated on next access.
Register these IMA-appraisal only functions separately from the rest of IMA
functions, as appraisal is a separate feature not necessarily enabled in
the kernel configuration.

Reuse the same approach as for other IMA functions, move hardcoded calls
from various places in the kernel to the LSM infrastructure. Declare the
functions as static and register them as hook implementations in
init_ima_appraise_lsm(), called by init_ima_lsm().

Also move the inline function ima_inode_remove_acl() from the public ima.h
header to ima_appraise.c.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/attr.c                             |  2 -
 include/linux/ima.h                   | 55 ---------------------------
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
 security/integrity/ima/ima_main.c     |  1 +
 security/security.c                   | 13 -------
 6 files changed, 35 insertions(+), 79 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 990e1b3a3c91..7e97313e7f70 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,7 +17,6 @@
 #include <linux/filelock.h>
 #include <linux/security.h>
 #include <linux/evm.h>
-#include <linux/ima.h>
 
 #include "internal.h"
 
@@ -503,7 +502,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
-		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 23ae24b60ecf..0bae61a15b60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -92,66 +92,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry, int ia_valid);
-extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			      const char *xattr_name, const void *xattr_value,
-			      size_t xattr_value_len, int flags);
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
-extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-				 const char *xattr_name);
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
index c0412100023e..a27fc10f84f7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
+void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
 
 #else
 static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
@@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
+{
+}
+
 #endif /* CONFIG_IMA_APPRAISE */
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 36abc84ba299..076451109637 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -636,8 +636,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
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
@@ -750,9 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
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
@@ -781,8 +781,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return result;
 }
 
-int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const char *acl_name, struct posix_acl *kacl)
+static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
@@ -790,8 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
-int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			  const char *xattr_name)
+static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 const char *xattr_name)
 {
 	int result;
 
@@ -803,3 +803,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
+void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
+{
+	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
+			   lsmid);
+}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d0826e864c29..b8b8891a9379 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1182,6 +1182,7 @@ static const struct lsm_id ima_lsmid = {
 static int __init init_ima_lsm(void)
 {
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
+	init_ima_appraise_lsm(&ima_lsmid);
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index a476af7f8aea..0030af4afa9d 100644
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
@@ -2309,9 +2308,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
@@ -2339,9 +2335,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
-	if (ret)
-		return ret;
-	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
 	if (ret)
 		return ret;
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
@@ -2402,9 +2395,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
-	if (ret)
-		return ret;
-	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
 	if (ret)
 		return ret;
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
@@ -2504,9 +2494,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
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


