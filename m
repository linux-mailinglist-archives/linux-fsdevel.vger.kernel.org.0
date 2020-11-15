Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF12B3439
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKOKrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:47:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59713 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgKOKqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:46:53 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFRp-0000Kt-Df; Sun, 15 Nov 2020 10:39:53 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 32/39] ima: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:37:11 +0100
Message-Id: <20201115103718.298186-33-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IMA does sometimes access the inode's i_uid and compares it against the rules'
fowner. Enable IMA to handle idmapped mounts by passing down the mount's user
namespace. We simply make use of the helpers we introduced before.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/attr.c                                    |  2 +-
 fs/namei.c                                   |  4 +--
 include/linux/ima.h                          | 15 ++++++-----
 security/integrity/ima/ima.h                 | 19 ++++++++-----
 security/integrity/ima/ima_api.c             | 10 ++++---
 security/integrity/ima/ima_appraise.c        | 14 +++++-----
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_main.c            | 28 ++++++++++++--------
 security/integrity/ima/ima_policy.c          | 17 ++++++------
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 10 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 36383cd3a986..2d55b0c36544 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -357,7 +357,7 @@ int notify_change(struct user_namespace *user_ns, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(dentry);
+		ima_inode_post_setattr(user_ns, dentry);
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
diff --git a/fs/namei.c b/fs/namei.c
index 976ee05c5027..4cebcb002c4f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3333,7 +3333,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *user_ns,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
-	ima_post_create_tmpfile(inode);
+	ima_post_create_tmpfile(user_ns, inode);
 	return child;
 
 out_err:
@@ -3645,7 +3645,7 @@ static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 			error = vfs_create(user_ns, path.dentry->d_inode,
 					   dentry, mode, true);
 			if (!error)
-				ima_post_path_mknod(dentry);
+				ima_post_path_mknod(user_ns, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(user_ns, path.dentry->d_inode, dentry,
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8fa7bcfb2da2..c3e3c260ad40 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,7 +16,7 @@ struct linux_binprm;
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
-extern void ima_post_create_tmpfile(struct inode *inode);
+extern void ima_post_create_tmpfile(struct user_namespace *user_ns, struct inode *inode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
@@ -27,7 +27,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
 			 bool contents);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
-extern void ima_post_path_mknod(struct dentry *dentry);
+extern void ima_post_path_mknod(struct user_namespace *user_ns,
+				struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 
@@ -61,7 +62,8 @@ static inline int ima_file_check(struct file *file, int mask)
 	return 0;
 }
 
-static inline void ima_post_create_tmpfile(struct inode *inode)
+static inline void ima_post_create_tmpfile(struct user_namespace *user_ns,
+					   struct inode *inode)
 {
 }
 
@@ -105,7 +107,8 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	return 0;
 }
 
-static inline void ima_post_path_mknod(struct dentry *dentry)
+static inline void ima_post_path_mknod(struct user_namespace *user_ns,
+				       struct dentry *dentry)
 {
 	return;
 }
@@ -141,7 +144,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct dentry *dentry);
+extern void ima_inode_post_setattr(struct user_namespace *user_ns, struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
@@ -151,7 +154,7 @@ static inline bool is_ima_appraise_enabled(void)
 	return 0;
 }
 
-static inline void ima_inode_post_setattr(struct dentry *dentry)
+static inline void ima_inode_post_setattr(struct user_namespace *user_ns, struct dentry *dentry)
 {
 	return;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..54da7b1a2faa 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -252,8 +252,9 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
+int ima_get_action(struct user_namespace *user_ns, struct inode *inode,
+		   const struct cred *cred, u32 secid, int mask,
+		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
@@ -265,7 +266,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
+void process_buffer_measurement(struct user_namespace *user_ns,
+				struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
 				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
@@ -280,8 +282,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct user_namespace *user_ns, struct inode *inode,
+		     const struct cred *cred, u32 secid, enum ima_hooks func,
+		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring);
 void ima_init_policy(void);
@@ -312,7 +315,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig);
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
+int ima_must_appraise(struct user_namespace *user_ns, struct inode *inode,
+		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func);
@@ -339,7 +343,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline int ima_must_appraise(struct inode *inode, int mask,
+static inline int ima_must_appraise(struct user_namespace *user_ns,
+				    struct inode *inode, int mask,
 				    enum ima_hooks func)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..ec51ada849a5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -162,6 +162,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 
 /**
  * ima_get_action - appraise & measure decision based on policy.
+ * @user_ns: userns of the mount through which the inode is accessed
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
  * @secid: secid of the task being validated
@@ -183,8 +184,9 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
+int ima_get_action(struct user_namespace *user_ns, struct inode *inode,
+		   const struct cred *cred, u32 secid, int mask,
+		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *keyring)
 {
@@ -192,8 +194,8 @@ int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, keyring);
+	return ima_match_policy(user_ns, inode, cred, secid, func, mask, flags,
+				pcr, template_desc, keyring);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3492f0b2da1c..162f00660a4a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -63,7 +63,8 @@ bool is_ima_appraise_enabled(void)
  *
  * Return 1 to appraise or hash
  */
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
+int ima_must_appraise(struct user_namespace *user_ns, struct inode *inode,
+		      int mask, enum ima_hooks func)
 {
 	u32 secid;
 
@@ -71,8 +72,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 		return 0;
 
 	security_task_getsecid(current, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+	return ima_match_policy(user_ns, inode, current_cred(), secid, func,
+				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -345,7 +346,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 
 		rc = is_binary_blacklisted(digest, digestsize);
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(NULL, digest, digestsize,
+			process_buffer_measurement(NULL, NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
 						   pcr, NULL);
 	}
@@ -496,6 +497,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 
 /**
  * ima_inode_post_setattr - reflect file metadata changes
+ * @user_ns: user namespace of the mount
  * @dentry: pointer to the affected dentry
  *
  * Changes to a dentry's metadata might result in needing to appraise.
@@ -503,7 +505,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void ima_inode_post_setattr(struct dentry *dentry)
+void ima_inode_post_setattr(struct user_namespace *user_ns, struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
@@ -513,7 +515,7 @@ void ima_inode_post_setattr(struct dentry *dentry)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(user_ns, inode, MAY_ACCESS, POST_SETATTR);
 	if (!action)
 		__vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 1c68c500c26f..9810f3bfa57f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -58,7 +58,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * if the IMA policy is configured to measure a key linked
 	 * to the given keyring.
 	 */
-	process_buffer_measurement(NULL, payload, payload_len,
+	process_buffer_measurement(NULL, NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
 				   keyring->description);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d1af8899cab..562003bab943 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -218,8 +218,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc, NULL);
+	action = ima_get_action(mnt_user_ns(file->f_path.mnt), inode, cred,
+				secid, mask, func, &pcr, &template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -431,8 +431,9 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 
 	security_task_getsecid(current, &secid);
 	inode = file_inode(vma->vm_file);
-	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
-				MMAP_CHECK, &pcr, &template, 0);
+	action = ima_get_action(mnt_user_ns(vma->vm_file->f_path.mnt), inode,
+				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
+				&pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -568,12 +569,13 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  * Skip calling process_measurement(), but indicate which newly, created
  * tmpfiles are in policy.
  */
-void ima_post_create_tmpfile(struct inode *inode)
+void ima_post_create_tmpfile(struct user_namespace *user_ns,
+			     struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(user_ns, inode, MAY_ACCESS, FILE_CHECK);
 	if (!must_appraise)
 		return;
 
@@ -589,18 +591,19 @@ void ima_post_create_tmpfile(struct inode *inode)
 
 /**
  * ima_post_path_mknod - mark as a new inode
+ * @user_ns: user namespace of the mount
  * @dentry: newly created dentry
  *
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-void ima_post_path_mknod(struct dentry *dentry)
+void ima_post_path_mknod(struct user_namespace *user_ns, struct dentry *dentry)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(user_ns, inode, MAY_ACCESS, FILE_CHECK);
 	if (!must_appraise)
 		return;
 
@@ -780,6 +783,7 @@ int ima_post_load_data(char *buf, loff_t size,
 
 /*
  * process_buffer_measurement - Measure the buffer to ima log.
+ * @userns: user namespace of the mount through which the inode is accessed
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
@@ -790,7 +794,8 @@ int ima_post_load_data(char *buf, loff_t size,
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
+void process_buffer_measurement(struct user_namespace *user_ns,
+				struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
 				int pcr, const char *keyring)
 {
@@ -823,7 +828,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &secid);
-		action = ima_get_action(inode, current_cred(), secid, 0, func,
+		action = ima_get_action(user_ns, inode, current_cred(), secid, 0, func,
 					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
@@ -895,7 +900,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	if (!f.file)
 		return;
 
-	process_buffer_measurement(file_inode(f.file), buf, size,
+	process_buffer_measurement(mnt_user_ns(f.file->f_path.mnt),
+				   file_inode(f.file), buf, size,
 				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
 	fdput(f);
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b5adeaa47fc..003d974ce2f3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -497,10 +497,10 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  *
  * Returns true on rule match, false on failure.
  */
-static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
+static bool ima_match_rules(struct ima_rule_entry *rule,
+			    struct user_namespace *user_ns, struct inode *inode,
 			    const struct cred *cred, u32 secid,
-			    enum ima_hooks func, int mask,
-			    const char *keyring)
+			    enum ima_hooks func, int mask, const char *keyring)
 {
 	int i;
 
@@ -539,7 +539,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	}
 
 	if ((rule->flags & IMA_FOWNER) &&
-	    !rule->fowner_op(inode->i_uid, rule->fowner))
+	    !rule->fowner_op(i_uid_into_mnt(user_ns, inode), rule->fowner))
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
@@ -620,8 +620,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct user_namespace *user_ns, struct inode *inode,
+		     const struct cred *cred, u32 secid, enum ima_hooks func,
+		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring)
 {
@@ -637,8 +638,8 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
-				     keyring))
+		if (!ima_match_rules(entry, user_ns, inode, cred, secid, func,
+				     mask, keyring))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 69a8626a35c0..2bacc4f3e6ba 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -158,7 +158,7 @@ void ima_process_queued_keys(void)
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
-			process_buffer_measurement(NULL, entry->payload,
+			process_buffer_measurement(NULL, NULL, entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
-- 
2.29.2

