Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F965EE18A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiI1QQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiI1QOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B1DF393;
        Wed, 28 Sep 2022 09:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D264561ED7;
        Wed, 28 Sep 2022 16:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352BCC433D7;
        Wed, 28 Sep 2022 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381631;
        bh=tSWSc0RzHXYJdQPae3JpE6xvY1f+QZmrBPNCIoz96UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbf98rHwWzLZgiVzkAExTN+sch+GFxxoomo1Z7WSTfWt5Q6leEpWQvei1Msl2H4Cz
         jsWAiM47OJTVMAp6/UTSlElDbvlB6NSFGihtbFOEZw9eBm2P9wa5u80hDPTZfeWp70
         2KNP/A7g194DiJ25PiNCtm7nh9rXVglImNBoSRiBx4MzeSJnIDnsd5qWx0p0C/ZnI1
         VRekXv20WfqNKxDGAzcqsOU8n8fDqbsJg5Ln+Gf7cTEOIgAjeg0W2N9aeN0NgETb+D
         MV06/OYHNLKj78Wz0kBn5xczCDwXoE+H/XVpKdlzXJH2+kMyqa7woeA+X8X9iuf1PY
         018SWZ6BN3/dg==
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
Subject: [PATCH v3 24/29] evm: remove evm_xattr_acl_change()
Date:   Wed, 28 Sep 2022 18:08:38 +0200
Message-Id: <20220928160843.382601-25-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=brauner@kernel.org; h=from:subject; bh=tSWSc0RzHXYJdQPae3JpE6xvY1f+QZmrBPNCIoz96UI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNat4Gm6wWOsoKh6oo5rh5vDh2leS72PR7o1h2t+OZtQ mvemo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJnLjEynFm92G1qN6fo0gxbhsNxmR 1s339N5HpdfLUnc3XrZq0KDUaG+bzvlxz54DR31SHvdS+U+SdP2mFgzZbQ/CjvaOLF0jv/mAA=
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

