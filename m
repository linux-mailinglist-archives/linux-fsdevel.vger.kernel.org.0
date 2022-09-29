Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519A5EF8C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiI2Pb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiI2PbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E3263F1E;
        Thu, 29 Sep 2022 08:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08746124B;
        Thu, 29 Sep 2022 15:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBE6C433D7;
        Thu, 29 Sep 2022 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465461;
        bh=1ND8XADvzSdUjwRZnawE9d7VxNpgI8Dunpn5MFnnvQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZ9z5FxUJF/8JsAgge993y5h/4xI2o2+BknBgrOZgRc2heo8i1vlH4cqwTHMdYt0y
         DQfJbUbABgOdfYYCAhujczgU0fQ7dWlHS2KohzDTRiTmsUgX/iLSr4QOGlIJS5rTkA
         9mRlmwzAsZwGwX5ubhjAHd01GtAr1Vku3aZGii3MPtTqjGBkfV7SOLEK23/G+Jf72c
         jeuBCJzSauUfyKksp6tjRrT9E/TkCeTlaPXPjH69zyUdOTtPR16/xaleFIaTR6UTx3
         akCAFT0CM8+VS9mHWNTrhpsSewEUbU2RsUuEPy0GXt6krSDAmtUwSy4zJp989R2uv6
         5+ng2+VIbU4Eg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 04/30] fs: add new get acl method
Date:   Thu, 29 Sep 2022 17:30:14 +0200
Message-Id: <20220929153041.500115-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4029; i=brauner@kernel.org; h=from:subject; bh=1ND8XADvzSdUjwRZnawE9d7VxNpgI8Dunpn5MFnnvQc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hLiml72z2Ayc0pK+oZdJstSZ8XVx5p8aZpUaWI7J6p4 VsuqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkI72D4K7dC3eSpCpfJiezv/0Ju7S 1earlBJEVE5/arOt71q2Nj5zEyHJR8mL483GMH6+sE/c1vIsxUDXVudhZbVXyebKDN0GrNCQA=
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
    
    /* v4 */
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

