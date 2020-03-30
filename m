Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8285197E97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgC3OhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:37:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54228 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbgC3OhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585579026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WAGzNd6pNRWDDmsHc7dEMeNxmmm8wLcoVJWZfC6bcvk=;
        b=OgzK/AJyhNf8+ICrB/biDLjuTUM0oLuCtPKy5DymCY+WYhz6bkK+XNPwvP/yk545EhKYOP
        VXBqTLJv8FEnFKvKcWfvxjH4JdJ6TAD/+83Udrb8GuytTy37ylFuJpo/Aeygqy8ZFI6vvW
        bxmY/qJpacwLZWLX5W0oW1g7kAPxVs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-Ln0cO6TIMN-1PhuFx1EZIA-1; Mon, 30 Mar 2020 10:36:59 -0400
X-MC-Unique: Ln0cO6TIMN-1PhuFx1EZIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F03E1922020;
        Mon, 30 Mar 2020 14:36:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-66.rdu2.redhat.com [10.10.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A40965C1D4;
        Mon, 30 Mar 2020 14:36:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
References: <1445647.1585576702@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com,
        kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Mount and superblock notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1449542.1585579014.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Mar 2020 15:36:54 +0100
Message-ID: <1449543.1585579014@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

If you could consider pulling this - or would you prefer it to go through
Al?  It adds a couple of VFS-related event sources for the general
notification mechanism:

 (1) Mount topology events, such as mounting, unmounting, mount expiry,
     mount reconfiguration.

 (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
     errors (not complete yet).


WHY
=3D=3D=3D

 (1) Mount notifications.

     This one is wanted to avoid repeated trawling of /proc/mounts or
     similar to work out changes to the mount object attributes and mount
     topology.  I'm told that the proc file holding the namespace_sem is a
     point of contention, especially as the process of generating the text
     descriptions of the mounts/superblocks can be quite involved.

     Whilst you can use poll() on /proc/mounts, it doesn't give you any
     clues as to what changed.  The notification generated here directly
     indicates the mounts involved in any particular event and gives an
     idea of what the change was.

     This is combined with a new fsinfo() system call that allows, amongst
     other things, the ability to retrieve in one go an { id,
     change_counter } tuple from all the children of a specified mount,
     allowing buffer overruns to be dealt with quickly.

     This can be used by systemd to improve efficiency:

	https://lore.kernel.org/linux-fsdevel/20200227151421.3u74ijhqt6ekbiss@ws.=
net.home/

     And it's not just Red Hat that's potentially interested in this:

	https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf=
6@6wind.com/

     Also, this can be used to improve management of containers by allowin=
g
     watches to be set in foreign mount namespaces, such as are in a
     container.

 (2) Superblock notifications.

     This one is provided to allow systemd or the desktop to more easily
     detect events such as I/O errors and EDQUOT/ENOSPC.  This would be of
     interest to Postgres:

	https://lore.kernel.org/linux-fsdevel/20200211005626.7yqjf5rbs3vbwagd@ala=
p3.anarazel.de/

     But could also be used to indicate to systemd when a superblock has
     had its configuration changed.

Thanks,
David
---
The following changes since commit 694435dbde3d1da79aafaf4cd680802f9eb229b=
7:

  smack: Implement the watch_key and post_notification hooks (2020-03-19 1=
7:31:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/notifications-fs-20200330

for you to fetch changes up to 8dbf1aa122da5bbb4ede0f363a8a18dfc723be33:

  watch_queue: sample: Display superblock notifications (2020-03-19 17:31:=
09 +0000)

----------------------------------------------------------------
Filesystem notifications

----------------------------------------------------------------
David Howells (6):
      watch_queue: Add security hooks to rule on setting mount and sb watc=
hes
      watch_queue: Implement mount topology and attribute change notificat=
ions
      watch_queue: sample: Display mount tree change notifications
      watch_queue: Introduce a non-repeating system-unique superblock ID
      watch_queue: Add superblock notifications
      watch_queue: sample: Display superblock notifications

 Documentation/watch_queue.rst               |  24 ++-
 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   4 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/Kconfig                                  |  21 +++
 fs/Makefile                                 |   1 +
 fs/internal.h                               |   1 +
 fs/mount.h                                  |  21 +++
 fs/mount_notify.c                           | 228 +++++++++++++++++++++++=
+++++
 fs/namespace.c                              |  22 +++
 fs/super.c                                  | 205 +++++++++++++++++++++++=
++
 include/linux/dcache.h                      |   1 +
 include/linux/fs.h                          |  62 ++++++++
 include/linux/lsm_hooks.h                   |  24 +++
 include/linux/security.h                    |  16 ++
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   6 +-
 include/uapi/linux/watch_queue.h            |  65 +++++++-
 kernel/sys_ni.c                             |   6 +
 samples/watch_queue/watch_test.c            |  81 +++++++++-
 security/security.c                         |  14 ++
 36 files changed, 835 insertions(+), 5 deletions(-)
 create mode 100644 fs/mount_notify.c

