Return-Path: <linux-fsdevel+bounces-6110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49017813845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013182820CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E3C675B6;
	Thu, 14 Dec 2023 17:16:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC7135;
	Thu, 14 Dec 2023 09:16:29 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SrdqH1WpFz9xqtc;
	Fri, 15 Dec 2023 00:59:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 860BD14066B;
	Fri, 15 Dec 2023 01:16:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV8uOHtlU7aDAg--.53464S5;
	Thu, 14 Dec 2023 18:16:18 +0100 (CET)
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
Subject: [PATCH v8 23/24] ima: Make it independent from 'integrity' LSM
Date: Thu, 14 Dec 2023 18:08:33 +0100
Message-Id: <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwCnpV8uOHtlU7aDAg--.53464S5
X-Coremail-Antispam: 1UD129KBjvAXoWfZF4rZw1xtr4rCFy3Cw47CFg_yoW5Xw17Go
	Zav39xJr48WFyfCay8K3WSyFWkuws8G3y3ArZ5WFWDK3W7K34DW342gw1rJFy3ZrW5G39F
	kwnrta1UJF9rJ3Wkn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UGJPiUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OoUAAAsX

From: Roberto Sassu <roberto.sassu@huawei.com>

Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
own integrity metadata (ima_iint_cache structure, with IMA-specific fields
from the integrity_iint_cache structure), and by managing it directly from
the 'ima' LSM.

Move the remaining IMA-specific flags to security/integrity/ima/ima.h,
since they are now unnecessary in the common integrity layer.

Replace integrity_iint_cache with ima_iint_cache in various places
of the IMA code.

Then, reserve space in the security blob for the entire ima_iint_cache
structure, so that it is available for all inodes having the security blob
allocated (those for which security_inode_alloc() was called). Adjust the
IMA code accordingly, call ima_iint_inode() to retrieve the ima_iint_cache
structure. Keep the non-NULL checks since there can be inodes without
security blob.

Don't include the inode pointer as field in the ima_iint_cache structure,
since the association with the inode is clear. Since the inode field is
missing in ima_iint_cache, pass the extra inode parameter to
ima_get_verity_digest().

Finally, register ima_inode_alloc_security/ima_inode_free_security() to
initialize/deinitialize the new ima_iint_cache structure (before this task
was done by iint_init_always() and iint_free()). Also, duplicate
iint_lockdep_annotate() for the ima_iint_cache structure, and name it
ima_iint_lockdep_annotate().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          | 109 ++++++++++++++++++++++----
 security/integrity/ima/ima_api.c      |  15 ++--
 security/integrity/ima/ima_appraise.c |  25 +++---
 security/integrity/ima/ima_init.c     |   2 +-
 security/integrity/ima/ima_main.c     |  96 ++++++++++++++++++-----
 security/integrity/ima/ima_policy.c   |   2 +-
 security/integrity/integrity.h        |  53 -------------
 7 files changed, 194 insertions(+), 108 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a27fc10f84f7..d1c339a340f8 100644
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
@@ -119,6 +119,86 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+/* IMA iint action cache flags */
+#define IMA_MEASURE		0x00000001
+#define IMA_MEASURED		0x00000002
+#define IMA_APPRAISE		0x00000004
+#define IMA_APPRAISED		0x00000008
+/*#define IMA_COLLECT		0x00000010  do not use this flag */
+#define IMA_COLLECTED		0x00000020
+#define IMA_AUDIT		0x00000040
+#define IMA_AUDITED		0x00000080
+#define IMA_HASH		0x00000100
+#define IMA_HASHED		0x00000200
+
+/* IMA iint policy rule cache flags */
+#define IMA_NONACTION_FLAGS	0xff000000
+#define IMA_DIGSIG_REQUIRED	0x01000000
+#define IMA_PERMIT_DIRECTIO	0x02000000
+#define IMA_NEW_FILE		0x04000000
+#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
+#define IMA_MODSIG_ALLOWED	0x20000000
+#define IMA_CHECK_BLACKLIST	0x40000000
+#define IMA_VERITY_REQUIRED	0x80000000
+
+#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
+				 IMA_HASH | IMA_APPRAISE_SUBMASK)
+#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
+				 IMA_HASHED | IMA_COLLECTED | \
+				 IMA_APPRAISED_SUBMASK)
+
+/* IMA iint subaction appraise cache flags */
+#define IMA_FILE_APPRAISE	0x00001000
+#define IMA_FILE_APPRAISED	0x00002000
+#define IMA_MMAP_APPRAISE	0x00004000
+#define IMA_MMAP_APPRAISED	0x00008000
+#define IMA_BPRM_APPRAISE	0x00010000
+#define IMA_BPRM_APPRAISED	0x00020000
+#define IMA_READ_APPRAISE	0x00040000
+#define IMA_READ_APPRAISED	0x00080000
+#define IMA_CREDS_APPRAISE	0x00100000
+#define IMA_CREDS_APPRAISED	0x00200000
+#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
+				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
+				 IMA_CREDS_APPRAISE)
+#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
+				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
+				 IMA_CREDS_APPRAISED)
+
+/* IMA iint cache atomic_flags */
+#define IMA_CHANGE_XATTR	0
+#define IMA_UPDATE_XATTR	1
+#define IMA_CHANGE_ATTR		2
+#define IMA_DIGSIG		3
+#define IMA_MUST_MEASURE	4
+
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
+static inline struct ima_iint_cache *ima_iint_inode(const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return inode->i_security + ima_blob_sizes.lbs_inode;
+}
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -152,7 +232,7 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry);
 int ima_calc_boot_aggregate(struct ima_digest_data *hash);
 void ima_add_violation(struct file *file, const unsigned char *filename,
-		       struct integrity_iint_cache *iint,
+		       struct ima_iint_cache *iint,
 		       const char *op, const char *cause);
 int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
