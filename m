Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E016A9EB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCCS20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjCCS2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:28:21 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855D10F3;
        Fri,  3 Mar 2023 10:28:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PSx8365xcz9v7Hj;
        Sat,  4 Mar 2023 02:19:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHCAQOPAJkKY9rAQ--.12963S3;
        Fri, 03 Mar 2023 19:27:49 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 24/28] ima: Move to LSM infrastructure
Date:   Fri,  3 Mar 2023 19:25:58 +0100
Message-Id: <20230303182602.1088032-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHCAQOPAJkKY9rAQ--.12963S3
X-Coremail-Antispam: 1UD129KBjvAXoWfWr18Zr4kXr4UCryrZr1kZrb_yoW8uryUAo
        WIqwsxJr4Fgr13GayYkF1SyFsxuws8K3yrJrZ3urZ8u3W2yw1Ut34j9F47Ja4UXw4rKa1U
        Cas7J3yrZa18Jw1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F
        4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j7
        jjgUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4YvgAABsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Remove hardcoded IMA function calls (not for appraisal) from the LSM
infrastructure, the VFS, NFS and the key subsystem.

Make those functions as static (except for ima_file_check() which is
exported, and ima_post_key_create_or_update(), which is not in ima_main.c),
and register them as implementation of the respective hooks in the new
function init_ima_lsm().

Call init_ima_lsm() from integrity_lsm_init() (renamed from
integrity_iintcache_init()), to make sure that the integrity subsystem is
ready at the time IMA hooks are registered. The same will be done for EVM,
by calling init_evm_lsm() just after init_ima_lsm().

Put 'integrity' at the end of the LSM list by setting the order to
LSM_ORDER_LAST. 'integrity' must be the last so that EVM can calculate the
HMAC on xattrs previously provided by the other selected LSMs.

Setting the order to LSM_ORDER_LAST also causes 'integrity' to be always
enabled regardless of the LSM choice. This avoids any risk that IMA and EVM
functions are not called when transitioning from an old kernel to one where
IMA and EVM are stacked.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/file_table.c                   |   2 -
 fs/namei.c                        |   7 ---
 fs/nfsd/vfs.c                     |   7 ---
 fs/open.c                         |   1 -
 include/linux/ima.h               | 100 ------------------------------
 security/integrity/iint.c         |   8 ++-
 security/integrity/ima/ima.h      |   7 +++
 security/integrity/ima/ima_main.c |  64 +++++++++++++------
 security/integrity/integrity.h    |   8 +++
 security/keys/key.c               |   9 +--
 security/security.c               |  53 +++-------------
 11 files changed, 74 insertions(+), 192 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 3150e613aec..37f9bf5ed97 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -26,7 +26,6 @@
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
 #include <linux/task_work.h>
-#include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
 
@@ -313,7 +312,6 @@ static void __fput(struct file *file)
 	locks_remove_file(file);
 
 	security_file_pre_free(file);
-	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
diff --git a/fs/namei.c b/fs/namei.c
index 8c4fdfd81d4..cd700d4e8cf 100644
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
@@ -3560,8 +3559,6 @@ static int do_open(struct nameidata *nd,
 		error = vfs_open(&nd->path, file);
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
-	if (!error)
-		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
 		error = handle_truncate(idmap, file);
 	if (unlikely(error > 0)) {
@@ -3625,7 +3622,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		spin_unlock(&inode->i_lock);
 	}
 	security_inode_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
-	ima_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
 	return 0;
 }
 
@@ -3968,9 +3964,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
-			if (!error)
-				ima_post_path_mknod(idmap, &path, dentry, mode,
-						    dev);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4b86c158ffb..50038722602 100644
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
@@ -858,12 +857,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out_nfserr;
 	}
 
-	host_err = ima_file_check(file, may_flags);
-	if (host_err) {
-		fput(file);
-		goto out_nfserr;
-	}
-
 	if (may_flags & NFSD_MAY_64BIT_COOKIE)
 		file->f_mode |= FMODE_64BITHASH;
 	else
