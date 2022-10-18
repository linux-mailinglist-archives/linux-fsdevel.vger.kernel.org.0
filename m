Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE488602AD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJRL7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJRL7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3737BCBA4;
        Tue, 18 Oct 2022 04:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D70FB81EBB;
        Tue, 18 Oct 2022 11:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A46AC433D6;
        Tue, 18 Oct 2022 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094278;
        bh=hH35kXVXfsR30Xj7RhQBnMeUbGKABO87HrpwHsFmp60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3WJKvUdZ1n0KXeD/YypHD4ZJgIFZ6h9kIxOi/k/Xrgvra+AEEBINCf8AR+G50oES
         xOyaFg4uqFxHIOMJ18OUb/5aKNmuDSvt03ZvXygwNWBzC5UF9Ll1L8/M2oDZJ5VgXP
         veg8/TiHi42k7Dcov5wl9ZwgI7FGGsMBx7zZyZMwlXkhI4YiFOUydeygvlBvoHXAaP
         23vNGXpdSdiG1i31Q9DQLOAtJIHTyA3FR8cWxpoAfGt9DuvNje9V6oqcA21/VHiJfd
         CIhxz6lx4QSPyqFOhGuQGYqeUGDgStCMNoUs4OZZAQp+gXJxE/9Q12/qAbB3y/mHwG
         /6yDVgon4iOZg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 15/30] acl: add vfs_set_acl()
Date:   Tue, 18 Oct 2022 13:56:45 +0200
Message-Id: <20221018115700.166010-16-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6522; i=brauner@kernel.org; h=from:subject; bh=hH35kXVXfsR30Xj7RhQBnMeUbGKABO87HrpwHsFmp60=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVG3efBHpnZFm3fHtH/OOu9YKktVShpVfG+GykjuOut4 aM+CjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMsGH4n2ykOHV/4Lmvjy0deBcuvd 37o9P5YnrPnKCLO6w85pRv4GRk2PDQ91WhV+LGjoBZPefYL9v1r93+O90jax3n5KDuSutwZgA=
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
operations. We add a new vfs_set_acl() api that can be used to set posix
acls. This finally removes all type unsafety and type conversion issues
explained in detail in [1] that we aim to get rid of.

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

 fs/posix_acl.c                  | 107 ++++++++++++++++++++++++++++++++
 include/linux/posix_acl.h       |  10 +++
 include/linux/posix_acl_xattr.h |  10 +++
 3 files changed, 127 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 912faf932781..6a97eec981fe 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -25,6 +25,11 @@
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/iversion.h>
+#include <linux/security.h>
+#include <linux/evm.h>
+#include <linux/fsnotify.h>
+
+#include "internal.h"
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -1257,3 +1262,105 @@ int simple_acl_create(struct inode *dir, struct inode *inode)
 		posix_acl_release(acl);
 	return 0;
 }
+
+static int vfs_set_acl_idmapped_mnt(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    struct posix_acl *acl)
+{
+	for (int n = 0; n < acl->a_count; n++) {
+		struct posix_acl_entry *acl_e = &acl->a_entries[n];
+
+		switch (acl_e->e_tag) {
+		case ACL_USER:
+			acl_e->e_uid = from_vfsuid(mnt_userns, fs_userns,
+						   VFSUIDT_INIT(acl_e->e_uid));
+			break;
+		case ACL_GROUP:
+			acl_e->e_gid = from_vfsgid(mnt_userns, fs_userns,
+						   VFSGIDT_INIT(acl_e->e_gid));
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vfs_set_acl - set posix acls
+ * @mnt_userns: user namespace of the mount
+ * @dentry: the dentry based on which to set the posix acls
+ * @acl_name: the name of the posix acl
+ * @kacl: the posix acls in the appropriate VFS format
+ *
+ * This function sets @kacl. The caller must all posix_acl_release() on @kacl
+ * afterwards.
+ *
+ * Return: On success 0, on error negative errno.
+ */
+int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		const char *acl_name, struct posix_acl *kacl)
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
+	if (kacl) {
+		/*
+		 * If we're on an idmapped mount translate from mount specific
+		 * vfs{g,u}id_t into global filesystem k{g,u}id_t.
+		 * Afterwards we can cache the POSIX ACLs filesystem wide and -
+		 * if this is a filesystem with a backing store - ultimately
+		 * translate them to backing store values.
+		 */
+		error = vfs_set_acl_idmapped_mnt(mnt_userns, i_user_ns(inode), kacl);
+		if (error)
+			return error;
+	}
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
+	error = security_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	if (inode->i_opflags & IOP_XATTR)
+		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
+	else if (unlikely(is_bad_inode(inode)))
+		error = -EIO;
+	else
+		error = -EOPNOTSUPP;
+	if (!error) {
+		fsnotify_xattr(dentry);
+		evm_inode_post_set_acl(dentry, acl_name, kacl);
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
+EXPORT_SYMBOL_GPL(vfs_set_acl);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 07e171b4428a..316b05c1dc97 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -99,6 +99,9 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_acl = NULL;
 	inode->i_default_acl = NULL;
 }
+
+int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		const char *acl_name, struct posix_acl *kacl);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -126,6 +129,13 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 static inline void forget_all_cached_acls(struct inode *inode)
 {
 }
+
+static inline int vfs_set_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *name,
+			      struct posix_acl *acl)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_inode_acl(struct inode *inode, int type);
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index ebfa11ac7046..b86b7f170d43 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -72,6 +72,16 @@ static inline const char *posix_acl_xattr_name(int type)
 	return "";
 }
 
+static inline int posix_acl_type(const char *name)
+{
+	if (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0)
+		return ACL_TYPE_ACCESS;
+	else if (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0)
+		return ACL_TYPE_DEFAULT;
+
+	return -1;
+}
+
 extern const struct xattr_handler posix_acl_access_xattr_handler;
 extern const struct xattr_handler posix_acl_default_xattr_handler;
 
-- 
2.34.1

