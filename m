Return-Path: <linux-fsdevel+bounces-45484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14CAA78659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5E018901FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B742A9E;
	Wed,  2 Apr 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h+Q1YLh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F682F2F;
	Wed,  2 Apr 2025 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743559706; cv=none; b=nLY5s9a+tt+lN4LOxB5XvoWPnrWMKJj6OhFLpNckIiVF2z2RrYci4ymbxm0yG5hvcuFu989yN6JiX65ZZVfS4wLaP/Ctyz+mSNi8VbM2aAiB0VQzS7EsZafUug9fIpaKhN0r4dGmRhFb/MLA4ZKOc6T7ahgTtYKbK7HH5kL2+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743559706; c=relaxed/simple;
	bh=LgryizMDt0BBXjSFJZHfFPQQcYvQ8H3XzOEzeICVDTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rh3j01PqgBbj1lD8z/SjM5xSDbt5fEpDk7PzknDc4GeHJehOh6p1V7VzbKcjLGYG+Sh6dz3p6Vk/RFoN8+tLtiTNZA6P2XXEyAQ/SfeceS/f+LwEMs0W0egDlM0/Qgy38EDE8vboAc6nJyy8Zio47lHgYTf9u1E9dtYo9+wv0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h+Q1YLh5; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743559705; x=1775095705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdzXn3HO86o3/5ISCuxpqaDyvjHqrBVvpfL+gQwpY5U=;
  b=h+Q1YLh5f1KrsYpMW1FMRPo67taX5NYg0qvlK8aSPjPO8K8LYlDaGXzW
   q4j+TysedvF+B4jxnqpTNxcf0X0ztJB+Pm+gBBHrRYG9e7xTM2/j3ZLk6
   Clr5xCHJzffPz69WkTq2nlIo8qZi/fzwadtl1bhw8hH+CKKKSZ1vBPXN0
   E=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="284788934"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 02:08:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:25364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.87:2525] with esmtp (Farcaster)
 id a3dd4e8d-12e6-4320-a80c-f0b19dbca9d2; Wed, 2 Apr 2025 02:08:19 +0000 (UTC)
