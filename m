Return-Path: <linux-fsdevel+bounces-36055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8D9DB548
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D411C282979
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966A198A22;
	Thu, 28 Nov 2024 10:07:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646411922F1;
	Thu, 28 Nov 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788451; cv=none; b=YIngkrHM/6oEp4o8Yp6afbg2lKu6uauDqXfivZit07k25NLBuxYCk2N5Mh3CXW7kYnc1RQ4W+Q4Yq1Al5SzMYrAOhtLV1eo2SiAyuZjf6INQpo2aGaUvu8hMM1DtjTMC5yB03T0/xSP4XtYKSKkHMLLNgueTm95+gkksDcnmcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788451; c=relaxed/simple;
	bh=RsrIuTxfS+xqQ+Dlj1rPpHMjR6j+A5JZ4Z7DBNge6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxyoQCO0E52jkRlwpycJRqvNrZVTu5RkrlzvrRnFNRXrc0fz6kdPx6QMf5VxkI9u6nAHs3z7aIlC/Bae+PbqJXpx9dasxA6PFRdkr2EkfAP6EftaXnRLcb+zuVbYFibzAGt97Wig8KFhTcylqXn59dHbgmf0CSfy8jv6yYaj274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XzWW15Nyyz9v7JM;
	Thu, 28 Nov 2024 17:39:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BC274140854;
	Thu, 28 Nov 2024 18:07:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S4;
	Thu, 28 Nov 2024 11:07:13 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 2/7] ima: Remove inode lock
Date: Thu, 28 Nov 2024 11:06:15 +0100
Message-ID: <20241128100621.461743-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S4
X-Coremail-Antispam: 1UD129KBjvAXoWfGry3trWkWw48Aw4xAFyfCrg_yoW8Gr17Ko
	WSy3sxJrn8WrySyay8Ww1SyFWUu39xGrWfCrs5XFnrK3W2kryUX347G3W5JFW3Xr4rGr1q
	k3s7Jw4kJF9rJ3Wkn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUxiihUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGdH1TUCmQAAsf

From: Roberto Sassu <roberto.sassu@huawei.com>

Move out the mutex in the ima_iint_cache structure to a new structure
called ima_iint_cache_lock, so that a lock can be taken regardless of
whether or not inode integrity metadata are stored in the inode.

Introduce ima_inode_security() to retrieve the ima_iint_cache_lock
structure, if inode i_security is not NULL, and consequently remove
ima_inode_get_iint() and ima_inode_set_iint(), since the ima_iint_cache
structure can be read and modified from the new structure.

Move the mutex initialization and annotation in the new function
ima_inode_alloc_security() and introduce ima_iint_lock() and
ima_iint_unlock() to respectively lock and unlock the mutex.

