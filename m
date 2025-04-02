Return-Path: <linux-fsdevel+bounces-45482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B442A785EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 02:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86187A27EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 00:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC31BE5E;
	Wed,  2 Apr 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DDapI0QI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD56C2D1;
	Wed,  2 Apr 2025 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555536; cv=none; b=iySSLwzyhZIBbBsIOpJ7IjRz+g93v5QZUoY59p7jFvzcBaTETBBBs7omlsXKXX3U8cJmYkyYttZWEaQeVDEFJfTR7Z37Pc4axMQWiyS34cJpb91c2rYmP0qrWxem2Lp+oVEq74+XdVVTXiQkcVqjjnEU92TI6NRCVfLlHpf8vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555536; c=relaxed/simple;
	bh=CPbNbRtfPG4/EVkztSuwh+xP+T0HOT3dFzSSvPR1c+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTu8dPDIiOBGh3hFmj5Aywt1cuL0VYQkt2r4cJHZD6jlxaYu3lbOfwbwJKpsjzBrlsID8lMrL0tbgNLvNYq70ATB5gsOCDepNcVu0ONge/Ts536I6MUXELBr4u2qUIo5ULs7z2mgy7BYy1gIj0Y5ZAr2LG+MVPenay7PXB4wG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DDapI0QI; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743555534; x=1775091534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXwFGCPonvXpWZDcPSAxbK+QrXCcGHKLVzBAlINj+BM=;
  b=DDapI0QISmw5flKbXhf6rFM8I5VXvkp5IvzYPCl1f8UirFWTJVf5oQU4
   /13uLkv335oZYgwoKyENwnTFnGJ5ITnVMMNdMAvjfHRWrt9mJ8wL3rW9Y
   Iqb5jhCLoSHK1cEBkTOmvaT2NqP3my6F75EepEMcebSyOEq89atsZF7Do
   U=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="183992474"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 00:58:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:39582]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.60:2525] with esmtp (Farcaster)
 id d78ee292-0699-4843-a1b5-a7fe49911d04; Wed, 2 Apr 2025 00:58:52 +0000 (UTC)