X-Farcaster-Flow-ID: a3dd4e8d-12e6-4320-a80c-f0b19dbca9d2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 02:08:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 02:08:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wangzhaolong1@huawei.com>
CC: <edumazet@google.com>, <ematsumiya@suse.de>, <kuniyu@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-net@vger.kernel.org>, <smfrench@gmail.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Tue, 1 Apr 2025 19:01:30 -0700
Message-ID: <20250402020807.28583-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
References: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Wang Zhaolong <wangzhaolong1@huawei.com>
Date: Tue, 1 Apr 2025 21:54:47 +0800
> Hi.
> 
> My colleagues and I have been investigating the issue addressed by this patch
> and have discovered some significant concerns that require broader discussion.
> 
> ### Socket Leak Issue
> 
> After testing this patch extensively, I've confirmed it introduces a socket leak
> when TCP connections don't complete proper termination (e.g., when FIN packets
> are dropped). The leak manifests as a continuous increase in TCP slab usage:
> 
> I've documented this issue with a reproducer in Bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219972#c0
> 
> The key issue appears to stem from the interaction between the SMB client and TCP
> socket lifecycle management:
> 
> 1. Removing `sk->sk_net_refcnt = 1` causes TCP timers to be terminated early in
>     `tcp_close()` via the `inet_csk_clear_xmit_timers_sync()` call when
>     `!sk->sk_net_refcnt`
> 2. This early timer termination prevents proper reference counting resolution
>     when connections don't complete the 4-way TCP termination handshake
> 3. The resulting socket references are never fully released, leading to a leak
> 
> #### Timeline of Related Changes
> 
> 1. v4.2-rc1 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets")
>     - Added `sk_net_refcnt` field to distinguish user sockets (=1) from kernel sockets (=0)
>     - Kernel sockets don't hold netns references, which can lead to potential UAF issues
> 
> 2. v6.9-rc2 151c9c724d05: ("tcp: properly terminate timers for kernel sockets")
>     - Modified `tcp_close()` to check `sk->sk_net_refcnt` and explicitly terminate timers for kernel sockets (=0)
>     - This prevents UAF when netns is destroyed before socket timers complete
>     - **Key change**: If `!sk->sk_net_refcnt`, call `inet_csk_clear_xmit_timers_sync()`
> 
> 3. v6.12-rc7 ef7134c7fc48: ("smb: client: Fix use-after-free of network namespace")
>     - Fixed netns UAF in CIFS by manually setting `sk->sk_net_refcnt = 1`
>     - Also called `maybe_get_net()` to maintain netns references
>     - This effectively made kernel sockets behave like user sockets for reference counting
> 
> 4. v6.13-rc4 e9f2517a3e18: ("smb: client: fix TCP timers deadlock after rmmod")
>     - Problem commit: Removed `sk->sk_net_refcnt = 1` setting
>     - Changed to using explicit `get_net()/put_net()` at CIFS layer
>     - This change leads to socket leaks because timers are terminated early
> 
> ### Lockdep Warning Analysis
> 
> I've also investigated the lockdep warning mentioned in the patch. My analysis
> suggests it may be a false positive rather than an actual deadlock. The crash
> actually occurs in the lockdep subsystem itself (null pointer dereference in
> `check_wait_context()`), not in the CIFS or networking code directly.
> 
> The procedure for the null pointer dereference is as follows:
> 
> When lockdep is enabled, the lock class "slock-AF_INET-CIFS" is set when a socket
> connection is established.
> 
> ```
> cifs_do_mount
>    cifs_mount
>      mount_get_conns
>        cifs_get_tcp_session
>          ip_connect
>            generic_ip_connect
>              cifs_reclassify_socket4
>                sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
>                  lockdep_init_map
>                    lockdep_init_map_wait
>                      lockdep_init_map_type
>                        lockdep_init_map_type
>                          register_lock_class
>                            __set_bit(class - lock_classes, lock_classes_in_use);
> ```
> 
> When the module is unloaded, the lock class is cleaned up.
> 
> ```
> free_mod_mem
>    lockdep_free_key_range
>      __lockdep_free_key_range
>        zap_class
>          __clear_bit(class - lock_classes, lock_classes_in_use);
> ```
> 
> After the module is uninstalled and the network connection is restored, the
> timer is woken up.
> 
> ```
> run_timer_softirq
>    run_timer_base
>      __run_timers
>        call_timer_fn
>          tcp_write_timer
>            bh_lock_sock
>              spin_lock(&((__sk)->sk_lock.slock))
>                _raw_spin_lock
>                  lock_acquire
>                    __lock_acquire
>                      check_wait_context
>                        hlock_class
>                         if (!test_bit(class_idx, lock_classes_in_use)) {
>                            return NULL;
>                        hlock_class(next)->wait_type_inner; // Null pointer dereference
> ```
> 
> The problem lies within lockdep, as Kuniyuki says:
> 
> > I tried the repro and confirmed it triggers null deref.
> > 
> > It happens in LOCKDEP internal, so for me it looks like a problem in
> > LOCKDEP rather than CIFS or TCP.
> > 
> > I think LOCKDEP should hold a module reference and prevent related
> > modules from being unloaded.
> 
> Regarding the deadlock issue, it is clear that the locks mentioned in the deadlock warning
> do not belong to the same lock instance. A deadlock should not occur.
> 
> ### Discussion Points
> 
> 1. API Design Question: Is this fundamentally an issue with how CIFS uses the socket
>     API, or is it a networking layer issue that should handle socket cleanup differently?
> 
> 2. Approach to Resolution: Would it be better to:
>     - Revert to the original solution (setting `sk->sk_net_refcnt = 1`) from ef7134c7fc48?
>     - Work with networking subsystem maintainers on a more comprehensive solution that
>       handles socket cleanup properly?
> 
> 3.  CVE Process Question: Given that CVE-2024-54680 appears to "fix" a non-existent issue
>      while introducing an actual vulnerability, what's the appropriate way to address this?

I tested on 6.14 and e9f2517a3e18, but the issue still reproduces,
so e9f2517a3e18 is a bogus fix, and we will need to ask the CNA team
to update the description once the correct fix is merged.

repro:
---8<---
#!/bin/bash

CIFS_SERVER="10.0.0.137"
CIFS_PATH="//${CIFS_SERVER}/Users/Administrator/Desktop/CIFS_TEST"
DEV="enp0s3"
CRED="/root/WindowsCredential.sh"
MNT=$(mktemp -d XXXXXX)

echo "/tmp/${MNT}"

mkdir -p /tmp/${MNT}

mount -t cifs ${CIFS_PATH} /tmp/${MNT} -o vers=3.0,sec=ntlmssp,credentials=${CRED},rsize=65536,wsize=65536,cache=none,echo_interval=1

