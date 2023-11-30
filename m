Return-Path: <linux-fsdevel+bounces-4521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B1800046
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C86A1C20866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BA18C03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA7171E;
	Thu, 30 Nov 2023 15:21:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4ShBZx2clnz9xFr4;
	Fri,  1 Dec 2023 07:04:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7D90B14068D;
	Fri,  1 Dec 2023 07:21:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3OdGGllXRuuAQ--.2350S6;
	Fri, 01 Dec 2023 00:20:59 +0100 (CET)
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
Subject: [PATCH v7 23/23] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Date: Fri,  1 Dec 2023 00:19:48 +0100
Message-Id: <20231130231948.2545638-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130231948.2545638-1-roberto.sassu@huaweicloud.com>
References: <20231130231948.2545638-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXU3OdGGllXRuuAQ--.2350S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfJr43ZrW5Zw1rurW5Awb_yoW3WrWDpF
	42gayUJwn8ZFWj9F4vyFy5Zr4fKFyvgFZ7Ww1Ykw1kAFyqvr1jqFs8AryUZF15GrW5t34I
	qrs0kr4UZ3WDtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj5MfaQABsC

From: Roberto Sassu <roberto.sassu@huawei.com>

Before the security field of kernel objects could be shared among LSMs with
the LSM stacking feature, IMA and EVM had to rely on an alternative storage
of inode metadata. The association between inode metadata and inode is
maintained through an rbtree.

With the reservation mechanism offered by the LSM infrastructure, the
rbtree is no longer necessary, as each LSM could reserve a space in the
security blob for each inode.

With the 'integrity' LSM removed, and with the 'ima' LSM taking its role,
reserve space from the 'ima' LSM for a pointer to the integrity_iint_cache
structure directly, rather than embedding the whole structure in the inode
security blob, to minimize the changes and to avoid waste of memory.

If IMA is disabled, EVM faces the same problems as before making it an
LSM, metadata verification fails for new files due to not setting the
IMA_NEW_FILE flag in ima_post_path_mknod(), and evm_verifyxattr()
returns INTEGRITY_UNKNOWN since IMA didn't call integrity_inode_get().

The only difference caused to moving the integrity metadata management
to the 'ima' LSM is the fact that EVM cannot take advantage of cached
verification results, and has to do the verification again. However,
this case should never happen, since the only public API available to
all kernel components, evm_verifyxattr(), does not work if IMA is
disabled.

Introduce two primitives for getting and setting the pointer of
integrity_iint_cache in the security blob, respectively
integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
the code more understandable, as they directly replace rbtree operations.

Locking is not needed, as access to inode metadata is not shared, it is per
inode.

Keep the blob size and the new primitives definition at the common level in
security/integrity rather than moving them in IMA itself, so that EVM can
still call integrity_inode_get() and integrity_iint_find() while IMA is
disabled. Just add an extra check in integrity_inode_get() to return NULL
if that is the case.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/iint.c         | 70 ++++---------------------------
 security/integrity/ima/ima_main.c |  1 +
 security/integrity/integrity.h    | 20 ++++++++-
 3 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index c36054041b84..8fc9455dda11 100644
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
 static struct kmem_cache *iint_cache __ro_after_init;
 
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
 
 	/*
 	 * After removing the 'integrity' LSM, the 'ima' LSM calls
@@ -144,31 +111,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 
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
 
@@ -185,10 +131,8 @@ void integrity_inode_free(struct inode *inode)
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
@@ -212,6 +156,10 @@ int __init integrity_iintcache_init(void)
 	return 0;
 }
 
+struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct integrity_iint_cache *),
+};
+
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3f59cce3fa02..52b4a3bba45a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1162,6 +1162,7 @@ DEFINE_LSM(ima) = {
 	.name = "ima",
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
+	.blobs = &integrity_blob_sizes,
 };
 
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 26d3b08dca1c..2fb35c67d64d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -158,7 +158,6 @@ struct ima_file_id {
 
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
@@ -194,6 +193,25 @@ int integrity_kernel_read(struct file *file, loff_t offset,
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


