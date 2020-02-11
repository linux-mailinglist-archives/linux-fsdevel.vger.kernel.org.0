Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA91595A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgBKRAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:00:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53528 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgBKRAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:00:30 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1Ysf-00014T-R7; Tue, 11 Feb 2020 16:59:25 +0000
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
Subject: [PATCH 20/24] sys:__sys_setreuid(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:49 +0100
Message-Id: <20200211165753.356508-21-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setreuid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.

During setreuid() the kfsuid is set to the keuid corresponding the euid that is
requested by userspace. If the requested euid is -1 the kfsuid is reset to the
current keuid. For the latter case this means we need to lookup the
corresponding userspace euid corresponding to the current keuid in the id
mappings and translate this euid into the corresponding kfsuid in the fsid
mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/sys.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 11f41e0a4974..ef1104c9df56 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -504,15 +504,18 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kuid_t kruid, keuid;
+	kuid_t kruid, keuid, kfsuid;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
+	kfsuid = make_kfsuid(ns, euid);
 
 	if ((ruid != (uid_t) -1) && !uid_valid(kruid))
 		return -EINVAL;
 	if ((euid != (uid_t) -1) && !uid_valid(keuid))
 		return -EINVAL;
+	if ((euid != (uid_t) -1) && !uid_valid(kfsuid))
+		return -EINVAL;
 
 	new = prepare_creds();
 	if (!new)
@@ -535,6 +538,9 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 		    !uid_eq(old->suid, keuid) &&
 		    !ns_capable_setid(old->user_ns, CAP_SETUID))
 			goto error;
+	} else {
+		uid_t fsuid = from_kuid_munged(new->user_ns, new->euid);
+		kfsuid = make_kfsuid(ns, fsuid);
 	}
 
 	if (!uid_eq(new->uid, old->uid)) {
@@ -545,7 +551,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && !uid_eq(keuid, old->uid)))
 		new->suid = new->euid;
-	new->fsuid = new->euid;
+	new->fsuid = kfsuid;
 
 	retval = security_task_fix_setuid(new, old, LSM_SETID_RE);
 	if (retval < 0)
-- 
2.25.0

