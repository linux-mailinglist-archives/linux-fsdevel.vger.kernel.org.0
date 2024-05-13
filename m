Return-Path: <linux-fsdevel+bounces-19363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6AD8C3C24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F241F21498
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B3146A99;
	Mon, 13 May 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDHAiqrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB452F9B;
	Mon, 13 May 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585684; cv=none; b=efvASu9bTUUNyxMn0a1IOLAqNRbLFts41AMET1Gf9KPcwPOjRRy/P7EvVjv69NVwUAQdEGuXVqFx3wVhzuHWRAQMCPTHG+73wyvqUeEDMExkGU01jPH5HfFQ7mkG80tHMYQmgFnOJXK/WMG7it2uXX45CTB4Ql+Ezo82Izjg4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585684; c=relaxed/simple;
	bh=3OaxjRNDhBmNwEefbfrScY6rGQksrM/NHL8MyKFgV4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT+m9DiSqjJw2e8WQJ6oBaphHJarJlSEiXgjVe4qA1oMAdLHjxebHmkdX3QnFZT8F5jW4tO/f17WnNrHjYiFAgSRsp9qiVP+mQ74zY+TDypLk4BJt3/8eoQwxXMvQ/WvN6uBOEMPNLmNCJUR6hqOpGb9UF+teOg+3F4Xvxz35Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDHAiqrS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so46503071fa.3;
        Mon, 13 May 2024 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585681; x=1716190481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgFCQ+7zKAXKsPhKwdGa6MyRTaEdQOnbAl2N/NHodVg=;
        b=IDHAiqrSQlQHiBqSNPxoOxj1ME7r3WNpEkK7UvEeN9k22lsW/fwqpasBZv6XCoMLWt
         zY3n1PEK5yaPf4M06pCCnVWH/ukwVl3WxPH2Bi96/4PFJgzXiF4QdfUN/vV6S/k6gx4o
         uP0B2iq1mwsy/or9EAG5H/Wk37Nf2rQaBJdWlVdqUz1nDnODvJPDKGcDOmXPbEVaT6Ca
         TpKYc4y87VdgSnrK0jSGNbHwGvxcrrE0uTgUIfeywu9lBdeKs/g7BYJ/lG76etxKCrlk
         YuNzkLFF+BrV1LuygjzpUnEr/qKN8dBkoEGTcQvVyf4QiVUI4FrEd8ZbbsEq33NJWSt2
         X5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585681; x=1716190481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgFCQ+7zKAXKsPhKwdGa6MyRTaEdQOnbAl2N/NHodVg=;
        b=a3s5GDmAMMRSXETadgxG1De+spRdHHn1LTSjl7i0CP7Z7nlyIEFmiqHiHBfuXLIy1y
         qU8eRLcR7znU2EjWF4QxIx+YlQzBAwKTUm6TysSIZ5/iMtOZ8I9MW4iUQwIRmwfuJa68
         oDgVl8C43ktJyTv3U23hB23ofrNViq/9HR6b6QK4BWhBP3lYjKy0xQQ0giQlTBONNzq5
         qtE1K9zPPb0fEYMNAgkTiYBHhoeMAEsKRgs7FZTiKaVItSWsNwe5zGIkIoTvF7yYylwp
         xDl7aECcmbFEkJl2fr7L2g93qLCDrQ4AokHrFj+3P4KkIjU4dAcvfXK2hqm0XIcqrZAq
         ffOA==
X-Forwarded-Encrypted: i=1; AJvYcCU1j4QbGKPS0HfXfdyc66x4Pe+VlqFRdRR9NyzfwmALzkrmoQMw2yKPbBleQoDBLqlRIZ1uheghHmui1S7IZzrSP+uWGAFf+tnxThPSZg==
X-Gm-Message-State: AOJu0YxM7jKgi7YJvWV5E2O2dwrk6fZCCcx58YWt2QSbKxWJASVVYpcA
	7LoKi8+9Gxg53/hGFh1mhYwXOtY1RhXdWffIJ6wdahuYDgeVONXyEhUqS6mYB30X64cptd7s/LG
	B6fxg4qksrjSYecggx8uYlBVCvz418ZVH
