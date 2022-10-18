Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0D602AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJRL6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJRL5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F7BCB82;
        Tue, 18 Oct 2022 04:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7286153E;
        Tue, 18 Oct 2022 11:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EC7C433C1;
        Tue, 18 Oct 2022 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094265;
        bh=fSjrzMyq+bpcifIr5JOm4lI4KXzBA9L1pFlvXfjZSmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UznQOqEcD8kIVpaiUl17ewp+RBLMClDNxkC1kDImHCLkRUi+WmovI4wiFSznjngmH
         QE+sMtU5A3+5A1bYMgFCu0ghXCyi3nPEWjKiXlRBnomR9VeKkZvt/8mFZL9Fsp7kdT
         sKYTGTQ/LCD3JeTf6yJAqT0zMoMhDz3HqqdB5z3uYU0P1vsYEFhk2yPkQhJ8YBXS03
         3GHtngY7sH1AFl3S1ytDGNUMksfmYoQwzWzhbtfF6x3aWDhKkY9K3IM+1L8DpVHn1n
         2NE2XPH3XDjk+2y6kGo77Itf8VNzUlqbOLbiqhho16B+Xk6TWuq0mShv1mdU/xS31T
         mvydEJToXo3Ew==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 10/30] selinux: implement get, set and remove acl hook
Date:   Tue, 18 Oct 2022 13:56:40 +0200
Message-Id: <20221018115700.166010-11-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927; i=brauner@kernel.org; h=from:subject; bh=fSjrzMyq+bpcifIr5JOm4lI4KXzBA9L1pFlvXfjZSmQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVHjeGGv+JeDc+5BP8ufs5at+eR5q/p14MGDf/y0Yjn2 X8jW6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIq+cM/7QYgpnOHhBpm3XFy3bf11 Lmtan3HWcfnvBo3jLRstT90bsY/tlebO5uN166/HvUqRlGMcmLE+tWbku/uPX6J1cHAe7rQlwA
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
audited all codepaths. SELinux has no restrictions based on the posix
acl values passed through it. The capability hook doesn't need to be
called either because it only has restrictions on security.* xattrs. So
these are all fairly simply hooks for SELinux.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Add get, and remove acl hook
    
    /* v4 */
    unchanged
    
    /* v5 */
    Acked-by: Paul Moore <paul@paul-moore.com>
    
    Paul Moore <paul@paul-moore.com>:
    - Use current_cred() directly in dentry_has_perm() call in
      selinux_inode_get_acl().

 security/selinux/hooks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f553c370397e..7c5c8d17695c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3240,6 +3240,25 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
 			    &ad);
 }
 
+static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_get_acl(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *acl_name)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
+static int selinux_inode_remove_acl(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *acl_name)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
 static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					const void *value, size_t size,
 					int flags)
@@ -7088,6 +7107,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
+	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
+	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-- 
2.34.1

