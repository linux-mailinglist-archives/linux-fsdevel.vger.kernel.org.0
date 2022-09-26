Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280595EAAC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiIZPYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiIZPX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977324B;
        Mon, 26 Sep 2022 07:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8117DCE114D;
        Mon, 26 Sep 2022 14:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AAC433D7;
        Mon, 26 Sep 2022 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201368;
        bh=mZiUJrvg8yaqgBdnDKc8+Ezywv02rJLKTDGCaJnn3OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqZtyn/JKkfubM8GJuzxSffRB5aOiFKohVcQSGC2SR8LnaGO6xIxS/fKGvWgrzNW0
         zuANfLYr0H8e3MwqJumW8OQRasTFzPt15cBkMda73e1S3rxByLNV55HcO6VordKJPB
         NBhFwDWdca1yfGK8SdEAzBLvOOXNMzNChOWexBWWel4aqZyPwY13NMzrh3MG6UbHBp
         Q3ii02eu3eayEqZpqoBGWVXGn68ZzKOabEPLBfTn0dYMXOjUpBFiYnRJnh0Cbo719m
         SQF8QHholkqKtn+60zFLWcqbOh3DdI0sPT9nq03ii7dXDB7w3PkbgBf8r82TvhsM0r
         Xh/oEQkkUxDLg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 18/30] evm: simplify evm_xattr_acl_change()
Date:   Mon, 26 Sep 2022 16:08:15 +0200
Message-Id: <20220926140827.142806-19-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4006; i=brauner@kernel.org; h=from:subject; bh=mZiUJrvg8yaqgBdnDKc8+Ezywv02rJLKTDGCaJnn3OU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnI8nD+vU2XRUo206wdMFs3I1JiSnf/iscfV4J7aGWWB 2/x3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkyEyGfzobjYXyCi9vYWG6+6OB/d WfyYf7LtydL75v3vTlrP2JnnMY/ofcW66kysX8nenC9vUsthMi0tvOiBc8KfE4s3/rOxWLs9wA
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

The posix acl api provides a dedicated security and integrity hook for
setting posix acls. This means that

evm_protect_xattr()
-> evm_xattr_change()
   -> evm_xattr_acl_change()

is now only hit during vfs_remove_acl() at which point we are guaranteed
that xattr_value and xattr_value_len are NULL and 0. In this case evm
always used to return 1. Simplify this function to do just that.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 security/integrity/evm/evm_main.c | 62 +++++++------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 15aa5995fff4..1fbe1b8d0364 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -436,62 +436,29 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 
 /*
  * evm_xattr_acl_change - check if passed ACL changes the inode mode
- * @mnt_userns: user namespace of the idmapped mount
- * @dentry: pointer to the affected dentry
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
  *
- * Check if passed ACL changes the inode mode, which is protected by EVM.
+ * This is only hit during xattr removal at which point we always return 1.
+ * Splat a warning in case someone managed to pass data to this function. That
+ * should never happen.
  *
  * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
  */
-static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
-				struct dentry *dentry, const char *xattr_name,
-				const void *xattr_value, size_t xattr_value_len)
+static int evm_xattr_acl_change(const void *xattr_value, size_t xattr_value_len)
 {
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
+	int rc = 0;
 
-	if (inode->i_mode != mode)
-		return 1;
+#ifdef CONFIG_FS_POSIX_ACL
+	WARN_ONCE(xattr_value != NULL,
+		  "Passing xattr value for POSIX ACLs not supported\n");
+	WARN_ONCE(xattr_value_len != 0,
+		  "Passing non-zero length for POSIX ACLs not supported\n");
+	rc = 1;
 #endif
-	return 0;
+
+	return rc;
 }
 
 /*
@@ -514,8 +481,7 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
 	int rc = 0;
 
 	if (posix_xattr_acl(xattr_name))
-		return evm_xattr_acl_change(mnt_userns, dentry, xattr_name,
-					    xattr_value, xattr_value_len);
+		return evm_xattr_acl_change(xattr_value, xattr_value_len);
 
 	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
 				0, GFP_NOFS);
-- 
2.34.1

