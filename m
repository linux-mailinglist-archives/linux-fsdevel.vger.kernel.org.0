Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461BE5EE169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiI1QNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiI1QNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191668683A;
        Wed, 28 Sep 2022 09:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA147B8214D;
        Wed, 28 Sep 2022 16:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00496C433D7;
        Wed, 28 Sep 2022 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381596;
        bh=n55Uy3v4zGJJiKbXY2RW8eOQMf7e2bWtM0CE5ysw6BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPgGeoFt2AZsjM0qb8W4plVawIbkdiMVFRX/SXji47JENYdbepA5+i5vj6U39mk06
         5nW9OycDEva5rNCoHZ5EGtnuo95Aqwc3CTji/9WokQ9927N9NNpRgAw/tppxSH8iAk
         1JszKWq4nnTJWrUM6aPQSKUQBmn0EwE+IC3qkBqTWBb/pyVJAiq3zHKqAUBK+nCs7N
         trZDXvIeefX53Ae/b05iN73qnqUECR2V2CDTxdkDwVEbaeRRzkoWmEh8POHE8yn0xq
         pGYqc6OijtHnnCV/v4DU59iAn+XndKNzAdGi0fplDRPLZ2v7vqNv549gClhXOHQYH1
         Z/nEDrt9EI9Rw==
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
Subject: [PATCH v3 10/29] selinux: implement get, set and remove acl hook
Date:   Wed, 28 Sep 2022 18:08:24 +0200
Message-Id: <20220928160843.382601-11-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=brauner@kernel.org; h=from:subject; bh=n55Uy3v4zGJJiKbXY2RW8eOQMf7e2bWtM0CE5ysw6BM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFFYfvfBMvEWfv1s7NblE8QdrffjDE1IJLb4S2+xkn6e3 PcjtKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEhDMcM/dVE934Z1Dcar7hw8OuUYk2 d5UvOT7vSvos0eM9TatgkvY/ifxG6qkN8Yk+HlsOR5/W9ly7M2e+cL3FCQNlqVsFqKPZARAA==
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
audited all codepaths. SELinux has no restrictions based on the posix
acl values passed through it. The capability hook doesn't need to be
called either because it only has restrictions on security.* xattrs. So
these are all fairly simply hooks for SELinux.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Add get, and remove acl hook

 security/selinux/hooks.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79573504783b..0e3cd67e5e92 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3239,6 +3239,27 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
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
+	const struct cred *cred = current_cred();
+
+	return dentry_has_perm(cred, dentry, FILE__GETATTR);
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
@@ -7063,6 +7084,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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

