Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2F1EBF61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBPwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 11:52:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgFBPwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591113123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XuSKMkbItueamTokOqRg0AWTflYyn03ssDlVOSWZxOY=;
        b=ED6Y6fr4A9LdOQkH6QfWRBVgj/gugEM9vz8qjqUpXoL2N64zgG1ltFfg2I6CFobh1POVhM
        JXe1cXSorusRR0ChiT5ZqqxfWzUiQeCRHjmg+7dLg4+skkXb/f0dZ/TCV8vpkkoEKKZ9Wf
        o3HG6Ulc59PSgKCQGsTuGrZlb4pTjIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-uIOploahNJm0gymkDBmlAQ-1; Tue, 02 Jun 2020 11:51:49 -0400
X-MC-Unique: uIOploahNJm0gymkDBmlAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20D3107ACCA;
        Tue,  2 Jun 2020 15:51:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6CC5C1D6;
        Tue,  2 Jun 2020 15:51:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com,
        kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1503046.1591113104.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Jun 2020 16:51:44 +0100
Message-ID: <1503047.1591113104@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull this, please?  It adds a general notification queue concept
and adds an event source for keys/keyrings, such as linking and unlinking
keys and changing their attributes.

Thanks to Debarshi Ray, we do have a pull request to use this to fix a
problem with gnome-online-accounts - as mentioned last time:

    https://gitlab.gnome.org/GNOME/gnome-online-accounts/merge_requests/47

Without this, g-o-a has to constantly poll a keyring-based kerberos cache
to find out if kinit has changed anything.

[[ With regard to the mount/sb notifications and fsinfo(), Karel Zak and
   Ian Kent have been working on making libmount use them, preparatory to
   working on systemd:

	https://github.com/karelzak/util-linux/commits/topic/fsinfo
	https://github.com/raven-au/util-linux/commits/topic/fsinfo.public

   Development has stalled briefly due to other commitments, so I'm not
   sure I can ask you to pull those parts of the series for now.  Christia=
n
   Brauner would like to use them in lxc, but hasn't started.
   ]]


LSM hooks are included:

 (1) A set of hooks are provided that allow an LSM to rule on whether or
     not a watch may be set.  Each of these hooks takes a different
     "watched object" parameter, so they're not really shareable.  The LSM
     should use current's credentials.  [Wanted by SELinux & Smack]

 (2) A hook is provided to allow an LSM to rule on whether or not a
     particular message may be posted to a particular queue.  This is give=
n
     the credentials from the event generator (which may be the system) an=
d
     the watch setter.  [Wanted by Smack]

I've provided SELinux and Smack with implementations of some of these hook=
s.


WHY
=3D=3D=3D

Key/keyring notifications are desirable because if you have your kerberos
tickets in a file/directory, your Gnome desktop will monitor that using
something like fanotify and tell you if your credentials cache changes.

However, we also have the ability to cache your kerberos tickets in the
session, user or persistent keyring so that it isn't left around on disk
across a reboot or logout.  Keyrings, however, cannot currently be
monitored asynchronously, so the desktop has to poll for it - not so good
on a laptop.  This facility will allow the desktop to avoid the need to
poll.


DESIGN DECISIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 (1) The notification queue is built on top of a standard pipe.  Messages
     are effectively spliced in.  The pipe is opened with a special flag:

	pipe2(fds, O_NOTIFICATION_PIPE);

     The special flag has the same value as O_EXCL (which doesn't seem lik=
e
     it will ever be applicable in this context)[?].  It is given up front
     to make it a lot easier to prohibit splice and co. from accessing the
     pipe.

     [?] Should this be done some other way?  I'd rather not use up a new
     	 O_* flag if I can avoid it - should I add a pipe3() system call
     	 instead?

     The pipe is then configured::

	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);

     Messages are then read out of the pipe using read().

 (2) It should be possible to allow write() to insert data into the
     notification pipes too, but this is currently disabled as the kernel
     has to be able to insert messages into the pipe *without* holding
     pipe->mutex and the code to make this work needs careful auditing.

 (3) sendfile(), splice() and vmsplice() are disabled on notification pipe=
s
     because of the pipe->mutex issue and also because they sometimes want
     to revert what they just did - but one or more notification messages
     might've been interleaved in the ring.

 (4) The kernel inserts messages with the wait queue spinlock held.  This
     means that pipe_read() and pipe_write() have to take the spinlock to
     update the queue pointers.

 (5) Records in the buffer are binary, typed and have a length so that the=
y
     can be of varying size.

     This allows multiple heterogeneous sources to share a common buffer;
     there are 16 million types available, of which I've used just a few,
     so there is scope for others to be used.  Tags may be specified when =
a
     watchpoint is created to help distinguish the sources.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Notification pipes don't interfere with each other; each may be bound
     to a different set of watches.  Any particular notification will be
     copied to all the queues that are currently watching for it - and onl=
y
     those that are watching for it.

 (8) When recording a notification, the kernel will not sleep, but will
     rather mark a queue as having lost a message if there's insufficient
     space.  read() will fabricate a loss notification message at an
     appropriate point later.

 (9) The notification pipe is created and then watchpoints are attached to
     it, using one of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
	watch_mount(AT_FDCWD, "/", 0, fd, 0x02);
	watch_sb(AT_FDCWD, "/mnt", 0, fd, 0x03);

     where in both cases, fd indicates the queue and the number after is a
     tag between 0 and 255.

(10) Watches are removed if either the notification pipe is destroyed or
     the watched object is destroyed.  In the latter case, a message will
     be generated indicating the enforced watch removal.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling
     namespaces tricky.  Further, dmesg might not exist or might be
     inaccessible inside a container.

 (3) Letting users see events they shouldn't be able to see.


TESTING AND MANPAGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 (*) The keyutils tree has a pipe-watch branch that has keyctl commands fo=
r
     making use of notifications.  Proposed manual pages can also be found
     on this branch, though a couple of them really need to go to the main
     manpages repository instead.

     If the kernel supports the watching of keys, then running "make test"
     on that branch will cause the testing infrastructure to spawn a
     monitoring process on the side that monitors a notifications pipe for
     all the key/keyring changes induced by the tests and they'll all be
     checked off to make sure they happened.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log=
/?h=3Dpipe-watch

 (*) A test program is provided (samples/watch_queue/watch_test) that can
     be used to monitor for keyrings, mount and superblock events.
     Information on the notifications is simply logged to stdout.

Thanks,
David

