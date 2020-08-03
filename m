Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189EA23A954
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCP17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:27:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgHCP17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596468476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WIZ7bSYiDkZRaRp/PG2/VcJpUHi5wIOy+qtpqbYupjU=;
        b=dmmF9jOaynYiaJi8Gph0oL6h9VVvnycnGrv/MJKmAEXpDqAHE4pvAefJGgvxsekWpiNvO1
        QYJMzbokz2fSpTh9MOF9th//uub06y6vPDxp8Qg0/yojvEu47WWopDzRwrbDFL1nphzUkH
        MtIehziYYWKxHICgQZ/q3VIM40l6GvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-1nFJN-FaMq-j5STgXb9V6g-1; Mon, 03 Aug 2020 11:27:54 -0400
X-MC-Unique: 1nFJN-FaMq-j5STgXb9V6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F069106B77E;
        Mon,  3 Aug 2020 15:27:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF77F8BED5;
        Mon,  3 Aug 2020 15:27:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        kzak@redhat.com, jlayton@redhat.com, mszeredi@redhat.com,
        nicolas.dichtel@6wind.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Mount notifications
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 03 Aug 2020 16:27:49 +0100
Message-ID: <1842689.1596468469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

Here's a set of patches to add notifications for mount topology events,
such as mounting, unmounting, mount expiry, mount reconfiguration.

The first patch in the series adds a hard limit on the number of watches
that any particular user can add.  The RLIMIT_NOFILE value for the process
adding a watch is used as the limit.  Even if you don't take the rest of
the series, can you at least take this one?

An LSM hook is included for an LSM to rule on whether or not a mount watch
may be set on a particular path.

This series is intended to be taken in conjunction with the fsinfo series
which I'll post a pull request for shortly and which is dependent on it.

Karel Zak[*] has created preliminary patches that add support to libmount
and Ian Kent has started working on making systemd use them.

[*] https://github.com/karelzak/util-linux/commits/topic/fsinfo

Note that there have been some last minute changes to the patchset: you
wanted something adding and Mikl=C3=B3s wanted some bits taking out/changin=
g.
I've placed a tag, fsinfo-core-20200724 on the aggregate of these two
patchsets that can be compared to fsinfo-core-20200803.

To summarise the changes: I added the limiter that you wanted; removed an
unused symbol; made the mount ID fields in the notificaion 64-bit (the
fsinfo patchset has a change to convey the mount uniquifier instead of the
mount ID); removed the event counters from the mount notification and moved
the event counters into the fsinfo patchset.


=3D=3D=3D=3D
WHY?
=3D=3D=3D=3D

Why do we want mount notifications?  Whilst /proc/mounts can be polled, it
only tells you that something changed in your namespace.  To find out, you
have to trawl /proc/mounts or similar to work out what changed in the mount
object attributes and mount topology.  I'm told that the proc file holding
the namespace_sem is a point of contention, especially as the process of
generating the text descriptions of the mounts/superblocks can be quite
involved.

The notification generated here directly indicates the mounts involved in
any particular event and gives an idea of what the change was.

This is combined with a new fsinfo() system call that allows, amongst other
things, the ability to retrieve in one go an { id, change_counter } tuple
from all the children of a specified mount, allowing buffer overruns to be
dealt with quickly.

This is of use to systemd to improve efficiency:

	https://lore.kernel.org/linux-fsdevel/20200227151421.3u74ijhqt6ekbiss@ws.n=
et.home/

And it's not just Red Hat that's potentially interested in this:

	https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf6=
@6wind.com/


David
---
The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/=
mount-notifications-20200803

for you to fetch changes up to 841a0dfa511364fa9a8d67512e0643669f1f03e3:

  watch_queue: sample: Display mount tree change notifications (2020-08-03 =
12:15:38 +0100)

----------------------------------------------------------------
Mount notifications

----------------------------------------------------------------
David Howells (5):
      watch_queue: Limit the number of watches a user can hold
      watch_queue: Make watch_sizeof() check record size
      watch_queue: Add security hooks to rule on setting mount watches
      watch_queue: Implement mount topology and attribute change notificati=
ons
      watch_queue: sample: Display mount tree change notifications

 Documentation/watch_queue.rst               |  12 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/Kconfig                                  |   9 ++
 fs/Makefile                                 |   1 +
 fs/mount.h                                  |  18 +++
 fs/mount_notify.c                           | 222 ++++++++++++++++++++++++=
++++
 fs/namespace.c                              |  22 +++
 include/linux/dcache.h                      |   1 +
 include/linux/lsm_hook_defs.h               |   3 +
 include/linux/lsm_hooks.h                   |   6 +
 include/linux/sched/user.h                  |   3 +
 include/linux/security.h                    |   8 +
 include/linux/syscalls.h                    |   2 +
 include/linux/watch_queue.h                 |   7 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/watch_queue.h            |  31 +++-
 kernel/sys_ni.c                             |   3 +
 kernel/watch_queue.c                        |   8 +
 samples/watch_queue/watch_test.c            |  41 ++++-
 security/security.c                         |   7 +
 37 files changed, 422 insertions(+), 6 deletions(-)
 create mode 100644 fs/mount_notify.c

