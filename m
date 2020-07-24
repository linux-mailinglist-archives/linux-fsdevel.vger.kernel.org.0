Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0624722C5DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXNLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:11:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgGXNLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595596290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k9drAeZ4hZck3whF/zeswoHycRwKNcQGYouHgh2Avoc=;
        b=YDqeQfkJoA+Uul4rs/pkD4LVyYa/WW4oajQY6I0TGOSh9f4O74xUKewjEMvMEk1g5PCjEY
        L3ztfie8Se7xAt2jXZf9muY5AupAbZBSSfqaIVoC3Gcebc1J3hYm8OvQMyoQWqZBL0t7CP
        vCgOxW6tKBuMd8jGecAvLbK+upriiIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-gG4lK0YCMwmnzZVTuuyqkA-1; Fri, 24 Jul 2020 09:11:28 -0400
X-MC-Unique: gG4lK0YCMwmnzZVTuuyqkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8292658;
        Fri, 24 Jul 2020 13:11:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58970183AB;
        Fri, 24 Jul 2020 13:11:23 +0000 (UTC)
Subject: [PATCH 0/4] Mount notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <mszeredi@redhat.com>, dhowells@redhat.com,
        torvalds@linux-foundation.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, jlayton@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:11:22 +0100
Message-ID: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

David
---
David Howells (4):
      watch_queue: Make watch_sizeof() check record size
      watch_queue: Add security hooks to rule on setting mount watches
      watch_queue: Implement mount topology and attribute change notifications
      watch_queue: sample: Display mount tree change notifications


 Documentation/watch_queue.rst               |  12 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
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
 fs/mount.h                                  |  21 ++
 fs/mount_notify.c                           | 228 ++++++++++++++++++++
 fs/namespace.c                              |  22 ++
 include/linux/dcache.h                      |   1 +
 include/linux/lsm_hook_defs.h               |   3 +
 include/linux/lsm_hooks.h                   |   6 +
 include/linux/security.h                    |   8 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/watch_queue.h            |  36 +++-
 kernel/sys_ni.c                             |   3 +
 samples/watch_queue/watch_test.c            |  44 +++-
 security/security.c                         |   7 +
 33 files changed, 421 insertions(+), 4 deletions(-)
 create mode 100644 fs/mount_notify.c


