Return-Path: <linux-fsdevel+bounces-3249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0137F1B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B14D1C216A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF9C22329;
	Mon, 20 Nov 2023 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A74D61;
	Mon, 20 Nov 2023 09:41:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYvb83N7Qz9xGhW;
	Tue, 21 Nov 2023 01:27:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXXxmVtlIZIKAQ--.7181S4;
	Mon, 20 Nov 2023 18:40:42 +0100 (CET)
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
Subject: [PATCH v6 22/25] ima: Remove dependency on 'integrity' LSM
Date: Mon, 20 Nov 2023 18:33:15 +0100
Message-Id: <20231120173318.1132868-23-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXBXXxmVtlIZIKAQ--.7181S4
X-Coremail-Antispam: 1UD129KBjvAXoWfAFWxGr1DXF43XF4UCr1Dtrb_yoW5Jw4kGo
	WSq39xJr4rWrySkay8KF1ftFy8ua15K3yfCrZ5WFWqk3W2yryDW342gw15JFy3Xr45GwnF
	kwnrJ3yUJF97J3Wkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOb7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26rxl6s0DMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJV
	W8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUI5rc
	DUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apggACsM
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Remove the dependency on the 'integrity' LSM by introducing IMA own
integrity metadata (ima_iint_cache structure, with IMA-specific fields from
the integrity_iint_cache structure), and by managing it directly from the
'ima' LSM.

First, replace integrity_iint_cache with ima_iint_cache in various places
of the IMA code.

Then, reserve space in the security blob for the entire ima_iint_cache
structure, so that retrieval of integrity metadata always succeeds, as
opposed to when integrity_inode_get() was called, which could fail. Adjust
the IMA code accordingly, call ima_inode_get_iint() to retrieve the
ima_iint_cache structure, and remove the now unnecessary non-NULL checks.

Don't include the inode pointer as field in the ima_iint_cache structure,
since the association with the inode is clear. Since the inode field is
missing in ima_iint_cache, pass the extra inode parameter to
ima_get_verity_digest().

Also, since IMA and EVM at this point are using different structures to
store integrity metadata, pass NULL to evm_verifyxattr(). Unfortunately,
this alone does not work, since EVM is expecting IMA to have allocated
integrity metadata with integrity_inode_get(), for files being appraised.

Since this is not true anymore, the integrity_iint_find() call in EVM
always returns NULL making it impossible for EVM to access integrity
metadata. Temporary fix this issue by forcing the creation of integrity
metadata with integrity_inode_get().

Finally, register ima_inode_alloc_security() for the inode_alloc_security
LSM hook, to initialize the new ima_iint_cache structure (before this task
was done by iint_init_always()). Also, duplicate iint_lockdep_annotate()
for the ima_iint_cache structure, and name it ima_iint_lockdep_annotate().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c     |   4 +-
 security/integrity/ima/ima.h          |  57 +++++++++----
 security/integrity/ima/ima_api.c      |  15 ++--
 security/integrity/ima/ima_appraise.c |  35 ++++----
 security/integrity/ima/ima_init.c     |   2 +-
 security/integrity/ima/ima_main.c     | 111 ++++++++++++++------------
 security/integrity/ima/ima_policy.c   |   2 +-
 7 files changed, 129 insertions(+), 97 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f1ce9d0a490f..1e59a985b845 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -409,7 +409,7 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 		return INTEGRITY_UNKNOWN;
 
 	if (!iint) {
-		iint = integrity_iint_find(d_backing_inode(dentry));
+		iint = integrity_inode_get(d_backing_inode(dentry));
 		if (!iint)
 			return INTEGRITY_UNKNOWN;
 	}
@@ -984,7 +984,7 @@ evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct integrity_iint_cache *iint;
 
