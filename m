Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE595192F88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCYRnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 13:43:17 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:40896 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgCYRnR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:43:17 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 7769AC61AE0;
        Wed, 25 Mar 2020 17:43:13 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
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
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v9 9/8] proc: use named enums for better readability
Date:   Wed, 25 Mar 2020 18:42:45 +0100
Message-Id: <20200325174245.298009-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
References: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c               | 2 +-
 fs/proc/inode.c              | 2 +-
 fs/proc/root.c               | 4 ++--
 include/linux/proc_fs.h      | 6 +++---
 include/uapi/linux/proc_fs.h | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a836979e42fe..608d60fb79fb 100644
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
index a462fd111719..7870e0be0a1f 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -165,7 +165,7 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
 		deactivate_super(old_sb);
 }
 
-static inline const char *hidepid2str(int v)
+static inline const char *hidepid2str(enum proc_hidepid v)
 {
 	switch (v) {
 		case HIDEPID_OFF: return "off";
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 42f3ee05c584..de7cee435621 100644
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
index d259817ec913..b9f7ecd7f61f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -29,7 +29,7 @@ struct proc_ops {
 };
 
 /* definitions for proc mount option pidonly */
-enum {
+enum proc_pidonly {
 	PROC_PIDONLY_OFF = 0,
 	PROC_PIDONLY_ON  = 1,
 };
@@ -39,8 +39,8 @@ struct proc_fs_info {
 	struct dentry *proc_self;        /* For /proc/self */
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
-	int hide_pid;
-	int pidonly;
+	enum proc_hidepid hide_pid;
+	enum proc_pidonly pidonly;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
index dc6d717aa6ec..f5fe0e8dcfe4 100644
--- a/include/uapi/linux/proc_fs.h
+++ b/include/uapi/linux/proc_fs.h
@@ -3,7 +3,7 @@
 #define _UAPI_PROC_FS_H
 
 /* definitions for hide_pid field */
-enum {
+enum proc_hidepid {
 	HIDEPID_OFF            = 0,
 	HIDEPID_NO_ACCESS      = 1,
 	HIDEPID_INVISIBLE      = 2,
-- 
2.25.2

