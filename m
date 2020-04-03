Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B235619DD8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404539AbgDCSHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 14:07:37 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:38090 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404439AbgDCSHf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:07:35 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 9B8F6209DC;
        Fri,  3 Apr 2020 18:07:30 +0000 (UTC)
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
Subject: [PATCH v11 8/8] proc: use named enums for better readability
Date:   Fri,  3 Apr 2020 20:06:48 +0200
Message-Id: <20200403180648.721362-9-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200403180648.721362-1-gladkov.alexey@gmail.com>
References: <20200403180648.721362-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 03 Apr 2020 18:07:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/base.c          | 2 +-
 fs/proc/inode.c         | 2 +-
 fs/proc/root.c          | 4 ++--
 include/linux/proc_fs.h | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1ebe9eba48ea..2f2f7b36c947 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -699,7 +699,7 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
  */
 static bool has_pid_permissions(struct proc_fs_info *fs_info,
 				 struct task_struct *task,
-				 int hide_pid_min)
+				 enum proc_hidepid hide_pid_min)
 {
 	/*
 	 * If 'hidpid' mount option is set force a ptrace check,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index d38a9e592352..8f3681723108 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -166,7 +166,7 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
 		deactivate_super(old_sb);
 }
 
-static inline const char *hidepid2str(int v)
+static inline const char *hidepid2str(enum proc_hidepid v)
 {
 	switch (v) {
 		case HIDEPID_OFF: return "off";
diff --git a/fs/proc/root.c b/fs/proc/root.c
index c6caae9e4308..9d6ce3710f4f 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -32,9 +32,9 @@
 struct proc_fs_context {
 	struct proc_fs_info	*fs_info;
 	unsigned int		mask;
-	int			hidepid;
+	enum proc_hidepid	hidepid;
 	int			gid;
-	int			pidonly;
+	enum proc_pidonly	pidonly;
 };
 
 enum proc_param {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index afd38cae2339..3701f49eb299 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -28,7 +28,7 @@ struct proc_ops {
 };
 
 /* definitions for hide_pid field */
-enum {
+enum proc_hidepid {
 	HIDEPID_OFF	  = 0,
 	HIDEPID_NO_ACCESS = 1,
 	HIDEPID_INVISIBLE = 2,
@@ -36,7 +36,7 @@ enum {
 };
 
 /* definitions for proc mount option pidonly */
-enum {
+enum proc_pidonly {
 	PROC_PIDONLY_OFF = 0,
 	PROC_PIDONLY_ON  = 1,
 };
@@ -46,8 +46,8 @@ struct proc_fs_info {
 	struct dentry *proc_self;        /* For /proc/self */
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
-	int hide_pid;
-	int pidonly;
+	enum proc_hidepid hide_pid;
+	enum proc_pidonly pidonly;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.25.2

