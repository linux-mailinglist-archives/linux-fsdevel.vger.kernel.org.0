Return-Path: <linux-fsdevel+bounces-16806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE78A30BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80F7B23FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE513DDAC;
	Fri, 12 Apr 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQOysi5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAC13CA91
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932354; cv=none; b=XnA1GYUPxsrln3Gw/+ASQJ6XoKLBSZuoF8ndMQY0r/LjDPmjVJZ2v/tQRaTRSBRsGAwWRASwuOiyjwcJ3E7BMQwA4N8y8JCEbYq4ZNl/k7N6Ndk7yr3NYYWLIKufHvQcHMfM8Y/SoDx6FM71SHxkOfLgJ6MWtiaAaPJp3Dw1o2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932354; c=relaxed/simple;
	bh=z6f+DpfWdQOyDjGK7Xhbii7c/cF4+9GYqYeMiWn3L6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgfUPlN64L7Ki3S1z8HB9HXwwComEsZtdaWhfQXOWTzKGJw0dvK9BByXm1LbHyzGC8U0LkVjuO68ynxyAEZhuOaXO6tl7fQCjGRV2L3zJtSRVze+C/eZtj6dp1TzjDJM9GMaJ/efl492GnlHkyuM/KbFCu4dQGwy7C51J+WU1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQOysi5b; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e44f82ff9cso105565ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712932351; x=1713537151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ0lF0NopBEopDyfBKqAjn1V2iZIve9E7jDPif6N+N0=;
        b=PQOysi5bC+C641xmX8lDBcfY1ipqtXtGWyLx1GcoHLVH+1nyJPOV5XBQ/HAxC0R4bM
         4Ar7z6TiYTNofV3/1UJ3uZuIfYbvGFaEZVazaYxWYyqsMM8Ifi7ulYABz00S00h1eGpc
         5miRe40YRQgmvnswdIM9UgshCO6GhjR7dxTCJcM6b72omvCjnBaFOk39wGYdOpWiwGZw
         zHIHGh1G7UNUi7ng2Sm2/pBCZYX1ET0ZRQ/pHB1J5kRPhYIK83UMGzRusHhiCZxunH77
         3t8EBM6VEZ+TN2zMtYOZQdqJQcW6TTuj1jTzkjnDG3rK02ExYxpnBTkAQ0O0S/1De5Fg
         i+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932351; x=1713537151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJ0lF0NopBEopDyfBKqAjn1V2iZIve9E7jDPif6N+N0=;
        b=meicfv9raNiczehuR2u4n2MNNd5AtHpgZtg9r8S0CcDt8UTVshE4/H+2xUsxjP/oFX
         yhwT/6ECoZIDLLZUJxvLXj8DSH5uebfkFjJ3bAuujSSGPfRcwn+1YnN7+XOaHCYZwVtT
         efMLcFoSjoZyQxUitx+lW8+FhVTskiDkiq0f1rKeVelsplKg6xUA+JvyZlSlXlwU80m6
         SISnyFm2+W0Ve2R2oYrv8JogsEsFAnBs37va+k7Bu2mNnJRU3n7/NO2cVneRvqDOl08+
         2ryJGQNULP74PDhxf4fMhBzqJ6mrx7KDTN5atF1dfj0NhNelxKkzbzMEVthrbDlKcyEz
         vggg==
X-Forwarded-Encrypted: i=1; AJvYcCWObQuhCSY+DnUYe88fgXuvRGCU7LFC25TPZdtbVxlqA67+NuUMcs6sKG990b8dgcO1K5ODmhorZiELKT98Ffg2gPo2kRf8yh+F0Ysbog==
X-Gm-Message-State: AOJu0Yx6kBeqyRgO3ULK44qujerq8Q4zSrlFU+UGjXAjpTGlgmsk0c3Y
	h3ttpfSZ5j+4k89oLiZKzCgtdYKbvxw4z9tAOMJZWRYaNKQPzl0melK3lwBo0FhgtSL1896SMqS
	MslAl+akErIz2PjNBc5LHRAuwzp4FySghykAE
X-Google-Smtp-Source: AGHT+IFrQYpa5/wbLFsPScnd7YN0byOsYmw2e1Xp69VJJ8kCAPFj03lsEz2hSVrjVL5ykgQJ/6NNAhjan8ku7NOqhAg=
X-Received: by 2002:a17:903:230d:b0:1e5:62:7a89 with SMTP id
 d13-20020a170903230d00b001e500627a89mr208160plh.18.1712932350065; Fri, 12 Apr
 2024 07:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjY_On6FkkR1YHT2TSUhq=JX2X9ChPg9XgjJuQoAZ3hzg@mail.gmail.com>
 <000000000000774dfe0615e71b29@google.com>
