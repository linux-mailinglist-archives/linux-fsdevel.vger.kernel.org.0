Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F686305D55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhA0NgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 08:36:19 -0500
Received: from mail.windriver.com ([147.11.1.11]:64027 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbhA0Nej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:34:39 -0500
Received: from pek-ygao-d1.windriver.com (pek-ygao-d1.corp.ad.wrs.com [128.224.155.99])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 107978DL008278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jan 2021 01:07:10 -0800 (PST)
References: <20201209112100.47653-1-yahu.gao@windriver.com> <87zh2mprwl.fsf@x220.int.ebiederm.org>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Gao Yahu <yahu.gao@windriver.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Yahu Gao <yahu.gao@windriver.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Review request 0/1: fs/proc: Fix NULL pointer dereference in
In-reply-to: <87zh2mprwl.fsf@x220.int.ebiederm.org>
Date:   Thu, 07 Jan 2021 17:07:08 +0800
Message-ID: <87pn2h9kub.fsf@pek-ygao-d1>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric W. Biederman <ebiederm@xmission.com> writes:

> [Please note this e-mail is from an EXTERNAL e-mail address]
>
> Yahu Gao <yahu.gao@windriver.com> writes:
>
>> There is a kernel NULL pointer dereference was found in Linux system.
>> The details of kernel NULL is shown at bellow.
>>
>> Currently, we do not have a way to provoke this fault on purpose, but
>> the reproduction rate in out CI loops is high enough that we could go
>> for a trace patch in black or white UP and get a reproduction in few
>> weeks.
>>
>> Our kernel version is 4.1.21, but via analyzing the source code of the
>> call trace. The upstream version should be affected. Really sorry for
>> havn't reproduced this in upstream version. But it's easier to be safe
>> than to prove it can't happen, right?
>
> Except I there are strong invariants that suggests that it takes
> a memory stomp to get a NULL pointer deference here.
>

Sorry for late reply. I took a long time to find root cause of memory stomp,
but got nothing for now:(

> For the life of a proc inode PROC_I(inode)->pid should be non-NULL.
>
> For a non-NULL pid pointer ->tasks[PIDTYPE_PID].first simply reads
> an entry out of the struct pid.  Only pid needs to be non-NULL.
>
> So I don't see how you are getting a NULL pointer derference.
>
> Have you decoded the oops, looked at the assembly and seen which field
> is NULL?  I expec that will help you track down what is wrong.
>

There are two messages I had found:
1. 'Unable to handle kernel NULL pointer dereference at virtual address
 00000008'.
2. In kernel 4.1.21, the members of 'struct pid' likes follow:
(Apologize for missing this message at first)
...
struct pid
{
        atomic_t count;
        unsigned int level;
        /* lists of tasks that use this pid */
        struct hlist_head tasks[PIDTYPE_MAX];
        struct rcu_head rcu;
        struct upid numbers[1];
};
...
The offset of the member *tasks* from *struct pid* is 0x00000008.

Based on the above message, I thought we got a NULL pointer of struct
pid.

Regards,
Yahu

>
>> Details of kernel crash:
>> ----------------------------------------------------------------------
>> [1446.285834] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000008
>> [ 1446.293943] pgd = e4af0880
>> [ 1446.296656] [00000008] *pgd=10cc3003, *pmd=04153003, *pte=00000000
>> [ 1446.302898] Internal error: Oops: 207 1 PREEMPT SMP ARM
>> [ 1446.302950] Modules linked in: adkNetD ncp
>> lttng_ring_buffer_client_mmap_overwrite(C)
>> lttng_ring_buffer_client_mmap_discard(C)
>> lttng_ring_buffer_client_discard(C)
>> lttng_ring_buffer_metadata_mmap_client(C) lttng_probe_printk(C)
>> lttng_probe_irq(C) lttng_ring_buffer_metadata_client(C)
>> lttng_ring_buffer_client_overwrite(C) lttng_probe_signal(C)
>> lttng_probe_sched(C) lttng_tracer(C) lttng_statedump(C)
>> lttng_lib_ring_buffer(C) lttng_clock_plugin_arm_cntpct(C) lttng_clock(C)
>> [ 1446.302963] CPU: 0 PID: 12086 Comm: netstat Tainted: G C
>> 4.1.21-rt13-* #1
>> [ 1446.302967] Hardware name: Ericsson CPM1
>> [ 1446.302972] task: cbd75480 ti: c4a68000 task.ti: c4a68000
>> [ 1446.302984] PC is at pid_delete_dentry+0x8/0x18
>> [ 1446.302992] LR is at dput+0x1a8/0x2b4
>> [ 1446.303003] pc : [] lr : [] psr: 20070013
>> [ 1446.303003] sp : c4a69e88 ip : 00000000 fp : 00000000
>> [ 1446.303007] r10: 000218cc r9 : cd228000 r8 : e5f44320
>> [ 1446.303011] r7 : 00000001 r6 : 00080040 r5 : c4aa97d0 r4 : c4aa9780
>> [ 1446.303015] r3 : 00000000 r2 : cbd75480 r1 : 00000000 r0 : c4aa9780
>> [ 1446.303020] Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment
>> user
>> [ 1446.303026] Control: 30c5387d Table: 24af0880 DAC: 000000fd
>> [ 1446.303033] Process netstat (pid: 12086, stack limit = 0xc4a68218)
>> [ 1446.303039] Stack: (0xc4a69e88 to 0xc4a6a000)
>> [ 1446.303052] 9e80: c4a69f70 0000a1c0 c4a69f13 00000002 e5f44320
>> cd228000
>> [ 1446.303059] 9ea0: 000218cc c0571604 c0a60bcc 00000000 00000000
>> 00000000 c4a69f20 c4a69f15
>> [ 1446.303065] 9ec0: 00003133 00000002 c4a69f13 00000000 0000001f
>> c4a69f70 c35de800 0000007c
>> [ 1446.303072] 9ee0: ce2b1c00 cd228000 00000001 c05747b8 c05745cc
>> c35de800 0000001f 00000000
>> [ 1446.303078] 9f00: 00000004 cd228008 00020000 c05745cc 33000004
>> c0400031 c4a68000 00000400
>> [ 1446.303086] 9f20: beb78c2c cd228000 c4a69f70 00000000 cd228008
>> c0ffca90 c4a68000 00000400
>> [ 1446.303103] 9f40: beb78c2c c052cd0c bf08a774 00000400 01480080
>> 00008000 cd228000 cd228000
>> [ 1446.303114] 9f60: c040f7c8 c4a68000 00000400 c052d22c c052cd8c
>> 00000000 00000021 00000000
>> [ 1446.303127] 9f80: 01480290 01480280 00007df0 ffffffea 01480060
>> 01480060 01480064 b6e424c0
>> [ 1446.303143] 9fa0: 0000008d c040f794 01480060 01480064 00000004
>> 01480080 00008000 00000000
>> [ 1446.303150] 9fc0: 01480060 01480064 b6e424c0 0000008d 01480080
>> 01480060 00035440 beb78c2c
>> [ 1446.303156] 9fe0: 01480080 beb78160 b6ede59c b6edea3c 60070010
>> 00000004 00000000 00000000
>> [ 1446.303167] [] (pid_delete_dentry) from [] (dput+0x1a8/0x2b4)
>> [ 1446.303176] [] (dput) from [] (proc_fill_cache+0x54/0x10c)
>> [ 1446.303189] [] (proc_fill_cache) from []
>> (proc_readfd_common+0xd8/0x238)
>> [ 1446.303203] [] (proc_readfd_common) from [] (iterate_dir+0x98/0x118)
>> [ 1446.303217] [] (iterate_dir) from [] (SyS_getdents+0x7c/0xf0)
>> [ 1446.303233] [] (SyS_getdents) from [] (__sys_trace_return+0x0/0x2c)
>> [ 1446.303243] Code: e8bd0030 e12fff1e e5903028 e5133020 (e5930008)
>
> Eric

