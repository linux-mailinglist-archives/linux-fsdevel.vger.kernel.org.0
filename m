Return-Path: <linux-fsdevel+bounces-19397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AC8C48CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 23:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBF92848E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D682C88;
	Mon, 13 May 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH/OtXj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055628288F;
	Mon, 13 May 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635505; cv=none; b=X4ljHP5Ns6lBearmvNqR7sObiE/B21OQ9D2blj86Xe81qDb/58bYuLL0XE7wJlbOg3pXLSPXmHQZITPbstuVmapSWXh+75MB/OGb8xzoCKPo/eMraK5mkY6eOy9ybcmyIWXgWEJdEWTCtbqmYhqlfI3uJBmUidzSmL+GoVrrcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635505; c=relaxed/simple;
	bh=zwVUoTt0Mvc77TZhWZtFnSQs69Hoh1fL7Om3rzw6V2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qplpugjYBEVeGpxFvSqZMqHsVBeGY28Wl4SoI9/Ldp7wL5wz8m8g7G8dhtG1e7Cordh7rsYuO7//xq8GJ86LSBAsTi+++0Sj3UjFEOqM8eN9SCxNEOrzSn4JGLIEiBNMjVu7JHCfwOM0Us7woGF5F0aL7w0q89GVP7x8lxcOoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH/OtXj3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so57462531fa.3;
        Mon, 13 May 2024 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715635501; x=1716240301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mDxr4awHDztEMqFtuKHan1uXzEexs1YGBsJwCreRv1Y=;
        b=FH/OtXj3THF0FBxwCAl9nTtoRUgMqmjF3OzWQFgjOVKsuEmd5J0cC/EXzPgtzkyepZ
         VMx3nX8Q2AM+UEwCBn3jbGbCZc87sYN5xFPatIPs79Rp/IkEZZF7ivL3dN3jIHqQQegc
         95hDDlYkuKnrAAzUskeuiTxTptyfEcbqqskgGYTguecmIEc0vu9RJQgkSfQycuStIWmG
         sfmxMiveTI/XRBOOWp5d18v6ZLcD2fhqsAeVLJsCbPHAtkIa/yi6FS4EWmqu8SDE74XR
         55Dz39egFOc+BZ/U3b6x9jgtWHLk7//YkfCWW2V314OqXMFN/po/TQvmwy7K9EkBhIJw
         p8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635501; x=1716240301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDxr4awHDztEMqFtuKHan1uXzEexs1YGBsJwCreRv1Y=;
        b=G24rMuMvZYzWYRbpBWuMTKrjaIIRpNMykudMp7LAEcztZ4ATF9l2FchUOxhY90IALJ
         bYiaWuijGsVnDAVd3TtuZcmq5slBKlBofE4JqJbnEksQCaJTGt7V1p1d75PqpWt12FJi
         cSphFkXxY0abzBh1NqoaGLoMEIjH9avUY66kzhJnjiqhuCvhWzeii7ubtABijaqTeDS+
         QtEPsW8Mnez+tDKK4OkF6PFKbCMjIwm4R6Dfz0R7FSo0dvrBil3XoiX6xzQePwatrkkr
         J090gOFGcVgLdOoK4MZXAEHdzK/T2eFE6VZY5ERvk3jy3UtTuAKDzbjCaRW446iMRPW1
         7uZA==
X-Forwarded-Encrypted: i=1; AJvYcCW1gBWEcAFVX9ngcubTMsgl/DJE1yXCOzPfdrC5K266OpjjLRcJrPZU2SLrx1yeC/46IP074sjT2YXzIAaXVbZx6xN1hDovhDZuaIvXQw==
X-Gm-Message-State: AOJu0YyyRij0AF59DXj3ghLyuKvMnyd2fYgHUceE0gphnsHQD2oa5bO4
	LcCMrVu/9s4SHx+5oeM+6GEUeNBfE9D3M3u6xfXEc3EIHwv/NMWuXpG2esitJbPO77F6T4Sl4QZ
	XByIVYxkQ5ApPAEGg90bvG1SUJ0+/dLzr