In-Reply-To: <000000000000774dfe0615e71b29@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 12 Apr 2024 16:32:16 +0200
Message-ID: <CANp29Y4tsid3_S253KC_W0TMzinhcx6DTKNJHxznv8TLzxhaRg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, krisman@suse.de, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW all latest v6.9 release candidates just do not boot with the syzbot co=
nfig.
There's a "mm,page_owner: Fix refcount imbalance" series that
addresses it, but it has not apparently reached torvalds yet.

On Fri, Apr 12, 2024 at 4:30=E2=80=AFPM syzbot
<syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> viperboard
> [    7.815991][    T1] usbcore: registered new interface driver dln2
> [    7.818221][    T1] usbcore: registered new interface driver pn533_usb
> [    7.823865][    T1] nfcsim 0.2 initialized
> [    7.825314][    T1] usbcore: registered new interface driver port100
> [    7.828562][    T1] usbcore: registered new interface driver nfcmrvl
> [    7.837679][    T1] Loading iSCSI transport class v2.0-870.
> [    7.856316][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queue=
s
> [    7.867881][    T1] ------------[ cut here ]------------
> [    7.869240][    T1] refcount_t: decrement hit 0; leaking memory.
> [    7.870647][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcou=
nt_warn_saturate+0xfa/0x1d0
> [    7.872673][    T1] Modules linked in:
> [    7.873450][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc=
3-syzkaller-00222-ga4170c0055a4 #0
> [    7.875073][    T1] Hardware name: Google Google Compute Engine/Google=
 Compute Engine, BIOS Google 03/27/2024
> [    7.876781][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
> [    7.877963][    T1] Code: b2 00 00 00 e8 e7 63 e7 fc 5b 5d c3 cc cc cc=
 cc e8 db 63 e7 fc c6 05 6c d2 e4 0a 01 90 48 c7 c7 c0 30 1f 8c e8 77 e1 a9=
 fc 90 <0f> 0b 90 90 eb d9 e8 bb 63 e7 fc c6 05 49 d2 e4 0a 01 90 48 c7 c7
> [    7.881853][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> [    7.883056][    T1] RAX: 7664671302135400 RBX: ffff8880202afc6c RCX: f=
fff8880166d0000
> [    7.885276][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000000
> [    7.887369][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: f=
ffffbfff1c39b48
> [    7.888750][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: f=
fffea000502ddc0
> [    7.890131][    T1] R13: ffffea000502ddc8 R14: 1ffffd4000a05bb9 R15: 0=
000000000000000
> [    7.891813][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(00=
00) knlGS:0000000000000000
> [    7.893900][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.895917][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 0=
0000000003506f0
> [    7.897448][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [    7.898766][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [    7.900462][    T1] Call Trace:
> [    7.901245][    T1]  <TASK>
> [    7.901998][    T1]  ? __warn+0x163/0x4e0
> [    7.902783][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.904160][    T1]  ? report_bug+0x2b3/0x500
> [    7.905119][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.906474][    T1]  ? handle_bug+0x3e/0x70
> [    7.907513][    T1]  ? exc_invalid_op+0x1a/0x50
> [    7.908463][    T1]  ? asm_exc_invalid_op+0x1a/0x20
> [    7.909468][    T1]  ? __warn_printk+0x292/0x360
> [    7.910957][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    7.912558][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
> [    7.913803][    T1]  __free_pages_ok+0xc60/0xd90
> [    7.914583][    T1]  make_alloc_exact+0xa3/0xf0
> [    7.915425][    T1]  vring_alloc_queue_split+0x20a/0x600
> [    7.916903][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
> [    7.917937][    T1]  ? vp_find_vqs+0x4c/0x4e0
> [    7.918930][    T1]  ? virtscsi_probe+0x3ea/0xf60
> [    7.919998][    T1]  ? virtio_dev_probe+0x991/0xaf0
> [    7.921234][    T1]  ? really_probe+0x2b8/0xad0
> [    7.921893][    T1]  ? driver_probe_device+0x50/0x430
> [    7.922882][    T1]  vring_create_virtqueue_split+0xc6/0x310
> [    7.924087][    T1]  ? ret_from_fork+0x4b/0x80
> [    7.924906][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
> [    7.926406][    T1]  vring_create_virtqueue+0xca/0x110
> [    7.927871][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.929037][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.929986][    T1]  setup_vq+0xe9/0x2d0
> [    7.930782][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    7.931882][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.932643][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.933619][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.934781][    T1]  vp_setup_vq+0xbf/0x330
> [    7.935911][    T1]  ? __pfx_vp_config_changed+0x10/0x10
> [    7.937334][    T1]  ? ioread16+0x2f/0x90
> [    7.938489][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    7.939978][    T1]  vp_find_vqs_msix+0x8b2/0xc80
> [    7.940989][    T1]  vp_find_vqs+0x4c/0x4e0
> [    7.941655][    T1]  virtscsi_init+0x8db/0xd00
> [    7.942427][    T1]  ? __pfx_virtscsi_init+0x10/0x10
> [    7.943724][    T1]  ? __pfx_default_calc_sets+0x10/0x10
> [    7.944616][    T1]  ? scsi_host_alloc+0xa57/0xea0
> [    7.946041][    T1]  ? vp_get+0xfd/0x140
> [    7.946895][    T1]  virtscsi_probe+0x3ea/0xf60
> [    7.947740][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
> [    7.948718][    T1]  ? kernfs_add_one+0x156/0x8b0
> [    7.949578][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
> [    7.950761][    T1]  ? virtio_features_ok+0x10c/0x270
> [    7.951946][    T1]  virtio_dev_probe+0x991/0xaf0
> [    7.953286][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
> [    7.954435][    T1]  really_probe+0x2b8/0xad0
> [    7.955311][    T1]  __driver_probe_device+0x1a2/0x390
> [    7.956686][    T1]  driver_probe_device+0x50/0x430
> [    7.957771][    T1]  __driver_attach+0x45f/0x710
> [    7.958769][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.959612][    T1]  bus_for_each_dev+0x239/0x2b0
> [    7.960946][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    7.962251][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
> [    7.964315][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
> [    7.966148][    T1]  bus_add_driver+0x347/0x620
> [    7.967112][    T1]  driver_register+0x23a/0x320
> [    7.968628][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.969941][    T1]  virtio_scsi_init+0x65/0xe0
> [    7.970833][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.972203][    T1]  do_one_initcall+0x248/0x880
> [    7.973355][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    7.974515][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> [    7.975602][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
> [    7.977269][    T1]  ? __pfx_parse_args+0x10/0x10
> [    7.978148][    T1]  ? do_initcalls+0x1c/0x80
> [    7.979254][    T1]  ? rcu_is_watching+0x15/0xb0
> [    7.980350][    T1]  do_initcall_level+0x157/0x210
> [    7.981349][    T1]  do_initcalls+0x3f/0x80
> [    7.982742][    T1]  kernel_init_freeable+0x435/0x5d0
> [    7.984461][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    7.986325][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
> [    7.987513][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.988803][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.990065][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.991335][    T1]  kernel_init+0x1d/0x2b0
> [    7.992855][    T1]  ret_from_fork+0x4b/0x80
> [    7.994528][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    7.996074][    T1]  ret_from_fork_asm+0x1a/0x30
> [    7.997423][    T1]  </TASK>
> [    7.998234][    T1] Kernel panic - not syncing: kernel: panic_on_warn =
set ...
> [    7.999604][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc=
3-syzkaller-00222-ga4170c0055a4 #0
> [    8.001827][    T1] Hardware name: Google Google Compute Engine/Google=
 Compute Engine, BIOS Google 03/27/2024
> [    8.004098][    T1] Call Trace:
> [    8.005064][    T1]  <TASK>
> [    8.005501][    T1]  dump_stack_lvl+0x241/0x360
> [    8.006050][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
> [    8.006050][    T1]  ? __pfx__printk+0x10/0x10
> [    8.006050][    T1]  ? _printk+0xd5/0x120
> [    8.006050][    T1]  ? vscnprintf+0x5d/0x90
> [    8.006050][    T1]  panic+0x349/0x860
> [    8.006050][    T1]  ? __warn+0x172/0x4e0
> [    8.006050][    T1]  ? __pfx_panic+0x10/0x10
> [    8.006050][    T1]  ? show_trace_log_lvl+0x4e6/0x520
> [    8.006050][    T1]  ? ret_from_fork_asm+0x1a/0x30
> [    8.006050][    T1]  __warn+0x346/0x4e0
> [    8.006050][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    8.006050][    T1]  report_bug+0x2b3/0x500
> [    8.006050][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
> [    8.006050][    T1]  handle_bug+0x3e/0x70
> [    8.006050][    T1]  exc_invalid_op+0x1a/0x50
> [    8.006050][    T1]  asm_exc_invalid_op+0x1a/0x20
> [    8.006050][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
> [    8.006050][    T1] Code: b2 00 00 00 e8 e7 63 e7 fc 5b 5d c3 cc cc cc=
 cc e8 db 63 e7 fc c6 05 6c d2 e4 0a 01 90 48 c7 c7 c0 30 1f 8c e8 77 e1 a9=
 fc 90 <0f> 0b 90 90 eb d9 e8 bb 63 e7 fc c6 05 49 d2 e4 0a 01 90 48 c7 c7
> [    8.006050][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
> [    8.006050][    T1] RAX: 7664671302135400 RBX: ffff8880202afc6c RCX: f=
fff8880166d0000
> [    8.006050][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000000
> [    8.006050][    T1] RBP: 0000000000000004 R08: ffffffff815880a2 R09: f=
ffffbfff1c39b48
> [    8.006050][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: f=
fffea000502ddc0
> [    8.006050][    T1] R13: ffffea000502ddc8 R14: 1ffffd4000a05bb9 R15: 0=
000000000000000
> [    8.006050][    T1]  ? __warn_printk+0x292/0x360
> [    8.006050][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
> [    8.006050][    T1]  __free_pages_ok+0xc60/0xd90
> [    8.006050][    T1]  make_alloc_exact+0xa3/0xf0
> [    8.006050][    T1]  vring_alloc_queue_split+0x20a/0x600
> [    8.006050][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
> [    8.006050][    T1]  ? vp_find_vqs+0x4c/0x4e0
> [    8.006050][    T1]  ? virtscsi_probe+0x3ea/0xf60
> [    8.006050][    T1]  ? virtio_dev_probe+0x991/0xaf0
> [    8.006050][    T1]  ? really_probe+0x2b8/0xad0
> [    8.006050][    T1]  ? driver_probe_device+0x50/0x430
> [    8.006050][    T1]  vring_create_virtqueue_split+0xc6/0x310
> [    8.006050][    T1]  ? ret_from_fork+0x4b/0x80
> [    8.055954][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
> [    8.055954][    T1]  vring_create_virtqueue+0xca/0x110
> [    8.055954][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    8.055954][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    8.055954][    T1]  setup_vq+0xe9/0x2d0
> [    8.055954][    T1]  ? __pfx_vp_notify+0x10/0x10
> [    8.055954][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    8.055954][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    8.055954][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    8.055954][    T1]  vp_setup_vq+0xbf/0x330
> [    8.055954][    T1]  ? __pfx_vp_config_changed+0x10/0x10
> [    8.055954][    T1]  ? ioread16+0x2f/0x90
> [    8.055954][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
> [    8.055954][    T1]  vp_find_vqs_msix+0x8b2/0xc80
> [    8.055954][    T1]  vp_find_vqs+0x4c/0x4e0
> [    8.055954][    T1]  virtscsi_init+0x8db/0xd00
> [    8.055954][    T1]  ? __pfx_virtscsi_init+0x10/0x10
> [    8.055954][    T1]  ? __pfx_default_calc_sets+0x10/0x10
> [    8.055954][    T1]  ? scsi_host_alloc+0xa57/0xea0
> [    8.055954][    T1]  ? vp_get+0xfd/0x140
> [    8.055954][    T1]  virtscsi_probe+0x3ea/0xf60
> [    8.055954][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
> [    8.055954][    T1]  ? kernfs_add_one+0x156/0x8b0
> [    8.055954][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
> [    8.055954][    T1]  ? virtio_features_ok+0x10c/0x270
> [    8.055954][    T1]  virtio_dev_probe+0x991/0xaf0
> [    8.055954][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
> [    8.055954][    T1]  really_probe+0x2b8/0xad0
> [    8.055954][    T1]  __driver_probe_device+0x1a2/0x390
> [    8.055954][    T1]  driver_probe_device+0x50/0x430
> [    8.055954][    T1]  __driver_attach+0x45f/0x710
> [    8.055954][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    8.055954][    T1]  bus_for_each_dev+0x239/0x2b0
> [    8.055954][    T1]  ? __pfx___driver_attach+0x10/0x10
> [    8.055954][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
> [    8.055954][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
> [    8.055954][    T1]  bus_add_driver+0x347/0x620
> [    8.055954][    T1]  driver_register+0x23a/0x320
> [    8.055954][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    8.055954][    T1]  virtio_scsi_init+0x65/0xe0
> [    8.055954][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    8.055954][    T1]  do_one_initcall+0x248/0x880
> [    8.055954][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
> [    8.055954][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> [    8.105903][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
> [    8.105903][    T1]  ? __pfx_parse_args+0x10/0x10
> [    8.105903][    T1]  ? do_initcalls+0x1c/0x80
> [    8.105903][    T1]  ? rcu_is_watching+0x15/0xb0
> [    8.105903][    T1]  do_initcall_level+0x157/0x210
> [    8.105903][    T1]  do_initcalls+0x3f/0x80
> [    8.105903][    T1]  kernel_init_freeable+0x435/0x5d0
> [    8.105903][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    8.105903][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
> [    8.105903][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    8.105903][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    8.105903][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    8.105903][    T1]  kernel_init+0x1d/0x2b0
> [    8.105903][    T1]  ret_from_fork+0x4b/0x80
> [    8.105903][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    8.105903][    T1]  ret_from_fork_asm+0x1a/0x30
> [    8.105903][    T1]  </TASK>
> [    8.105903][    T1] Kernel Offset: disabled
> [    8.105903][    T1] Rebooting in 86400 seconds..
>
>
> syzkaller build log:
> go env (err=3D<nil>)
> GO111MODULE=3D'auto'
> GOARCH=3D'amd64'
> GOBIN=3D''
> GOCACHE=3D'/syzkaller/.cache/go-build'
> GOENV=3D'/syzkaller/.config/go/env'
> GOEXE=3D''
> GOEXPERIMENT=3D''
> GOFLAGS=3D''
> GOHOSTARCH=3D'amd64'
> GOHOSTOS=3D'linux'
> GOINSECURE=3D''
> GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
> GONOPROXY=3D''
> GONOSUMDB=3D''
> GOOS=3D'linux'
> GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
> GOPRIVATE=3D''
> GOPROXY=3D'https://proxy.golang.org,direct'
> GOROOT=3D'/usr/local/go'
> GOSUMDB=3D'sum.golang.org'
> GOTMPDIR=3D''
> GOTOOLCHAIN=3D'auto'
> GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
> GOVCS=3D''
> GOVERSION=3D'go1.21.4'
> GCCGO=3D'gccgo'
> GOAMD64=3D'v1'
> AR=3D'ar'
> CC=3D'gcc'
> CXX=3D'g++'
> CGO_ENABLED=3D'1'
> GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/g=
o.mod'
> GOWORK=3D''
> CGO_CFLAGS=3D'-O2 -g'
> CGO_CPPFLAGS=3D''
> CGO_CXXFLAGS=3D'-O2 -g'
> CGO_FFLAGS=3D'-O2 -g'
> CGO_LDFLAGS=3D'-O2 -g'
> PKG_CONFIG=3D'pkg-config'
> GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=
=3D0 -ffile-prefix-map=3D/tmp/go-build1668308411=3D/tmp/go-build -gno-recor=
d-gcc-switches'
>
> git status (err=3D<nil>)
> HEAD detached at 56086b24b
> nothing to commit, working tree clean
>
>
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:31: run command via tools/syz-env for best compatibility, see:
> Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contrib=
uting.md#using-syz-env
> go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./=
sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:31: run command via tools/syz-env for best compatibility, see:
> Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contrib=
uting.md#using-syz-env
> bin/syz-sysgen
> touch .descriptions
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzz=
er github.com/google/syzkaller/syz-fuzzer
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-exec=
prog github.com/google/syzkaller/tools/syz-execprog
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stre=
ss github.com/google/syzkaller/tools/syz-stress
> mkdir -p ./bin/linux_amd64
> gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
>         -m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-vari=
able -Wframe-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -=
Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-a=
rgument -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
>         -DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"56086b24bdfd822d3b227edb3=
064db443cd8c971\"
>
>
> Error text is too large and was truncated, full error text is at:
> https://syzkaller.appspot.com/x/error.txt?x=3D122f8f97180000
>
>
> Tested on:
>
> commit:         a4170c00 fsnotify: do not handle events on a shutting ..
> git tree:       https://github.com/amir73il/linux fsnotify-fixes
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9995779c8305f=
57e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67b45f1=
6d4e6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Note: no patches were applied.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000774dfe0615e71b29%40google.com.

