Return-Path: <linux-fsdevel+bounces-7977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3D82DFAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28851C22128
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2518C25;
	Mon, 15 Jan 2024 18:25:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFAD18AF9;
	Mon, 15 Jan 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDKvD4clXz9xqxT;
	Tue, 16 Jan 2024 02:10:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 314A91407FA;
	Tue, 16 Jan 2024 02:25:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBmAeKVlZIWcAA--.52410S2;
	Mon, 15 Jan 2024 19:25:19 +0100 (CET)
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
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 20/25] ima: Move to LSM infrastructure
Date: Mon, 15 Jan 2024 19:18:04 +0100
Message-Id: <20240115181809.885385-21-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3YBmAeKVlZIWcAA--.52410S2
X-Coremail-Antispam: 1UD129KBjvAXoWfAFWrur45Kw48GFyUXFWrKrg_yoW5Jr48to
	WIqwsxJr4Fgr13GFWFkF1SyFsxWws8K3yrJrWa9rZ8u3W2yw1UK3409a17Aa4UXa1fKa1U
	W3s7J3yrZa18Jw1rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMI
	IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1AwIDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5SSjAAAs+

From: Roberto Sassu <roberto.sassu@huawei.com>

Move hardcoded IMA function calls (not appraisal-specific functions) from
various places in the kernel to the LSM infrastructure, by introducing a
new LSM named 'ima' (at the end of the LSM list and always enabled like
'integrity').

Having IMA before EVM in the Makefile is sufficient to preserve the
relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
and thus the order of IMA and EVM function calls as when they were
hardcoded.

Make moved functions as static (except ima_post_key_create_or_update(),
which is not in ima_main.c), and register them as implementation of the
respective hooks in the new function init_ima_lsm().

Select CONFIG_SECURITY_PATH, to ensure that the path-based LSM hook
path_post_mknod is always available and ima_post_path_mknod() is always
executed to mark files as new, as before the move.

A slight difference is that IMA and EVM functions registered for the
inode_post_setattr, inode_post_removexattr, path_post_mknod,
inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
won't be executed for private inodes. Since those inodes are supposed to be
fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
and kernel-internal tmpfs files.

Conditionally register ima_post_key_create_or_update() if
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled. Also, conditionally register
ima_kernel_module_request() if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled.

Finally, add the LSM_ID_IMA case in lsm_list_modules_test.c.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_table.c                               |   2 -
 fs/namei.c                                    |   6 -
 fs/nfsd/vfs.c                                 |   7 --
 fs/open.c                                     |   1 -
 include/linux/ima.h                           | 104 ------------------
 include/uapi/linux/lsm.h                      |   1 +
 security/integrity/Makefile                   |   1 +
 security/integrity/ima/Kconfig                |   1 +
 security/integrity/ima/ima.h                  |   6 +
 security/integrity/ima/ima_main.c             |  78 +++++++++----
 security/integrity/integrity.h                |   1 +
 security/keys/key.c                           |   9 +-
 security/security.c                           |  63 ++---------
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 14 files changed, 83 insertions(+), 200 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c72dc75f2bd3..0401ac98281c 100644
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
 
 	security_file_release(file);
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
index 0f9af283cbc8..23ae24b60ecf 100644
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
@@ -256,14 +162,4 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 	return false;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-
-#if defined(CONFIG_IMA) && defined(CONFIG_INTEGRITY_ASYMMETRIC_KEYS)
-extern int ima_kernel_module_request(char *kmod_name);
-#else
-static inline int ima_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-#endif
 #endif /* _LINUX_IMA_H */
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f8aef9ade549..b3b7fd699b63 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -62,6 +62,7 @@ struct lsm_ctx {
 #define LSM_ID_LOCKDOWN		108
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
+#define LSM_ID_IMA		111
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index d0ffe37dc1d6..92b63039c654 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -18,5 +18,6 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/load_powerpc.o \
                                      platform_certs/keyring_handler.o
+# The relative order of the 'ima' and 'evm' LSMs depends on the order below.
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b98bfe9efd0c..475c32615006 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,6 +8,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
+	select SECURITY_PATH
 	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
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
index 908fa026ec58..483ccd24e214 100644
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
@@ -717,8 +717,7 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-void ima_post_path_mknod(struct mnt_idmap *idmap,
-			 struct dentry *dentry)
+static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
@@ -753,8 +752,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
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
@@ -803,8 +802,8 @@ const int read_idmap[READING_MAX_ID] = {
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
@@ -837,7 +836,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_load_data(enum kernel_load_data_id id, bool contents)
+static int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
 	bool ima_enforce, sig_enforce;
 
@@ -891,9 +890,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
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
@@ -1110,7 +1109,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  *
  * Return: Zero if it is safe to load the kernel module, -EINVAL otherwise.
  */
-int ima_kernel_module_request(char *kmod_name)
+static int ima_kernel_module_request(char *kmod_name)
 {
 	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
 		return -EINVAL;
@@ -1151,4 +1150,41 @@ static int __init init_ima(void)
 	return error;
 }
 
+static struct security_hook_list ima_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(file_post_open, ima_file_check),
+	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
+	LSM_HOOK_INIT(file_release, ima_file_free),
+	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
+	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
+	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
+	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
+	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
+	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
+	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
+#endif
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
+#endif
+};
+
+static const struct lsm_id ima_lsmid = {
+	.name = "ima",
+	.id = LSM_ID_IMA,
+};
+
+static int __init init_ima_lsm(void)
+{
+	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(ima) = {
+	.name = "ima",
+	.init = init_ima_lsm,
+	.order = LSM_ORDER_LAST,
+};
+
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9561db7cf6b4..59eaddd84434 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -18,6 +18,7 @@
 #include <crypto/hash.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/lsm_hooks.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
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
index 6c6571a141a1..aa17b47d44c1 100644
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
@@ -2901,13 +2897,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
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
@@ -2936,12 +2927,7 @@ int security_mmap_addr(unsigned long addr)
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
@@ -3250,12 +3236,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
  */
 int security_kernel_module_request(char *kmod_name)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
-	if (ret)
-		return ret;
-	return ima_kernel_module_request(kmod_name);
+	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
 /**
@@ -3271,12 +3252,7 @@ int security_kernel_module_request(char *kmod_name)
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
 
@@ -3296,12 +3272,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
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
 
@@ -3316,12 +3287,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
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
 
@@ -3343,13 +3309,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
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
 
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 9df29b1e3497..17333787cb2f 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -122,6 +122,9 @@ TEST(correct_lsm_list_modules)
 		case LSM_ID_LANDLOCK:
 			name = "landlock";
 			break;
+		case LSM_ID_IMA:
+			name = "ima";
+			break;
 		default:
 			name = "INVALID";
 			break;
-- 
2.34.1


