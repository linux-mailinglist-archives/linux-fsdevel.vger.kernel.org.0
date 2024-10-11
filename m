Return-Path: <linux-fsdevel+bounces-31678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D516A999FCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD31F240B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55E20C491;
	Fri, 11 Oct 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="iMhjeFnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CA20C48B;
	Fri, 11 Oct 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637734; cv=none; b=Q34wIBk5LcNPcgbjIa7bM9efouWGB2f/+Nek8esyC25YUVKodqjVSTQroYJOY9wyO0SAnt2xPvem6AkQiIbyYPrloSOHHEsqqdzvpxgUx+KJPR0ZIrRN6p2a1wWuEagK0g1RgzQ8SIuP2uYxcfS7fk7bwI4D6lSyEg5OmwxmBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637734; c=relaxed/simple;
	bh=RBOsApsnCFQXYc+fLb8m1C2WI4ruVWbrm3X1JFobwW4=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=lmI0QseqdmRfKPvYkdsapTEBGKkQMpONV2PrxkSz4LIQhpM3kb1hXidmg4wkG51q4iO7tffwoqfFQ1wG8sV1gLxMvh2LuRxrpd8ZUkYqIEjsMz9mt6/r0FjspruErOEdHICXdchw2kC0gTufyP5QJ6M2wMLXIqFSpBue9++oKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=iMhjeFnD; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
From: Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1728637728;
	bh=C7DfB6pE74FcGPfy8z6epWlBKAVYg8YQK/rpTAJ2aUA=;
	h=From:Subject:Date:In-Reply-To:Cc:To:References;
	b=iMhjeFnDZXcxC6RH3WOdXcfDHhZqPhIPzSfFzzalIXf+rjluT3z5Vl30mAPGFHLG5
	 Med9jZWA7xa08ROF4EVI+khqb+ibsv5ecIMBYwUg7adctaQ5gG8O4cyd9jT5FhBUdI
	 bSr4Cgo14KTU5Kw4NHLloIjiO7eVetKR8pKbBaz4=
Message-Id: <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Date: Fri, 11 Oct 2024 11:08:26 +0200
In-Reply-To: <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>
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
To: Chris Mason <clm@meta.com>
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
 <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>


--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 11. Oct 2024, at 09:27, Christian Theune <ct@flyingcircus.io> =
wrote:
>=20
> I=E2=80=99m going to gather a few more instances during the day and =
will post them as a batch later.

I=E2=80=99ve received 8 alerts in the last hours and managed to get =
detailed, repeated walker output from two of them:

- FC-41287.log
- FC-41289.log

The other logs are tracebacks as the kernel reported them but the =
situation resolved itself faster than I could log in and run the walker =
script. In FC-41289.log I=E2=80=99m also providing output from `ps auxf` =
to see what the process tree looks like, maybe that helps, too.

My observations:=20

- different entry points from the XFS code: unlink, f(data)sync, =
truncate
- in none of the cases I caught I could see any real competing traffic =
(aside from maybe occasional journal writes and very little background =
noise), all affected machines are staging environments that saw =
basically no usage during that timeframe

I=E2=80=99m stopping my alerting now as it=E2=80=99s been interrupting =
me every few minutes and I=E2=80=99m running out of steam sitting around =
waiting for the alert. ;)

Christian


--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41281.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41281.log"
Content-Transfer-Encoding: 7bit

[195020.405783] INFO: task nix-build:157920 blocked for more than 122 seconds.
[195020.406720]       Not tainted 6.11.0 #1-NixOS
[195020.407260] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[195020.408162] task:nix-build       state:D stack:0     pid:157920 tgid:157920 ppid:157919 flags:0x00000002
[195020.409260] Call Trace:
[195020.409566]  <TASK>
[195020.409845]  __schedule+0x3a3/0x1300
[195020.410323]  schedule+0x27/0xf0
[195020.410715]  io_schedule+0x46/0x70
[195020.411151]  folio_wait_bit_common+0x13f/0x340
[195020.411723]  ? __pfx_wake_page_function+0x10/0x10
[195020.412315]  folio_wait_writeback+0x2b/0x80
[195020.412781]  truncate_inode_partial_folio+0x5e/0x1b0
[195020.413367]  truncate_inode_pages_range+0x1de/0x400
[195020.413962]  evict+0x29f/0x2c0
[195020.414358]  ? iput+0x6e/0x230
[195020.414766]  ? _atomic_dec_and_lock+0x39/0x50
[195020.415308]  do_unlinkat+0x2de/0x330
[195020.415710]  __x64_sys_unlink+0x3f/0x70
[195020.416129]  do_syscall_64+0xb7/0x200
[195020.416536]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[195020.417092] RIP: 0033:0x7f2bb5d1056b
[195020.417565] RSP: 002b:00007ffc013c8588 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[195020.418507] RAX: ffffffffffffffda RBX: 000055963c267500 RCX: 00007f2bb5d1056b
[195020.419366] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055963c268c80
[195020.420166] RBP: 000055963c267690 R08: 0000000000016020 R09: 0000000000000000
[195020.421143] R10: 00000000000000f0 R11: 0000000000000206 R12: 00007ffc013c85c8
[195020.421969] R13: 00007ffc013c85ac R14: 00007ffc013c8ed0 R15: 00005596441e42b0
[195020.422802]  </TASK>

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

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41282.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41282.log"
Content-Transfer-Encoding: 7bit

[208400.702546] INFO: task nix-build:330993 blocked for more than 122 seconds.
[208400.703012]       Not tainted 6.11.0 #1-NixOS
[208400.703260] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[208400.703760] task:nix-build       state:D stack:0     pid:330993 tgid:330993 ppid:330992 flags:0x00004002
[208400.704588] Call Trace:
[208400.704744]  <TASK>
[208400.704874]  __schedule+0x3a3/0x1300
[208400.705085]  ? wb_update_bandwidth+0x52/0x70
[208400.705329]  schedule+0x27/0xf0
[208400.705523]  io_schedule+0x46/0x70
[208400.705734]  folio_wait_bit_common+0x13f/0x340
[208400.706021]  ? __pfx_wake_page_function+0x10/0x10
[208400.706296]  folio_wait_writeback+0x2b/0x80
[208400.706644]  __filemap_fdatawait_range+0x80/0xe0
[208400.707037]  filemap_write_and_wait_range+0x85/0xb0
[208400.707436]  xfs_setattr_size+0xd9/0x3c0 [xfs]
[208400.707955]  xfs_vn_setattr+0x81/0x150 [xfs]
[208400.708365]  notify_change+0x2ed/0x4f0
[208400.708638]  ? do_truncate+0x98/0xf0
[208400.708855]  do_truncate+0x98/0xf0
[208400.709050]  do_ftruncate+0xfe/0x160
[208400.709329]  __x64_sys_ftruncate+0x3e/0x70
[208400.709656]  do_syscall_64+0xb7/0x200
[208400.710041]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[208400.710367] RIP: 0033:0x7fab32912c2b
[208400.710614] RSP: 002b:00007ffee94d7e18 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[208400.711093] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab32912c2b
[208400.711503] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000011
[208400.711947] RBP: 0000000000000011 R08: 0000000000000000 R09: 00007ffee94d7dc0
[208400.712355] R10: 0000000000068000 R11: 0000000000000246 R12: 000055f3aca90b20
[208400.712776] R13: 000055f3acb2d3d8 R14: 0000000000000001 R15: 000055f3acb3a3a8
[208400.713222]  </TASK>

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41283.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41283.log"
Content-Transfer-Encoding: 7bit

[820710.966217] INFO: task nix-build:884370 blocked for more than 122 seconds.
[820710.966643]       Not tainted 6.11.0 #1-NixOS
[820710.966890] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[820710.967307] task:nix-build       state:D stack:0     pid:884370 tgid:884370 ppid:884369 flags:0x00000002
[820710.967913] Call Trace:
[820710.968056]  <TASK>
[820710.968189]  __schedule+0x3a3/0x1300
[820710.968391]  schedule+0x27/0xf0
[820710.968563]  io_schedule+0x46/0x70
[820710.968758]  folio_wait_bit_common+0x13f/0x340
[820710.968998]  ? __pfx_wake_page_function+0x10/0x10
[820710.969258]  folio_wait_writeback+0x2b/0x80
[820710.969485]  truncate_inode_partial_folio+0x5e/0x1b0
[820710.969753]  truncate_inode_pages_range+0x1de/0x400
[820710.970041]  evict+0x29f/0x2c0
[820710.970230]  ? iput+0x6e/0x230
[820710.970399]  ? _atomic_dec_and_lock+0x39/0x50
[820710.970633]  do_unlinkat+0x2de/0x330
[820710.970837]  __x64_sys_unlink+0x3f/0x70
[820710.971042]  do_syscall_64+0xb7/0x200
[820710.971257]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[820710.971528] RIP: 0033:0x7f09e0e2d56b
[820710.971740] RSP: 002b:00007ffed1ddeb58 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
[820710.972131] RAX: ffffffffffffffda RBX: 00005587092aa500 RCX: 00007f09e0e2d56b
[820710.972503] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005587092abc80
[820710.972875] RBP: 00005587092aa690 R08: 0000000000016020 R09: 0000000000000000
[820710.973249] R10: 0000000000000080 R11: 0000000000000202 R12: 00007ffed1ddeb98
[820710.973623] R13: 00007ffed1ddeb7c R14: 00007ffed1ddf4a0 R15: 0000558711268cd0
[820710.973998]  </TASK>
[820710.974122] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41285.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41285.log"
Content-Transfer-Encoding: 7bit

