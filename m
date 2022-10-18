Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE41602AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJRMAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiJRL7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9BBD07C;
        Tue, 18 Oct 2022 04:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD4016153F;
        Tue, 18 Oct 2022 11:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D06C433C1;
        Tue, 18 Oct 2022 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094291;
        bh=rUM6WxxL/2PcHSmk6ehr+wODBu2opvgdc03mmqvLOak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyGpGTfwn3WXkqkF589GMF0vbkIRno1qzyCt5mKGXOZcFRIGeIlLqrjvVbjFPTqPb
         gbk3treaHtjDKDR17nt93XFTfhnM/ARHT2Djrbcj7ixCFacO7uFQ7EBJqbPMa6souW
         kgpdJsAdvDIvg7Ppyxsnk6je5KsMBHHxHu7AsuunAMSG+kY8Citzuk3ohB83vdre5I
         mbi7O9vnmTyLm6nflWkpbADWMp5Q7pqLWl0sKHmepOkxmP2CAQmYoz9LpzgIrEVkOk
         Nhv61DNEYRRD1KMbpJf0zi7nD6A+/IWiMD0eTdEIuA2CXjwsyziHSZhzFGyNUiY74X
         KWuktUv2CY2uQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 20/30] ecryptfs: implement set acl method
Date:   Tue, 18 Oct 2022 13:56:50 +0200
Message-Id: <20221018115700.166010-21-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=brauner@kernel.org; h=from:subject; bh=rUM6WxxL/2PcHSmk6ehr+wODBu2opvgdc03mmqvLOak=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdFwCb3aGsY5y03mdd818wlLPkqeCpu7ZqLSJP6tZx+6 Xtz2oaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiu+QZGfYKRW15KvF4K+vFlEU3n3 3Q5nMQEPx9gWvyip2M705uuLGc4Z/plR1SrSIvPqbwLI2ytvA6eKmSYUbmt5gjD4QXn8mx/MUMAA==
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
    
    /* v5 */
    unchanged

 fs/ecryptfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index b4be9f6bafd2..5802b93b2cda 100644
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

