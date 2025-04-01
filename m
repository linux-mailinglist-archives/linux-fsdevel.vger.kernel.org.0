Return-Path: <linux-fsdevel+bounces-45449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6308A77CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793F0167537
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D42046A8;
	Tue,  1 Apr 2025 13:54:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB35C2C6;
	Tue,  1 Apr 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515696; cv=none; b=MVQ87UtqWV8aNygTcEqISf4gKd3uO0VC/80WcqCha3Ocfhb12+F+PCgWoto1CGnn92jMd/SGhiKUG8qwAR+1urubg3pSFrguUsDrenwwK3ka1shuvZ4woy0xM3htiErO+2ZAYPtKQTqnZoOCERuq99GGUgLUcHVJWaLhzvJb3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515696; c=relaxed/simple;
	bh=1JeXX8dTrMj5iy7nBIKL7ZWyC7Mz2KiEEpDNh7CypLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PrWCq5qHQIzUivGu/CO0iLwUQAFTasvS8/flSvlMXsN6S5pPxjzftEUg04A/cji4PwnyWBnz8d5LMIvGmzOcGiuzShB+MwZQFtGvT4x3lC0+VQCpahGX6w5QFPkPx2bVWlf54FjhIqkZ/TgDtVYwLJESHCM5vZTSItxK7DkLpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZRqCF6dy6zvWqt;
	Tue,  1 Apr 2025 21:50:49 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CC6814036D;
	Tue,  1 Apr 2025 21:54:49 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 21:54:48 +0800
Message-ID: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
Date: Tue, 1 Apr 2025 21:54:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: Steve French <smfrench@gmail.com>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, <linux-net@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>,
	<kuniyu@amazon.com>, <edumazet@google.com>
CC: <zhangchangzhong@huawei.com>
References: <CAH2r5msqxcvHcbDt0x_eNpbdPxUhgFoOAPchZ16EBZeFhCdAKA@mail.gmail.com>
 <CAH2r5mtoz+4RSDLJijNFD6dRiLTWKou8m3M2mTp2cy7oPsP=Qg@mail.gmail.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <CAH2r5mtoz+4RSDLJijNFD6dRiLTWKou8m3M2mTp2cy7oPsP=Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Hi.

My colleagues and I have been investigating the issue addressed by this patch
and have discovered some significant concerns that require broader discussion.

### Socket Leak Issue

After testing this patch extensively, I've confirmed it introduces a socket leak
when TCP connections don't complete proper termination (e.g., when FIN packets
are dropped). The leak manifests as a continuous increase in TCP slab usage:

I've documented this issue with a reproducer in Bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=219972#c0

The key issue appears to stem from the interaction between the SMB client and TCP
socket lifecycle management:

1. Removing `sk->sk_net_refcnt = 1` causes TCP timers to be terminated early in
    `tcp_close()` via the `inet_csk_clear_xmit_timers_sync()` call when
    `!sk->sk_net_refcnt`
2. This early timer termination prevents proper reference counting resolution
    when connections don't complete the 4-way TCP termination handshake
3. The resulting socket references are never fully released, leading to a leak

#### Timeline of Related Changes

1. v4.2-rc1 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets")
    - Added `sk_net_refcnt` field to distinguish user sockets (=1) from kernel sockets (=0)
    - Kernel sockets don't hold netns references, which can lead to potential UAF issues

2. v6.9-rc2 151c9c724d05: ("tcp: properly terminate timers for kernel sockets")
    - Modified `tcp_close()` to check `sk->sk_net_refcnt` and explicitly terminate timers for kernel sockets (=0)
    - This prevents UAF when netns is destroyed before socket timers complete
    - **Key change**: If `!sk->sk_net_refcnt`, call `inet_csk_clear_xmit_timers_sync()`

