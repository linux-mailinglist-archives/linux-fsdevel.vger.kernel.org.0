Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535C5EF8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiI2Pdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiI2PcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C3135043;
        Thu, 29 Sep 2022 08:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAC6F61484;
        Thu, 29 Sep 2022 15:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4DDC433D6;
        Thu, 29 Sep 2022 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465497;
        bh=7JNyt5RQKkEtQ8rAtIsu9ElzMdpi8bUl8DXl+EGS0u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4h1uoF7Gj6ObBrcyGBgnqtcILSWEQ7XUnn09f4tKX+LLwlpFGxtDM+jDFTlQgOKX
         JqlUgo5HVh4c7qXFe+yPptlheH3bGO6VNa/NCjZH6Gi5mbIdAl+zE4tm6C/hwhDh9o
         hs6XgNUmGlBV+7an3Uw5WpBS6NaNllLb9F739ZrRMWOyKjsbNmDPOYyad2xabZn33a
         t7hxG8e1axREnMLJ2TjxL29KepHXVPokuRJ1ZG0pK2PB1URBTwsY+YDTNRw8r7bxjC
         h0tcYlQCALjFrW1CEWu8xLYDJmo+Lxo2ywcnMqLMgIwiYe9/rR8wGVnEQPv8FAAOih
         aNeXPlEMzJ13g==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 17/30] acl: add vfs_remove_acl()
Date:   Thu, 29 Sep 2022 17:30:27 +0200
Message-Id: <20220929153041.500115-18-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5631; i=brauner@kernel.org; h=from:subject; bh=7JNyt5RQKkEtQ8rAtIsu9ElzMdpi8bUl8DXl+EGS0u0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hKd5HPKvWnS5wMzfm0s+1hu2C9xY6vnTguFTzf9W/gN /2QzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkizzD/7L7duGz5f5ZdbVMWab32H KiApfV/Q9a8R//Wn9jWXw95xHDf++CFLbdrY5LXp8rErn4ZfODi5uzyytZxDp/3NY7VMQlxA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/evm.h       | 13 ++++++++
 include/linux/posix_acl.h |  8 +++++
 3 files changed, 86 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 41752d51b331..01209603afc9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1486,3 +1486,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
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