-	iint = integrity_iint_find(d_backing_inode(dentry));
+	iint = integrity_inode_get(d_backing_inode(dentry));
 	if (iint)
 		/* needed for successful verification of empty files */
 		iint->flags |= IMA_NEW_FILE;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a27fc10f84f7..7c94277f2929 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -60,7 +60,7 @@ extern const char boot_aggregate_name[];
 
 /* IMA event related data */
 struct ima_event_data {
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint;
 	struct file *file;
 	const unsigned char *filename;
 	struct evm_ima_xattr_data *xattr_value;
@@ -119,6 +119,34 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+/* IMA integrity metadata associated with an inode */
+struct ima_iint_cache {
+	struct mutex mutex;	/* protects: version, flags, digest */
+	u64 version;		/* track inode changes */
+	unsigned long flags;
+	unsigned long measured_pcrs;
+	unsigned long atomic_flags;
+	unsigned long real_ino;
+	dev_t real_dev;
+	enum integrity_status ima_file_status:4;
+	enum integrity_status ima_mmap_status:4;
+	enum integrity_status ima_bprm_status:4;
+	enum integrity_status ima_read_status:4;
+	enum integrity_status ima_creds_status:4;
+	struct ima_digest_data *ima_hash;
+};
+
+extern struct lsm_blob_sizes ima_blob_sizes;
+
+static inline struct ima_iint_cache *
+ima_inode_get_iint(const struct inode *inode)
+{
+	struct ima_iint_cache *ima_iint_sec;
+
+	ima_iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
+	return ima_iint_sec;
+}
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -152,7 +180,7 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry);
 int ima_calc_boot_aggregate(struct ima_digest_data *hash);
 void ima_add_violation(struct file *file, const unsigned char *filename,
-		       struct integrity_iint_cache *iint,
+		       struct ima_iint_cache *iint,
 		       const char *op, const char *cause);
 int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
@@ -267,10 +295,10 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
-int ima_collect_measurement(struct integrity_iint_cache *iint,
+int ima_collect_measurement(struct ima_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig);
-void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
+void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -280,7 +308,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
 			       bool buf_hash, u8 *digest, size_t digest_len);
