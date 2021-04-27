Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA836C538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhD0Lie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:38:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2928 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhD0Lie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:38:34 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FV03c6pYtz6yhqy;
        Tue, 27 Apr 2021 19:32:12 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:37:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 4/6] security: Support multiple LSMs implementing the inode_init_security hook
Date:   Tue, 27 Apr 2021 13:37:30 +0200
Message-ID: <20210427113732.471066-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427113732.471066-1-roberto.sassu@huawei.com>
References: <20210427113732.471066-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current implementation of security_inode_init_security() is capable of
handling only one LSM providing an xattr to be set at inode creation. That
xattr is then passed to EVM to calculate the HMAC.

To support multiple LSMs, each providing one or multiple xattrs, this patch
makes the following modifications to security_inode_init_security():
- dynamically allocates new_xattrs, based on the number of slots requested
  by LSMs (through the new field lbs_xattr introduced in the lsm_blob_sizes
  structure);
- replaces the call_int_hook() macro with its definition, to correctly
  handle the case of an LSM returning -EOPNOTSUPP (the loop should not be
  stopped);
- verifies whether or not inode_init_security hook implementations operated
  correctly:
  - LSMs returning zero must fill at least a slot;
  - LSMs must not fill a slot outside the xattr array;
  - LSMs must set an xattr name for each filled slot.

The modifications necessary for EVM to calculate the HMAC on all xattrs
will be done in a separate patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/security.c        | 64 ++++++++++++++++++++++++++++++++------
 security/selinux/hooks.c   |  5 ++-
 security/smack/smack_lsm.c |  5 ++-
 4 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 197d6662b262..cb6329ce8b0c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1581,6 +1581,7 @@ struct lsm_blob_sizes {
 	int	lbs_ipc;
 	int	lbs_msg_msg;
 	int	lbs_task;
+	int	lbs_xattr;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 527a18fd6742..91675003a5cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,8 +30,6 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 
-#define MAX_LSM_EVM_XATTR	2
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -204,6 +202,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_xattr, &blob_sizes.lbs_xattr);
 }
 
 /* Prepare LSM for initialization. */
@@ -339,6 +338,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
+	init_debug("xattr slots        = %d\n", blob_sizes.lbs_xattr);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -1042,9 +1042,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *xattr;
-	int ret, base_slot = 0;
+	struct xattr *new_xattrs, *xattr;
+	struct security_hook_list *P;
+	int ret, base_slot = 0, old_base_slot;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1052,11 +1052,56 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, &base_slot, fs_data);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-			    new_xattrs, &base_slot, fs_data);
-	if (ret)
+
+	/* Allocate +1 for EVM and +1 as terminator. */
+	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
+			     GFP_NOFS);
+	if (!new_xattrs)
+		return -ENOMEM;
+
+	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
+			     list) {
+		old_base_slot = base_slot;
+		ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+						  &base_slot, fs_data);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+
+			continue;
+		}
+
+		if (base_slot == old_base_slot) {
+			WARN_ONCE(
+			    "LSM %s: returned zero but didn't fill any slot\n",
+			    P->lsm);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (base_slot > blob_sizes.lbs_xattr) {
+			WARN_ONCE(
+			    "LSM %s: wrote xattr outside array (%d/%d)\n",
+			    P->lsm, base_slot, blob_sizes.lbs_xattr);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		while (old_base_slot < base_slot) {
+			if (new_xattrs[old_base_slot++].name != NULL)
+				continue;
+
+			WARN_ONCE("LSM %s: ret = 0 but xattr name = NULL\n",
+				  P->lsm);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (!base_slot) {
+		ret = -EOPNOTSUPP;
 		goto out;
+	}
 
 	ret = evm_inode_init_security(inode, new_xattrs,
 				      new_xattrs + base_slot);
@@ -1070,6 +1115,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 			continue;
 		kfree(xattr->value);
 	}
+	kfree(new_xattrs);
 	if (initxattrs == &security_initxattrs)
 		return ret;
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6319417129af..3ea56c706a58 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,6 +104,8 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+#define SELINUX_INODE_INIT_XATTRS 1
+
 struct selinux_state selinux_state;
 
 /* SECMARK reference count */
@@ -2922,7 +2924,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_find_xattr_slot(xattrs, base_slot,
-						  *base_slot + 1);
+		selinux_blob_sizes.lbs_xattr + SELINUX_INODE_INIT_XATTRS);
 	u32 newsid, clen;
 	int rc;
 	char *context;
@@ -6976,6 +6978,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_xattr = SELINUX_INODE_INIT_XATTRS,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 53e32cde09fb..cecba1228602 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -51,6 +51,8 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
+#define SMACK_INODE_INIT_XATTRS 1
+
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
 struct kmem_cache *smack_rule_cache;
@@ -978,7 +980,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	struct xattr *xattr = lsm_find_xattr_slot(xattrs, base_slot,
-						  *base_slot + 1);
+			smack_blob_sizes.lbs_xattr + SMACK_INODE_INIT_XATTRS);
 	int may;
 
 	if (xattr) {
@@ -4702,6 +4704,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_xattr = SMACK_INODE_INIT_XATTRS,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
-- 
2.25.1

