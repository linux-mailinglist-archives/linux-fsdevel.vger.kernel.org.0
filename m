Return-Path: <linux-fsdevel+bounces-45491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F7A78764
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976B01892189
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F968230BE5;
	Wed,  2 Apr 2025 04:49:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220371EA90;
	Wed,  2 Apr 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569397; cv=none; b=ugMcmyArV7qDwn47N7orQr+k4CtJ0wLDSJK8VAySwW0BHSJ4gKXB4NGk0TWGECoSRL+ePFOTcsyuuO+3arHhZtpNKZnIcLxHuvFUofWB6BH4maZNEiKdaYriyOe6qJ4XcNpekoi+VJBRs0/7cgZRibFZLJFtnDRYEsQbtTU1Itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569397; c=relaxed/simple;
	bh=9m0e7crQ9Tm/COI28RDj/VbGs0vzyR5dA1r/D/Csyc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N5fJXoHYVn8guhIlb+K/vRfDzKkfsIqXQq1oIw7DMKuBP7+7bWq1lkeoplMo0Qtx7hXAcVNEhR+tCkK9wGfLl7owCQAIAw7oVaGlvZSwagKvTNxrIUWAZ5W1FnG0Sr0HfWFogWGpkZU8MKpzAQcp90iU3Z4pPmIJEfqih6FCNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSC810KQzz13KhH;
	Wed,  2 Apr 2025 12:49:21 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D420140360;
	Wed,  2 Apr 2025 12:49:52 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 12:49:51 +0800
Message-ID: <36dc113c-383e-4b8a-88c1-6a070e712086@huawei.com>
Date: Wed, 2 Apr 2025 12:49:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <edumazet@google.com>, <ematsumiya@suse.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-net@vger.kernel.org>, <smfrench@gmail.com>,
	<zhangchangzhong@huawei.com>, <cve@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <sfrench@samba.org>
References: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
 <20250402020807.28583-1-kuniyu@amazon.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <20250402020807.28583-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Yes, it seems the previous description might not have been entirely clear.
I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
does not actually address any real issues. It also fails to resolve the null pointer
dereference problem within lockdep. On top of that, it has caused a series of
subsequent leakage issues.

We will indeed need the CNA team to update the description once the correct fix
is merged.

Best regards,
Wang Zhaolong


