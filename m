Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6215F5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgBNSi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33657 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgBNSiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:00 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqO-0000uO-Jh; Fri, 14 Feb 2020 18:37:40 +0000
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
Subject: [PATCH v2 07/28] sys: __sys_setfsuid(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:33 +0100
Message-Id: <20200214183554.1133805-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setfsuid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.

A caller can only setfs{g,u}id() to a given id if the id maps to a valid kid in
both the id and fsid maps of the caller's user namespace. This is always the
case when no id mappings and fsid mappings have been written. It is also always
the case when an id mapping has been written which includes the target id and
but no fsid mappings have been written. All non-fsid mapping aware workloads
will thus work just as before.
Requiring a valid mapping for the target id in both the id and fsid mappings of
the container simplifies permission checking for userns visible filesystems
such as proc.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Set unmapped fsid as well.
---
 kernel/sys.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index f9bc5c303e3f..13f790dbda71 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -59,6 +59,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
+#include <linux/fsuidgid.h>
 #include <linux/cred.h>
 
 #include <linux/nospec.h>
@@ -799,15 +800,19 @@ long __sys_setfsuid(uid_t uid)
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
@@ -817,6 +822,7 @@ long __sys_setfsuid(uid_t uid)
 	    ns_capable_setid(old->user_ns, CAP_SETUID)) {
 		if (!uid_eq(kuid, old->fsuid)) {
 			new->fsuid = kuid;
+			new->kfsuid = kfsuid;
 			if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
 				goto change_okay;
 		}
-- 
2.25.0