-void ima_audit_measurement(struct integrity_iint_cache *iint,
+void ima_audit_measurement(struct ima_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
@@ -318,17 +346,17 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
-int ima_check_blacklist(struct integrity_iint_cache *iint,
+int ima_check_blacklist(struct ima_iint_cache *iint,
 			const struct modsig *modsig, int pcr);
 int ima_appraise_measurement(enum ima_hooks func,
-			     struct integrity_iint_cache *iint,
+			     struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
-enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
+void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
+enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
 					   enum ima_hooks func);
 enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
@@ -337,14 +365,14 @@ int ima_read_xattr(struct dentry *dentry,
 void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
 
 #else
-static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
+static inline int ima_check_blacklist(struct ima_iint_cache *iint,
 				      const struct modsig *modsig, int pcr)
 {
 	return 0;
 }
 
 static inline int ima_appraise_measurement(enum ima_hooks func,
-					   struct integrity_iint_cache *iint,
+					   struct ima_iint_cache *iint,
 					   struct file *file,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
@@ -361,14 +389,13 @@ static inline int ima_must_appraise(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline void ima_update_xattr(struct integrity_iint_cache *iint,
+static inline void ima_update_xattr(struct ima_iint_cache *iint,
 				    struct file *file)
 {
 }
 
-static inline enum integrity_status ima_get_cache_status(struct integrity_iint_cache
-							 *iint,
-							 enum ima_hooks func)
+static inline enum integrity_status
+ima_get_cache_status(struct ima_iint_cache *iint, enum ima_hooks func)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 597ea0c4d72f..f3363935804f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -131,7 +131,7 @@ int ima_store_template(struct ima_template_entry *entry,
  * value is invalidated.
  */
 void ima_add_violation(struct file *file, const unsigned char *filename,
-		       struct integrity_iint_cache *iint,
+		       struct ima_iint_cache *iint,
 		       const char *op, const char *cause)
 {
 	struct ima_template_entry *entry;
@@ -201,7 +201,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 				allowed_algos);
 }
 
-static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
+static bool ima_get_verity_digest(struct ima_iint_cache *iint,
+				  struct inode *inode,
 				  struct ima_max_digest_data *hash)
 {
 	enum hash_algo alg;
@@ -211,7 +212,7 @@ static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
 	 * On failure, 'measure' policy rules will result in a file data
 	 * hash containing 0's.
 	 */
-	digest_len = fsverity_get_digest(iint->inode, hash->digest, NULL, &alg);
+	digest_len = fsverity_get_digest(inode, hash->digest, NULL, &alg);
 	if (digest_len == 0)
 		return false;
 
@@ -237,7 +238,7 @@ static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
  *
  * Return 0 on success, error code otherwise
  */
-int ima_collect_measurement(struct integrity_iint_cache *iint,
+int ima_collect_measurement(struct ima_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig)
 {
@@ -280,7 +281,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	memset(&hash.digest, 0, sizeof(hash.digest));
 
 	if (iint->flags & IMA_VERITY_REQUIRED) {
-		if (!ima_get_verity_digest(iint, &hash)) {
+		if (!ima_get_verity_digest(iint, inode, &hash)) {
 			audit_cause = "no-verity-digest";
 			result = -ENODATA;
 		}
@@ -338,7 +339,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
  *
  * Must be called with iint->mutex held.
  */
-void ima_store_measurement(struct integrity_iint_cache *iint,
+void ima_store_measurement(struct ima_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -382,7 +383,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		ima_free_template_entry(entry);
 }
 
-void ima_audit_measurement(struct integrity_iint_cache *iint,
+void ima_audit_measurement(struct ima_iint_cache *iint,
 			   const unsigned char *filename)
 {
 	struct audit_buffer *ab;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 076451109637..b0b96c263961 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -85,7 +85,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
-			 struct integrity_iint_cache *iint)
+			 struct ima_iint_cache *iint)
 {
 	int rc, offset;
 	u8 algo = iint->ima_hash->algo;
@@ -106,7 +106,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 }
 
 /* Return specific func appraised cached result */
-enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
+enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
 					   enum ima_hooks func)
 {
 	switch (func) {
@@ -126,7 +126,7 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 	}
 }
 
-static void ima_set_cache_status(struct integrity_iint_cache *iint,
+static void ima_set_cache_status(struct ima_iint_cache *iint,
 				 enum ima_hooks func,
 				 enum integrity_status status)
 {
@@ -152,8 +152,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	}
 }
 
-static void ima_cache_flags(struct integrity_iint_cache *iint,
-			     enum ima_hooks func)
+static void ima_cache_flags(struct ima_iint_cache *iint, enum ima_hooks func)
 {
 	switch (func) {
 	case MMAP_CHECK:
@@ -276,7 +275,7 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
  *
  * Return 0 on success, error code otherwise.
  */
-static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
+static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
 			enum integrity_status *status, const char **cause)
 {
@@ -443,7 +442,7 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
  *
  * Returns -EPERM if the hash is blacklisted.
  */
-int ima_check_blacklist(struct integrity_iint_cache *iint,
+int ima_check_blacklist(struct ima_iint_cache *iint,
 			const struct modsig *modsig, int pcr)
 {
 	enum hash_algo hash_algo;
@@ -478,7 +477,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
  * Return 0 on success, error code otherwise
  */
 int ima_appraise_measurement(enum ima_hooks func,
-			     struct integrity_iint_cache *iint,
+			     struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig)
@@ -520,7 +519,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
-				 rc < 0 ? 0 : rc, iint);
+				 rc < 0 ? 0 : rc, NULL);
 	switch (status) {
 	case INTEGRITY_PASS:
 	case INTEGRITY_PASS_IMMUTABLE:
@@ -603,7 +602,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 /*
  * ima_update_xattr - update 'security.ima' hash value
  */
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
+void ima_update_xattr(struct ima_iint_cache *iint, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	int rc = 0;
@@ -640,7 +639,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 	int action;
 
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
@@ -648,12 +647,9 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
 		return;
 
 	action = ima_must_appraise(idmap, inode, MAY_ACCESS, POST_SETATTR);
-	iint = integrity_iint_find(inode);
-	if (iint) {
-		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
-		if (!action)
-			clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
-	}
+	set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
+	if (!action)
+		clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
 }
 
 /*
@@ -674,14 +670,11 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
 		return;
 
-	iint = integrity_iint_find(inode);
-	if (!iint)
-		return;
 	iint->measured_pcrs = 0;
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
 	if (digsig)
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 63979aefc95f..393f5c7912d5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -44,7 +44,7 @@ static int __init ima_add_boot_aggregate(void)
 	static const char op[] = "add_boot_aggregate";
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry;
-	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_iint_cache tmp_iint, *iint = &tmp_iint;
 	struct ima_event_data event_data = { .iint = iint,
 					     .filename = boot_aggregate_name };
 	struct ima_max_digest_data hash;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3b5d53a7f755..737bca82dd5a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -114,7 +114,7 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
  *
  */
 static void ima_rdwr_violation_check(struct file *file,
-				     struct integrity_iint_cache *iint,
+				     struct ima_iint_cache *iint,
 				     int must_measure,
 				     char **pathbuf,
 				     const char **pathname,
@@ -125,12 +125,9 @@ static void ima_rdwr_violation_check(struct file *file,
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
-		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
-			if (!iint)
-				iint = integrity_iint_find(inode);
+		if (atomic_read(&inode->i_readcount)) {
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (test_bit(IMA_MUST_MEASURE, &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
@@ -153,7 +150,7 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
-static void ima_check_last_writer(struct integrity_iint_cache *iint,
+static void ima_check_last_writer(struct ima_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
@@ -192,15 +189,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 static void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	iint = integrity_iint_find(inode);
-	if (!iint)
-		return;
-
 	ima_check_last_writer(iint, inode, file);
 }
 
@@ -209,7 +202,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       enum ima_hooks func)
 {
 	struct inode *backing_inode, *inode = file_inode(file);
-	struct integrity_iint_cache *iint = NULL;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -247,20 +240,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	inode_lock(inode);
 
-	if (action) {
-		iint = integrity_inode_get(inode);
-		if (!iint)
-			rc = -ENOMEM;
-	}
-
-	if (!rc && violation_check)
+	if (violation_check)
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
 
 	inode_unlock(inode);
 
-	if (rc)
-		goto out;
 	if (!action)
 		goto out;
 
@@ -564,21 +549,11 @@ static int ima_file_check(struct file *file, int mask)
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			    size_t buf_size)
 {
-	struct integrity_iint_cache *iint = NULL, tmp_iint;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode), tmp_iint;
 	int rc, hash_algo;
 
-	if (ima_policy_flag) {
-		iint = integrity_iint_find(inode);
-		if (iint)
-			mutex_lock(&iint->mutex);
-	}
-
-	if ((!iint || !(iint->flags & IMA_COLLECTED)) && file) {
-		if (iint)
-			mutex_unlock(&iint->mutex);
-
+	if ((!(iint->flags & IMA_COLLECTED)) && file) {
 		memset(&tmp_iint, 0, sizeof(tmp_iint));
-		tmp_iint.inode = inode;
 		mutex_init(&tmp_iint.mutex);
 
 		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
@@ -592,11 +567,9 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 		}
 
 		iint = &tmp_iint;
-		mutex_lock(&iint->mutex);
 	}
 
-	if (!iint)
-		return -EOPNOTSUPP;
+	mutex_lock(&iint->mutex);
 
 	/*
 	 * ima_file_hash can be called when ima_collect_measurement has still
@@ -688,7 +661,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 				    struct inode *inode)
 
 {
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 	int must_appraise;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
@@ -699,11 +672,6 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 	if (!must_appraise)
 		return;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
-	if (!iint)
-		return;
-
 	/* needed for writing the security xattrs */
 	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
 	iint->ima_file_status = INTEGRITY_PASS;
@@ -720,8 +688,8 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 static void __maybe_unused
 ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
 	int must_appraise;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
@@ -732,11 +700,6 @@ ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
-	if (!iint)
-		return;
-
 	/* needed for re-opening empty files */
 	iint->flags |= IMA_NEW_FILE;
 }
@@ -936,7 +899,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry = NULL;
-	struct integrity_iint_cache iint = {};
+	struct ima_iint_cache iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
 					    .filename = eventname,
 					    .buf = buf,
@@ -1145,6 +1108,48 @@ static int __maybe_unused ima_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
+#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
+
+/*
+ * It is not clear that IMA should be nested at all, but as long is it measures
+ * files both on overlayfs and on underlying fs, we need to annotate the iint
+ * mutex to avoid lockdep false positives related to IMA + overlayfs.
+ * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ */
+static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *ima_iint,
+					     struct inode *inode)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
+
+	int depth = inode->i_sb->s_stack_depth;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
+		depth = 0;
+
+	lockdep_set_class(&ima_iint->mutex, &iint_mutex_key[depth]);
+#endif
+}
+
+static int ima_inode_alloc_security(struct inode *inode)
+{
+	struct ima_iint_cache *iint = ima_inode_get_iint(inode);
+
+	iint->ima_hash = NULL;
+	iint->version = 0;
+	iint->flags = 0UL;
+	iint->atomic_flags = 0UL;
+	iint->ima_file_status = INTEGRITY_UNKNOWN;
+	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
+	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
+	iint->ima_creds_status = INTEGRITY_UNKNOWN;
+	iint->measured_pcrs = 0;
+	mutex_init(&iint->mutex);
+	ima_iint_lockdep_annotate(iint, inode);
+	return 0;
+}
+
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
@@ -1156,6 +1161,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
+	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
 #ifdef CONFIG_SECURITY_PATH
 	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
 #endif
@@ -1185,10 +1191,15 @@ int __init init_ima_lsm(void)
 	return 0;
 }
 
+struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct ima_iint_cache),
+};
+
 DEFINE_LSM(ima) = {
 	.name = "ima",
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
+	.blobs = &ima_blob_sizes,
 };
 
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f69062617754..c0556907c2e6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -49,7 +49,7 @@
 #define DONT_HASH	0x0200
 
 #define INVALID_PCR(a) (((a) < 0) || \
-	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
+	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
 
 int ima_policy_flag;
 static int temp_ima_appraise;
-- 
2.34.1


