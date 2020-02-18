Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BB1628AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgBROif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:38:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53250 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgBROif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:38:35 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43y8-0000fF-OS; Tue, 18 Feb 2020 14:35:24 +0000
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
Subject: [PATCH v3 20/25] exec: bprm_fill_uid(): handle fsid mappings
Date:   Tue, 18 Feb 2020 15:34:06 +0100
Message-Id: <20200218143411.2389182-21-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure that during suid/sgid binary execution we lookup the fsids in the
fsid mappings. If the kernel is compiled without fsid mappings or no fsid
mappings are setup the behavior is unchanged.

Assuming we have a binary in a given user namespace that is owned by 0:0 in the
given user namespace which appears as 300000:300000 on-disk in the initial user
namespace. Now assume we write an id mapping of 0 100000 100000 and an fsid
mapping for 0 300000 300000 in the user namespace. When we hit bprm_fill_uid()
during setid execution we will retrieve inode kuid=300000 and kgid=300000. We
first check whether there's an fsid mapping for these kids. In our scenario we
find that they map to fsuid=0 and fsgid=0 in the user namespace. Now we
translate them into kids in the id mapping. In our example they translate to
kuid=100000 and kgid=100000 which means the file will ultimately run as uid=0
and gid=0 in the user namespace and as uid=100000, gid=100000 in the initial
user namespace.
Let's alter the example and assume that there is an fsid mapping of 0 300000
300000 set up but no id mapping has been setup for the user namespace. In this
the last step of translating into a valid kid pair in the id mappings will fail
and we will behave as before and ignore the sid bits.

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch added
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Make sure that bprm_fill_uid() handles fsid mappings.

/* v3 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Fix commit message.
---
 fs/exec.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index db17be51b112..9e4a7e757cef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/fsuidgid.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1518,8 +1519,8 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 {
 	struct inode *inode;
 	unsigned int mode;
-	kuid_t uid;
-	kgid_t gid;
+	kuid_t uid, euid;
+	kgid_t gid, egid;
 
 	/*
 	 * Since this can be called multiple times (via prepare_binprm),
@@ -1551,18 +1552,30 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
-	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
-		 !kgid_has_mapping(bprm->cred->user_ns, gid))
+	if (!kfsuid_has_mapping(bprm->cred->user_ns, uid) ||
+		 !kfsgid_has_mapping(bprm->cred->user_ns, gid))
 		return;
 
+	if (mode & S_ISUID) {
+		euid = kfsuid_to_kuid(bprm->cred->user_ns, uid);
+		if (!uid_valid(euid))
+			return;
+	}
+
+	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		egid = kfsgid_to_kgid(bprm->cred->user_ns, gid);
+		if (!gid_valid(egid))
+			return;
+	}
+
 	if (mode & S_ISUID) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
-		bprm->cred->euid = uid;
+		bprm->cred->euid = euid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
-		bprm->cred->egid = gid;
+		bprm->cred->egid = egid;
 	}
 }
 
-- 
2.25.0

