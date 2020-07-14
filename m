Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750F21F910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGNSR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:17:29 -0400
Received: from smtp-8faa.mail.infomaniak.ch ([83.166.143.170]:34409 "EHLO
        smtp-8faa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729257AbgGNSR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:17:28 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B5pd22pjWzlhBfk;
        Tue, 14 Jul 2020 20:16:54 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4B5pd16Yg6zlh8TC;
        Tue, 14 Jul 2020 20:16:53 +0200 (CEST)
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
Date:   Tue, 14 Jul 2020 20:16:35 +0200
Message-Id: <20200714181638.45751-5-mic@digikod.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714181638.45751-1-mic@digikod.net>
References: <20200714181638.45751-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the O_MAYEXEC flag is passed, openat2(2) may be subject to
additional restrictions depending on a security policy managed by the
kernel through a sysctl or implemented by an LSM thanks to the
inode_permission hook.  This new flag is ignored by open(2) and
openat(2) because of their unspecified flags handling.

The underlying idea is to be able to restrict scripts interpretation
according to a policy defined by the system administrator.  For this to
be possible, script interpreters must use the O_MAYEXEC flag
appropriately.  To be fully effective, these interpreters also need to
handle the other ways to execute code: command line parameters (e.g.,
option -e for Perl), module loading (e.g., option -m for Python), stdin,
file sourcing, environment variables, configuration files, etc.
According to the threat model, it may be acceptable to allow some script
interpreters (e.g. Bash) to interpret commands from stdin, may it be a
TTY or a pipe, because it may not be enough to (directly) perform
syscalls.  Further documentation can be found in a following patch.

Even without enforced security policy, userland interpreters can set it
to enforce the system policy at their level, knowing that it will not
break anything on running systems which do not care about this feature.
However, on systems which want this feature enforced, there will be
knowledgeable people (i.e. sysadmins who enforced O_MAYEXEC
deliberately) to manage it.  A simple security policy implementation,
configured through a dedicated sysctl, is available in a following
patch.

O_MAYEXEC should not be confused with the O_EXEC flag which is intended
for execute-only, which obviously doesn't work for scripts.  However, a
similar behavior could be implemented in userland with O_PATH:
https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/

The implementation of O_MAYEXEC almost duplicates what execve(2) and
uselib(2) are already doing: setting MAY_OPENEXEC in acc_mode (which can
then be checked as MAY_EXEC, if enforced), and propagating FMODE_EXEC to
_fmode via __FMODE_EXEC flag (which can then trigger a
fanotify/FAN_OPEN_EXEC event).

This is an updated subset of the patch initially written by Vincent
Strubel for CLIP OS 4:
https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
This patch has been used for more than 12 years with customized script
interpreters.  Some examples (with the original name O_MAYEXEC) can be
found here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC

Co-developed-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Deven Bowers <deven.desai@linux.microsoft.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---

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
 fs/fcntl.c                       | 2 +-
 fs/open.c                        | 8 ++++++++
 include/linux/fcntl.h            | 2 +-
 include/linux/fs.h               | 2 ++
 include/uapi/asm-generic/fcntl.h | 7 +++++++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..0357ad667563 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1033,7 +1033,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/open.c b/fs/open.c
index 623b7506a6db..38e434bdbbb6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -987,6 +987,8 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 		.mode = mode & S_IALLUGO,
 	};
 
+	/* O_MAYEXEC is ignored by syscalls relying on build_open_how(). */
+	how.flags &= ~O_MAYEXEC;
 	/* O_PATH beats everything else. */
 	if (how.flags & O_PATH)
 		how.flags &= O_PATH_FLAGS;
@@ -1054,6 +1056,12 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	if (flags & __O_SYNC)
 		flags |= O_DSYNC;
 
+	/* Checks execution permissions on open. */
+	if (flags & O_MAYEXEC) {
+		acc_mode |= MAY_OPENEXEC;
+		flags |= __FMODE_EXEC;
+	}
+
 	op->open_flag = flags;
 
 	/* O_TRUNC implies we need access checks for write permissions */
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..e188a360fa5f 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_MAYEXEC)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
 #define VALID_UPGRADE_FLAGS \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..56f835c9a87a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -101,6 +101,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define MAY_CHDIR		0x00000040
 /* called from RCU mode, don't block */
 #define MAY_NOT_BLOCK		0x00000080
+/* the inode is opened with O_MAYEXEC */
+#define MAY_OPENEXEC		0x00000100
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..bca90620119f 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -97,6 +97,13 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+/*
+ * Code execution from file is intended, checks such permission.  A simple
+ * policy can be enforced system-wide as explained in
+ * Documentation/admin-guide/sysctl/fs.rst .
+ */
+#define O_MAYEXEC	040000000
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
-- 
2.27.0

