Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4E3D6E14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 07:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhG0FdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 01:33:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:40070 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhG0FdK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=NWm91QZpFPYp47rJALTE6VIoCVrKmfU9xj6j1qItEr8=; b=xxnsLJ2U8hNsIOnmTlw
        8/cIrpjVHsCpEk71ud7aUlXmvEiwZPxpK8XdlBquyirHkFGlHLpkPWOdpbS3M3p1BWy5v+G5+NrJg
        SE6jsgLQoDMccTnqwRxqrYd/HeGt8f3jz9bLaD+K8pQ13u/4lfgj1cyS+WW4682Z9ivPjYUog/8=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8FiE-005LVp-Fh; Tue, 27 Jul 2021 08:33:06 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 00/10] memcg accounting from OpenVZ
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yutian Yang <nglaive@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
Message-ID: <153f4b96-8ec1-0d17-e7d5-a21ad971ddc5@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OpenVZ uses memory accounting 20+ years since v2.2.x linux kernels. 
Initially we used our own accounting subsystem, then partially committed
it to upstream, and a few years ago switched to cgroups v1.
Now we're rebasing again, revising our old patches and trying to push
them upstream.

We try to protect the host system from any misuse of kernel memory 
allocation triggered by untrusted users inside the containers.

Patch-set is addressed mostly to cgroups maintainers and cgroups@ mailing
list, though I would be very grateful for any comments from maintainersi
of affected subsystems or other people added in cc:

Compared to the upstream, we additionally account the following kernel objects:
- network devices and its Tx/Rx queues
- ipv4/v6 addresses and routing-related objects
- inet_bind_bucket cache objects
- VLAN group arrays
- ipv6/sit: ip_tunnel_prl
- scm_fp_list objects used by SCM_RIGHTS messages of Unix sockets 
- nsproxy and namespace objects itself
- IPC objects: semaphores, message queues and share memory segments
- mounts
- pollfd and select bits arrays
- signals and posix timers
- file lock
- fasync_struct used by the file lease code and driver's fasync queues 
- tty objects
- per-mm LDT

We have an incorrect/incomplete/obsoleted accounting for few other kernel
objects: sk_filter, af_packets, netlink and xt_counters for iptables.
They require rework and probably will be dropped at all.

Also we're going to add an accounting for nft, however it is not ready yet.

We have not tested performance on upstream, however, our performance team
compares our current RHEL7-based production kernel and reports that
they are at least not worse as the according original RHEL7 kernel.

v7:
- net-related patches was approved and included into net-next git
- rebase to v5.14-rc3
- added Acked-by tag from Kirill Tkhai on "memcg: enable accounting for
  new namesapces and struct nsproxy"

v6:
- improved description of "memcg: enable accounting for signals"
  according to Eric Biderman's wishes
- added Reviewed-by tag from Shakeel Butt on the same patch

v5:
- rebased to v5.14-rc1
- updated ack tags

v4:
- improved description for tty patch
- minor cleanup in LDT patch
- rebased to v5.12
- resent to lkml@

v3:
- added new patches for other kind of accounted objects
- combined patches for ip address/routing-related objects
- improved description
- re-ordered and rebased for linux 5.12-rc8

v2:
- squashed old patch 1 "accounting for allocations called with disabled BH"
   with old patch 2 "accounting for fib6_nodes cache" used such kind of memory allocation 
- improved patch description
- subsystem maintainers added to cc:

Vasily Averin (10):
  memcg: enable accounting for mnt_cache entries
  memcg: enable accounting for pollfd and select bits arrays
  memcg: enable accounting for file lock caches
  memcg: enable accounting for fasync_cache
  memcg: enable accounting for new namesapces and struct nsproxy
  memcg: enable accounting of ipc resources
  memcg: enable accounting for signals
  memcg: enable accounting for posix_timers_cache slab
  memcg: enable accounting for tty-related objects
  memcg: enable accounting for ldt_struct objects

 arch/x86/kernel/ldt.c      | 6 +++---
 drivers/tty/tty_io.c       | 4 ++--
 fs/fcntl.c                 | 3 ++-
 fs/locks.c                 | 6 ++++--
 fs/namespace.c             | 7 ++++---
 fs/select.c                | 4 ++--
 ipc/msg.c                  | 2 +-
 ipc/namespace.c            | 2 +-
 ipc/sem.c                  | 9 +++++----
 ipc/shm.c                  | 2 +-
 kernel/cgroup/namespace.c  | 2 +-
 kernel/nsproxy.c           | 2 +-
 kernel/pid_namespace.c     | 2 +-
 kernel/signal.c            | 2 +-
 kernel/time/namespace.c    | 4 ++--
 kernel/time/posix-timers.c | 4 ++--
 kernel/user_namespace.c    | 2 +-
 17 files changed, 34 insertions(+), 29 deletions(-)

-- 
1.8.3.1

