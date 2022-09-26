Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22B5EAAC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiIZPYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiIZPX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977121AA;
        Mon, 26 Sep 2022 07:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF9E60DD7;
        Mon, 26 Sep 2022 14:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268AAC433D7;
        Mon, 26 Sep 2022 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201374;
        bh=zx/WipUuAXwkCDciCFX/tqx0x7LwTgaqCoOVt3/0/4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tl0H8E5hBKeJrA6NOTcMfaWu29I9OqtBkd2j61kpSpf5HVafs/HU8DaLWZSlUDBbF
         vPEzVAit/X5e9X91AsZkz+DF/sD5UV0Ah39SPaYf95B7kBUY2Ow/WIGFYUP0g0IKFH
         +xh9nmOEiZqNn8g+/3G+22fIX1jjlZY8bZcRrUpPy8jGhX5LsutE9oQPhniAki6fEy
         /vIGGhQAtcbA0PqiFKEYvzFQAc8d9OgtSOUPD6jegMklVvmueGErhUJp6OahvRMrER
         jVJF0pPk5j97HgKiroDPhPb5r/wIguQbzCXjx8OrRWGlMZyniddp+Fe2Xm/EUweivO
         LHBfRV68AGhtw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 20/30] ecryptfs: implement get acl method
Date:   Mon, 26 Sep 2022 16:08:17 +0200
Message-Id: <20220926140827.142806-21-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=brauner@kernel.org; h=from:subject; bh=zx/WipUuAXwkCDciCFX/tqx0x7LwTgaqCoOVt3/0/4g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnJ83TjH8V+mUpVrZfk3eXdDz8Nrb7ievbJWfUfXutlJ LyP/dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEyZPhf4L7rCdKrHX7Jpgt1//3c3 mPWoPM1lWv57K1RG5O9Enz6WNk6C44f/+D2pUvRser/pzz3qrleuu0zZNPeh9fJDG927+UlRkA
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

 fs/ecryptfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..740312986388 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -18,6 +18,8 @@
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include <linux/fileattr.h>
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
@@ -1120,6 +1122,13 @@ static int ecryptfs_fileattr_set(struct user_namespace *mnt_userns,
 	return rc;
 }
 
+static struct posix_acl *ecryptfs_get_acl(struct user_namespace *mnt_userns,
+					  struct dentry *dentry, int type)
+{
+	return vfs_get_acl(mnt_userns, ecryptfs_dentry_to_lower(dentry),
+			   posix_acl_xattr_name(type));
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1143,6 +1152,7 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.listxattr = ecryptfs_listxattr,
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
+	.get_acl = ecryptfs_get_acl,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1152,6 +1162,7 @@ const struct inode_operations ecryptfs_main_iops = {
 	.listxattr = ecryptfs_listxattr,
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
+	.get_acl = ecryptfs_get_acl,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.34.1