3. v6.12-rc7 ef7134c7fc48: ("smb: client: Fix use-after-free of network namespace")
    - Fixed netns UAF in CIFS by manually setting `sk->sk_net_refcnt = 1`
    - Also called `maybe_get_net()` to maintain netns references
    - This effectively made kernel sockets behave like user sockets for reference counting

4. v6.13-rc4 e9f2517a3e18: ("smb: client: fix TCP timers deadlock after rmmod")
    - Problem commit: Removed `sk->sk_net_refcnt = 1` setting
    - Changed to using explicit `get_net()/put_net()` at CIFS layer
    - This change leads to socket leaks because timers are terminated early

### Lockdep Warning Analysis

I've also investigated the lockdep warning mentioned in the patch. My analysis
suggests it may be a false positive rather than an actual deadlock. The crash
actually occurs in the lockdep subsystem itself (null pointer dereference in
`check_wait_context()`), not in the CIFS or networking code directly.

The procedure for the null pointer dereference is as follows:

When lockdep is enabled, the lock class "slock-AF_INET-CIFS" is set when a socket
connection is established.

```
cifs_do_mount
   cifs_mount
     mount_get_conns
       cifs_get_tcp_session
         ip_connect
           generic_ip_connect
             cifs_reclassify_socket4
               sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
                 lockdep_init_map
                   lockdep_init_map_wait
                     lockdep_init_map_type
                       lockdep_init_map_type
                         register_lock_class
                           __set_bit(class - lock_classes, lock_classes_in_use);
```

When the module is unloaded, the lock class is cleaned up.

```
free_mod_mem
   lockdep_free_key_range
     __lockdep_free_key_range
       zap_class
         __clear_bit(class - lock_classes, lock_classes_in_use);
```

After the module is uninstalled and the network connection is restored, the
timer is woken up.

```
run_timer_softirq
   run_timer_base
     __run_timers
       call_timer_fn
         tcp_write_timer
           bh_lock_sock
             spin_lock(&((__sk)->sk_lock.slock))
               _raw_spin_lock
                 lock_acquire
                   __lock_acquire
                     check_wait_context
                       hlock_class
                        if (!test_bit(class_idx, lock_classes_in_use)) {
                           return NULL;
                       hlock_class(next)->wait_type_inner; // Null pointer dereference
```

The problem lies within lockdep, as Kuniyuki says:

> I tried the repro and confirmed it triggers null deref.
> 
> It happens in LOCKDEP internal, so for me it looks like a problem in
> LOCKDEP rather than CIFS or TCP.
> 
> I think LOCKDEP should hold a module reference and prevent related
> modules from being unloaded.

Regarding the deadlock issue, it is clear that the locks mentioned in the deadlock warning
do not belong to the same lock instance. A deadlock should not occur.

### Discussion Points

1. API Design Question: Is this fundamentally an issue with how CIFS uses the socket
    API, or is it a networking layer issue that should handle socket cleanup differently?

2. Approach to Resolution: Would it be better to:
    - Revert to the original solution (setting `sk->sk_net_refcnt = 1`) from ef7134c7fc48?
    - Work with networking subsystem maintainers on a more comprehensive solution that
      handles socket cleanup properly?

3.  CVE Process Question: Given that CVE-2024-54680 appears to "fix" a non-existent issue
     while introducing an actual vulnerability, what's the appropriate way to address this?

What's the best path forward?

Best regards,
Wang Zhaolong

