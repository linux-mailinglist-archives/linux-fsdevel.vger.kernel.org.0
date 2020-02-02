Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2A14FDC3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 16:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgBBPTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 10:19:51 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:52492 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBBPTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:19:51 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 489ZPv3BbYzQlDR;
        Sun,  2 Feb 2020 16:19:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id DZIc82vBUK6f; Sun,  2 Feb 2020 16:19:43 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2) syscall
Date:   Mon,  3 Feb 2020 02:19:07 +1100
Message-Id: <20200202151907.23587-3-cyphar@cyphar.com>
In-Reply-To: <20200202151907.23587-1-cyphar@cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than trying to merge the new syscall documentation into open.2
(which would probably result in the man-page being incomprehensible),
instead the new syscall gets its own dedicated page with links between
open(2) and openat2(2) to avoid duplicating information such as the list
of O_* flags or common errors.

In addition to describing all of the key flags, information about the
extensibility design is provided so that users can better understand why
they need to pass sizeof(struct open_how) and how their programs will
work across kernels. After some discussions with David Laight, I also
included explicit instructions to zero the structure to avoid issues
when recompiling with new headers.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man2/open.2    |  17 ++
 man2/openat2.2 | 471 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 488 insertions(+)
 create mode 100644 man2/openat2.2

diff --git a/man2/open.2 b/man2/open.2
index b0f485b41589..2a721c991a20 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -65,6 +65,10 @@ open, openat, creat \- open and possibly create a file
 .BI "int openat(int " dirfd ", const char *" pathname ", int " flags );
 .BI "int openat(int " dirfd ", const char *" pathname ", int " flags \
 ", mode_t " mode );
+.PP
+/* Documented separately, in \fBopenat2\fP(2). */
+.BI "int openat2(int " dirfd ", const char *" pathname ", \
+const struct open_how *" how ", size_t " size ");
 .fi
 .PP
 .in -4n
@@ -933,6 +937,15 @@ If
 is absolute, then
 .I dirfd
 is ignored.
+.SS openat2(2)
+The
+.BR openat2 (2)
+system call is an extension of
+.BR openat (),
+with a superset of features. To avoid making this man page too long, the
+description of
+.BR openat2 (2)
+and its features is documented in a separate man page.
 .SH RETURN VALUE
 .BR open (),
 .BR openat (),
@@ -1220,6 +1233,9 @@ SVr4, 4.3BSD, POSIX.1-2001, POSIX.1-2008.
 .BR openat ():
 POSIX.1-2008.
 .PP
+.BR openat2 (2)
+is Linux-specific.
+.PP
 The
 .BR O_DIRECT ,
 .BR O_NOATIME ,
@@ -1778,6 +1794,7 @@ is ignored).
 .BR mknod (2),
 .BR mmap (2),
 .BR mount (2),
+.BR openat2 (2),
 .BR open_by_handle_at (2),
 .BR read (2),
 .BR socket (2),
