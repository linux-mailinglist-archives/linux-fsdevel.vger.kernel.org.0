Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074477918FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351376AbjIDNnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbjIDNnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:43:08 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D15E5D;
        Mon,  4 Sep 2023 06:42:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfTwZ0209z9xHM3;
        Mon,  4 Sep 2023 21:28:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCXSblt3vVkorkeAg--.30599S7;
        Mon, 04 Sep 2023 14:42:13 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 25/25] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Date:   Mon,  4 Sep 2023 15:40:49 +0200
Message-Id: <20230904134049.1802006-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCXSblt3vVkorkeAg--.30599S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfGFy8XFyDtr1UAFWDurg_yoWxGrWUpF
        42gayUJws8ZFWj9F4vyF98ur4fKFyjqFZ7W34Ykw1kAFyvvr1jqFs8AryUZF15GrW5t34I
        qrn0kr4UZF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5OBggAAsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/iint.c      | 67 +++-------------------------------
 security/integrity/integrity.h | 19 +++++++++-
 2 files changed, 24 insertions(+), 62 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 70ee803a33ea..c2fba8afbbdb 100644
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
 
 static void iint_free(struct integrity_iint_cache *iint)
@@ -92,9 +61,7 @@ static void iint_free(struct integrity_iint_cache *iint)
  */
 struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 {
-	struct rb_node **p;
-	struct rb_node *node, *parent = NULL;
-	struct integrity_iint_cache *iint, *test_iint;
+	struct integrity_iint_cache *iint;
 
 	iint = integrity_iint_find(inode);
 	if (iint)
@@ -104,31 +71,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
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
 
@@ -145,10 +91,8 @@ static void integrity_inode_free(struct inode *inode)
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
@@ -188,6 +132,7 @@ static int __init integrity_lsm_init(void)
 }
 
 struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct integrity_iint_cache *),
 	.lbs_xattr_count = 1,
 };
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e020c365997b..24de4ad4a37e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -158,7 +158,6 @@ struct ima_file_id {
 
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
@@ -192,6 +191,24 @@ int integrity_kernel_read(struct file *file, loff_t offset,
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
2.34.1

