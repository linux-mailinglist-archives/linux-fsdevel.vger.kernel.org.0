Return-Path: <linux-fsdevel+bounces-6109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C9813831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B27E1C20C0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309365EDC;
	Thu, 14 Dec 2023 17:16:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77E18C;
	Thu, 14 Dec 2023 09:16:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Srdtf6Gynz9y4ST;
	Fri, 15 Dec 2023 01:02:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CFC4B1400CC;
	Fri, 15 Dec 2023 01:16:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV8uOHtlU7aDAg--.53464S4;
	Thu, 14 Dec 2023 18:16:06 +0100 (CET)
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
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v8 22/24] evm: Make it independent from 'integrity' LSM
Date: Thu, 14 Dec 2023 18:08:32 +0100
Message-Id: <20231214170834.3324559-23-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCnpV8uOHtlU7aDAg--.53464S4
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFW3uw1xJw4UKry7CF4kWFg_yoW8Jr4rKo
	WfXwsxJr4UWF1fAFWFg3W2yFZruw4rGrWfArZ5XF4DC3W2y34kG34UGw15JFW3Xw4rGr4D
	C3srZa1kXFZ2qwn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UXXocUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj5enyQAAsG

From: Roberto Sassu <roberto.sassu@huawei.com>

Define a new structure for EVM-specific metadata, called evm_iint_cache,
and embed it in the inode security blob. Introduce evm_iint_inode() to
retrieve metadata, and register evm_inode_alloc_security() for the
inode_alloc_security LSM hook, to initialize the structure (before
splitting metadata, this task was done by iint_init_always()).

Keep the non-NULL checks after calling evm_iint_inode() except in
evm_inode_alloc_security(), to take into account inodes for which
security_inode_alloc() was not called. When using shared metadata,
obtaining a NULL pointer from integrity_iint_find() meant that the file
wasn't processed by IMA.

Given that from now on EVM relies on its own metadata, remove the iint
parameter from evm_verifyxattr(). Also, directly retrieve the iint in
evm_verify_hmac(), called by both evm_verifyxattr() and
evm_verify_current_integrity(), since now there is no performance penalty
in retrieving EVM metadata (constant time).

Replicate the management of the IMA_NEW_FILE flag (now EVM_NEW_FILE), by
introducing evm_post_path_mknod() and evm_file_free() to respectively set
and clear the new flag at the same time IMA does. A noteworthy difference
is that evm_post_path_mknod() cannot check if a file must be appraised.
Also, since IMA_NEW_FILE is always cleared in ima_check_last_writer() if it
is set, it is not necessary to maintain an inode version in EVM to
replicate the IMA logic (the inode version check is in OR).

Also, move the EVM-specific flag EVM_IMMUTABLE_DIGSIG to
security/integrity/evm/evm.h, since that definition is now unnecessary in
the common integrity layer.

Finally, switch to the LSM reservation mechanism for the EVM xattr, and
consequently decrement by one the number of xattrs to allocate in
security_inode_init_security().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h                   |  8 +--
 security/integrity/evm/evm.h          | 19 +++++++
 security/integrity/evm/evm_crypto.c   |  4 +-
 security/integrity/evm/evm_main.c     | 79 ++++++++++++++++++++-------
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/integrity.h        |  1 -
 security/security.c                   |  4 +-
 7 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index cb481eccc967..d48d6da32315 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,15 +12,12 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
-struct integrity_iint_cache;
-
 #ifdef CONFIG_EVM
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
-					     size_t xattr_value_len,
-					     struct integrity_iint_cache *iint);
+					     size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -48,8 +45,7 @@ static inline int evm_set_key(void *key, size_t keylen)
 static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 						    const char *xattr_name,
 						    void *xattr_value,
-						    size_t xattr_value_len,
-					struct integrity_iint_cache *iint)
+						    size_t xattr_value_len)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 53bd7fec93fa..eb1a2c343bd7 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -32,6 +32,25 @@ struct xattr_list {
 	bool enabled;
 };
 
+#define EVM_NEW_FILE			0x00000001
+#define EVM_IMMUTABLE_DIGSIG		0x00000002
+
+/* EVM integrity metadata associated with an inode */
+struct evm_iint_cache {
+	unsigned long flags;
+	enum integrity_status evm_status:4;
+};
+
+extern struct lsm_blob_sizes evm_blob_sizes;
+
+static inline struct evm_iint_cache *evm_iint_inode(const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return inode->i_security + evm_blob_sizes.lbs_inode;
+}
+
 extern int evm_initialized;
 
 #define EVM_ATTR_FSUUID		0x0001
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..7552d49d0725 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -322,10 +322,10 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 {
 	const struct evm_ima_xattr_data *xattr_data = NULL;
-	struct integrity_iint_cache *iint;
+	struct evm_iint_cache *iint;
 	int rc = 0;
 
-	iint = integrity_iint_find(inode);
+	iint = evm_iint_inode(inode);
 	if (iint && (iint->flags & EVM_IMMUTABLE_DIGSIG))
 		return 1;
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0cd014bfc093..e3a0dd7fae10 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -167,14 +167,14 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     const char *xattr_name,
 					     char *xattr_value,
-					     size_t xattr_value_len,
-					     struct integrity_iint_cache *iint)
+					     size_t xattr_value_len)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
 	struct signature_v2_hdr *hdr;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct evm_digest digest;
