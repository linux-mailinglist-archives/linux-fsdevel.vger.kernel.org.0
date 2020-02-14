Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF08A15F5C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbgBNSiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbgBNSiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:02 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqU-0000uO-Ht; Fri, 14 Feb 2020 18:37:46 +0000
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
Subject: [PATCH v2 12/28] sys:__sys_setregid(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:38 +0100
Message-Id: <20200214183554.1133805-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setregid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.

During setregid() the kfsgid is set to the kegid corresponding the egid that is
requested by userspace. If the requested egid is -1 the kfsgid is reset to the
current kegid. For the latter case this means we need to lookup the
corresponding userspace egid corresponding to the current kegid in the id
mappings and translate this egid into the corresponding kfsgid in the fsid
mappings.

The kfsid to cleanly handle userns visible filesystem is set as before.

We require that a user must have a valid fsid mapping for the target id. This
is consistent with how the setid calls work today without fsid mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - set kfsid which is used when dealing with proc permission checking
---
 kernel/sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 4697e010bbd7..22eea030d9e7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -354,7 +354,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t krgid, kegid;
+	kgid_t krgid, kegid, kfsgid;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
@@ -386,12 +386,20 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 			new->egid = kegid;
 		else
 			goto error;
+		kfsgid = make_kfsgid(ns, egid);
+	} else {
+		kfsgid = kgid_to_kfsgid(new->user_ns, new->egid);
+	}
+	if (!gid_valid(kfsgid)) {
+		retval = -EINVAL;
+		goto error;
 	}
 
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && !gid_eq(kegid, old->gid)))
 		new->sgid = new->egid;
-	new->fsgid = new->egid;
+	new->kfsgid = new->egid;
+	new->fsgid = kfsgid;
 
 	return commit_creds(new);
 
-- 
2.25.0

