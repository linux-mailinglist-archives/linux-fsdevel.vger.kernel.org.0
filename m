Return-Path: <linux-fsdevel+bounces-2255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67A7E40F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7A41C208E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1279430D0B;
	Tue,  7 Nov 2023 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFD30CF3;
	Tue,  7 Nov 2023 13:48:07 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E719A0;
	Tue,  7 Nov 2023 05:48:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPpz45RMLz9xsll;
	Tue,  7 Nov 2023 21:31:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHtXXdP0pltoA3AA--.60646S3;
	Tue, 07 Nov 2023 14:47:34 +0100 (CET)
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
Subject: [PATCH v5 21/23] evm: Move to LSM infrastructure
Date: Tue,  7 Nov 2023 14:40:10 +0100
Message-Id: <20231107134012.682009-22-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDHtXXdP0pltoA3AA--.60646S3
X-Coremail-Antispam: 1UD129KBjvAXoWfuF48GryDKF48GFWUGw13XFb_yoW8ur4DZo
	WIqwsrKF4kWr1fA3y5G3WxKFWv9ay3GrW5JF95C3yDC3W2vw1UC34SkF13J3W5Xr1rGrW2
	q34Iv340gFW7Xr1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UGZXrUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5IbhQABs0
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

As for IMA, move hardcoded EVM function calls from various places in the
kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
(at the end of the LSM list and always enabled, like 'ima' and
'integrity').

Make EVM functions as static (except for evm_inode_init_security(), which
is exported), and register them as hook implementations in init_evm_lsm(),
called by integrity_lsm_init() to keep the original ordering of IMA and EVM
functions.

Introduce evm_get_lsm_id() to pass the EVM LSM ID back to the 'integrity'
LSM for registration of the integrity-specific hooks.

Finally, switch to the LSM reservation mechanism for the EVM xattr, and
consequently decrement by one the number of xattrs to allocate in
security_inode_init_security().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/attr.c                         |   2 -
 fs/posix_acl.c                    |   3 -
 fs/xattr.c                        |   2 -
 include/linux/evm.h               | 107 -----------------------
 include/uapi/linux/lsm.h          |   1 +
 security/integrity/evm/evm_main.c | 137 ++++++++++++++++++++++++++----
 security/integrity/iint.c         |   1 +
 security/integrity/integrity.h    |  15 ++++
 security/security.c               |  45 +++-------
 9 files changed, 150 insertions(+), 163 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 38841f3ebbcb..b51bd7c9b4a7 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -16,7 +16,6 @@
 #include <linux/fcntl.h>
 #include <linux/filelock.h>
 #include <linux/security.h>
-#include <linux/evm.h>
 
 #include "internal.h"
 
@@ -502,7 +501,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		security_inode_post_setattr(idmap, dentry, ia_valid);
-		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
 	return error;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index e3fbe1a9f3f5..ae67479cd2b6 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -26,7 +26,6 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/iversion.h>
 #include <linux/security.h>
-#include <linux/evm.h>
 #include <linux/fsnotify.h>
 #include <linux/filelock.h>
 
@@ -1138,7 +1137,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_xattr(dentry);
 		security_inode_post_set_acl(dentry, acl_name, kacl);
-		evm_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
 out_inode_unlock:
@@ -1247,7 +1245,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_xattr(dentry);
 		security_inode_post_remove_acl(idmap, dentry, acl_name);
-		evm_inode_post_remove_acl(idmap, dentry, acl_name);
 	}
 
 out_inode_unlock:
diff --git a/fs/xattr.c b/fs/xattr.c
index 84a4aa566c02..2660bc7effdc 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -16,7 +16,6 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/security.h>
-#include <linux/evm.h>
 #include <linux/syscalls.h>
 #include <linux/export.h>
 #include <linux/fsnotify.h>
@@ -557,7 +556,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 
 	fsnotify_xattr(dentry);
 	security_inode_post_removexattr(dentry, name);
