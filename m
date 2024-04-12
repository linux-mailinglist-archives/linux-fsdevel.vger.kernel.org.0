Return-Path: <linux-fsdevel+bounces-16782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE368A2883
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C190A1F248C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318CE4D9F6;
	Fri, 12 Apr 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZLBX1lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B92E3FD;
	Fri, 12 Apr 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908393; cv=none; b=MCpaA25HkKXb8+Gut294PASFWlsc/Siiik93B7oIr6Kh2FpRJBlSsFmJv62vBQ3KipPsMu+dTyCN8soIx1J4oHAZIsPTOoQm6QuNEOY6Pyb9Z899ZM2SiscIe/WsbOuE6KfZl45ZRblbNnPutecHy94QDzINb2izrnSufLIUox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908393; c=relaxed/simple;
	bh=7AB25A/V09XlHNs7lPaNZ3EFvGY/JQHIdAe7QEQ2SD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciLF9xw8/Vth1WKA8+Gy7vc3/3+gbFdpc5kvDXKNZiPAyJTmZBLHGm8Asq9csgccdddSE52XSmqX/ss0DsyAzHsvFy15ff+KBz/GElP3t8ydGayS1YC0Mcali1h0F+EGptaM8FDX6Dvo588TVhEOVSqWpgkCvQmGqxTDN/nx7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZLBX1lD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4347dadc2cfso3997901cf.3;
        Fri, 12 Apr 2024 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712908391; x=1713513191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqcmPBebDiY4QLcoIlCZmHKpMW9s+14LtH6kQjNjSCg=;
        b=dZLBX1lDFfFSbVBX2RYtLHVm3a8TyTl9iYAyMRppATZhTFH2oUUxFL12uMMVkdMp6i
         cRNTOKRA0DbPQwRoUrc7I/ZJZqJneAFNk2EMvEP7PrBuIA4Q0fUxCSG0Z9BuYitIbSs/
         p3zC2Bwj1h0xqsTP7edJOurnwDANtMW1geTqMtuTeTFi28MHrQjaLceHV0B9zkfOZX3p
         ubxsNaHoZrwK6JgdtLFl+pxMIIl6dxQRWu21J1tqFajeMt3B2Df0H5/o/lbOsmFnH1ya
         fGNzRMbZAOWCGLASh1xNbXcVL74MYKKKu4/7b2tdmEkwUqs21Xa2lY8eQzrZw6bJaZ8s
         cjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908391; x=1713513191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqcmPBebDiY4QLcoIlCZmHKpMW9s+14LtH6kQjNjSCg=;
        b=TZXytvQtyTu3PrDSh+Czl3kcAMFD+HDEIAY4nTy3GzPSi5+BS3s+9hCDrfxMIJ051c
         eRU50eqjDemal37e0OVju6N2X/LCArSHK6l6GIcseP7nq3ARaTZkDJbLxwGykbsLjufQ
         1v8OSA0wBnIW7PqBA6h+w3F/pZjRVIkexQ9Wbueq1QGrC+f7uu19AtjrmyIE25UPDxyf
         bUN1xf65GlUUfcBIqdb2tP/zeCSYmv4ak5mRja9XldSh0BqzrukXfJGpMcDgUSbpkFOw
         EuXdP2cPJOxDuVoXtC+gpe/ThgbwsiqlMEQRGFt3MiZwZjYcOEhwTSjoX1NyTraoUnUv
         C6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNtbI7iK9YumH7Zn1p6gqlFvcef4eBhBBA8wrKUi5idoe61kNn042/OVJaIBiOHnhrG/KMbZd14svMpRBTvquZiBKW8ShSdqF/qr/X5hnIh8iVVOMblWDW702M2Omq+zI4cwsk6UP5K1EsHbAKtjWr5xJWTQaaHs4Q7V78Axz4U8CLCyMWArs=
X-Gm-Message-State: AOJu0Yw14NC2QYMoxqObw/nBN3OeLCzdnA47IId/L4pyVqUst3mv118c
	p/2DXWjHrlPTypt4JqWHqXkeH4/YGVVlc7QRwbYFOWokEUt4egO1vJPlNVEOyVZjQB9+dRZs50M
	MXPSE5gO5yJFnu3iKPg8Jhnf4Eiw=
X-Google-Smtp-Source: AGHT+IFpqZiQTFT2ho41y9YKmKKL18+nC7uhM5EXxW4vHfIUzGSQevTZi1rkMbcHClmFb+FhhvNVaXfiAfEct7nXv+A=
X-Received: by 2002:ac8:6210:0:b0:436:8612:ba21 with SMTP id
 ks16-20020ac86210000000b004368612ba21mr1448815qtb.68.1712908390559; Fri, 12
 Apr 2024 00:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
 <0000000000003b04040615d7afde@google.com>