diff --git a/fs/open.c b/fs/open.c
index 4401a73d403..5d99c2bc061 100644
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
index f56c6280667..6980e160ee5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,26 +16,6 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
-extern int ima_bprm_check(struct linux_binprm *bprm);
-extern int ima_file_check(struct file *file, int mask);
-extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-				    struct inode *dir, struct dentry *dentry,
-				    umode_t mode);
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
-				const struct path *dir, struct dentry *dentry,
-				umode_t mode, unsigned int dev);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
@@ -60,72 +40,6 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
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
-					   struct inode *dir,
-					   struct dentry *dentry,
-					   umode_t mode)
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
-				       const struct path *dir,
-				       struct dentry *dentry,
-				       umode_t mode, unsigned int dev)
-{
-	return;
-}
-
 static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
 	return -EOPNOTSUPP;
@@ -176,20 +90,6 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
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
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f799..bbadf974b31 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -172,19 +172,21 @@ static void init_once(void *foo)
 	mutex_init(&iint->mutex);
 }
 
-static int __init integrity_iintcache_init(void)
+static int __init integrity_lsm_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
+
+	init_ima_lsm();
 	return 0;
 }
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
-	.init = integrity_iintcache_init,
+	.init = integrity_lsm_init,
+	.order = LSM_ORDER_LAST,
 };
 
-
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c99..7bdc7cdce07 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -127,6 +127,13 @@ void ima_load_kexec_buffer(void);
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  const void *payload, size_t plen,
+					  unsigned long flags, bool create);
+#endif
+
 /*
  * The default binary_runtime_measurements list format is defined as the
  * platform native format.  The canonical format is defined as little-endian.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b7835e287d9..567b7af0f55 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/lsm_hooks.h>
 #include <linux/fs.h>
 
 #include "ima.h"
@@ -184,7 +185,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  *
  * Flag files that changed, based on i_version
  */
-void ima_file_free(struct file *file)
+static void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
@@ -409,8 +410,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
@@ -448,8 +449,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
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
@@ -507,7 +508,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_bprm_check(struct linux_binprm *bprm)
+static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
@@ -669,9 +670,8 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
  * Skip calling process_measurement(), but indicate which newly, created
  * tmpfiles are in policy.
  */
-void ima_post_create_tmpfile(struct mnt_idmap *idmap,
-			     struct inode *dir, struct dentry *dentry,
-			     umode_t mode)
+static void ima_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
+				    struct dentry *dentry, umode_t mode)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
@@ -706,9 +706,9 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-void ima_post_path_mknod(struct mnt_idmap *idmap,
-			 const struct path *dir, struct dentry *dentry,
-			 umode_t mode, unsigned int dev)
+static void __maybe_unused
+ima_post_path_mknod(struct mnt_idmap *idmap, const struct path *dir,
+		    struct dentry *dentry, umode_t mode, unsigned int dev)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
@@ -747,8 +747,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
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
@@ -797,8 +797,8 @@ const int read_idmap[READING_MAX_ID] = {
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
@@ -831,7 +831,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_load_data(enum kernel_load_data_id id, bool contents)
+static int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
 	bool ima_enforce, sig_enforce;
 
@@ -885,9 +885,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
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
@@ -1116,4 +1116,28 @@ static int __init init_ima(void)
 	return error;
 }
 
+static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
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
+void __init init_ima_lsm(void)
+{
+	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");
+}
+
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bd..c72d375a356 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -191,6 +191,14 @@ extern struct dentry *integrity_dir;
 
 struct modsig;
 
+#ifdef CONFIG_IMA
+void __init init_ima_lsm(void);
+#else
+static inline void __init init_ima_lsm(void)
+{
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
diff --git a/security/keys/key.c b/security/keys/key.c
index 0f9c6faf349..2acf9fa8073 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,7 +13,6 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
-#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,8 +935,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	security_key_post_create_or_update(keyring, key, payload, plen, flags,
 					   true);
-	ima_post_key_create_or_update(keyring, key, payload, plen,
-				      flags, true);
 
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
@@ -969,13 +966,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
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
index 24f52ba3218..5ca8d89eb57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1097,12 +1097,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
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
@@ -2849,13 +2844,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
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
@@ -2884,12 +2874,7 @@ int security_mmap_addr(unsigned long addr)
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
@@ -3219,12 +3204,7 @@ int security_kernel_module_request(char *kmod_name)
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
 
@@ -3244,12 +3224,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
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
 
@@ -3264,12 +3239,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
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
 
@@ -3291,13 +3261,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
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
2.25.1