[217499.576744] INFO: task nix-build:176931 blocked for more than 122 seconds.
[217499.577213]       Not tainted 6.11.0 #1-NixOS
[217499.577455] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[217499.577910] task:nix-build       state:D stack:0     pid:176931 tgid:176931 ppid:176930 flags:0x00004002
[217499.578417] Call Trace:
[217499.578560]  <TASK>
[217499.578697]  __schedule+0x3a3/0x1300
[217499.578920]  ? xfs_vm_writepages+0x67/0x90 [xfs]
[217499.579333]  schedule+0x27/0xf0
[217499.579515]  io_schedule+0x46/0x70
[217499.579721]  folio_wait_bit_common+0x13f/0x340
[217499.579981]  ? __pfx_wake_page_function+0x10/0x10
[217499.580241]  folio_wait_writeback+0x2b/0x80
[217499.580475]  __filemap_fdatawait_range+0x80/0xe0
[217499.580740]  file_write_and_wait_range+0x88/0xb0
[217499.581004]  xfs_file_fsync+0x5e/0x2a0 [xfs]
[217499.581586]  __x64_sys_fdatasync+0x52/0x90
[217499.581856]  do_syscall_64+0xb7/0x200
[217499.582069]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[217499.582349] RIP: 0033:0x7f56be82f70a
[217499.582563] RSP: 002b:00007fff458db490 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
[217499.582988] RAX: ffffffffffffffda RBX: 000055af3319bbf8 RCX: 00007f56be82f70a
[217499.583372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[217499.583760] RBP: 0000000000000000 R08: 0000000000000001 R09: 000055af3b0fefe8
[217499.584169] R10: 000000000000007e R11: 0000000000000293 R12: 0000000000000001
[217499.584552] R13: 0000000000000197 R14: 000055af3b0ff33e R15: 00007fff458db690
[217499.584951]  </TASK>

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41286.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41286.log"
Content-Transfer-Encoding: 7bit

[217499.576744] INFO: task nix-build:176931 blocked for more than 122 seconds.
[217499.577213]       Not tainted 6.11.0 #1-NixOS
[217499.577455] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[217499.577910] task:nix-build       state:D stack:0     pid:176931 tgid:176931 ppid:176930 flags:0x00004002
[217499.578417] Call Trace:
[217499.578560]  <TASK>
[217499.578697]  __schedule+0x3a3/0x1300
[217499.578920]  ? xfs_vm_writepages+0x67/0x90 [xfs]
[217499.579333]  schedule+0x27/0xf0
[217499.579515]  io_schedule+0x46/0x70
[217499.579721]  folio_wait_bit_common+0x13f/0x340
[217499.579981]  ? __pfx_wake_page_function+0x10/0x10
[217499.580241]  folio_wait_writeback+0x2b/0x80
[217499.580475]  __filemap_fdatawait_range+0x80/0xe0
[217499.580740]  file_write_and_wait_range+0x88/0xb0
[217499.581004]  xfs_file_fsync+0x5e/0x2a0 [xfs]
[217499.581586]  __x64_sys_fdatasync+0x52/0x90
[217499.581856]  do_syscall_64+0xb7/0x200
[217499.582069]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[217499.582349] RIP: 0033:0x7f56be82f70a
[217499.582563] RSP: 002b:00007fff458db490 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
[217499.582988] RAX: ffffffffffffffda RBX: 000055af3319bbf8 RCX: 00007f56be82f70a
[217499.583372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[217499.583760] RBP: 0000000000000000 R08: 0000000000000001 R09: 000055af3b0fefe8
[217499.584169] R10: 000000000000007e R11: 0000000000000293 R12: 0000000000000001
[217499.584552] R13: 0000000000000197 R14: 000055af3b0ff33e R15: 00007fff458db690
[217499.584951]  </TASK>
[217565.040136] systemd[1]: fc-agent.service: Deactivated successfully.
[217565.041118] systemd[1]: Finished Flying Circus Management Task.
[217565.041814] systemd[1]: fc-agent.service: Consumed 18.400s CPU time, received 28.9M IP traffic, sent 158.2K IP traffic.
[217637.400585] systemd[1]: Created slice Slice /user/1003.
[217637.407307] systemd[1]: Starting User Runtime Directory /run/user/1003...
[217637.426906] systemd[1]: Finished User Runtime Directory /run/user/1003.
[217637.439512] systemd[1]: Starting User Manager for UID 1003...
[217637.644565] systemd[1]: Started User Manager for UID 1003.
[217637.652243] systemd[1]: Started Session 3 of User ctheune.

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41287.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41287.log"
Content-Transfer-Encoding: 7bit

[215042.580872] INFO: task nix-build:240798 blocked for more than 122 seconds.
[215042.581318]       Not tainted 6.11.0 #1-NixOS
[215042.581624] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[215042.582070] task:nix-build       state:D stack:0     pid:240798 tgid:240798 ppid:240797 flags:0x00000002
[215042.582573] Call Trace:
[215042.582713]  <TASK>
[215042.582860]  __schedule+0x3a3/0x1300
[215042.583069]  ? xfs_vm_writepages+0x67/0x90 [xfs]
[215042.583469]  schedule+0x27/0xf0
[215042.583651]  io_schedule+0x46/0x70
[215042.583859]  folio_wait_bit_common+0x13f/0x340
[215042.584108]  ? __pfx_wake_page_function+0x10/0x10
[215042.584364]  folio_wait_writeback+0x2b/0x80
[215042.584594]  __filemap_fdatawait_range+0x80/0xe0
[215042.584856]  file_write_and_wait_range+0x88/0xb0
[215042.585109]  xfs_file_fsync+0x5e/0x2a0 [xfs]
[215042.585471]  __x64_sys_fdatasync+0x52/0x90
[215042.585698]  do_syscall_64+0xb7/0x200
[215042.585916]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[215042.586191] RIP: 0033:0x7ff0c831270a
[215042.586406] RSP: 002b:00007ffe1482b960 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
[215042.586818] RAX: ffffffffffffffda RBX: 0000564877f8abf8 RCX: 00007ff0c831270a
[215042.587197] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[215042.587574] RBP: 0000000000000000 R08: 0000000000000001 R09: 000056487ff73f78
[215042.587960] R10: 0000000000000082 R11: 0000000000000293 R12: 0000000000000001
[215042.588337] R13: 00000000000001a0 R14: 000056487ff742e0 R15: 00007ffe1482bb60
[215042.588716]  </TASK>
[215120.626730] systemd[1]: Created slice Slice /user/1003.
[215120.633868] systemd[1]: Starting User Runtime Directory /run/user/1003...
[215120.664698] systemd[1]: Finished User Runtime Directory /run/user/1003.
[215120.673752] systemd[1]: Starting User Manager for UID 1003...
[215121.175903] systemd[1]: Started User Manager for UID 1003.
[215121.182026] systemd[1]: Started Session 1 of User ctheune.

[215135.177690429]

240798 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[215140.478882357]

240798 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----


[215145.029642882]

240798 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f


-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----


[215150.173831058]

240798 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[215155.155491198]

240798 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] file_write_and_wait_range+0x88/0xb0
[<0>] xfs_file_fsync+0x5e/0x2a0 [xfs]
[<0>] __x64_sys_fdatasync+0x52/0x90
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----


[215163.267601] systemd[1]: fc-agent.service: Deactivated successfully.
[215163.268172] systemd[1]: Finished Flying Circus Management Task.
[215163.269162] systemd[1]: fc-agent.service: Consumed 19.683s CPU time, received 28.9M IP traffic, sent 152.5K IP traffic.

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41288.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41288.log"
Content-Transfer-Encoding: 7bit

[217748.915126] INFO: task nix-build:198761 blocked for more than 122 seconds.
[217748.916085]       Not tainted 6.11.0 #1-NixOS
[217748.916639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[217748.917636] task:nix-build       state:D stack:0     pid:198761 tgid:198761 ppid:198760 flags:0x00000002
[217748.918897] Call Trace:
[217748.919271]  <TASK>
[217748.919593]  __schedule+0x3a3/0x1300
[217748.920118]  ? xfs_btree_insrec+0x32c/0x570 [xfs]
[217748.921070]  schedule+0x27/0xf0
[217748.921483]  io_schedule+0x46/0x70
[217748.921921]  folio_wait_bit_common+0x13f/0x340
[217748.922508]  ? __pfx_wake_page_function+0x10/0x10
[217748.923115]  folio_wait_writeback+0x2b/0x80
[217748.923647]  truncate_inode_partial_folio+0x5e/0x1b0
[217748.924286]  truncate_inode_pages_range+0x1de/0x400
[217748.924903]  evict+0x29f/0x2c0
[217748.925325]  ? iput+0x6e/0x230
[217748.925722]  ? _atomic_dec_and_lock+0x39/0x50
[217748.926290]  do_unlinkat+0x2de/0x330
[217748.926751]  __x64_sys_unlink+0x3f/0x70
[217748.927247]  do_syscall_64+0xb7/0x200
[217748.927716]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[217748.928375] RIP: 0033:0x7f177b02d56b
[217748.928860] RSP: 002b:00007ffe6bb88658 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
[217748.929804] RAX: ffffffffffffffda RBX: 000055fd811835b0 RCX: 00007f177b02d56b
[217748.930700] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055fd81184d30
[217748.931615] RBP: 000055fd81183740 R08: 0000000000016020 R09: 0000000000000000
[217748.932508] R10: 0000000000000030 R11: 0000000000000202 R12: 00007ffe6bb88698
[217748.933422] R13: 00007ffe6bb8867c R14: 00007ffe6bb88fa0 R15: 000055fd890e1a50
[217748.934341]  </TASK>

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Disposition: attachment;
	filename=FC-41289.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="FC-41289.log"
Content-Transfer-Encoding: 7bit

[218237.291578] INFO: task nix-build:176536 blocked for more than 122 seconds.
[218237.292026]       Not tainted 6.11.0 #1-NixOS
[218237.292261] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[218237.292695] task:nix-build       state:D stack:0     pid:176536 tgid:176536 ppid:176535 flags:0x00000002
[218237.293188] Call Trace:
[218237.293326]  <TASK>
[218237.293458]  __schedule+0x3a3/0x1300
[218237.293673]  ? xfs_vm_writepages+0x67/0x90 [xfs]
[218237.294063]  schedule+0x27/0xf0
[218237.294240]  io_schedule+0x46/0x70
[218237.294426]  folio_wait_bit_common+0x13f/0x340
[218237.294696]  ? __pfx_wake_page_function+0x10/0x10
[218237.295038]  folio_wait_writeback+0x2b/0x80
[218237.295270]  __filemap_fdatawait_range+0x80/0xe0
[218237.295541]  filemap_write_and_wait_range+0x85/0xb0
[218237.295804]  xfs_setattr_size+0xd9/0x3c0 [xfs]
[218237.296173]  xfs_vn_setattr+0x81/0x150 [xfs]
[218237.296530]  notify_change+0x2ed/0x4f0
[218237.296777]  ? do_truncate+0x98/0xf0
[218237.296996]  do_truncate+0x98/0xf0
[218237.297183]  do_ftruncate+0xfe/0x160
[218237.297378]  __x64_sys_ftruncate+0x3e/0x70
[218237.297632]  do_syscall_64+0xb7/0x200
[218237.297836]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[218237.298111] RIP: 0033:0x7f0453b12c2b
[218237.298316] RSP: 002b:00007ffe9f6db828 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[218237.298742] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0453b12c2b
[218237.299116] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000011
[218237.299492] RBP: 0000000000000011 R08: 0000000000000000 R09: 00007ffe9f6db7d0
[218237.299869] R10: 0000000000018000 R11: 0000000000000246 R12: 00005562ff27fb20
[218237.300241] R13: 00005562ff31c3d8 R14: 0000000000000001 R15: 00005562ff3293a8
[218237.300631]  </TASK>
[218261.984778] systemd[1]: Created slice Slice /user/1003.
[218261.989545] systemd[1]: Starting User Runtime Directory /run/user/1003...
[218262.000938] systemd[1]: Finished User Runtime Directory /run/user/1003.
[218262.005583] systemd[1]: Starting User Manager for UID 1003...
[218262.105005] systemd[1]: Started User Manager for UID 1003.
[218262.109759] systemd[1]: Started Session 7 of User ctheune.


[218269.921479398]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[218274.052571366]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[218278.588908363]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[218283.450120071]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[218287.296514668]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

[218290.957136179]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

# dstat
You did not select any stats, using -cdngy by default.
--total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw
  5   1  92   1   1|7869B  145k|   0     0 |  17B  442B| 611   801
  2   1   0  97   0|   0  1488k|  21k 7707B|   0     0 |1030  1385
  2   1   0  96   1|   0  1076k|  20k 5616B|   0     0 | 981  1296
  1   0   0  99   0|   0  1196k|  11k  454B|   0     0 | 711   987 ^C

[218298.44665228]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           2  0.0  0.0      0     0 ?        S    Oct08   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-slub_flushwq]
root           7  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/0:0H-kblockd]
root          13  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mm_percpu_wq]
root          14  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_kthread]
root          15  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_rude_kthread]
root          16  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_trace_kthread]
root          17  0.0  0.0      0     0 ?        S    Oct08   0:25  \_ [ksoftirqd/0]
root          18  0.0  0.0      0     0 ?        I    Oct08   1:12  \_ [rcu_preempt]
root          19  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_par_gp_kthread_worker/0]
root          20  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_gp_kthread_worker]
root          21  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [migration/0]
root          22  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [idle_inject/0]
root          23  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [cpuhp/0]
root          24  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kdevtmpfs]
root          25  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-inet_frag_wq]
root          26  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kauditd]
root          27  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [khungtaskd]
root          28  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [oom_reaper]
root          29  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-writeback]
root          30  0.0  0.0      0     0 ?        S    Oct08   0:02  \_ [kcompactd0]
root          31  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [ksmd]
root          32  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [khugepaged]
root          33  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kintegrityd]
root          34  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kblockd]
root          35  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-blkcg_punt_bio]
root          36  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [irq/9-acpi]
root          37  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md]
root          38  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md_bitmap]
root          39  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-devfreq_wq]
root          44  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kswapd0]
root          45  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kthrotld]
root          46  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mld]
root          47  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ipv6_addrconf]
root          54  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kstrp]
root          55  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/u5:0]
root         102  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [hwrng]
root         109  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [watchdogd]
root         149  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ata_sff]
root         150  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_0]
root         151  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_0]
root         152  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_1]
root         153  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_1]
root         184  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfsalloc]
root         185  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs_mru_cache]
root         186  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vda1]
root         187  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vda1]
root         188  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vda1]
root         189  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vda1]
root         190  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vda1]
root         191  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vda1]
root         192  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vda1]
root         193  0.0  0.0      0     0 ?        S    Oct08   0:20  \_ [xfsaild/vda1]
root         531  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root         644  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vdc1]
root         645  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vdc1]
root         646  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vdc1]
root         647  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vdc1]
root         648  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vdc1]
root         649  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vdc1]
root         650  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vdc1]
root         651  0.0  0.0      0     0 ?        S    Oct08   0:05  \_ [xfsaild/vdc1]
root         723  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ttm]
root        1286  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-tls-strp]
root        2772  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root      171717  0.0  0.0      0     0 ?        I    09:03   0:00  \_ [kworker/u4:3-events_power_efficient]
root      174477  0.0  0.0      0     0 ?        I    10:01   0:00  \_ [kworker/0:2-xfs-conv/vdc1]
root      174683  0.0  0.0      0     0 ?        I    10:06   0:00  \_ [kworker/u4:2-events_power_efficient]
root      175378  0.0  0.0      0     0 ?        I    10:20   0:00  \_ [kworker/u4:4-events_unbound]
root      176049  0.0  0.0      0     0 ?        I    10:34   0:00  \_ [kworker/0:3-xfs-conv/vdc1]
root      176150  0.0  0.0      0     0 ?        I<   10:35   0:00  \_ [kworker/0:1H-xfs-log/vda1]
root      176358  0.0  0.0      0     0 ?        I    10:40   0:00  \_ [kworker/0:0-xfs-conv/vdc1]
root      176402  0.0  0.0      0     0 ?        I    10:41   0:00  \_ [kworker/u4:0-events_power_efficient]
root      176544  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:1-writeback]
root      176545  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:5-writeback]
root      176546  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:6-events_power_efficient]
root      176549  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:1-xfs-conv/vdc1]
root      176550  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:4-xfs-conv/vdc1]
root      176551  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:5-xfs-conv/vdc1]
root      176552  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:6-xfs-conv/vdc1]
root      176553  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:7-xfs-conv/vdc1]
root      176554  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:8-xfs-conv/vdc1]
root      176555  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:9-xfs-conv/vdc1]
root      176556  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:10-xfs-conv/vdc1]
root      176557  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:11-xfs-conv/vdc1]
root      176558  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:12-kthrotld]
root      176559  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:13-xfs-conv/vdc1]
root      176560  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:14-xfs-conv/vdc1]
root      176561  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:15-xfs-conv/vdc1]
root      176562  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:16-xfs-conv/vdc1]
root      176563  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:17-xfs-conv/vdc1]
root      176564  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:18-xfs-conv/vdc1]
root      176565  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:19-xfs-conv/vdc1]
root      176566  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:20-xfs-conv/vdc1]
root      176567  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:21-xfs-conv/vdc1]
root      176568  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:22-xfs-conv/vdc1]
root      176569  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:23-xfs-conv/vdc1]
root      176570  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:24-xfs-conv/vdc1]
root      176571  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:25-xfs-conv/vdc1]
root      176572  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:26-xfs-conv/vdc1]
root      176573  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:27-xfs-conv/vdc1]
root      176574  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:28-xfs-conv/vdc1]
root      176575  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:29-xfs-conv/vdc1]
root      176576  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:30-xfs-conv/vdc1]
root      176577  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:31-xfs-conv/vdc1]
root      176578  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:32-xfs-conv/vdc1]
root      176579  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:33-xfs-conv/vdc1]
root      176580  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:34-xfs-conv/vdc1]
root      176581  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:35-xfs-conv/vdc1]
root      176582  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:36-xfs-conv/vdc1]
root      176583  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:37-xfs-conv/vdc1]
root      176584  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:38-xfs-conv/vdc1]
root      176585  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:39-xfs-conv/vdc1]
root      176586  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:40-xfs-conv/vdc1]
root      176587  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:41-xfs-buf/vdc1]
root      176588  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:42-xfs-conv/vdc1]
root      176589  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:43-xfs-conv/vdc1]
root      176590  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:44-xfs-conv/vdc1]
root      176591  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:45-xfs-conv/vdc1]
root      176592  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:46-xfs-conv/vdc1]
root      176593  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:47-xfs-conv/vdc1]
root      176594  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:48-xfs-conv/vdc1]
root      176595  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:49-xfs-conv/vdc1]
root      176596  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:50-xfs-conv/vdc1]
root      176597  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:51-xfs-conv/vdc1]
root      176598  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:52-xfs-conv/vdc1]
root      176599  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:53-xfs-conv/vdc1]
root      176600  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:54-xfs-conv/vdc1]
root      176601  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:55-xfs-conv/vdc1]
root      176602  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:56-xfs-conv/vdc1]
root      176603  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:57-xfs-conv/vdc1]
root      176604  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:58-xfs-conv/vdc1]
root      176605  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:59-xfs-conv/vdc1]
root      176606  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:60-xfs-conv/vdc1]
root      176607  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:61-xfs-conv/vdc1]
root      176608  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:62-xfs-conv/vdc1]
root      176609  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:63-xfs-conv/vdc1]
root      176610  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:64-xfs-conv/vdc1]
root      176611  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:65-xfs-conv/vdc1]
root      176612  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:66-xfs-conv/vdc1]
root      176613  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:67-xfs-conv/vdc1]
root      176614  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:68-xfs-conv/vdc1]
root      176615  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:69-xfs-conv/vdc1]
root      176616  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:70-xfs-conv/vdc1]
root      176617  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:71-xfs-conv/vdc1]
root      176618  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:72-xfs-conv/vdc1]
root      176619  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:73-xfs-conv/vdc1]
root      176620  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:74-xfs-conv/vdc1]
root      176621  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:75-xfs-conv/vdc1]
root      176622  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:76-xfs-conv/vdc1]
root      176623  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:77-xfs-conv/vdc1]
root      176624  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:78-xfs-conv/vdc1]
root      176625  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:79-xfs-conv/vdc1]
root      176626  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:80-xfs-conv/vdc1]
root      176627  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:81-xfs-conv/vdc1]
root      176628  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:82-xfs-conv/vdc1]
root      176629  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:83-xfs-conv/vdc1]
root      176630  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:84-xfs-conv/vdc1]
root      176631  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:85-xfs-conv/vdc1]
root      176632  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:86-xfs-conv/vdc1]
root      176633  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:87-xfs-conv/vdc1]
root      176634  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:88-xfs-conv/vdc1]
root      176635  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:89-xfs-conv/vdc1]
root      176636  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:90-xfs-conv/vdc1]
root      176637  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:91-xfs-conv/vdc1]
root      176638  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:92-xfs-conv/vdc1]
root      176639  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:93-xfs-conv/vdc1]
root      176640  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:94-xfs-conv/vdc1]
root      176641  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:95-xfs-conv/vdc1]
root      176642  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:96-xfs-conv/vdc1]
root      176643  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:97-xfs-conv/vdc1]
root      176644  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:98-xfs-conv/vdc1]
root      176645  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:99-xfs-conv/vdc1]
root      176646  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:100-xfs-conv/vdc1]
root      176647  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:101-xfs-conv/vdc1]
root      176648  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:102-xfs-conv/vdc1]
root      176649  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:103-xfs-conv/vdc1]
root      176650  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:104-xfs-conv/vdc1]
root      176651  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:105-xfs-conv/vdc1]
root      176652  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:106-xfs-conv/vdc1]
root      176653  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:107-xfs-conv/vdc1]
root      176654  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:108-xfs-conv/vdc1]
root      176655  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:109-xfs-conv/vdc1]
root      176656  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:110-xfs-conv/vdc1]
root      176657  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:111-xfs-conv/vdc1]
root      176658  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:112-xfs-conv/vdc1]
root      176659  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:113-xfs-conv/vdc1]
root      176660  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:114-xfs-conv/vdc1]
root      176661  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:115-xfs-conv/vdc1]
root      176662  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:116-xfs-conv/vdc1]
root      176663  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:117-xfs-conv/vdc1]
root      176664  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:118-xfs-conv/vdc1]
root      176665  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:119-xfs-conv/vdc1]
root      176666  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:120-xfs-conv/vdc1]
root      176667  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:121-xfs-conv/vdc1]
root      176668  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:122-xfs-conv/vdc1]
root      176669  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:123-xfs-conv/vdc1]
root      176670  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:124-xfs-conv/vdc1]
root      176671  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:125-xfs-conv/vdc1]
root      176672  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:126-xfs-conv/vdc1]
root      176673  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:127-xfs-conv/vdc1]
root      176674  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:128-xfs-conv/vdc1]
root      176675  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:129-xfs-conv/vdc1]
root      176676  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:130-xfs-conv/vdc1]
root      176677  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:131-xfs-conv/vdc1]
root      176678  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:132-xfs-conv/vdc1]
root      176679  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:133-xfs-conv/vdc1]
root      176680  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:134-xfs-conv/vdc1]
root      176681  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:135-xfs-conv/vdc1]
root      176682  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:136-xfs-conv/vdc1]
root      176683  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:137-xfs-conv/vdc1]
root      176684  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:138-xfs-conv/vdc1]
root      176685  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:139-xfs-conv/vdc1]
root      176686  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:140-xfs-conv/vdc1]
root      176687  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:141-xfs-conv/vdc1]
root      176688  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:142-xfs-conv/vdc1]
root      176689  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:143-xfs-conv/vdc1]
root      176690  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:144-xfs-conv/vdc1]
root      176691  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:145-xfs-conv/vdc1]
root      176692  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:146-xfs-conv/vdc1]
root      176693  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:147-xfs-conv/vdc1]
root      176694  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:148-xfs-conv/vdc1]
root      176695  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:149-xfs-conv/vdc1]
root      176696  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:150-xfs-conv/vdc1]
root      176697  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:151-xfs-conv/vdc1]
root      176698  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:152-xfs-conv/vdc1]
root      176699  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:153-xfs-conv/vdc1]
root      176700  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:154-xfs-conv/vdc1]
root      176701  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:155-xfs-conv/vdc1]
root      176702  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:156-xfs-conv/vdc1]
root      176703  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:157-xfs-conv/vdc1]
root      176704  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:158-xfs-buf/vda1]
root      176705  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:159-xfs-conv/vdc1]
root      176706  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:160-xfs-conv/vdc1]
root      176707  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:161-xfs-conv/vdc1]
root      176708  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:162-xfs-conv/vdc1]
root      176709  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:163-xfs-conv/vdc1]
root      176710  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:164-xfs-conv/vdc1]
root      176711  0.2  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:165-xfs-conv/vda1]
root      176712  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:166-xfs-conv/vdc1]
root      176713  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:167-xfs-conv/vdc1]
root      176714  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:168-xfs-conv/vdc1]
root      176715  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:169-xfs-conv/vdc1]
root      176716  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:170-xfs-conv/vdc1]
root      176717  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:171-xfs-conv/vdc1]
root      176718  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:172-xfs-conv/vdc1]
root      176719  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:173-xfs-conv/vdc1]
root      176720  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:174-xfs-conv/vdc1]
root      176721  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:175-xfs-conv/vdc1]
root      176722  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:176-xfs-conv/vdc1]
root      176723  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:177-xfs-conv/vdc1]
root      176724  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:178-xfs-conv/vdc1]
root      176725  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:179-xfs-conv/vdc1]
root      176726  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:180-xfs-conv/vdc1]
root      176727  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:181-xfs-conv/vdc1]
root      176728  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:182-xfs-conv/vdc1]
root      176729  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:183-xfs-conv/vdc1]
root      176730  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:184-xfs-conv/vdc1]
root      176731  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:185-xfs-conv/vdc1]
root      176732  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:186-xfs-conv/vdc1]
root      176733  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:187-xfs-conv/vdc1]
root      176734  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:188-xfs-conv/vdc1]
root      176735  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:189-xfs-conv/vdc1]
root      176736  0.3  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:190-cgroup_destroy]
root      176737  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:191-xfs-conv/vdc1]
root      176738  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:192-xfs-conv/vdc1]
root      176739  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:193-xfs-conv/vdc1]
root      176740  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:194-xfs-conv/vdc1]
root      176741  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:195-xfs-conv/vdc1]
root      176742  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:196-xfs-conv/vdc1]
root      176743  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:197-xfs-conv/vdc1]
root      176744  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:198-xfs-conv/vdc1]
root      176745  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:199-xfs-conv/vdc1]
root      176746  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:200-xfs-conv/vdc1]
root      176747  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:201-xfs-conv/vdc1]
root      176748  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:202-xfs-conv/vdc1]
root      176749  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:203-xfs-conv/vdc1]
root      176750  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:204-xfs-conv/vdc1]
root      176751  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:205-xfs-conv/vdc1]
root      176752  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:206-xfs-buf/vda1]
root      176753  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:207-xfs-conv/vdc1]
root      176754  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:208-xfs-conv/vdc1]
root      176755  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:209-xfs-conv/vdc1]
root      176756  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:210-xfs-conv/vdc1]
root      176757  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:211-xfs-conv/vdc1]
root      176758  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:212-xfs-conv/vdc1]
root      176759  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:213-xfs-conv/vdc1]
root      176760  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:214-xfs-conv/vdc1]
root      176761  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:215-xfs-conv/vdc1]
root      176762  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:216-xfs-conv/vdc1]
root      176763  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:217-xfs-conv/vdc1]
root      176764  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:218-xfs-conv/vdc1]
root      176765  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:219-xfs-conv/vdc1]
root      176766  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:220-xfs-conv/vdc1]
root      176767  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:221-xfs-conv/vdc1]
root      176768  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:222-xfs-conv/vdc1]
root      176769  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:223-xfs-conv/vdc1]
root      176770  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:224-xfs-conv/vdc1]
root      176771  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:225-xfs-conv/vdc1]
root      176772  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:226-xfs-conv/vdc1]
root      176773  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:227-xfs-conv/vdc1]
root      176774  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:228-xfs-conv/vdc1]
root      176775  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:229-xfs-conv/vdc1]
root      176776  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:230-xfs-conv/vdc1]
root      176777  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:231-xfs-conv/vdc1]
root      176778  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:232-xfs-conv/vdc1]
root      176779  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:233-xfs-conv/vdc1]
root      176780  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:234-xfs-conv/vdc1]
root      176781  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:235-xfs-conv/vdc1]
root      176782  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:236-xfs-conv/vdc1]
root      176783  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:237-xfs-conv/vdc1]
root      176784  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:238-xfs-conv/vdc1]
root      176785  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:239-xfs-conv/vdc1]
root      176786  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:240-xfs-conv/vdc1]
root      176787  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:241-xfs-conv/vdc1]
root      176788  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:242-xfs-conv/vdc1]
root      176789  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:243-xfs-conv/vdc1]
root      176790  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:244-xfs-conv/vdc1]
root      176791  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:245-xfs-conv/vdc1]
root      176792  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:246-xfs-conv/vdc1]
root      176793  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:247-xfs-conv/vdc1]
root      176794  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:248-xfs-conv/vdc1]
root      176795  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:249-xfs-conv/vdc1]
root      176796  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:250-xfs-conv/vdc1]
root      176797  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:251-xfs-conv/vdc1]
root      176798  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:252-xfs-conv/vdc1]
root      176799  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:253-xfs-conv/vdc1]
root      176800  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:254-xfs-conv/vdc1]
root      176801  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:255-xfs-conv/vdc1]
root      176802  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:256-xfs-buf/vda1]
root      176803  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:257-xfs-conv/vdc1]
root      176804  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:7-events_unbound]
root      176813  0.0  0.0      0     0 ?        I<   10:44   0:00  \_ [kworker/0:2H-kblockd]
root      176814  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/u4:8-events_unbound]
root      176815  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/0:258]
root           1  0.0  0.3  21852 13056 ?        Ss   Oct08   0:19 /run/current-system/systemd/lib/systemd/systemd
root         399  0.0  1.8 139764 75096 ?        Ss   Oct08   0:13 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-journald
root         455  0.0  0.2  33848  8168 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-udevd
systemd+     811  0.0  0.1  16800  6660 ?        Ss   Oct08   0:10 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-oomd
systemd+     816  0.0  0.1  91380  7952 ?        Ssl  Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-timesyncd
root         837  0.0  0.0  80596  3288 ?        Ssl  Oct08   1:37 /nix/store/ag3xk1l8ij06vx434abk8643f8p7i08c-qemu-host-cpu-only-8.2.6-ga/bin/qemu-ga --statedir /run/qemu-ga
root         840  0.0  0.0 226896  1984 ?        Ss   Oct08   0:00 /nix/store/k34f0d079arcgfjsq78gpkdbd6l6nnq4-cron-4.1/bin/cron -n
message+     850  0.0  0.1  13776  6080 ?        Ss   Oct08   0:05 /nix/store/0hm8vh65m378439kl16xv0p6l7c51asj-dbus-1.14.10/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         876  0.0  0.1  17468  7968 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-logind
nscd        1074  0.0  0.1 555748  6016 ?        Ssl  Oct08   0:28 /nix/store/zza9hvd6iawqdcxvinf4yxv580av3s9f-nsncd-unstable-2024-01-16/bin/nsncd
telegraf    1092  0.3  3.4 6344672 138484 ?      S<Lsl Oct08  13:05 /nix/store/8bnbkyh26j97l0pw02gb7lngh4n6k3r5-telegraf-1.30.3/bin/telegraf -config /nix/store/nh4k7bx1asm0kn1klhbmg52wk1qdcwpw-config.toml -config-directory /nix/store/dj77wnb5j
root        1093  0.0  1.5 1109328 60864 ?       Ssl  Oct08   2:24 /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/fn9jcsr2kp2kq3m2qd6qrkv6xh7jcj5g-fail2ban-1.0.2/bin/.fail2ban-server-wrapped -xf start
sensucl+    1094  0.0  0.9 898112 38340 ?        Ssl  Oct08   1:41 /nix/store/qqc6v89xn0g2w123wx85blkpc4pz2ags-ruby-2.7.8/bin/ruby /nix/store/dpvf0jdq1mbrdc90aapyrn2wvjbpckyv-sensu-check-env/bin/sensu-client -L warn -c /nix/store/ly677hg5b7szz
root        1098  0.0  0.1  11564  7568 ?        Ss   Oct08   0:00 sshd: /nix/store/1m888byzaqaig6azrrfpmjdyhgfliaga-openssh-9.7p1/bin/sshd -D -f /etc/ssh/sshd_config [listener] 0 of 10-100 startups
root      176967  0.0  0.2  14380  9840 ?        Ss   10:47   0:00  \_ sshd: ctheune [priv]
ctheune   176988  0.2  0.1  14540  5856 ?        S    10:47   0:00      \_ sshd: ctheune@pts/0
ctheune   176992  0.0  0.1 230756  5968 pts/0    Ss   10:47   0:00          \_ -bash
root      176998  0.0  0.0 228796  3956 pts/0    S+   10:47   0:00              \_ sudo -i
root      177001  0.0  0.0 228796  1604 pts/1    Ss   10:47   0:00                  \_ sudo -i
root      177002  0.0  0.1 230892  6064 pts/1    S    10:47   0:00                      \_ -bash
root      177041  0.0  0.1 232344  4264 pts/1    R+   10:48   0:00                          \_ ps auxf
root        1101  0.0  0.0 226928  1944 tty1     Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login --noclear --keep-baud tty1 115200,38400,9600 linux
root        1102  0.0  0.0 226928  2192 ttyS0    Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login ttyS0 --keep-baud vt220
_du4651+    1105  0.0  2.2 2505204 90824 ?       Ssl  Oct08   1:15 /nix/store/ff5j2is3di7praysyv232wfvcq7hvkii-filebeat-oss-7.17.16/bin/filebeat -e -c /nix/store/xlb56lv0f3j03l3v34x5jfvq8wng18ww-filebeat-journal-services19.gocept.net.json -pat
mysql       2809  0.3 18.6 4784932 750856 ?      Ssl  Oct08  11:47 /nix/store/9iq211dy95nqn484nx5z5mv3c7pc2h27-percona-server_lts-8.0.36-28/bin/mysqld --defaults-extra-file=/nix/store/frvxmffp9fpgq06bx89rgczyn6k6i51y-my.cnf --user=mysql --data
root      176527  0.0  0.0 227904  3236 ?        SNs  10:43   0:00 /nix/store/516kai7nl5dxr792c0nzq0jp8m4zvxpi-bash-5.2p32/bin/bash /nix/store/s8g5ls9d611hjq5psyd15sqbpqgrlwck-unit-script-fc-agent-start/bin/fc-agent-start
root      176535  0.1  1.1 279068 46452 ?        SN   10:43   0:00  \_ /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/gavi1rlv3ja79vl5hg3lgh07absa8yb9-python3.11-fc-agent-1.0/bin/.fc-manage-wrapped --enc-p
root      176536  3.5  1.8 635400 72368 ?        DNl  10:43   0:09      \_ nix-build --no-build-output <nixpkgs/nixos> -A system -I https://hydra.flyingcircus.io/build/496886/download/1/nixexprs.tar.xz --out-link /run/fc-agent-built-system
ctheune   176972  0.1  0.2  20028 11856 ?        Ss   10:47   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd --user
ctheune   176974  0.0  0.0  20368  3004 ?        S    10:47   0:00  \_ (sd-pam)

