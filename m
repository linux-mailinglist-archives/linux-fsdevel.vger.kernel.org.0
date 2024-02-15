Return-Path: <linux-fsdevel+bounces-11695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CB5856038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7A32871A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4B136661;
	Thu, 15 Feb 2024 10:40:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71543131742;
	Thu, 15 Feb 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993600; cv=none; b=di8aXNlW16WyUxURB8WlhpZQ71Zm0wJyKlKK22pbXAJO0T8WTnIZkZfQyuwagFooYuN3POgVYP1ajL/p1Opcev5rn6+n5daMdcELFz1A1yWLS5SCugyjEKZQINlxguOyqLiaTQn+r9gGb/2dXpHk/weFGrT3D19H/uyCc+ibdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993600; c=relaxed/simple;
	bh=xzVxo+pz89esXqXypP0zK8EBUx994TIoRv/UmpnrbNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMb1lrSVZQa3hhLRYwaNJVmK7/lzBe3bNjaDUHm1xxZ8oKfv8PNXL2/fq/5ZuYoPp2nEEg6jzlfbpqGgRd1WRicU+9+SSh2CA7hJULz2iqIPDFsSmr3/ifd1B2HThIkk3VnsLWlFHLo7c3q7v7N+vUL1zMhjNxEQIxrYFJ4oX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbB541JRtz9yB7M;
	Thu, 15 Feb 2024 18:24:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 080FD1405A1;
	Thu, 15 Feb 2024 18:39:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHABmc6c1lwxGNAg--.11795S7;
	Thu, 15 Feb 2024 11:39:45 +0100 (CET)
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
Subject: [PATCH v10 25/25] integrity: Remove LSM
Date: Thu, 15 Feb 2024 11:31:13 +0100
Message-Id: <20240215103113.2369171-26-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHABmc6c1lwxGNAg--.11795S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWxAw4fAw1DAFW7Gr4kZwb_yoWfuw4xpF
	W7KayUJr4rZFW0kF4vyFy5ur4fK34qgFZ7W34Ykw1kAFyqvrn0qFs8AryUuF1rGrWFq34I
	qr4akr45ZF1DtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UWVbkUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf6QAAsZ

From: Roberto Sassu <roberto.sassu@huawei.com>

Since now IMA and EVM use their own integrity metadata, it is safe to
remove the 'integrity' LSM, with its management of integrity metadata.

Keep the iint.c file only for loading IMA and EVM keys at boot, and for
creating the integrity directory in securityfs (we need to keep it for
retrocompatibility reasons).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/integrity.h      |  14 ---
 security/integrity/iint.c      | 197 +--------------------------------
 security/integrity/integrity.h |  25 -----
 security/security.c            |   2 -
 4 files changed, 2 insertions(+), 236 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index ef0f63ef5ebc..459b79683783 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -19,24 +19,10 @@ enum integrity_status {
 	INTEGRITY_UNKNOWN,
 };
 
-/* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
-extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
 extern void __init integrity_load_keys(void);
 
 #else
-static inline struct integrity_iint_cache *
-				integrity_inode_get(struct inode *inode)
-{
-	return NULL;
-}
-
-static inline void integrity_inode_free(struct inode *inode)
-{
-	return;
-}
-
 static inline void integrity_load_keys(void)
 {
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index d4419a2a1e24..068ac6c2ae1e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -6,207 +6,14 @@
  * Mimi Zohar <zohar@us.ibm.com>
  *
  * File: integrity_iint.c
- *	- implements the integrity hooks: integrity_inode_alloc,
- *	  integrity_inode_free
- *	- cache integrity information associated with an inode
- *	  using a rbtree tree.
+ *	- initialize the integrity directory in securityfs
+ *	- load IMA and EVM keys
  */
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/rbtree.h>
-#include <linux/file.h>
-#include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/lsm_hooks.h>
 #include "integrity.h"
 
-static struct rb_root integrity_iint_tree = RB_ROOT;
-static DEFINE_RWLOCK(integrity_iint_lock);
-static struct kmem_cache *iint_cache __ro_after_init;
-
 struct dentry *integrity_dir;
 
