Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD036A9ECB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCCS3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjCCS3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:29:12 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C802E819;
        Fri,  3 Mar 2023 10:28:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSx8J1Wh2z9xtRp;
        Sat,  4 Mar 2023 02:19:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHCAQOPAJkKY9rAQ--.12963S7;
        Fri, 03 Mar 2023 19:28:31 +0100 (CET)
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
Subject: [PATCH 28/28] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Date:   Fri,  3 Mar 2023 19:26:02 +0100
Message-Id: <20230303182602.1088032-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHCAQOPAJkKY9rAQ--.12963S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfGFy8XFyDtr1UAFWDurg_yoWxGF1xpF
        42gay8Jws8ZFWj9F4vyFZ8ur4fKFyqgFZ7W34Ykw1kAFyvvr1jqFs8AryUZFy5GrW5Kw1I
        qrn8Kr4UuF1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
        U0189tUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4otXQADsI
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Before the security field of kernel objects could be shared among LSMs with
the LSM stacking feature, IMA and EVM had to rely on an alternative storage
of inode metadata. The association between inode metadata and inode is
maintained through an rbtree.

With the reservation mechanism offered by the LSM infrastructure, the
rbtree is no longer necessary, as each LSM could reserve a space in the
security blob for each inode. Thus, request from the 'integrity' LSM a
space in the security blob for the pointer of inode metadata
(integrity_iint_cache structure).

Prefer this to allocating the integrity_iint_cache structure directly, as
IMA would require it only for a subset of inodes. Always allocating it
would cause a waste of memory.

Introduce two primitives for getting and setting the pointer of
integrity_iint_cache in the security blob, respectively
integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
the code more understandable, as they directly replace rbtree operations.

Locking is not needed, as access to inode metadata is not shared, it is per
inode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/iint.c      | 64 ++++------------------------------
 security/integrity/integrity.h | 20 ++++++++++-
 2 files changed, 25 insertions(+), 59 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index b12215d8b13..1610380de2f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -14,58 +14,25 @@
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
-			break;
-	}
-	if (!n)
-		return NULL;
-
-	return iint;
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
 
 static void iint_free(struct integrity_iint_cache *iint)
@@ -94,9 +61,7 @@ static void iint_free(struct integrity_iint_cache *iint)
  */
 struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 {
-	struct rb_node **p;
-	struct rb_node *node, *parent = NULL;
-	struct integrity_iint_cache *iint, *test_iint;
+	struct integrity_iint_cache *iint;
 
 	/*
 	 * The integrity's "iint_cache" is initialized at security_init(),
@@ -114,26 +79,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
-	write_lock(&integrity_iint_lock);
-
-	p = &integrity_iint_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		test_iint = rb_entry(parent, struct integrity_iint_cache,
-				     rb_node);
-		if (inode < test_iint->inode)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
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
 
@@ -150,10 +99,8 @@ static void integrity_inode_free(struct inode *inode)
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
@@ -193,6 +140,7 @@ static int __init integrity_lsm_init(void)
 }
 
 struct lsm_blob_sizes integrity_blob_sizes __lsm_ro_after_init = {
+	.lbs_inode = sizeof(struct integrity_iint_cache *),
 	.lbs_xattr = 1,
 };
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a3cbc65f9c6..720c2f183e4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -18,6 +18,7 @@
 #include <crypto/hash.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/lsm_hooks.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -157,7 +158,6 @@ struct ima_file_id {
 
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
@@ -191,6 +191,24 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 extern struct dentry *integrity_dir;
 extern struct lsm_blob_sizes integrity_blob_sizes;
 
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
+
 struct modsig;
 
 #ifdef CONFIG_IMA
-- 
2.25.1