-	evm_inode_post_removexattr(dentry, name);
 
 out:
 	return error;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 437d4076a3b3..cb481eccc967 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -21,44 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     void *xattr_value,
 					     size_t xattr_value_len,
 					     struct integrity_iint_cache *iint);
-extern int evm_inode_setattr(struct mnt_idmap *idmap,
-			     struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry, int ia_valid);
-extern int evm_inode_setxattr(struct mnt_idmap *idmap,
-			      struct dentry *dentry, const char *name,
-			      const void *value, size_t size, int flags);
-extern void evm_inode_post_setxattr(struct dentry *dentry,
-				    const char *xattr_name,
-				    const void *xattr_value,
-				    size_t xattr_value_len,
-				    int flags);
-extern int evm_inode_removexattr(struct mnt_idmap *idmap,
-				 struct dentry *dentry, const char *xattr_name);
-extern void evm_inode_post_removexattr(struct dentry *dentry,
-				       const char *xattr_name);
-static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
-					     struct dentry *dentry,
-					     const char *acl_name)
-{
-	evm_inode_post_removexattr(dentry, acl_name);
-}
-extern int evm_inode_set_acl(struct mnt_idmap *idmap,
-			     struct dentry *dentry, const char *acl_name,
-			     struct posix_acl *kacl);
-static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
-}
-static inline void evm_inode_post_set_acl(struct dentry *dentry,
-					  const char *acl_name,
-					  struct posix_acl *kacl)
-{
-	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
-}
-
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -93,75 +55,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 }
 #endif
 
-static inline int evm_inode_setattr(struct mnt_idmap *idmap,
-				    struct dentry *dentry, struct iattr *attr)
-{
-	return 0;
-}
-
-static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
-					  struct dentry *dentry, int ia_valid)
-{
-	return;
-}
-
-static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
-				     struct dentry *dentry, const char *name,
-				     const void *value, size_t size, int flags)
-{
-	return 0;
-}
-
-static inline void evm_inode_post_setxattr(struct dentry *dentry,
-					   const char *xattr_name,
-					   const void *xattr_value,
-					   size_t xattr_value_len,
-					   int flags)
-{
-	return;
-}
-
-static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
-					struct dentry *dentry,
-					const char *xattr_name)
-{
-	return 0;
-}
-
-static inline void evm_inode_post_removexattr(struct dentry *dentry,
-					      const char *xattr_name)
-{
-	return;
-}
-
-static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
-					     struct dentry *dentry,
-					     const char *acl_name)
-{
-	return;
-}
-
-static inline int evm_inode_set_acl(struct mnt_idmap *idmap,
-				    struct dentry *dentry, const char *acl_name,
-				    struct posix_acl *kacl)
-{
-	return 0;
-}
-
-static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
-				       struct dentry *dentry,
-				       const char *acl_name)
-{
-	return 0;
-}
-
-static inline void evm_inode_post_set_acl(struct dentry *dentry,
-					  const char *acl_name,
-					  struct posix_acl *kacl)
-{
-	return;
-}
-
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
 					  struct xattr *xattrs,
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index ee7d034255a9..825339bcd580 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -62,6 +62,7 @@ struct lsm_ctx {
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
 #define LSM_ID_IMA		111
+#define LSM_ID_EVM		112
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ea84a6f835ff..21560874e5fc 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -566,9 +566,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
  * userspace from writing HMAC value.  Writing 'security.evm' requires
  * requires CAP_SYS_ADMIN privileges.
  */
-int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len, int flags)
+static int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const char *xattr_name, const void *xattr_value,
+			      size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
@@ -598,8 +598,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
  * the current value is valid.
  */
