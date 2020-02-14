Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEC15F581
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgBNSh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:37:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgBNSh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:37:56 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqK-0000uO-9H; Fri, 14 Feb 2020 18:37:36 +0000
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
Subject: [PATCH v2 03/28] proc: add /proc/<pid>/fsgid_map
Date:   Fri, 14 Feb 2020 19:35:29 +0100
Message-Id: <20200214183554.1133805-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /proc/<pid>/fsgid_map file can be written to once to setup an fsgid mapping
for a user namespace. Writing to this file has the same restrictions as writing
to /proc/<pid>/fsgid_map.

root@e1-vm:/# cat /proc/13023/fsgid_map
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
/* v2 */
unchanged
---
 fs/proc/base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5fb28004663e..1303cdd2e617 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2975,6 +2975,11 @@ static int proc_fsuid_map_open(struct inode *inode, struct file *file)
 {
 	return proc_id_map_open(inode, file, &proc_fsuid_seq_operations);
 }
+
+static int proc_fsgid_map_open(struct inode *inode, struct file *file)
+{
+	return proc_id_map_open(inode, file, &proc_fsgid_seq_operations);
+}
 #endif
 
 static const struct file_operations proc_uid_map_operations = {
@@ -3009,6 +3014,14 @@ static const struct file_operations proc_fsuid_map_operations = {
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
+
+static const struct file_operations proc_fsgid_map_operations = {
+	.open		= proc_fsgid_map_open,
+	.write		= proc_fsgid_map_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_id_map_release,
+};
 #endif
 
 static int proc_setgroups_open(struct inode *inode, struct file *file)
@@ -3195,6 +3208,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_USER_NS
 #ifdef CONFIG_USER_NS_FSID
 	REG("fsuid_map",  S_IRUGO|S_IWUSR, proc_fsuid_map_operations),
+	REG("fsgid_map",  S_IRUGO|S_IWUSR, proc_fsgid_map_operations),
 #endif
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
-- 
2.25.0

