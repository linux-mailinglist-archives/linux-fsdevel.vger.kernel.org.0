Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54D15F5E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgBNSkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:40:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgBNSkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:40:45 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqj-0000uO-8o; Fri, 14 Feb 2020 18:38:01 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 22/28] attr: notify_change(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:48 +0100
Message-Id: <20200214183554.1133805-23-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch notify_change() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/attr.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..b3fe9d9582d2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,6 +17,8 @@
 #include <linux/security.h>
 #include <linux/evm.h>
 #include <linux/ima.h>
+#include <linux/fsuidgid.h>
+#include <linux/fs.h>
 
 static bool chown_ok(const struct inode *inode, kuid_t uid)
 {
@@ -310,12 +312,21 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	 * Verify that uid/gid changes are valid in the target
 	 * namespace of the superblock.
 	 */
-	if (ia_valid & ATTR_UID &&
-	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
-		return -EOVERFLOW;
-	if (ia_valid & ATTR_GID &&
-	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
-		return -EOVERFLOW;
+	if (is_userns_visible(inode->i_sb->s_iflags)) {
+		if (ia_valid & ATTR_UID &&
+		    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+			return -EOVERFLOW;
+		if (ia_valid & ATTR_GID &&
+		    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+			return -EOVERFLOW;
+	} else {
+		if (ia_valid & ATTR_UID &&
+		    !kfsuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+			return -EOVERFLOW;
+		if (ia_valid & ATTR_GID &&
+		    !kfsgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+			return -EOVERFLOW;
+	}
 
 	/* Don't allow modifications of files with invalid uids or
 	 * gids unless those uids & gids are being made valid.
-- 
2.25.0