-int evm_inode_removexattr(struct mnt_idmap *idmap,
-			  struct dentry *dentry, const char *xattr_name)
+static int evm_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 const char *xattr_name)
 {
 	/* Policy permits modification of the protected xattrs even though
 	 * there's no HMAC key loaded
@@ -649,9 +649,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
  * Prevent modifying posix acls causing the EVM HMAC to be re-calculated
  * and 'security.evm' xattr updated, unless the existing 'security.evm' is
  * valid.
+ *
+ * Return: zero on success, -EPERM on failure.
  */
-int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const char *acl_name, struct posix_acl *kacl)
+static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			     const char *acl_name, struct posix_acl *kacl)
 {
 	enum integrity_status evm_status;
 
@@ -690,6 +692,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return -EPERM;
 }
 
+/**
+ * evm_inode_remove_acl - Protect the EVM extended attribute from posix acls
+ * @idmap: idmap of the mount
+ * @dentry: pointer to the affected dentry
+ * @acl_name: name of the posix acl
+ *
+ * Prevent removing posix acls causing the EVM HMAC to be re-calculated
+ * and 'security.evm' xattr updated, unless the existing 'security.evm' is
+ * valid.
+ *
+ * Return: zero on success, -EPERM on failure.
+ */
+static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+				const char *acl_name)
+{
+	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
+}
+
 static void evm_reset_status(struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
@@ -738,9 +758,11 @@ bool evm_revalidate_status(const char *xattr_name)
  * __vfs_setxattr_noperm().  The caller of which has taken the inode's
  * i_mutex lock.
  */
-void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
-			     const void *xattr_value, size_t xattr_value_len,
-			     int flags)
+static void evm_inode_post_setxattr(struct dentry *dentry,
+				    const char *xattr_name,
+				    const void *xattr_value,
+				    size_t xattr_value_len,
+				    int flags)
 {
 	if (!evm_revalidate_status(xattr_name))
 		return;
@@ -756,6 +778,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
 }
 
+/**
+ * evm_inode_post_set_acl - Update the EVM extended attribute from posix acls
+ * @dentry: pointer to the affected dentry
+ * @acl_name: name of the posix acl
+ * @kacl: pointer to the posix acls
+ *
+ * Update the 'security.evm' xattr with the EVM HMAC re-calculated after setting
+ * posix acls.
+ */
+static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				   struct posix_acl *kacl)
+{
+	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
+}
+
 /**
  * evm_inode_post_removexattr - update 'security.evm' after removing the xattr
  * @dentry: pointer to the affected dentry
@@ -766,7 +803,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
  * No need to take the i_mutex lock here, as this function is called from
  * vfs_removexattr() which takes the i_mutex.
  */
-void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
+static void evm_inode_post_removexattr(struct dentry *dentry,
+				       const char *xattr_name)
 {
 	if (!evm_revalidate_status(xattr_name))
 		return;
@@ -782,6 +820,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
+/**
+ * evm_inode_post_remove_acl - Update the EVM extended attribute from posix acls
+ * @idmap: idmap of the mount
+ * @dentry: pointer to the affected dentry
+ * @acl_name: name of the posix acl
+ *
+ * Update the 'security.evm' xattr with the EVM HMAC re-calculated after
+ * removing posix acls.
+ */
+static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
+					     struct dentry *dentry,
+					     const char *acl_name)
+{
+	evm_inode_post_removexattr(dentry, acl_name);
+}
+
 static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
@@ -805,8 +859,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
  */
-int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		      struct iattr *attr)
+static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			     struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 	enum integrity_status evm_status;
@@ -853,8 +907,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			    int ia_valid)
+static void evm_inode_post_setattr(struct mnt_idmap *idmap,
+				   struct dentry *dentry, int ia_valid)
 {
 	if (!evm_revalidate_status(NULL))
 		return;
@@ -964,4 +1018,57 @@ static int __init init_evm(void)
 	return error;
 }
 
