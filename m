Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC1337092
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhCKKxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 05:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCKKxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:53:07 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74594C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 02:53:07 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dx5Q96kpNzMqP1K;
        Thu, 11 Mar 2021 11:53:05 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dx5Q944mhzlh8TJ;
        Thu, 11 Mar 2021 11:53:05 +0100 (CET)
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
Subject: [PATCH v3 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Date:   Thu, 11 Mar 2021 11:52:42 +0100
Message-Id: <20210311105242.874506-2-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210311105242.874506-1-mic@digikod.net>
References: <20210311105242.874506-1-mic@digikod.net>
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
out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an
unprivileged chroot is only allowed if the calling process is not
already chrooted.  This limitation is the same as for creating user
namespaces.

This change may not impact systems relying on other permission models
than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
such systems may require to update their security policies.

Only the chroot system call is relaxed with this no_new_privs check; the
init_chroot() helper doesn't require such change.

Allowing unprivileged users to use chroot(2) is one of the initial
objectives of no_new_privs:
https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
This patch is a follow-up of a previous one sent by Andy Lutomirski:
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
Link: https://lore.kernel.org/r/20210311105242.874506-2-mic@digikod.net
---

Changes since v2:
* Replace path_is_under() check with current_chrooted() to gain the same
  protection as create_user_ns() (suggested by Jann Horn). See commit
  3151527ee007 ("userns:  Don't allow creation if the user is chrooted")

Changes since v1:
* Replace custom is_path_beneath() with existing path_is_under().
---
 fs/open.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..1eb086ed324b 100644
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
@@ -546,8 +547,18 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto dput_and_out;
 
+	/*
+	 * Changing the root directory for the calling task (and its future
+	 * children) requires that this task has CAP_SYS_CHROOT in its
+	 * namespace, or be running with no_new_privs and not sharing its
+	 * fs_struct and not escaping its current root (cf. create_user_ns()).
+	 * As for seccomp, checking no_new_privs avoids scenarios where
+	 * unprivileged tasks can affect the behavior of privileged children.
+	 */
 	error = -EPERM;
-	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
+	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
+			!(task_no_new_privs(current) && current->fs->users == 1
+				&& !current_chrooted()))
 		goto dput_and_out;
 	error = security_path_chroot(&path);
 	if (error)
-- 
2.30.2

