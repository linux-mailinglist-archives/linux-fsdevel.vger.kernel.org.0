Return-Path: <linux-fsdevel+bounces-30395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE498AB32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B731F23A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44D198A0B;
	Mon, 30 Sep 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="MwQhucXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAF193081;
	Mon, 30 Sep 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717717; cv=none; b=B7yPDBjMhdQWB4n1gp93FIRxewxk2SKV2ikBViNDDBZLP2kGAaLX2+8HShUu3FVEfYLQ9brcvx+C4+cKtkf3+g1dFEPUZ4STp2+OY8rSBSwAjXZRSTJW1VMZyVeRIfVdq13h3RLOBvRLET79IFkEc9aAApBHUaCPpYwwcq+8edA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717717; c=relaxed/simple;
	bh=Yh/kzjEpMJXhxJ+oDUKyicbfDIShDdIHy6VDTph0A44=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AF3v+KTDwE2lbDEezi9tFOnXJhdtlZFQ7Dzphmz1obQwbGdzKakRQ5+oSzDkaL46NQD2GxiTYBTdSo12H6EiY46YMhguvdORm9hnux81KwWsCEnCTjC92izG9o44/ODSOPYEkNW1PBpMh4N7UmrW+uUhBK5dYM1jFDF0C1gfYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=MwQhucXQ; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727717703;
	bh=y9fgcEQUNiPEpJ2USU0yAmJArJilNuIATGvm2Om33JQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=MwQhucXQAAqABLZuGhW72ooGGwKgNFhJwlgx3MfMmNHxz/098ZA71bbR6XG/tufxR
	 rG+DkgrDd7adUqXjW+L5hPfp2LEUrFDuG3JG6vZWMTiTqIGrI2Cw1aGyl93wwne9E5
	 m+dGKzcjPdqzYCzyPOnp5cMNFY4add8L8K5b8rWc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
Date: Mon, 30 Sep 2024 19:34:39 +0200
Cc: Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@meta.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
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
To: Linus Torvalds <torvalds@linux-foundation.org>

Hi,

we=E2=80=99ve been running a number of VMs since last week on 6.11. =
We=E2=80=99ve encountered one hung task situation multiple times now =
that seems to be resolving itself after a bit of time, though. I do not =
see spinning CPU during this time.

The situation seems to be related to cgroups-based IO throttling / =
weighting so far:

