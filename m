Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7236A1595BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgBKRAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:00:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgBKQ7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:36 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsP-00014T-AP; Tue, 11 Feb 2020 16:59:09 +0000
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
Subject: [PATCH 02/24] proc: add /proc/<pid>/fsuid_map
Date:   Tue, 11 Feb 2020 17:57:31 +0100
Message-Id: <20200211165753.356508-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /proc/<pid>/fsuid_map file can be written to once to setup an fsuid mapping
for a user namespace. Writing to this file has the same restrictions as writing
to /proc/<pid>/fsuid_map:

root@e1-vm:/# cat /proc/13023/fsuid_map
         0     300000     100000

Fsid mappings have always been around. They are currently always identical to
the id mappings for a user namespace. This means, currently whenever an fsid
needs to be looked up the kernel will use the id mapping of the user namespace.
With the introduction of fsid mappings the kernel will now lookup fsids in the
fsid mappings of the user namespace. If no fsid mapping exists the kernel will
continue looking up fsids in the id mappings of the user namespace. Hence, if a
system supports fsid mappings through /proc/<pid>/fs*id_map and a container
runtime is not aware of fsid mappings it or does not use them it will it will
continue to work just as before.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/proc/base.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..ad5f6adc9344 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2879,6 +2879,13 @@ static int proc_projid_map_open(struct inode *inode, struct file *file)
 	return proc_id_map_open(inode, file, &proc_projid_seq_operations);
 }
 
+#ifdef CONFIG_USER_NS_FSID
+static int proc_fsuid_map_open(struct inode *inode, struct file *file)
+{
+	return proc_id_map_open(inode, file, &proc_fsuid_seq_operations);
+}
+#endif
+
 static const struct file_operations proc_uid_map_operations = {
 	.open		= proc_uid_map_open,
 	.write		= proc_uid_map_write,
@@ -2903,6 +2910,16 @@ static const struct file_operations proc_projid_map_operations = {
 	.release	= proc_id_map_release,
 };
 
+#ifdef CONFIG_USER_NS_FSID
+static const struct file_operations proc_fsuid_map_operations = {
+	.open		= proc_fsuid_map_open,
+	.write		= proc_fsuid_map_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_id_map_release,
+};
+#endif
+
 static int proc_setgroups_open(struct inode *inode, struct file *file)
 {
 	struct user_namespace *ns = NULL;
@@ -3079,6 +3096,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
 #endif
 #ifdef CONFIG_USER_NS
+#ifdef CONFIG_USER_NS_FSID
+	REG("fsuid_map",  S_IRUGO|S_IWUSR, proc_fsuid_map_operations),
+#endif
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
 	REG("projid_map", S_IRUGO|S_IWUSR, proc_projid_map_operations),
-- 
2.25.0