X-Google-Smtp-Source: AGHT+IFIqmNudIC91z7Hpg7c68jWXqN1MUNyxRPT2D4Bvldn4wxqsL1sXHmiXUaEA9HtMJ4r1CBbQe/J/2+g/r+f2j0=
X-Received: by 2002:a2e:3101:0:b0:2d8:729f:cf14 with SMTP id
 38308e7fff4ca-2e51ff60149mr49078571fa.27.1715585680533; Mon, 13 May 2024
 00:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mvvRFnzYnOM5T7qP+7H2Jetcv4cePhBPRDkd0ZwOGJfvg@mail.gmail.com>
 <CAH2r5ms-fSEsiusCeiRANZ10J6z1p5QQYzPRXqiDHfaYb-3Wgg@mail.gmail.com>
In-Reply-To: <CAH2r5ms-fSEsiusCeiRANZ10J6z1p5QQYzPRXqiDHfaYb-3Wgg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 13 May 2024 02:34:29 -0500
Message-ID: <CAH2r5msmBQ=5zx=0SggGYg_Hpxc7ZcMPVY9xPY_u4_2pBuZJQQ@mail.gmail.com>
Subject: Re: cifs
To: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The problem with the recent netfs/folio series is easy to repro, and
doesn't show up if I remove the mempools patch:

Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 15 18:03:30 2024 +0000

    cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs

    Add mempools for the allocation of cifs_io_request and cifs_io_subreque=
st
    structs for netfslib to use so that it can guarantee eventual allocatio=
n in
    writeback.

Repro is just to do modprobe and then rmmod

[root@fedora29 xfstests-dev]# modprobe cifs
[root@fedora29 xfstests-dev]# dmesg -c
[  589.547809] Key type cifs.spnego registered
[  589.547857] Key type cifs.idmap registered
[root@fedora29 xfstests-dev]# rmmod cifs
Segmentation fault