X-Farcaster-Flow-ID: d78ee292-0699-4843-a1b5-a7fe49911d04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 00:58:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 00:58:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <edumazet@google.com>, <ematsumiya@suse.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <smfrench@gmail.com>, <wangzhaolong1@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Date: Tue, 1 Apr 2025 17:57:46 -0700
Message-ID: <20250402005841.19846-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401202810.81863-1-kuniyu@amazon.com>
References: <20250401202810.81863-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 1 Apr 2025 13:26:54 -0700
> (corrected netdev list)
> 
> From: Wang Zhaolong <wangzhaolong1@huawei.com>
> Date: Tue, 1 Apr 2025 21:54:47 +0800
> > Hi.
> > 
> > My colleagues and I have been investigating the issue addressed by this patch
> > and have discovered some significant concerns that require broader discussion.
> > 
> > ### Socket Leak Issue
> > 
> > After testing this patch extensively, I've confirmed it introduces a socket leak
> > when TCP connections don't complete proper termination (e.g., when FIN packets
> > are dropped). The leak manifests as a continuous increase in TCP slab usage:
> > 
> > I've documented this issue with a reproducer in Bugzilla:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=219972#c0
> > 
> > The key issue appears to stem from the interaction between the SMB client and TCP
> > socket lifecycle management:
> > 
> > 1. Removing `sk->sk_net_refcnt = 1` causes TCP timers to be terminated early in
> >     `tcp_close()` via the `inet_csk_clear_xmit_timers_sync()` call when
> >     `!sk->sk_net_refcnt`
> > 2. This early timer termination prevents proper reference counting resolution
> >     when connections don't complete the 4-way TCP termination handshake
> > 3. The resulting socket references are never fully released, leading to a leak
> > 
> > #### Timeline of Related Changes
> > 
> > 1. v4.2-rc1 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets")
> >     - Added `sk_net_refcnt` field to distinguish user sockets (=1) from kernel sockets (=0)
> >     - Kernel sockets don't hold netns references, which can lead to potential UAF issues
> > 
> > 2. v6.9-rc2 151c9c724d05: ("tcp: properly terminate timers for kernel sockets")
> >     - Modified `tcp_close()` to check `sk->sk_net_refcnt` and explicitly terminate timers for kernel sockets (=0)
> >     - This prevents UAF when netns is destroyed before socket timers complete
> >     - **Key change**: If `!sk->sk_net_refcnt`, call `inet_csk_clear_xmit_timers_sync()`
> > 
> > 3. v6.12-rc7 ef7134c7fc48: ("smb: client: Fix use-after-free of network namespace")
> >     - Fixed netns UAF in CIFS by manually setting `sk->sk_net_refcnt = 1`
> >     - Also called `maybe_get_net()` to maintain netns references
> >     - This effectively made kernel sockets behave like user sockets for reference counting
> > 
> > 4. v6.13-rc4 e9f2517a3e18: ("smb: client: fix TCP timers deadlock after rmmod")
> >     - Problem commit: Removed `sk->sk_net_refcnt = 1` setting
> >     - Changed to using explicit `get_net()/put_net()` at CIFS layer
> >     - This change leads to socket leaks because timers are terminated early
> > 
> > ### Lockdep Warning Analysis
> > 
> > I've also investigated the lockdep warning mentioned in the patch. My analysis
> > suggests it may be a false positive rather than an actual deadlock.
> 
> Note that the 'deadlock' in the description is simply wrong as I mentioned
> before.  The 'deadlock' means a lock which belongs to an unloaded module,
> and not actual deadlock like circular locking etc.
> 
> https://lore.kernel.org/netdev/20241219084100.33837-1-kuniyu@amazon.com/
> 
> 
> > The crash
> > actually occurs in the lockdep subsystem itself (null pointer dereference in
> > `check_wait_context()`), not in the CIFS or networking code directly.
> > 
> > The procedure for the null pointer dereference is as follows:
> > 
> > When lockdep is enabled, the lock class "slock-AF_INET-CIFS" is set when a socket
> > connection is established.
> > 
> > ```
> > cifs_do_mount
> >    cifs_mount
> >      mount_get_conns
> >        cifs_get_tcp_session
> >          ip_connect
> >            generic_ip_connect
> >              cifs_reclassify_socket4
> >                sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
> >                  lockdep_init_map
> >                    lockdep_init_map_wait
> >                      lockdep_init_map_type
> >                        lockdep_init_map_type
> >                          register_lock_class
> >                            __set_bit(class - lock_classes, lock_classes_in_use);
> > ```
> > 
> > When the module is unloaded, the lock class is cleaned up.
> > 
> > ```
> > free_mod_mem
> >    lockdep_free_key_range
> >      __lockdep_free_key_range
> >        zap_class
> >          __clear_bit(class - lock_classes, lock_classes_in_use);
> > ```
> > 
> > After the module is uninstalled and the network connection is restored, the
> > timer is woken up.
> > 
> > ```
> > run_timer_softirq
> >    run_timer_base
> >      __run_timers
> >        call_timer_fn
> >          tcp_write_timer
> >            bh_lock_sock
> >              spin_lock(&((__sk)->sk_lock.slock))
> >                _raw_spin_lock
> >                  lock_acquire
> >                    __lock_acquire
> >                      check_wait_context
> >                        hlock_class
> >                         if (!test_bit(class_idx, lock_classes_in_use)) {
> >                            return NULL;
> >                        hlock_class(next)->wait_type_inner; // Null pointer dereference
> > ```
> > 
> > The problem lies within lockdep, as Kuniyuki says:
> > 
> > > I tried the repro and confirmed it triggers null deref.
> > > 
> > > It happens in LOCKDEP internal, so for me it looks like a problem in
> > > LOCKDEP rather than CIFS or TCP.
> > > 
> > > I think LOCKDEP should hold a module reference and prevent related
> > > modules from being unloaded.
> > 
> > Regarding the deadlock issue, it is clear that the locks mentioned in the deadlock warning
> > do not belong to the same lock instance. A deadlock should not occur.
> > 
> > ### Discussion Points
> > 
> > 1. API Design Question: Is this fundamentally an issue with how CIFS uses the socket
> >     API, or is it a networking layer issue that should handle socket cleanup differently?
> > 
> > 2. Approach to Resolution: Would it be better to:
> >     - Revert to the original solution (setting `sk->sk_net_refcnt = 1`) from ef7134c7fc48?
> >     - Work with networking subsystem maintainers on a more comprehensive solution that
> >       handles socket cleanup properly?

I verified the patch below fixed the null-ptr-deref in lockdep by
preventing cifs from being unloaded while TCP sockets are alive.

I'll post this officialy, and once this is merged and pulled into
the cifs tree, I'll send a revert of e9f2517a3e18.

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..e6515ef9116a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -547,6 +547,10 @@ struct sock {
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 struct sock_bh_locked {
@@ -1583,6 +1587,16 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	sk_mem_reclaim(sk);
 }
 
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+static inline void sk_set_owner(struct sock *sk, struct module *owner)
+{
+	__module_get(owner);
+	sk->sk_owner = owner;
+}
+#else
+#define sk_set_owner(sk, owner)
+#endif
+
 /*
  * Macro so as to not evaluate some arguments when
  * lockdep is not enabled.
@@ -1592,6 +1606,7 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
  */
 #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
 do {									\
+	sk_set_owner(sk, THIS_MODULE);					\
 	sk->sk_lock.owned = 0;						\
 	init_waitqueue_head(&sk->sk_lock.wq);				\
 	spin_lock_init(&(sk)->sk_lock.slock);				\
diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..b54f12faad1c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2324,6 +2324,12 @@ static void __sk_destruct(struct rcu_head *head)
 		__netns_tracker_free(net, &sk->ns_tracker, false);
 		net_passive_dec(net);
 	}
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	if (sk->sk_owner)
+		module_put(sk->sk_owner);
+#endif
+
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
---8<---


