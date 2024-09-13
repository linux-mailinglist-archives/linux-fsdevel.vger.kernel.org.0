Return-Path: <linux-fsdevel+bounces-29315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD297810E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C42819D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A11DB531;
	Fri, 13 Sep 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="mLc2s0LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C01DA608;
	Fri, 13 Sep 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233851; cv=none; b=e9R49h8SAZ0/kjtx0izZi76rASkEGikjZWWHIbd0yreKH5EwG3CV4mMowi2HzQx57ojjs+O01/4qxeJhYzEKp+O0eH2CpkHKIcCP/2g4WNBsv73jNM12FqO9BhRQW3MP2wLmUNzehPXDq1wi2uZZ1oHkMZjxd8UUby8556UCB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233851; c=relaxed/simple;
	bh=FO62iVSVH951xT1SG11mEf68oQIoIQ3s1YOTTvAaGjY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L6ATDFxQgEOE3jQdleaAyQISR555nKf9k6Z9XipEKBST2vV7QENAHVCgsPQvM85cjSlgM5i4XRH1Myfbzb6y4OIRGbxyosaLxBlANyVvkLdGc4kiUQ53pkIG8P6rQ3QTMibmI28UDu82cHtd6e0eOWXnpsvCvYi1HexeK6BcPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=mLc2s0LW; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726233842;
	bh=9ms/1bNiozbIzjtyaq2G9oocw1Mq+E2nS4rMSUL9AII=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=mLc2s0LWky/EpR9tGbi/NI8DNLiF4gBtWFgN+OyY0kKHqdTPpsukoGGwCPe4PS//s
	 lUNVdCr78vu6GBSqQ92xqAHWANc9QXDhp6I3bLaGAnxOlnec/9cHyu0KKP/oHN7Q/o
	 PjblgjEy1+KbH/MqL1dayb0FUx2pmjD85Pylkh+E=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <ZuO1CtpGgwyf8Hui@casper.infradead.org>
Date: Fri, 13 Sep 2024 15:23:39 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 Dave Chinner <david@fromorbit.com>,
 clm@meta.com,
 regressions@lists.linux.dev,
 regressions@leemhuis.info,
 mironov.ivan@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAD926DD-8AE5-47DC-A7E3-9CF50646A6A0@flyingcircus.io>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <415b0e1a-c92f-4bf9-bccd-613f903f3c75@kernel.dk>
 <CAHk-=wg51pT_b+tgHuAaO6O0PT19WY9p3CXEqTn=LO8Zjaf=7A@mail.gmail.com>
 <ZuO1CtpGgwyf8Hui@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>

Hi,

> On 13. Sep 2024, at 05:44, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> My current best guess is that we have an xarray node with a stray =
pointer
> in it; that the node is freed from one xarray, allocated to a =
different
> xarray, but not properly cleared.  But I can't reproduce the problem,
> so that's pure speculation on my part.

I=E2=80=99d love to help with the reproduction. I understand that BZ is =
unloved and I guess putting everything I=E2=80=99ve seen so far from =
various sources into a single spot might help - unfortunately that =
creates a pretty long mail. I selectively didn=E2=80=99t inline some =
more far fetched things.

A tiny bit of context about me: I=E2=80=99m a seasoned developer, but =
not a kernel developer. I don=E2=80=99t know the subsystems from a code =
perspective. I stare at kernel code (or C code generally) mostly only =
when things go wrong. I did my share of debugging hard things over the =
last 25 years and I am good at trying to attack things from multiple =
angles.

I have 9 non-production VMs that exhibited the issue last year. I can =
put those on custom compiled kernels and instrument them as needed. Feel =
free to use me as a resource here.

Rabbit hole 1: the stalls and stack traces
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I=E2=80=99ve reviewed all of the stall messages (see below) that I could =
find and noticed:

- All of the VMs that are affected have at least 2 CPUs. I haven=E2=80=99t=
 seen this on any single CPU VMs AFAICT, but I wouldn=E2=80=99t fully =
eliminate that it could be possible to also be happening there. OTOH =
(obviously?) race conditions would be easier to produce on an multi =
processing machine than with a single core =E2=80=A6 ;)

- I=E2=80=99ve only ever seen it on virtual machines, however, there=E2=80=
=99s a redhat bug report from 2023 that shows data that points to an =
Asus board, so it looks like a physical machine, so I guess a =
physical/virtual machine distinction is not relevant.

- Most call stacks come from the VFS, but I=E2=80=99ve seen two that =
originate from a page fault (if I=E2=80=99m reading things correctly) - =
so trying to swap a page in? That=E2=80=99s interesting because it would =
hint at a reproducer that doesn=E2=80=99t need FS code being involved.

