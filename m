Return-Path: <linux-fsdevel+bounces-31714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E972799A562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C761C21CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648C219484;
	Fri, 11 Oct 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="DRMwYd+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614331E501C;
	Fri, 11 Oct 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654640; cv=none; b=aAavM454i9ht3rl64nmo4YuXCUMx/A1Mlj7pX6I7W88IAoPKcHHh6T16LO/w1LMUG+CZgLbGTEV71/q9jtT4IEJabcY0vY3QQKAEUBhRfyolZijRr/BuXblV55GZk+lXzThoVhq+/QBVkoFxMZ7a09U+CjdZUoo7HG7RlaPUCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654640; c=relaxed/simple;
	bh=rkoN1t9+WGwqDDBopn4udo62u+w8ZOwNYcBJAvq9Nx0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IECZFPGgw1P2ctMAilnYlSvxhZY+BmKGSgqzF9wFAaXZxBGUDMfKVSgl0f8IuXdbU2FcrwCgXFcTAB30vvKTQaicIxDsZ6lz/RRKluB6P3NsDxMa/A+8y62I/uH8dmQ5h48crpcwtEv48wNWi41KW3M0G6PCTMxmSACHmHAfUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=DRMwYd+b; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1728654635;
	bh=KvNGlemhaNExRrqlaQX0CrDFggZF6YQd0fZVnjowWsM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=DRMwYd+bbgVy+htDpLRrpNmovu27Zg0dxG7AOb97R+c4AJMEVG7JtuUnp+AolUgjv
	 ONa2do625TUZFB7b7qLtIESnLirPx0g4oqwY6gNqwRAmMLaIiDZK4iz6TFZ2X8WAZX
	 zEZePLfyx26unk2qsQTvoyHz51ToIUE8oIpKUzxQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
Date: Fri, 11 Oct 2024 15:50:12 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCFA457F-E115-47F0-87F1-F64A51BDE96C@flyingcircus.io>
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
 <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
 <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>
 <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
 <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
To: Chris Mason <clm@meta.com>

Hi,

> On 11. Oct 2024, at 15:06, Chris Mason <clm@meta.com> wrote:
>=20
> - It's actually taking the IO a long time to finish.  We can poke at =
the
> pending requests, how does the device look in the VM?  (virtio, scsi =
etc).

I _think_ that=E2=80=99s not it. This is a Qemu w/ virtio-block + Ceph =
stack with 2x10G and fully SSD backed. The last 24 hours show operation =
latency at less than 0.016ms. Ceph=E2=80=99s slow request warning (30s =
limit) has not triggered in the last 24 hours.

Also, aside from a VM that was exhausting its Qemu io throttling for a =
minute (and stuck in completely different tracebacks) the only blocked =
task reports from the last 48 hours was this specific process.

I=E2=80=99d expect that we=E2=80=99d see a lot more reports about IO =
issues from multiple VMs and multiple loads at the same time when the =
storage misbehaves (we did experience those in the long long past in =
older Ceph versions and with spinning rust, so I=E2=80=99m pretty =
confident (at the moment) this isn=E2=80=99t a storage issue per se).

Incidentally this now reminds me of a different (maybe not?) issue that =
I=E2=80=99ve been trying to track down with mdraid/xfs:
https://marc.info/?l=3Dlinux-raid&m=3D172295385102939&w=3D2

This is only tested on an older kernel so far (5.15.138) and we ended up =
seeing IOPS stuck in the md device but not below it. However, MD isn=E2=80=
=99t involved here. I made the connection because the original traceback =
also shows it stuck in =E2=80=9Cwait_on_page_writeback=E2=80=9D, but =
maybe that=E2=80=99s a red herring:

