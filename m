Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F21AFB1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDSOLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 10:11:49 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:45564 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDSOLr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:11:47 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id ED324209FF;
        Sun, 19 Apr 2020 14:11:42 +0000 (UTC)
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
Subject: [PATCH v12 5/7] docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior
Date:   Sun, 19 Apr 2020 16:10:55 +0200
Message-Id: <20200419141057.621356-6-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200419141057.621356-1-gladkov.alexey@gmail.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sun, 19 Apr 2020 14:11:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/filesystems/proc.rst | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 38b606991065..360486c7a992 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -51,6 +51,8 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   4	Configuring procfs
   4.1	Mount options
 
+  5	Filesystem behavior
+
 Preface
 =======
 
@@ -2142,6 +2144,7 @@ The following mount options are supported:
 	=========	========================================================
 	hidepid=	Set /proc/<pid>/ access mode.
 	gid=		Set the group authorized to learn processes information.
+	subset=		Show only the specified subset of procfs.
 	=========	========================================================
 
 hidepid=0 means classic mode - everybody may access all /proc/<pid>/ directories
@@ -2164,6 +2167,57 @@ information about running processes, whether some daemon runs with elevated
 privileges, whether other user runs some sensitive program, whether other users
 run any program at all, etc.
 
+hidepid=4 means that procfs should only contain /proc/<pid>/ directories
+that the caller can ptrace.
+
 gid= defines a group authorized to learn processes information otherwise
 prohibited by hidepid=.  If you use some daemon like identd which needs to learn
 information about processes information, just add identd to this group.
+
+subset=pid hides all top level files and directories in the procfs that
+are not related to tasks.
+
+5	Filesystem behavior
+----------------------------
+
+Originally, before the advent of pid namepsace, procfs was a global file
+system. It means that there was only one procfs instance in the system.
+
+When pid namespace was added, a separate procfs instance was mounted in
+each pid namespace. So, procfs mount options are global among all
+mountpoints within the same namespace.
+
+::
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+
+# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
+mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
++++ exited with 0 +++
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+proc /tmp/proc proc rw,relatime,hidepid=2 0 0
+
+and only after remounting procfs mount options will change at all
+mountpoints.
+
+# mount -o remount,hidepid=1 -t proc proc /tmp/proc
+
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=1 0 0
+proc /tmp/proc proc rw,relatime,hidepid=1 0 0
+
+This behavior is different from the behavior of other filesystems.
+
+The new procfs behavior is more like other filesystems. Each procfs mount
+creates a new procfs instance. Mount options affect own procfs instance.
+It means that it became possible to have several procfs instances
+displaying tasks with different filtering options in one pid namespace.
+
+# mount -o hidepid=2 -t proc proc /proc
+# mount -o hidepid=1 -t proc proc /tmp/proc
+# grep ^proc /proc/mounts
+proc /proc proc rw,relatime,hidepid=2 0 0
+proc /tmp/proc proc rw,relatime,hidepid=1 0 0
-- 
2.25.3

