Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5D159598
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgBKRAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:00:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgBKQ7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:41 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsZ-00014T-Qz; Tue, 11 Feb 2020 16:59:20 +0000
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
Subject: [PATCH 14/24] commoncap: cap_task_fix_setuid(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:43 +0100
Message-Id: <20200211165753.356508-15-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch cap_task_fix_setuid() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 security/commoncap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..ecfa0d0c250e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
+#include <linux/fsuidgid.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1051,7 +1052,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		 *          if not, we might be a bit too harsh here.
 		 */
 		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
-			kuid_t root_uid = make_kuid(old->user_ns, 0);
+			kuid_t root_uid = make_kfsuid(old->user_ns, 0);
 			if (uid_eq(old->fsuid, root_uid) && !uid_eq(new->fsuid, root_uid))
 				new->cap_effective =
 					cap_drop_fs_set(new->cap_effective);
-- 
2.25.0