echo "hello world" > /tmp/${MNT}/a.txt

iptables -A INPUT -s ${CIFS_SERVER} -j DROP

cat /tmp/${MNT}/a.txt &

for i in $(seq 10);
do
    umount /tmp/${MNT}
    rmmod cifs
    sleep 1
done

rm -r /tmp/${MNT}

iptables -D INPUT -s ${CIFS_SERVER} -j DROP
---8<---

splat:
---8<---
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 10 PID: 0 at kernel/locking/lockdep.c:234 hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
Modules linked in: cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded: cifs]
CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Not tainted 6.14.0 #36
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
Code: ef 90 e8 c4 66 4c 00 85 c0 74 23 8b 05 ba dd bf 01 85 c0 75 19 90 48 c7 c6 4d 83 a1 82 48 c7 c7 bc 0d a0 82 e8 e2 2f f8 ff 90 <0f> 0b 90 90 90 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffa0000000468a08 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ff1100010091cc38 RCX: 0000000000000027
RDX: ff1100081f09ca48 RSI: 0000000000000001 RDI: ff1100081f09ca40
RBP: ff1100010091c200 R08: ff1100083fe6e228 R09: 00000000ffffbfff
R10: ff1100081eca0000 R11: ff1100083fe10dc0 R12: ff1100010091cc88
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000424b1
FS:  0000000000000000(0000) GS:ff1100081f080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10a998d1b4 CR3: 0000000002c4a003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? __warn (kernel/panic.c:748)
 ? hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
 ? report_bug (lib/bug.c:201 lib/bug.c:219)
 ? handle_bug (arch/x86/kernel/traps.c:285)
 ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
 ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
 ? hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
 ? hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
 __lock_acquire (kernel/locking/lockdep.c:4853 kernel/locking/lockdep.c:5178)
 ? lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816)
 ? sk_filter_trim_cap (./include/linux/rcupdate.h:337 ./include/linux/rcupdate.h:849 net/core/filter.c:155)
 lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816)
 ? tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
 ? sk_filter_trim_cap (./include/linux/rcupdate.h:883 net/core/filter.c:166)
 ? __inet_lookup_established (./include/net/inet_hashtables.h:358 net/ipv4/inet_hashtables.c:515)
 _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
 ? tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
 tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
 ? raw_local_deliver (net/ipv4/raw.c:206)
 ? lock_is_held_type (kernel/locking/lockdep.c:5592 kernel/locking/lockdep.c:5923)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discriminator 1))
 ip_local_deliver_finish (./include/linux/rcupdate.h:878 net/ipv4/ip_input.c:234)
 ip_sublist_rcv_finish (net/ipv4/ip_input.c:576)
 ip_list_rcv_finish (net/ipv4/ip_input.c:628)
 ip_list_rcv (net/ipv4/ip_input.c:670)
 __netif_receive_skb_list_core (net/core/dev.c:5939 net/core/dev.c:5986)
 netif_receive_skb_list_internal (net/core/dev.c:6040 net/core/dev.c:6129)
 napi_complete_done (./include/linux/list.h:37 ./include/net/gro.h:519 ./include/net/gro.h:514 net/core/dev.c:6496)
 e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3815)
 __napi_poll.constprop.0 (net/core/dev.c:7191)
 net_rx_action (net/core/dev.c:7262 net/core/dev.c:7382)
 ? handle_irq_event (kernel/irq/internals.h:236 kernel/irq/handle.c:213)
 ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
 ? find_held_lock (kernel/locking/lockdep.c:5341)
 handle_softirqs (kernel/softirq.c:561)
 __irq_exit_rcu (kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
 irq_exit_rcu (kernel/softirq.c:680)
 common_interrupt (arch/x86/kernel/irq.c:280 (discriminator 14))
 </IRQ>
 <TASK>
 asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693)
RIP: 0010:default_idle (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:744)
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 2b 15 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffa00000000ffee8 EFLAGS: 00000202
RAX: 000000000000640b RBX: ff1100010091c200 RCX: 0000000000061aa4
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff812f30c5
RBP: 000000000000000a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 ? do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:118)
 do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 cpu_startup_entry (kernel/sched/idle.c:422 (discriminator 1))
 start_secondary (arch/x86/kernel/smpboot.c:315)
 common_startup_64 (arch/x86/kernel/head_64.S:421)
 </TASK>
