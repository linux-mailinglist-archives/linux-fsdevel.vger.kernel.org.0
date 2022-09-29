Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF85EF8F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiI2PeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiI2Pca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8016177360;
        Thu, 29 Sep 2022 08:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CD3B824F8;
        Thu, 29 Sep 2022 15:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC18EC43144;
        Thu, 29 Sep 2022 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465505;
        bh=Epc5bEYT4kufjLMVjC9LV24arZY8PufY0CiTw+GKu24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbWxILX9GvneJJvw7a2NgRPVJBWmlVB5PgrwZfpFPNJb4SBz17mGHKC2FzUmRECuL
         uIdLdJMWTHI2oK7NoGAqjZFUt/IP28kuTvxqDtfqKjlssXDkwbLPNksMBoDoFTRVs6
         f1eqFuqsKxceMgcprfc6tAodwzZBDV1tgPOtPCXfQHWjx/EV8mSn2QFQBuUKou0SlK
         7SAblcCH3rtS0S7UOSPRmXcguXdeULgyXhvj38KoxbUrnhn3iLj2DgAoTs/4eBW52W
         HeRvQAzeXDIH5JFA7lmr1o0DTckgyWKNVlcf6iKdREoMrRTfA9B1NRvUBhy1YdSbvm
         bzLJDgkxEK//w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 20/30] ecryptfs: implement set acl method
Date:   Thu, 29 Sep 2022 17:30:30 +0200
Message-Id: <20220929153041.500115-21-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=brauner@kernel.org; h=from:subject; bh=Epc5bEYT4kufjLMVjC9LV24arZY8PufY0CiTw+GKu24=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hL9qMegLXN4Y+A/3hnX5eIddR2PCTIdzpj3U7EqTCfl Fb9cRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERm1jMyzI07u+nn45JKpzNS77l1Fz o3Hvjbc6X6j4QMm8rr+d2fHRgZfpu1PLCY+lNhae8Gh/eRSyL/+htHv025n3z7dKDAqcpWPgA=
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

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

So far ecryptfs didn't implement get and set acl inode operations
because it wanted easy access to the dentry. Now that we extended the
set acl inode operation to take a dentry argument and added a new get
acl inode operation that takes a dentry argument we can let ecryptfs
implement get and set acl inode operations.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged

 fs/ecryptfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 740312986388..c3d1ae688a19 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1129,6 +1129,21 @@ static struct posix_acl *ecryptfs_get_acl(struct user_namespace *mnt_userns,
 			   posix_acl_xattr_name(type));
 }
 
+static int ecryptfs_set_acl(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct posix_acl *acl,
+			    int type)
+{
+	int rc;
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct inode *lower_inode = d_inode(lower_dentry);
+
+	rc = vfs_set_acl(&init_user_ns, lower_dentry,
+			 posix_acl_xattr_name(type), acl);
+	if (!rc)
+		fsstack_copy_attr_all(d_inode(dentry), lower_inode);
+	return rc;
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1153,6 +1168,7 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
 	.get_acl = ecryptfs_get_acl,
+	.set_acl = ecryptfs_set_acl,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1163,6 +1179,7 @@ const struct inode_operations ecryptfs_main_iops = {
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
 	.get_acl = ecryptfs_get_acl,
+	.set_acl = ecryptfs_set_acl,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.34.1

