Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53441595A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgBKRAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:00:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53432 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgBKQ7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:37 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsX-00014T-Dz; Tue, 11 Feb 2020 16:59:17 +0000
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
Subject: [PATCH 12/24] posix_acl: handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:41 +0100
Message-Id: <20200211165753.356508-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch posix_acls() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Afaict, all filesystems that share a superblock in all user namespaces
currently do not support acls so this change should be safe to do
unconditionally.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/posix_acl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 249672bf54fe..763bba24f380 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -22,6 +22,7 @@
 #include <linux/xattr.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/fsuidgid.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -692,12 +693,12 @@ static void posix_acl_fix_xattr_userns(
 	for (end = entry + count; entry != end; entry++) {
 		switch(le16_to_cpu(entry->e_tag)) {
 		case ACL_USER:
-			uid = make_kuid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kuid(to, uid));
+			uid = make_kfsuid(from, le32_to_cpu(entry->e_id));
+			entry->e_id = cpu_to_le32(from_kfsuid(to, uid));
 			break;
 		case ACL_GROUP:
-			gid = make_kgid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kgid(to, gid));
+			gid = make_kfsgid(from, le32_to_cpu(entry->e_id));
+			entry->e_id = cpu_to_le32(from_kfsgid(to, gid));
 			break;
 		default:
 			break;
@@ -746,12 +747,12 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 		return ERR_PTR(-EINVAL);
 	if (count == 0)
 		return NULL;
-	
+
 	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	acl_e = acl->a_entries;
-	
+
 	for (end = entry + count; entry != end; acl_e++, entry++) {
 		acl_e->e_tag  = le16_to_cpu(entry->e_tag);
 		acl_e->e_perm = le16_to_cpu(entry->e_perm);
@@ -765,14 +766,14 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 
 			case ACL_USER:
 				acl_e->e_uid =
-					make_kuid(user_ns,
+					make_kfsuid(user_ns,
 						  le32_to_cpu(entry->e_id));
 				if (!uid_valid(acl_e->e_uid))
 					goto fail;
 				break;
 			case ACL_GROUP:
 				acl_e->e_gid =
-					make_kgid(user_ns,
+					make_kfsgid(user_ns,
 						  le32_to_cpu(entry->e_id));
 				if (!gid_valid(acl_e->e_gid))
 					goto fail;
@@ -817,11 +818,11 @@ posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
 		switch(acl_e->e_tag) {
 		case ACL_USER:
 			ext_entry->e_id =
-				cpu_to_le32(from_kuid(user_ns, acl_e->e_uid));
+				cpu_to_le32(from_kfsuid(user_ns, acl_e->e_uid));
 			break;
 		case ACL_GROUP:
 			ext_entry->e_id =
-				cpu_to_le32(from_kgid(user_ns, acl_e->e_gid));
+				cpu_to_le32(from_kfsgid(user_ns, acl_e->e_gid));
 			break;
 		default:
 			ext_entry->e_id = cpu_to_le32(ACL_UNDEFINED_ID);
-- 
2.25.0

