Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1210E155D17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBGRmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:42:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBGRmu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:42:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4382AFF6;
        Fri,  7 Feb 2020 17:42:45 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-man@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 2/2] Add manpage for fsopen(2), fspick(2) and fsmount(2)
Date:   Fri,  7 Feb 2020 18:42:36 +0100
Message-Id: <20200207174236.18882-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207174236.18882-1-pvorel@suse.cz>
References: <20200207174236.18882-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add a manual page to document the fsopen(), fspick() and fsmount() system
calls.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

* man2/fsmount.2
maybe document these flags?
#define MOUNT_ATTR_RDONLY      0x00000001 /* Mount read-only */
#define MOUNT_ATTR_NOSUID      0x00000002 /* Ignore suid and sgid bits */
#define MOUNT_ATTR_NODEV       0x00000004 /* Disallow access to device special files */
#define MOUNT_ATTR_NOEXEC      0x00000008 /* Disallow program execution */
#define MOUNT_ATTR__ATIME      0x00000070 /* Setting on how atime should be updated */
#define MOUNT_ATTR_RELATIME    0x00000000 /* - Update atime relative to mtime/ctime. */
#define MOUNT_ATTR_NOATIME     0x00000010 /* - Do not update access times. */
#define MOUNT_ATTR_STRICTATIME 0x00000020 /* - Always perform atime updates */
#define MOUNT_ATTR_NODIRATIME  0x00000080 /* Do not update directory access times */

* man2/fsopen.2
and these?
enum fs_context_phase {
	FS_CONTEXT_CREATE_PARAMS,	/* Loading params for sb creation */
	FS_CONTEXT_CREATING,		/* A superblock is being created */
	FS_CONTEXT_AWAITING_MOUNT,	/* Superblock created, awaiting fsmount() */
	FS_CONTEXT_AWAITING_RECONF,	/* Awaiting initialisation for reconfiguration */
	FS_CONTEXT_RECONF_PARAMS,	/* Loading params for reconfiguration */
	FS_CONTEXT_RECONFIGURING,	/* Reconfiguring the superblock */
	FS_CONTEXT_FAILED,		/* Failed to correctly transition a context */
};


Kind regards,
Petr

 man2/fsconfig.2 | 282 ++++++++++++++++++++++++++++++++++++++++++++++++
 man2/fsmount.2  |   1 +
 man2/fsopen.2   | 256 +++++++++++++++++++++++++++++++++++++++++++
 man2/fspick.2   | 195 +++++++++++++++++++++++++++++++++
 4 files changed, 734 insertions(+)
 create mode 100644 man2/fsconfig.2
 create mode 100644 man2/fsmount.2
 create mode 100644 man2/fsopen.2
 create mode 100644 man2/fspick.2