Here=E2=80=99s the stalls that I could recover from my efforts last =
year:

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=3Dbcec/1/0x4000000000000000 =
softirq=3D32229387/32229388 fqs=3D3407711
	(t=3D6825807 jiffies g=3D51307757 q=3D12582143 ncpus=3D2)
CPU: 1 PID: 135430 Comm: systemd-journal Not tainted 6.1.57 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__rcu_read_unlock+0x1d/0x30
Code: ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 65 48 8b 3c =
25 c0 0b 02 00 83 af 64 04 00 00 01 75 0a 8b 87 68 04 00 00 <85> c0 75 =
05 c3 cc cc cc cc e9 45 fe ff ff 0f 1f 44 00 00 0f 1f 44
RSP: 0018:ffffa9c442887c78 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffca97c0ed4000 RCX: 0000000000000000
RDX: ffff88a1919bb6d0 RSI: ffff88a1919bb6d0 RDI: ffff88a187480000
RBP: 0000000000000044 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000100cca
R13: ffff88a2a48836b0 R14: 0000000000001be0 R15: ffffca97c0ed4000
FS:  00007fa45ec86c40(0000) GS:ffff88a2fad00000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa45f436985 CR3: 000000010b4f8000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 ? rcu_dump_cpu_stacks+0xc8/0x100
 ? rcu_sched_clock_irq.cold+0x15b/0x2fb
 ? sched_slice+0x87/0x140
 ? perf_event_task_tick+0x64/0x370
 ? __cgroup_account_cputime_field+0x5b/0xa0
 ? update_process_times+0x77/0xb0
 ? tick_sched_handle+0x34/0x50
 ? tick_sched_timer+0x6f/0x80
 ? tick_sched_do_timer+0xa0/0xa0
 ? __hrtimer_run_queues+0x112/0x2b0
 ? hrtimer_interrupt+0xfe/0x220
 ? __sysvec_apic_timer_interrupt+0x7f/0x170
 ? sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? __rcu_read_unlock+0x1d/0x30
 ? xas_load+0x30/0x40
 __filemap_get_folio+0x10a/0x370
 filemap_fault+0x139/0x910
 ? preempt_count_add+0x47/0xa0
 __do_fault+0x31/0x80
 do_fault+0x299/0x410
 __handle_mm_fault+0x623/0xb80
 handle_mm_fault+0xdb/0x2d0
 do_user_addr_fault+0x19c/0x560
 exc_page_fault+0x66/0x150
 asm_exc_page_fault+0x22/0x30
RIP: 0033:0x7fa45f4369af
Code: Unable to access opcode bytes at 0x7fa45f436985.
RSP: 002b:00007fff3ec0a580 EFLAGS: 00010246
RAX: 0000002537ea8ea4 RBX: 00007fff3ec0aab0 RCX: 0000000000000000
RDX: 00007fa45a3dffd0 RSI: 00007fa45a3e0010 RDI: 000055e348682520
RBP: 0000000000000015 R08: 000055e34862fd00 R09: 00007fff3ec0b1b0
R10: 0000000000000000 R11: 0000000000000000 R12: 00007fff3ec0a820
R13: 00007fff3ec0a640 R14: 2f4f057952ecadbd R15: 0000000000000000
 </TASK>


rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:         1-....: (21000 ticks this GP) =
idle=3Dd1e4/1/0x4000000000000000 softirq=3D87308049/87308049 fqs=3D5541
        (t=3D21002 jiffies g=3D363533457 q=3D100563 ncpus=3D5)
rcu: rcu_preempt kthread starved for 8417 jiffies! g363533457 f0x0 =
RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D4
rcu:         Unless rcu_preempt kthread gets sufficient CPU time, OOM is =
now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:0     pid:15    =
ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 ? rcu_gp_cleanup+0x570/0x570
 __schedule+0x35d/0x1370
 ? get_nohz_timer_target+0x18/0x190
 ? _raw_spin_unlock_irqrestore+0x23/0x40
 ? __mod_timer+0x281/0x3d0
 ? rcu_gp_cleanup+0x570/0x570
 schedule+0x5d/0xe0
 schedule_timeout+0x94/0x150
 ? __bpf_trace_tick_stop+0x10/0x10
 rcu_gp_fqs_loop+0x15b/0x650
 rcu_gp_kthread+0x1a9/0x280
 kthread+0xe9/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 4:
