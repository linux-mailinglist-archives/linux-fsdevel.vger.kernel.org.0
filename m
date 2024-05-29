Return-Path: <linux-fsdevel+bounces-20432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D88D35C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89331F22E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1E1802DE;
	Wed, 29 May 2024 11:48:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8613DDAE
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983284; cv=none; b=GPQv16BFyIBq/PywHC6mrbi1URz2TJ64lPM/5PvlB5kT420rXMFNz6Rrcn07LvTkUcDH/um1ZS26yWp27DLhk0EekgJYsqQYpJOcCJphms+FJPseWz/VZsUxqkqTAWLOOsNuMe/+1Y3WKg3m7GLJlZq/ZGGTw/f/xCRkIWtraI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983284; c=relaxed/simple;
	bh=tJI7W6PBiymQn7VUzsTFy3GXjIpWqqV3HphE4UEyXLM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A4Rc8Z+JVHWy6MJBoVfDVPHRm+UDZTxSfo43EyniICaCgo3Ik458iv+3BwoMccFUYwV3H4XRHz7sb8a0H9GIy762flsKqwy8jnpBofht3ZI9qmx50OymhbAiR/meSrEWHKV7xSeh+q5lq3B2mPvEw3mfPJs6DZEsC0bEXs2z9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3744edd84b1so20333495ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 04:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716983281; x=1717588081;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7que1wCcQSg2LMiw0l1rpP/+1+zrMnwXWbUoNws8Zak=;
        b=kCkm1BbKGUKevPGEmbs5tjZheSl6fbFCZSBcmXr/qGYO9WkuanFIzjNU54T0axUNZE
         uokn7UXqqz/5dAd162277FgtiB5hanzXtqj0efX4yjSSKFEheaSUax2XWwfB1Rw/yVjK
         AeFieLyphHOhK75+jM0onK9IcQKiU0cWW+IVOIhvYm0SDXhVIiXrAqkjhoauRlJydj7n
         8VwEbcCFPXnikL2qrppw5MbVsDD60+TFhrvJ5mTi1Tnx4Gq2ReEJEMAJkMHIdHcSKfth
         ZVJAeG+hV2JjpwZulkJSJn02Dea3HkRqCbac1Fq7ujU2nW8GSSKrJt3Yu9BGnAFKVQDy
         xpSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9x1TnvEvju2RXb5+B/LRrsNVGI9B2+fHbqoWe4+Cizcl+mDBs1xdLcdJ7FOdaKd1IqW1HlrJvx3OrcHAdTuKeXUP6a/E0oDZZEjV0Eg==
X-Gm-Message-State: AOJu0YxhCv+vEDnMzQnzbneG9ExiklohSno58rw+htZSRrzozz3HH99R
	1pCUu7fP4deueIeID2fOaw3AshyM2p46TvqZlbN/laVidqmC1NVOITSXsHoV5w8GqIJ6nmQf/MU
	796rG0VsU0Wz4xfqGigRRC4xFKaI2Va9tZEsyc+ZR6h18KGnGybHvSeA=
X-Google-Smtp-Source: AGHT+IGV3pkoeHq2JLojbo7MaYprtJGxEmcl7RRlayhH/M3kW4v5OUCXHAXiDd8NFtiIotxOrYmhhxSVXNADfuHSqkFJ75s/u8Cr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:374:598b:3fec with SMTP id
 e9e14a558f8ab-374598b4269mr5048615ab.5.1716983281767; Wed, 29 May 2024
 04:48:01 -0700 (PDT)
Date: Wed, 29 May 2024 04:48:01 -0700
In-Reply-To: <1f177444-0613-4843-98fe-bcdca2538a07@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098718506199652db@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in sanity_check_extent_cache
From: syzbot <syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

