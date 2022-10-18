Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3907602ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJRL75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJRL7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E9BBD05A;
        Tue, 18 Oct 2022 04:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C98E1B81EB8;
        Tue, 18 Oct 2022 11:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79CCC433C1;
        Tue, 18 Oct 2022 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094282;
        bh=2BkIIXTbtryASSyRifiiLhiHX9PCwh+EK68WPINtxOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FciMpkbDhV+qg4KGEyoJVUiz5FEntoAqJ7YW2pV2LyPNebKQsm8P7hTodbB4e3cx6
         89xl0Zm0IQpj+kYCJqrTB/iwO11W459ilyukcVf8z6dNYJVFlZmGqqzcDSX/CtU1UP
         WQuk1a/V8ynkQhjJumf1NU0XHSzb+bjw4fWFrd2PHzuvEk9xBcN4mL0DnzWO1mPIvr
         1bi4ju6y9biBHmr0YwkCpAYpDGr4j/FTJ3Y3dCXtEAKwy68M0hwOXHgQI/NEaBe793
         Kg8RRyAK379gg+JMjRo5sjT/95BNTTtnEADNHXVmPRZP/SinvUkhN7PVPN8ZJg32Q0
         REejhVUWqcZlw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 17/30] acl: add vfs_remove_acl()
Date:   Tue, 18 Oct 2022 13:56:47 +0200
Message-Id: <20221018115700.166010-18-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5666; i=brauner@kernel.org; h=from:subject; bh=2BkIIXTbtryASSyRifiiLhiHX9PCwh+EK68WPINtxOQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdE4pH5m9+uTOQFxtYXny2/0/9hhtXDFb0+/NrbFgkuU WGUKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyqZmR4T0rx5Q6i/eHNfZ6bK7M8f nCsGL7+lndjc83/dHhb1SoE2H47239svmkYKUjk5R3sLLpq+99VTGOkpe4T5072fDuovBKTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In previous patches we implemented get and set inode operations for all
non-stacking filesystems that support posix acls but didn't yet
implement get and/or set acl inode operations. This specifically
affected cifs and 9p.

Now we can build a posix acl api based solely on get and set inode
operations. We add a new vfs_remove_acl() api that can be used to set
posix acls. This finally removes all type unsafety and type conversion
issues explained in detail in [1] that we aim to get rid of.

After we finished building the vfs api we can switch stacking
filesystems to rely on the new posix api and then finally switch the
xattr system calls themselves to rely on the posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/
    - return -EOPNOTSUPP from vfs_set_acl() if !CONFIG_FS_POSIX_ACL
    
    Christian Brauner (Microsoft) <brauner@kernel.org>:
    - use newly introduced may_write_xattr() helper
    
    /* v5 */
    unchanged

 fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/evm.h       | 13 ++++++++
 include/linux/posix_acl.h |  8 +++++
 3 files changed, 86 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index c4c8673cddcc..a84be3fdb6c5 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1479,3 +1479,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 	return acl;
 }
 EXPORT_SYMBOL_GPL(vfs_get_acl);
+
+/**
+ * vfs_remove_acl - remove posix acls
+ * @mnt_userns: user namespace of the mount
+ * @dentry: the dentry based on which to retrieve the posix acls
+ * @acl_name: the name of the posix acl
+ *
+ * This function removes posix acls.
+ *
+ * Return: On success 0, on error negative errno.
+ */
+int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name)
+{
+	int acl_type;
+	int error;
+	struct inode *inode = d_inode(dentry);
+	struct inode *delegated_inode = NULL;
+
+	acl_type = posix_acl_type(acl_name);
+	if (acl_type < 0)
+		return -EINVAL;
+
+retry_deleg:
+	inode_lock(inode);
+
+	/*
+	 * We only care about restrictions the inode struct itself places upon
+	 * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
+	 */
+	error = may_write_xattr(mnt_userns, inode);
+	if (error)
+		goto out_inode_unlock;
+
+	error = security_inode_remove_acl(mnt_userns, dentry, acl_name);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	if (inode->i_opflags & IOP_XATTR)
+		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
+	else if (unlikely(is_bad_inode(inode)))
+		error = -EIO;
+	else
+		error = -EOPNOTSUPP;
+	if (!error) {
+		fsnotify_xattr(dentry);
+		evm_inode_post_remove_acl(mnt_userns, dentry, acl_name);
+	}
+
+out_inode_unlock:
+	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(vfs_remove_acl);
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 117ac01b2432..7a9ee2157f69 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -35,6 +35,12 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
+static inline void evm_inode_post_remove_acl(struct user_namespace *mnt_userns,
+					     struct dentry *dentry,
+					     const char *acl_name)
+{
+	evm_inode_post_removexattr(dentry, acl_name);
+}
 extern int evm_inode_set_acl(struct user_namespace *mnt_userns,
 			     struct dentry *dentry, const char *acl_name,
 			     struct posix_acl *kacl);
@@ -123,6 +129,13 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
+static inline void evm_inode_post_remove_acl(struct user_namespace *mnt_userns,
+					     struct dentry *dentry,
+					     const char *acl_name)
+{
+	return;
+}
+
 static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
 				    struct dentry *dentry, const char *acl_name,
 				    struct posix_acl *kacl)
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 86aec1efc80e..ee608d22ecb9 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -104,6 +104,8 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl);
 struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *acl_name);
+int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -145,6 +147,12 @@ static inline struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline int vfs_remove_acl(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *acl_name)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_inode_acl(struct inode *inode, int type);
-- 
2.34.1