+static struct security_hook_list evm_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
+	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
+	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
+	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
+	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
+	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
+	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
+	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),
+	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
+	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
+	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
+};
+
+static const struct lsm_id evm_lsmid = {
+	.name = "evm",
+	.id = LSM_ID_EVM,
+};
+
+/* Return the EVM LSM ID, if EVM is enabled or NULL if not. */
+const struct lsm_id *evm_get_lsm_id(void)
+{
+	return &evm_lsmid;
+}
+
+/*
+ * Since with the LSM_ORDER_LAST there is no guarantee about the ordering
+ * within the .lsm_info.init section, ensure that IMA hooks are before EVM
+ * ones, by letting the 'integrity' LSM call init_evm_lsm() to initialize the
+ * 'ima' and 'evm' LSMs in this sequence.
+ */
+void __init init_evm_lsm(void)
+{
+	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), &evm_lsmid);
+}
+
+static struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
+	.lbs_xattr_count = 1,
+};
+
+/* Introduce a dummy function as 'evm' init method (it cannot be NULL). */
+static int __init dummy_init_evm_lsm(void)
+{
+	return 0;
+}
+
+DEFINE_LSM(evm) = {
+	.name = "evm",
+	.init = dummy_init_evm_lsm,
+	.order = LSM_ORDER_LAST,
+	.blobs = &evm_blob_sizes,
+};
+
 late_initcall(init_evm);
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 87f2c0d69f78..0b0ac71142e8 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -199,6 +199,7 @@ static int __init integrity_lsm_init(void)
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, iint_init_once);
 	init_ima_lsm();
+	init_evm_lsm();
 	return 0;
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 3098cae1c27c..7534ec06324e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -209,6 +209,21 @@ static inline void __init init_ima_lsm(void)
 
 #endif
 
+#ifdef CONFIG_EVM
+const struct lsm_id *evm_get_lsm_id(void);
+void __init init_evm_lsm(void);
+#else
+static inline const struct lsm_id *evm_get_lsm_id(void)
+{
+	return NULL;
+}
+
+static inline void __init init_evm_lsm(void)
+{
+}
+
+#endif
+
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
diff --git a/security/security.c b/security/security.c
index 456f3fe74116..9703549b6ddc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -20,13 +20,13 @@
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
-#include <linux/evm.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
+#include <linux/xattr.h>
 #include <linux/msg.h>
 #include <net/flow.h>
 
@@ -50,7 +50,8 @@
 	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_IMA) ? 1 : 0))
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -1715,8 +1716,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		return 0;
 
 	if (initxattrs) {
-		/* Allocate +1 for EVM and +1 as terminator. */
-		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
+		/* Allocate +1 as terminator. */
+		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
 				     sizeof(*new_xattrs), GFP_NOFS);
 		if (!new_xattrs)
 			return -ENOMEM;
@@ -1740,10 +1741,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!xattr_count)
 		goto out;
 
-	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
-				      &xattr_count);
-	if (ret)
-		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
 	for (; xattr_count > 0; xattr_count--)
@@ -2235,14 +2232,9 @@ int security_inode_permission(struct inode *inode, int mask)
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
-	int ret;
-
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
-	if (ret)
-		return ret;
-	return evm_inode_setattr(idmap, dentry, attr);
+	return call_int_hook(inode_setattr, 0, idmap, dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
@@ -2307,9 +2299,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
+	return ret;
 }
 
 /**
@@ -2328,15 +2318,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
 {
-	int ret;
-
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
-			    kacl);
-	if (ret)
-		return ret;
-	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
+	return call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
+			     kacl);
 }
 
 /**
@@ -2389,14 +2374,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
 int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name)
 {
-	int ret;
-
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
-	if (ret)
-		return ret;
-	return evm_inode_remove_acl(idmap, dentry, acl_name);
+	return call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
 }
 
 /**
@@ -2432,7 +2412,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
-	evm_inode_post_setxattr(dentry, name, value, size, flags);
 }
 
 /**
@@ -2493,9 +2472,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(idmap, dentry, name);
-	if (ret)
-		return ret;
-	return evm_inode_removexattr(idmap, dentry, name);
+	return ret;
 }
 
 /**
-- 
2.34.1


