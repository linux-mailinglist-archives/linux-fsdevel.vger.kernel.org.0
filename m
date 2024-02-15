Return-Path: <linux-fsdevel+bounces-11692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8C856017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176E71C2256C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C72D12F5B8;
	Thu, 15 Feb 2024 10:39:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF872130AEF;
	Thu, 15 Feb 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993559; cv=none; b=bgHREav8V7lglGjbgFUeIzkQttfoJTlMPVJG2udOvHMst1cZbH48KF4aVTnyOli6wauNrXvMN7herkeGXmDzDqu4D5CvQU4FVrkyjEyGkBt6GLkDnk3W9MIN7qIA6ubF2M9ox3ZiJbEwwEaOdqXXw9/cyTDHLH95TmjIQ1/5lMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993559; c=relaxed/simple;
	bh=KyG8VaGJOE20Bb1LrlnUAYrrFjBxTbvFcIRdT0DfvUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RA8oiZbkfO2QK0G/TzBk7Kd0oFfqpZaE1pAdyzadLCqViM8YOKSMYNi3RdOl4QxJ9OgBhZsGZlFawBUjH+KSTA4ESdZS9jHG4vFfoqcHBDaXWWFApXbTiOplFGfkRZpzScrAOiKDN/iMTebwc4bv+l3Ib/kRX0E7d2hdAzW5688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TbB4D3ySrz9xFQg;
	Thu, 15 Feb 2024 18:23:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 39C75140732;
	Thu, 15 Feb 2024 18:39:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHABmc6c1lwxGNAg--.11795S4;
	Thu, 15 Feb 2024 11:39:03 +0100 (CET)
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
Subject: [PATCH v10 22/25] evm: Move to LSM infrastructure
Date: Thu, 15 Feb 2024 11:31:10 +0100
Message-Id: <20240215103113.2369171-23-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHABmc6c1lwxGNAg--.11795S4
X-Coremail-Antispam: 1UD129KBjvAXoWfuF47Cw1DKF47AFW3Aw1xGrg_yoW8ZFWkGo
	WIqwsrtF4kWr13JrW5Gw1xKFyvgay7GrWrJ3Z5C3yDC3W2vw18C34fCa13J3W5Xr1rGrW2
	q3s7Z34jgF47Xr1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYW7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUrdgADUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf5wABsW

From: Roberto Sassu <roberto.sassu@huawei.com>

As for IMA, move hardcoded EVM function calls from various places in the
kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
(last and always enabled like 'ima'). The order in the Makefile ensures
that 'evm' hooks are executed after 'ima' ones.

Make EVM functions as static (except for evm_inode_init_security(), which
is exported), and register them as hook implementations in init_evm_lsm().
Also move the inline functions evm_inode_remove_acl(),
evm_inode_post_remove_acl(), and evm_inode_post_set_acl() from the public
evm.h header to evm_main.c.

Unlike before (see commit to move IMA to the LSM infrastructure),
evm_inode_post_setattr(), evm_inode_post_set_acl(),
evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
executed for private inodes.

Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/attr.c                                     |   2 -
 fs/posix_acl.c                                |   3 -
 fs/xattr.c                                    |   2 -
 include/linux/evm.h                           | 113 -----------------
 include/uapi/linux/lsm.h                      |   1 +
 security/integrity/evm/evm_main.c             | 118 +++++++++++++++---
 security/security.c                           |  43 ++-----
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 8 files changed, 116 insertions(+), 169 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 7e97313e7f70..4d0d75953107 100644
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
index 0d2371240c1b..5c90239e3f2b 100644
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
index f891c260a971..f8b643f91a98 100644
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
index 3faabdd47852..cb481eccc967 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -21,45 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
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
-extern int evm_inode_copy_up_xattr(const char *name);
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
@@ -94,80 +55,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
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
-static inline int  evm_inode_copy_up_xattr(const char *name)
-{
-	return 0;
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
index b3b7fd699b63..33d8c9f4aa6b 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -63,6 +63,7 @@ struct lsm_ctx {
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
 #define LSM_ID_IMA		111
+#define LSM_ID_EVM		112
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d35143179699..0a089af83a45 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -589,9 +589,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
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
 
@@ -621,8 +621,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -672,9 +672,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
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
 
@@ -713,6 +715,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -761,9 +781,11 @@ bool evm_revalidate_status(const char *xattr_name)
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
@@ -782,6 +804,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
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
@@ -792,7 +829,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
  * No need to take the i_mutex lock here, as this function is called from
  * vfs_removexattr() which takes the i_mutex.
  */
-void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
+static void evm_inode_post_removexattr(struct dentry *dentry,
+				       const char *xattr_name)
 {
 	if (!evm_revalidate_status(xattr_name))
 		return;
@@ -808,6 +846,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
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
@@ -831,8 +885,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
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
@@ -883,8 +937,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -901,7 +955,7 @@ void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
 
-int evm_inode_copy_up_xattr(const char *name)
+static int evm_inode_copy_up_xattr(const char *name)
 {
 	if (strcmp(name, XATTR_NAME_EVM) == 0)
 		return 1; /* Discard */
@@ -1004,4 +1058,36 @@ static int __init init_evm(void)
 	return error;
 }
 
+static struct security_hook_list evm_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
+	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
+	LSM_HOOK_INIT(inode_copy_up_xattr, evm_inode_copy_up_xattr),
+	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
+	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),
+	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
+	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
+	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
+	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
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
+static int __init init_evm_lsm(void)
+{
+	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), &evm_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(evm) = {
+	.name = "evm",
+	.init = init_evm_lsm,
+	.order = LSM_ORDER_LAST,
+};
+
 late_initcall(init_evm);
diff --git a/security/security.c b/security/security.c
index 0030af4afa9d..6b439242d117 100644
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
 #include <linux/overflow.h>
 #include <net/flow.h>
@@ -51,7 +51,8 @@
 	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_IMA) ? 1 : 0))
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -1741,10 +1742,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!xattr_count)
 		goto out;
 
-	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
-				      &xattr_count);
-	if (ret)
-		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
 	for (; xattr_count > 0; xattr_count--)
@@ -2236,14 +2233,9 @@ int security_inode_permission(struct inode *inode, int mask)
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
 
@@ -2308,9 +2300,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
+	return ret;
 }
 
 /**
@@ -2329,15 +2319,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
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
@@ -2390,14 +2375,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
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
@@ -2433,7 +2413,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
-	evm_inode_post_setxattr(dentry, name, value, size, flags);
 }
 
 /**
@@ -2494,9 +2473,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(idmap, dentry, name);
-	if (ret)
-		return ret;
-	return evm_inode_removexattr(idmap, dentry, name);
+	return ret;
 }
 
 /**
@@ -2700,7 +2677,7 @@ int security_inode_copy_up_xattr(const char *name)
 			return rc;
 	}
 
-	return evm_inode_copy_up_xattr(name);
+	return LSM_RET_DEFAULT(inode_copy_up_xattr);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 17333787cb2f..4d5d4cee2586 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -125,6 +125,9 @@ TEST(correct_lsm_list_modules)
 		case LSM_ID_IMA:
 			name = "ima";
 			break;
+		case LSM_ID_EVM:
+			name = "evm";
+			break;
 		default:
 			name = "INVALID";
 			break;
-- 
2.34.1


