Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C220116289E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBROh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:37:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgBROhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:37:25 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43yD-0000fF-W8; Tue, 18 Feb 2020 14:35:30 +0000
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
Subject: [PATCH v3 24/25] sys: handle fsid mappings in set*id() calls
Date:   Tue, 18 Feb 2020 15:34:10 +0100
Message-Id: <20200218143411.2389182-25-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch set*id() calls to lookup fsids in the fsid mappings. If no fsid mappings
are setup the behavior is unchanged, i.e. fsids are looked up in the id
mappings.

A caller can only setid() to a given id if the id maps to a valid kid in
both the id and fsid maps of the caller's user namespace. This is always the
case when no id mappings and fsid mappings have been written. It is also always
the case when an id mapping has been written which includes the target id and
but no fsid mappings have been written. All non-fsid mapping aware workloads
will thus work just as before.

During setr*id() calls the kfsid is set to the keid corresponding to the eid
that is requested by userspace. If the requested eid is -1 the kfsid is reset
to the current keid. For the latter case this means we need to lookup the
corresponding userspace eid corresponding to the current keid in the id
mappings and translate this eid into the corresponding kfsid in the fsid
mappings.

We require that a user must have a valid fsid mapping for the target id. This
is consistent with how the setid calls work today without fsid mappings.

The kfsid to cleanly handle userns visible filesystem is set as before.

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - set kfsid which is used when dealing with proc permission checking

/* v3 */
- Jann Horn <jannh@google.com>:
  - Squash all set*id() patches into a single patch and move this to be the
    last patch so we don't expose a half-done feature in the middle of this
    series.
---
 kernel/sys.c | 106 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 23 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index f9bc5c303e3f..78592deee2d8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -59,6 +59,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
+#include <linux/fsuidgid.h>
 #include <linux/cred.h>
 
 #include <linux/nospec.h>
@@ -353,7 +354,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t krgid, kegid;
+	kgid_t krgid, kegid, kfsgid;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
@@ -385,12 +386,20 @@ long __sys_setregid(gid_t rgid, gid_t egid)
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
 
@@ -415,24 +424,31 @@ long __sys_setgid(gid_t gid)
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
 
@@ -496,7 +512,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kuid_t kruid, keuid;
+	kuid_t kruid, keuid, kfsuid;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
@@ -527,6 +543,13 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 		    !uid_eq(old->suid, keuid) &&
 		    !ns_capable_setid(old->user_ns, CAP_SETUID))
 			goto error;
+		kfsuid = make_kfsuid(new->user_ns, euid);
+	} else {
+		kfsuid = kuid_to_kfsuid(new->user_ns, new->euid);
+	}
+	if (!uid_valid(kfsuid)) {
+		retval = -EINVAL;
+		goto error;
 	}
 
 	if (!uid_eq(new->uid, old->uid)) {
@@ -537,7 +560,8 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && !uid_eq(keuid, old->uid)))
 		new->suid = new->euid;
-	new->fsuid = new->euid;
+	new->kfsuid = new->euid;
+	new->fsuid = kfsuid;
 
 	retval = security_task_fix_setuid(new, old, LSM_SETID_RE);
 	if (retval < 0)
@@ -573,11 +597,16 @@ long __sys_setuid(uid_t uid)
 	struct cred *new;
 	int retval;
 	kuid_t kuid;
+	kuid_t kfsuid;
 
 	kuid = make_kuid(ns, uid);
 	if (!uid_valid(kuid))
 		return -EINVAL;
 
+	kfsuid = make_kfsuid(ns, uid);
+	if (!uid_valid(kfsuid))
+		return -EINVAL;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
@@ -595,7 +624,8 @@ long __sys_setuid(uid_t uid)
 		goto error;
 	}
 
-	new->fsuid = new->euid = kuid;
+	new->kfsuid = new->euid = kuid;
+	new->fsuid = kfsuid;
 
 	retval = security_task_fix_setuid(new, old, LSM_SETID_ID);
 	if (retval < 0)