[  593.793058] RIP: 0010:free_large_kmalloc+0x78/0xb0
[  593.793063] Code: 74 0a 5d 41 5c 41 5d c3 cc cc cc cc 48 89 ef 5d
41 5c 41 5d e9 99 06 f4 ff 48 c7 c6 50 cf 38 9d 48 89 ef e8 7a f4 f8
ff 0f 0b <0f> 0b 80 3d a6 3d 91 02 00 41 bc 00 f0 ff ff 75 a2 4c 89 ee
48 c7
[  593.793068] RSP: 0018:ff1100011ceafe00 EFLAGS: 00010246
[  593.793074] RAX: 0017ffffc0000000 RBX: 1fe22000239d5fc6 RCX: dffffc00000=
00000
[  593.793078] RDX: ffd4000009265808 RSI: ffffffffc1960140 RDI: ffd40000092=
65800
[  593.793082] RBP: ffd4000009265800 R08: ffffffff9b287a70 R09: 00000000000=
00001
[  593.793086] R10: ffffffff9df472e7 R11: 0000000000000001 R12: ffffffffc19=
5ff60
[  593.793090] R13: ffffffffc1960140 R14: 0000000000000000 R15: 00000000000=
00000
[  593.793093] FS:  00007fd5849cc280(0000) GS:ff110004cb200000(0000)
knlGS:0000000000000000
[  593.793098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  593.793101] CR2: 000055c6c44c7d58 CR3: 000000010da2a004 CR4: 00000000003=
71ef0
[  593.793110] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  593.793114] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  593.793118] Call Trace:
[  593.793121]  <TASK>
[  593.793125]  ? __warn+0xa4/0x220
[  593.793133]  ? free_large_kmalloc+0x78/0xb0
[  593.793140]  ? report_bug+0x1d4/0x1e0
[  593.793151]  ? handle_bug+0x42/0x80
[  593.793158]  ? exc_invalid_op+0x18/0x50
[  593.793164]  ? asm_exc_invalid_op+0x1a/0x20
[  593.793178]  ? rcu_is_watching+0x20/0x50
[  593.793188]  ? free_large_kmalloc+0x78/0xb0
[  593.793197]  exit_cifs+0x89/0x6a0 [cifs]
[  593.793363]  __do_sys_delete_module.constprop.0+0x23f/0x450
[  593.793370]  ? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
[  593.793375]  ? mark_held_locks+0x24/0x90
[  593.793383]  ? __x64_sys_close+0x54/0xa0
[  593.793388]  ? lockdep_hardirqs_on_prepare+0x139/0x200
[  593.793394]  ? kasan_quarantine_put+0x97/0x1f0
[  593.793404]  ? mark_held_locks+0x24/0x90
[  593.793414]  do_syscall_64+0x78/0x180
[  593.793421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  593.793427] RIP: 0033:0x7fd584aecd4b
[  593.793433] Code: 73 01 c3 48 8b 0d 3d 11 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 11 0c 00 f7 d8 64 89
01 48
[  593.793437] RSP: 002b:00007ffe0a36ec18 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  593.793443] RAX: ffffffffffffffda RBX: 000055c6c44bd7a0 RCX: 00007fd584a=
ecd4b
[  593.793447] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055c6c44=
bd808
[  593.793451] RBP: 0000000000000000 R08: 00007ffe0a36db91 R09: 00000000000=
00000
[  593.793454] R10: 00007fd584b5eae0 R11: 0000000000000206 R12: 00007ffe0a3=
6ee40
[  593.793458] R13: 00007ffe0a3706d1 R14: 000055c6c44bd260 R15: 000055c6c44=
bd7a0
[  593.793474]  </TASK>
[  593.793477] irq event stamp: 12729
[  593.793480] hardirqs last  enabled at (12735): [<ffffffff9b25d2eb>]
console_unlock+0x15b/0x170
[  593.793487] hardirqs last disabled at (12740): [<ffffffff9b25d2d0>]
console_unlock+0x140/0x170
[  593.793492] softirqs last  enabled at (11910): [<ffffffff9b16499e>]
__irq_exit_rcu+0xfe/0x120
[  593.793498] softirqs last disabled at (11901): [<ffffffff9b16499e>]
__irq_exit_rcu+0xfe/0x120
[  593.793503] ---[ end trace 0000000000000000 ]---
[  593.793546] object pointer: 0x00000000da6e868b
[  593.793550] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  593.793553] BUG: KASAN: invalid-free in exit_cifs+0x89/0x6a0 [cifs]
[  593.793698] Free of addr ffffffffc1960140 by task rmmod/1306

[  593.793703] CPU: 4 PID: 1306 Comm: rmmod Tainted: G        W
  6.9.0 #1
[  593.793707] Hardware name: Red Hat KVM, BIOS 1.16.1-1.el9 04/01/2014
[  593.793709] Call Trace:
[  593.793711]  <TASK>
[  593.793714]  dump_stack_lvl+0x79/0xb0
[  593.793718]  print_report+0xcb/0x620
[  593.793724]  ? exit_cifs+0x89/0x6a0 [cifs]
[  593.793861]  ? exit_cifs+0x89/0x6a0 [cifs]
[  593.794002]  kasan_report_invalid_free+0x9a/0xc0
[  593.794008]  ? exit_cifs+0x89/0x6a0 [cifs]
[  593.794173]  free_large_kmalloc+0x38/0xb0
[  593.794178]  exit_cifs+0x89/0x6a0 [cifs]
[  593.794327]  __do_sys_delete_module.constprop.0+0x23f/0x450
[  593.794331]  ? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
[  593.794335]  ? mark_held_locks+0x24/0x90
[  593.794339]  ? __x64_sys_close+0x54/0xa0
[  593.794342]  ? lockdep_hardirqs_on_prepare+0x139/0x200
[  593.794347]  ? kasan_quarantine_put+0x97/0x1f0
[  593.794352]  ? mark_held_locks+0x24/0x90
[  593.794357]  do_syscall_64+0x78/0x180
[  593.794361]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  593.794367] RIP: 0033:0x7fd584aecd4b
[  593.794370] Code: 73 01 c3 48 8b 0d 3d 11 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 11 0c 00 f7 d8 64 89
01 48
[  593.794373] RSP: 002b:00007ffe0a36ec18 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  593.794377] RAX: ffffffffffffffda RBX: 000055c6c44bd7a0 RCX: 00007fd584a=
ecd4b
[  593.794380] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055c6c44=
bd808
[  593.794382] RBP: 0000000000000000 R08: 00007ffe0a36db91 R09: 00000000000=
00000
[  593.794385] R10: 00007fd584b5eae0 R11: 0000000000000206 R12: 00007ffe0a3=
6ee40
[  593.794387] R13: 00007ffe0a3706d1 R14: 000055c6c44bd260 R15: 000055c6c44=
bd7a0
[  593.794394]  </TASK>

