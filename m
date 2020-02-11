Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD41595CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgBKRBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:01:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53591 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBKRBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:01:15 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1Ysh-00014T-DW; Tue, 11 Feb 2020 16:59:27 +0000
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
Subject: [PATCH 22/24] sys:__sys_setresuid(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:51 +0100
Message-Id: <20200211165753.356508-23-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setresuid() to lookup fsids in the fsid mappings. If no fsid mappings
are setup the behavior is unchanged, i.e. fsids are looked up in the id
mappings.

During setresuid() the kfsuid is set to the keuid corresponding the euid that is
requested by userspace. If the requested euid is -1 the kfsuid is reset to the
current keuid. For the latter case this means we need to lookup the
corresponding userspace euid corresponding to the current keuid in the id
mappings and translate this euid into the corresponding kfsuid in the fsid
mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/sys.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 41551c01c3eb..3b98ce84607d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -650,11 +650,12 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kuid_t kruid, keuid, ksuid;
+	kuid_t kruid, keuid, ksuid, kfsuid;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
 	ksuid = make_kuid(ns, suid);
+	kfsuid = make_kfsuid(ns, euid);
 
 	if ((ruid != (uid_t) -1) && !uid_valid(kruid))
 		return -EINVAL;
@@ -665,6 +666,9 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	if ((suid != (uid_t) -1) && !uid_valid(ksuid))
 		return -EINVAL;
 
+	if ((euid != (uid_t) -1) && !uid_valid(kfsuid))
+		return -EINVAL;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
@@ -692,11 +696,15 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 				goto error;
 		}
 	}
-	if (euid != (uid_t) -1)
+	if (euid != (uid_t) -1) {
 		new->euid = keuid;
+	} else {
+		uid_t fsuid = from_kuid_munged(new->user_ns, new->euid);
+		kfsuid = make_kfsuid(ns, fsuid);
+	}
 	if (suid != (uid_t) -1)
 		new->suid = ksuid;
-	new->fsuid = new->euid;
+	new->fsuid = kfsuid;
 
 	retval = security_task_fix_setuid(new, old, LSM_SETID_RES);
 	if (retval < 0)
-- 
2.25.0

