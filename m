Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7211B650F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDWUET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:04:19 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:48382 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgDWUDq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:03:46 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id AD61420A03;
        Thu, 23 Apr 2020 20:03:40 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 2/8] Use proc_pid_ns() to get pid_namespace from the proc superblock
Date:   Thu, 23 Apr 2020 22:03:10 +0200
Message-Id: <20200423200316.164518-3-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423200316.164518-1-gladkov.alexey@gmail.com>
References: <20200423200316.164518-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 23 Apr 2020 20:03:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To get pid_namespace from the procfs superblock should be used a special
helper. This will avoid errors when s_fs_info will change the type.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/locks.c                 | 4 ++--
 security/tomoyo/realpath.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b8a31c1c4fff..399c5dbb72c4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
 	struct file_lock *fl, *bfl;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
 
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index bf38fc1b59b2..08b096e2f7e3 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -7,6 +7,7 @@
 
 #include "common.h"
 #include <linux/magic.h>
+#include <linux/proc_fs.h>
 
 /**
  * tomoyo_encode2 - Encode binary string to ascii string.
@@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
 		char *ep;
 		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
+		struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
 
 		if (*ep == '/' && pid && pid ==
-		    task_tgid_nr_ns(current, sb->s_fs_info)) {
+		    task_tgid_nr_ns(current, proc_pidns)) {
 			pos = ep - 5;
 			if (pos < buffer)
 				goto out;
-- 
2.25.3