@@ -267,10 +347,10 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
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
@@ -280,7 +360,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
 			       bool buf_hash, u8 *digest, size_t digest_len);
-void ima_audit_measurement(struct integrity_iint_cache *iint,
+void ima_audit_measurement(struct ima_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
@@ -318,17 +398,17 @@ int ima_policy_show(struct seq_file *m, void *v);
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
@@ -337,14 +417,14 @@ int ima_read_xattr(struct dentry *dentry,
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
@@ -361,14 +441,13 @@ static inline int ima_must_appraise(struct mnt_idmap *idmap,
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
index 1dd6ee72a20a..d71df7deacb7 100644
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
+	struct ima_iint_cache *iint;
 	int action;
 
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
@@ -648,7 +647,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
 		return;
 
 	action = ima_must_appraise(idmap, inode, MAY_ACCESS, POST_SETATTR);
-	iint = integrity_iint_find(inode);
+	iint = ima_iint_inode(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
 		if (!action)
@@ -674,12 +673,12 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint;
 
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
 		return;
 
-	iint = integrity_iint_find(inode);
+	iint = ima_iint_inode(inode);
 	if (!iint)
 		return;
 	iint->measured_pcrs = 0;
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
index 2a9ca5fa4317..b28e49f53ca4 100644
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
@@ -125,9 +125,9 @@ static void ima_rdwr_violation_check(struct file *file,
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
-		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
+		if (atomic_read(&inode->i_readcount)) {
 			if (!iint)
-				iint = integrity_iint_find(inode);
+				iint = ima_iint_inode(inode);
 			/* IMA_MEASURE is set from reader side */
 			if (iint && test_bit(IMA_MUST_MEASURE,
 						&iint->atomic_flags))
@@ -153,7 +153,7 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
-static void ima_check_last_writer(struct integrity_iint_cache *iint,
+static void ima_check_last_writer(struct ima_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
@@ -192,12 +192,12 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 static void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	iint = integrity_iint_find(inode);
+	iint = ima_iint_inode(inode);
 	if (!iint)
 		return;
 
@@ -209,7 +209,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       enum ima_hooks func)
 {
 	struct inode *backing_inode, *inode = file_inode(file);
-	struct integrity_iint_cache *iint = NULL;
+	struct ima_iint_cache *iint;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -248,7 +248,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	inode_lock(inode);
 
 	if (action) {
-		iint = integrity_inode_get(inode);
+		iint = ima_iint_inode(inode);
 		if (!iint)
 			rc = -ENOMEM;
 	}
@@ -564,11 +564,11 @@ static int ima_file_check(struct file *file, int mask)
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			    size_t buf_size)
 {
-	struct integrity_iint_cache *iint = NULL, tmp_iint;
+	struct ima_iint_cache *iint, tmp_iint;
 	int rc, hash_algo;
 
 	if (ima_policy_flag) {
-		iint = integrity_iint_find(inode);
+		iint = ima_iint_inode(inode);
 		if (iint)
 			mutex_lock(&iint->mutex);
 	}
@@ -578,7 +578,6 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			mutex_unlock(&iint->mutex);
 
 		memset(&tmp_iint, 0, sizeof(tmp_iint));
-		tmp_iint.inode = inode;
 		mutex_init(&tmp_iint.mutex);
 
 		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
@@ -688,7 +687,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 				    struct inode *inode)
 
 {
-	struct integrity_iint_cache *iint;
+	struct ima_iint_cache *iint;
 	int must_appraise;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
@@ -699,8 +698,8 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 	if (!must_appraise)
 		return;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
+	iint = ima_iint_inode(inode);
+	/* iint is NULL if security_inode_alloc() was not called on inode. */
 	if (!iint)
 		return;
 
@@ -720,8 +719,8 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 static void __maybe_unused
 ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
+	struct ima_iint_cache *iint = ima_iint_inode(inode);
 	int must_appraise;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
@@ -732,8 +731,8 @@ ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
+	iint = ima_iint_inode(inode);
+	/* iint is NULL if security_inode_alloc() was not called on inode. */
 	if (!iint)
 		return;
 
@@ -936,7 +935,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry = NULL;
-	struct integrity_iint_cache iint = {};
+	struct ima_iint_cache iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
 					    .filename = eventname,
 					    .buf = buf,
@@ -1145,6 +1144,60 @@ static int __maybe_unused ima_kernel_module_request(char *kmod_name)
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
+	struct ima_iint_cache *iint = ima_iint_inode(inode);
+
+	/* Called by security_inode_alloc(), it cannot be NULL. */
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
+static void ima_inode_free_security(struct inode *inode)
+{
+	struct ima_iint_cache *iint = ima_iint_inode(inode);
+
+	if (!iint)
+		return;
+
+	kfree(iint->ima_hash);
+	mutex_destroy(&iint->mutex);
+}
+
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
@@ -1156,6 +1209,8 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
+	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
+	LSM_HOOK_INIT(inode_free_security, ima_inode_free_security),
 #ifdef CONFIG_SECURITY_PATH
 	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
 #endif
@@ -1179,10 +1234,15 @@ static int __init init_ima_lsm(void)
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
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7a97c269a072..671fc50255f9 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -20,59 +20,6 @@
 #include <linux/audit.h>
 #include <linux/lsm_hooks.h>
 
-/* iint action cache flags */
-#define IMA_MEASURE		0x00000001
-#define IMA_MEASURED		0x00000002
-#define IMA_APPRAISE		0x00000004
-#define IMA_APPRAISED		0x00000008
-/*#define IMA_COLLECT		0x00000010  do not use this flag */
-#define IMA_COLLECTED		0x00000020
-#define IMA_AUDIT		0x00000040
-#define IMA_AUDITED		0x00000080
-#define IMA_HASH		0x00000100
-#define IMA_HASHED		0x00000200
-
-/* iint policy rule cache flags */
-#define IMA_NONACTION_FLAGS	0xff000000
-#define IMA_DIGSIG_REQUIRED	0x01000000
-#define IMA_PERMIT_DIRECTIO	0x02000000
-#define IMA_NEW_FILE		0x04000000
-#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
-#define IMA_MODSIG_ALLOWED	0x20000000
-#define IMA_CHECK_BLACKLIST	0x40000000
-#define IMA_VERITY_REQUIRED	0x80000000
-
-#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
-				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
-				 IMA_HASHED | IMA_COLLECTED | \
-				 IMA_APPRAISED_SUBMASK)
-
-/* iint subaction appraise cache flags */
-#define IMA_FILE_APPRAISE	0x00001000
-#define IMA_FILE_APPRAISED	0x00002000
-#define IMA_MMAP_APPRAISE	0x00004000
-#define IMA_MMAP_APPRAISED	0x00008000
-#define IMA_BPRM_APPRAISE	0x00010000
-#define IMA_BPRM_APPRAISED	0x00020000
-#define IMA_READ_APPRAISE	0x00040000
-#define IMA_READ_APPRAISED	0x00080000
-#define IMA_CREDS_APPRAISE	0x00100000
-#define IMA_CREDS_APPRAISED	0x00200000
-#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
-				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
-				 IMA_CREDS_APPRAISE)
-#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
-				 IMA_CREDS_APPRAISED)
-
-/* iint cache atomic_flags */
-#define IMA_CHANGE_XATTR	0
-#define IMA_UPDATE_XATTR	1
-#define IMA_CHANGE_ATTR		2
-#define IMA_DIGSIG		3
-#define IMA_MUST_MEASURE	4
-
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
 	EVM_XATTR_HMAC,
-- 
2.34.1


