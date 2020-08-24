Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D324FDB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHXMZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 08:25:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726972AbgHXMZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598271912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi1whHHeAhV121Ie5VqRINib5kFTKjdPsVRsKEDgwWg=;
        b=MTCtZ0PWzyZOeboJMRNqAdGOv0y4TD6u4WpRE6twAR5/bkjeLcbA35UJM6Y9rqe5n0Md9O
        DLAnHxPEo+79toRGXN8Kc5WlnfP6wiNVeeILx7aE02pydfpX2PE8vsOGIDm6IZu16zTMYB
        Ow3fFTZ3kItECkeVzHPtv9VfvQktOng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ORbl5fBGN_y1HB3YkgKZhQ-1; Mon, 24 Aug 2020 08:25:08 -0400
X-MC-Unique: ORbl5fBGN_y1HB3YkgKZhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C1F318A2245;
        Mon, 24 Aug 2020 12:25:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAA9C5D9E4;
        Mon, 24 Aug 2020 12:25:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 13:25:05 +0100
Message-ID: <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
In-Reply-To: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a manual page to document the fsopen() and fsmount() system calls.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man2/fsmount.2 |    1 
 man2/fsopen.2  |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)
 create mode 100644 man2/fsmount.2
 create mode 100644 man2/fsopen.2

diff --git a/man2/fsmount.2 b/man2/fsmount.2
new file mode 100644
index 000000000..2bf59fc3e
--- /dev/null
+++ b/man2/fsmount.2
@@ -0,0 +1 @@
+.so man2/fsopen.2
diff --git a/man2/fsopen.2 b/man2/fsopen.2
new file mode 100644
index 000000000..1d1bba238
--- /dev/null
+++ b/man2/fsopen.2
@@ -0,0 +1,245 @@
+'\" t
+.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
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
+.TH FSOPEN 2 2020-08-07 "Linux" "Linux Programmer's Manual"
+.SH NAME
+fsopen, fsmount \- Filesystem parameterisation and mount creation
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <sys/mount.h>
+.B #include <unistd.h>
+.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
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
+.PP
+Once the creation command has been successfully run on a context, the context
+will not accept further configuration.  At
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
+To use either of these calls, the caller requires the appropriate privilege
+(Linux: the
+.B CAP_SYS_ADMIN
+capability).
+.PP
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
+The filesystem
+.I fsname
+is not available in the kernel.
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
+move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.in
+.PP
+Here, an ext4 context is created first and attached to sfd.  The context is
+then told where its source will be, given a bunch of options and a superblock
+record object is then created.  Then fsmount() is called to create a mount
+object and
+.BR move_mount (2)
+is called to attach it to its intended mountpoint.
+.PP
+And here's an example of mounting from an NFS server and setting a Smack
+security module label on it too:
+.PP
+.in +4n
+.nf
+sfd = fsopen("nfs", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "source", "example.com:/pub", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
+fsconfig(sfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
+fsconfig(sfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
+fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mfd = fsmount(sfd, 0, MS_NODEV);
+move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.fi
+.in
+.PP
+.SH SEE ALSO
+.BR mountpoint (1),
+.BR fsconfig (2),
+.BR fspick (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR umount (2),
+.BR mount_namespaces (7),
+.BR path_resolution (7),
+.BR mount (8),
+.BR umount (8)


