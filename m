Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F45EF8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiI2PdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiI2PcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9F1138EE;
        Thu, 29 Sep 2022 08:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C955FB824F8;
        Thu, 29 Sep 2022 15:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B898C4347C;
        Thu, 29 Sep 2022 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465488;
        bh=PA/C5Bhmd27EHXCpHUNsenq+Sp0N9Nx+ma3BNixH/D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye2yjCqkNeY9NzhZukvZ6fOwyFmBq86fcHd1CyjA6YkeSwgmPmKc0pN8KuYbOualI
         rsEBYIvCsoijEOtArMQNzIXyPohmOoehH/6o24OXQadRCw1ga/UhM0SA0oFpZRUpGo
         wRLotcZfM9JpJ9ukxUcKBt3LI2MjrWaK1Akfgo7cx+ko/VAPm67rphr1qC91R3WHQF
         qfX+TzCFp86p0e6bHJ19bPo9fiIE6SKxd5YQyCphn8BWOzCIxLBBQJzHAYFXmG2cee
         IvA5nm4cp1oysRDB10/8RtRGMKT1DMuOGW/ztyoRcrsKlw331qQuhXbRWfUSZ8sC+X
         xWL5n53He0d9w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 13/30] evm: add post set acl hook
Date:   Thu, 29 Sep 2022 17:30:23 +0200
Message-Id: <20220929153041.500115-14-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org; h=from:subject; bh=PA/C5Bhmd27EHXCpHUNsenq+Sp0N9Nx+ma3BNixH/D8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hLh5Zhir5MQnLFYZ53SZmnhpZxVj+yKnoc3lez0OqOu Lt3dUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHZfAz/M2dGP6nZlG9qxbdz17qEGy 3v7r6dHnsjM8a+93xU7yfT84wMDwrXFMb9Etr7zqTepu3Aokl7jbx0JLsf10379/UN4+kIbgA=
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

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Reviewed-by: Paul Moore <paul@paul-moore.com>
    
    /* v4 */
    unchanged

 include/linux/evm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 86139be48992..117ac01b2432 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -44,6 +44,12 @@ static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
 {
 	return evm_inode_set_acl(mnt_userns, dentry, acl_name, NULL);
 }
+static inline void evm_inode_post_set_acl(struct dentry *dentry,
+					  const char *acl_name,
+					  struct posix_acl *kacl)
+{
+	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
+}
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
@@ -131,6 +137,13 @@ static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
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