[  593.794398] The buggy address belongs to the variable:
[  593.794399]  cifs_io_subrequest_pool+0x0/0xfffffffffff3dec0 [cifs]

[  593.794557] Memory state around the buggy address:
[  593.794559]  ffffffffc1960000: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
f9 f9 f9 f9
[  593.794562]  ffffffffc1960080: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
f9 f9 f9 f9
[  593.794565] >ffffffffc1960100: 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00
00 00 00 00
[  593.794567]                                            ^
[  593.794570]  ffffffffc1960180: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 f9
[  593.794572]  ffffffffc1960200: f9 f9 f9 f9 00 00 00 00 00 00 00 00
00 00 00 00
[  593.794575] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On Sat, May 11, 2024 at 12:59=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> This was running against linux-next as of about an hour ago
>
> On Sat, May 11, 2024 at 12:53=E2=80=AFPM Steve French <smfrench@gmail.com=
> wrote:
> >
> > Tried running the regression tests against for-next and saw crash
> > early in the test run in
> >
> > # FS QA Test No. cifs/006
> > #
> > # check deferred closes on handles of deleted files
> > #
> > umount: /mnt/test: not mounted.
> > umount: /mnt/test: not mounted.
> > umount: /mnt/scratch: not mounted.
> > umount: /mnt/scratch: not mounted.
> > ./run-xfstests.sh: line 25: 4556 Segmentation fault rmmod cifs
> > modprobe: ERROR: could not insert 'cifs': Device or resource busy
> >
> > More information here:
> > http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builder=
s/5/builds/123/steps/14/logs/stdio
> >
> > Are you also seeing that?  There are not many likely candidates for
> > what patch is causing the problem (could be related to the folios
> > changes) e.g.
> >
> > 7c1ac89480e8 cifs: Enable large folio support
> > 3ee1a1fc3981 cifs: Cut over to using netfslib
> > 69c3c023af25 cifs: Implement netfslib hooks
> > c20c0d7325ab cifs: Make add_credits_and_wake_if() clear deducted credit=
s
> > edea94a69730 cifs: Add mempools for cifs_io_request and
> > cifs_io_subrequest structs
> > 3758c485f6c9 cifs: Set zero_point in the copy_file_range() and
> > remap_file_range()
> > 1a5b4edd97ce cifs: Move cifs_loose_read_iter() and
> > cifs_file_write_iter() to file.c
> > dc5939de82f1 cifs: Replace the writedata replay bool with a netfs sreq =
flag
> > 56257334e8e0 cifs: Make wait_mtu_credits take size_t args
> > ab58fbdeebc7 cifs: Use more fields from netfs_io_subrequest
> > a975a2f22cdc cifs: Replace cifs_writedata with a wrapper around
> > netfs_io_subrequest
> > 753b67eb630d cifs: Replace cifs_readdata with a wrapper around
> > netfs_io_subrequest
> > 0f7c0f3f5150 cifs: Use alternative invalidation to using launder_folio
> > 2e9d7e4b984a mm: Remove the PG_fscache alias for PG_private_2
> >
> > Any ideas?
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

