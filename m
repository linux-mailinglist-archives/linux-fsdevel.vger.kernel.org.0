Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980A5EF8DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiI2PdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiI2Pby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA02D7C77B;
        Thu, 29 Sep 2022 08:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9379DB824F4;
        Thu, 29 Sep 2022 15:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50419C43470;
        Thu, 29 Sep 2022 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465483;
        bh=kObTk4GZ2hIOw1wANlwibq0F/l0o9D6KwqtMlygLMHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZVXHRR/nyuoDEEpn0YSW2vaAfTX/XUGpN4TP9EELwRwH0V1SFNNlY3TAJbwwm6xb
         wkfXd0/wVsdHchqwwkCqFnPqcOm/mbY8zNszkt1ACxz8DiurNOGhFdbX8k/jveEk7g
         ozPvM/EPe6I8UQAq28MlcbwSJ8HM7aQ+oX2A6WYEZTjfQb1H/PGiYfcEjJC/j45rdX
         c1buy/VwP5/wtGHG5WjCwxYVOmRxpICpvL11RcWNqByx1bvUBn3y6yA0iLbx5gO/6X
         8fv6Rk1sjK0j0cnuLgAgWpKIjz8mfTG6MUDeiuaRpZ9ZQ6T3EVYWDb6Y9cCAxmXUiA
         n9+bEUBnZD7DA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 11/30] smack: implement get, set and remove acl hook
Date:   Thu, 29 Sep 2022 17:30:21 +0200
Message-Id: <20220929153041.500115-12-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5303; i=brauner@kernel.org; h=from:subject; bh=kObTk4GZ2hIOw1wANlwibq0F/l0o9D6KwqtMlygLMHE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hI+wLTinlKD3vaJMwsXh5XP3ZFh/Tf75ZKu45NZNDdP /uTk3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARO22Gf/qsYkckZ4s8nWLwn+XLUY EeD2/HE5OrXIRuXrz26f2i0iuMDNMmsxrvNmAN3KeyqyJzu+yymt2TnL9+iEvJrl3CODG1mhkA
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

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

So far posix acls were passed as a void blob to the security and
integrity modules. Some of them like evm then proceed to interpret the
void pointer and convert it into the kernel internal struct posix acl
representation to perform their integrity checking magic. This is
obviously pretty problematic as that requires knowledge that only the
vfs is guaranteed to have and has lead to various bugs. Add a proper
security hook for setting posix acls and pass down the posix acls in
their appropriate vfs format instead of hacking it through a void
pointer stored in the uapi format.

I spent considerate time in the security module infrastructure and
audited all codepaths. Smack has no restrictions based on the posix
acl values passed through it. The capability hook doesn't need to be
called either because it only has restrictions on security.* xattrs. So
these all becomes very simple hooks for smack.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Add get, and remove acl hook
    
    /* v4 */
    Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

 security/smack/smack_lsm.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 001831458fa2..8247e8fd43d0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1393,6 +1393,72 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
+/**
+ * smack_inode_set_acl - Smack check for setting posix acls
+ * @mnt_userns: the userns attached to the mnt this request came from
+ * @dentry: the object
+ * @acl_name: name of the posix acl
+ * @kacl: the posix acls
+ *
+ * Returns 0 if access is permitted, an error code otherwise
+ */
+static int smack_inode_set_acl(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, const char *acl_name,
+			       struct posix_acl *kacl)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	return rc;
+}
+
+/**
+ * smack_inode_get_acl - Smack check for getting posix acls
+ * @mnt_userns: the userns attached to the mnt this request came from
+ * @dentry: the object
+ * @acl_name: name of the posix acl
+ *
+ * Returns 0 if access is permitted, an error code otherwise
+ */
+static int smack_inode_get_acl(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, const char *acl_name)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	return rc;
+}
+
+/**
+ * smack_inode_remove_acl - Smack check for getting posix acls
+ * @mnt_userns: the userns attached to the mnt this request came from
+ * @dentry: the object
+ * @acl_name: name of the posix acl
+ *
+ * Returns 0 if access is permitted, an error code otherwise
+ */
+static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
+				  struct dentry *dentry, const char *acl_name)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	return rc;
+}
+
 /**
  * smack_inode_getsecurity - get smack xattrs
  * @mnt_userns: active user namespace
@@ -4772,6 +4838,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
 	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
 	LSM_HOOK_INIT(inode_removexattr, smack_inode_removexattr),
+	LSM_HOOK_INIT(inode_set_acl, smack_inode_set_acl),
+	LSM_HOOK_INIT(inode_get_acl, smack_inode_get_acl),
+	LSM_HOOK_INIT(inode_remove_acl, smack_inode_remove_acl),
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
-- 
2.34.1

