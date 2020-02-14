Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7515F5F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbgBNSlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:41:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbgBNSlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:41:49 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqg-0000uO-Qn; Fri, 14 Feb 2020 18:37:58 +0000
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
Subject: [PATCH v2 20/28] open: handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:46 +0100
Message-Id: <20200214183554.1133805-21-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let chown_common() lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.
do_faccessat() just needs to translate from real ids into fsids.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - handle faccessat() too
---
 fs/open.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..4e092845728f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -32,6 +32,7 @@
 #include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <linux/fsuidgid.h>
 
 #include "internal.h"
 
@@ -361,8 +362,10 @@ long do_faccessat(int dfd, const char __user *filename, int mode)
 	if (!override_cred)
 		return -ENOMEM;
 
-	override_cred->fsuid = override_cred->uid;
-	override_cred->fsgid = override_cred->gid;
+	override_cred->kfsuid = override_cred->uid;
+	override_cred->kfsgid = override_cred->gid;
+	override_cred->fsuid = kuid_to_kfsuid(override_cred->user_ns, override_cred->uid);
+	override_cred->fsgid = kgid_to_kfsgid(override_cred->user_ns, override_cred->gid);
 
 	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
 		/* Clear the capabilities if we switch to a non-root user */
@@ -626,8 +629,13 @@ static int chown_common(const struct path *path, uid_t user, gid_t group)
 	kuid_t uid;
 	kgid_t gid;
 
-	uid = make_kuid(current_user_ns(), user);
-	gid = make_kgid(current_user_ns(), group);
+	if (is_userns_visible(inode->i_sb->s_iflags)) {
+		uid = make_kuid(current_user_ns(), user);
+		gid = make_kgid(current_user_ns(), group);
+	} else {
+		uid = make_kfsuid(current_user_ns(), user);
+		gid = make_kfsgid(current_user_ns(), group);
+	}
 
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
-- 
2.25.0

