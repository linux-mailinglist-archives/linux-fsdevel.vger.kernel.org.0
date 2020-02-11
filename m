Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A831595D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBKQ7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 11:59:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBKQ7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:33 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsR-00014T-KC; Tue, 11 Feb 2020 16:59:11 +0000
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
Subject: [PATCH 05/24] proc: task_state(): use from_kfs{g,u}id_munged
Date:   Tue, 11 Feb 2020 17:57:34 +0100
Message-Id: <20200211165753.356508-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If fsid mappings have been written, this will cause proc to look at fsid
mappings for the user namespace. If no fsid mappings have been written the
behavior is as before.

Here is part of the output from /proc/<pid>/status from the initial user
namespace for systemd running in an unprivileged container as user namespace
root with id mapping 0 100000 100000 and fsid mapping 0 300000 100000:

Name:	systemd
Umask:	0000
State:	S (sleeping)
Tgid:	13023
Ngid:	0
Pid:	13023
PPid:	13008
TracerPid:	0
Uid:	100000	100000	100000	300000
Gid:	100000	100000	100000	300000
FDSize:	64
Groups:

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/proc/array.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 5efaf3708ec6..d4a04f85a67e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -91,6 +91,7 @@
 #include <linux/string_helpers.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
+#include <linux/fsuidgid.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -193,11 +194,11 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	seq_put_decimal_ull(m, "\nUid:\t", from_kuid_munged(user_ns, cred->uid));
 	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->euid));
 	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->suid));
-	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->fsuid));
+	seq_put_decimal_ull(m, "\t", from_kfsuid_munged(user_ns, cred->fsuid));
 	seq_put_decimal_ull(m, "\nGid:\t", from_kgid_munged(user_ns, cred->gid));
 	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->egid));
 	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->sgid));
-	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->fsgid));
+	seq_put_decimal_ull(m, "\t", from_kfsgid_munged(user_ns, cred->fsgid));
 	seq_put_decimal_ull(m, "\nFDSize:\t", max_fds);
 
 	seq_puts(m, "\nGroups:\t");
-- 
2.25.0