X-Google-Smtp-Source: AGHT+IGj4/GrLOuoxnQbuUXxPZL2aLnWO44sjFXDSarFHI4iWtRarnbnKe23JRYY5JDiK64O3g7RCgX9yIdYFoXuT20=
X-Received: by 2002:a2e:be84:0:b0:2df:6cb8:c911 with SMTP id
 38308e7fff4ca-2e51ff5e437mr82953561fa.24.1715635500418; Mon, 13 May 2024
 14:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mvvRFnzYnOM5T7qP+7H2Jetcv4cePhBPRDkd0ZwOGJfvg@mail.gmail.com>
 <CAH2r5ms-fSEsiusCeiRANZ10J6z1p5QQYzPRXqiDHfaYb-3Wgg@mail.gmail.com> <CAH2r5msmBQ=5zx=0SggGYg_Hpxc7ZcMPVY9xPY_u4_2pBuZJQQ@mail.gmail.com>
In-Reply-To: <CAH2r5msmBQ=5zx=0SggGYg_Hpxc7ZcMPVY9xPY_u4_2pBuZJQQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 13 May 2024 16:24:49 -0500
Message-ID: <CAH2r5mutCTMA6Mq2coMRBQkmH6_b8Fa+nvewP3bYkJ3orH-_Gg@mail.gmail.com>
Subject: Re: cifs
To: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000912ae806185c848e"

--000000000000912ae806185c848e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix for the insmod/rmmod netfs bug

See attached


