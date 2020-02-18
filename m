Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2C16285F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBROgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:36:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53047 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgBROfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:35:40 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43y2-0000fF-9Z; Tue, 18 Feb 2020 14:35:18 +0000
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
Subject: [PATCH v3 14/25] open: handle fsid mappings
Date:   Tue, 18 Feb 2020 15:34:00 +0100
Message-Id: <20200218143411.2389182-15-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
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
will retain their old semantics even with the introduction of fsid mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - handle faccessat() too

/* v3 */
unchanged
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

