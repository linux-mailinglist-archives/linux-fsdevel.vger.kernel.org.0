Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C4260CD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgIHIAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 04:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgIHIAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:00:32 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415FC061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 01:00:15 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BlyHS6kCqzlhfxV;
        Tue,  8 Sep 2020 10:00:04 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BlyHN6ZwJzlh8T9;
        Tue,  8 Sep 2020 10:00:00 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [RFC PATCH v8 1/3] fs: Introduce AT_INTERPRETED flag for faccessat2(2)
Date:   Tue,  8 Sep 2020 09:59:54 +0200
Message-Id: <20200908075956.1069018-2-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075956.1069018-1-mic@digikod.net>
References: <20200908075956.1069018-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The AT_INTERPRETED flag combined with the X_OK mode enable trusted user
space tasks to check that files are allowed to be executed by user
space.  The security policy is consistently managed by the kernel
through a sysctl or implemented by an LSM thanks to the inode_permission
hook and a new kernel flag: MAY_INTERPRETED_EXEC.

The underlying idea is to be able to restrict scripts interpretation
according to a policy defined by the system administrator.  For this to
be possible, script interpreters must use faccessat2(2) with the
AT_INTERPRETED flag and the X_OK mode.  To be fully effective, these
interpreters also need to handle the other ways to execute code: command
line parameters (e.g., option -e for Perl), module loading (e.g., option
-m for Python), stdin, file sourcing, environment variables,
configuration files, etc.  According to the threat model, it may be
acceptable to allow some script interpreters (e.g. Bash) to interpret
commands from stdin, may it be a TTY or a pipe, because it may not be
enough to (directly) perform syscalls.  Further documentation can be
found in a following patch.

Even without enforced security policy, userland interpreters can set it
to enforce the system policy at their level, knowing that it will not
break anything on running systems which do not care about this feature.
However, on systems which want this feature enforced, there will be
knowledgeable people (i.e. sysadmins who enforced AT_INTERPRETED with
X_OK deliberately) to manage it.  A simple security policy
implementation, configured through a dedicated sysctl, is available in a
following patch.

AT_INTERPRETED with X_OK should not be confused with the O_EXEC flag
(for open) which is intended for execute-only, which obviously doesn't
work for scripts.  However, a similar behavior could be implemented in
userland with O_PATH:
https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/

This is a new implementation of a patch initially written by
Vincent Strubel for CLIP OS 4:
https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
This patch has been used for more than 12 years with customized script
interpreters.  Some examples (with the original O_MAYEXEC) can be found
here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC

Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
---

Changes since v7:
* Replaces openat2/O_MAYEXEC with faccessat2/X_OK/AT_INTERPRETED .
  Switching to an FD-based syscall was suggested by Al Viro and Jann
  Horn.

Changes since v6:
* Do not set __FMODE_EXEC for now because of inconsistent behavior:
  https://lore.kernel.org/lkml/202007160822.CCDB5478@keescook/
* Returns EISDIR when opening a directory with O_MAYEXEC.
* Removed Deven Bowers and Kees Cook Reviewed-by tags because of the
  current update.

Changes since v5:
* Update commit message.

Changes since v3:
* Switch back to O_MAYEXEC, but only handle it with openat2(2) which
  checks unknown flags (suggested by Aleksa Sarai). Cf.
  https://lore.kernel.org/lkml/20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com/

Changes since v2:
* Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).  This change
  enables to not break existing application using bogus O_* flags that
  may be ignored by current kernels by using a new dedicated flag, only
  usable through openat2(2) (suggested by Jeff Layton).  Using this flag
  will results in an error if the running kernel does not support it.
  User space needs to manage this case, as with other RESOLVE_* flags.
  The best effort approach to security (for most common distros) will
  simply consists of ignoring such an error and retry without
  RESOLVE_MAYEXEC.  However, a fully controlled system may which to
  error out if such an inconsistency is detected.

Changes since v1:
* Set __FMODE_EXEC when using O_MAYEXEC to make this information
  available through the new fanotify/FAN_OPEN_EXEC event (suggested by
  Jan Kara and Matthew Bobrowski):
  https://lore.kernel.org/lkml/20181213094658.GA996@lithium.mbobrowski.org/
---
 fs/open.c                  | 31 +++++++++++++++++++++++++++++--
 include/linux/fs.h         |  2 ++
 include/uapi/linux/fcntl.h | 12 +++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..879bdfbdc6fa 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -405,9 +405,13 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
-	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
+	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH |
+				AT_INTERPRETED))
 		return -EINVAL;
 
+	/* Only allows X_OK with AT_INTERPRETED for now. */
+	if ((flags & AT_INTERPRETED) && !(mode & S_IXOTH))
+		return -EINVAL;
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		lookup_flags &= ~LOOKUP_FOLLOW;
 	if (flags & AT_EMPTY_PATH)
@@ -426,7 +430,30 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 
 	inode = d_backing_inode(path.dentry);
 
-	if ((mode & MAY_EXEC) && S_ISREG(inode->i_mode)) {
+	if ((flags & AT_INTERPRETED)) {
+		/*
+		 * For compatibility reasons, without a defined security policy
+		 * (via sysctl or LSM), using AT_INTERPRETED must map the
+		 * execute permission to the read permission.  Indeed, from
+		 * user space point of view, being able to execute data (e.g.
+		 * scripts) implies to be able to read this data.
+		 *
+		 * The MAY_INTERPRETED_EXEC bit is set to enable LSMs to add
+		 * custom checks, while being compatible with current policies.
+		 */
+		if ((mode & MAY_EXEC)) {
+			mode |= MAY_INTERPRETED_EXEC;
+			/*
+			 * For compatibility reasons, if the system-wide policy
+			 * doesn't enforce file permission checks, then
+			 * replaces the execute permission request with a read
+			 * permission request.
+			 */
+			mode &= ~MAY_EXEC;
+			/* To be executed *by* user space, files must be readable. */
+			mode |= MAY_READ;
+		}
+	} else if ((mode & MAY_EXEC) && S_ISREG(inode->i_mode)) {
 		/*
 		 * MAY_EXEC on regular files is denied if the fs is mounted
 		 * with the "noexec" flag.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..03f1b2da6a87 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -101,6 +101,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define MAY_CHDIR		0x00000040
 /* called from RCU mode, don't block */
 #define MAY_NOT_BLOCK		0x00000080
+/* interpreted accesses checked with faccessat2 and AT_INTERPRETED */
+#define MAY_INTERPRETED_EXEC	0x00000100
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..dca082b02634 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -90,7 +90,8 @@
  * unlinkat.  The two functions do completely different things and therefore,
  * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
  * faccessat would be undefined behavior and thus treating it equivalent to
- * AT_EACCESS is valid undefined behavior.
+ * AT_EACCESS is valid undefined behavior.  The same goes for AT_SYMLINK_FOLLOW
+ * and AT_INTERPRETED.
  */
 #define AT_FDCWD		-100    /* Special value used to indicate
                                            openat should use the current
@@ -100,6 +101,15 @@
                                            effective IDs, not real IDs.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
+#define AT_INTERPRETED		0x400	/* Check if the current process should
+					   grant access (e.g. execution) for a
+					   specific file, i.e. enables RWX to
+					   be enforced *by* user space.  The
+					   main usage is for script
+					   interpreters to enforce a policy
+					   consistent with the kernel's one
+					   (through sysctl configuration or LSM
+					   policy).  */
 #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
 #define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
 #define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
-- 
2.28.0