On Mon, May 13, 2024 at 2:34=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> The problem with the recent netfs/folio series is easy to repro, and
> doesn't show up if I remove the mempools patch:
>
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Mar 15 18:03:30 2024 +0000
>
>     cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs
>
>     Add mempools for the allocation of cifs_io_request and cifs_io_subreq=
uest
>     structs for netfslib to use so that it can guarantee eventual allocat=
ion in
>     writeback.
>
> Repro is just to do modprobe and then rmmod
>
> [root@fedora29 xfstests-dev]# modprobe cifs
> [root@fedora29 xfstests-dev]# dmesg -c
> [  589.547809] Key type cifs.spnego registered
> [  589.547857] Key type cifs.idmap registered
> [root@fedora29 xfstests-dev]# rmmod cifs
> Segmentation fault
>
> [  593.793058] RIP: 0010:free_large_kmalloc+0x78/0xb0
> [  593.793063] Code: 74 0a 5d 41 5c 41 5d c3 cc cc cc cc 48 89 ef 5d
> 41 5c 41 5d e9 99 06 f4 ff 48 c7 c6 50 cf 38 9d 48 89 ef e8 7a f4 f8
> ff 0f 0b <0f> 0b 80 3d a6 3d 91 02 00 41 bc 00 f0 ff ff 75 a2 4c 89 ee
> 48 c7
> [  593.793068] RSP: 0018:ff1100011ceafe00 EFLAGS: 00010246
> [  593.793074] RAX: 0017ffffc0000000 RBX: 1fe22000239d5fc6 RCX: dffffc000=
0000000
> [  593.793078] RDX: ffd4000009265808 RSI: ffffffffc1960140 RDI: ffd400000=
9265800
> [  593.793082] RBP: ffd4000009265800 R08: ffffffff9b287a70 R09: 000000000=
0000001
> [  593.793086] R10: ffffffff9df472e7 R11: 0000000000000001 R12: ffffffffc=
195ff60
> [  593.793090] R13: ffffffffc1960140 R14: 0000000000000000 R15: 000000000=
0000000
> [  593.793093] FS:  00007fd5849cc280(0000) GS:ff110004cb200000(0000)
> knlGS:0000000000000000
> [  593.793098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  593.793101] CR2: 000055c6c44c7d58 CR3: 000000010da2a004 CR4: 000000000=
0371ef0
> [  593.793110] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  593.793114] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  593.793118] Call Trace:
> [  593.793121]  <TASK>
> [  593.793125]  ? __warn+0xa4/0x220
> [  593.793133]  ? free_large_kmalloc+0x78/0xb0
> [  593.793140]  ? report_bug+0x1d4/0x1e0
> [  593.793151]  ? handle_bug+0x42/0x80
> [  593.793158]  ? exc_invalid_op+0x18/0x50
> [  593.793164]  ? asm_exc_invalid_op+0x1a/0x20
> [  593.793178]  ? rcu_is_watching+0x20/0x50
> [  593.793188]  ? free_large_kmalloc+0x78/0xb0
> [  593.793197]  exit_cifs+0x89/0x6a0 [cifs]
> [  593.793363]  __do_sys_delete_module.constprop.0+0x23f/0x450
> [  593.793370]  ? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
> [  593.793375]  ? mark_held_locks+0x24/0x90
> [  593.793383]  ? __x64_sys_close+0x54/0xa0
> [  593.793388]  ? lockdep_hardirqs_on_prepare+0x139/0x200
> [  593.793394]  ? kasan_quarantine_put+0x97/0x1f0
> [  593.793404]  ? mark_held_locks+0x24/0x90
> [  593.793414]  do_syscall_64+0x78/0x180
> [  593.793421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  593.793427] RIP: 0033:0x7fd584aecd4b
> [  593.793433] Code: 73 01 c3 48 8b 0d 3d 11 0c 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 11 0c 00 f7 d8 64 89
> 01 48
> [  593.793437] RSP: 002b:00007ffe0a36ec18 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  593.793443] RAX: ffffffffffffffda RBX: 000055c6c44bd7a0 RCX: 00007fd58=
4aecd4b
> [  593.793447] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055c6c=
44bd808
> [  593.793451] RBP: 0000000000000000 R08: 00007ffe0a36db91 R09: 000000000=
0000000
> [  593.793454] R10: 00007fd584b5eae0 R11: 0000000000000206 R12: 00007ffe0=
a36ee40
> [  593.793458] R13: 00007ffe0a3706d1 R14: 000055c6c44bd260 R15: 000055c6c=
44bd7a0
> [  593.793474]  </TASK>
> [  593.793477] irq event stamp: 12729
> [  593.793480] hardirqs last  enabled at (12735): [<ffffffff9b25d2eb>]
> console_unlock+0x15b/0x170
> [  593.793487] hardirqs last disabled at (12740): [<ffffffff9b25d2d0>]
> console_unlock+0x140/0x170
> [  593.793492] softirqs last  enabled at (11910): [<ffffffff9b16499e>]
> __irq_exit_rcu+0xfe/0x120
> [  593.793498] softirqs last disabled at (11901): [<ffffffff9b16499e>]
> __irq_exit_rcu+0xfe/0x120
> [  593.793503] ---[ end trace 0000000000000000 ]---
> [  593.793546] object pointer: 0x00000000da6e868b
> [  593.793550] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  593.793553] BUG: KASAN: invalid-free in exit_cifs+0x89/0x6a0 [cifs]
> [  593.793698] Free of addr ffffffffc1960140 by task rmmod/1306
>
> [  593.793703] CPU: 4 PID: 1306 Comm: rmmod Tainted: G        W
>   6.9.0 #1
> [  593.793707] Hardware name: Red Hat KVM, BIOS 1.16.1-1.el9 04/01/2014
> [  593.793709] Call Trace:
> [  593.793711]  <TASK>
> [  593.793714]  dump_stack_lvl+0x79/0xb0
> [  593.793718]  print_report+0xcb/0x620
> [  593.793724]  ? exit_cifs+0x89/0x6a0 [cifs]
> [  593.793861]  ? exit_cifs+0x89/0x6a0 [cifs]
> [  593.794002]  kasan_report_invalid_free+0x9a/0xc0
> [  593.794008]  ? exit_cifs+0x89/0x6a0 [cifs]
> [  593.794173]  free_large_kmalloc+0x38/0xb0
> [  593.794178]  exit_cifs+0x89/0x6a0 [cifs]
> [  593.794327]  __do_sys_delete_module.constprop.0+0x23f/0x450
> [  593.794331]  ? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
> [  593.794335]  ? mark_held_locks+0x24/0x90
> [  593.794339]  ? __x64_sys_close+0x54/0xa0
> [  593.794342]  ? lockdep_hardirqs_on_prepare+0x139/0x200
> [  593.794347]  ? kasan_quarantine_put+0x97/0x1f0
> [  593.794352]  ? mark_held_locks+0x24/0x90
> [  593.794357]  do_syscall_64+0x78/0x180
> [  593.794361]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  593.794367] RIP: 0033:0x7fd584aecd4b
> [  593.794370] Code: 73 01 c3 48 8b 0d 3d 11 0c 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 11 0c 00 f7 d8 64 89
> 01 48
> [  593.794373] RSP: 002b:00007ffe0a36ec18 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  593.794377] RAX: ffffffffffffffda RBX: 000055c6c44bd7a0 RCX: 00007fd58=
4aecd4b
> [  593.794380] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055c6c=
44bd808
> [  593.794382] RBP: 0000000000000000 R08: 00007ffe0a36db91 R09: 000000000=
0000000
> [  593.794385] R10: 00007fd584b5eae0 R11: 0000000000000206 R12: 00007ffe0=
a36ee40
> [  593.794387] R13: 00007ffe0a3706d1 R14: 000055c6c44bd260 R15: 000055c6c=
44bd7a0
> [  593.794394]  </TASK>
>
> [  593.794398] The buggy address belongs to the variable:
> [  593.794399]  cifs_io_subrequest_pool+0x0/0xfffffffffff3dec0 [cifs]
>
> [  593.794557] Memory state around the buggy address:
> [  593.794559]  ffffffffc1960000: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
> f9 f9 f9 f9
> [  593.794562]  ffffffffc1960080: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
> f9 f9 f9 f9
> [  593.794565] >ffffffffc1960100: 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00
> 00 00 00 00
> [  593.794567]                                            ^
> [  593.794570]  ffffffffc1960180: 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 f9
> [  593.794572]  ffffffffc1960200: f9 f9 f9 f9 00 00 00 00 00 00 00 00
> 00 00 00 00
> [  593.794575] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> On Sat, May 11, 2024 at 12:59=E2=80=AFPM Steve French <smfrench@gmail.com=
> wrote:
> >
> > This was running against linux-next as of about an hour ago
> >
> > On Sat, May 11, 2024 at 12:53=E2=80=AFPM Steve French <smfrench@gmail.c=
om> wrote:
> > >
> > > Tried running the regression tests against for-next and saw crash
> > > early in the test run in
> > >
> > > # FS QA Test No. cifs/006
> > > #
> > > # check deferred closes on handles of deleted files
> > > #
> > > umount: /mnt/test: not mounted.
> > > umount: /mnt/test: not mounted.
> > > umount: /mnt/scratch: not mounted.
> > > umount: /mnt/scratch: not mounted.
> > > ./run-xfstests.sh: line 25: 4556 Segmentation fault rmmod cifs
> > > modprobe: ERROR: could not insert 'cifs': Device or resource busy
> > >
> > > More information here:
> > > http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/build=
ers/5/builds/123/steps/14/logs/stdio
> > >
> > > Are you also seeing that?  There are not many likely candidates for
> > > what patch is causing the problem (could be related to the folios
> > > changes) e.g.
> > >
> > > 7c1ac89480e8 cifs: Enable large folio support
> > > 3ee1a1fc3981 cifs: Cut over to using netfslib
> > > 69c3c023af25 cifs: Implement netfslib hooks
> > > c20c0d7325ab cifs: Make add_credits_and_wake_if() clear deducted cred=
its
> > > edea94a69730 cifs: Add mempools for cifs_io_request and
> > > cifs_io_subrequest structs
> > > 3758c485f6c9 cifs: Set zero_point in the copy_file_range() and
> > > remap_file_range()
> > > 1a5b4edd97ce cifs: Move cifs_loose_read_iter() and
> > > cifs_file_write_iter() to file.c
> > > dc5939de82f1 cifs: Replace the writedata replay bool with a netfs sre=
q flag
> > > 56257334e8e0 cifs: Make wait_mtu_credits take size_t args
> > > ab58fbdeebc7 cifs: Use more fields from netfs_io_subrequest
> > > a975a2f22cdc cifs: Replace cifs_writedata with a wrapper around
> > > netfs_io_subrequest
> > > 753b67eb630d cifs: Replace cifs_readdata with a wrapper around
> > > netfs_io_subrequest
> > > 0f7c0f3f5150 cifs: Use alternative invalidation to using launder_foli=
o
> > > 2e9d7e4b984a mm: Remove the PG_fscache alias for PG_private_2
> > >
> > > Any ideas?
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
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