NMI backtrace for cpu 4
CPU: 4 PID: 529675 Comm: connection Not tainted 6.1.57 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:xas_descend+0x3/0x90
Code: 48 8b 57 08 48 89 57 10 e9 3a c6 2c 00 48 8b 57 10 48 89 07 48 c1 =
e8 20 48 89 57 08 e9 26 c6 2c 00 cc cc cc cc cc cc 0f b6 0e <48> 8b 57 =
08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48
RSP: 0018:ffffa37c47ccfbf8 EFLAGS: 00000246
RAX: ffff92832453e912 RBX: ffffa37c47ccfd78 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffff92832453e910 RDI: ffffa37c47ccfc08
RBP: 0000000000006305 R08: ffffa37c47ccfe70 R09: ffff92830f538138
R10: ffffa37c47ccfe68 R11: ffff92830f538138 R12: 0000000000006305
R13: ffff92832b518900 R14: 0000000000006305 R15: ffffa37c47ccfe98
FS:  00007fcbee42b6c0(0000) GS:ffff9287a9c00000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc0b10d0d8 CR3: 0000000107632000 CR4: 00000000003506e0
Call Trace:
 <NMI>
 ? nmi_cpu_backtrace.cold+0x1b/0x76
 ? nmi_cpu_backtrace_handler+0xd/0x20
 ? nmi_handle+0x5d/0x120
 ? xas_descend+0x3/0x90
 ? default_do_nmi+0x69/0x170
 ? exc_nmi+0x13c/0x170
 ? end_repeat_nmi+0x16/0x67
 ? xas_descend+0x3/0x90
 ? xas_descend+0x3/0x90
 ? xas_descend+0x3/0x90
 </NMI>
 <TASK>
 xas_load+0x30/0x40
 filemap_get_read_batch+0x16e/0x250
 filemap_get_pages+0xa9/0x630
 ? current_time+0x3c/0x100
 ? atime_needs_update+0x104/0x180
 ? touch_atime+0x46/0x1f0
 filemap_read+0xd2/0x340
 xfs_file_buffered_read+0x4f/0xd0 [xfs]
 xfs_file_read_iter+0x6a/0xd0 [xfs]
 vfs_read+0x23c/0x310
 ksys_read+0x6b/0xf0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x7fd0ccf0f78c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 bb f8 ff 48 =
8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 =
f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 ff bb f8 ff 48
RSP: 002b:00007fcbee427320 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd0ccf0f78c
RDX: 0000000000000014 RSI: 00007fcbee427500 RDI: 0000000000000129
RBP: 00007fcbee427430 R08: 0000000000000000 R09: 00a9b630ab4578b9
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fcbee42a9f8
R13: 0000000000000014 R14: 00000000040ef680 R15: 0000000000000129
 </TASK>
CPU: 1 PID: 529591 Comm: connection Not tainted 6.1.57 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:xas_descend+0x18/0x90
Code: c1 e8 20 48 89 57 08 e9 26 c6 2c 00 cc cc cc cc cc cc 0f b6 0e 48 =
8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 <48> 89 77 =
18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d fd 00 00 00
RSP: 0018:ffffa37c47b7fbf8 EFLAGS: 00000216
RAX: fffff6e88448e000 RBX: ffffa37c47b7fd78 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffff92832453e910 RDI: ffffa37c47b7fc08
RBP: 000000000000630d R08: ffffa37c47b7fe70 R09: ffff92830f538138
R10: ffffa37c47b7fe68 R11: ffff92830f538138 R12: 000000000000630d
R13: ffff92830b9a3b00 R14: 000000000000630d R15: ffffa37c47b7fe98
FS:  00007fcbf07bb6c0(0000) GS:ffff9287a9900000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc0ac8e360 CR3: 0000000107632000 CR4: 00000000003506e0
Call Trace:
 <IRQ>
 ? rcu_dump_cpu_stacks+0xc8/0x100
 ? rcu_sched_clock_irq.cold+0x15b/0x2fb
 ? sched_slice+0x87/0x140
 ? perf_event_task_tick+0x64/0x370
 ? __cgroup_account_cputime_field+0x5b/0xa0
 ? update_process_times+0x77/0xb0
 ? tick_sched_handle+0x34/0x50
 ? tick_sched_timer+0x6f/0x80
 ? tick_sched_do_timer+0xa0/0xa0
 ? __hrtimer_run_queues+0x112/0x2b0
 ? hrtimer_interrupt+0xfe/0x220
 ? __sysvec_apic_timer_interrupt+0x7f/0x170
 ? sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? xas_descend+0x18/0x90
 xas_load+0x30/0x40
 filemap_get_read_batch+0x16e/0x250
 filemap_get_pages+0xa9/0x630
 ? current_time+0x3c/0x100
 ? atime_needs_update+0x104/0x180
 ? touch_atime+0x46/0x1f0
 filemap_read+0xd2/0x340
 xfs_file_buffered_read+0x4f/0xd0 [xfs]
 xfs_file_read_iter+0x6a/0xd0 [xfs]
 vfs_read+0x23c/0x310
 ksys_read+0x6b/0xf0
 do_syscall_64+0x3a/0x90
 </TASK>


rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:    0-....: (21000 ticks this GP) idle=3D91fc/1/0x4000000000000000 =
softirq=3D85252827/85252827 fqs=3D4704
        (t=3D21002 jiffies g=3D167843445 q=3D13889 ncpus=3D3)
CPU: 0 PID: 2202919 Comm: .postgres-wrapp Not tainted 6.1.31 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:xas_descend+0x26/0x70
Code: cc cc cc cc 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 =
04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 <75> 08 48 =
3d fd 00 00 0>
RSP: 0018:ffffb427c4917bf0 EFLAGS: 00000246
RAX: ffff98871f8dbdaa RBX: ffffb427c4917d70 RCX: 0000000000000002
RDX: 0000000000000005 RSI: ffff988876d3c000 RDI: ffffb427c4917c00
RBP: 000000000000f177 R08: ffffb427c4917e68 R09: ffff988846485d38
R10: ffffb427c4917e60 R11: ffff988846485d38 R12: 000000000000f177
R13: ffff988827b4ae00 R14: 000000000000f176 R15: ffffb427c4917e90
FS:  00007ff8de817800(0000) GS:ffff98887ac00000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff881c8c000 CR3: 000000010dfea000 CR4: 00000000000006f0

(stack trace is missing in this one)

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:         1-....: (20915 ticks this GP) =
idle=3D4b8c/1/0x4000000000000000 softirq=3D138338523/138338526 fqs=3D6063
        (t=3D21000 jiffies g=3D180955121 q=3D35490 ncpus=3D2)
CPU: 1 PID: 1415835 Comm: .postgres-wrapp Not tainted 6.1.57 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:filemap_get_read_batch+0x16e/0x250
Code: 85 ff 00 00 00 48 83 c4 40 5b 5d c3 cc cc cc cc f0 ff 0e 0f 84 e1 =
00 00 00 48 c7 44 24 18 03 00 00 00 48 89 e7 e8 42 ab 6d 00 <48> 89 c7 =
48 85 ff 74 ba 48 81 ff 06 04 00 00 0f 85 fe fe ff ff 48
RSP: 0018:ffffac01c6887c00 EFLAGS: 00000246
RAX: ffffe5a104574000 RBX: ffffac01c6887d70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff96db861bcb68 RDI: ffffac01c6887c00
RBP: 0000000000014781 R08: ffffac01c6887e68 R09: ffff96dad46fad38
R10: ffffac01c6887e60 R11: ffff96dad46fad38 R12: 0000000000014781
R13: ffff96db86f47000 R14: 0000000000014780 R15: ffffac01c6887e90
FS:  00007f9ba0a12800(0000) GS:ffff96dbbbd00000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b5050a018 CR3: 000000010ac82000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 ? rcu_dump_cpu_stacks+0xc8/0x100
 ? rcu_sched_clock_irq.cold+0x15b/0x2fb
 ? sched_slice+0x87/0x140
 ? timekeeping_update+0xdd/0x130
 ? __cgroup_account_cputime_field+0x5b/0xa0
 ? update_process_times+0x77/0xb0
 ? update_wall_time+0xc/0x20
 ? tick_sched_handle+0x34/0x50
 ? tick_sched_timer+0x6f/0x80
 ? tick_sched_do_timer+0xa0/0xa0
 ? __hrtimer_run_queues+0x112/0x2b0
 ? hrtimer_interrupt+0xfe/0x220
 ? __sysvec_apic_timer_interrupt+0x7f/0x170
 ? sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? filemap_get_read_batch+0x16e/0x250
 filemap_get_pages+0xa9/0x630
 ? iomap_iter+0x78/0x310
 ? iomap_file_buffered_write+0x8f/0x2f0
 filemap_read+0xd2/0x340
 xfs_file_buffered_read+0x4f/0xd0 [xfs]
 xfs_file_read_iter+0x6a/0xd0 [xfs]
 vfs_read+0x23c/0x310
 __x64_sys_pread64+0x94/0xc0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x7f9ba0b0d787
Code: 48 e8 5d dc f2 ff 41 b8 02 00 00 00 e9 38 f6 ff ff 66 90 f3 0f 1e =
fa 80 3d 7d bc 0e 00 00 49 89 ca 74 10 b8 11 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 59 c3 48 83 ec 28 48 89 54 24 10 48 89 74 24
RSP: 002b:00007ffe56bb0878 EFLAGS: 00000202 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ba0b0d787
RDX: 0000000000002000 RSI: 00007f9b5c85ce80 RDI: 000000000000003a
RBP: 0000000000000001 R08: 000000000a00000d R09: 0000000000000000
R10: 0000000014780000 R11: 0000000000000202 R12: 00007f9b90052ab0
R13: 00005566dc227f75 R14: 00005566dc22c510 R15: 00005566de3cf0c0
 </TASK>


rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (21000 ticks this GP) idle=3D947c/1/0x4000000000000000 =
softirq=3D299845076/299845076 fqs=3D5249
	(t=3D21002 jiffies g=3D500931101 q=3D17117 ncpus=3D2)
CPU: 1 PID: 1660396 Comm: nix-collect-gar Not tainted 6.1.55 #1-NixOS
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__xas_next+0x0/0xe0
Code: 48 3d 00 10 00 00 77 c8 48 89 c8 c3 cc cc cc cc e9 f5 fe ff ff 48 =
c7 47 18 01 00 00 00 31 c9 48 89 c8 c3 cc cc cc cc 0f 1f 00 <48> 8b 47 =
18 a8 02 75 0e 48 83 47 08 01 48 85 c0 0f 84 b5 00 00 00
RSP: 0018:ffffb170866f7bf8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffb170866f7d70 RCX: 0000000000000000
RDX: 0000000000000020 RSI: ffff8ab97d5306d8 RDI: ffffb170866f7c00
RBP: 00000000000011e4 R08: 0000000000000000 R09: ffff8ab9a4dc3d38
R10: ffffb170866f7e60 R11: ffff8ab9a4dc3d38 R12: 00000000000011e4
R13: ffff8ab946fda400 R14: 00000000000011e4 R15: ffffb170866f7e90
FS:  00007f17d22e3f80(0000) GS:ffff8ab9bdd00000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000013279e8 CR3: 00000000137c8000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 ? rcu_dump_cpu_stacks+0xc8/0x100
 ? rcu_sched_clock_irq.cold+0x15b/0x2fb
 ? sched_slice+0x87/0x140
 ? perf_event_task_tick+0x64/0x370
 ? __cgroup_account_cputime_field+0x5b/0xa0
 ? update_process_times+0x77/0xb0
 ? tick_sched_handle+0x34/0x50
 ? tick_sched_timer+0x6f/0x80
 ? tick_sched_do_timer+0xa0/0xa0
 ? __hrtimer_run_queues+0x112/0x2b0
 ? hrtimer_interrupt+0xfe/0x220
 ? __sysvec_apic_timer_interrupt+0x7f/0x170
 ? sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? __xas_prev+0xe0/0xe0
 ? xas_load+0x30/0x40
 filemap_get_read_batch+0x16e/0x250
 filemap_get_pages+0xa9/0x630
 ? atime_needs_update+0x104/0x180
 ? touch_atime+0x46/0x1f0
 filemap_read+0xd2/0x340
 xfs_file_buffered_read+0x4f/0xd0 [xfs]
 xfs_file_read_iter+0x6a/0xd0 [xfs]
 vfs_read+0x23c/0x310
 __x64_sys_pread64+0x94/0xc0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x7f17d3a2d7c7
Code: 08 89 3c 24 48 89 4c 24 18 e8 75 db f8 ff 4c 8b 54 24 18 48 8b 54 =
24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 =
f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 c5 db f8 ff 48 8b
RSP: 002b:00007ffffd9d0fb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f17d3a2d7c7
RDX: 0000000000001000 RSI: 000056435be0ccf8 RDI: 0000000000000006
RBP: 00000000011e4000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000011e4000 R11: 0000000000000293 R12: 0000000000001000
R13: 000056435be0ccf8 R14: 0000000000001000 R15: 000056435bdea370
 </TASK>

I=E2=80=99ve pulled together the various states the stall was detected =
in a more compact form:

 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? __rcu_read_unlock+0x1d/0x30
 ? xas_load+0x30/0x40
 __filemap_get_folio+0x10a/0x370
 filemap_fault+0x139/0x910

 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? __xas_prev+0xe0/0xe0
 ? xas_load+0x30/0x40
 filemap_get_read_batch+0x16e/0x250

 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? filemap_get_read_batch+0x16e/0x250

 xas_load+0x30/0x40
 filemap_get_read_batch+0x16e/0x250

RIP: 0010:xas_descend+0x26/0x70 (this one was missing the stack trace)

I tried reading through the xarray code, but my C and kernel knowledge =
is stretched thin trying to understand some of the internals: I =
couldn=E2=80=99t figure out how __rcu_read_unlock appears from within =
xas_load, similar to __xas_prev. I stopped diving deeper at that point.

My original bug report also includes an initial grab of multiple stall =
reports over time on a single machine where the situation unfolded with =
different stack traces over many hours. It=E2=80=99s a bit long so I=E2=80=
=99m opting to provide the link: =
https://bugzilla.kernel.org/show_bug.cgi?id=3D217572#c0=20

