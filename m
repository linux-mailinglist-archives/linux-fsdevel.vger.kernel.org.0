Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD935F408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbhDNMjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245007AbhDNMjG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D01960FED;
        Wed, 14 Apr 2021 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403925;
        bh=Q1tgq0bLCW1BwFD0GBk1hkaoX7xvFd/jY5QTGUnA8kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/F64rVzbleGLCiMf6pD1vbcfsUEmIFZdvYsnZlLRX/D0f21O93J69Z1knW5XJi7A
         xK6NUt8xOyTW8puSn4KAOK9XE+bBRHe0MED2vKMkbw0H2AwafWGduo1RIzsceMi1uk
         dvv337WYKO/4rivyB+jsfIAqv5cBBO5scTjln5zSRBHVHkqlWWrQVHtR1K4KmNv1Py
         guxI2CPTf6PzIVsD1Lm5UyRKeRrAF81FQfXoO3yL2tCrqomi6Ml0igKnzeeJjN+gaY
         tPL0hESZycShEOlVz6dSiUYRM+ozkoHQVw50Uo+grFnAJnmKBMKUOy7CBfmt2R6OMh
         Rh/8mGFhcu05w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/7] namespace: move unbindable check out of clone_private_mount()
Date:   Wed, 14 Apr 2021 14:37:47 +0200
Message-Id: <20210414123750.2110159-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=QhpZF+pXGA2C35UZEcASpoPOekySoXvzF+VucE2h6UQ=; m=nUiY/Hyk9O3NEoy5nBMQg8mS6mXzVIt1wOdmvUcTRF8=; p=qKMfjPFs6+zUvX3s+RUCVFdWmJzx6xWhQ/tbOsngNSM=; g=6136b4f118bef21a7753d80f6c1d7b9bfbceb86a
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh3wAKCRCRxhvAZXjcorREAQD9J6K JHiA/HQfrmEEyPA6l+rDET5u0b/PHbnIdB6gYFwEAjdbYoTfRQMkHc57c+Ps4V0mXtYStC3s/ygfS 6zj+ags=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We're about to switch all filesystems that stack on top or otherwise use
a struct path of another filesystem to use clone_private_mount() in the
following commits. Most of these filesystems like ecryptfs and
cachefiles don't need the MS_UNBDINDABLE check that overlayfs currently
wants. So move the check out of clone_private_mount() and into overlayfs
itself.

Note that overlayfs can probably be switched to not rely on the
MS_UNBDINDABLE check too but for now keep it.

[1]: df820f8de4e4 ("ovl: make private mounts longterm")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c       |  3 ---
 fs/overlayfs/super.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7ffefa8b3980..f6efe1272b9d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1976,9 +1976,6 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	struct mount *old_mnt = real_mount(path->mnt);
 	struct mount *new_mnt;
 
-	if (IS_MNT_UNBINDABLE(old_mnt))
-		return ERR_PTR(-EINVAL);
-
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
 	if (IS_ERR(new_mnt))
 		return ERR_CAST(new_mnt);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index fdd72f1a9c5e..c942bb1073f6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include "../pnode.h"
 #include "overlayfs.h"
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -1175,6 +1176,14 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
 	}
 }
 
+static inline struct vfsmount *ovl_clone_private_mount(const struct path *path)
+{
+	if (IS_MNT_UNBINDABLE(real_mount(path->mnt)))
+		return ERR_PTR(-EINVAL);
+
+	return clone_private_mount(path);
+}
+
 static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 			 struct ovl_layer *upper_layer, struct path *upperpath)
 {
@@ -1201,7 +1210,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	if (err)
 		goto out;
 
-	upper_mnt = clone_private_mount(upperpath);
+	upper_mnt = ovl_clone_private_mount(upperpath);
 	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
 		pr_err("failed to clone upperpath\n");
@@ -1700,7 +1709,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			}
 		}
 
-		mnt = clone_private_mount(&stack[i]);
+		mnt = ovl_clone_private_mount(&stack[i]);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");
-- 
2.27.0