-	struct inode *inode;
+	struct inode *inode = d_backing_inode(dentry);
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
 	int rc, xattr_len, evm_immutable = 0;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
@@ -240,8 +240,6 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					(const char *)xattr_data, xattr_len,
 					digest.digest, digest.hdr.length);
 		if (!rc) {
-			inode = d_backing_inode(dentry);
-
 			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
 				if (iint)
 					iint->flags |= EVM_IMMUTABLE_DIGSIG;
@@ -389,7 +387,6 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
- * @iint: inode integrity metadata
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
@@ -402,19 +399,13 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  */
 enum integrity_status evm_verifyxattr(struct dentry *dentry,
 				      const char *xattr_name,
-				      void *xattr_value, size_t xattr_value_len,
-				      struct integrity_iint_cache *iint)
+				      void *xattr_value, size_t xattr_value_len)
 {
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
-	if (!iint) {
-		iint = integrity_iint_find(d_backing_inode(dentry));
-		if (!iint)
-			return INTEGRITY_UNKNOWN;
-	}
 	return evm_verify_hmac(dentry, xattr_name, xattr_value,
-				 xattr_value_len, iint);
+				 xattr_value_len);
 }
 EXPORT_SYMBOL_GPL(evm_verifyxattr);
 
@@ -431,7 +422,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 
 	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
 		return INTEGRITY_PASS;
-	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
+	return evm_verify_hmac(dentry, NULL, NULL, 0);
 }
 
 /*
@@ -503,14 +494,14 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 
 	evm_status = evm_verify_current_integrity(dentry);
 	if (evm_status == INTEGRITY_NOXATTRS) {
-		struct integrity_iint_cache *iint;
+		struct evm_iint_cache *iint;
 
 		/* Exception if the HMAC is not going to be calculated. */
 		if (evm_hmac_disabled())
 			return 0;
 
-		iint = integrity_iint_find(d_backing_inode(dentry));
-		if (iint && (iint->flags & IMA_NEW_FILE))
+		iint = evm_iint_inode(d_backing_inode(dentry));
+		if (iint && (iint->flags & EVM_NEW_FILE))
 			return 0;
 
 		/* exception for pseudo filesystems */
@@ -712,9 +703,9 @@ static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static void evm_reset_status(struct inode *inode)
 {
-	struct integrity_iint_cache *iint;
+	struct evm_iint_cache *iint;
 
-	iint = integrity_iint_find(inode);
+	iint = evm_iint_inode(inode);
 	if (iint)
 		iint->evm_status = INTEGRITY_UNKNOWN;
 }
@@ -979,6 +970,43 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL_GPL(evm_inode_init_security);
 
+static int evm_inode_alloc_security(struct inode *inode)
+{
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
+
+	/* Called by security_inode_alloc(), it cannot be NULL. */
+	iint->flags = 0UL;
+	iint->evm_status = INTEGRITY_UNKNOWN;
+
+	return 0;
+}
+
+static void evm_file_free(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
+	fmode_t mode = file->f_mode;
+
+	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
+		return;
+
+	if (iint && atomic_read(&inode->i_writecount) == 1)
+		iint->flags &= ~EVM_NEW_FILE;
+}
+
+static void __maybe_unused
+evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	if (iint)
+		iint->flags |= EVM_NEW_FILE;
+}
+
 #ifdef CONFIG_EVM_LOAD_X509
 void __init evm_load_x509(void)
 {
@@ -1030,6 +1058,11 @@ static struct security_hook_list evm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
 	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
 	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
+	LSM_HOOK_INIT(inode_alloc_security, evm_inode_alloc_security),
+	LSM_HOOK_INIT(file_release, evm_file_free),
+#ifdef CONFIG_SECURITY_PATH
+	LSM_HOOK_INIT(path_post_mknod, evm_post_path_mknod),
+#endif
 };
 
 static const struct lsm_id evm_lsmid = {
@@ -1043,10 +1076,16 @@ static int __init init_evm_lsm(void)
 	return 0;
 }
 
+struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct evm_iint_cache),
+	.lbs_xattr_count = 1,
+};
+
 DEFINE_LSM(evm) = {
 	.name = "evm",
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
+	.blobs = &evm_blob_sizes,
 };
 
 late_initcall(init_evm);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 076451109637..1dd6ee72a20a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -520,7 +520,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
-				 rc < 0 ? 0 : rc, iint);
+				 rc < 0 ? 0 : rc);
 	switch (status) {
 	case INTEGRITY_PASS:
 	case INTEGRITY_PASS_IMMUTABLE:
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 59eaddd84434..7a97c269a072 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -37,7 +37,6 @@
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
-#define EVM_IMMUTABLE_DIGSIG	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_MODSIG_ALLOWED	0x20000000
 #define IMA_CHECK_BLACKLIST	0x40000000
diff --git a/security/security.c b/security/security.c
index 18a70aa707ad..7741d2d076c5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1716,8 +1716,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		return 0;
 
 	if (initxattrs) {
-		/* Allocate +1 for EVM and +1 as terminator. */
-		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
+		/* Allocate +1 as terminator. */
+		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
 				     sizeof(*new_xattrs), GFP_NOFS);
 		if (!new_xattrs)
 			return -ENOMEM;
-- 
2.34.1