[Aug 6 09:35] INFO: task .backy-wrapped:2615 blocked for more than 122 =
seconds.
[ +0.008130] Not tainted 5.15.138 #1-NixOS
[ +0.005194] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ +0.008895] task:.backy-wrapped state:D stack: 0 pid: 2615 ppid: 1 =
flags:0x00000002
[ +0.000005] Call Trace:
[ +0.000002] <TASK>
[ +0.000004] __schedule+0x373/0x1580
[ +0.000009] ? xlog_cil_commit+0x559/0x880 [xfs]
[ +0.000041] schedule+0x5b/0xe0
[ +0.000001] io_schedule+0x42/0x70
[ +0.000001] wait_on_page_bit_common+0x119/0x380
[ +0.000005] ? __page_cache_alloc+0x80/0x80
[ +0.000002] wait_on_page_writeback+0x22/0x70
[ +0.000001] truncate_inode_pages_range+0x26f/0x6d0
[ +0.000006] evict+0x15f/0x180
[ +0.000003] __dentry_kill+0xde/0x170
[ +0.000001] dput+0x15b/0x330
[ +0.000002] do_renameat2+0x34e/0x5b0
[ +0.000003] __x64_sys_rename+0x3f/0x50
[ +0.000002] do_syscall_64+0x3a/0x90
[ +0.000002] entry_SYSCALL_64_after_hwframe+0x62/0xcc
[ +0.000003] RIP: 0033:0x7fdd1885275b
[ +0.000002] RSP: 002b:00007ffde643ad18 EFLAGS: 00000246 ORIG_RAX: =
0000000000000052
[ +0.000002] RAX: ffffffffffffffda RBX: 00007ffde643adb0 RCX: =
00007fdd1885275b
[ +0.000001] RDX: 0000000000000000 RSI: 00007fdd09a3d3d0 RDI: =
00007fdd098549d0
[ +0.000001] RBP: 00007ffde643ad60 R08: 00000000ffffffff R09: =
0000000000000000
[ +0.000001] R10: 00007ffde643af90 R11: 0000000000000246 R12: =
00000000ffffff9c
[ +0.000000] R13: 00000000ffffff9c R14: 000000000183cab0 R15: =
00007fdd0b128810
[ +0.000001] </TASK>
[ +0.000011] INFO: task kworker/u64:0:2380262 blocked for more than 122 =
seconds.
[ +0.008309] Not tainted 5.15.138 #1-NixOS
[ +0.005190] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ +0.008895] task:kworker/u64:0 state:D stack: 0 pid:2380262 ppid: 2 =
flags:0x00004000
[ +0.000004] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
[ +0.000006] Call Trace:
[ +0.000001] <TASK>
[ +0.000001] __schedule+0x373/0x1580
[ +0.000003] schedule+0x5b/0xe0
[ +0.000001] md_bitmap_startwrite+0x177/0x1e0
[ +0.000004] ? finish_wait+0x90/0x90
[ +0.000004] add_stripe_bio+0x449/0x770 [raid456]
[ +0.000005] raid5_make_request+0x1cf/0xbd0 [raid456]
[ +0.000003] ? kmem_cache_alloc_node_trace+0x391/0x3e0
[ +0.000004] ? linear_map+0x44/0x90 [dm_mod]
[ +0.000005] ? finish_wait+0x90/0x90
[ +0.000001] ? __blk_queue_split+0x516/0x580
[ +0.000003] md_handle_request+0x122/0x1b0
[ +0.000003] md_submit_bio+0x6e/0xb0
[ +0.000001] __submit_bio+0x18f/0x220
[ +0.000002] ? crypt_page_alloc+0x46/0x60 [dm_crypt]
[ +0.000002] submit_bio_noacct+0xbe/0x2d0
[ +0.000001] kcryptd_crypt+0x392/0x550 [dm_crypt]
[ +0.000002] process_one_work+0x1d6/0x360
[ +0.000003] worker_thread+0x4d/0x3b0
[ +0.000002] ? process_one_work+0x360/0x360
[ +0.000001] kthread+0x118/0x140
[ +0.000001] ? set_kthread_struct+0x50/0x50
[ +0.000001] ret_from_fork+0x22/0x30
[ +0.000004] </TASK>
=E2=80=A6(more md kworker tasks pile up here)

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


