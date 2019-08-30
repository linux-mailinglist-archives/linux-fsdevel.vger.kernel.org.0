Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB15A38F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfH3OQh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 10:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3OQh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DEE23084031;
        Fri, 30 Aug 2019 14:16:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5148A6012C;
        Fri, 30 Aug 2019 14:16:33 +0000 (UTC)
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
Subject: keyctl_watch_key.3 manpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4676.1567174592.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 30 Aug 2019 15:16:32 +0100
Message-ID: <4677.1567174592@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 30 Aug 2019 14:16:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

.\"
.\" Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
.\" Written by David Howells (dhowells@redhat.com)
.\"
.\" This program is free software; you can redistribute it and/or
.\" modify it under the terms of the GNU General Public License
.\" as published by the Free Software Foundation; either version
.\" 2 of the License, or (at your option) any later version.
.\"
.TH KEYCTL_GRANT_PERMISSION 3 "28 Aug 2019" Linux "Linux Key Management Calls"
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH NAME
keyctl_watch_key \- Watch for changes to a key
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH SYNOPSIS
.nf
.B #include <keyutils.h>
.sp
.BI "long keyctl_watch_key(key_serial_t " key ,
.BI "                      int " watch_queue_fd
.BI "                      int " watch_id ");"
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH DESCRIPTION
.BR keyctl_watch_key ()
sets or removes a watch on
.IR key .
.PP
.I watch_id
specifies the ID for a watch that will be included in notification messages.
It can be between 0 and 255 to add a key; it should be -1 to remove a key.
.PP
.I watch_queue_fd
is a file descriptor attached to a watch_queue device instance.  Multiple
openings of a device provide separate instances.  Each device instance can
only have one watch on any particular key.
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SS Notification Record
.PP
Key-specific notification messages that the kernel emits into the buffer have
the following format:
.PP
.in +4n
.EX
struct key_notification {
	struct watch_notification watch;
	__u32	key_id;
	__u32	aux;
};
.EE
.in
.PP
The
.I watch.type
field will be set to
.B WATCH_TYPE_KEY_NOTIFY
and the
.I watch.subtype
field will contain one of the following constants, indicating the event that
occurred and the watch_id passed to keyctl_watch_key() will be placed in
.I watch.info
in the ID field.  The following events are defined:
.TP
.B NOTIFY_KEY_INSTANTIATED
This indicates that a watched key got instantiated or negatively instantiated.
.I key_id
indicates the key that was instantiated and
.I aux
is unused.
.TP
.B NOTIFY_KEY_UPDATED
This indicates that a watched key got updated or instantiated by update.
.I key_id
indicates the key that was updated and
.I aux
is unused.
.TP
.B NOTIFY_KEY_LINKED
This indicates that a key got linked into a watched keyring.
.I key_id
indicates the keyring that was modified
.I aux
indicates the key that was added.
.TP
.B NOTIFY_KEY_UNLINKED
This indicates that a key got unlinked from a watched keyring.
.I key_id
indicates the keyring that was modified
.I aux
indicates the key that was removed.
.TP
.B NOTIFY_KEY_CLEARED
This indicates that a watched keyring got cleared.
.I key_id
indicates the keyring that was cleared and
.I aux
is unused.
.TP
.B NOTIFY_KEY_REVOKED
This indicates that a watched key got revoked.
.I key_id
indicates the key that was revoked and
.I aux
is unused.
.TP
.B NOTIFY_KEY_INVALIDATED
This indicates that a watched key got invalidated.
.I key_id
indicates the key that was invalidated and
.I aux
is unused.
.TP
.B NOTIFY_KEY_SETATTR
This indicates that a watched key had its attributes (owner, group,
permissions, timeout) modified.
.I key_id
indicates the key that was modified and
.I aux
is unused.
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SS Removal Notification
When a watched key is garbage collected, all of its watches are automatically
destroyed and a notification is delivered to each watcher.  This will normally
be an extended notification of the form:
.PP
.in +4n
.EX
struct watch_notification_removal {
	struct watch_notification watch;
	__u64	id;
};
.EE
.in
.PP
The
.I watch.type
field will be set to
.B WATCH_TYPE_META
and the
.I watch.subtype
field will contain
.BR WATCH_META_REMOVAL_NOTIFICATION .
If the extended notification is given, then the length will be 2 units,
otherwise it will be 1 and only the header will be present.
.PP
The watch_id passed to
.IR keyctl_watch_key ()
will be placed in
.I watch.info
in the ID field.
.PP
If the extension is present,
.I id
will be set to the ID of the destroyed key.
.PP
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success
.BR keyctl_watch_key ()
returns
.B 0 .
On error, the value
.B -1
will be returned and
.I errno
will have been set to an appropriate error.
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH ERRORS
.TP
.B ENOKEY
The specified key does not exist.
.TP
.B EKEYEXPIRED
The specified key has expired.
.TP
.B EKEYREVOKED
The specified key has been revoked.
.TP
.B EACCES
The named key exists, but does not grant
.B view
permission to the calling process.
.TP
.B EBUSY
The specified key already has a watch on it for that device instance (add
only).
.TP
.B EBADSLT
The specified key doesn't have a watch on it (removal only).
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH LINKING
This is a library function that can be found in
.IR libkeyutils .
When linking,
.B \-lkeyutils
should be specified to the linker.
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH SEE ALSO
.ad l
.nh
.BR keyctl (1),
.BR add_key (2),
.BR keyctl (2),
.BR request_key (2),
.BR keyctl (3),
.BR keyrings (7),
.BR keyutils (7)