[218305.88474928]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           2  0.0  0.0      0     0 ?        S    Oct08   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-slub_flushwq]
root           7  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/0:0H-kblockd]
root          13  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mm_percpu_wq]
root          14  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_kthread]
root          15  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_rude_kthread]
root          16  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_trace_kthread]
root          17  0.0  0.0      0     0 ?        S    Oct08   0:25  \_ [ksoftirqd/0]
root          18  0.0  0.0      0     0 ?        I    Oct08   1:12  \_ [rcu_preempt]
root          19  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_par_gp_kthread_worker/0]
root          20  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_gp_kthread_worker]
root          21  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [migration/0]
root          22  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [idle_inject/0]
root          23  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [cpuhp/0]
root          24  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kdevtmpfs]
root          25  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-inet_frag_wq]
root          26  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kauditd]
root          27  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [khungtaskd]
root          28  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [oom_reaper]
root          29  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-writeback]
root          30  0.0  0.0      0     0 ?        S    Oct08   0:02  \_ [kcompactd0]
root          31  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [ksmd]
root          32  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [khugepaged]
root          33  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kintegrityd]
root          34  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kblockd]
root          35  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-blkcg_punt_bio]
root          36  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [irq/9-acpi]
root          37  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md]
root          38  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md_bitmap]
root          39  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-devfreq_wq]
root          44  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kswapd0]
root          45  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kthrotld]
root          46  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mld]
root          47  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ipv6_addrconf]
root          54  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kstrp]
root          55  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/u5:0]
root         102  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [hwrng]
root         109  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [watchdogd]
root         149  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ata_sff]
root         150  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_0]
root         151  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_0]
root         152  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_1]
root         153  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_1]
root         184  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfsalloc]
root         185  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs_mru_cache]
root         186  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vda1]
root         187  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vda1]
root         188  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vda1]
root         189  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vda1]
root         190  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vda1]
root         191  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vda1]
root         192  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vda1]
root         193  0.0  0.0      0     0 ?        S    Oct08   0:20  \_ [xfsaild/vda1]
root         531  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root         644  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vdc1]
root         645  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vdc1]
root         646  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vdc1]
root         647  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vdc1]
root         648  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vdc1]
root         649  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vdc1]
root         650  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vdc1]
root         651  0.0  0.0      0     0 ?        S    Oct08   0:05  \_ [xfsaild/vdc1]
root         723  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ttm]
root        1286  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-tls-strp]
root        2772  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root      171717  0.0  0.0      0     0 ?        I    09:03   0:00  \_ [kworker/u4:3-events_power_efficient]
root      174477  0.0  0.0      0     0 ?        I    10:01   0:00  \_ [kworker/0:2-xfs-conv/vdc1]
root      174683  0.0  0.0      0     0 ?        I    10:06   0:00  \_ [kworker/u4:2-events_unbound]
root      175378  0.0  0.0      0     0 ?        I    10:20   0:00  \_ [kworker/u4:4-writeback]
root      176049  0.0  0.0      0     0 ?        I    10:34   0:00  \_ [kworker/0:3-xfs-conv/vdc1]
root      176150  0.0  0.0      0     0 ?        I<   10:35   0:00  \_ [kworker/0:1H-xfs-log/vda1]
root      176358  0.0  0.0      0     0 ?        I    10:40   0:00  \_ [kworker/0:0-xfs-conv/vdc1]
root      176402  0.0  0.0      0     0 ?        I    10:41   0:00  \_ [kworker/u4:0-events_power_efficient]
root      176544  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:1-writeback]
root      176545  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:5-writeback]
root      176546  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:6-events_power_efficient]
root      176549  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:1-xfs-conv/vdc1]
root      176550  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:4-xfs-conv/vdc1]
root      176551  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:5-xfs-conv/vdc1]
root      176552  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:6-xfs-conv/vdc1]
root      176553  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:7-xfs-conv/vdc1]
root      176554  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:8-xfs-conv/vdc1]
root      176555  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:9-xfs-conv/vdc1]
root      176556  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:10-xfs-conv/vdc1]
root      176557  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:11-xfs-conv/vdc1]
root      176558  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:12-kthrotld]
root      176559  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:13-xfs-conv/vdc1]
root      176560  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:14-xfs-conv/vdc1]
root      176561  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:15-xfs-conv/vdc1]
root      176562  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:16-xfs-conv/vdc1]
root      176563  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:17-xfs-conv/vdc1]
root      176564  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:18-xfs-conv/vdc1]
root      176565  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:19-xfs-conv/vdc1]
root      176566  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:20-xfs-conv/vdc1]
root      176567  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:21-xfs-conv/vdc1]
root      176568  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:22-xfs-conv/vdc1]
root      176569  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:23-xfs-conv/vdc1]
root      176570  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:24-xfs-conv/vdc1]
root      176571  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:25-xfs-conv/vdc1]
root      176572  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:26-xfs-conv/vdc1]
root      176573  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:27-xfs-conv/vdc1]
root      176574  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:28-xfs-conv/vdc1]
root      176575  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:29-xfs-conv/vdc1]
root      176576  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:30-xfs-conv/vdc1]
root      176577  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:31-xfs-conv/vdc1]
root      176578  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:32-xfs-conv/vdc1]
root      176579  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:33-xfs-conv/vdc1]
root      176580  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:34-xfs-conv/vdc1]
root      176581  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:35-xfs-conv/vdc1]
root      176582  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:36-xfs-conv/vdc1]
root      176583  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:37-xfs-conv/vdc1]
root      176584  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:38-xfs-conv/vdc1]
root      176585  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:39-xfs-conv/vdc1]
root      176586  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:40-xfs-conv/vdc1]
root      176587  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:41-xfs-buf/vdc1]
root      176588  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:42-xfs-conv/vdc1]
root      176589  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:43-xfs-conv/vdc1]
root      176590  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:44-xfs-conv/vdc1]
root      176591  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:45-xfs-conv/vdc1]
root      176592  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:46-xfs-conv/vdc1]
root      176593  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:47-xfs-conv/vdc1]
root      176594  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:48-xfs-conv/vdc1]
root      176595  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:49-xfs-conv/vdc1]
root      176596  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:50-xfs-conv/vdc1]
root      176597  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:51-xfs-conv/vdc1]
root      176598  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:52-xfs-conv/vdc1]
root      176599  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:53-xfs-conv/vdc1]
root      176600  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:54-xfs-conv/vdc1]
root      176601  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:55-xfs-conv/vdc1]
root      176602  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:56-xfs-conv/vdc1]
root      176603  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:57-xfs-conv/vdc1]
root      176604  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:58-xfs-conv/vdc1]
root      176605  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:59-xfs-conv/vdc1]
root      176606  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:60-xfs-conv/vdc1]
root      176607  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:61-xfs-conv/vdc1]
root      176608  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:62-xfs-conv/vdc1]
root      176609  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:63-xfs-conv/vdc1]
root      176610  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:64-xfs-conv/vdc1]
root      176611  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:65-xfs-conv/vdc1]
root      176612  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:66-xfs-conv/vdc1]
root      176613  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:67-xfs-conv/vdc1]
root      176614  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:68-xfs-conv/vdc1]
root      176615  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:69-xfs-conv/vdc1]
root      176616  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:70-xfs-conv/vdc1]
root      176617  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:71-xfs-conv/vdc1]
root      176618  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:72-xfs-conv/vdc1]
root      176619  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:73-xfs-conv/vdc1]
root      176620  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:74-xfs-conv/vdc1]
root      176621  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:75-xfs-conv/vdc1]
root      176622  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:76-xfs-conv/vdc1]
root      176623  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:77-xfs-conv/vdc1]
root      176624  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:78-xfs-conv/vdc1]
root      176625  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:79-xfs-conv/vdc1]
root      176626  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:80-xfs-conv/vdc1]
root      176627  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:81-xfs-conv/vdc1]
root      176628  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:82-xfs-conv/vdc1]
root      176629  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:83-xfs-conv/vdc1]
root      176630  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:84-xfs-conv/vdc1]
root      176631  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:85-xfs-conv/vdc1]
root      176632  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:86-xfs-conv/vdc1]
root      176633  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:87-xfs-conv/vdc1]
root      176634  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:88-xfs-conv/vdc1]
root      176635  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:89-xfs-conv/vdc1]
root      176636  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:90-xfs-conv/vdc1]
root      176637  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:91-xfs-conv/vdc1]
root      176638  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:92-xfs-conv/vdc1]
root      176639  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:93-xfs-conv/vdc1]
root      176640  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:94-xfs-conv/vdc1]
root      176641  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:95-xfs-conv/vdc1]
root      176642  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:96-xfs-conv/vdc1]
root      176643  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:97-xfs-conv/vdc1]
root      176644  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:98-xfs-conv/vdc1]
root      176645  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:99-xfs-conv/vdc1]
root      176646  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:100-xfs-conv/vdc1]
root      176647  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:101-xfs-conv/vdc1]
root      176648  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:102-xfs-conv/vdc1]
root      176649  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:103-xfs-conv/vdc1]
root      176650  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:104-xfs-conv/vdc1]
root      176651  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:105-xfs-conv/vdc1]
root      176652  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:106-xfs-conv/vdc1]
root      176653  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:107-xfs-conv/vdc1]
root      176654  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:108-xfs-conv/vdc1]
root      176655  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:109-xfs-conv/vdc1]
root      176656  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:110-xfs-conv/vdc1]
root      176657  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:111-xfs-conv/vdc1]
root      176658  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:112-xfs-conv/vdc1]
root      176659  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:113-xfs-conv/vdc1]
root      176660  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:114-xfs-conv/vdc1]
root      176661  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:115-xfs-conv/vdc1]
root      176662  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:116-xfs-conv/vdc1]
root      176663  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:117-xfs-conv/vdc1]
root      176664  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:118-xfs-conv/vdc1]
root      176665  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:119-xfs-conv/vdc1]
root      176666  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:120-xfs-conv/vdc1]
root      176667  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:121-xfs-conv/vdc1]
root      176668  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:122-xfs-conv/vdc1]
root      176669  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:123-xfs-conv/vdc1]
root      176670  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:124-xfs-conv/vdc1]
root      176671  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:125-xfs-conv/vdc1]
root      176672  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:126-xfs-conv/vdc1]
root      176673  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:127-xfs-conv/vdc1]
root      176674  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:128-xfs-conv/vdc1]
root      176675  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:129-xfs-conv/vdc1]
root      176676  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:130-xfs-conv/vdc1]
root      176677  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:131-xfs-conv/vdc1]
root      176678  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:132-xfs-conv/vdc1]
root      176679  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:133-xfs-conv/vdc1]
root      176680  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:134-xfs-conv/vdc1]
root      176681  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:135-xfs-conv/vdc1]
root      176682  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:136-xfs-conv/vdc1]
root      176683  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:137-xfs-conv/vdc1]
root      176684  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:138-xfs-conv/vdc1]
root      176685  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:139-xfs-conv/vdc1]
root      176686  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:140-xfs-conv/vdc1]
root      176687  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:141-xfs-conv/vdc1]
root      176688  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:142-xfs-conv/vdc1]
root      176689  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:143-xfs-conv/vdc1]
root      176690  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:144-xfs-conv/vdc1]
root      176691  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:145-xfs-conv/vdc1]
root      176692  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:146-xfs-conv/vdc1]
root      176693  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:147-xfs-conv/vdc1]
root      176694  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:148-xfs-conv/vdc1]
root      176695  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:149-xfs-conv/vdc1]
root      176696  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:150-xfs-conv/vdc1]
root      176697  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:151-xfs-conv/vdc1]
root      176698  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:152-xfs-conv/vdc1]
root      176699  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:153-xfs-conv/vdc1]
root      176700  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:154-xfs-conv/vdc1]
root      176701  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:155-xfs-conv/vdc1]
root      176702  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:156-xfs-conv/vdc1]
root      176703  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:157-xfs-conv/vdc1]
root      176704  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:158-xfs-buf/vda1]
root      176705  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:159-xfs-conv/vdc1]
root      176706  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:160-xfs-conv/vdc1]
root      176707  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:161-xfs-conv/vdc1]
root      176708  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:162-xfs-conv/vdc1]
root      176709  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:163-xfs-conv/vdc1]
root      176710  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:164-xfs-conv/vdc1]
root      176711  0.2  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:165-xfs-conv/vda1]
root      176712  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:166-xfs-conv/vdc1]
root      176713  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:167-xfs-conv/vdc1]
root      176714  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:168-xfs-conv/vdc1]
root      176715  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:169-xfs-conv/vdc1]
root      176716  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:170-xfs-conv/vdc1]
root      176717  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:171-xfs-conv/vdc1]
root      176718  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:172-xfs-conv/vdc1]
root      176719  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:173-xfs-conv/vdc1]
root      176720  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:174-xfs-conv/vdc1]
root      176721  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:175-xfs-conv/vdc1]
root      176722  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:176-xfs-conv/vdc1]
root      176723  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:177-xfs-conv/vdc1]
root      176724  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:178-xfs-conv/vdc1]
root      176725  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:179-xfs-conv/vdc1]
root      176726  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:180-xfs-conv/vdc1]
root      176727  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:181-xfs-conv/vdc1]
root      176728  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:182-xfs-conv/vdc1]
root      176729  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:183-xfs-conv/vdc1]
root      176730  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:184-xfs-conv/vdc1]
root      176731  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:185-xfs-conv/vdc1]
root      176732  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:186-xfs-conv/vdc1]
root      176733  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:187-xfs-conv/vdc1]
root      176734  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:188-xfs-conv/vdc1]
root      176735  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:189-xfs-conv/vdc1]
root      176736  0.3  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:190-cgroup_destroy]
root      176737  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:191-xfs-conv/vdc1]
root      176738  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:192-xfs-conv/vdc1]
root      176739  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:193-xfs-conv/vdc1]
root      176740  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:194-xfs-conv/vdc1]
root      176741  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:195-xfs-conv/vdc1]
root      176742  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:196-xfs-conv/vdc1]
root      176743  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:197-xfs-conv/vdc1]
root      176744  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:198-xfs-conv/vdc1]
root      176745  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:199-xfs-conv/vdc1]
root      176746  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:200-xfs-conv/vdc1]
root      176747  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:201-xfs-conv/vdc1]
root      176748  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:202-xfs-conv/vdc1]
root      176749  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:203-xfs-conv/vdc1]
root      176750  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:204-xfs-conv/vdc1]
root      176751  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:205-xfs-conv/vdc1]
root      176752  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:206-xfs-buf/vda1]
root      176753  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:207-xfs-conv/vdc1]
root      176754  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:208-xfs-conv/vdc1]
root      176755  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:209-xfs-conv/vdc1]
root      176756  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:210-xfs-conv/vdc1]
root      176757  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:211-xfs-conv/vdc1]
root      176758  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:212-xfs-conv/vdc1]
root      176759  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:213-xfs-conv/vdc1]
root      176760  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:214-xfs-conv/vdc1]
root      176761  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:215-xfs-conv/vdc1]
root      176762  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:216-xfs-conv/vdc1]
root      176763  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:217-xfs-conv/vdc1]
root      176764  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:218-xfs-conv/vdc1]
root      176765  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:219-xfs-conv/vdc1]
root      176766  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:220-xfs-conv/vdc1]
root      176767  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:221-xfs-conv/vdc1]
root      176768  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:222-xfs-conv/vdc1]
root      176769  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:223-xfs-conv/vdc1]
root      176770  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:224-xfs-conv/vdc1]
root      176771  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:225-xfs-conv/vdc1]
root      176772  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:226-xfs-conv/vdc1]
root      176773  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:227-xfs-conv/vdc1]
root      176774  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:228-xfs-conv/vdc1]
root      176775  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:229-xfs-conv/vdc1]
root      176776  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:230-xfs-conv/vdc1]
root      176777  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:231-xfs-conv/vdc1]
root      176778  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:232-xfs-conv/vdc1]
root      176779  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:233-xfs-conv/vdc1]
root      176780  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:234-xfs-conv/vdc1]
root      176781  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:235-xfs-conv/vdc1]
root      176782  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:236-xfs-conv/vdc1]
root      176783  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:237-xfs-conv/vdc1]
root      176784  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:238-xfs-conv/vdc1]
root      176785  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:239-xfs-conv/vdc1]
root      176786  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:240-xfs-conv/vdc1]
root      176787  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:241-xfs-conv/vdc1]
root      176788  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:242-xfs-conv/vdc1]
root      176789  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:243-xfs-conv/vdc1]
root      176790  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:244-xfs-conv/vdc1]
root      176791  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:245-xfs-conv/vdc1]
root      176792  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:246-xfs-conv/vdc1]
root      176793  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:247-xfs-conv/vdc1]
root      176794  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:248-xfs-conv/vdc1]
root      176795  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:249-xfs-conv/vdc1]
root      176796  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:250-xfs-conv/vdc1]
root      176797  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:251-xfs-conv/vdc1]
root      176798  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:252-xfs-conv/vdc1]
root      176799  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:253-xfs-conv/vdc1]
root      176800  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:254-xfs-conv/vdc1]
root      176801  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:255-xfs-conv/vdc1]
root      176802  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:256-xfs-buf/vda1]
root      176803  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:257-xfs-conv/vdc1]
root      176804  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:7-events_unbound]
root      176813  0.0  0.0      0     0 ?        I<   10:44   0:00  \_ [kworker/0:2H-kblockd]
root      176814  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/u4:8-events_unbound]
root      176815  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/0:258]
root           1  0.0  0.3  21852 13056 ?        Ss   Oct08   0:19 /run/current-system/systemd/lib/systemd/systemd
root         399  0.0  1.8 139764 75096 ?        Ss   Oct08   0:13 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-journald
root         455  0.0  0.2  33848  8168 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-udevd
systemd+     811  0.0  0.1  16800  6660 ?        Ss   Oct08   0:10 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-oomd
systemd+     816  0.0  0.1  91380  7952 ?        Ssl  Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-timesyncd
root         837  0.0  0.0  80596  3288 ?        Ssl  Oct08   1:37 /nix/store/ag3xk1l8ij06vx434abk8643f8p7i08c-qemu-host-cpu-only-8.2.6-ga/bin/qemu-ga --statedir /run/qemu-ga
root         840  0.0  0.0 226896  1984 ?        Ss   Oct08   0:00 /nix/store/k34f0d079arcgfjsq78gpkdbd6l6nnq4-cron-4.1/bin/cron -n
message+     850  0.0  0.1  13776  6080 ?        Ss   Oct08   0:05 /nix/store/0hm8vh65m378439kl16xv0p6l7c51asj-dbus-1.14.10/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         876  0.0  0.1  17468  7968 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-logind
nscd        1074  0.0  0.1 555748  6016 ?        Ssl  Oct08   0:28 /nix/store/zza9hvd6iawqdcxvinf4yxv580av3s9f-nsncd-unstable-2024-01-16/bin/nsncd
telegraf    1092  0.3  3.4 6344672 138484 ?      S<Lsl Oct08  13:05 /nix/store/8bnbkyh26j97l0pw02gb7lngh4n6k3r5-telegraf-1.30.3/bin/telegraf -config /nix/store/nh4k7bx1asm0kn1klhbmg52wk1qdcwpw-config.toml -config-directory /nix/store/dj77wnb5j
root        1093  0.0  1.5 1109328 60864 ?       Ssl  Oct08   2:24 /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/fn9jcsr2kp2kq3m2qd6qrkv6xh7jcj5g-fail2ban-1.0.2/bin/.fail2ban-server-wrapped -xf start
sensucl+    1094  0.0  0.9 898112 38340 ?        Ssl  Oct08   1:41 /nix/store/qqc6v89xn0g2w123wx85blkpc4pz2ags-ruby-2.7.8/bin/ruby /nix/store/dpvf0jdq1mbrdc90aapyrn2wvjbpckyv-sensu-check-env/bin/sensu-client -L warn -c /nix/store/ly677hg5b7szz
root        1098  0.0  0.1  11564  7568 ?        Ss   Oct08   0:00 sshd: /nix/store/1m888byzaqaig6azrrfpmjdyhgfliaga-openssh-9.7p1/bin/sshd -D -f /etc/ssh/sshd_config [listener] 0 of 10-100 startups
root      176967  0.0  0.2  14380  9840 ?        Ss   10:47   0:00  \_ sshd: ctheune [priv]
ctheune   176988  0.2  0.1  14540  5856 ?        S    10:47   0:00      \_ sshd: ctheune@pts/0
ctheune   176992  0.0  0.1 230756  5968 pts/0    Ss   10:47   0:00          \_ -bash
root      176998  0.0  0.0 228796  3956 pts/0    S+   10:47   0:00              \_ sudo -i
root      177001  0.0  0.0 228796  1604 pts/1    Ss   10:47   0:00                  \_ sudo -i
root      177002  0.0  0.1 230892  6064 pts/1    S    10:47   0:00                      \_ -bash
root      177048  0.0  0.0 232344  3944 pts/1    R+   10:48   0:00                          \_ ps auxf
root        1101  0.0  0.0 226928  1944 tty1     Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login --noclear --keep-baud tty1 115200,38400,9600 linux
root        1102  0.0  0.0 226928  2192 ttyS0    Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login ttyS0 --keep-baud vt220
_du4651+    1105  0.0  2.2 2505204 90824 ?       Ssl  Oct08   1:15 /nix/store/ff5j2is3di7praysyv232wfvcq7hvkii-filebeat-oss-7.17.16/bin/filebeat -e -c /nix/store/xlb56lv0f3j03l3v34x5jfvq8wng18ww-filebeat-journal-services19.gocept.net.json -pat
mysql       2809  0.3 18.6 4784932 750856 ?      Ssl  Oct08  11:47 /nix/store/9iq211dy95nqn484nx5z5mv3c7pc2h27-percona-server_lts-8.0.36-28/bin/mysqld --defaults-extra-file=/nix/store/frvxmffp9fpgq06bx89rgczyn6k6i51y-my.cnf --user=mysql --data
root      176527  0.0  0.0 227904  3236 ?        SNs  10:43   0:00 /nix/store/516kai7nl5dxr792c0nzq0jp8m4zvxpi-bash-5.2p32/bin/bash /nix/store/s8g5ls9d611hjq5psyd15sqbpqgrlwck-unit-script-fc-agent-start/bin/fc-agent-start
root      176535  0.1  1.1 279068 46452 ?        SN   10:43   0:00  \_ /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/gavi1rlv3ja79vl5hg3lgh07absa8yb9-python3.11-fc-agent-1.0/bin/.fc-manage-wrapped --enc-p
root      176536  3.5  1.8 635400 72368 ?        DNl  10:43   0:09      \_ nix-build --no-build-output <nixpkgs/nixos> -A system -I https://hydra.flyingcircus.io/build/496886/download/1/nixexprs.tar.xz --out-link /run/fc-agent-built-system
ctheune   176972  0.1  0.2  20028 11856 ?        Ss   10:47   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd --user
ctheune   176974  0.0  0.0  20368  3004 ?        S    10:47   0:00  \_ (sd-pam)