-/*
- * __integrity_iint_find - return the iint associated with an inode
- */
-static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-	struct rb_node *n = integrity_iint_tree.rb_node;
-
-	while (n) {
-		iint = rb_entry(n, struct integrity_iint_cache, rb_node);
-
-		if (inode < iint->inode)
-			n = n->rb_left;
-		else if (inode > iint->inode)
-			n = n->rb_right;
-		else
-			return iint;
-	}
-
-	return NULL;
-}
-
-/*
- * integrity_iint_find - return the iint associated with an inode
- */
-struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-
-	if (!IS_IMA(inode))
-		return NULL;
-
-	read_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	read_unlock(&integrity_iint_lock);
-
-	return iint;
-}
-
-#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
-
-/*
- * It is not clear that IMA should be nested at all, but as long is it measures
- * files both on overlayfs and on underlying fs, we need to annotate the iint
- * mutex to avoid lockdep false positives related to IMA + overlayfs.
- * See ovl_lockdep_annotate_inode_mutex_key() for more details.
- */
-static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
-					 struct inode *inode)
-{
-#ifdef CONFIG_LOCKDEP
-	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
-
-	int depth = inode->i_sb->s_stack_depth;
-
-	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
-		depth = 0;
-
-	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
-#endif
-}
-
-static void iint_init_always(struct integrity_iint_cache *iint,
-			     struct inode *inode)
-{
-	iint->ima_hash = NULL;
-	iint->version = 0;
-	iint->flags = 0UL;
-	iint->atomic_flags = 0UL;
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	iint->measured_pcrs = 0;
-	mutex_init(&iint->mutex);
-	iint_lockdep_annotate(iint, inode);
-}
-
-static void iint_free(struct integrity_iint_cache *iint)
-{
-	kfree(iint->ima_hash);
-	mutex_destroy(&iint->mutex);
-	kmem_cache_free(iint_cache, iint);
-}
-
-/**
- * integrity_inode_get - find or allocate an iint associated with an inode
- * @inode: pointer to the inode
- * @return: allocated iint
- *
- * Caller must lock i_mutex
- */
-struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
-{
-	struct rb_node **p;
-	struct rb_node *node, *parent = NULL;
-	struct integrity_iint_cache *iint, *test_iint;
-
-	iint = integrity_iint_find(inode);
-	if (iint)
-		return iint;
-
-	iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
-	if (!iint)
-		return NULL;
-
-	iint_init_always(iint, inode);
-
-	write_lock(&integrity_iint_lock);
-
-	p = &integrity_iint_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		test_iint = rb_entry(parent, struct integrity_iint_cache,
-				     rb_node);
-		if (inode < test_iint->inode) {
-			p = &(*p)->rb_left;
-		} else if (inode > test_iint->inode) {
-			p = &(*p)->rb_right;
-		} else {
-			write_unlock(&integrity_iint_lock);
-			kmem_cache_free(iint_cache, iint);
-			return test_iint;
-		}
-	}
-
-	iint->inode = inode;
-	node = &iint->rb_node;
-	inode->i_flags |= S_IMA;
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, &integrity_iint_tree);
-
-	write_unlock(&integrity_iint_lock);
-	return iint;
-}
-
-/**
- * integrity_inode_free - called on security_inode_free
- * @inode: pointer to the inode
- *
- * Free the integrity information(iint) associated with an inode.
- */
-void integrity_inode_free(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-
-	if (!IS_IMA(inode))
-		return;
-
-	write_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
-	write_unlock(&integrity_iint_lock);
-
-	iint_free(iint);
-}
-
-static void iint_init_once(void *foo)
-{
-	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
-
-	memset(iint, 0, sizeof(*iint));
-}
-
-static int __init integrity_iintcache_init(void)
-{
-	iint_cache =
-	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, iint_init_once);
-	return 0;
-}
-DEFINE_LSM(integrity) = {
-	.name = "integrity",
-	.init = integrity_iintcache_init,
-	.order = LSM_ORDER_LAST,
-};
-
-
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 671fc50255f9..50d6f798e613 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -102,31 +102,6 @@ struct ima_file_id {
 	__u8 hash[HASH_MAX_DIGESTSIZE];
 } __packed;
 
-/* integrity data associated with an inode */
-struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-	struct mutex mutex;	/* protects: version, flags, digest */
-	struct inode *inode;	/* back pointer to inode in question */
-	u64 version;		/* track inode changes */
-	unsigned long flags;
-	unsigned long measured_pcrs;
-	unsigned long atomic_flags;
-	unsigned long real_ino;
-	dev_t real_dev;
-	enum integrity_status ima_file_status:4;
-	enum integrity_status ima_mmap_status:4;
-	enum integrity_status ima_bprm_status:4;
-	enum integrity_status ima_read_status:4;
-	enum integrity_status ima_creds_status:4;
-	enum integrity_status evm_status:4;
-	struct ima_digest_data *ima_hash;
-};
-
-/* rbtree tree calls to lookup, insert, delete
- * integrity data associated with an inode.
- */
-struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
-
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
 
diff --git a/security/security.c b/security/security.c
index de8a9a7b2a30..4317bcd6ec6a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/integrity.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
@@ -1598,7 +1597,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
  */
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.34.1