Finally, expand the critical region in process_measurement() guarded by
iint->mutex up to where the inode was locked, use only one iint lock in
__ima_inode_hash(), since the mutex is now in the inode security blob, and
replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/ima/ima.h      | 31 ++++-------
 security/integrity/ima/ima_api.c  |  4 +-
 security/integrity/ima/ima_iint.c | 92 ++++++++++++++++++++++++++-----
 security/integrity/ima/ima_main.c | 39 ++++++-------
 4 files changed, 109 insertions(+), 57 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3f1a82b7cd71..b4eeab48f08a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,7 +182,6 @@ struct ima_kexec_hdr {
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
-	struct mutex mutex;	/* protects: version, flags, digest */
 	struct integrity_inode_attributes real_inode;
 	unsigned long flags;
 	unsigned long measured_pcrs;
@@ -195,35 +194,27 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+struct ima_iint_cache_lock {
+	struct mutex mutex;	/* protects: iint version, flags, digest */
+	struct ima_iint_cache *iint;
+};
+
 extern struct lsm_blob_sizes ima_blob_sizes;
 
-static inline struct ima_iint_cache *
-ima_inode_get_iint(const struct inode *inode)
+static inline struct ima_iint_cache_lock *ima_inode_security(void *i_security)
 {
-	struct ima_iint_cache **iint_sec;
-
-	if (unlikely(!inode->i_security))
+	if (unlikely(!i_security))
 		return NULL;
 
-	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
-	return *iint_sec;
-}
-
-static inline void ima_inode_set_iint(const struct inode *inode,
-				      struct ima_iint_cache *iint)
-{
-	struct ima_iint_cache **iint_sec;
-
-	if (unlikely(!inode->i_security))
-		return;
-
-	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
-	*iint_sec = iint;
+	return i_security + ima_blob_sizes.lbs_inode;
 }
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
+int ima_inode_alloc_security(struct inode *inode);
 void ima_inode_free_rcu(void *inode_security);
+void ima_iint_lock(struct inode *inode);
+void ima_iint_unlock(struct inode *inode);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 984e861f6e33..37c2a228f0e1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -234,7 +234,7 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  * Calculate the file hash, if it doesn't already exist,
  * storing the measurement and i_version in the iint.
  *
- * Must be called with iint->mutex held.
+ * Must be called with iint mutex held.
  *
  * Return 0 on success, error code otherwise
  */
@@ -343,7 +343,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
  *	- the inode was previously flushed as well as the iint info,
  *	  containing the hashing info.
  *
- * Must be called with iint->mutex held.
+ * Must be called with iint mutex held.
  */
 void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 9d9fc7a911ad..dcc32483d29f 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -26,7 +26,13 @@ static struct kmem_cache *ima_iint_cache __ro_after_init;
  */
 struct ima_iint_cache *ima_iint_find(struct inode *inode)
 {
-	return ima_inode_get_iint(inode);
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
+	if (!iint_lock)
+		return NULL;
+
+	return iint_lock->iint;
 }
 
 #define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
@@ -37,18 +43,18 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
  */
-static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
-					     struct inode *inode)
+static inline void ima_iint_lock_lockdep_annotate(struct mutex *mutex,
+						  struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
+	static struct lock_class_key ima_iint_lock_mutex_key[IMA_MAX_NESTING];
 
 	int depth = inode->i_sb->s_stack_depth;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class(mutex, &ima_iint_lock_mutex_key[depth]);
 #endif
 }
 
@@ -65,14 +71,11 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
-	mutex_init(&iint->mutex);
-	ima_iint_lockdep_annotate(iint, inode);
 }
 
 static void ima_iint_free(struct ima_iint_cache *iint)
 {
 	kfree(iint->ima_hash);
-	mutex_destroy(&iint->mutex);
 	kmem_cache_free(ima_iint_cache, iint);
 }
 
@@ -87,9 +90,14 @@ static void ima_iint_free(struct ima_iint_cache *iint)
  */
 struct ima_iint_cache *ima_inode_get(struct inode *inode)
 {
+	struct ima_iint_cache_lock *iint_lock;
 	struct ima_iint_cache *iint;
 
-	iint = ima_iint_find(inode);
+	iint_lock = ima_inode_security(inode->i_security);
+	if (!iint_lock)
+		return NULL;
+
+	iint = iint_lock->iint;
 	if (iint)
 		return iint;
 
@@ -99,11 +107,31 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 
 	ima_iint_init_always(iint, inode);
 
-	ima_inode_set_iint(inode, iint);
+	iint_lock->iint = iint;
 
 	return iint;
 }
 
+/**
+ * ima_inode_alloc_security - Called to init an inode
+ * @inode: Pointer to the inode
+ *
+ * Initialize and annotate the mutex in the ima_iint_cache_lock structure.
+ *
+ * Return: Zero.
+ */
+int ima_inode_alloc_security(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
+
+	mutex_init(&iint_lock->mutex);
+	ima_iint_lock_lockdep_annotate(&iint_lock->mutex, inode);
+
+	return 0;
+}
+
 /**
  * ima_inode_free_rcu - Called to free an inode via a RCU callback
  * @inode_security: The inode->i_security pointer
@@ -112,10 +140,48 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
  */
 void ima_inode_free_rcu(void *inode_security)
 {
-	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode_security);
+
+	mutex_destroy(&iint_lock->mutex);
+
+	if (iint_lock->iint)
+		ima_iint_free(iint_lock->iint);
+}
+
+/**
+ * ima_iint_lock - Lock integrity metadata
+ * @inode: Pointer to the inode
+ *
+ * Lock integrity metadata.
+ */
+void ima_iint_lock(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
+
+	/* Only inodes with i_security are processed by IMA. */
+	if (iint_lock)
+		mutex_lock(&iint_lock->mutex);
+}
+
+/**
+ * ima_iint_unlock - Unlock integrity metadata
+ * @inode: Pointer to the inode
+ *
+ * Unlock integrity metadata.
+ */
+void ima_iint_unlock(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
 
-	if (*iint_p)
-		ima_iint_free(*iint_p);
+	/* Only inodes with i_security are processed by IMA. */
+	if (iint_lock)
+		mutex_unlock(&iint_lock->mutex);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cea0afbbc28d..05cfb04cd02b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -163,7 +163,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (!(mode & FMODE_WRITE))
 		return;
 
-	mutex_lock(&iint->mutex);
+	ima_iint_lock(inode);
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
@@ -181,7 +181,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				ima_update_xattr(iint, file);
 		}
 	}