> From: Wang Zhaolong <wangzhaolong1@huawei.com>
> Date: Tue, 1 Apr 2025 21:54:47 +0800
>> Hi.
>>
>> My colleagues and I have been investigating the issue addressed by this patch
>> and have discovered some significant concerns that require broader discussion.
>>
>> ### Socket Leak Issue
>>
>> After testing this patch extensively, I've confirmed it introduces a socket leak
>> when TCP connections don't complete proper termination (e.g., when FIN packets
>> are dropped). The leak manifests as a continuous increase in TCP slab usage:
>>
>> I've documented this issue with a reproducer in Bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=219972#c0
>>
>> The key issue appears to stem from the interaction between the SMB client and TCP
>> socket lifecycle management:
>>
>> 1. Removing `sk->sk_net_refcnt = 1` causes TCP timers to be terminated early in
>>      `tcp_close()` via the `inet_csk_clear_xmit_timers_sync()` call when
>>      `!sk->sk_net_refcnt`
>> 2. This early timer termination prevents proper reference counting resolution
>>      when connections don't complete the 4-way TCP termination handshake
>> 3. The resulting socket references are never fully released, leading to a leak
>>
>> #### Timeline of Related Changes
>>
>> 1. v4.2-rc1 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets")
>>      - Added `sk_net_refcnt` field to distinguish user sockets (=1) from kernel sockets (=0)
>>      - Kernel sockets don't hold netns references, which can lead to potential UAF issues
>>
>> 2. v6.9-rc2 151c9c724d05: ("tcp: properly terminate timers for kernel sockets")
>>      - Modified `tcp_close()` to check `sk->sk_net_refcnt` and explicitly terminate timers for kernel sockets (=0)
>>      - This prevents UAF when netns is destroyed before socket timers complete
>>      - **Key change**: If `!sk->sk_net_refcnt`, call `inet_csk_clear_xmit_timers_sync()`
>>
>> 3. v6.12-rc7 ef7134c7fc48: ("smb: client: Fix use-after-free of network namespace")
>>      - Fixed netns UAF in CIFS by manually setting `sk->sk_net_refcnt = 1`
>>      - Also called `maybe_get_net()` to maintain netns references
>>      - This effectively made kernel sockets behave like user sockets for reference counting
>>
>> 4. v6.13-rc4 e9f2517a3e18: ("smb: client: fix TCP timers deadlock after rmmod")
>>      - Problem commit: Removed `sk->sk_net_refcnt = 1` setting
>>      - Changed to using explicit `get_net()/put_net()` at CIFS layer
>>      - This change leads to socket leaks because timers are terminated early
>>
>> ### Lockdep Warning Analysis
>>
>> I've also investigated the lockdep warning mentioned in the patch. My analysis
>> suggests it may be a false positive rather than an actual deadlock. The crash
>> actually occurs in the lockdep subsystem itself (null pointer dereference in
>> `check_wait_context()`), not in the CIFS or networking code directly.
>>
>> The procedure for the null pointer dereference is as follows:
>>
>> When lockdep is enabled, the lock class "slock-AF_INET-CIFS" is set when a socket
>> connection is established.
>>
>> ```
>> cifs_do_mount
>>     cifs_mount
>>       mount_get_conns
>>         cifs_get_tcp_session
>>           ip_connect
>>             generic_ip_connect
>>               cifs_reclassify_socket4
>>                 sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
>>                   lockdep_init_map
>>                     lockdep_init_map_wait
>>                       lockdep_init_map_type
>>                         lockdep_init_map_type
>>                           register_lock_class
>>                             __set_bit(class - lock_classes, lock_classes_in_use);
>> ```
>>
>> When the module is unloaded, the lock class is cleaned up.
>>
>> ```
>> free_mod_mem
>>     lockdep_free_key_range
>>       __lockdep_free_key_range
>>         zap_class
>>           __clear_bit(class - lock_classes, lock_classes_in_use);
>> ```
>>
>> After the module is uninstalled and the network connection is restored, the
>> timer is woken up.
>>
>> ```
>> run_timer_softirq
>>     run_timer_base
>>       __run_timers
>>         call_timer_fn
>>           tcp_write_timer
>>             bh_lock_sock
>>               spin_lock(&((__sk)->sk_lock.slock))
>>                 _raw_spin_lock
>>                   lock_acquire
>>                     __lock_acquire
>>                       check_wait_context
>>                         hlock_class
>>                          if (!test_bit(class_idx, lock_classes_in_use)) {
>>                             return NULL;
>>                         hlock_class(next)->wait_type_inner; // Null pointer dereference
>> ```
>>
>> The problem lies within lockdep, as Kuniyuki says:
>>
>>> I tried the repro and confirmed it triggers null deref.
>>>
>>> It happens in LOCKDEP internal, so for me it looks like a problem in
>>> LOCKDEP rather than CIFS or TCP.
>>>
>>> I think LOCKDEP should hold a module reference and prevent related
>>> modules from being unloaded.
>>
>> Regarding the deadlock issue, it is clear that the locks mentioned in the deadlock warning
>> do not belong to the same lock instance. A deadlock should not occur.
>>
>> ### Discussion Points
>>
>> 1. API Design Question: Is this fundamentally an issue with how CIFS uses the socket
>>      API, or is it a networking layer issue that should handle socket cleanup differently?
>>
>> 2. Approach to Resolution: Would it be better to:
>>      - Revert to the original solution (setting `sk->sk_net_refcnt = 1`) from ef7134c7fc48?
>>      - Work with networking subsystem maintainers on a more comprehensive solution that
>>        handles socket cleanup properly?
>>
>> 3.  CVE Process Question: Given that CVE-2024-54680 appears to "fix" a non-existent issue
>>       while introducing an actual vulnerability, what's the appropriate way to address this?
> 
> I tested on 6.14 and e9f2517a3e18, but the issue still reproduces,
> so e9f2517a3e18 is a bogus fix, and we will need to ask the CNA team
> to update the description once the correct fix is merged.
> 

