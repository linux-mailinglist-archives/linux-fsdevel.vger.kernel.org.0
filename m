Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94B5EF90B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiI2Pes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiI2Pc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B0177341;
        Thu, 29 Sep 2022 08:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD46B824F2;
        Thu, 29 Sep 2022 15:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E8C4347C;
        Thu, 29 Sep 2022 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465519;
        bh=TALios6GJy/9Xg/rNe0HSqPJhJrlpV6C67TbXwjDa+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExF8x3nsS76oZRnO6pNjzcwx8w+G2yS27REl7tsMNAYd3kdvacOZeEnPTpYo8LWZ8
         lnI24p5qGoGhGf6E1gZcb7KBKcFg0L7nNaC+OXUMP45aTl9vrEHmkDQk70o/Dx1LCC
         RJn1609WJKQVB3cFhU7Df+YwzQizcm1+Dkw08iRjwYSazIHYFg3G553f6ANmX75h07
         H+DFC2heacb80xaUeo5pLw0hKtVqOGVsTOjEeDzFMnhy2FXWpHVv32VBL4rZov8Pc0
         5jjuyfcA47MPC2gFJhba2UssBc8d9pCqKZEiW4kzRXNBCz118aFqXTXRVHb7qDrQr3
         /nxsN0X0KfkpQ==
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
Subject: [PATCH v4 25/30] evm: remove evm_xattr_acl_change()
Date:   Thu, 29 Sep 2022 17:30:35 +0200
Message-Id: <20220929153041.500115-26-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891; i=brauner@kernel.org; h=from:subject; bh=TALios6GJy/9Xg/rNe0HSqPJhJrlpV6C67TbXwjDa+8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hJjkbOt/fZYhnsH4+GWnN6v2S7M3U9ebDqyu/N4i6eR 0bGvHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhcWL4p9k0c8cl/0X8i28tffh7dk u+6ctmYY+OkgZdU1fT7BCjGEaGjsQW/SxrXv3+rliWyqKmXS8mHfJ0MJBJFc52K95efJcJAA==
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

The security and integrity infrastructure has dedicated hooks now so
evm_xattr_acl_change() is dead code. Before this commit the callchain was:

evm_protect_xattr()
-> evm_xattr_change()
   -> evm_xattr_acl_change()

where evm_protect_xattr() was hit from evm_inode_setxattr() and
evm_inode_removexattr(). But now we have evm_inode_set_acl() and
evm_inode_remove_acl() and have switched over the vfs to rely on the posix
acl api so the code isn't hit anymore.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Remove evm_xattr_acl_change() completely.
    
    /* v4 */
    unchanged

 security/integrity/evm/evm_main.c | 64 -------------------------------
 1 file changed, 64 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7904786b610f..e0d120383870 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -434,66 +434,6 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
 }
 
-/*
- * evm_xattr_acl_change - check if passed ACL changes the inode mode
- * @mnt_userns: user namespace of the idmapped mount
- * @dentry: pointer to the affected dentry
- * @xattr_name: requested xattr
- * @xattr_value: requested xattr value
- * @xattr_value_len: requested xattr value length
- *
- * Check if passed ACL changes the inode mode, which is protected by EVM.
- *
- * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
- */
-static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
-				struct dentry *dentry, const char *xattr_name,
-				const void *xattr_value, size_t xattr_value_len)
-{
-#ifdef CONFIG_FS_POSIX_ACL
-	umode_t mode;
-	struct posix_acl *acl = NULL, *acl_res;
-	struct inode *inode = d_backing_inode(dentry);
-	int rc;
-
-	/*
-	 * An earlier comment here mentioned that the idmappings for
-	 * ACL_{GROUP,USER} don't matter since EVM is only interested in the
-	 * mode stored as part of POSIX ACLs. Nonetheless, if it must translate
-	 * from the uapi POSIX ACL representation to the VFS internal POSIX ACL
-	 * representation it should do so correctly. There's no guarantee that
-	 * we won't change POSIX ACLs in a way that ACL_{GROUP,USER} matters
-	 * for the mode at some point and it's difficult to keep track of all
-	 * the LSM and integrity modules and what they do to POSIX ACLs.
-	 *
-	 * Frankly, EVM shouldn't try to interpret the uapi struct for POSIX
-	 * ACLs it received. It requires knowledge that only the VFS is
-	 * guaranteed to have.
-	 */
-	acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
-				  xattr_value, xattr_value_len);
-	if (IS_ERR_OR_NULL(acl))
-		return 1;
-
-	acl_res = acl;
-	/*
-	 * Passing mnt_userns is necessary to correctly determine the GID in
-	 * an idmapped mount, as the GID is used to clear the setgid bit in
-	 * the inode mode.
-	 */
-	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
-
-	posix_acl_release(acl);
-
-	if (rc)
-		return 1;
-
-	if (inode->i_mode != mode)
-		return 1;
-#endif
-	return 0;
-}
-
 /*
  * evm_xattr_change - check if passed xattr value differs from current value
  * @mnt_userns: user namespace of the idmapped mount
@@ -513,10 +453,6 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
 	char *xattr_data = NULL;
 	int rc = 0;
 
-	if (posix_xattr_acl(xattr_name))
-		return evm_xattr_acl_change(mnt_userns, dentry, xattr_name,
-					    xattr_value, xattr_value_len);
-
 	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
 				0, GFP_NOFS);
 	if (rc < 0)
-- 
2.34.1

