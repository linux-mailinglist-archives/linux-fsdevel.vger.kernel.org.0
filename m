Return-Path: <linux-fsdevel+bounces-39854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B180A1978D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF5188BA4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E921518B;
	Wed, 22 Jan 2025 17:25:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEE21422F;
	Wed, 22 Jan 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566738; cv=none; b=snBwmfWgEpdm48Gwp0/npJeRqMy5oKOajYNMyVrFemhFqCU72NANnaJ2yNW4HeSaO3okaGJ+DO6hrn1nVmKheTMFGLTapiAEY95NyKYmiQrd3mKgrCiCAPXaslzexDnI5kbc28POCIslUP8Jl0ocMqjtMnLETka9UINql3izU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566738; c=relaxed/simple;
	bh=HIQuHjkqPP2yvxQUtvoP5UA2nF1uxCswRA98U88pmrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s84YqIusX7XxztDNTTbsKEFHzpvlx4PNgD4bRcxmGYWBK0inOwtu1Y4tRTipBskhNT8L1gr7osogEfhfhpxs1xeNgBzQeLZFyxZLI1bQEahx3qv86gfOiUvD28mBioVNcvUzLSlMA1gim/EbEJQrvebWn99exV9b9v60I0N/+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdVl63qjfz9v7Vc;
	Thu, 23 Jan 2025 01:03:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9F7F6140CA4;
	Thu, 23 Jan 2025 01:25:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S4;
	Wed, 22 Jan 2025 18:25:27 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 2/6] ima: Remove inode lock
Date: Wed, 22 Jan 2025 18:24:28 +0100
Message-Id: <20250122172432.3074180-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S4
X-Coremail-Antispam: 1UD129KBjvAXoWfGry3trWkWw48Aw4xAFyfCrg_yoW8Gr1rWo
	WSy39xJrn8WrySyay8Ww1SyFWUu39xGrWfCrs5XFnrK3W2kryUX347W3W5JFW3Xr4rGr1q
	k3s7Jw4kJF9rJ3Wkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOb7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGeQmNQFNQABsf

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
index 24d09ea91b87..f96021637bcf 100644
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
index c35ea613c9f8..76b7280632fc 100644
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
index 6551be5754de..006f1e3725d6 100644
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
 
@@ -1115,7 +1109,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  * @kmod_name: kernel module name
  *
  * Avoid a verification loop where verifying the signature of the modprobe
- * binary requires executing modprobe itself. Since the modprobe iint->mutex
+ * binary requires executing modprobe itself. Since the modprobe iint mutex
  * is already held when the signature verification is performed, a deadlock
  * occurs as soon as modprobe is executed within the critical region, since
  * the same lock cannot be taken again.
@@ -1190,6 +1184,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
+	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
@@ -1207,7 +1202,7 @@ static int __init init_ima_lsm(void)
 }
 
 struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct ima_iint_cache *),
+	.lbs_inode = sizeof(struct ima_iint_cache_lock),
 };
 
 DEFINE_LSM(ima) = {
-- 
2.34.1