In-Reply-To: <0000000000003b04040615d7afde@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 10:52:59 +0300
Message-ID: <CAOQ4uxjY_On6FkkR1YHT2TSUhq=JX2X9ChPg9XgjJuQoAZ3hzg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
Cc: jack@suse.cz, krisman@suse.de, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	repnop@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:06=E2=80=AFPM syzbot
<syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> viperboard
> [    7.499011][    T1] usbcore: registered new interface driver dln2
> [    7.500804][    T1] usbcore: registered new interface driver pn533_usb
> [    7.507181][    T1] nfcsim 0.2 initialized
> [    7.508964][    T1] usbcore: registered new interface driver port100
> [    7.511844][    T1] usbcore: registered new interface driver nfcmrvl
> [    7.519814][    T1] Loading iSCSI transport class v2.0-870.
> [    7.539126][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queue=
s
> [    7.550224][    T1] ------------[ cut here ]------------
> [    7.551264][    T1] refcount_t: decrement hit 0; leaking memory.
> [    7.552627][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcou=
nt_warn_saturate+0xfa/0x1d0
> [    7.554218][    T1] Modules linked in:
> [    7.554791][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc=
3-syzkaller-00014-geb06a4b6cca5 #0
> [    7.556609][    T1] Hardware name: Google Google Compute Engine/Google=
 Compute Engine, BIOS Google 03/27/2024
> [    7.558128][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
> [    7.559937][    T1] Code: b2 00 00 00 e8 87 70 e7 fc 5b 5d c3 cc cc cc=
 cc e8 7b 70 e7 fc c6 05 0c 5d e5 0a 01 90 48 c7 c7 40 4b 1f 8c e8 17 ee a9=
 fc 90 <0f> 0b 90 90 eb d9 e8 5b 70 e7 fc c6 05 e9 5c e5 0a 01 90 48 c7 c7
> [    7.563097][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> [    7.564240][    T1] RAX: 6f40bd285f2a6000 RBX: ffff888147ed00fc RCX: f=
fff8880166d0000
> [    7.565743][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000000
> [    7.567236][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: f=
ffffbfff1c39af8
> [    7.568531][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: f=
fffea000503edc0
> [    7.570021][    T1] R13: ffffea000503edc8 R14: 1ffffd4000a07db9 R15: 0=
000000000000000
> [    7.571764][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(00=
00) knlGS:0000000000000000
> [    7.573270][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.574232][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 0=
0000000003506f0
> [    7.575566][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [    7.576737][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [    7.578004][    T1] Call Trace:
> [    7.578712][    T1]  <TASK>
> [    7.579189][    T1]  ? __warn+0x163/0x4e0
> [    7.580052][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.580896][    T1]  ? report_bug+0x2b3/0x500
> [    7.581593][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.582383][    T1]  ? handle_bug+0x3e/0x70
> [    7.583169][    T1]  ? exc_invalid_op+0x1a/0x50
> [    7.584335][    T1]  ? asm_exc_invalid_op+0x1a/0x20
> [    7.585285][    T1]  ? __warn_printk+0x292/0x360
> [    7.586058][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.586882][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
> [    7.587666][    T1]  __free_pages_ok+0xc60/0xd90
> [    7.588339][    T1]  make_alloc_exact+0xa3/0xf0
> [    7.589220][    T1]  vring_alloc_queue_split+0x20a/0x600
> [    7.590378][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
> [    7.591429][    T1]  ? vp_find_vqs+0x4c/0x4e0
> [    7.592174][    T1]  ? virtscsi_probe+0x3ea/0xf60
> [    7.592853][    T1]  ? virtio_dev_probe+0x991/0xaf0
> [    7.593892][    T1]  ? really_probe+0x2b8/0xad0
> [    7.594581][    T1]  ? driver_probe_device+0x50/0x430
> [    7.595325][    T1]  vring_create_virtqueue_split+0xc6/0x310
> [    7.596200][    T1]  ? ret_from_fork+0x4b/0x80
> [    7.597705][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
> [    7.599051][    T1]  vring_create_virtqueue+0xca/0x110
> [    7.599905][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.600626][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.601770][    T1]  setup_vq+0xe9/0x2d0
> [    7.602429][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.603153][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.604003][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.604758][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.605623][    T1]  vp_setup_vq+0xbf/0x330
> [    7.606388][    T1]  ? __pfx_vp_config_changed+0x10/0x10
> [    7.607239][    T1]  ? ioread16+0x2f/0x90
> [    7.608129][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.609047][    T1]  vp_find_vqs_msix+0x8b2/0xc80
> [    7.609880][    T1]  vp_find_vqs+0x4c/0x4e0
> [    7.610578][    T1]  virtscsi_init+0x8db/0xd00
> [    7.611247][    T1]  ? __pfx_virtscsi_init+0x10/0x10
> [    7.612058][    T1]  ? __pfx_default_calc_sets+0x10/0x10
> [    7.612860][    T1]  ? scsi_host_alloc+0xa57/0xea0
> [    7.613671][    T1]  ? vp_get+0xfd/0x140
> [    7.614243][    T1]  virtscsi_probe+0x3ea/0xf60
> [    7.614969][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
> [    7.615847][    T1]  ? kernfs_add_one+0x156/0x8b0
> [    7.616678][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
> [    7.617627][    T1]  ? virtio_features_ok+0x10c/0x270
> [    7.618392][    T1]  virtio_dev_probe+0x991/0xaf0
> [    7.619262][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
> [    7.620216][    T1]  really_probe+0x2b8/0xad0
> [    7.621124][    T1]  __driver_probe_device+0x1a2/0x390
> [    7.621980][    T1]  driver_probe_device+0x50/0x430
> [    7.622710][    T1]  __driver_attach+0x45f/0x710
> [    7.623413][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.624299][    T1]  bus_for_each_dev+0x239/0x2b0
> [    7.625118][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.625993][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
> [    7.626858][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
> [    7.627837][    T1]  bus_add_driver+0x347/0x620
> [    7.628735][    T1]  driver_register+0x23a/0x320
> [    7.629982][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.631006][    T1]  virtio_scsi_init+0x65/0xe0
> [    7.631802][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.632612][    T1]  do_one_initcall+0x248/0x880
> [    7.633404][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.634540][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> [    7.635786][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
> [    7.636889][    T1]  ? __pfx_parse_args+0x10/0x10
> [    7.637652][    T1]  ? do_initcalls+0x1c/0x80
> [    7.638456][    T1]  ? rcu_is_watching+0x15/0xb0
> [    7.639227][    T1]  do_initcall_level+0x157/0x210
> [    7.640192][    T1]  do_initcalls+0x3f/0x80
> [    7.640818][    T1]  kernel_init_freeable+0x435/0x5d0
> [    7.641593][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    7.642546][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
> [    7.643506][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.644295][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.645313][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.646036][    T1]  kernel_init+0x1d/0x2b0
> [    7.646660][    T1]  ret_from_fork+0x4b/0x80
> [    7.647368][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.648542][    T1]  ret_from_fork_asm+0x1a/0x30
> [    7.649812][    T1]  </TASK>
> [    7.650346][    T1] Kernel panic - not syncing: kernel: panic_on_warn =
set ...
> [    7.651620][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc=
3-syzkaller-00014-geb06a4b6cca5 #0
> [    7.653389][    T1] Hardware name: Google Google Compute Engine/Google=
 Compute Engine, BIOS Google 03/27/2024
> [    7.655321][    T1] Call Trace:
> [    7.655801][    T1]  <TASK>
> [    7.656252][    T1]  dump_stack_lvl+0x241/0x360
> [    7.657006][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
> [    7.657825][    T1]  ? __pfx__printk+0x10/0x10
> [    7.658542][    T1]  ? _printk+0xd5/0x120
> [    7.659343][    T1]  ? vscnprintf+0x5d/0x90
> [    7.659705][    T1]  panic+0x349/0x860
> [    7.659705][    T1]  ? __warn+0x172/0x4e0
> [    7.659705][    T1]  ? __pfx_panic+0x10/0x10
> [    7.659705][    T1]  ? show_trace_log_lvl+0x4e6/0x520
> [    7.659705][    T1]  ? ret_from_fork_asm+0x1a/0x30
> [    7.659705][    T1]  __warn+0x346/0x4e0
> [    7.659705][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.659705][    T1]  report_bug+0x2b3/0x500
> [    7.659705][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.659705][    T1]  handle_bug+0x3e/0x70
> [    7.659705][    T1]  exc_invalid_op+0x1a/0x50
> [    7.659705][    T1]  asm_exc_invalid_op+0x1a/0x20
> [    7.659705][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
> [    7.659705][    T1] Code: b2 00 00 00 e8 87 70 e7 fc 5b 5d c3 cc cc cc=
 cc e8 7b 70 e7 fc c6 05 0c 5d e5 0a 01 90 48 c7 c7 40 4b 1f 8c e8 17 ee a9=
 fc 90 <0f> 0b 90 90 eb d9 e8 5b 70 e7 fc c6 05 e9 5c e5 0a 01 90 48 c7 c7
> [    7.659705][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> [    7.659705][    T1] RAX: 6f40bd285f2a6000 RBX: ffff888147ed00fc RCX: f=
fff8880166d0000
> [    7.659705][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000000
> [    7.659705][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: f=
ffffbfff1c39af8
> [    7.659705][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: f=
fffea000503edc0
> [    7.659705][    T1] R13: ffffea000503edc8 R14: 1ffffd4000a07db9 R15: 0=
000000000000000
> [    7.659705][    T1]  ? __warn_printk+0x292/0x360
> [    7.659705][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
> [    7.659705][    T1]  __free_pages_ok+0xc60/0xd90
> [    7.659705][    T1]  make_alloc_exact+0xa3/0xf0
> [    7.659705][    T1]  vring_alloc_queue_split+0x20a/0x600
> [    7.659705][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
> [    7.659705][    T1]  ? vp_find_vqs+0x4c/0x4e0
> [    7.659705][    T1]  ? virtscsi_probe+0x3ea/0xf60
> [    7.659705][    T1]  ? virtio_dev_probe+0x991/0xaf0
> [    7.659705][    T1]  ? really_probe+0x2b8/0xad0
> [    7.659705][    T1]  ? driver_probe_device+0x50/0x430
> [    7.659705][    T1]  vring_create_virtqueue_split+0xc6/0x310
> [    7.659705][    T1]  ? ret_from_fork+0x4b/0x80
> [    7.659705][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
> [    7.659705][    T1]  vring_create_virtqueue+0xca/0x110
> [    7.659705][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.659705][    T1]  setup_vq+0xe9/0x2d0
> [    7.659705][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.659705][    T1]  vp_setup_vq+0xbf/0x330
> [    7.659705][    T1]  ? __pfx_vp_config_changed+0x10/0x10
> [    7.659705][    T1]  ? ioread16+0x2f/0x90
> [    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.709861][    T1]  vp_find_vqs_msix+0x8b2/0xc80
> [    7.709861][    T1]  vp_find_vqs+0x4c/0x4e0
> [    7.709861][    T1]  virtscsi_init+0x8db/0xd00
> [    7.709861][    T1]  ? __pfx_virtscsi_init+0x10/0x10
> [    7.709861][    T1]  ? __pfx_default_calc_sets+0x10/0x10
> [    7.709861][    T1]  ? scsi_host_alloc+0xa57/0xea0
> [    7.709861][    T1]  ? vp_get+0xfd/0x140
> [    7.709861][    T1]  virtscsi_probe+0x3ea/0xf60
> [    7.709861][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
> [    7.709861][    T1]  ? kernfs_add_one+0x156/0x8b0
> [    7.709861][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
> [    7.709861][    T1]  ? virtio_features_ok+0x10c/0x270
> [    7.709861][    T1]  virtio_dev_probe+0x991/0xaf0
> [    7.709861][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
> [    7.709861][    T1]  really_probe+0x2b8/0xad0
> [    7.709861][    T1]  __driver_probe_device+0x1a2/0x390
> [    7.709861][    T1]  driver_probe_device+0x50/0x430
> [    7.709861][    T1]  __driver_attach+0x45f/0x710
> [    7.709861][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.709861][    T1]  bus_for_each_dev+0x239/0x2b0
> [    7.709861][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.709861][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
> [    7.709861][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
> [    7.709861][    T1]  bus_add_driver+0x347/0x620
> [    7.709861][    T1]  driver_register+0x23a/0x320
> [    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.709861][    T1]  virtio_scsi_init+0x65/0xe0
> [    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.709861][    T1]  do_one_initcall+0x248/0x880
> [    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.709861][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> [    7.709861][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
> [    7.709861][    T1]  ? __pfx_parse_args+0x10/0x10
> [    7.709861][    T1]  ? do_initcalls+0x1c/0x80
> [    7.709861][    T1]  ? rcu_is_watching+0x15/0xb0
> [    7.709861][    T1]  do_initcall_level+0x157/0x210
> [    7.709861][    T1]  do_initcalls+0x3f/0x80
> [    7.709861][    T1]  kernel_init_freeable+0x435/0x5d0
> [    7.709861][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    7.709861][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
> [    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.709861][    T1]  kernel_init+0x1d/0x2b0
> [    7.709861][    T1]  ret_from_fork+0x4b/0x80
> [    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.709861][    T1]  ret_from_fork_asm+0x1a/0x30
> [    7.709861][    T1]  </TASK>
> [    7.709861][    T1] Kernel Offset: disabled
> [    7.709861][    T1] Rebooting in 86400 seconds..
>
>

Not sure what this is about.
Let's try again after rebase to current master:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Thanks,
Amir.

