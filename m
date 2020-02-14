Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1815F596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgBNSiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33699 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbgBNSiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:04 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqR-0000uO-Mb; Fri, 14 Feb 2020 18:37:43 +0000
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
Subject: [PATCH v2 10/28] sys:__sys_setgid(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:36 +0100
Message-Id: <20200214183554.1133805-11-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setgid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.
The kfsid to cleanly handle userns visible filesystem is set as before.

We require that a user must have a valid fsid mapping for the target id. This
is consistent with how the setid calls work today without fsid mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - set kfsid which is used when dealing with proc permission checking
---
 kernel/sys.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index a8eefd748327..aa379fb5e93b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -416,24 +416,31 @@ long __sys_setgid(gid_t gid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t kgid;
+	kgid_t kgid, kfsgid;
 
 	kgid = make_kgid(ns, gid);
 	if (!gid_valid(kgid))
 		return -EINVAL;
 
+	kfsgid = make_kfsgid(ns, gid);
+	if (!gid_valid(kfsgid))
+		return -EINVAL;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
 	old = current_cred();
 
 	retval = -EPERM;
-	if (ns_capable(old->user_ns, CAP_SETGID))
-		new->gid = new->egid = new->sgid = new->fsgid = kgid;
-	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
-		new->egid = new->fsgid = kgid;
-	else
+	if (ns_capable(old->user_ns, CAP_SETGID)) {
+		new->gid = new->egid = new->sgid = new->kfsgid = kgid;
+		new->fsgid = kfsgid;
+	} else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid)) {
+		new->egid = new->kfsgid = kgid;
+		new->fsgid = kfsgid;
+	} else {
 		goto error;
+	}
 
 	return commit_creds(new);
 
-- 
2.25.0

