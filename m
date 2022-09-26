Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0583F5EAAA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiIZPYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiIZPXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2188DD8;
        Mon, 26 Sep 2022 07:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76575B80A72;
        Mon, 26 Sep 2022 14:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC556C43141;
        Mon, 26 Sep 2022 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201353;
        bh=nozG0WcEYu9YjxS/9G2XFppJTyXK2JL22UJ4HGPG+rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1FtIZNJFBlz+4L6w68g1ebOzAEeWXzHB9dtDQNRyPXjouNPMJMsM0By/IuW2yBdv
         xWyhe7tSPePVEMG9j0hpldO5Y8kSAQQ5LOcCHwrX7jdvP/texE6Ou5FvY1fIz79mYL
         FGcfXwk6Xh8QcbeB7Jl6JlLAy3F+/iRvC4noP+wNuqPjcTipQFb/ZuzH50l3G/BXMR
         pYd9umL2JsR0QWFGTjKI9lZDcDarFQ+a37Bh6tYnZ2MUTW2KwbfaX0+3Mvzq2lkbyE
         LXz7g6fnvB/r4YaTO8VTwbYeMGc+Kzr8w/fNe24j9AbF/6JSwZ6FnNtsh6N4sFckhb
         tfd6E3sB8ua5A==
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
Subject: [PATCH v2 11/30] selinux: implement set acl hook
Date:   Mon, 26 Sep 2022 16:08:08 +0200
Message-Id: <20220926140827.142806-12-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=brauner@kernel.org; h=from:subject; bh=nozG0WcEYu9YjxS/9G2XFppJTyXK2JL22UJ4HGPG+rA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbrJPyeo7wFljsE9o1n6z8ISjmTnPfUO5zwe8WLuwS7vh lnZtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQeL2Bk2F9QdMTn6Ym/uRqBL9z9TT edY3ycrT1VYGuQlO77Al3pcwz/3URt/HfviNfQv3bv6K2ahSGT5kdfNjVY6fI4V5WrZvYffgA=
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
this all becomes a very simple hook for SELinux.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 security/selinux/hooks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79573504783b..bbc0ce3bde35 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3239,6 +3239,13 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
 			    &ad);
 }
 
+static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
 static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					const void *value, size_t size,
 					int flags)
@@ -7063,6 +7070,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-- 
2.34.1