-	mutex_unlock(&iint->mutex);
+	ima_iint_unlock(inode);
 }
 
 /**
@@ -247,7 +247,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (action & IMA_FILE_APPRAISE)
 		func = FILE_CHECK;
 
-	inode_lock(inode);
+	ima_iint_lock(inode);
 
 	if (action) {
 		iint = ima_inode_get(inode);
@@ -259,15 +259,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
 
-	inode_unlock(inode);
-
 	if (rc)
 		goto out;
 	if (!action)
 		goto out;
 
-	mutex_lock(&iint->mutex);
-
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
@@ -412,10 +408,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
-	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
 out:
+	ima_iint_unlock(inode);
 	if (pathbuf)
 		__putname(pathbuf);
 	if (must_appraise) {
@@ -580,18 +576,13 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 	struct ima_iint_cache *iint = NULL, tmp_iint;
 	int rc, hash_algo;
 
-	if (ima_policy_flag) {
+	ima_iint_lock(inode);
+
+	if (ima_policy_flag)
 		iint = ima_iint_find(inode);
-		if (iint)
-			mutex_lock(&iint->mutex);
-	}
 
 	if ((!iint || !(iint->flags & IMA_COLLECTED)) && file) {
-		if (iint)
-			mutex_unlock(&iint->mutex);
-
 		memset(&tmp_iint, 0, sizeof(tmp_iint));
-		mutex_init(&tmp_iint.mutex);
 
 		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
 					     ima_hash_algo, NULL);
@@ -600,22 +591,24 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			if (rc != -ENOMEM)
 				kfree(tmp_iint.ima_hash);
 
+			ima_iint_unlock(inode);
 			return -EOPNOTSUPP;
 		}
 
 		iint = &tmp_iint;
-		mutex_lock(&iint->mutex);
 	}
 
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * ima_file_hash can be called when ima_collect_measurement has still
 	 * not been called, we might not always have a hash.
 	 */
 	if (!iint->ima_hash || !(iint->flags & IMA_COLLECTED)) {
-		mutex_unlock(&iint->mutex);
+		ima_iint_unlock(inode);
 		return -EOPNOTSUPP;
 	}
 
@@ -626,11 +619,12 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 		memcpy(buf, iint->ima_hash->digest, copied_size);
 	}
 	hash_algo = iint->ima_hash->algo;
-	mutex_unlock(&iint->mutex);
 
 	if (iint == &tmp_iint)
 		kfree(iint->ima_hash);
 
+	ima_iint_unlock(inode);
+
 	return hash_algo;
 }
 
@@ -1118,7 +1112,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  * @kmod_name: kernel module name
  *
  * Avoid a verification loop where verifying the signature of the modprobe
- * binary requires executing modprobe itself. Since the modprobe iint->mutex
+ * binary requires executing modprobe itself. Since the modprobe iint mutex
  * is already held when the signature verification is performed, a deadlock
  * occurs as soon as modprobe is executed within the critical region, since
  * the same lock cannot be taken again.
@@ -1193,6 +1187,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
+	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
@@ -1210,7 +1205,7 @@ static int __init init_ima_lsm(void)
 }
 
 struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct ima_iint_cache *),
+	.lbs_inode = sizeof(struct ima_iint_cache_lock),
 };
 
 DEFINE_LSM(ima) = {
-- 
2.47.0.118.gfd3785337b


