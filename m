Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387F602ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJRL7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJRL6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:58:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14FBD045;
        Tue, 18 Oct 2022 04:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC97B81EBA;
        Tue, 18 Oct 2022 11:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63840C433C1;
        Tue, 18 Oct 2022 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094273;
        bh=3O+gPnGHG8TPnDVhxwIEQLRX/A3IPzI7T52+FI1TLFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jp3IfAWjPn8To25BbWy8FOoVWO8v//uOUhBmZE5YWCoFhEgbk6xiivs8kgasELzs5
         12wjTus7RnnUOCIA3r2rzrrp1EjNfYxE/hykS54fGP6Tbh+cK0Moj6juzr3f47ChcR
         ezjHHTSsLnmv7fI7UX+Pd9iykokL3R/A6DaUDLnavOSh7I6FKTC+cX918JemUO7Ax6
         pESZnBfW1YQ9Z/czPBEVshHWd1QflwU7IMu3gCEqBKP1cgiWdy9MSUBOpGS4nxYqUu
         WSQUOWNBX5xHEQaGU/FOoMOzYYCXId941/7pA03KyqegN6jgkPYBwtKplVO9g3tKiC
         RrlbIG4bxK2jw==
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
Subject: [PATCH v5 13/30] evm: add post set acl hook
Date:   Tue, 18 Oct 2022 13:56:43 +0200
Message-Id: <20221018115700.166010-14-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=brauner@kernel.org; h=from:subject; bh=3O+gPnGHG8TPnDVhxwIEQLRX/A3IPzI7T52+FI1TLFQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVHvu7Tz4YONu9UWGMfGpM+arlh/TWrd1Dec1Q2pT39M yNq0oaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiOnaMDFsdXELnbNU9aPHS7fwdtw 0XinmNWbY63WFs91ncIuPuEMfIMHFNwdKX+7oi/vtVT2JsyWY793r6qmuqd5f7n2k0fjznAAcA
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

The security_inode_post_setxattr() hook is used by security modules to
update their own security.* xattrs. Consequently none of the security
modules operate on posix acls. So we don't need an additional security
hook when post setting posix acls.

However, the integrity subsystem wants to be informed about posix acl
changes in order to reset the EVM status flag.

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
This will cause the hashes to be updated as before.

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
    
    /* v5 */
    Mimi Zohar <zohar@linux.ibm.com>:
    - Tweak commit message.

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

