Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE278EC4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbjHaLko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjHaLkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:40:43 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF93E64;
        Thu, 31 Aug 2023 04:40:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbzS04Cn2z9xFQH;
        Thu, 31 Aug 2023 19:28:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHebm+e_BkHQreAQ--.24451S7;
        Thu, 31 Aug 2023 12:39:52 +0100 (CET)
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
Subject: [PATCH v2 25/25] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Date:   Thu, 31 Aug 2023 13:38:03 +0200
Message-Id: <20230831113803.910630-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHebm+e_BkHQreAQ--.24451S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfGFy8XFyDtr1UAFWDurg_yoWxJw1UpF
        42gayUJws8ZFWj9F4vyFZ8ur4fKFyqgFZ7W34Ykw1kAFyvvr1jqFs8AryUZFy5GrW5t34I
        qrn0kr4UZF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z2
        80aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49dsAAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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