[218314.012140606]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           2  0.0  0.0      0     0 ?        S    Oct08   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-slub_flushwq]
root           7  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/0:0H-kblockd]
root          13  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mm_percpu_wq]
root          14  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_kthread]
root          15  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_rude_kthread]
root          16  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_trace_kthread]
root          17  0.0  0.0      0     0 ?        S    Oct08   0:25  \_ [ksoftirqd/0]
root          18  0.0  0.0      0     0 ?        I    Oct08   1:12  \_ [rcu_preempt]
root          19  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_par_gp_kthread_worker/0]
root          20  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_gp_kthread_worker]
root          21  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [migration/0]
root          22  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [idle_inject/0]
root          23  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [cpuhp/0]
root          24  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kdevtmpfs]
root          25  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-inet_frag_wq]
root          26  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kauditd]
root          27  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [khungtaskd]
root          28  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [oom_reaper]
root          29  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-writeback]
root          30  0.0  0.0      0     0 ?        S    Oct08   0:02  \_ [kcompactd0]
root          31  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [ksmd]
root          32  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [khugepaged]
root          33  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kintegrityd]
root          34  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kblockd]
root          35  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-blkcg_punt_bio]
root          36  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [irq/9-acpi]
root          37  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md]
root          38  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md_bitmap]
root          39  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-devfreq_wq]
root          44  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kswapd0]
root          45  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kthrotld]
root          46  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mld]
root          47  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ipv6_addrconf]
root          54  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kstrp]
root          55  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/u5:0]
root         102  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [hwrng]
root         109  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [watchdogd]
root         149  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ata_sff]
root         150  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_0]
root         151  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_0]
root         152  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_1]
root         153  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_1]
root         184  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfsalloc]
root         185  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs_mru_cache]
root         186  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vda1]
root         187  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vda1]
root         188  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vda1]
root         189  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vda1]
root         190  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vda1]
root         191  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vda1]
root         192  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vda1]
root         193  0.0  0.0      0     0 ?        S    Oct08   0:20  \_ [xfsaild/vda1]
root         531  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root         644  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vdc1]
root         645  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vdc1]
root         646  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vdc1]
root         647  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vdc1]
root         648  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vdc1]
root         649  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vdc1]
root         650  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vdc1]
root         651  0.0  0.0      0     0 ?        S    Oct08   0:05  \_ [xfsaild/vdc1]
root         723  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ttm]
root        1286  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-tls-strp]
root        2772  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root      171717  0.0  0.0      0     0 ?        I    09:03   0:00  \_ [kworker/u4:3-writeback]
root      174477  0.0  0.0      0     0 ?        I    10:01   0:00  \_ [kworker/0:2-xfs-conv/vdc1]
root      174683  0.0  0.0      0     0 ?        I    10:06   0:00  \_ [kworker/u4:2-events_unbound]
root      175378  0.0  0.0      0     0 ?        I    10:20   0:00  \_ [kworker/u4:4-events_power_efficient]
root      176049  0.0  0.0      0     0 ?        I    10:34   0:00  \_ [kworker/0:3-xfs-conv/vdc1]
root      176150  0.0  0.0      0     0 ?        I<   10:35   0:00  \_ [kworker/0:1H-xfs-log/vda1]
root      176358  0.0  0.0      0     0 ?        I    10:40   0:00  \_ [kworker/0:0-xfs-conv/vdc1]
root      176402  0.0  0.0      0     0 ?        I    10:41   0:00  \_ [kworker/u4:0-events_power_efficient]
root      176544  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:1-writeback]
root      176545  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:5-writeback]
root      176546  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:6-events_power_efficient]
root      176549  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:1-xfs-conv/vdc1]
root      176550  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:4-xfs-conv/vdc1]
root      176551  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:5-xfs-conv/vdc1]
root      176552  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:6-xfs-conv/vdc1]
root      176553  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:7-xfs-conv/vdc1]
root      176554  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:8-xfs-conv/vdc1]
root      176555  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:9-xfs-conv/vdc1]
root      176556  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:10-xfs-conv/vdc1]
root      176557  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:11-xfs-conv/vdc1]
root      176558  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:12-kthrotld]
root      176559  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:13-xfs-conv/vdc1]
root      176560  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:14-xfs-conv/vdc1]
root      176561  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:15-xfs-conv/vdc1]
root      176562  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:16-xfs-conv/vdc1]
root      176563  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:17-xfs-conv/vdc1]
root      176564  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:18-xfs-conv/vdc1]
root      176565  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:19-xfs-conv/vdc1]
root      176566  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:20-xfs-conv/vdc1]
root      176567  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:21-xfs-conv/vdc1]
root      176568  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:22-xfs-conv/vdc1]
root      176569  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:23-xfs-conv/vdc1]
root      176570  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:24-xfs-conv/vdc1]
root      176571  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:25-xfs-conv/vdc1]
root      176572  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:26-xfs-conv/vdc1]
root      176573  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:27-xfs-conv/vdc1]
root      176574  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:28-xfs-conv/vdc1]
root      176575  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:29-xfs-conv/vdc1]
root      176576  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:30-xfs-conv/vdc1]
root      176577  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:31-xfs-conv/vdc1]
root      176578  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:32-xfs-conv/vdc1]
root      176579  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:33-xfs-conv/vdc1]
root      176580  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:34-xfs-conv/vdc1]
root      176581  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:35-xfs-conv/vdc1]
root      176582  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:36-xfs-conv/vdc1]
root      176583  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:37-xfs-conv/vdc1]
root      176584  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:38-xfs-conv/vdc1]
root      176585  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:39-xfs-conv/vdc1]
root      176586  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:40-xfs-conv/vdc1]
root      176587  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:41-xfs-buf/vdc1]
root      176588  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:42-xfs-conv/vdc1]
root      176589  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:43-xfs-conv/vdc1]
root      176590  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:44-xfs-conv/vdc1]
root      176591  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:45-xfs-conv/vdc1]
root      176592  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:46-xfs-conv/vdc1]
root      176593  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:47-xfs-conv/vdc1]
root      176594  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:48-xfs-conv/vdc1]
root      176595  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:49-xfs-conv/vdc1]
root      176596  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:50-xfs-conv/vdc1]
root      176597  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:51-xfs-conv/vdc1]
root      176598  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:52-xfs-conv/vdc1]
root      176599  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:53-xfs-conv/vdc1]
root      176600  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:54-xfs-conv/vdc1]
root      176601  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:55-xfs-conv/vdc1]
root      176602  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:56-xfs-conv/vdc1]
root      176603  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:57-xfs-conv/vdc1]
root      176604  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:58-xfs-conv/vdc1]
root      176605  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:59-xfs-conv/vdc1]
root      176606  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:60-xfs-conv/vdc1]
root      176607  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:61-xfs-conv/vdc1]
root      176608  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:62-xfs-conv/vdc1]
root      176609  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:63-xfs-conv/vdc1]
root      176610  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:64-xfs-conv/vdc1]
root      176611  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:65-xfs-conv/vdc1]
root      176612  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:66-xfs-conv/vdc1]
root      176613  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:67-xfs-conv/vdc1]
root      176614  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:68-xfs-conv/vdc1]
root      176615  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:69-xfs-conv/vdc1]
root      176616  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:70-xfs-conv/vdc1]
root      176617  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:71-xfs-conv/vdc1]
root      176618  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:72-xfs-conv/vdc1]
root      176619  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:73-xfs-conv/vdc1]
root      176620  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:74-xfs-conv/vdc1]
root      176621  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:75-xfs-conv/vdc1]
root      176622  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:76-xfs-conv/vdc1]
root      176623  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:77-xfs-conv/vdc1]
root      176624  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:78-xfs-conv/vdc1]
root      176625  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:79-xfs-conv/vdc1]
root      176626  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:80-xfs-conv/vdc1]
root      176627  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:81-xfs-conv/vdc1]
root      176628  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:82-xfs-conv/vdc1]
root      176629  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:83-xfs-conv/vdc1]
root      176630  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:84-xfs-conv/vdc1]
root      176631  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:85-xfs-conv/vdc1]
root      176632  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:86-xfs-conv/vdc1]
root      176633  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:87-xfs-conv/vdc1]
root      176634  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:88-xfs-conv/vdc1]
root      176635  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:89-xfs-conv/vdc1]
root      176636  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:90-xfs-conv/vdc1]
root      176637  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:91-xfs-conv/vdc1]
root      176638  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:92-xfs-conv/vdc1]
root      176639  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:93-xfs-conv/vdc1]
root      176640  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:94-xfs-conv/vdc1]
root      176641  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:95-xfs-conv/vdc1]
root      176642  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:96-xfs-conv/vdc1]
root      176643  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:97-xfs-conv/vdc1]
root      176644  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:98-xfs-conv/vdc1]
root      176645  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:99-xfs-conv/vdc1]
root      176646  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:100-xfs-conv/vdc1]
root      176647  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:101-xfs-conv/vdc1]
root      176648  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:102-xfs-conv/vdc1]
root      176649  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:103-xfs-conv/vdc1]
root      176650  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:104-xfs-conv/vdc1]
root      176651  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:105-xfs-conv/vdc1]
root      176652  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:106-xfs-conv/vdc1]
root      176653  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:107-xfs-conv/vdc1]
root      176654  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:108-xfs-conv/vdc1]
root      176655  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:109-xfs-conv/vdc1]
root      176656  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:110-xfs-conv/vdc1]
root      176657  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:111-xfs-conv/vdc1]
root      176658  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:112-xfs-conv/vdc1]
root      176659  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:113-xfs-conv/vdc1]
root      176660  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:114-xfs-conv/vdc1]
root      176661  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:115-xfs-conv/vdc1]
root      176662  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:116-xfs-conv/vdc1]
root      176663  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:117-xfs-conv/vdc1]
root      176664  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:118-xfs-conv/vdc1]
root      176665  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:119-xfs-conv/vdc1]
root      176666  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:120-xfs-conv/vdc1]
root      176667  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:121-xfs-conv/vdc1]
root      176668  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:122-xfs-conv/vdc1]
root      176669  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:123-xfs-conv/vdc1]
root      176670  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:124-xfs-conv/vdc1]
root      176671  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:125-xfs-conv/vdc1]
root      176672  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:126-xfs-conv/vdc1]
root      176673  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:127-xfs-conv/vdc1]
root      176674  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:128-xfs-conv/vdc1]
root      176675  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:129-xfs-conv/vdc1]
root      176676  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:130-xfs-conv/vdc1]
root      176677  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:131-xfs-conv/vdc1]
root      176678  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:132-xfs-conv/vdc1]
root      176679  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:133-xfs-conv/vdc1]
root      176680  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:134-xfs-conv/vdc1]
root      176681  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:135-xfs-conv/vdc1]
root      176682  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:136-xfs-conv/vdc1]
root      176683  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:137-xfs-conv/vdc1]
root      176684  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:138-xfs-conv/vdc1]
root      176685  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:139-xfs-conv/vdc1]
root      176686  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:140-xfs-conv/vdc1]
root      176687  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:141-xfs-conv/vdc1]
root      176688  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:142-xfs-conv/vdc1]
root      176689  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:143-xfs-conv/vdc1]
root      176690  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:144-xfs-conv/vdc1]
root      176691  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:145-xfs-conv/vdc1]
root      176692  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:146-xfs-conv/vdc1]
root      176693  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:147-xfs-conv/vdc1]
root      176694  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:148-xfs-conv/vdc1]
root      176695  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:149-xfs-conv/vdc1]
root      176696  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:150-xfs-conv/vdc1]
root      176697  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:151-xfs-conv/vdc1]
root      176698  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:152-xfs-conv/vdc1]
root      176699  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:153-xfs-conv/vdc1]
root      176700  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:154-xfs-conv/vdc1]
root      176701  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:155-xfs-conv/vdc1]
root      176702  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:156-xfs-conv/vdc1]
root      176703  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:157-xfs-conv/vdc1]
root      176704  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:158-xfs-buf/vda1]
root      176705  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:159-xfs-conv/vdc1]
root      176706  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:160-xfs-conv/vdc1]
root      176707  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:161-xfs-conv/vdc1]
root      176708  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:162-xfs-conv/vdc1]
root      176709  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:163-xfs-conv/vdc1]
root      176710  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:164-xfs-conv/vdc1]
root      176711  0.2  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:165-xfs-conv/vda1]
root      176712  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:166-xfs-conv/vdc1]
root      176713  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:167-xfs-conv/vdc1]
root      176714  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:168-xfs-conv/vdc1]
root      176715  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:169-xfs-conv/vdc1]
root      176716  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:170-xfs-conv/vdc1]
root      176717  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:171-xfs-conv/vdc1]
root      176718  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:172-xfs-conv/vdc1]
root      176719  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:173-xfs-conv/vdc1]
root      176720  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:174-xfs-conv/vdc1]
root      176721  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:175-xfs-conv/vdc1]
root      176722  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:176-xfs-conv/vdc1]
root      176723  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:177-xfs-conv/vdc1]
root      176724  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:178-xfs-conv/vdc1]
root      176725  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:179-xfs-conv/vdc1]
root      176726  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:180-xfs-conv/vdc1]
root      176727  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:181-xfs-conv/vdc1]
root      176728  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:182-xfs-conv/vdc1]
root      176729  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:183-xfs-conv/vdc1]
root      176730  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:184-xfs-conv/vdc1]
root      176731  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:185-xfs-conv/vdc1]
root      176732  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:186-xfs-conv/vdc1]
root      176733  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:187-xfs-conv/vdc1]
root      176734  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:188-xfs-conv/vdc1]
root      176735  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:189-xfs-conv/vdc1]
root      176736  0.3  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:190-cgroup_destroy]
root      176737  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:191-xfs-conv/vdc1]
root      176738  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:192-xfs-conv/vdc1]
root      176739  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:193-xfs-conv/vdc1]
root      176740  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:194-xfs-conv/vdc1]
root      176741  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:195-xfs-conv/vdc1]
root      176742  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:196-xfs-conv/vdc1]
root      176743  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:197-xfs-conv/vdc1]
root      176744  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:198-xfs-conv/vdc1]
root      176745  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:199-xfs-conv/vdc1]
root      176746  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:200-xfs-conv/vdc1]
root      176747  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:201-xfs-conv/vdc1]
root      176748  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:202-xfs-conv/vdc1]
root      176749  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:203-xfs-conv/vdc1]
root      176750  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:204-xfs-conv/vdc1]
root      176751  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:205-xfs-conv/vdc1]
root      176752  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:206-xfs-buf/vda1]
root      176753  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:207-xfs-conv/vdc1]
root      176754  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:208-xfs-conv/vdc1]
root      176755  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:209-xfs-conv/vdc1]
root      176756  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:210-xfs-conv/vdc1]
root      176757  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:211-xfs-conv/vdc1]
root      176758  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:212-xfs-conv/vdc1]
root      176759  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:213-xfs-conv/vdc1]
root      176760  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:214-xfs-conv/vdc1]
root      176761  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:215-xfs-conv/vdc1]
root      176762  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:216-xfs-conv/vdc1]
root      176763  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:217-xfs-conv/vdc1]
root      176764  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:218-xfs-conv/vdc1]
root      176765  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:219-xfs-conv/vdc1]
root      176766  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:220-xfs-conv/vdc1]
root      176767  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:221-xfs-conv/vdc1]
root      176768  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:222-xfs-conv/vdc1]
root      176769  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:223-xfs-conv/vdc1]
root      176770  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:224-xfs-conv/vdc1]
root      176771  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:225-xfs-conv/vdc1]
root      176772  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:226-xfs-conv/vdc1]
root      176773  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:227-xfs-conv/vdc1]
root      176774  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:228-xfs-conv/vdc1]
root      176775  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:229-xfs-conv/vdc1]
root      176776  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:230-xfs-conv/vdc1]
root      176777  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:231-xfs-conv/vdc1]
root      176778  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:232-xfs-conv/vdc1]
root      176779  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:233-xfs-conv/vdc1]
root      176780  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:234-xfs-conv/vdc1]
root      176781  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:235-xfs-conv/vdc1]
root      176782  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:236-xfs-conv/vdc1]
root      176783  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:237-xfs-conv/vdc1]
root      176784  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:238-xfs-conv/vdc1]
root      176785  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:239-xfs-conv/vdc1]
root      176786  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:240-xfs-conv/vdc1]
root      176787  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:241-xfs-conv/vdc1]
root      176788  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:242-xfs-conv/vdc1]
root      176789  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:243-xfs-conv/vdc1]
root      176790  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:244-xfs-conv/vdc1]
root      176791  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:245-xfs-conv/vdc1]
root      176792  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:246-xfs-conv/vdc1]
root      176793  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:247-xfs-conv/vdc1]
root      176794  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:248-xfs-conv/vdc1]
root      176795  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:249-xfs-conv/vdc1]
root      176796  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:250-xfs-conv/vdc1]
root      176797  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:251-xfs-conv/vdc1]
root      176798  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:252-xfs-conv/vdc1]
root      176799  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:253-xfs-conv/vdc1]
root      176800  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:254-xfs-conv/vdc1]
root      176801  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:255-xfs-conv/vdc1]
root      176802  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:256-xfs-buf/vda1]
root      176803  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:257-xfs-conv/vdc1]
root      176804  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:7-events_unbound]
root      176813  0.0  0.0      0     0 ?        I<   10:44   0:00  \_ [kworker/0:2H-kblockd]
root      176814  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/u4:8-events_unbound]
root      176815  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/0:258]
root           1  0.0  0.3  21852 13056 ?        Ss   Oct08   0:19 /run/current-system/systemd/lib/systemd/systemd
root         399  0.0  1.8 139764 75096 ?        Ss   Oct08   0:13 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-journald
root         455  0.0  0.2  33848  8168 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-udevd
systemd+     811  0.0  0.1  16800  6660 ?        Ss   Oct08   0:10 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-oomd
systemd+     816  0.0  0.1  91380  7952 ?        Ssl  Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-timesyncd
root         837  0.0  0.0  80596  3288 ?        Ssl  Oct08   1:37 /nix/store/ag3xk1l8ij06vx434abk8643f8p7i08c-qemu-host-cpu-only-8.2.6-ga/bin/qemu-ga --statedir /run/qemu-ga
root         840  0.0  0.0 226896  1984 ?        Ss   Oct08   0:00 /nix/store/k34f0d079arcgfjsq78gpkdbd6l6nnq4-cron-4.1/bin/cron -n
message+     850  0.0  0.1  13776  6080 ?        Ss   Oct08   0:05 /nix/store/0hm8vh65m378439kl16xv0p6l7c51asj-dbus-1.14.10/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         876  0.0  0.1  17468  7968 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-logind
nscd        1074  0.0  0.1 555748  6016 ?        Ssl  Oct08   0:28 /nix/store/zza9hvd6iawqdcxvinf4yxv580av3s9f-nsncd-unstable-2024-01-16/bin/nsncd
telegraf    1092  0.3  3.4 6344672 138484 ?      S<Lsl Oct08  13:05 /nix/store/8bnbkyh26j97l0pw02gb7lngh4n6k3r5-telegraf-1.30.3/bin/telegraf -config /nix/store/nh4k7bx1asm0kn1klhbmg52wk1qdcwpw-config.toml -config-directory /nix/store/dj77wnb5j
root        1093  0.0  1.5 1109328 60864 ?       Ssl  Oct08   2:24 /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/fn9jcsr2kp2kq3m2qd6qrkv6xh7jcj5g-fail2ban-1.0.2/bin/.fail2ban-server-wrapped -xf start
sensucl+    1094  0.0  0.9 898112 38340 ?        Ssl  Oct08   1:41 /nix/store/qqc6v89xn0g2w123wx85blkpc4pz2ags-ruby-2.7.8/bin/ruby /nix/store/dpvf0jdq1mbrdc90aapyrn2wvjbpckyv-sensu-check-env/bin/sensu-client -L warn -c /nix/store/ly677hg5b7szz
root        1098  0.0  0.1  11564  7568 ?        Ss   Oct08   0:00 sshd: /nix/store/1m888byzaqaig6azrrfpmjdyhgfliaga-openssh-9.7p1/bin/sshd -D -f /etc/ssh/sshd_config [listener] 0 of 10-100 startups
root      176967  0.0  0.2  14380  9840 ?        Ss   10:47   0:00  \_ sshd: ctheune [priv]
ctheune   176988  0.2  0.1  14540  5856 ?        S    10:47   0:00      \_ sshd: ctheune@pts/0
ctheune   176992  0.0  0.1 230756  5968 pts/0    Ss   10:47   0:00          \_ -bash
root      176998  0.0  0.0 228796  3956 pts/0    S+   10:47   0:00              \_ sudo -i
root      177001  0.0  0.0 228796  1604 pts/1    Ss   10:47   0:00                  \_ sudo -i
root      177002  0.0  0.1 230892  6064 pts/1    S    10:47   0:00                      \_ -bash
root      177061  0.0  0.1 232344  4048 pts/1    R+   10:48   0:00                          \_ ps auxf
root        1101  0.0  0.0 226928  1944 tty1     Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login --noclear --keep-baud tty1 115200,38400,9600 linux
root        1102  0.0  0.0 226928  2192 ttyS0    Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login ttyS0 --keep-baud vt220
_du4651+    1105  0.0  2.2 2505204 90824 ?       Ssl  Oct08   1:15 /nix/store/ff5j2is3di7praysyv232wfvcq7hvkii-filebeat-oss-7.17.16/bin/filebeat -e -c /nix/store/xlb56lv0f3j03l3v34x5jfvq8wng18ww-filebeat-journal-services19.gocept.net.json -pat
mysql       2809  0.3 18.6 4784932 750856 ?      Ssl  Oct08  11:47 /nix/store/9iq211dy95nqn484nx5z5mv3c7pc2h27-percona-server_lts-8.0.36-28/bin/mysqld --defaults-extra-file=/nix/store/frvxmffp9fpgq06bx89rgczyn6k6i51y-my.cnf --user=mysql --data
root      176527  0.0  0.0 227904  3236 ?        SNs  10:43   0:00 /nix/store/516kai7nl5dxr792c0nzq0jp8m4zvxpi-bash-5.2p32/bin/bash /nix/store/s8g5ls9d611hjq5psyd15sqbpqgrlwck-unit-script-fc-agent-start/bin/fc-agent-start
root      176535  0.1  1.1 279068 46452 ?        SN   10:43   0:00  \_ /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/gavi1rlv3ja79vl5hg3lgh07absa8yb9-python3.11-fc-agent-1.0/bin/.fc-manage-wrapped --enc-p
root      176536  3.3  1.8 635400 72368 ?        DNl  10:43   0:09      \_ nix-build --no-build-output <nixpkgs/nixos> -A system -I https://hydra.flyingcircus.io/build/496886/download/1/nixexprs.tar.xz --out-link /run/fc-agent-built-system
ctheune   176972  0.1  0.2  20028 11856 ?        Ss   10:47   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd --user
ctheune   176974  0.0  0.0  20368  3004 ?        S    10:47   0:00  \_ (sd-pam)