--
Thanks,

Steve

--000000000000912ae806185c848e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-Change-from-mempool_destroy-to-mempool_exit-for.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Change-from-mempool_destroy-to-mempool_exit-for.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lw5h2ilq0>
X-Attachment-Id: f_lw5h2ilq0

RnJvbSBlYTE5YTdhNDhlZGIyZGU4ZWJlZWY1MDlmYTE2NTU3Mzk0ZDVkM2M0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMTMgTWF5IDIwMjQgMTI6NDk6MjIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBDaGFuZ2UgZnJvbSBtZW1wb29sX2Rlc3Ryb3kgdG8gbWVtcG9vbF9leGl0IGZvciByZXF1
ZXN0CiBwb29scwoKaW5zbW9kIGZvbGxvd2VkIGJ5IHJtbW9kIHdhcyBvb3BzaW5nIHdpdGggdGhl
IG5ldyBtZW1wb29scyBjaWZzIHJlcXVlc3QgcGF0Y2gKCkZpeGVzOiBlZGVhOTRhNjk3MzAgKCJj
aWZzOiBBZGQgbWVtcG9vbHMgZm9yIGNpZnNfaW9fcmVxdWVzdCBhbmQgY2lmc19pb19zdWJyZXF1
ZXN0IHN0cnVjdHMiKQpTdWdnZXN0ZWQtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPgpT
aWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQog
ZnMvc21iL2NsaWVudC9jaWZzZnMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2NpZnNm
cy5jIGIvZnMvc21iL2NsaWVudC9jaWZzZnMuYwppbmRleCA3NjNkMTc4NzBlMGIuLmM4YjUyYWM5
NGNlMiAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZnMuYworKysgYi9mcy9zbWIvY2xp
ZW50L2NpZnNmcy5jCkBAIC0xNzkwLDkgKzE3OTAsOSBAQCBzdGF0aWMgaW50IGNpZnNfaW5pdF9u
ZXRmcyh2b2lkKQogCiBzdGF0aWMgdm9pZCBjaWZzX2Rlc3Ryb3lfbmV0ZnModm9pZCkKIHsKLQlt
ZW1wb29sX2Rlc3Ryb3koJmNpZnNfaW9fc3VicmVxdWVzdF9wb29sKTsKKwltZW1wb29sX2V4aXQo
JmNpZnNfaW9fc3VicmVxdWVzdF9wb29sKTsKIAlrbWVtX2NhY2hlX2Rlc3Ryb3koY2lmc19pb19z
dWJyZXF1ZXN0X2NhY2hlcCk7Ci0JbWVtcG9vbF9kZXN0cm95KCZjaWZzX2lvX3JlcXVlc3RfcG9v
bCk7CisJbWVtcG9vbF9leGl0KCZjaWZzX2lvX3JlcXVlc3RfcG9vbCk7CiAJa21lbV9jYWNoZV9k
ZXN0cm95KGNpZnNfaW9fcmVxdWVzdF9jYWNoZXApOwogfQogCi0tIAoyLjQwLjEKCg==
--000000000000912ae806185c848e--

