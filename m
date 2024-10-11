Return-Path: <linux-fsdevel+bounces-31666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C6999DE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0C91F236EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8720A5C1;
	Fri, 11 Oct 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="mO4khwbU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75063209F52;
	Fri, 11 Oct 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631663; cv=none; b=lqrI/NFkRgUbBGdArNomnn8KvSzcPIPaa+pPuVB+/9N+S5xJKVmXzVM8qMU1rDF7N1vNlDfQqm1jJPC6QCqVj1Pcx/ng90bdAL8LvALmHNwgsVS//CUYYXwjekn3u7XHyywu71gbPRI1PEvt9qnMpxd875Yln1tW2IjJHipdaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631663; c=relaxed/simple;
	bh=F3jIVOQPpn/582C4DLIXwkG+iiEGngr+yBorpOxKTnA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ttZTelJgOKXE4Y/be6hoYMYXGN2226ZsDfE54fiUzHK/OEGfagnIqZpw6QoNTdAM54U8AWFtbaH3j2lk9dwcsdzjOahssAM/56yf+nIiTrJcuomyRWZ5q1GiT9dgurJNk2q1ATXYmTiIJhnjLdss5vYJyoiX3UzA6pWZ4jgzCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=mO4khwbU; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1728631651;
	bh=ht6MJDY3Fy1CYRDV0JIK9gBKG7L45D1Bq8tOJWehI3s=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=mO4khwbUxEnu4l2dyNWJXue8da8L8Yn/aSjtiP2qwAm8zB34elmAzZx7DsyisDY6O
	 KXA6p4A5My7kw+7+hfnDGO5qaVi+ZoZe2k45KtnF9mvzRhNwpuiBCFC5iIvQ7ghj7o
	 a8yoEMynJU15/73u0XbsH3a8wt0as9J41bfh+7uM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
Date: Fri, 11 Oct 2024 09:27:08 +0200
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
Message-Id: <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
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
To: Chris Mason <clm@meta.com>

Hi,

> On 10. Oct 2024, at 08:29, Christian Theune <ct@flyingcircus.io> =
wrote:
>=20
>=20
>> On 1. Oct 2024, at 02:56, Chris Mason <clm@meta.com> wrote:
>>=20
>> Not disagreeing with Linus at all, but given that you've got IO
>> throttling too, we might really just be waiting.  It's hard to tell
>> because the hung task timeouts only give you information about one =
process.
>>=20
>> I've attached a minimal version of a script we use here to show all =
the
>> D state processes, it might help explain things.  The only problem is
>> you have to actually ssh to the box and run it when you're stuck.
>>=20
>> The idea is to print the stack trace of every D state process, and =
then
>> also print out how often each unique stack trace shows up.  When =
we're
>> deadlocked on something, there are normally a bunch of the same stack
>> (say waiting on writeback) and then one jerk sitting around in a
>> different stack who is causing all the trouble.
>=20
> I think I should be able to trigger this. I=E2=80=99ve seen around a =
100 of those issues over the last week and the chance of it happening =
correlates with a certain workload that should be easy to trigger. Also, =
the condition remains for at around 5 minutes, so I should be able to =
trace it when I see the alert in an interactive session.
>=20
> I=E2=80=99ve verified I can run your script and I=E2=80=99ll get back =
to you in the next days.

I wasn=E2=80=99t able to create a reproducer after all so I=E2=80=99ve =
set up alerting.

I just caught one right away, but it unblocked quickly after I logged =
in:

The original message that triggered the alert was:

[Oct11 09:18] INFO: task nix-build:157920 blocked for more than 122 =
seconds.
[  +0.000937]       Not tainted 6.11.0 #1-NixOS
[  +0.000540] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[  +0.000902] task:nix-build       state:D stack:0     pid:157920 =
tgid:157920 ppid:157919 flags:0x00000002
[  +0.001098] Call Trace:
[  +0.000306]  <TASK>
[  +0.000279]  __schedule+0x3a3/0x1300
[  +0.000478]  schedule+0x27/0xf0
[  +0.000392]  io_schedule+0x46/0x70
[  +0.000436]  folio_wait_bit_common+0x13f/0x340
[  +0.000572]  ? __pfx_wake_page_function+0x10/0x10
[  +0.000592]  folio_wait_writeback+0x2b/0x80
[  +0.000466]  truncate_inode_partial_folio+0x5e/0x1b0
[  +0.000586]  truncate_inode_pages_range+0x1de/0x400
[  +0.000595]  evict+0x29f/0x2c0
[  +0.000396]  ? iput+0x6e/0x230
[  +0.000408]  ? _atomic_dec_and_lock+0x39/0x50
[  +0.000542]  do_unlinkat+0x2de/0x330
[  +0.000402]  __x64_sys_unlink+0x3f/0x70
[  +0.000419]  do_syscall_64+0xb7/0x200
[  +0.000407]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  +0.000556] RIP: 0033:0x7f2bb5d1056b
[  +0.000473] RSP: 002b:00007ffc013c8588 EFLAGS: 00000206 ORIG_RAX: =
0000000000000057
[  +0.000942] RAX: ffffffffffffffda RBX: 000055963c267500 RCX: =
00007f2bb5d1056b
[  +0.000859] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
000055963c268c80
[  +0.000800] RBP: 000055963c267690 R08: 0000000000016020 R09: =
0000000000000000
[  +0.000977] R10: 00000000000000f0 R11: 0000000000000206 R12: =
00007ffc013c85c8
[  +0.000826] R13: 00007ffc013c85ac R14: 00007ffc013c8ed0 R15: =
00005596441e42b0
[  +0.000833]  </TASK>

Then after logging in I caught it once with walker.py - this was about a =
minute after the alert triggered I think. I=E2=80=99ll add timestamps to =
walker.py in the next instances:

157920 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] truncate_inode_partial_folio+0x5e/0x1b0
[<0>] truncate_inode_pages_range+0x1de/0x400
[<0>] evict+0x29f/0x2c0
[<0>] do_unlinkat+0x2de/0x330
[<0>] __x64_sys_unlink+0x3f/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] truncate_inode_partial_folio+0x5e/0x1b0
[<0>] truncate_inode_pages_range+0x1de/0x400
[<0>] evict+0x29f/0x2c0
[<0>] do_unlinkat+0x2de/0x330
[<0>] __x64_sys_unlink+0x3f/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

I tried once again after 1-2 seconds and got this:

157920 nix-build D
[<0>] xlog_wait_on_iclog+0x167/0x180 [xfs]
[<0>] xfs_log_force_seq+0x8d/0x150 [xfs]
[<0>] xfs_file_fsync+0x195/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] xlog_wait_on_iclog+0x167/0x180 [xfs]
[<0>] xfs_log_force_seq+0x8d/0x150 [xfs]
[<0>] xfs_file_fsync+0x195/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

and after that the process was done and exited. The last traceback looks =
unlocked already.

I=E2=80=99m going to gather a few more instances during the day and will =
post them as a batch later.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