irq event stamp: 25636
hardirqs last  enabled at (25636): [<ffffffff81297fe1>] __local_bh_enable_ip+0x71/0xd0
hardirqs last disabled at (25635): [<ffffffff8129800a>] __local_bh_enable_ip+0x9a/0xd0
softirqs last  enabled at (25606): [<ffffffff81297b2e>] handle_softirqs+0x2ee/0x3b0
softirqs last disabled at (25613): [<ffffffff81297d51>] __irq_exit_rcu+0xa1/0xc0
---[ end trace 0000000000000000 ]---
BUG: kernel NULL pointer dereference, address: 00000000000000c4
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Tainted: G        W          6.14.0 #36
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire (kernel/locking/lockdep.c:4852 kernel/locking/lockdep.c:5178) 
Code: 15 41 09 c7 41 8b 44 24 20 25 ff 1f 00 00 41 09 c7 8b 84 24 a0 00 00 00 45 89 7c 24 20 41 89 44 24 24 e8 e1 bc ff ff 4c 89 e7 <44> 0f b6 b8 c4 00 00 00 e8 d1 bc ff ff 0f b6 80 c5 00 00 00 88 44
RSP: 0018:ffa0000000468a10 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ff1100010091cc38 RCX: 0000000000000027
RDX: ff1100081f09ca48 RSI: 0000000000000001 RDI: ff1100010091cc88
RBP: ff1100010091c200 R08: ff1100083fe6e228 R09: 00000000ffffbfff
R10: ff1100081eca0000 R11: ff1100083fe10dc0 R12: ff1100010091cc88
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000424b1
FS:  0000000000000000(0000) GS:ff1100081f080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c4 CR3: 0000000002c4a003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816)
 _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
 tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discriminator 1))
 ip_local_deliver_finish (./include/linux/rcupdate.h:878 net/ipv4/ip_input.c:234)
 ip_sublist_rcv_finish (net/ipv4/ip_input.c:576)
 ip_list_rcv_finish (net/ipv4/ip_input.c:628)
 ip_list_rcv (net/ipv4/ip_input.c:670)
 __netif_receive_skb_list_core (net/core/dev.c:5939 net/core/dev.c:5986)
 netif_receive_skb_list_internal (net/core/dev.c:6040 net/core/dev.c:6129)
 napi_complete_done (./include/linux/list.h:37 ./include/net/gro.h:519 ./include/net/gro.h:514 net/core/dev.c:6496)
 e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3815)
 __napi_poll.constprop.0 (net/core/dev.c:7191)
 net_rx_action (net/core/dev.c:7262 net/core/dev.c:7382)
 handle_softirqs (kernel/softirq.c:561)
 __irq_exit_rcu (kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
 irq_exit_rcu (kernel/softirq.c:680)
 common_interrupt (arch/x86/kernel/irq.c:280 (discriminator 14))
  </IRQ>
 <TASK>
 asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693)
RIP: 0010:default_idle (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:744)
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 2b 15 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffa00000000ffee8 EFLAGS: 00000202
RAX: 000000000000640b RBX: ff1100010091c200 RCX: 0000000000061aa4
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff812f30c5
RBP: 000000000000000a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 ? do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:118)
 do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 cpu_startup_entry (kernel/sched/idle.c:422 (discriminator 1))
 start_secondary (arch/x86/kernel/smpboot.c:315)
 common_startup_64 (arch/x86/kernel/head_64.S:421)
 </TASK>
Modules linked in: cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded: cifs]
CR2: 00000000000000c4
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x222/0x16f0
Code: 15 41 09 c7 41 8b 44 24 20 25 ff 1f 00 00 41 09 c7 8b 84 24 a0 00 00 00 45 89 7c 24 20 41 89 44 24 24 e8 e1 bc ff ff 4c 89 e7 <44> 0f b6 b8 c4 00 00 00 e8 d1 bc ff ff 0f b6 80 c5 00 00 00 88 44
RSP: 0018:ffa0000000468a10 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ff1100010091cc38 RCX: 0000000000000027
RDX: ff1100081f09ca48 RSI: 0000000000000001 RDI: ff1100010091cc88
RBP: ff1100010091c200 R08: ff1100083fe6e228 R09: 00000000ffffbfff
R10: ff1100081eca0000 R11: ff1100083fe10dc0 R12: ff1100010091cc88
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000424b1
FS:  0000000000000000(0000) GS:ff1100081f080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c4 CR3: 0000000002c4a003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
---8<---

