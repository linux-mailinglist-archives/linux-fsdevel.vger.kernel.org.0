Return-Path: <linux-fsdevel+bounces-1351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB277D926F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34387282348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724AF12B84;
	Fri, 27 Oct 2023 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872911715
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:44:26 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C01FD8;
	Fri, 27 Oct 2023 01:44:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGwm92lp8z9xGYP;
	Fri, 27 Oct 2023 16:28:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnP5EaeDtl3AMCAw--.27269S5;
	Fri, 27 Oct 2023 09:43:55 +0100 (CET)
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
Subject: [PATCH v4 23/23] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Date: Fri, 27 Oct 2023 10:42:34 +0200
Message-Id: <20231027084234.485243-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnP5EaeDtl3AMCAw--.27269S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfJr4xZFyxGr4fCF17KFg_yoWxuF1kpF
	42gay8Jws8ZFWq9F4vyFW5Zr4fKFyqgFZ7W34Ykw1kAFyvvr1YqFs8AryUZF15GrW5t34I
	qr1Ykr4UuF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5WUfgABsJ
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Before the security field of kernel objects could be shared among LSMs with
the LSM stacking feature, IMA and EVM had to rely on an alternative storage
of inode metadata. The association between inode metadata and inode is
maintained through an rbtree.

Because of this alternative storage mechanism, there was no need to use
disjoint inode metadata, so IMA and EVM today still share them.

With the reservation mechanism offered by the LSM infrastructure, the
rbtree is no longer necessary, as each LSM could reserve a space in the
security blob for each inode. However, since IMA and EVM share the
inode metadata, they cannot directly reserve the space for them.

Instead, request from the 'integrity' LSM a space in the security blob for
the pointer of inode metadata (integrity_iint_cache structure). The other
reason for keeping the 'integrity' LSM is to preserve the original ordering
of IMA and EVM functions as when they were hardcoded.

Prefer reserving space for a pointer to allocating the integrity_iint_cache
structure directly, as IMA would require it only for a subset of inodes.
Always allocating it would cause a waste of memory.

Introduce two primitives for getting and setting the pointer of
integrity_iint_cache in the security blob, respectively
integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
the code more understandable, as they directly replace rbtree operations.

Locking is not needed, as access to inode metadata is not shared, it is per
inode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/iint.c      | 71 +++++-----------------------------
 security/integrity/integrity.h | 20 +++++++++-
 2 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 31a0fda3f1a1..0ce4b38c6b7d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -14,56 +14,25 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/rbtree.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include "integrity.h"
 
-static struct rb_root integrity_iint_tree = RB_ROOT;
-static DEFINE_RWLOCK(integrity_iint_lock);
 static struct kmem_cache *iint_cache __read_mostly;
 
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
 /*
  * integrity_iint_find - return the iint associated with an inode
  */
 struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
 {
-	struct integrity_iint_cache *iint;
-
 	if (!IS_IMA(inode))
 		return NULL;
 
-	read_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	read_unlock(&integrity_iint_lock);
-
-	return iint;
+	return integrity_inode_get_iint(inode);
 }
 
 #define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
@@ -123,9 +92,7 @@ static void iint_free(struct integrity_iint_cache *iint)
  */
 struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 {
-	struct rb_node **p;
-	struct rb_node *node, *parent = NULL;
-	struct integrity_iint_cache *iint, *test_iint;
+	struct integrity_iint_cache *iint;
 
 	iint = integrity_iint_find(inode);
 	if (iint)
@@ -137,31 +104,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 
 	iint_init_always(iint, inode);
 
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
 	iint->inode = inode;
-	node = &iint->rb_node;
 	inode->i_flags |= S_IMA;
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, &integrity_iint_tree);
+	integrity_inode_set_iint(inode, iint);
 
-	write_unlock(&integrity_iint_lock);
 	return iint;
 }
 
@@ -178,10 +124,8 @@ static void integrity_inode_free(struct inode *inode)
 	if (!IS_IMA(inode))
 		return;
 
-	write_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
-	write_unlock(&integrity_iint_lock);
+	iint = integrity_iint_find(inode);
+	integrity_inode_set_iint(inode, NULL);
 
 	iint_free(iint);
 }
@@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
 	return 0;
 }
 
+struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct integrity_iint_cache *),
+};
+
 /*
  * Keep it until IMA and EVM can use disjoint integrity metadata, and their
  * initialization order can be swapped without change in their behavior.
@@ -239,6 +187,7 @@ DEFINE_LSM(integrity) = {
 	.name = "integrity",
 	.init = integrity_lsm_init,
 	.order = LSM_ORDER_LAST,
+	.blobs = &integrity_blob_sizes,
 };
 
 /*
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e4df82d6f6e7..ef2689b5264d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -158,7 +158,6 @@ struct ima_file_id {
 
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
@@ -192,6 +191,25 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
+extern struct lsm_blob_sizes integrity_blob_sizes;
+
+static inline struct integrity_iint_cache *
+integrity_inode_get_iint(const struct inode *inode)
+{
+	struct integrity_iint_cache **iint_sec;
+
+	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
+	return *iint_sec;
+}
+
+static inline void integrity_inode_set_iint(const struct inode *inode,
+					    struct integrity_iint_cache *iint)
+{
+	struct integrity_iint_cache **iint_sec;
+
+	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
+	*iint_sec = iint;
+}
 
 struct modsig;
 
-- 
2.34.1


