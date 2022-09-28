Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F535EE17C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiI1QPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiI1QNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB3DCEB2;
        Wed, 28 Sep 2022 09:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3A9ECE1F1F;
        Wed, 28 Sep 2022 16:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C3BC433D6;
        Wed, 28 Sep 2022 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381618;
        bh=ZJQaZ9+enkXhDWiALhTU5vozOEZKswDtKmVsLbfd05I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjhE+g88eES0HD5iZkR4/9vcHzO0vxTikZxiooNIlBcMWjCZ1aSEfLM6A3lDR1zdK
         UG4UVVsphQBaSsbbRlv7OSOwPzBUYqYXvUUxcuZ0JRA0MiNBnhBUWg8CWUbWr+9qEA
         j3RF14dw9TKEPXL3ruOcmgzvIjM4RTZ66+gUMVAmrsvF7eVwv/ZYCvZbceO0OXsNUk
         IePvpXrIhNhDYJxGTFg2sAO+TxsBsx01LwXIjiqyzEgmf3m6CJPAQFmEZX1pPOGae6
         mScQN6504ZMbTPVLVO6Mz9FXoEqvGuAOaPO7FsVw1DiZH8uaYUQ807TYxYLu5zsGEA
         kgWHSht6i6TRg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 19/29] ecryptfs: implement set acl method
Date:   Wed, 28 Sep 2022 18:08:33 +0200
Message-Id: <20220928160843.382601-20-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=brauner@kernel.org; h=from:subject; bh=ZJQaZ9+enkXhDWiALhTU5vozOEZKswDtKmVsLbfd05I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNbuezDluW/wxfrE/SYy72UKorVYvu29FfLI/IdEWIlI acenjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMD2H4K2tzbKrrqlJew2uBh9jfRb N/4FUvcOYxe8YrMWGClNaszYwMv1gm/d57/uTxreZX7b8tMVXqCNl78v2psz2rjdhrVCYIsQAA
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

