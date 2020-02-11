Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6968C1595AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgBKQ7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 11:59:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53401 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBKQ7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:35 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsT-00014T-3L; Tue, 11 Feb 2020 16:59:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 07/24] namei: may_{o_}create(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:36 +0100
Message-Id: <20200211165753.356508-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch may_{o_}create() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4fb61e0754ed..c85c65adfa9d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/fsuidgid.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -2771,6 +2772,20 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	return 0;
 }
 
+static bool fsid_has_mapping(struct user_namespace *ns, struct super_block *sb)
+{
+	if (is_userns_visible(sb->s_iflags)) {
+		if (!kuid_has_mapping(ns, current_fsuid()) ||
+		    !kgid_has_mapping(ns, current_fsgid()))
+			return false;
+	} else if (!kfsuid_has_mapping(ns, current_fsuid()) ||
+		   !kfsgid_has_mapping(ns, current_fsgid())) {
+		return false;
+	}
+
+	return true;
+}
+
 /*	Check whether we can create an object with dentry child in directory
  *  dir.
  *  1. We can't do it if child already exists (open has special treatment for
@@ -2789,8 +2804,7 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
 	s_user_ns = dir->i_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!fsid_has_mapping(s_user_ns, dir->i_sb))
 		return -EOVERFLOW;
 	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
 }
@@ -2972,8 +2986,7 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 		return error;
 
 	s_user_ns = dir->dentry->d_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!fsid_has_mapping(s_user_ns, dir->dentry->d_sb))
 		return -EOVERFLOW;
 
 	error = inode_permission(dir->dentry->d_inode, MAY_WRITE | MAY_EXEC);
-- 
2.25.0

