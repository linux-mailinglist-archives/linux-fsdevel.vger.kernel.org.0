Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA557B683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiGTMds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiGTMdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:33:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3370D4D807
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 05:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC97EB81F2D
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 12:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C0C3411E;
        Wed, 20 Jul 2022 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658320386;
        bh=Z4c82suRVc4GtGCbhpnDlMD+hZbL411UX1V6St46LPw=;
        h=From:To:Cc:Subject:Date:From;
        b=SQhwbOIQP1Xw/KysKVUDtDqMwFP7yFLU76xvoCHpYoajLs3HlZqLXXbp7vstIn/uj
         NMVavLhVIyz5tYT3rUt3BF/mgF4R0M10as0Q3DPZbVroc2lZbcf5BrrvcwP/IE/P6S
         eg2UR2EjpACddywZnU+UHHSMDzVPMDeo8QfJBwa3+L6N9yGg9NDe5NIs8uDsVTuNXi
         bFXboxU2TForJRt4etKt139zv9cIKIZKKsNS26YTuweIdB5lPoFfFdpQDiTNg5JZfe
         M4RmIXv9zjjvMGZWts7ryvao/CHbR6OL0sRAgYzK32MdhH2D2OOuJTZ7fUwjG/wmT+
         UVA+aKWOf9lKQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] ntfs: fix acl handling
Date:   Wed, 20 Jul 2022 14:32:52 +0200
Message-Id: <20220720123252.686466-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; h=from:subject; bh=Z4c82suRVc4GtGCbhpnDlMD+hZbL411UX1V6St46LPw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRd//qhSm/PPD/lKZJ1HxKFF2z7+FIqecPbtaeul08ucN1y qyZatKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidYUM/yzkKp2n7S0v7Q2a+GTyG6 +sH8umZcmU/fW6rDNfSWfmpJOMDKeqzH26Z7AycSc3X9vPpvkx4YL6t1vydTazD83Ktl8+kQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While looking at our current POSIX ACL handling in the context of some
overlayfs work I went through a range of other filesystems checking how they
handle them currently and encountered ntfs3.

The posic_acl_{from,to}_xattr() helpers always need to operate on the
filesystem idmapping. Since ntfs3 can only be mounted in the initial user
namespace the relevant idmapping is init_user_ns.

The posix_acl_{from,to}_xattr() helpers are concerned with translating between
the kernel internal struct posix_acl{_entry} and the uapi struct
posix_acl_xattr_{header,entry} and the kernel internal data structure is cached
filesystem wide.

Additional idmappings such as the caller's idmapping or the mount's idmapping
are handled higher up in the VFS. Individual filesystems usually do not need to
concern themselves with these.

The posix_acl_valid() helper is concerned with checking whether the values in
the kernel internal struct posix_acl can be represented in the filesystem's
idmapping. IOW, if they can be written to disk. So this helper too needs to
take the filesystem's idmapping.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ntfs3/xattr.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 5e0e0280e70d..3e9118705174 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -478,8 +478,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 }
 
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
-					 struct inode *inode, int type,
+static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
 					 int locked)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
@@ -514,7 +513,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 
 	/* Translate extended attribute to acl. */
 	if (err >= 0) {
-		acl = posix_acl_from_xattr(mnt_userns, buf, err);
+		acl = posix_acl_from_xattr(&init_user_ns, buf, err);
 	} else if (err == -ENODATA) {
 		acl = NULL;
 	} else {
@@ -537,8 +536,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
 	if (rcu)
 		return ERR_PTR(-ECHILD);
 
-	/* TODO: init_user_ns? */
-	return ntfs_get_acl_ex(&init_user_ns, inode, type, 0);
+	return ntfs_get_acl_ex(inode, type, 0);
 }
 
 static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
@@ -595,7 +593,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 		value = kmalloc(size, GFP_NOFS);
 		if (!value)
 			return -ENOMEM;
-		err = posix_acl_to_xattr(mnt_userns, acl, value, size);
+		err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
 		if (err < 0)
 			goto out;
 		flags = 0;
@@ -641,7 +639,7 @@ static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
 	if (!acl)
 		return -ENODATA;
 
-	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
+	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
 	posix_acl_release(acl);
 
 	return err;
@@ -665,12 +663,12 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
 	if (!value) {
 		acl = NULL;
 	} else {
-		acl = posix_acl_from_xattr(mnt_userns, value, size);
+		acl = posix_acl_from_xattr(&init_user_ns, value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 
 		if (acl) {
-			err = posix_acl_valid(mnt_userns, acl);
+			err = posix_acl_valid(&init_user_ns, acl);
 			if (err)
 				goto release_and_out;
 		}

base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
-- 
2.34.1

