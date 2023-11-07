Return-Path: <linux-fsdevel+bounces-2253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6E7E40D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8D31C20C8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44F30D05;
	Tue,  7 Nov 2023 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6030CF2;
	Tue,  7 Nov 2023 13:46:43 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A45B2D5E;
	Tue,  7 Nov 2023 05:46:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPq0k6Q8vz9xrpH;
	Tue,  7 Nov 2023 21:33:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnFXUiP0plvHc3AA--.54683S11;
	Tue, 07 Nov 2023 14:46:05 +0100 (CET)
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
Subject: [PATCH v5 19/23] ima: Move to LSM infrastructure
Date: Tue,  7 Nov 2023 14:40:08 +0100
Message-Id: <20231107134012.682009-20-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAnFXUiP0plvHc3AA--.54683S11
X-Coremail-Antispam: 1UD129KBjvAXoWfAFW7Kr4UWr4ftFy8GFyDZFb_yoW8tw1Dto
	WIqwsxJr4Fgr13GayYkF1SyFsxuws8K3yfJrW3urZ8W3W2yw1Ut34F9a17Ja4UXw4rKa17
	uas7J3yrZF4UJw1rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YbiQABs-
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Move hardcoded IMA function calls (not appraisal-specific functions) from
various places in the kernel to the LSM infrastructure, by introducing a
new LSM named 'ima' (at the end of the LSM list and always enabled like
'integrity').

Make moved functions as static (except ima_post_key_create_or_update(),
which is not in ima_main.c), and register them as implementation of the
respective hooks in the new function init_ima_lsm(). Conditionally register
ima_post_path_mknod() if CONFIG_SECURITY_PATH is enabled, otherwise the
path_post_mknod hook won't be available.

Call init_ima_lsm() from integrity_lsm_init() (renamed from
integrity_iintcache_init()), the init method of the 'integrity' LSM, to
make sure that the integrity subsystem is ready at the time IMA hooks are
registered, and to keep the original ordering of IMA and EVM functions as
when they were hardcoded.

Finally, introduce ima_get_lsm_id() to pass the IMA LSM ID back to the
'integrity' LSM for registration of the integrity-specific hooks.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_table.c                   |  2 -
 fs/namei.c                        |  6 --
 fs/nfsd/vfs.c                     |  7 ---
 fs/open.c                         |  1 -
 include/linux/ima.h               | 94 -------------------------------
 include/uapi/linux/lsm.h          |  1 +
 security/integrity/iint.c         | 11 +++-
 security/integrity/ima/ima.h      |  6 ++
 security/integrity/ima/ima_main.c | 93 +++++++++++++++++++++++-------
 security/integrity/integrity.h    | 16 ++++++
 security/keys/key.c               |  9 +--
 security/security.c               | 56 ++++--------------
 12 files changed, 116 insertions(+), 186 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 64ed74555e64..e64b0057fa72 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -26,7 +26,6 @@
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
 #include <linux/task_work.h>
-#include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
 
@@ -386,7 +385,6 @@ static void __fput(struct file *file)
 	locks_remove_file(file);
 
 	security_file_pre_free(file);
-	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
diff --git a/fs/namei.c b/fs/namei.c
index adb3ab27951a..37cc0988308f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -27,7 +27,6 @@
 #include <linux/fsnotify.h>
 #include <linux/personality.h>
 #include <linux/security.h>
-#include <linux/ima.h>
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
@@ -3622,8 +3621,6 @@ static int do_open(struct nameidata *nd,
 		error = vfs_open(&nd->path, file);
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
-	if (!error)
-		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
 		error = handle_truncate(idmap, file);
 	if (unlikely(error > 0)) {
@@ -3687,7 +3684,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		spin_unlock(&inode->i_lock);
 	}
 	security_inode_post_create_tmpfile(idmap, inode);
-	ima_post_create_tmpfile(idmap, inode);
 	return 0;
 }
 
