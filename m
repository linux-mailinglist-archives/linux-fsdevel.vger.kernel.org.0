Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C230CA38E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH3OPy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 10:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfH3OPy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:15:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45A2E1089049;
        Fri, 30 Aug 2019 14:15:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 514345C549;
        Fri, 30 Aug 2019 14:15:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: watch_devices(2) manpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4595.1567174549.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 30 Aug 2019 15:15:49 +0100
Message-ID: <4596.1567174549@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 30 Aug 2019 14:15:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'\" t
.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.TH WATCH_DEVICES 2 2019-08-29 "Linux" "Linux Programmer's Manual"
.SH NAME
watch_devices \- Watch for global device notifications
.SH SYNOPSIS
.nf
.B #include <linux/watch_queue.h>
.br
.B #include <unistd.h>
.br
.BI "int watch_devices(int " watch_fd ", int " watch_id ", unsigned int " flags );
.fi
.PP
.IR Note :
There are no glibc wrappers for these system calls.
.SH DESCRIPTION
.PP
.BR watch_devices ()
attaches a watch on the global device notification source to a previously
opened and configured watch queue.  See
.BR watch_queue (7)
for more information on how to set up and use those.
.PP
The global device notification source is provided with events from a number of
sources, including block device errors and USB events.  Each notification type
has a specific format.

.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SS Block Device Notifications
Events on block devices, such as I/O errors are posted to any watching queues.
The message format is:
.PP
.in +4n
.EX
struct block_notification {
	struct watch_notification watch;
	__u64	dev;
	__u64	sector;
};
.EE
.in
.PP
The
.I watch.type
field will be set to
.BR WATCH_TYPE_BLOCK_NOTIFY ,
the
.I watch.subtype
field will contain a constant that indicates the particular event that occurred
and the watch_id passed to watch_devices() will be placed in
.I watch.info
in the ID field.
.PP
.I dev
will contain the major and minor device numbers in
.B dev_t
form and
.I sector
will contain the first sector the notification pertains to.
.PP
The following events are defined:
.PP
.in +4n
.TS
lB l.
NOTIFY_BLOCK_ERROR_TIMEOUT
NOTIFY_BLOCK_ERROR_NO_SPACE
NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT
NOTIFY_BLOCK_ERROR_CRITICAL_TARGET
NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS
NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM
NOTIFY_BLOCK_ERROR_PROTECTION
NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE
NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE
NOTIFY_BLOCK_ERROR_IO
.TE
.in
.PP
All of which indicate error conditions.

.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SS USB Device Notifications
Events on USB devices, such as I/O errors are posted to any watching queues.
The message format is:
.PP
.in +4n
.EX
struct usb_notification {
        struct watch_notification watch;
        __u32   error;
        __u32   reserved;
        __u8    name_len;
        __u8    name[0];
};
.EE
.in
.PP
The
.I watch.type
field will be set to
.BR WATCH_TYPE_USB_NOTIFY ,
the
.I watch.subtype
field will contain a constant that indicates the particular event that occurred
and the watch_id passed to watch_devices() will be placed in
.I watch.info
in the ID field.
.PP
.IR name " and " name_len
indicates the textual name of the USB device that originated the notification.
The name will be truncated to
.B USB_NOTIFICATION_MAX_NAME_LEN
if it is longer than that.
.PP
The following subtypes are currently defined:
.TP
.B NOTIFY_USB_DEVICE_ADD
A new USB device has been plugged in.
.TP
.B NOTIFY_USB_DEVICE_REMOVE
A USB device has been unplugged.
.TP
.B NOTIFY_USB_BUS_ADD
A new USB bus is now available.
.TP
.B NOTIFY_USB_BUS_REMOVE
A USB bus has been removed.
.TP
.B NOTIFY_USB_DEVICE_RESET
A USB device has been reset.
.TP
.B NOTIFY_USB_DEVICE_ERROR
A USB device has generated an error; a suitable error code will have been
placed in
.IR error .


.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success, the function returns 0.  On error, \-1 is returned, and
.I errno
is set appropriately.
.SH ERRORS
The following errors may be returned:
.TP
.B EBADF
.I watch_fd
is an invalid file descriptor.
.TP
.B EBADSLT
The watch does not exist and so cannot be removed.
.TP
.B EBUSY
The source is already attached to the watch device instance specified by
.I watch_fd
and so cannot be added.
.TP
.B EINVAL
.I watch_fd
does not refer to a watch_queue device file.
.TP
.B EINVAL
.IR watch_fd " or " watch_id
is out of range.
.TP
.B EINVAL
Unsupported
.I flags
set.
.TP
.B ENOMEM
Insufficient memory available to allocate a watch record.
.TP
.B EPERM
The caller does not have the required privileges.
.SH CONFORMING TO
These functions are Linux-specific and should not be used in programs intended
to be portable.
.SH VERSIONS
The notification queue driver first appeared in v??? of the Linux kernel.
.SH NOTES
Glibc does not (yet) provide a wrapper for the
.BR watch_devices "()"
system call; call it using
.BR syscall (2).
.SH SEE ALSO
.BR watch_queue (7)