I also was wondering whether the stall is stuck or spinning and one of =
my early comments noticed that with 3 CPUs I had a total of 60% spent in =
system time, so this sounds like it might be spinning between xas_load =
and xas_descend. I see there=E2=80=99s some kind of retry mechanism in =
there and while-loops that might get stuck if the data structures are =
borked. I think it=E2=80=99s alternating between xas_load and =
xas_descend, though, so not stuck in xas_descend=E2=80=99s loop itself.

The redhat report "large folio related page cache iteration hang=E2=80=9D =
(https://bugzilla.redhat.com/show_bug.cgi?id=3D2213967) does show a =
=E2=80=9Ckernel bug=E2=80=9D message in addition to the known stack =
around xas_load:

kernel: watchdog: BUG: soft lockup - CPU#28 stuck for 26s! =
[rocksdb:low:2195]
kernel: Modules linked in: tls nf_conntrack_netbios_ns =
nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 =
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct =
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel =
udp_tunnel tcp_bbr rfkill ip_set nf_tables nfnetlink nct6775 =
nct6775_core tun hwmon_vid jc42 vfat fat ipmi_ssif intel_rapl_msr =
intel_rapl_common amd64_edac edac_mce_amd kvm_amd snd_hda_intel =
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core kvm =
snd_hwdep snd_pcm snd_timer cdc_ether irqbypass acpi_ipmi snd usbnet =
wmi_bmof rapl ipmi_si k10temp soundcore i2c_piix4 joydev mii =
ipmi_devintf ipmi_msghandler fuse loop xfs uas usb_storage raid1 =
hid_cp2112 igb crct10dif_pclmul ast crc32_pclmul nvme crc32c_intel =
polyval_clmulni dca polyval_generic i2c_algo_bit nvme_core =
ghash_clmulni_intel ccp sha512_ssse3 wmi sp5100_tco nvme_common
kernel: CPU: 28 PID: 2195 Comm: rocksdb:low Not tainted =
6.3.5-100.fc37.x86_64 #1
kernel: Hardware name: To Be Filled By O.E.M. X570D4U/X570D4U, BIOS =
T1.29b 05/17/2022
kernel: RIP: 0010:xas_load+0x45/0x50
kernel: Code: 3d 00 10 00 00 77 07 5b 5d c3 cc cc cc cc 0f b6 4b 10 48 =
8d 68 fe 38 48 fe 72 ec 48 89 ee 48 89 df e8 cf fd ff ff 80 7d 00 00 =
<75> c7 eb d9 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
kernel: RSP: 0018:ffffaab80392fb40 EFLAGS: 00000246
kernel: RAX: fffff69f82a7c000 RBX: ffffaab80392fb58 RCX: =
0000000000000000
kernel: RDX: 0000000000000010 RSI: ffff94a4268a6480 RDI: =
ffffaab80392fb58
kernel: RBP: ffff94a4268a6480 R08: 0000000000000000 R09: =
000000000000424a
kernel: R10: ffff94af1ec69ab0 R11: 0000000000000000 R12: =
0000000000001610
kernel: R13: 000000000000160c R14: 000000000000160c R15: =
ffffaab80392fdf0
kernel: FS: 00007f49f7bfe6c0(0000) GS:ffff94b63f100000(0000) =
knlGS:0000000000000000
kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007f01446e9000 CR3: 000000014a4be000 CR4: =
0000000000750ee0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel: <IRQ>
kernel: ? watchdog_timer_fn+0x1a8/0x210
kernel: ? __pfx_watchdog_timer_fn+0x10/0x10
kernel: ? __hrtimer_run_queues+0x112/0x2b0
kernel: ? hrtimer_interrupt+0xf8/0x230
kernel: ? __sysvec_apic_timer_interrupt+0x61/0x130
kernel: ? sysvec_apic_timer_interrupt+0x6d/0x90
kernel: </IRQ>
kernel: <TASK>
kernel: ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
kernel: ? xas_load+0x45/0x50
kernel: filemap_get_read_batch+0x179/0x270
kernel: filemap_get_pages+0xab/0x6a0
kernel: ? touch_atime+0x48/0x1b0
kernel: ? filemap_read+0x33f/0x350
kernel: filemap_read+0xdf/0x350
kernel: xfs_file_buffered_read+0x4f/0xd0 [xfs]
kernel: xfs_file_read_iter+0x74/0xe0 [xfs]
kernel: vfs_read+0x240/0x310
kernel: __x64_sys_pread64+0x98/0xd0
kernel: do_syscall_64+0x5f/0x90
kernel: ? native_flush_tlb_local+0x34/0x40
kernel: ? flush_tlb_func+0x10d/0x240
kernel: ? do_syscall_64+0x6b/0x90
kernel: ? sched_clock_cpu+0xf/0x190
kernel: ? irqtime_account_irq+0x40/0xc0
kernel: ? __irq_exit_rcu+0x4b/0xf0
kernel: entry_SYSCALL_64_after_hwframe+0x72/0xdc
kernel: RIP: 0033:0x7f4a0c23c227
kernel: Code: 08 89 3c 24 48 89 4c 24 18 e8 b5 e3 f8 ff 4c 8b 54 24 18 =
48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 =
<48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 05 e4 f8 ff 48 8b
kernel: RSP: 002b:00007f49f7bf8310 EFLAGS: 00000293 ORIG_RAX: =
0000000000000011
kernel: RAX: ffffffffffffffda RBX: 000000000000424a RCX: =
00007f4a0c23c227
kernel: RDX: 000000000000424a RSI: 00007f04294a35c0 RDI: =
00000000000004be
kernel: RBP: 00007f49f7bf8460 R08: 0000000000000000 R09: =
00007f49f7bf84a0
kernel: R10: 000000000160c718 R11: 0000000000000293 R12: =
000000000000424a
kernel: R13: 000000000160c718 R14: 00007f04294a35c0 R15: =
0000000000000000
kernel: </TASK>
...
kernel: ------------[ cut here ]------------
kernel: kernel BUG at fs/inode.c:612!
kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
kernel: CPU: 21 PID: 2195 Comm: rocksdb:low Tainted: G L =
6.3.5-100.fc37.x86_64 #1
kernel: Hardware name: To Be Filled By O.E.M. X570D4U/X570D4U, BIOS =
T1.29b 05/17/2022
kernel: RIP: 0010:clear_inode+0x76/0x80
kernel: Code: 2d a8 40 75 2b 48 8b 93 28 01 00 00 48 8d 83 28 01 00 00 =
48 39 c2 75 1a 48 c7 83 98 00 00 00 60 00 00 00 5b 5d c3 cc cc cc cc =
<0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
kernel: RSP: 0018:ffffaab80392fe58 EFLAGS: 00010002
kernel: RAX: 0000000000000000 RBX: ffff94af1ec69938 RCX: =
0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: =
ffff94af1ec69ab8
kernel: RBP: ffff94af1ec69ab8 R08: ffffaab80392fd38 R09: =
0000000000000002
kernel: R10: 0000000000000001 R11: 0000000000000005 R12: =
ffffffffc08b9860
kernel: R13: ffff94af1ec69938 R14: 00000000ffffff9c R15: =
ffff94979dd5da40
kernel: FS: 00007f49f7bfe6c0(0000) GS:ffff94b63ef40000(0000) =
knlGS:0000000000000000
kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007eefca8e2000 CR3: 000000014a4be000 CR4: =
0000000000750ee0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel: <TASK>
kernel: ? die+0x36/0x90
kernel: ? do_trap+0xda/0x100
kernel: ? clear_inode+0x76/0x80
kernel: ? do_error_trap+0x6a/0x90
kernel: ? clear_inode+0x76/0x80
kernel: ? exc_invalid_op+0x50/0x70
kernel: ? clear_inode+0x76/0x80
kernel: ? asm_exc_invalid_op+0x1a/0x20
kernel: ? clear_inode+0x76/0x80
kernel: ? clear_inode+0x1d/0x80
kernel: evict+0x1b8/0x1d0
kernel: do_unlinkat+0x174/0x320
kernel: __x64_sys_unlink+0x42/0x70
kernel: do_syscall_64+0x5f/0x90
kernel: ? __irq_exit_rcu+0x4b/0xf0
kernel: entry_SYSCALL_64_after_hwframe+0x72/0xdc
kernel: RIP: 0033:0x7f4a0c23faab
kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 82 63 0d 00 f7 d8 64 89 01 48 =
83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 57 00 00 00 0f 05 =
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 63 0d 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007f49f7bfab58 EFLAGS: 00000206 ORIG_RAX: =
0000000000000057
kernel: RAX: ffffffffffffffda RBX: 00007f49f7bfac38 RCX: =
00007f4a0c23faab
kernel: RDX: 00007f49f7bfadd0 RSI: 00007f4a0bc2fd30 RDI: =
00007f49dd3c32d0
kernel: RBP: 0000000000000002 R08: 0000000000000000 R09: =
0000000000000000
kernel: R10: ffffffffffffdf58 R11: 0000000000000206 R12: =
0000000000280bc0
kernel: R13: 00007f4a0bca77b8 R14: 00007f49f7bfadd0 R15: =
00007f49f7bfadd0
kernel: </TASK>
kernel: Modules linked in: tls nf_conntrack_netbios_ns =
nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 =
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct =
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel =
udp_tunnel tcp_bbr rfkill ip_set nf_tables nfnetlink nct6775 =
nct6775_core tun hwmon_vid jc42 vfat fat ipmi_ssif intel_rapl_msr =
intel_rapl_common amd64_edac edac_mce_amd kvm_amd snd_hda_intel =
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core kvm =
snd_hwdep snd_pcm snd_timer cdc_ether irqbypass acpi_ipmi snd usbnet =
wmi_bmof rapl ipmi_si k10temp soundcore i2c_piix4 joydev mii =
ipmi_devintf ipmi_msghandler fuse loop xfs uas usb_storage raid1 =
hid_cp2112 igb crct10dif_pclmul ast crc32_pclmul nvme crc32c_intel =
polyval_clmulni dca polyval_generic i2c_algo_bit nvme_core =
ghash_clmulni_intel ccp sha512_ssse3 wmi sp5100_tco nvme_common
kernel: ---[ end trace 0000000000000000 ]---
kernel: RIP: 0010:clear_inode+0x76/0x80
kernel: Code: 2d a8 40 75 2b 48 8b 93 28 01 00 00 48 8d 83 28 01 00 00 =
48 39 c2 75 1a 48 c7 83 98 00 00 00 60 00 00 00 5b 5d c3 cc cc cc cc =
<0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
kernel: RSP: 0018:ffffaab80392fe58 EFLAGS: 00010002
kernel: RAX: 0000000000000000 RBX: ffff94af1ec69938 RCX: =
0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: =
ffff94af1ec69ab8
kernel: RBP: ffff94af1ec69ab8 R08: ffffaab80392fd38 R09: =
0000000000000002
kernel: R10: 0000000000000001 R11: 0000000000000005 R12: =
ffffffffc08b9860
kernel: R13: ffff94af1ec69938 R14: 00000000ffffff9c R15: =
ffff94979dd5da40
kernel: FS: 00007f49f7bfe6c0(0000) GS:ffff94b63ef40000(0000) =
knlGS:0000000000000000
kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007eefca8e2000 CR3: 000000014a4be000 CR4: =
0000000000750ee0
kernel: PKRU: 55555554
kernel: note: rocksdb:low[2195] exited with irqs disabled
kernel: note: rocksdb:low[2195] exited with preempt_count 1

Above report is showing rocksdb as the workload with relatively short =
uptimes around 30 minutes. Maybe there=E2=80=99s a reproducer around =
there somewhere? I=E2=80=99ve CCed the reporter from there to maybe get =
some insight on his workload.

Rabbit hole 2: things that were already considered=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


There were a number of potential vectors and bugfixes that were =
discussed/referenced but haven=E2=80=99t turned out to fix the issue =
overall. Some of them might be obvious red herrings by now, but I=E2=80=99=
m not sure which.

* [GIT PULL] xfs, iomap: fix data corruption due to stale cached iomaps =
(https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disa=
ster.area/)

* cbc02854331e ("XArray: Do not return sibling entries from =
xa_load()=E2=80=9D) did not help here

* I think i=E2=80=99ve seen that the affected data on disk ended up =
being null bytes, but I can=E2=80=99t verify that.

* There was a fix close to this in =E2=80=9C_filemap_get_folio and NULL =
pointer dereference=E2=80=9D =
(https://bugzilla.kernel.org/show_bug.cgi?id=3D217441) and "having =
TRANSPARENT_HUGEPAGE enabled hangs some applications (supervisor read =
access in kernel mode)=E2=80=9D =
https://bugzilla.kernel.org/show_bug.cgi?id=3D216646 but their traces =
looked slightly different from the ones discussed here as did their =
outcome. Interestingly: those are also on the page fault path, not an fs =
path.

* memcg was in the stack and under question at some point but it also =
happens without it

* i was wondering whether increased readahead sizes might cause issues =
(most our VMs run 128kb but DB VMs run with 1MiB. However, this might =
also be a red herring as the single vs. multi core situation correlates =
strongly in our case).

Maybe offtopic but maybe it spurs ideas =E2=80=93 a situation that felt =
similar to the stalls here: I remember debugging a memory issue in =
Python=E2=80=99s small object allocator a number of years ago that =
resulted in segfaults and I wonder whether the stalls we=E2=80=99re =
seeing are only a delayed symptom of an earlier corruption somewhere =
else. The Python issue was a third party module that caused an out of =
bounds write into an adjacent byte that was used as a pointer for arena =
management. That one was also extremely hard to track down due to this =
indirection / "magic at a distance=E2=80=9D behaviour.

That=E2=80=99s all the input I have.

My offer stands: I can take time and run a number of machines that =
exhibited the behaviour on custom kernels to gather data.=20

Cheers,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


