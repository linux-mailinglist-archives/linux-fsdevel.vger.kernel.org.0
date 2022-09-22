Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC105E66D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiIVPTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiIVPSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE11EFA7E;
        Thu, 22 Sep 2022 08:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF27B8383A;
        Thu, 22 Sep 2022 15:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B4DC433C1;
        Thu, 22 Sep 2022 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859898;
        bh=MWkCA5LiKPHul7BioBZdrKO+vKgKGFCjQnDwD8FxHH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHVde9E9xJPWPz4zDDjZs7cHtmUFgFMWKfWqo6rNwirFSZK1tB3kUMFJtqnp10EBp
         vHNI/555nw0MHxAe23BkFWs8kQ/cmNGkqaUNIwpvkXu4oofCupbyPocSsFYli6RKi5
         XglMxjJM99KqcJfxxZkhRI8Ajt8ECmzPRrrahPUAFxDjhOIcvo4NMcNk83OXuqxICa
         SfkaltFu2M6gy1FGLhPAY2Tiy9K+J9iIp1pcXSrQAaGyg6JZFoJ7gUJHSMquU6sTTh
         NDszDAzwqGOGYd7bN4BsNl6xjjX1dTgghH7teFFwbBddQQsX+8OBaOoHEUOnmOqh4P
         rc+Lzp76UYipA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 14/29] evm: add post set acl hook
Date:   Thu, 22 Sep 2022 17:17:12 +0200
Message-Id: <20220922151728.1557914-15-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591; i=brauner@kernel.org; h=from:subject; bh=MWkCA5LiKPHul7BioBZdrKO+vKgKGFCjQnDwD8FxHH8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FRxb7rwl0eoMNLsV+2qWL+JyvNO3hP7zOs4+8zXF4UR T/9qdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEbiYjw6WtKS0vT2UHV9kLbTXKlv ofrPSJ/2Z50I1SZ8Xb72XibzEyfDHve3L6fYPRg+UXG8P6DhxdL2nIGDL/8pTyhpMMRikKTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The security_inode_post_setxattr() hook is used by security modules to
update their own security.* xattrs. Consequently none of the security
modules operate on posix acls. So we don't need an additional security
hook when post setting posix acls.

However, the integrity subsystem wants to be informed about posix acl
changes and specifically evm to update their hashes when the xattrs
change. The callchain for evm_inode_post_setxattr() is:

-> evm_inode_post_setxattr()
   -> evm_update_evmxattr()
      -> evm_calc_hmac()
         -> evm_calc_hmac_or_hash()

and evm_cacl_hmac_or_hash() walks the global list of protected xattr
names evm_config_xattrnames. This global list can be modified via
/sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
restricted to security.* xattrs and the default xattrs in
evm_config_xattrnames only contains security.* xattrs as well.

So the actual value for posix acls is currently completely irrelevant
for evm during evm_inode_post_setxattr() and frankly it should stay that
way in the future to not cause the vfs any more headaches. But if the
actual posix acl values matter then evm shouldn't operate on the binary
void blob and try to hack around in the uapi struct anyway. Instead it
should then in the future add a dedicated hook which takes a struct
posix_acl argument passing the posix acls in the proper vfs format.

For now it is sufficient to make evm_inode_post_set_acl() a wrapper
around evm_inode_post_setxattr() not passing any actual values down.
This will still cause the hashes to be updated as before.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c      |  5 ++++-
 include/linux/evm.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5ff0d8b05194..752e9bda8840 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -25,6 +25,7 @@
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/security.h>
+#include <linux/evm.h>
 #include <linux/fsnotify.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
@@ -1350,8 +1351,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		error = -EIO;
 	else
 		error = -EOPNOTSUPP;
-	if (!error)
+	if (!error) {
 		fsnotify_xattr(dentry);
+		evm_inode_post_set_acl(dentry, acl_name, kacl);
+	}
 
 out_inode_unlock:
 	inode_unlock(inode);
diff --git a/include/linux/evm.h b/include/linux/evm.h
index aebcfd47d496..d735a1757bdf 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -38,6 +38,12 @@ extern void evm_inode_post_removexattr(struct dentry *dentry,
 extern int evm_inode_set_acl(struct user_namespace *mnt_userns,
 			     struct dentry *dentry, const char *acl_name,
 			     struct posix_acl *kacl);
+static inline void evm_inode_post_set_acl(struct dentry *dentry,
+					  const char *acl_name,
+					  struct posix_acl *kacl)
+{
+	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
+}
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
@@ -118,6 +124,12 @@ static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
 	return 0;
 }
 
+static inline void evm_inode_post_set_acl(struct dentry *dentry,
+					  const char *acl_name)
+{
+	return;
+}
+
 static inline int evm_inode_init_security(struct inode *inode,
 					  const struct xattr *xattr_array,
 					  struct xattr *evm)
-- 
2.34.1

