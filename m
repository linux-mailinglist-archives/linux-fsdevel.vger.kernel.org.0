Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D95EE14D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiI1QNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiI1QNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEE8A7F5;
        Wed, 28 Sep 2022 09:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFBA61F2E;
        Wed, 28 Sep 2022 16:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037D6C433C1;
        Wed, 28 Sep 2022 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381578;
        bh=UwUQk1b1nvPapXx6ngWz5NhmJF3I+bke2TJtDoi8e9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUtTJEW+f4TnAzWMChpNzhNF3aB2k0oxYFSZRd13G9AAF6KFtZZDdi+H5WcJRvq0h
         I2onXfv/Yk15/l5OCzDTEGYxAtZKJ5JR7Fem7afBmEB3wADTkkJWdpvH4lPc09DQi4
         ccGc4B7hn+3PeDLNW3M079ryCyLDKbXfAk9fWvUKo3y4pGg3YszUaU5cRhmialxN1o
         DAIv6wsTf+HeVdDWMacHMU4hVpC5yxxqKVzYs0fMHGSI1MHvz6Jb5p+Wl57iatBiCg
         HyNkqZ2yTvh+GuEV0TkY2Bz7a3WxRshom7K3gnfGR/bzDkQ8dz8I0nhgjXnmelTDbt
         z/gDzlyjXSO8A==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 04/29] fs: add new get acl method
Date:   Wed, 28 Sep 2022 18:08:18 +0200
Message-Id: <20220928160843.382601-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; i=brauner@kernel.org; h=from:subject; bh=UwUQk1b1nvPapXx6ngWz5NhmJF3I+bke2TJtDoi8e9A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFFa1KXrWFUY7Nyn6hF7hlXB/fca2qrlNsPzKzjdir5lb shQ7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJiKzkJHholb4lvMTZ8eUs5c9e1SXJB nTx5x0SdteeUZt42brT2fXMDJ8a22J3tb9wm+f8MsTTcvF643j3olvP8C3YD5DU0ZF1lEOAA==
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

Since some filesystem rely on the dentry being available to them when
setting posix acls (e.g., 9p and cifs) they cannot rely on the old get
acl inode operation to retrieve posix acl and need to implement their
own custom handlers because of that.

In a previous patch we renamed the old get acl inode operation to
->get_inode_acl(). We decided to rename it and implement a new one since
->get_inode_acl() is called generic_permission() and inode_permission()
both of which can be called during an filesystem's ->permission()
handler. So simply passing a dentry argument to ->get_acl() would have
amounted to also having to pass a dentry argument to ->permission(). We
avoided that change.

This adds a new ->get_acl() inode operations which takes a dentry
argument which filesystems such as 9p, cifs, and overlayfs can implement
to get posix acls.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged

 Documentation/filesystems/locking.rst | 2 ++
 Documentation/filesystems/vfs.rst     | 1 +
 include/linux/fs.h                    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 1cd2930e54ee..4a0fcaeec58c 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -83,6 +83,7 @@ prototypes::
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
 
 locking rules:
 	all may block
@@ -104,6 +105,7 @@ get_link:	no
 setattr:	exclusive
 permission:	no (may not block if called in rcu-walk mode)
 get_inode_acl:	no
+get_acl:	no
 getattr:	no
 listxattr:	no
 fiemap:		no
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4fc6f1e23012..344f5f421c64 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -440,6 +440,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
+		struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
 	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
 		int (*fileattr_set)(struct user_namespace *mnt_userns,
 				    struct dentry *dentry, struct fileattr *fa);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11cddd040578..badff81b9dde 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2168,6 +2168,8 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct user_namespace *, struct inode *,
 			struct dentry *, umode_t);
+	struct posix_acl *(*get_acl)(struct user_namespace *, struct dentry *,
+				     int);
 	int (*set_acl)(struct user_namespace *, struct dentry *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
-- 
2.34.1

