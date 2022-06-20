Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2C551EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiFTOfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbiFTOeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7520C47
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 326C3B811A5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA7C341C5;
        Mon, 20 Jun 2022 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733017;
        bh=w17qTr5fFqxr6HlQFG2e6I2TiZlftaodApDuN8pAAJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7jeT5zqlo+TxDaSTToWTDy+MhFGgZpjwt/E7eO+bFYZukHQOljiZxcd+ZG4GRgSL
         a15xmYWQeYaW6j/jqRXl6nx6n42nFLA8Wcs4M5LoOGhHd/0U/RA8sElwdplTx3TL3F
         RLysfUU4p8CWLNjMjeKXnurpt/bcnqFJeUGKyw/O9AyUoPDyg3TTGdM/6AuSWysX0W
         Xbjg54/THOhlKgFX5Y4GUp5Q+5d2COhNYc4x/Bcmdbx8WrAnz1sslwID1/qEk8voS2
         cEWk/Kgrk2eKJ9iiOc6NNZqOkDPhUxe+AVt63uMPRw8GQgBjtIsBSiDt2gKp+LpzC/
         4PiIP5w1lcINA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 7/8] security: pass down mount idmapping to setattr hook
Date:   Mon, 20 Jun 2022 15:49:46 +0200
Message-Id: <20220620134947.2772863-8-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7161; h=from:subject; bh=w17qTr5fFqxr6HlQFG2e6I2TiZlftaodApDuN8pAAJ4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHrb+n6eBZf04QSPI6cWe2z683ZVTlM1A8uMDz063Tc/ Tna531HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRo4cZGb6v3p7r2/z1fyHf4ew7Gy 2jv03T4Zg0v+4wU7JGYkFuezfDPyst5am15mW2XPM+5K/Yna9ex70iaeuesrzoXwG6t+50cAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before this change we used to take a shortcut and place the actual
values that would be written to inode->i_{g,u}id into struct iattr. This
had the advantage that we moved idmappings mostly out of the picture
early on but it made reasoning about changes more difficult than it
should be.

The filesystem was never explicitly told that it dealt with an idmapped
mount. The transition to the value that needed to be stored in
inode->i_{g,u}id appeared way too early and increased the probability of
bugs in various codepaths.

We know place the same value in struct iattr no matter if this is an
idmapped mount or not. The vfs will only deal with type safe
kmnt{g,u}id_t. This makes it massively safer to perform permission
checks as the type will tell us what checks we need to perform and what
helpers we need to use.

Adapt the security_inode_setattr() helper to pass down the mount's
idmapping to account for that change.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/attr.c                         | 2 +-
 fs/fat/file.c                     | 3 ++-
 include/linux/evm.h               | 6 ++++--
 include/linux/security.h          | 8 +++++---
 security/integrity/evm/evm_main.c | 8 +++++---
 security/security.c               | 5 +++--
 6 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 2e180dd9460f..88e2ca30d42e 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -411,7 +411,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
 		return -EOVERFLOW;
 
-	error = security_inode_setattr(dentry, attr);
+	error = security_inode_setattr(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 	error = try_break_deleg(inode, delegated_inode);
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 3dae3ed60f3a..530f18173db2 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -90,7 +90,8 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	 * out the RO attribute for checking by the security
 	 * module, just because it maps to a file mode.
 	 */
-	err = security_inode_setattr(file->f_path.dentry, &ia);
+	err = security_inode_setattr(&init_user_ns,
+				     file->f_path.dentry, &ia);
 	if (err)
 		goto out_unlock_inode;
 
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 4c374be70247..aa63e0b3c0a2 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -21,7 +21,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     void *xattr_value,
 					     size_t xattr_value_len,
 					     struct integrity_iint_cache *iint);
-extern int evm_inode_setattr(struct dentry *dentry, struct iattr *attr);
+extern int evm_inode_setattr(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *name,
@@ -68,7 +69,8 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 }
 #endif
 
-static inline int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
+static inline int evm_inode_setattr(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, struct iattr *attr)
 {
 	return 0;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 7fc4e9f49f54..4d0baf30266e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -353,7 +353,8 @@ int security_inode_readlink(struct dentry *dentry);
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu);
 int security_inode_permission(struct inode *inode, int mask);
-int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
+int security_inode_setattr(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, const char *name,
@@ -848,8 +849,9 @@ static inline int security_inode_permission(struct inode *inode, int mask)
 	return 0;
 }
 
-static inline int security_inode_setattr(struct dentry *dentry,
-					  struct iattr *attr)
+static inline int security_inode_setattr(struct user_namespace *mnt_userns,
+					 struct dentry *dentry,
+					 struct iattr *attr)
 {
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index bcde6bc2a2ce..7f4af5b58583 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -755,7 +755,8 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
-static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
+static int evm_attr_change(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
@@ -775,7 +776,8 @@ static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
  */
-int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
+int evm_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 	enum integrity_status evm_status;
@@ -801,7 +803,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 		return 0;
 
 	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
-	    !evm_attr_change(dentry, attr))
+	    !evm_attr_change(mnt_userns, dentry, attr))
 		return 0;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
diff --git a/security/security.c b/security/security.c
index 188b8f782220..f85afb02ea1c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1324,7 +1324,8 @@ int security_inode_permission(struct inode *inode, int mask)
 	return call_int_hook(inode_permission, 0, inode, mask);
 }
 
-int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
+int security_inode_setattr(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, struct iattr *attr)
 {
 	int ret;
 
@@ -1333,7 +1334,7 @@ int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	ret = call_int_hook(inode_setattr, 0, dentry, attr);
 	if (ret)
 		return ret;
-	return evm_inode_setattr(dentry, attr);
+	return evm_inode_setattr(mnt_userns, dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
-- 
2.34.1

