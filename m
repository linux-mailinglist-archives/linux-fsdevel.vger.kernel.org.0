Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C09334682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhCJSTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhCJSTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:19:03 -0500
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F7C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 10:19:02 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DwgM93hnmzMqKl8;
        Wed, 10 Mar 2021 19:19:01 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DwgM9170Tzlh8TC;
        Wed, 10 Mar 2021 19:19:01 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Date:   Wed, 10 Mar 2021 19:18:57 +0100
Message-Id: <20210310181857.401675-2-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210310181857.401675-1-mic@digikod.net>
References: <20210310181857.401675-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Being able to easily change root directories enable to ease some
development workflow and can be used as a tool to strengthen
unprivileged security sandboxes.  chroot(2) is not an access-control
mechanism per se, but it can be used to limit the absolute view of the
filesystem, and then limit ways to access data and kernel interfaces
(e.g. /proc, /sys, /dev, etc.).

Users may not wish to expose namespace complexity to potentially
malicious processes, or limit their use because of limited resources.
The chroot feature is much more simple (and limited) than the mount
namespace, but can still be useful.  As for containers, users of
chroot(2) should take care of file descriptors or data accessible by
other means (e.g. current working directory, leaked FDs, passed FDs,
devices, mount points, etc.).  There is a lot of literature that discuss
the limitations of chroot, and users of this feature should be aware of
the multiple ways to bypass it.  Using chroot(2) for security purposes
can make sense if it is combined with other features (e.g. dedicated
user, seccomp, LSM access-controls, etc.).

One could argue that chroot(2) is useless without a properly populated
root hierarchy (i.e. without /dev and /proc).  However, there are
multiple use cases that don't require the chrooting process to create
file hierarchies with special files nor mount points, e.g.:
* A process sandboxing itself, once all its libraries are loaded, may
  not need files other than regular files, or even no file at all.
* Some pre-populated root hierarchies could be used to chroot into,
  provided for instance by development environments or tailored
  distributions.
* Processes executed in a chroot may not require access to these special
  files (e.g. with minimal runtimes, or by emulating some special files
  with a LD_PRELOADed library or seccomp).

Allowing a task to change its own root directory is not a threat to the
system if we can prevent confused deputy attacks, which could be
performed through execution of SUID-like binaries.  This can be
prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
prctl(2).  To only affect this task, its filesystem information must not
be shared with other tasks, which can be achieved by not passing
CLONE_FS to clone(2).  A similar no_new_privs check is already used by
seccomp to avoid the same kind of security issues.  Furthermore, because
of its security use and to avoid giving a new way for attackers to get
out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot is
only allowed if the new root directory is the same or beneath the
current one.  This still allows a process to use a subset of its
legitimate filesystem to chroot into and then further reduce its view of
the filesystem.

This change may not impact systems relying on other permission models
than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
such systems may require to update their security policies.

Only the chroot system call is relaxed with this no_new_privs check; the
init_chroot() helper doesn't require such change.

Allowing unprivileged users to use chroot(2) is one of the initial
objectives of no_new_privs:
https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
This patch is a follow-up of a previous one sent by Andy Lutomirski, but
with less limitations:
https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210310181857.401675-2-mic@digikod.net
---

Changes since v1:
* Replace custom is_path_beneath() with existing path_is_under().
---
 fs/open.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..280dbff25b25 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/fs.h>
+#include <linux/path.h>
 #include <linux/personality.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
@@ -546,15 +547,31 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto dput_and_out;
 
+	/*
+	 * Changing the root directory for the calling task (and its future
+	 * children) requires that this task has CAP_SYS_CHROOT in its
+	 * namespace, or be running with no_new_privs and not sharing its
+	 * fs_struct and not escaping its current root directory.  As for
+	 * seccomp, checking no_new_privs avoids scenarios where unprivileged
+	 * tasks can affect the behavior of privileged children.  Lock the path
+	 * to protect against TOCTOU race between path_is_under() and
+	 * set_fs_root().  No need to lock the root because it is not possible
+	 * to rename it beneath itself.
+	 */
 	error = -EPERM;
-	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
-		goto dput_and_out;
+	inode_lock(d_inode(path.dentry));
+	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
+			!(task_no_new_privs(current) && current->fs->users == 1
+				&& path_is_under(&path, &current->fs->root)))
+		goto unlock_and_out;
 	error = security_path_chroot(&path);
 	if (error)
-		goto dput_and_out;
+		goto unlock_and_out;
 
 	set_fs_root(current->fs, &path);
 	error = 0;
+unlock_and_out:
+	inode_unlock(d_inode(path.dentry));
 dput_and_out:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
-- 
2.30.2

