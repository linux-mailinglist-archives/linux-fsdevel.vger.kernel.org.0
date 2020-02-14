Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16D15F58D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgBNSiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbgBNSiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:02 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqP-0000uO-HU; Fri, 14 Feb 2020 18:37:41 +0000
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
Subject: [PATCH v2 08/28] sys: __sys_setfsgid(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:34 +0100
Message-Id: <20200214183554.1133805-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setfsgid() to lookup fsids in the fsid mappings. If no fsid mappings are
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
 kernel/sys.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 13f790dbda71..864fa78f25a7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -849,15 +849,19 @@ long __sys_setfsgid(gid_t gid)
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
@@ -867,6 +871,7 @@ long __sys_setfsgid(gid_t gid)
 	    ns_capable(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
+			new->kfsgid = kfsgid;
 			goto change_okay;
 		}
 	}
-- 
2.25.0

