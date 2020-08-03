Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5247023A733
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCNG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:06:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726981AbgHCNG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596459985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pwPDTywOojI/7bsmmT70RBPy/Nqmgh7kaCKLIQz3WEI=;
        b=YDlIDWHnwdTB+S+j+Psfyn0jaql5URTd813jKDFLoeteiYEcOO2iLoxJUD9tRArPFjUTvW
        9IFsD8TmnHpWMOwdJlyJhGOo7m3Mwi+pCxlc8D4Ek2DIZsaOVx6zhAwXwlfyf4DKymSJt/
        uxdAq1AmX1B2DImAExWvwAz2hC+KGHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-JOtaLftLN66601CSTdmQTw-1; Mon, 03 Aug 2020 09:06:24 -0400
X-MC-Unique: JOtaLftLN66601CSTdmQTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 128DD8015F7;
        Mon,  3 Aug 2020 13:06:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ADEA1001B0B;
        Mon,  3 Aug 2020 13:06:18 +0000 (UTC)
Subject: [PATCH 0/5] Mount notifications [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jamorris@linux.microsoft.com>,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        jlayton@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:06:17 +0100
Message-ID: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to add notifications for mount topology events,
such as mounting, unmounting, mount expiry, mount reconfiguration.

An LSM hook is included to an LSM to rule on whether or not a mount watch
may be set on a particular path.

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

	https://lore.kernel.org/linux-fsdevel/20200227151421.3u74ijhqt6ekbiss@ws.net.home/

And it's not just Red Hat that's potentially interested in this:

	https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf6@6wind.com/

The kernel patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-pipe-core


===================
SIGNIFICANT CHANGES
===================

 ver #2:

 (*) Make the ID fields in the mount notification 64-bits.  They're left
     referring to the mount ID here, but switched to the mount unique ID in
     the patch in fsinfo that adds that. [Requested by Miklós Szeredi]

 (*) Dropped the event counters from the mount notification message.
     [Requested by Miklós].

     This can easily be added back later as the message length can be
     increased to show it.

 (*) Moved the mount event counters over to the fsinfo patchset.


David
---
David Howells (5):
      watch_queue: Limit the number of watches a user can hold
      watch_queue: Make watch_sizeof() check record size
      watch_queue: Add security hooks to rule on setting mount watches
      watch_queue: Implement mount topology and attribute change notifications
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
 fs/Kconfig                                  |   9 +
 fs/Makefile                                 |   1 +
 fs/mount.h                                  |  18 ++
 fs/mount_notify.c                           | 222 ++++++++++++++++++++
 fs/namespace.c                              |  22 ++
 include/linux/dcache.h                      |   1 +
 include/linux/lsm_hook_defs.h               |   3 +
 include/linux/lsm_hooks.h                   |   6 +
 include/linux/security.h                    |   8 +
 include/linux/syscalls.h                    |   2 +
 include/linux/watch_queue.h                 |   7 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/watch_queue.h            |  31 ++-
 kernel/sys_ni.c                             |   3 +
 samples/watch_queue/watch_test.c            |  41 +++-
 security/security.c                         |   7 +
 35 files changed, 411 insertions(+), 6 deletions(-)
 create mode 100644 fs/mount_notify.c