@@ -4036,8 +4032,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
-			if (!error)
-				ima_post_path_mknod(idmap, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0c3f07a8bba..e491392a1243 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -25,7 +25,6 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
 #include <linux/jhash.h>
-#include <linux/ima.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -883,12 +882,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out;
 	}
 
-	host_err = ima_file_check(file, may_flags);
-	if (host_err) {
-		fput(file);
-		goto out;
-	}
-
 	if (may_flags & NFSD_MAY_64BIT_COOKIE)
 		file->f_mode |= FMODE_64BITHASH;
 	else
diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..c8bb9bd5259f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -29,7 +29,6 @@
 #include <linux/audit.h>
 #include <linux/falloc.h>
 #include <linux/fs_struct.h>
-#include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
 #include <linux/mnt_idmapping.h>
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 31ef6c3c3207..23ae24b60ecf 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,24 +16,6 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
-extern int ima_bprm_check(struct linux_binprm *bprm);
-extern int ima_file_check(struct file *file, int mask);
-extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-				    struct inode *inode);
-extern void ima_file_free(struct file *file);
-extern int ima_file_mmap(struct file *file, unsigned long reqprot,
-			 unsigned long prot, unsigned long flags);
-extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-			     unsigned long prot);
-extern int ima_load_data(enum kernel_load_data_id id, bool contents);
-extern int ima_post_load_data(char *buf, loff_t size,
-			      enum kernel_load_data_id id, char *description);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
-			 bool contents);
-extern int ima_post_read_file(struct file *file, char *buf, loff_t size,
-			      enum kernel_read_file_id id);
-extern void ima_post_path_mknod(struct mnt_idmap *idmap,
-				struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
@@ -58,68 +40,6 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
 	return HASH_ALGO__LAST;
 }
 
-static inline int ima_bprm_check(struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static inline int ima_file_check(struct file *file, int mask)
-{
-	return 0;
-}
-
-static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-					   struct inode *inode)
-{
-}
-
-static inline void ima_file_free(struct file *file)
-{
-	return;
-}
-
-static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
-				unsigned long prot, unsigned long flags)
-{
-	return 0;
-}
-
-static inline int ima_file_mprotect(struct vm_area_struct *vma,
-				    unsigned long reqprot, unsigned long prot)
-{
-	return 0;
-}
-
-static inline int ima_load_data(enum kernel_load_data_id id, bool contents)
-{
-	return 0;
-}
-
-static inline int ima_post_load_data(char *buf, loff_t size,
-				     enum kernel_load_data_id id,
-				     char *description)
-{
-	return 0;
-}
-
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
-				bool contents)
-{
-	return 0;
-}
-
-static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
-				     enum kernel_read_file_id id)
-{
-	return 0;
-}
-
-static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
-				       struct dentry *dentry)
-{
-	return;
-}
-
 static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
 	return -EOPNOTSUPP;
@@ -170,20 +90,6 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
-#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
-extern void ima_post_key_create_or_update(struct key *keyring,
-					  struct key *key,
-					  const void *payload, size_t plen,
-					  unsigned long flags, bool create);
-#else
-static inline void ima_post_key_create_or_update(struct key *keyring,
-						 struct key *key,
-						 const void *payload,
-						 size_t plen,
-						 unsigned long flags,
-						 bool create) {}
-#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
-
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f0386880a78e..ee7d034255a9 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -61,6 +61,7 @@ struct lsm_ctx {
 #define LSM_ID_LOCKDOWN		108
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
+#define LSM_ID_IMA		111
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index d4419a2a1e24..87f2c0d69f78 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -193,20 +193,25 @@ static void iint_init_once(void *foo)
 	memset(iint, 0, sizeof(*iint));
 }
 
-static int __init integrity_iintcache_init(void)
+static int __init integrity_lsm_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, iint_init_once);
+	init_ima_lsm();
 	return 0;
 }
+
+/*
+ * Keep it until IMA and EVM can use disjoint integrity metadata, and their
+ * initialization order can be swapped without change in their behavior.
+ */
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
-	.init = integrity_iintcache_init,
+	.init = integrity_lsm_init,
 	.order = LSM_ORDER_LAST,
 };
 