diff --git a/man2/openat2.2 b/man2/openat2.2
new file mode 100644
index 000000000000..6ec87a040f37
--- /dev/null
+++ b/man2/openat2.2
@@ -0,0 +1,471 @@
+.\" Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.TH OPENAT2 2 2019-12-20 "Linux" "Linux Programmer's Manual"
+.SH NAME
+openat2 \- open and possibly create a file (extended)
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <sys/stat.h>
+.B #include <fcntl.h>
+.B #include <openat2.h>
+.PP
+.BI "int openat2(int " dirfd ", const char *" pathname ", \
+struct open_how *" how ", size_t " size ");
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call; see NOTES.
+.SH DESCRIPTION
+The
+.BR openat2 ()
+system call opens the file specified by
+.IR pathname .
+If the specified file does not exist, it may optionally (if
+.B O_CREAT
+is specified in
+.IR how.flags )
+be created by
+.BR openat2() .
+.PP
+As with
+.BR openat (2),
+if
+.I pathname
+is relative, then it is interpreted relative to the
+directory referred to by the file descriptor
+.I dirfd
+(or the current working directory of the calling process, if
+.I dirfd
+is the special value
+.BR AT_FDCWD .)
+If
+.I pathname
+is absolute, then
+.I dirfd
+is ignored (unless
+.I how.resolve
+contains
+.BR RESOLVE_IN_ROOT,
+in which case
+.I pathname
+is resolved relative to
+.IR dirfd .)
+.PP
+The
+.BR openat2 ()
+system call is an extension of
+.BR openat (2)
+and provides a superset of its functionality.
+Rather than taking a single
+.I flag
+argument, an extensible structure (\fIhow\fP) is passed instead to allow for
+future extensions.
+.I size
+must be set to
+.IR "sizeof(struct open_how)" ,
+to facilitate future extensions (see the "Extensibility" section of the
+.B NOTES
+for more detail on how extensions are handled.)
+
+.SS The open_how structure
+The following structure indicates how
+.I pathname
+should be opened, and acts as a superset of the
+.IR flag " and " mode
+arguments to
+.BR openat (2).
+.PP
+.in +4n
+.EX
+struct open_how {
+    u64 flags;    /* O_* flags. */
+    u64 mode;     /* Mode for O_{CREAT,TMPFILE}. */
+    u64 resolve;  /* RESOLVE_* flags. */
+    /* ... */
+};
+.EE
+.in
+.PP
+Any future extensions to
+.BR openat2 ()
+will be implemented as new fields appended to the above structure, with the
+zero value of the new fields acting as though the extension were not present.
+Therefore, users must ensure that they zero-fill this structure on
+initialisation (see the "Extensibility" section of
+the
+.B NOTES
+for more detail on why this is necessary.)
+.PP
+The meaning of each field is as follows:
+.RS
+
+.I flags
+.RS
+The file creation and status flags to use for this operation.
+All of the
+.B O_*
+flags defined for
+.BR openat (2)
+are valid
+.BR openat2 ()
+flag values.
+
+Unlike
+.BR openat (2),
+it is an error to provide
+.BR openat2 ()
+unknown or conflicting flags in
+.IR flags .
+.RE
+
+.IR mode
+.RS
+File mode for the new file, with identical semantics to the
+.I mode
+argument to
+.BR openat (2).
+
+Unlike
+.BR openat (2),
+it is an error to provide
+.BR openat2 ()
+with a
+.I mode
+which contains bits other than
+.IR 0777 ,
+or to provide
+.BR openat2 ()
+a non-zero
+.IR mode " if " flags
+does not contain
+.BR O_CREAT " or " O_TMPFILE .
+.RE
+
+.I resolve
+.RS
+Change how
+.B all
+components of
+.I pathname
+will be resolved (see
+.BR path_resolution (7)
+for background information.)
+The primary use case for these flags is to allow trusted programs to restrict
+how untrusted paths (or paths inside untrusted directories) are resolved.
+The full list of
+.I resolve
+flags is given below.
+.TP
+.B RESOLVE_NO_XDEV
+Disallow traversal of mount points during path resolution (including all bind
+mounts).
+
+Users of this flag are encouraged to make its use configurable (unless it is
+used for a specific security purpose), as bind mounts are very widely used by
+end-users.
+Setting this flag indiscrimnately for all uses of
+.IR openat2 ()
+may result in spurious errors on previously-functional systems.
+.TP
+.B RESOLVE_NO_SYMLINKS
+Disallow resolution of symbolic links during path resolution.
+This option implies
+.BR RESOLVE_NO_MAGICLINKS .
+
+If the trailing component is a symbolic link, and
+.I flags
+contains both
+.BR O_PATH " and " O_NOFOLLOW ","
+then an
+.B O_PATH
+file descriptor referencing the symbolic link will be returned.
+
+Users of this flag are encouraged to make its use configurable (unless it is
+used for a specific security purpose), as symbolic links are very widely used
+by end-users.
+Setting this flag indiscrimnately for all uses of
+.IR openat2 ()
+may result in spurious errors on previously-functional systems.
+.TP
+.B RESOLVE_NO_MAGICLINKS
+Disallow all magic link resolution during path resolution.
+
+If the trailing component is a magic link, and
+.I flags
+contains both
+.BR O_PATH " and " O_NOFOLLOW ","
+then an
+.B O_PATH
+file descriptor referencing the magic link will be returned.
+
+Magic-links are symbolic link-like objects that are most notably found in
+.BR proc (5)
+(examples include
+.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
+Due to the potential danger of unknowingly opening these magic links, it may be
+preferable for users to disable their resolution entirely (see
+.BR symbolic link (7)
+for more details.)
+.TP
+.B RESOLVE_BENEATH
+Do not permit the path resolution to succeed if any component of the resolution
+is not a descendant of the directory indicated by
+.IR dirfd .
+This results in absolute symbolic links (and absolute values of
+.IR pathname )
+to be rejected.
+
+Currently, this flag also disables magic link resolution.
+However, this may change in the future.
+The caller should explicitly specify
+.B RESOLVE_NO_MAGICLINKS
+to ensure that magic links are not resolved.
+
+.TP
+.B RESOLVE_IN_ROOT
+Treat
+.I dirfd
+as the root directory while resolving
+.I pathname
+(as though the user called
+.BR chroot (2)
+with
+.IR dirfd
+as the argument.)
+Absolute symbolic links and ".." path components will be scoped to
+.IR dirfd .
+If
+.I pathname
+is an absolute path, it is also treated relative to
+.IR dirfd .
+
+However, unlike
+.BR chroot (2)
+(which changes the filesystem root permanently for a process),
+.B RESOLVE_IN_ROOT
+allows a program to efficiently restrict path resolution for only certain
+operations.
+It also has several hardening features (such detecting escape attempts during
+.I ".."
+resolution) which
+.BR chroot (2)
+does not.
+
+Currently, this flag also disables magic link resolution.
+However, this may change in the future.
+The caller should explicitly specify
+.B RESOLVE_NO_MAGICLINKS
+to ensure that magic links are not resolved.
+.PP
+It is an error to provide
+.BR openat2 ()
+unknown flags in
+.IR resolve .
+.RE
+.RE
+
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, -1 is returned, and
+.I errno
+is set appropriately.
+
+.SH ERRORS
+The set of errors returned by
+.BR openat2 ()
+includes all of the errors returned by
+.BR openat (2),
+as well as the following additional errors:
+.TP
+.B EINVAL
+An unknown flag or invalid value was specified in
+.IR how .
+.TP
+.B EINVAL
+.I mode
+is non-zero, but
+.I flags
+does not contain
+.BR O_CREAT " or " O_TMPFILE .
+.TP
+.B EINVAL
+.I size
+was smaller than any known version of
+.IR "struct open_how" .
+.TP
+.B E2BIG
+An extension was specified in
+.IR how ,
+which the current kernel does not support (see the "Extensibility" section of
+the
+.B NOTES
+for more detail on how extensions are handled.)
+.TP
+.B EAGAIN
+.I resolve
+contains either
+.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
+and the kernel could not ensure that a ".." component didn't escape (due to a
+race condition or potential attack.)
+Callers may choose to retry the
+.BR openat2 ()
+call.
+.TP
+.B EXDEV
+.I resolve
+contains either
+.BR RESOLVE_IN_ROOT " or " RESOLVE_BENEATH ,
+and an escape from the root during path resolution was detected.
+
+.TP
+.B EXDEV
+.I resolve
+contains
+.BR RESOLVE_NO_XDEV ,
+and a path component attempted to cross a mount point.
+
+.TP
+.B ELOOP
+.I resolve
+contains
+.BR RESOLVE_NO_SYMLINKS ,
+and one of the path components was a symbolic link (or magic link).
+.TP
+.B ELOOP
+.I resolve
+contains
+.BR RESOLVE_NO_MAGICLINKS ,
+and one of the path components was a magic link.
+
+.SH VERSIONS
+.BR openat2 ()
+first appeared in Linux 5.6.
+
+.SH CONFORMING TO
+This system call is Linux-specific.
+
+The semantics of
+.B RESOLVE_BENEATH
+were modelled after FreeBSD's
+.BR O_BENEATH .
+
+.SH NOTES
+Glibc does not provide a wrapper for this system call; call it using
+.BR syscall (2).
+
+.SS Extensibility
+In order to allow for
+.I struct open_how
+to be extended in future kernel revisions,
+.BR openat2 ()
+requires userspace to specify the size of
+.I struct open_how
+structure they are passing.
+By providing this information, it is possible for
+.BR openat2 ()
+to provide both forwards- and backwards-compatibility \(em with
+.I size
+acting as an implicit version number (because new extension fields will always
+be appended, the size will always increase.)
+This extensibility design is very similar to other system calls such as
+.BR perf_setattr "(2), " perf_event_open "(2), and " clone (3).
+
+If we let
+.I usize
+be the size of the structure according to userspace and
+.I ksize
+be the size of the structure which the kernel supports, then there are only
+three cases to consider:
+
+.RS
+.IP * 3
+If
+.IR ksize " equals " usize ,
+then there is no version mismatch and
+.I how
+can be used verbatim.
+.IP *
+If
+.IR ksize " is larger than " usize ,
+then there are some extensions the kernel supports which the userspace program
+is unaware of.
+Because all extensions must have their zero values be a no-op, the kernel
+treats all of the extension fields not set by userspace to have zero values.
+This provides backwards-compatibility.
+.IP *
+If
+.IR ksize " is smaller than " usize ,
+then there are some extensions which the userspace program is aware of but the
+kernel does not support.
+Because all extensions must have their zero values be a no-op, the kernel can
+safely ignore the unsupported extension fields if they are all-zero.
+If any unsupported extension fields are non-zero, then -1 is returned and
+.I errno
+is set to
+.BR E2BIG .
+This provides forwards-compatibility.
+.RE
+.PP
+Therefore most userspace programs will not need to have any special handling
+of extensions.
+.PP
+However, because the definition of
+.I struct open_how
+may change in the future (with new fields being added when system headers are
+updated), userspace programs should zero-fill
+.I struct open_how
+to ensure that re-compiling the program with new headers will not result in
+spurious errors at runtime. The simplest way is to use a designated
+initialiser:
+.PP
+.in +4n
+.EX
+struct open_how how = { .flags = O_RDWR, .resolve = RESOLVE_IN_ROOT };
+.EE
+.in
+.PP
+or explicitly using something like
+.BR memset (3):
+.PP
+.in +4n
+.EX
+struct open_how how;
+memset(&how, 0, sizeof(how));
+how.flags = O_RDWR;
+how.resolve = RESOLVE_IN_ROOT;
+.EE
+.in
+.PP
+If a userspace program wishes to determine what extensions the running kernel
+supports, they may conduct a binary search on
+.IR size
+with a structure which has every byte non-zero (to find the largest value which
+doesn't produce an error of
+.BR E2BIG .)
+
+.SH SEE ALSO
+.BR openat (2),
+.BR path_resolution (7),
+.BR symlink (7)
-- 
2.25.0