> Adding fsdevel and networking in case any thoughts on this fix for
> network/namespaces refcount issue (that causes rmmod UAF).
> 
> Any opinions on Enzo's proposed Fix?
> 
> ---------- Forwarded message ---------
> From: Steve French <smfrench@gmail.com>
> Date: Tue, Dec 17, 2024 at 9:24 PM
> Subject: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
> To: CIFS <linux-cifs@vger.kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Enzo Matsumiya <ematsumiya@suse.de>
> 
> 
> Enzo had an interesting patch, that seems to fix an important problem.
> 
> Here was his repro scenario:
> 
>       tw:~ # mount.cifs -o credentials=/root/wincreds,echo_interval=10
> //someserver/target1 /mnt/test
>       tw:~ # ls /mnt/test
>       abc  dir1  dir3  target1_file.txt  tsub
>       tw:~ # iptables -A INPUT -s someserver -j DROP
> 
> Trigger reconnect and wait for 3*echo_interval:
> 
>       tw:~ # cat /mnt/test/target1_file.txt
>       cat: /mnt/test/target1_file.txt: Host is down
> 
> Then umount and rmmod.  Note that rmmod might take several iterations
> until it properly tears down everything, so make sure you see the "not
> loaded" message before proceeding:
> 
>       tw:~ # umount /mnt/*; rmmod cifs
>       umount: /mnt/az: not mounted.
>       umount: /mnt/dfs: not mounted.
>       umount: /mnt/local: not mounted.
>       umount: /mnt/scratch: not mounted.
>       rmmod: ERROR: Module cifs is in use
>       ...
>       tw:~ # rmmod cifs
>       rmmod: ERROR: Module cifs is not currently loaded
> 
> Then kickoff the TCP internals:
>       tw:~ # iptables -F
> 
> Gets the lockdep warning (requires CONFIG_LOCKDEP=y) + a NULL deref
> later on.
> 
> 
> Any thoughts on his patch?  See below (and attached)
> 
>      Commit ef7134c7fc48 ("smb: client: Fix use-after-free of network
> namespace.")
>      fixed a netns UAF by manually enabled socket refcounting
>      (sk->sk_net_refcnt=1 and sock_inuse_add(net, 1)).
> 
>      The reason the patch worked for that bug was because we now hold
>      references to the netns (get_net_track() gets a ref internally)
>      and they're properly released (internally, on __sk_destruct()),
>      but only because sk->sk_net_refcnt was set.
> 
>      Problem:
>      (this happens regardless of CONFIG_NET_NS_REFCNT_TRACKER and regardless
>      if init_net or other)
> 
>      Setting sk->sk_net_refcnt=1 *manually* and *after* socket creation is not
>      only out of cifs scope, but also technically wrong -- it's set conditionally
>      based on user (=1) vs kernel (=0) sockets.  And net/ implementations
>      seem to base their user vs kernel space operations on it.
> 
>      e.g. upon TCP socket close, the TCP timers are not cleared because
>      sk->sk_net_refcnt=1:
>      (cf. commit 151c9c724d05 ("tcp: properly terminate timers for
> kernel sockets"))
> 
>      net/ipv4/tcp.c:
>          void tcp_close(struct sock *sk, long timeout)
>          {
>              lock_sock(sk);
>              __tcp_close(sk, timeout);
>              release_sock(sk);
>              if (!sk->sk_net_refcnt)
>                      inet_csk_clear_xmit_timers_sync(sk);
>              sock_put(sk);
>          }
> 
>      Which will throw a lockdep warning and then, as expected, deadlock on
>      tcp_write_timer().
> 
>      A way to reproduce this is by running the reproducer from ef7134c7fc48
>      and then 'rmmod cifs'.  A few seconds later, the deadlock/lockdep
>      warning shows up.
> 
>      Fix:
>      We shouldn't mess with socket internals ourselves, so do not set
>      sk_net_refcnt manually.
> 
>      Also change __sock_create() to sock_create_kern() for explicitness.
> 
>      As for non-init_net network namespaces, we deal with it the best way
>      we can -- hold an extra netns reference for server->ssocket and drop it
>      when it's released.  This ensures that the netns still exists whenever
>      we need to create/destroy server->ssocket, but is not directly tied to
>      it.
> 
>      Fixes: ef7134c7fc48 ("smb: client: Fix use-after-free of network
> namespace.")
> 
> 
> --
> Thanks,
> 
> Steve
> 
> 