Here are three examples of similar tracebacks where jobs that do perform =
a certain amount of IO (either given a weight or given an explicit limit =
like this:

IOWeight=3D10
IOReadIOPSMax=3D/dev/vda 188
IOWriteIOPSMax=3D/dev/vda 188
=09
Telemetry for the affected VM does not show that it actually reaches 188 =
IOPS (the load is mostly writing) but creates a kind of gaussian curve =
=E2=80=A6=20

The underlying storage and network was completely inconspicuous during =
the whole time.

Sep 27 00:51:20 <redactedhostname>13 kernel: INFO: task nix-build:5300 =
blocked for more than 122 seconds.
Sep 27 00:51:20 <redactedhostname>13 kernel:       Not tainted 6.11.0 =
#1-NixOS
Sep 27 00:51:20 <redactedhostname>13 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 27 00:51:20 <redactedhostname>13 kernel: task:nix-build       =
state:D stack:0     pid:5300  tgid:5298  ppid:5297   flags:0x00000002
Sep 27 00:51:20 <redactedhostname>13 kernel: Call Trace:
Sep 27 00:51:20 <redactedhostname>13 kernel:  <TASK>
Sep 27 00:51:20 <redactedhostname>13 kernel:  __schedule+0x3a3/0x1300
Sep 27 00:51:20 <redactedhostname>13 kernel:  ? =
xfs_vm_writepages+0x67/0x90 [xfs]
Sep 27 00:51:20 <redactedhostname>13 kernel:  schedule+0x27/0xf0
Sep 27 00:51:20 <redactedhostname>13 kernel:  io_schedule+0x46/0x70
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
folio_wait_bit_common+0x13f/0x340
Sep 27 00:51:20 <redactedhostname>13 kernel:  ? =
__pfx_wake_page_function+0x10/0x10
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
folio_wait_writeback+0x2b/0x80
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
__filemap_fdatawait_range+0x80/0xe0
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
filemap_write_and_wait_range+0x85/0xb0
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
xfs_setattr_size+0xd9/0x3c0 [xfs]
Sep 27 00:51:20 <redactedhostname>13 kernel:  xfs_vn_setattr+0x81/0x150 =
[xfs]
Sep 27 00:51:20 <redactedhostname>13 kernel:  notify_change+0x2ed/0x4f0
Sep 27 00:51:20 <redactedhostname>13 kernel:  ? do_truncate+0x98/0xf0
Sep 27 00:51:20 <redactedhostname>13 kernel:  do_truncate+0x98/0xf0
Sep 27 00:51:20 <redactedhostname>13 kernel:  do_ftruncate+0xfe/0x160
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
__x64_sys_ftruncate+0x3e/0x70
Sep 27 00:51:20 <redactedhostname>13 kernel:  do_syscall_64+0xb7/0x200
Sep 27 00:51:20 <redactedhostname>13 kernel:  =
entry_SYSCALL_64_after_hwframe+0x77/0x7f
Sep 27 00:51:20 <redactedhostname>13 kernel: RIP: 0033:0x7f1ed1912c2b
Sep 27 00:51:20 <redactedhostname>13 kernel: RSP: 002b:00007f1eb73fd3f8 =
EFLAGS: 00000246 ORIG_RAX: 000000000000004d
Sep 27 00:51:20 <redactedhostname>13 kernel: RAX: ffffffffffffffda RBX: =
0000000000000000 RCX: 00007f1ed1912c2b
Sep 27 00:51:20 <redactedhostname>13 kernel: RDX: 0000000000000003 RSI: =
0000000000000000 RDI: 0000000000000012
Sep 27 00:51:20 <redactedhostname>13 kernel: RBP: 0000000000000012 R08: =
0000000000000000 R09: 00007f1eb73fd3a0
Sep 27 00:51:20 <redactedhostname>13 kernel: R10: 0000000000132000 R11: =
0000000000000246 R12: 00005601d0150290
Sep 27 00:51:20 <redactedhostname>13 kernel: R13: 00005601d58ae0b8 R14: =
0000000000000001 R15: 00005601d58bec58
Sep 27 00:51:20 <redactedhostname>13 kernel:  </TASK>

Sep 28 10:13:04 release2405dev00 kernel: INFO: task nix-channel:507080 =
blocked for more than 122 seconds.
Sep 28 10:13:04 release2405dev00 kernel:       Not tainted 6.11.0 =
#1-NixOS
Sep 28 10:13:04 release2405dev00 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 28 10:13:04 release2405dev00 kernel: task:nix-channel     state:D =
stack:0     pid:507080 tgid:507080 ppid:507061 flags:0x00000002
Sep 28 10:13:04 release2405dev00 kernel: Call Trace:
Sep 28 10:13:04 release2405dev00 kernel:  <TASK>
Sep 28 10:13:04 release2405dev00 kernel:  __schedule+0x3a3/0x1300
Sep 28 10:13:04 release2405dev00 kernel:  ? xfs_vm_writepages+0x67/0x90 =
[xfs]
Sep 28 10:13:04 release2405dev00 kernel:  schedule+0x27/0xf0
Sep 28 10:13:04 release2405dev00 kernel:  io_schedule+0x46/0x70
Sep 28 10:13:04 release2405dev00 kernel:  =
folio_wait_bit_common+0x13f/0x340
Sep 28 10:13:04 release2405dev00 kernel:  ? =
__pfx_wake_page_function+0x10/0x10
Sep 28 10:13:04 release2405dev00 kernel:  folio_wait_writeback+0x2b/0x80
Sep 28 10:13:04 release2405dev00 kernel:  =
__filemap_fdatawait_range+0x80/0xe0
Sep 28 10:13:04 release2405dev00 kernel:  =
file_write_and_wait_range+0x88/0xb0
Sep 28 10:13:04 release2405dev00 kernel:  xfs_file_fsync+0x5e/0x2a0 =
[xfs]
Sep 28 10:13:04 release2405dev00 kernel:  __x64_sys_fdatasync+0x52/0x90
Sep 28 10:13:04 release2405dev00 kernel:  do_syscall_64+0xb7/0x200
Sep 28 10:13:04 release2405dev00 kernel:  =
entry_SYSCALL_64_after_hwframe+0x77/0x7f
Sep 28 10:13:04 release2405dev00 kernel: RIP: 0033:0x7f5b9371270a
Sep 28 10:13:04 release2405dev00 kernel: RSP: 002b:00007ffd678149f0 =
EFLAGS: 00000293 ORIG_RAX: 000000000000004b
Sep 28 10:13:04 release2405dev00 kernel: RAX: ffffffffffffffda RBX: =
0000559a4d023a18 RCX: 00007f5b9371270a
Sep 28 10:13:04 release2405dev00 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000007
Sep 28 10:13:04 release2405dev00 kernel: RBP: 0000000000000000 R08: =
0000000000000001 R09: 0000559a4d027878
Sep 28 10:13:04 release2405dev00 kernel: R10: 0000000000000016 R11: =
0000000000000293 R12: 0000000000000001
Sep 28 10:13:04 release2405dev00 kernel: R13: 000000000000002e R14: =
0000559a4d0278fc R15: 00007ffd67814bf0
Sep 28 10:13:04 release2405dev00 kernel:  </TASK>

Sep 28 03:39:19 <redactedhostname>10 kernel: INFO: task nix-build:94696 =
blocked for more than 122 seconds.
Sep 28 03:39:19 <redactedhostname>10 kernel:       Not tainted 6.11.0 =
#1-NixOS
Sep 28 03:39:19 <redactedhostname>10 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 28 03:39:19 <redactedhostname>10 kernel: task:nix-build       =
state:D stack:0     pid:94696 tgid:94696 ppid:94695  flags:0x00000002
Sep 28 03:39:19 <redactedhostname>10 kernel: Call Trace:
Sep 28 03:39:19 <redactedhostname>10 kernel:  <TASK>
Sep 28 03:39:19 <redactedhostname>10 kernel:  __schedule+0x3a3/0x1300
Sep 28 03:39:19 <redactedhostname>10 kernel:  schedule+0x27/0xf0
Sep 28 03:39:19 <redactedhostname>10 kernel:  io_schedule+0x46/0x70
Sep 28 03:39:19 <redactedhostname>10 kernel:  =
folio_wait_bit_common+0x13f/0x340
Sep 28 03:39:19 <redactedhostname>10 kernel:  ? =
__pfx_wake_page_function+0x10/0x10
Sep 28 03:39:19 <redactedhostname>10 kernel:  =
folio_wait_writeback+0x2b/0x80
Sep 28 03:39:19 <redactedhostname>10 kernel:  =
truncate_inode_partial_folio+0x5e/0x1b0
Sep 28 03:39:19 <redactedhostname>10 kernel:  =
truncate_inode_pages_range+0x1de/0x400
Sep 28 03:39:19 <redactedhostname>10 kernel:  evict+0x29f/0x2c0
Sep 28 03:39:19 <redactedhostname>10 kernel:  ? iput+0x6e/0x230
Sep 28 03:39:19 <redactedhostname>10 kernel:  ? =
_atomic_dec_and_lock+0x39/0x50
Sep 28 03:39:19 <redactedhostname>10 kernel:  do_unlinkat+0x2de/0x330
Sep 28 03:39:19 <redactedhostname>10 kernel:  __x64_sys_unlink+0x3f/0x70
Sep 28 03:39:19 <redactedhostname>10 kernel:  do_syscall_64+0xb7/0x200
Sep 28 03:39:19 <redactedhostname>10 kernel:  =
entry_SYSCALL_64_after_hwframe+0x77/0x7f
Sep 28 03:39:19 <redactedhostname>10 kernel: RIP: 0033:0x7f37c062d56b
Sep 28 03:39:19 <redactedhostname>10 kernel: RSP: 002b:00007fff71638018 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000057
Sep 28 03:39:19 <redactedhostname>10 kernel: RAX: ffffffffffffffda RBX: =
0000562038c30500 RCX: 00007f37c062d56b
Sep 28 03:39:19 <redactedhostname>10 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000562038c31c80
Sep 28 03:39:19 <redactedhostname>10 kernel: RBP: 0000562038c30690 R08: =
0000000000016020 R09: 0000000000000000
Sep 28 03:39:19 <redactedhostname>10 kernel: R10: 0000000000000050 R11: =
0000000000000206 R12: 00007fff71638058
Sep 28 03:39:19 <redactedhostname>10 kernel: R13: 00007fff7163803c R14: =
00007fff71638960 R15: 0000562040b8a500
Sep 28 03:39:19 <redactedhostname>10 kernel:  </TASK>

Hope this helps,
Christian

> On 19. Sep 2024, at 12:19, Christian Theune <ct@flyingcircus.io> =
wrote:
>=20
>=20
>=20
>> On 19. Sep 2024, at 08:57, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>=20
>> Yeah, right now Jens is still going to run some more testing, but I
>> think the plan is to just backport
>>=20
>> a4864671ca0b ("lib/xarray: introduce a new helper xas_get_order")
>> 6758c1128ceb ("mm/filemap: optimize filemap folio adding")
>>=20
>> and I think we're at the point where you might as well start testing
>> that if you have the cycles for it. Jens is mostly trying to confirm
>> the root cause, but even without that, I think you running your load
>> with those two changes back-ported is worth it.
>>=20
>> (Or even just try running it on plain 6.10 or 6.11, both of which
>> already has those commits)
>=20
> I=E2=80=99ve discussed this with my team and we=E2=80=99re preparing =
to switch all our=20
> non-prod machines as well as those production machines that have shown
> the error before.
>=20
> This will require a bit of user communication and reboot scheduling.
> Our release prep will be able to roll this out starting early next =
week
> and the production machines in question around Sept 30.
>=20
> We would run with 6.11 as our understanding so far is that running the
> most current kernel would generate the most insight and is easier to
> work with for you all?
>=20
> (Generally we run the mostly vanilla LTS that has surpassed x.y.50+ so
> we might later downgrade to 6.6 when this is fixed.)
>=20
>> So considering how well the reproducer works for Jens and Chris, my
>> main worry is whether your load might have some _additional_ issue.
>>=20
>> Unlikely, but still .. The two commits fix the repproducer, so I =
think
>> the important thing to make sure is that it really fixes the original
>> issue too.
>>=20
>> And yeah, I'd be surprised if it doesn't, but at the same time I =
would
>> _not_ suggest you try to make your load look more like the case we
>> already know gets fixed.
>>=20
>> So yes, it will be "weeks of not seeing crashes" until we'd be
>> _really_ confident it's all the same thing, but I'd rather still have
>> you test that, than test something else than what caused issues
>> originally, if you see what I mean.
>=20
> Agreed, I=E2=80=99m all onboard with that.
>=20
> Liebe Gr=C3=BC=C3=9Fe,
> Christian Theune
>=20
> --=20
> Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
> Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
> Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian =
Theune, Christian Zagrodnick
>=20

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