[218321.967537846]
176536 nix-build D
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----
stack summary

1 hit:
[<0>] folio_wait_bit_common+0x13f/0x340
[<0>] folio_wait_writeback+0x2b/0x80
[<0>] __filemap_fdatawait_range+0x80/0xe0
[<0>] filemap_write_and_wait_range+0x85/0xb0
[<0>] xfs_setattr_size+0xd9/0x3c0 [xfs]
[<0>] xfs_vn_setattr+0x81/0x150 [xfs]
[<0>] notify_change+0x2ed/0x4f0
[<0>] do_truncate+0x98/0xf0
[<0>] do_ftruncate+0xfe/0x160
[<0>] __x64_sys_ftruncate+0x3e/0x70
[<0>] do_syscall_64+0xb7/0x200
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

-----

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           2  0.0  0.0      0     0 ?        S    Oct08   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-slub_flushwq]
root           7  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/0:0H-kblockd]
root          13  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mm_percpu_wq]
root          14  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_kthread]
root          15  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_rude_kthread]
root          16  0.0  0.0      0     0 ?        I    Oct08   0:00  \_ [rcu_tasks_trace_kthread]
root          17  0.0  0.0      0     0 ?        S    Oct08   0:25  \_ [ksoftirqd/0]
root          18  0.0  0.0      0     0 ?        I    Oct08   1:12  \_ [rcu_preempt]
root          19  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_par_gp_kthread_worker/0]
root          20  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [rcu_exp_gp_kthread_worker]
root          21  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [migration/0]
root          22  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [idle_inject/0]
root          23  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [cpuhp/0]
root          24  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kdevtmpfs]
root          25  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-inet_frag_wq]
root          26  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kauditd]
root          27  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [khungtaskd]
root          28  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [oom_reaper]
root          29  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-writeback]
root          30  0.0  0.0      0     0 ?        S    Oct08   0:02  \_ [kcompactd0]
root          31  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [ksmd]
root          32  0.0  0.0      0     0 ?        SN   Oct08   0:00  \_ [khugepaged]
root          33  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kintegrityd]
root          34  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kblockd]
root          35  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-blkcg_punt_bio]
root          36  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [irq/9-acpi]
root          37  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md]
root          38  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-md_bitmap]
root          39  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-devfreq_wq]
root          44  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [kswapd0]
root          45  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kthrotld]
root          46  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-mld]
root          47  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ipv6_addrconf]
root          54  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-kstrp]
root          55  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/u5:0]
root         102  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [hwrng]
root         109  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [watchdogd]
root         149  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ata_sff]
root         150  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_0]
root         151  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_0]
root         152  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [scsi_eh_1]
root         153  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-scsi_tmf_1]
root         184  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfsalloc]
root         185  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs_mru_cache]
root         186  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vda1]
root         187  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vda1]
root         188  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vda1]
root         189  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vda1]
root         190  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vda1]
root         191  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vda1]
root         192  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vda1]
root         193  0.0  0.0      0     0 ?        S    Oct08   0:20  \_ [xfsaild/vda1]
root         531  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root         644  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-buf/vdc1]
root         645  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-conv/vdc1]
root         646  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-reclaim/vdc1]
root         647  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-blockgc/vdc1]
root         648  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-inodegc/vdc1]
root         649  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-log/vdc1]
root         650  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-xfs-cil/vdc1]
root         651  0.0  0.0      0     0 ?        S    Oct08   0:05  \_ [xfsaild/vdc1]
root         723  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-ttm]
root        1286  0.0  0.0      0     0 ?        I<   Oct08   0:00  \_ [kworker/R-tls-strp]
root        2772  0.0  0.0      0     0 ?        S    Oct08   0:00  \_ [psimon]
root      171717  0.0  0.0      0     0 ?        I    09:03   0:00  \_ [kworker/u4:3-events_power_efficient]
root      174477  0.0  0.0      0     0 ?        I    10:01   0:00  \_ [kworker/0:2-xfs-conv/vdc1]
root      174683  0.0  0.0      0     0 ?        I    10:06   0:00  \_ [kworker/u4:2-writeback]
root      175378  0.0  0.0      0     0 ?        I    10:20   0:00  \_ [kworker/u4:4-events_unbound]
root      176049  0.0  0.0      0     0 ?        I    10:34   0:00  \_ [kworker/0:3-xfs-conv/vdc1]
root      176150  0.0  0.0      0     0 ?        I<   10:35   0:00  \_ [kworker/0:1H-xfs-log/vda1]
root      176358  0.0  0.0      0     0 ?        I    10:40   0:00  \_ [kworker/0:0-xfs-conv/vdc1]
root      176402  0.0  0.0      0     0 ?        I    10:41   0:00  \_ [kworker/u4:0-events_power_efficient]
root      176544  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:1-writeback]
root      176545  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:5-writeback]
root      176546  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:6-events_power_efficient]
root      176549  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:1-xfs-conv/vdc1]
root      176550  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:4-xfs-conv/vdc1]
root      176551  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:5-xfs-conv/vdc1]
root      176552  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:6-xfs-conv/vdc1]
root      176553  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:7-xfs-conv/vdc1]
root      176554  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:8-xfs-conv/vdc1]
root      176555  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:9-xfs-conv/vdc1]
root      176556  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:10-xfs-conv/vdc1]
root      176557  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:11-xfs-conv/vdc1]
root      176558  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:12-kthrotld]
root      176559  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:13-xfs-conv/vdc1]
root      176560  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:14-xfs-conv/vdc1]
root      176561  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:15-xfs-conv/vdc1]
root      176562  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:16-xfs-conv/vdc1]
root      176563  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:17-xfs-conv/vdc1]
root      176564  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:18-xfs-conv/vdc1]
root      176565  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:19-xfs-conv/vdc1]
root      176566  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:20-xfs-conv/vdc1]
root      176567  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:21-xfs-conv/vdc1]
root      176568  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:22-xfs-conv/vdc1]
root      176569  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:23-xfs-conv/vdc1]
root      176570  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:24-xfs-conv/vdc1]
root      176571  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:25-xfs-conv/vdc1]
root      176572  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:26-xfs-conv/vdc1]
root      176573  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:27-xfs-conv/vdc1]
root      176574  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:28-xfs-conv/vdc1]
root      176575  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:29-xfs-conv/vdc1]
root      176576  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:30-xfs-conv/vdc1]
root      176577  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:31-xfs-conv/vdc1]
root      176578  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:32-xfs-conv/vdc1]
root      176579  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:33-xfs-conv/vdc1]
root      176580  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:34-xfs-conv/vdc1]
root      176581  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:35-xfs-conv/vdc1]
root      176582  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:36-xfs-conv/vdc1]
root      176583  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:37-xfs-conv/vdc1]
root      176584  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:38-xfs-conv/vdc1]
root      176585  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:39-xfs-conv/vdc1]
root      176586  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:40-xfs-conv/vdc1]
root      176587  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:41-xfs-buf/vdc1]
root      176588  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:42-xfs-conv/vdc1]
root      176589  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:43-xfs-conv/vdc1]
root      176590  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:44-xfs-conv/vdc1]
root      176591  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:45-xfs-conv/vdc1]
root      176592  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:46-xfs-conv/vdc1]
root      176593  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:47-xfs-conv/vdc1]
root      176594  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:48-xfs-conv/vdc1]
root      176595  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:49-xfs-conv/vdc1]
root      176596  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:50-xfs-conv/vdc1]
root      176597  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:51-xfs-conv/vdc1]
root      176598  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:52-xfs-conv/vdc1]
root      176599  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:53-xfs-conv/vdc1]
root      176600  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:54-xfs-conv/vdc1]
root      176601  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:55-xfs-conv/vdc1]
root      176602  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:56-xfs-conv/vdc1]
root      176603  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:57-xfs-conv/vdc1]
root      176604  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:58-xfs-conv/vdc1]
root      176605  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:59-xfs-conv/vdc1]
root      176606  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:60-xfs-conv/vdc1]
root      176607  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:61-xfs-conv/vdc1]
root      176608  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:62-xfs-conv/vdc1]
root      176609  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:63-xfs-conv/vdc1]
root      176610  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:64-xfs-conv/vdc1]
root      176611  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:65-xfs-conv/vdc1]
root      176612  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:66-xfs-conv/vdc1]
root      176613  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:67-xfs-conv/vdc1]
root      176614  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:68-xfs-conv/vdc1]
root      176615  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:69-xfs-conv/vdc1]
root      176616  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:70-xfs-conv/vdc1]
root      176617  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:71-xfs-conv/vdc1]
root      176618  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:72-xfs-conv/vdc1]
root      176619  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:73-xfs-conv/vdc1]
root      176620  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:74-xfs-conv/vdc1]
root      176621  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:75-xfs-conv/vdc1]
root      176622  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:76-xfs-conv/vdc1]
root      176623  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:77-xfs-conv/vdc1]
root      176624  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:78-xfs-conv/vdc1]
root      176625  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:79-xfs-conv/vdc1]
root      176626  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:80-xfs-conv/vdc1]
root      176627  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:81-xfs-conv/vdc1]
root      176628  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:82-xfs-conv/vdc1]
root      176629  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:83-xfs-conv/vdc1]
root      176630  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:84-xfs-conv/vdc1]
root      176631  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:85-xfs-conv/vdc1]
root      176632  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:86-xfs-conv/vdc1]
root      176633  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:87-xfs-conv/vdc1]
root      176634  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:88-xfs-conv/vdc1]
root      176635  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:89-xfs-conv/vdc1]
root      176636  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:90-xfs-conv/vdc1]
root      176637  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:91-xfs-conv/vdc1]
root      176638  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:92-xfs-conv/vdc1]
root      176639  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:93-xfs-conv/vdc1]
root      176640  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:94-xfs-conv/vdc1]
root      176641  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:95-xfs-conv/vdc1]
root      176642  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:96-xfs-conv/vdc1]
root      176643  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:97-xfs-conv/vdc1]
root      176644  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:98-xfs-conv/vdc1]
root      176645  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:99-xfs-conv/vdc1]
root      176646  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:100-xfs-conv/vdc1]
root      176647  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:101-xfs-conv/vdc1]
root      176648  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:102-xfs-conv/vdc1]
root      176649  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:103-xfs-conv/vdc1]
root      176650  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:104-xfs-conv/vdc1]
root      176651  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:105-xfs-conv/vdc1]
root      176652  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:106-xfs-conv/vdc1]
root      176653  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:107-xfs-conv/vdc1]
root      176654  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:108-xfs-conv/vdc1]
root      176655  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:109-xfs-conv/vdc1]
root      176656  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:110-xfs-conv/vdc1]
root      176657  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:111-xfs-conv/vdc1]
root      176658  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:112-xfs-conv/vdc1]
root      176659  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:113-xfs-conv/vdc1]
root      176660  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:114-xfs-conv/vdc1]
root      176661  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:115-xfs-conv/vdc1]
root      176662  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:116-xfs-conv/vdc1]
root      176663  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:117-xfs-conv/vdc1]
root      176664  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:118-xfs-conv/vdc1]
root      176665  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:119-xfs-conv/vdc1]
root      176666  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:120-xfs-conv/vdc1]
root      176667  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:121-xfs-conv/vdc1]
root      176668  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:122-xfs-conv/vdc1]
root      176669  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:123-xfs-conv/vdc1]
root      176670  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:124-xfs-conv/vdc1]
root      176671  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:125-xfs-conv/vdc1]
root      176672  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:126-xfs-conv/vdc1]
root      176673  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:127-xfs-conv/vdc1]
root      176674  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:128-xfs-conv/vdc1]
root      176675  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:129-xfs-conv/vdc1]
root      176676  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:130-xfs-conv/vdc1]
root      176677  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:131-xfs-conv/vdc1]
root      176678  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:132-xfs-conv/vdc1]
root      176679  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:133-xfs-conv/vdc1]
root      176680  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:134-xfs-conv/vdc1]
root      176681  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:135-xfs-conv/vdc1]
root      176682  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:136-xfs-conv/vdc1]
root      176683  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:137-xfs-conv/vdc1]
root      176684  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:138-xfs-conv/vdc1]
root      176685  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:139-xfs-conv/vdc1]
root      176686  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:140-xfs-conv/vdc1]
root      176687  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:141-xfs-conv/vdc1]
root      176688  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:142-xfs-conv/vdc1]
root      176689  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:143-xfs-conv/vdc1]
root      176690  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:144-xfs-conv/vdc1]
root      176691  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:145-xfs-conv/vdc1]
root      176692  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:146-xfs-conv/vdc1]
root      176693  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:147-xfs-conv/vdc1]
root      176694  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:148-xfs-conv/vdc1]
root      176695  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:149-xfs-conv/vdc1]
root      176696  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:150-xfs-conv/vdc1]
root      176697  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:151-xfs-conv/vdc1]
root      176698  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:152-xfs-conv/vdc1]
root      176699  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:153-xfs-conv/vdc1]
root      176700  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:154-xfs-conv/vdc1]
root      176701  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:155-xfs-conv/vdc1]
root      176702  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:156-xfs-conv/vdc1]
root      176703  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:157-xfs-conv/vdc1]
root      176704  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:158-xfs-buf/vda1]
root      176705  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:159-xfs-conv/vdc1]
root      176706  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:160-xfs-conv/vdc1]
root      176707  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:161-xfs-conv/vdc1]
root      176708  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:162-xfs-conv/vdc1]
root      176709  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:163-xfs-conv/vdc1]
root      176710  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:164-xfs-conv/vdc1]
root      176711  0.2  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:165-xfs-conv/vda1]
root      176712  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:166-xfs-conv/vdc1]
root      176713  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:167-xfs-conv/vdc1]
root      176714  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:168-xfs-conv/vdc1]
root      176715  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:169-xfs-conv/vdc1]
root      176716  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:170-xfs-conv/vdc1]
root      176717  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:171-xfs-conv/vdc1]
root      176718  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:172-xfs-conv/vdc1]
root      176719  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:173-xfs-conv/vdc1]
root      176720  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:174-xfs-conv/vdc1]
root      176721  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:175-xfs-conv/vdc1]
root      176722  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:176-xfs-conv/vdc1]
root      176723  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:177-xfs-conv/vdc1]
root      176724  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:178-xfs-conv/vdc1]
root      176725  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:179-xfs-conv/vdc1]
root      176726  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:180-xfs-conv/vdc1]
root      176727  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:181-xfs-conv/vdc1]
root      176728  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:182-xfs-conv/vdc1]
root      176729  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:183-xfs-conv/vdc1]
root      176730  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:184-xfs-conv/vdc1]
root      176731  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:185-xfs-conv/vdc1]
root      176732  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:186-xfs-conv/vdc1]
root      176733  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:187-xfs-conv/vdc1]
root      176734  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:188-xfs-conv/vdc1]
root      176735  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:189-xfs-conv/vdc1]
root      176736  0.3  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:190-cgroup_destroy]
root      176737  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:191-xfs-conv/vdc1]
root      176738  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:192-xfs-conv/vdc1]
root      176739  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:193-xfs-conv/vdc1]
root      176740  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:194-xfs-conv/vdc1]
root      176741  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:195-xfs-conv/vdc1]
root      176742  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:196-xfs-conv/vdc1]
root      176743  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:197-xfs-conv/vdc1]
root      176744  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:198-xfs-conv/vdc1]
root      176745  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:199-xfs-conv/vdc1]
root      176746  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:200-xfs-conv/vdc1]
root      176747  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:201-xfs-conv/vdc1]
root      176748  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:202-xfs-conv/vdc1]
root      176749  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:203-xfs-conv/vdc1]
root      176750  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:204-xfs-conv/vdc1]
root      176751  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:205-xfs-conv/vdc1]
root      176752  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:206-xfs-buf/vda1]
root      176753  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:207-xfs-conv/vdc1]
root      176754  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:208-xfs-conv/vdc1]
root      176755  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:209-xfs-conv/vdc1]
root      176756  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:210-xfs-conv/vdc1]
root      176757  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:211-xfs-conv/vdc1]
root      176758  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:212-xfs-conv/vdc1]
root      176759  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:213-xfs-conv/vdc1]
root      176760  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:214-xfs-conv/vdc1]
root      176761  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:215-xfs-conv/vdc1]
root      176762  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:216-xfs-conv/vdc1]
root      176763  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:217-xfs-conv/vdc1]
root      176764  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:218-xfs-conv/vdc1]
root      176765  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:219-xfs-conv/vdc1]
root      176766  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:220-xfs-conv/vdc1]
root      176767  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:221-xfs-conv/vdc1]
root      176768  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:222-xfs-conv/vdc1]
root      176769  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:223-xfs-conv/vdc1]
root      176770  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:224-xfs-conv/vdc1]
root      176771  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:225-xfs-conv/vdc1]
root      176772  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:226-xfs-conv/vdc1]
root      176773  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:227-xfs-conv/vdc1]
root      176774  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:228-xfs-conv/vdc1]
root      176775  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:229-xfs-conv/vdc1]
root      176776  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:230-xfs-conv/vdc1]
root      176777  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:231-xfs-conv/vdc1]
root      176778  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:232-xfs-conv/vdc1]
root      176779  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:233-xfs-conv/vdc1]
root      176780  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:234-xfs-conv/vdc1]
root      176781  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:235-xfs-conv/vdc1]
root      176782  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:236-xfs-conv/vdc1]
root      176783  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:237-xfs-conv/vdc1]
root      176784  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:238-xfs-conv/vdc1]
root      176785  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:239-xfs-conv/vdc1]
root      176786  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:240-xfs-conv/vdc1]
root      176787  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:241-xfs-conv/vdc1]
root      176788  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:242-xfs-conv/vdc1]
root      176789  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:243-xfs-conv/vdc1]
root      176790  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:244-xfs-conv/vdc1]
root      176791  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:245-xfs-conv/vdc1]
root      176792  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:246-xfs-conv/vdc1]
root      176793  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:247-xfs-conv/vdc1]
root      176794  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:248-xfs-conv/vdc1]
root      176795  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:249-xfs-conv/vdc1]
root      176796  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:250-xfs-conv/vdc1]
root      176797  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:251-xfs-conv/vdc1]
root      176798  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:252-xfs-conv/vdc1]
root      176799  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:253-xfs-conv/vdc1]
root      176800  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:254-xfs-conv/vdc1]
root      176801  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:255-xfs-conv/vdc1]
root      176802  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:256-xfs-buf/vda1]
root      176803  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/0:257-xfs-conv/vdc1]
root      176804  0.0  0.0      0     0 ?        I    10:43   0:00  \_ [kworker/u4:7-events_unbound]
root      176813  0.0  0.0      0     0 ?        I<   10:44   0:00  \_ [kworker/0:2H-kblockd]
root      176814  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/u4:8-events_unbound]
root      176815  0.0  0.0      0     0 ?        I    10:44   0:00  \_ [kworker/0:258]
root           1  0.0  0.3  21852 13056 ?        Ss   Oct08   0:19 /run/current-system/systemd/lib/systemd/systemd
root         399  0.0  1.8 139764 75096 ?        Ss   Oct08   0:13 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-journald
root         455  0.0  0.2  33848  8168 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-udevd
systemd+     811  0.0  0.1  16800  6660 ?        Ss   Oct08   0:10 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-oomd
systemd+     816  0.0  0.1  91380  7952 ?        Ssl  Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-timesyncd
root         837  0.0  0.0  80596  3288 ?        Ssl  Oct08   1:37 /nix/store/ag3xk1l8ij06vx434abk8643f8p7i08c-qemu-host-cpu-only-8.2.6-ga/bin/qemu-ga --statedir /run/qemu-ga
root         840  0.0  0.0 226896  1984 ?        Ss   Oct08   0:00 /nix/store/k34f0d079arcgfjsq78gpkdbd6l6nnq4-cron-4.1/bin/cron -n
message+     850  0.0  0.1  13776  6080 ?        Ss   Oct08   0:05 /nix/store/0hm8vh65m378439kl16xv0p6l7c51asj-dbus-1.14.10/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         876  0.0  0.1  17468  7968 ?        Ss   Oct08   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd-logind
nscd        1074  0.0  0.1 555748  6016 ?        Ssl  Oct08   0:28 /nix/store/zza9hvd6iawqdcxvinf4yxv580av3s9f-nsncd-unstable-2024-01-16/bin/nsncd
telegraf    1092  0.3  3.4 6344672 138484 ?      S<Lsl Oct08  13:05 /nix/store/8bnbkyh26j97l0pw02gb7lngh4n6k3r5-telegraf-1.30.3/bin/telegraf -config /nix/store/nh4k7bx1asm0kn1klhbmg52wk1qdcwpw-config.toml -config-directory /nix/store/dj77wnb5j
root        1093  0.0  1.5 1109328 60864 ?       Ssl  Oct08   2:24 /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/fn9jcsr2kp2kq3m2qd6qrkv6xh7jcj5g-fail2ban-1.0.2/bin/.fail2ban-server-wrapped -xf start
sensucl+    1094  0.0  0.9 898112 38340 ?        Ssl  Oct08   1:41 /nix/store/qqc6v89xn0g2w123wx85blkpc4pz2ags-ruby-2.7.8/bin/ruby /nix/store/dpvf0jdq1mbrdc90aapyrn2wvjbpckyv-sensu-check-env/bin/sensu-client -L warn -c /nix/store/ly677hg5b7szz
root        1098  0.0  0.1  11564  7568 ?        Ss   Oct08   0:00 sshd: /nix/store/1m888byzaqaig6azrrfpmjdyhgfliaga-openssh-9.7p1/bin/sshd -D -f /etc/ssh/sshd_config [listener] 0 of 10-100 startups
root      176967  0.0  0.2  14380  9840 ?        Ss   10:47   0:00  \_ sshd: ctheune [priv]
ctheune   176988  0.2  0.1  14540  5856 ?        S    10:47   0:00      \_ sshd: ctheune@pts/0
ctheune   176992  0.0  0.1 230756  5968 pts/0    Ss   10:47   0:00          \_ -bash
root      176998  0.0  0.0 228796  3956 pts/0    S+   10:47   0:00              \_ sudo -i
root      177001  0.0  0.0 228796  1604 pts/1    Ss   10:47   0:00                  \_ sudo -i
root      177002  0.0  0.1 230892  6064 pts/1    S    10:47   0:00                      \_ -bash
root      177075  0.0  0.1 232344  4048 pts/1    R+   10:48   0:00                          \_ ps auxf
root        1101  0.0  0.0 226928  1944 tty1     Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login --noclear --keep-baud tty1 115200,38400,9600 linux
root        1102  0.0  0.0 226928  2192 ttyS0    Ss+  Oct08   0:00 agetty --login-program /nix/store/gwihsgkd13xmk8vwfn2k1nkdi9bys42x-shadow-4.14.6/bin/login ttyS0 --keep-baud vt220
_du4651+    1105  0.0  2.2 2505204 90952 ?       Ssl  Oct08   1:15 /nix/store/ff5j2is3di7praysyv232wfvcq7hvkii-filebeat-oss-7.17.16/bin/filebeat -e -c /nix/store/xlb56lv0f3j03l3v34x5jfvq8wng18ww-filebeat-journal-services19.gocept.net.json -pat
mysql       2809  0.3 18.6 4784932 750856 ?      Ssl  Oct08  11:47 /nix/store/9iq211dy95nqn484nx5z5mv3c7pc2h27-percona-server_lts-8.0.36-28/bin/mysqld --defaults-extra-file=/nix/store/frvxmffp9fpgq06bx89rgczyn6k6i51y-my.cnf --user=mysql --data
root      176527  0.0  0.0 227904  3236 ?        SNs  10:43   0:00 /nix/store/516kai7nl5dxr792c0nzq0jp8m4zvxpi-bash-5.2p32/bin/bash /nix/store/s8g5ls9d611hjq5psyd15sqbpqgrlwck-unit-script-fc-agent-start/bin/fc-agent-start
root      176535  0.0  1.1 279068 46452 ?        SN   10:43   0:00  \_ /nix/store/h723hb9m43lybmvfxkk6n7j4v664qy7b-python3-3.11.9/bin/python3.11 /nix/store/gavi1rlv3ja79vl5hg3lgh07absa8yb9-python3.11-fc-agent-1.0/bin/.fc-manage-wrapped --enc-p
root      176536  3.2  1.8 635400 72368 ?        DNl  10:43   0:09      \_ nix-build --no-build-output <nixpkgs/nixos> -A system -I https://hydra.flyingcircus.io/build/496886/download/1/nixexprs.tar.xz --out-link /run/fc-agent-built-system
ctheune   176972  0.0  0.2  20028 11856 ?        Ss   10:47   0:00 /nix/store/nswmyag3qi9ars0mxw5lp8zm0wv5zxld-systemd-255.9/lib/systemd/systemd --user
ctheune   176974  0.0  0.0  20368  3004 ?        S    10:47   0:00  \_ (sd-pam)


[218342.027043] systemd[1]: fc-agent.service: Deactivated successfully.
[218342.027658] systemd[1]: Finished Flying Circus Management Task.
[218342.028479] systemd[1]: fc-agent.service: Consumed 17.942s CPU time, received 28.8M IP traffic, sent 133.3K IP traffic.

[218331.821045432] (no further output from walker.py)

--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


--Apple-Mail=_9D14FAC2-E546-4354-BB3E-50098A492948--

