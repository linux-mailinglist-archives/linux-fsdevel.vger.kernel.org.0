Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6081F15F5CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgBNSjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:39:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33781 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgBNSjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:39:36 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqk-0000uO-FR; Fri, 14 Feb 2020 18:38:02 +0000
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
Subject: [PATCH v2 23/28] commoncap: cap_bprm_set_creds(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:49 +0100
Message-Id: <20200214183554.1133805-24-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During exec the kfsids are currently reset to the effective kids. To retain the
same semantics with the introduction of fsid mappings, we lookup the userspace
effective id in the id mappings and translate the effective id into the
corresponding kfsid in the fsidmapping. This means, the behavior is unchanged
when no fsid mappings are setup and the semantics stay the same even when fsid
mappings are setup.

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Reset kfsids used for userns visible filesystems such as proc too.
---
 security/commoncap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..9641695d8383 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -810,7 +810,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	struct cred *new = bprm->cred;
 	bool effective = false, has_fcap = false, is_setid;
 	int ret;
-	kuid_t root_uid;
+	kuid_t root_uid, kfsuid;
+	kgid_t kfsgid;
+	uid_t fsuid;
+	gid_t fsgid;
 
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
@@ -847,8 +850,15 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 						   old->cap_permitted);
 	}
 
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
+	fsuid = from_kuid_munged(new->user_ns, new->euid);
+	kfsuid = make_kfsuid(new->user_ns, fsuid);
+	new->suid = new->kfsuid = new->euid;
+	new->fsuid = kfsuid;
+
+	fsgid = from_kgid_munged(new->user_ns, new->egid);
+	kfsgid = make_kfsgid(new->user_ns, fsgid);
+	new->sgid = new->kfsgid = new->egid;
+	new->fsgid = kfsgid;
 
 	/* File caps or setid cancels ambient. */
 	if (has_fcap || is_setid)
-- 
2.25.0