-
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..c0412100023e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -127,6 +127,12 @@ void ima_load_kexec_buffer(void);
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   const void *payload, size_t plen,
+				   unsigned long flags, bool create);
+#endif
+
 /*
  * The default binary_runtime_measurements list format is defined as the
  * platform native format.  The canonical format is defined as little-endian.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 02021ee467d3..f923ff5c6524 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -189,7 +189,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  *
  * Flag files that changed, based on i_version
  */
-void ima_file_free(struct file *file)
+static void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
@@ -427,8 +427,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_mmap(struct file *file, unsigned long reqprot,
-		  unsigned long prot, unsigned long flags)
+static int ima_file_mmap(struct file *file, unsigned long reqprot,
+			 unsigned long prot, unsigned long flags)
 {
 	u32 secid;
 	int ret;
@@ -466,8 +466,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
  *
  * On mprotect change success, return 0.  On failure, return -EACESS.
  */
-int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-		      unsigned long prot)
+static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+			     unsigned long prot)
 {
 	struct ima_template_desc *template = NULL;
 	struct file *file;
@@ -525,7 +525,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_bprm_check(struct linux_binprm *bprm)
+static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
@@ -551,7 +551,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_check(struct file *file, int mask)
+static int ima_file_check(struct file *file, int mask)
 {
 	u32 secid;
 
@@ -560,7 +560,6 @@ int ima_file_check(struct file *file, int mask)
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
-EXPORT_SYMBOL_GPL(ima_file_check);
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			    size_t buf_size)
@@ -685,8 +684,9 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
  * Skip calling process_measurement(), but indicate which newly, created
  * tmpfiles are in policy.
  */
-void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-			     struct inode *inode)
+static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
+				    struct inode *inode)
+
 {
 	struct integrity_iint_cache *iint;
 	int must_appraise;
@@ -717,8 +717,8 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-void ima_post_path_mknod(struct mnt_idmap *idmap,
-			 struct dentry *dentry)
+static void __maybe_unused
+ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
@@ -753,8 +753,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
-		  bool contents)
+static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
+			 bool contents)
 {
 	enum ima_hooks func;
 	u32 secid;
@@ -803,8 +803,8 @@ const int read_idmap[READING_MAX_ID] = {
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_post_read_file(struct file *file, char *buf, loff_t size,
-		       enum kernel_read_file_id read_id)
+static int ima_post_read_file(struct file *file, char *buf, loff_t size,
+			      enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
 	u32 secid;
@@ -837,7 +837,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_load_data(enum kernel_load_data_id id, bool contents)
+static int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
 	bool ima_enforce, sig_enforce;
 
@@ -891,9 +891,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_post_load_data(char *buf, loff_t size,
-		       enum kernel_load_data_id load_id,
-		       char *description)
+static int ima_post_load_data(char *buf, loff_t size,
+			      enum kernel_load_data_id load_id,
+			      char *description)
 {
 	if (load_id == LOADING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -1122,4 +1122,57 @@ static int __init init_ima(void)
 	return error;
 }
 
+static struct security_hook_list ima_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(file_post_open, ima_file_check),
+	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
+	LSM_HOOK_INIT(file_pre_free_security, ima_file_free),
+	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
+	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
+	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
+	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
+	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
+	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
+#ifdef CONFIG_SECURITY_PATH
+	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
+#endif
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
+#endif
+};
+
+static const struct lsm_id ima_lsmid = {
+	.name = "ima",
+	.id = LSM_ID_IMA,
+};
+
+/* Return the IMA LSM ID, if IMA is enabled or NULL if not. */
+const struct lsm_id *ima_get_lsm_id(void)
+{
+	return &ima_lsmid;
+}
+
+/*
+ * Since with the LSM_ORDER_LAST there is no guarantee about the ordering
+ * within the .lsm_info.init section, ensure that IMA hooks are before EVM
+ * ones, by letting the 'integrity' LSM call init_ima_lsm() to initialize the
+ * 'ima' and 'evm' LSMs in this sequence.
+ */
+void __init init_ima_lsm(void)
+{
+	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
+}
+
+/* Introduce a dummy function as 'ima' init method (it cannot be NULL). */
+static int __init dummy_init_ima_lsm(void)
+{
+	return 0;
+}
+
+DEFINE_LSM(ima) = {
+	.name = "ima",
+	.init = dummy_init_ima_lsm,
+	.order = LSM_ORDER_LAST,
+};
+
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9561db7cf6b4..3098cae1c27c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -18,6 +18,7 @@
 #include <crypto/hash.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/lsm_hooks.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -193,6 +194,21 @@ extern struct dentry *integrity_dir;
 
 struct modsig;
 
+#ifdef CONFIG_IMA
+const struct lsm_id *ima_get_lsm_id(void);
+void __init init_ima_lsm(void);
+#else
+static inline const struct lsm_id *ima_get_lsm_id(void)
+{
+	return NULL;
+}
+
+static inline void __init init_ima_lsm(void)
+{
+}
+
+#endif
+
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
diff --git a/security/keys/key.c b/security/keys/key.c
index f75fe66c2f03..80fc2f203a0c 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,7 +13,6 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
-#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -937,8 +936,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	security_key_post_create_or_update(keyring, key, payload, plen, flags,
 					   true);
-	ima_post_key_create_or_update(keyring, key, payload, plen,
-				      flags, true);
 
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
@@ -970,13 +967,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	key_ref = __key_update(key_ref, &prep);
 
-	if (!IS_ERR(key_ref)) {
+	if (!IS_ERR(key_ref))
 		security_key_post_create_or_update(keyring, key, payload, plen,
 						   flags, false);
-		ima_post_key_create_or_update(keyring, key,
-					      payload, plen,
-					      flags, false);
-	}
 
 	goto error_free_prep;
 }
diff --git a/security/security.c b/security/security.c
index 859189722ab8..b2fdcbaa4b30 100644
--- a/security/security.c
+++ b/security/security.c
@@ -50,7 +50,8 @@
 	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -1182,12 +1183,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
  */
 int security_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
-
-	ret = call_int_hook(bprm_check_security, 0, bprm);
-	if (ret)
-		return ret;
-	return ima_bprm_check(bprm);
+	return call_int_hook(bprm_check_security, 0, bprm);
 }
 
 /**
@@ -2883,13 +2879,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 int security_mmap_file(struct file *file, unsigned long prot,
 		       unsigned long flags)
 {
-	unsigned long prot_adj = mmap_prot(file, prot);
-	int ret;
-
-	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
-	if (ret)
-		return ret;
-	return ima_file_mmap(file, prot, prot_adj, flags);
+	return call_int_hook(mmap_file, 0, file, prot, mmap_prot(file, prot),
+			     flags);
 }
 
 /**
@@ -2918,12 +2909,7 @@ int security_mmap_addr(unsigned long addr)
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot)
 {
-	int ret;
-
-	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
-	if (ret)
-		return ret;
-	return ima_file_mprotect(vma, reqprot, prot);
+	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
 }
 
 /**
@@ -3253,12 +3239,7 @@ int security_kernel_module_request(char *kmod_name)
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 			      bool contents)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
-	if (ret)
-		return ret;
-	return ima_read_file(file, id, contents);
+	return call_int_hook(kernel_read_file, 0, file, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
@@ -3278,12 +3259,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
-	if (ret)
-		return ret;
-	return ima_post_read_file(file, buf, size, id);
+	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
@@ -3298,12 +3274,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
  */
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_load_data, 0, id, contents);
-	if (ret)
-		return ret;
-	return ima_load_data(id, contents);
+	return call_int_hook(kernel_load_data, 0, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
@@ -3325,13 +3296,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id,
 				   char *description)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
-			    description);
-	if (ret)
-		return ret;
-	return ima_post_load_data(buf, size, id, description);
+	return call_int_hook(kernel_post_load_data, 0, buf, size, id,
+			     description);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 
-- 
2.34.1