42][    T1] usbcore: registered new interface driver dln2
[    7.576709][    T1] usbcore: registered new interface driver pn533_usb
[    7.583988][    T1] nfcsim 0.2 initialized
[    7.586139][    T1] usbcore: registered new interface driver port100
[    7.587701][    T1] usbcore: registered new interface driver nfcmrvl
[    7.594256][    T1] Loading iSCSI transport class v2.0-870.
[    7.612218][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.621827][    T1] ------------[ cut here ]------------
[    7.622778][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.626782][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.628293][    T1] Modules linked in:
[    7.628860][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00060-g889914b5c209 #0
[    7.630401][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    7.632495][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.634119][    T1] Code: b2 00 00 00 e8 67 52 f2 fc 5b 5d c3 cc cc cc c=
c e8 5b 52 f2 fc c6 05 51 cc ce 0a 01 90 48 c7 c7 a0 54 fe 8b e8 b7 d0 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 3b 52 f2 fc c6 05 2e cc ce 0a 01 90 48 c7 c7
[    7.638094][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.639044][    T1] RAX: 343580cc97689700 RBX: ffff8881401bf06c RCX: fff=
f8880166c8000
[    7.640552][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.642175][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    7.643575][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000501cdc0
[    7.645089][    T1] R13: ffffea000501cdc8 R14: 1ffffd4000a039b9 R15: 000=
0000000000000
[    7.646458][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.647850][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.648816][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    7.650069][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.651660][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.653255][    T1] Call Trace:
[    7.653955][    T1]  <TASK>
[    7.655231][    T1]  ? __warn+0x163/0x4e0
[    7.656060][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.657004][    T1]  ? report_bug+0x2b3/0x500
[    7.657697][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.658659][    T1]  ? handle_bug+0x3e/0x70
[    7.659735][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.660993][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.661819][    T1]  ? __warn_printk+0x292/0x360
[    7.662573][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.663589][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.664642][    T1]  __free_pages_ok+0xc54/0xd80
[    7.665381][    T1]  make_alloc_exact+0xa3/0xf0
[    7.666771][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.667714][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.668766][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.669540][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.670758][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.671577][    T1]  ? really_probe+0x2b8/0xad0
[    7.672570][    T1]  ? driver_probe_device+0x50/0x430
[    7.673427][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.674713][    T1]  ? ret_from_fork+0x4b/0x80
[    7.675577][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.676513][    T1]  vring_create_virtqueue+0xca/0x110
[    7.677483][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.678536][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.679645][    T1]  setup_vq+0xe9/0x2d0
[    7.680389][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.681211][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.682323][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.683391][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.684728][    T1]  vp_setup_vq+0xbf/0x330
[    7.685412][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.686599][    T1]  ? ioread16+0x2f/0x90
[    7.687219][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.688543][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.689396][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.690066][    T1]  virtscsi_init+0x8db/0xd00
[    7.690768][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.691800][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.692645][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.693496][    T1]  ? vp_get+0xfd/0x140
[    7.694109][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.695276][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.696256][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.697276][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.698400][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.699300][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.700143][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.700985][    T1]  really_probe+0x2b8/0xad0
[    7.702196][    T1]  __driver_probe_device+0x1a2/0x390
[    7.703259][    T1]  driver_probe_device+0x50/0x430
[    7.704075][    T1]  __driver_attach+0x45f/0x710
[    7.704819][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.705601][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.706514][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.707442][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.708680][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.710058][    T1]  bus_add_driver+0x347/0x620
[    7.711073][    T1]  driver_register+0x23a/0x320
[    7.712178][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.713450][    T1]  virtio_scsi_init+0x65/0xe0
[    7.714571][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.715692][    T1]  do_one_initcall+0x248/0x880
[    7.716533][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.717409][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.718599][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.719639][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.720523][    T1]  ? do_initcalls+0x1c/0x80
[    7.721261][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.722428][    T1]  do_initcall_level+0x157/0x210
[    7.723278][    T1]  do_initcalls+0x3f/0x80
[    7.723962][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.725035][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.726103][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.727205][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.728033][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.729046][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.729731][    T1]  kernel_init+0x1d/0x2b0
[    7.730411][    T1]  ret_from_fork+0x4b/0x80
[    7.731117][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.731836][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.732580][    T1]  </TASK>
[    7.733103][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.734198][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00060-g889914b5c209 #0
[    7.734971][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    7.734971][    T1] Call Trace:
[    7.734971][    T1]  <TASK>
[    7.734971][    T1]  dump_stack_lvl+0x241/0x360
[    7.734971][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.734971][    T1]  ? __pfx__printk+0x10/0x10
[    7.734971][    T1]  ? _printk+0xd5/0x120
[    7.734971][    T1]  ? vscnprintf+0x5d/0x90
[    7.734971][    T1]  panic+0x349/0x860
[    7.734971][    T1]  ? __warn+0x172/0x4e0
[    7.734971][    T1]  ? __pfx_panic+0x10/0x10
[    7.734971][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.734971][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.734971][    T1]  __warn+0x346/0x4e0
[    7.734971][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.734971][    T1]  report_bug+0x2b3/0x500
[    7.734971][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.734971][    T1]  handle_bug+0x3e/0x70
[    7.734971][    T1]  exc_invalid_op+0x1a/0x50
[    7.734971][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.734971][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.734971][    T1] Code: b2 00 00 00 e8 67 52 f2 fc 5b 5d c3 cc cc cc c=
c e8 5b 52 f2 fc c6 05 51 cc ce 0a 01 90 48 c7 c7 a0 54 fe 8b e8 b7 d0 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 3b 52 f2 fc c6 05 2e cc ce 0a 01 90 48 c7 c7
[    7.734971][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.734971][    T1] RAX: 343580cc97689700 RBX: ffff8881401bf06c RCX: fff=
f8880166c8000
[    7.734971][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.734971][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    7.734971][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000501cdc0
[    7.734971][    T1] R13: ffffea000501cdc8 R14: 1ffffd4000a039b9 R15: 000=
0000000000000
[    7.734971][    T1]  ? __warn_printk+0x292/0x360
[    7.734971][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.734971][    T1]  __free_pages_ok+0xc54/0xd80
[    7.734971][    T1]  make_alloc_exact+0xa3/0xf0
[    7.734971][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.734971][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.734971][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.734971][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.734971][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.734971][    T1]  ? really_probe+0x2b8/0xad0
[    7.734971][    T1]  ? driver_probe_device+0x50/0x430
[    7.734971][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.734971][    T1]  ? ret_from_fork+0x4b/0x80
[    7.734971][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.734971][    T1]  vring_create_virtqueue+0xca/0x110
[    7.734971][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.734971][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.734971][    T1]  setup_vq+0xe9/0x2d0
[    7.734971][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.734971][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.784590][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.784590][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.784590][    T1]  vp_setup_vq+0xbf/0x330
[    7.784590][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.784590][    T1]  ? ioread16+0x2f/0x90
[    7.784590][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.784590][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.784590][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.784590][    T1]  virtscsi_init+0x8db/0xd00
[    7.784590][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.784590][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.784590][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.784590][    T1]  ? vp_get+0xfd/0x140
[    7.784590][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.784590][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.784590][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.784590][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.784590][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.784590][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.784590][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.784590][    T1]  really_probe+0x2b8/0xad0
[    7.784590][    T1]  __driver_probe_device+0x1a2/0x390
[    7.784590][    T1]  driver_probe_device+0x50/0x430
[    7.784590][    T1]  __driver_attach+0x45f/0x710
[    7.784590][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.784590][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.784590][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.784590][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.784590][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.784590][    T1]  bus_add_driver+0x347/0x620
[    7.784590][    T1]  driver_register+0x23a/0x320
[    7.784590][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.784590][    T1]  virtio_scsi_init+0x65/0xe0
[    7.784590][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.784590][    T1]  do_one_initcall+0x248/0x880
[    7.784590][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.784590][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.784590][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.784590][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.784590][    T1]  ? do_initcalls+0x1c/0x80
[    7.784590][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.784590][    T1]  do_initcall_level+0x157/0x210
[    7.784590][    T1]  do_initcalls+0x3f/0x80
[    7.784590][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.784590][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.784590][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.784590][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.784590][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.784590][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.784590][    T1]  kernel_init+0x1d/0x2b0
[    7.784590][    T1]  ret_from_fork+0x4b/0x80
[    7.784590][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.784590][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.834581][    T1]  </TASK>
[    7.834581][    T1] Kernel Offset: disabled
[    7.834581][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build686088701=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 610f2a54d
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D610f2a54d02f8cf4f2454c03bf679b602e6e59b6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240503-155746'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D610f2a54d02f8cf4f2454c03bf679b602e6e59b6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240503-155746'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D610f2a54d02f8cf4f2454c03bf679b602e6e59b6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240503-155746'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Ivendor -O2 -pthread -Wall -Werror -Wparentheses -W=
unused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-overflow -W=
no-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unus=
ed-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOA=
RCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"610f2a54d02f8cf4f2454c03bf679b602e=
6e59b6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1233c3ec980000


Tested on:

commit:         889914b5 f2fs: fix to cover read extent cache access w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.=
git wip
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ace29459a0a191=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D74ebe2104433e9dc6=
10d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