@@ -624,7 +654,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kuid_t kruid, keuid, ksuid;
+	kuid_t kruid, keuid, ksuid, kfsuid;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
@@ -666,11 +696,21 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 				goto error;
 		}
 	}
-	if (euid != (uid_t) -1)
+	if (euid != (uid_t) -1) {
 		new->euid = keuid;
+		kfsuid = make_kfsuid(ns, euid);
+	} else {
+		kfsuid = kuid_to_kfsuid(new->user_ns, new->euid);
+	}
+	if (!uid_valid(kfsuid)) {
+		return -EINVAL;
+		goto error;
+	}
+
 	if (suid != (uid_t) -1)
 		new->suid = ksuid;
-	new->fsuid = new->euid;
+	new->kfsuid = new->euid;
+	new->fsuid = kfsuid;
 
 	retval = security_task_fix_setuid(new, old, LSM_SETID_RES);
 	if (retval < 0)
@@ -716,7 +756,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t krgid, kegid, ksgid;
+	kgid_t krgid, kegid, ksgid, kfsgid;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
@@ -749,11 +789,21 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 
 	if (rgid != (gid_t) -1)
 		new->gid = krgid;
-	if (egid != (gid_t) -1)
+	if (egid != (gid_t) -1) {
 		new->egid = kegid;
+		kfsgid = make_kfsgid(ns, egid);
+	} else {
+		kfsgid = kgid_to_kfsgid(new->user_ns, new->egid);
+	}
+	if (!gid_valid(kfsgid)) {
+		retval = -EINVAL;
+		goto error;
+	}
+
 	if (sgid != (gid_t) -1)
 		new->sgid = ksgid;
-	new->fsgid = new->egid;
+	new->kfsgid = new->egid;
+	new->fsgid = kfsgid;
 
 	return commit_creds(new);
 
@@ -799,15 +849,19 @@ long __sys_setfsuid(uid_t uid)
 	const struct cred *old;
 	struct cred *new;
 	uid_t old_fsuid;
-	kuid_t kuid;
+	kuid_t kuid, kfsuid;
 
 	old = current_cred();
-	old_fsuid = from_kuid_munged(old->user_ns, old->fsuid);
+	old_fsuid = from_kfsuid_munged(old->user_ns, old->fsuid);
 
-	kuid = make_kuid(old->user_ns, uid);
+	kuid = make_kfsuid(old->user_ns, uid);
 	if (!uid_valid(kuid))
 		return old_fsuid;
 
+	kfsuid = make_kuid(old->user_ns, uid);
+	if (!uid_valid(kfsuid))
+		return old_fsuid;
+
 	new = prepare_creds();
 	if (!new)
 		return old_fsuid;
@@ -817,6 +871,7 @@ long __sys_setfsuid(uid_t uid)
 	    ns_capable_setid(old->user_ns, CAP_SETUID)) {
 		if (!uid_eq(kuid, old->fsuid)) {
 			new->fsuid = kuid;
+			new->kfsuid = kfsuid;
 			if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
 				goto change_okay;
 		}
@@ -843,15 +898,19 @@ long __sys_setfsgid(gid_t gid)
 	const struct cred *old;
 	struct cred *new;
 	gid_t old_fsgid;
-	kgid_t kgid;
+	kgid_t kgid, kfsgid;
 
 	old = current_cred();
-	old_fsgid = from_kgid_munged(old->user_ns, old->fsgid);
+	old_fsgid = from_kfsgid_munged(old->user_ns, old->fsgid);
 
-	kgid = make_kgid(old->user_ns, gid);
+	kgid = make_kfsgid(old->user_ns, gid);
 	if (!gid_valid(kgid))
 		return old_fsgid;
 
+	kfsgid = make_kgid(old->user_ns, gid);
+	if (!gid_valid(kfsgid))
+		return old_fsgid;
+
 	new = prepare_creds();
 	if (!new)
 		return old_fsgid;
@@ -861,6 +920,7 @@ long __sys_setfsgid(gid_t gid)
 	    ns_capable(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
+			new->kfsgid = kfsgid;
 			goto change_okay;
 		}
 	}
-- 
2.25.0

