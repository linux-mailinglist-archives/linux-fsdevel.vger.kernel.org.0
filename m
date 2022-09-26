Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF35EAABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiIZPYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiIZPXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDF895F5;
        Mon, 26 Sep 2022 07:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8136D60DEB;
        Mon, 26 Sep 2022 14:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD46C433D7;
        Mon, 26 Sep 2022 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201361;
        bh=4761Hw9EEwamAX3MILsd8qPl7LDxfk4ndzMC4c60hY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgrhKlhbESAjyQzTk8hzWhzTZC1J2qEkaisrKmFDDuyzzYertdey5qghNHlfqR4fj
         FGDkbX6+Ihw9d/wYeb5kX3WRuCtFivMM106y/oxEEDIUOrG70aSsfRZXRrqO50IyU8
         hdSaQeha9734oF9xuMvg35zWYe+y7myfdrR3N77Y6GFfd5GOXfLGrtUIkBGcG4kzDW
         5noxg+LrHxPiO3irPfHkJz6kh+0p6rZ8WQqULUhqKMX55lPdZ4fOc96OXEd6GL8Uyt
         J9pOFOZ2zegHUqIMlVzuM5t1z0/nU3gYyP/VojIG3X3j7BEZLg91xDWGq2utzOJpTR
         QsWoyR66KPStQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 15/30] evm: add post set acl hook
Date:   Mon, 26 Sep 2022 16:08:12 +0200
Message-Id: <20220926140827.142806-16-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666; i=brauner@kernel.org; h=from:subject; bh=4761Hw9EEwamAX3MILsd8qPl7LDxfk4ndzMC4c60hY4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnJgzg6+OMeJJbjpaznf0eVliq2sqR922da0Lpq38Pv7 gnNlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ2s7wP0vgyv3CQ8I35jJFGsw9sP vp0zU1mcVsIozHahKMF60oO8nIMCfowUf3l7yHLmQ/6p9zYn2kDs+fd5b7z73eMS8q0vmTEjMA
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

Notes:
    /* v2 */
    unchanged

 fs/posix_acl.c      |  5 ++++-
 include/linux/evm.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 471d17fa1611..ef0908a4bc46 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -25,6 +25,7 @@
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/security.h>
+#include <linux/evm.h>
 #include <linux/fsnotify.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
@@ -1351,8 +1352,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
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
index aebcfd47d496..7811ce56e02f 100644
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
@@ -118,6 +124,13 @@ static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
 	return 0;
 }
 
+static inline void evm_inode_post_set_acl(struct dentry *dentry,
+					  const char *acl_name,
+					  struct posix_acl *kacl)
+{
+	return;
+}
+
 static inline int evm_inode_init_security(struct inode *inode,
 					  const struct xattr *xattr_array,
 					  struct xattr *evm)
-- 
2.34.1