diff --git a/man2/fsconfig.2 b/man2/fsconfig.2
new file mode 100644
index 000000000..93b82997a
--- /dev/null
+++ b/man2/fsconfig.2
@@ -0,0 +1,282 @@
+'\" t
+.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
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
+.\"
+.TH FSCONFIG 2 2019-10-10 "Linux" "Linux Programmer's Manual"
+.SH NAME
+fsconfig \- Filesystem parameterisation
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.br
+.B #include <sys/mount.h>
+.br
+.B #include <unistd.h>
+.br
+.B #include <sys/mount.h>
+.PP
+.BI "int fsconfig(int *" fd ", unsigned int " cmd ", const char *" key ,
+.br
+.BI "             const void __user *" value ", int " aux ");"
+.br
+.BI
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call.
+.SH DESCRIPTION
+.PP
+.BR fsconfig ()
+is used to supply parameters to and issue commands against a filesystem
+configuration context as set up by
+.BR fsopen (2)
+or
+.BR fspick (2).
+The context is supplied attached to the file descriptor specified by
+.I fd
+argument.
+.PP
+The
+.I cmd
+argument indicates the command to be issued, where some of the commands simply
+supply parameters to the context.  The meaning of
+.IR key ", " value " and " aux
+are command-dependent; unless required for the command, these should be set to
+NULL or 0.
+.PP
+The available commands are:
+.TP
+.B FSCONFIG_SET_FLAG
+Set the parameter named by
+.IR key
+to true.  This may incur error
+.B EINVAL
+if the parameter requires an argument.
+.TP
+.B FSCONFIG_SET_STRING
+Set the parameter named by
+.I key
+to a string.  This may incur error
+.B EINVAL
+if the parser doesn't want a parameter here, wants a non-string or the string
+cannot be interpreted appropriately.
+.I value
+points to a NUL-terminated string.
+.TP
+.B FSCONFIG_SET_BINARY
+Set the parameter named by
+.I key
+to be a binary blob argument.  This may cause
+.B EINVAL
+to be returned if the filesystem parser isn't expecting a binary blob and it
+can't be converted to something usable.
+.I value
+points to the data and
+.I aux
+indicates the size of the data.
+.TP
+.B FSCONFIG_SET_PATH
+Set the parameter named by
+.I key
+to the object at the provided path.
+.I value
+should point to a NULL-terminated pathname string and aux may indicate
+.B AT_FDCWD
+or a file descriptor indicating a directory from which to begin a relative
+pathwalk.  This may return any errors incurred by the pathwalk and may return
+.B EINVAL
+if the parameter isn't expecting a path.
+.IP
+Note that FSCONFIG_SET_STRING can be used instead, implying AT_FDCWD.
+.TP
+.B FSCONFIG_SET_PATH_EMPTY
+As FSCONFIG_SET_PATH, but with
+.B AT_EMPTY_PATH
+applied to the pathwalk.
+.TP
+.B FSCONFIG_SET_FD
+Set the parameter named by
+.I key
+to the file descriptor specified by
+.IR aux .
+This will incur
+.B EINVAL
+if the parameter doesn't expect a file descriptor or
+.B EBADF
+if the file descriptor is invalid.
+.IP
+Note that FSCONFIG_SET_STRING can be used instead with the file descriptor
+passed as a decimal string.
+.TP
+.B FSCONFIG_CMD_CREATE
+This command causes the filesystem to take the parameters set in the context
+and to try to create filesystem representation in the kernel.  If it can share
+an existing one, it may do that instead if the filesystem type and parameters
+permit that.  This is intended for use with
+.BR fsopen (2).
+.TP
+.B FSCONFIG_CMD_RECONFIGURE
+This command causes the filesystem to apply the parameters set in the context
+to an already existing filesystem representation in memory and to alter it.
+This is intended for use with
+.BR fspick (2),
+but may also by used against the context created by
+.BR fsopen()
+after
+.BR fsmount (2)
+has been called on it.
+
+.\"________________________________________________________
+.SH EXAMPLES
+.PP
+.in +4n
+.nf
+fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+
+fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
+
+fsconfig(sfd, FSCONFIG_SET_BINARY, "ms_pac", pac_buffer, pac_size);
+
+fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "/dev/sdd4", AT_FDCWD);
+
+dirfd = open("/dev/", O_PATH);
+fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "sdd4", dirfd);
+
+fd = open("/overlays/mine/", O_PATH);
+fsconfig(sfd, FSCONFIG_SET_PATH_EMPTY, "lower_dir", "", fd);
+
+pipe(pipefds);
+fsconfig(sfd, FSCONFIG_SET_FD, "fd", NULL, pipefds[1]);
+.fi
+.in
+.PP
+
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.SH RETURN VALUE
+On success, the function returns 0.  On error, \-1 is returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+The error values given below result from filesystem type independent
+errors.
+Each filesystem type may have its own special errors and its
+own special behavior.
+See the Linux kernel source code for details.
+.TP
+.B EACCES
+A component of a path was not searchable.
+(See also
+.BR path_resolution (7).)
+.TP
+.B EACCES
+Mounting a read-only filesystem was attempted without specifying the
+.RB ' ro '
+parameter.
+.TP
+.B EACCES
+A specified block device is located on a filesystem mounted with the
+.B MS_NODEV
+option.
+.\" mtk: Probably: write permission is required for MS_BIND, with
+.\" the error EPERM if not present; CAP_DAC_OVERRIDE is required.
+.TP
+.B EBADF
+The file descriptor given by
+.I fd
+or possibly by
+.I aux
+(depending on the command) is invalid.
+.TP
+.B EBUSY
+The context attached to
+.I fd
+is in the wrong state for the given command.
+.TP
+.B EBUSY
+The filesystem representation cannot be reconfigured read-only because it still
+holds files open for writing.
+.TP
+.B EFAULT
+One of the pointer arguments points outside the user address space.
+.TP
+.B EINVAL
+.I fd
+does not refer to a filesystem configuration context.
+.TP
+.B EINVAL
+One of the source parameters referred to an invalid superblock.
+.TP
+.B ELOOP
+Too many links encountered during pathname resolution.
+.TP
+.B ENAMETOOLONG
+A path name was longer than
+.BR MAXPATHLEN .
+.TP
+.B ENOENT
+A pathname was empty or had a nonexistent component.
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the call.
+.TP
+.B ENOTBLK
+Once of the parameters does not refer to a block device (and a device was
+required).
+.TP
+.B ENOTDIR
+.IR pathname ,
+or a prefix of
+.IR source ,
+is not a directory.
+.TP
+.B EOPNOTSUPP
+The command given by
+.I cmd
+was not valid.
+.TP
+.B ENXIO
+The major number of a block device parameter is out of range.
+.TP
+.B EPERM
+The caller does not have the required privileges.
+.SH CONFORMING TO
+These functions are Linux-specific and should not be used in programs intended
+to be portable.
+.SH VERSIONS
+.BR fsconfig ()
+was added to Linux in kernel 5.2.
+.SH NOTES
+Glibc does not (yet) provide a wrapper for the
+.BR fspick ()
+system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR mountpoint (1),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount_namespaces (7),
+.BR path_resolution (7)
diff --git a/man2/fsmount.2 b/man2/fsmount.2
new file mode 100644
index 000000000..2bf59fc3e
--- /dev/null
+++ b/man2/fsmount.2
@@ -0,0 +1 @@
+.so man2/fsopen.2
diff --git a/man2/fsopen.2 b/man2/fsopen.2
new file mode 100644
index 000000000..6bed60cce
--- /dev/null
+++ b/man2/fsopen.2
@@ -0,0 +1,256 @@
+'\" t
+.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
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
+.\"
+.TH FSOPEN 2 2019-10-10 "Linux" "Linux Programmer's Manual"
+.SH NAME
+fsopen, fsmount \- Filesystem parameterisation and mount creation
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.br
+.B #include <sys/mount.h>
+.br
+.B #include <unistd.h>
+.br
+.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
+.br
+.BR "#include <sys/mount.h>       "
+.PP
+.BI "int fsopen(const char *" fsname ", unsigned int " flags );
+.PP
+.BI "int fsmount(int " fd ", unsigned int " flags ", unsigned int " mount_attrs );
+.fi
+.PP
+.IR Note :
+There are no glibc wrappers for these system calls.
+.SH DESCRIPTION
+.PP
+.BR fsopen ()
+creates a blank filesystem configuration context within the kernel for the
+filesystem named in the
+.I fsname
+parameter, puts it into creation mode and attaches it to a file descriptor,
+which it then returns.  The file descriptor can be marked close-on-exec by
+setting
+.B FSOPEN_CLOEXEC
+in
+.IR flags .
+.PP
+After calling fsopen(), the file descriptor should be passed to the
+.BR fsconfig (2)
+system call, using that to specify the desired filesystem and security
+parameters.
+.PP
+When the parameters are all set, the
+.BR fsconfig ()
+system call should then be called again with
+.B FSCONFIG_CMD_CREATE
+as the command argument to effect the creation.
+.RS
+.PP
+.BR "[!]\ NOTE" :
+Depending on the filesystem type and parameters, this may rather share an
+existing in-kernel filesystem representation instead of creating a new one.
+In such a case, the parameters specified may be discarded or may overwrite the
+parameters set by a previous mount - at the filesystem's discretion.
+.RE
+.PP
+The file descriptor also serves as a channel by which more comprehensive error,
+warning and information messages may be retrieved from the kernel using
+.BR read (2).
+
+.PP
+Once the creation command has been successfully run on a context, the context
+is switched into need-mount mode which prevents further configuration.  At
+this point,
+.BR fsmount ()
+should be called to create a mount object.
+.PP
+.BR fsmount ()
+takes the file descriptor returned by
+.BR fsopen ()
+and creates a mount object for the filesystem root specified there.  The
+attributes of the mount object are set from the
+.I mount_attrs
+parameter.  The attributes specify the propagation and mount restrictions to
+be applied to accesses through this mount.
+.PP
+The mount object is then attached to a new file descriptor that looks like one
+created by
+.BR open "(2) with " O_PATH " or " open_tree (2).
+This can be passed to
+.BR move_mount (2)
+to attach the mount object to a mountpoint, thereby completing the process.
+.PP
+The file descriptor returned by fsmount() is marked close-on-exec if
+FSMOUNT_CLOEXEC is specified in
+.IR flags .
+.PP
+After fsmount() has completed, the context created by fsopen() is reset and
+moved to reconfiguration state, allowing the new superblock to be
+reconfigured.  See
+.BR fspick (2)
+for details.
+.PP
+
+.\"________________________________________________________
+.SS Message Retrieval Interface
+The context file descriptor may be queried for message strings at any time by
+calling
+.BR read (2)
+on the file descriptor.  This will return formatted messages that are prefixed
+to indicate their class:
+.TP
+\fB"e <message>"\fP
+An error message string was logged.
+.TP
+\fB"i <message>"\fP
+An informational message string was logged.
+.TP
+\fB"w <message>"\fP
+An warning message string was logged.
+.PP
+Messages are removed from the queue as they're read.
+
+.\"________________________________________________________
+.SH EXAMPLES
+To illustrate the process, here's an example whereby this can be used to mount
+an ext4 filesystem on /dev/sdb1 onto /mnt.
+.PP
+.in +4n
+.nf
+sfd = fsopen("ext4", FSOPEN_CLOEXEC);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sdb1", 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "user_attr", NULL, 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0);
+fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
+move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.in
+.PP
+Here, an ext4 context is created first and attached to sfd.  This is then told
+where its source will be, given a bunch of options and created.  Then
+fsmount() is called to create a mount object and
+.BR move_mount (2)
+is called to attach it to its intended mountpoint.
+.PP
+And here's an example of mounting from an NFS server and setting a Smack
+security module label on it too:
+.PP
+.in +4n
+.nf
+sfd = fsopen("nfs", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "source", "example.com/pub/linux", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
+fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mfd = fsmount(sfd, 0, MS_NODEV);
+move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.in
+.PP
+
+
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.SH RETURN VALUE
+On success, both functions return a file descriptor.  On error, \-1 is
+returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+The error values given below result from filesystem type independent
+errors.
+Each filesystem type may have its own special errors and its
+own special behavior.
+See the Linux kernel source code for details.
+.TP
+.B EBUSY
+The context referred to by
+.I fd
+is not in the right state to be used by
+.BR fsmount ().
+.TP
+.B EFAULT
+One of the pointer arguments points outside the user address space.
+.TP
+.B EINVAL
+.I flags
+had an invalid flag set.
+.TP
+.B EINVAL
+.I mount_attrs,
+includes invalid
+.BR MOUNT_ATTR_*
+flags.
+.TP
+.B EMFILE
+The system has too many open files to create more.
+.TP
+.B ENFILE
+The process has too many open files to create more.
+.TP
+.B ENODEV
+Filesystem
+.I fsname
+not configured in the kernel.
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the call.
+.TP
+.B EPERM
+The caller does not have the required privileges.
+.SH CONFORMING TO
+These functions are Linux-specific and should not be used in programs intended
+to be portable.
+.SH VERSIONS
+.BR fsopen "(), and " fsmount ()
+were added to Linux in kernel 5.2.
+.SH NOTES
+Glibc does not (yet) provide a wrapper for the
+.BR fsopen "() or " fsmount "()"
+system calls; call them using
+.BR syscall (2).
+.SH SEE ALSO
+.BR mountpoint (1),
+.BR fsconfig (2),
+.BR fspick (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR umount (2),
+.BR mount_namespaces (7),
+.BR path_resolution (7),
+.BR findmnt (8),
+.BR lsblk (8),
+.BR mount (8),
+.BR umount (8)
diff --git a/man2/fspick.2 b/man2/fspick.2
new file mode 100644
index 000000000..02f0ccf48
--- /dev/null
+++ b/man2/fspick.2
@@ -0,0 +1,195 @@
+'\" t
+.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
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
+.\"
+.TH FSPICK 2 2019-10-10 "Linux" "Linux Programmer's Manual"
+.SH NAME
+fspick \- Select filesystem for reconfiguration
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.br
+.B #include <sys/mount.h>
+.br
+.B #include <unistd.h>
+.br
+.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
+.PP
+.BI "int fspick(int " dirfd ", const char *" pathname ", unsigned int " flags );
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call.
+.SH DESCRIPTION
+.PP
+.BR fspick ()
+creates a new filesystem configuration context within the kernel and attaches a
+pre-existing superblock to it so that it can be reconfigured (similar to
+.BR mount (8)
+with the "-o remount" option).  The configuration context is marked as being in
+reconfiguration mode and attached to a file descriptor, which is returned to
+the caller.  This can be marked close-on-exec by setting
+.B FSPICK_CLOEXEC
+in
+.IR flags .
+.PP
+The target is whichever superblock backs the object determined by
+.IR dfd ", " pathname " and " flags .
+The following can be set in
+.I flags
+to control the pathwalk to that object:
+.TP
+.B FSPICK_SYMLINK_NOFOLLOW
+Don't follow symbolic links in the terminal component of the path.
+.TP
+.B FSPICK_NO_AUTOMOUNT
+Don't follow automounts in the terminal component of the path.
+.TP
+.B FSPICK_EMPTY_PATH
+Allow an empty string to be specified as the pathname.  This allows
+.I dirfd
+to specify a path exactly.
+.PP
+After calling fspick(), the file descriptor should be passed to the
+.BR fsconfig (2)
+system call, using that to specify the desired changes to filesystem and
+security parameters.
+.PP
+When the parameters are all set, the
+.BR fsconfig ()
+system call should then be called again with
+.B FSCONFIG_CMD_RECONFIGURE
+as the command argument to effect the reconfiguration.
+.PP
+After the reconfiguration has taken place, the context is wiped clean (apart
+from the superblock attachment, which remains) and can be reused to make
+another reconfiguration.
+.PP
+The file descriptor also serves as a channel by which more comprehensive error,
+warning and information messages may be retrieved from the kernel using
+.BR read (2).
+
+
+.\"________________________________________________________
+.SS Message Retrieval Interface
+The context file descriptor may be queried for message strings at any time by
+calling
+.BR read (2)
+on the file descriptor.  This will return formatted messages that are prefixed
+to indicate their class:
+.TP
+\fB"e <message>"\fP
+An error message string was logged.
+.TP
+\fB"i <message>"\fP
+An informational message string was logged.
+.TP
+\fB"w <message>"\fP
+An warning message string was logged.
+.PP
+Messages are removed from the queue as they're read and the queue has a limited
+depth, so it's possible for some to get lost.
+
+.\"________________________________________________________
+.SH EXAMPLES
+To illustrate the process, here's an example whereby this can be used to
+reconfigure a filesystem:
+.PP
+.in +4n
+.nf
+sfd = fspick(AT_FDCWD, "/mnt", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
+fsconfig(sfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
+.fi
+.in
+.PP
+
+
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.SH RETURN VALUE
+On success, the function returns a file descriptor.  On error, \-1 is returned,
+and
+.I errno
+is set appropriately.
+.SH ERRORS
+The error values given below result from filesystem type independent
+errors.
+Each filesystem type may have its own special errors and its
+own special behavior.
+See the Linux kernel source code for details.
+.TP
+.B EACCES
+A component of a path was not searchable.
+(See also
+.BR path_resolution (7).)
+.TP
+.B EFAULT
+.I pathname
+points outside the user address space.
+.TP
+.B EINVAL
+.I flags
+includes an undefined value.
+.TP
+.B ELOOP
+Too many links encountered during pathname resolution.
+.TP
+.B EMFILE
+The system has too many open files to create more.
+.TP
+.B ENFILE
+The process has too many open files to create more.
+.TP
+.B ENAMETOOLONG
+A pathname was longer than
+.BR MAXPATHLEN .
+.TP
+.B ENOENT
+A pathname was empty or had a nonexistent component.
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the call.
+.TP
+.B EPERM
+The caller does not have the required privileges.
+.SH CONFORMING TO
+These functions are Linux-specific and should not be used in programs intended
+to be portable.
+.SH VERSIONS
+.BR fsopen "(), " fsmount "() and " fspick ()
+were added to Linux in kernel 5.2.
+.SH NOTES
+Glibc does not (yet) provide a wrapper for the
+.BR fspick "()"
+system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR mountpoint (1),
+.BR fsconfig (2),
+.BR fsopen (2),
+.BR path_resolution (7),
+.BR mount (8)
-- 
2.24.1

