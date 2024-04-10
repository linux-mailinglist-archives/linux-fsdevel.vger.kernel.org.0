Return-Path: <linux-fsdevel+bounces-16523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0089E99F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 07:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C352A1F2310B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899B14AA3;
	Wed, 10 Apr 2024 05:19:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E81125AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726344; cv=none; b=mF/UQRP/ckMPDaiy9lH16xvqeGZEFr6If1APvXIYJ5Kg+ajk/PdN2fvg1V+NTesvMewtQBrQK/G0fmj6A179IA4DoUHdqgrzF3t7V+4mEgi4rtf6FLFHWVE7IMnPE0F6VWbdj1KEaqCpLAu8gFplLBoffwDJr5isG8xb7m3t1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726344; c=relaxed/simple;
	bh=cQZimYwevNJAkIQSGjQb7G+Nnt/jzO9PqGElQ+a/T4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bPyZCJ77pDqFIMgtEstXt32uYMsICzXPuEV2Thyyyw7yTty8r6PBbZAoTZwQ1mxS74mCqPUTGC9vTwLY2r7CzDNyKl04YSRwRFQ+HiZBJ2MWlnwE3dJi6e+yEC7tVfo7GW4/94puI+uzHS0cI/hnpX9edB23MYKh0RoOrJ0bhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a179df9fdso40674945ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 22:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726342; x=1713331142;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW/rWKUZySv/3ojdJiq8kb1g4EtY5k0JGAdJpiXserk=;
        b=qEa4TerGAUIx7i6OzK2qAzmioNglM4amU9KHbnOseu3avMQKhhqrmELBm+MJV5rvyq
         3nIn5Uv+OVFiS6nmPlmbcLcuTTOJ8V7U/K8zN5Ts5TuKVoewNJC2hzHiKnYlTevdugak
         Nl+Zdy0QbM8Qdn0axoBNNJg5fCaW6K+UWCoz5E+ol6DIEWuLO2OVFFpSQtTVXidez4JC
         KNHO8sEmbSA8/daL9Xk+k4RkM6T/jF5zGwQnDIJsM/8LnsvJGmaQ83odd+F80qSup+84
         RHUNvsUEKD5S4O8yN5rvBPMOq/piv0h+DoQ769PiBaAPwrTIMUqykYz4GMooTvS2KUMO
         itEw==
X-Forwarded-Encrypted: i=1; AJvYcCVdXuQSvfWjtgSssRqePvFO1Nm7v9d6yhYjDvUtvLfjsknvhywASQ+TTjpVBV+fnNKEOys21509RJS8tqtgAF754YW0Ez+Uqydyd/PL1w==
X-Gm-Message-State: AOJu0YyUM1iFXFCxNb5pXO28Q32/8WxChUWx51je78oZa/R3iDIpDEuj
	uQq9cItNo1FKWQEX9otX46tC5KNYWX8JS3c9Ehx7tx7tkZEpp9DMVKTmnaYUanaM03UZX2x8iu7
	ulbsN3lwi4ppGcC941J2Rgp3OUcRoREXNZT4DvILdFpuw6Vpgo6va1iE=
X-Google-Smtp-Source: AGHT+IF4/g69lYp6nKSnpVSqQ9XAYqwyrIcX7muYfZNRsPaOd8C4CFfg20nXgkxot2rNZ8hkZ0YH01goaQ5i8gS/5Nl7/AnVlVD4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:369:f7ca:a361 with SMTP id
 l13-20020a056e021aad00b00369f7caa361mr97775ilv.1.1712726341935; Tue, 09 Apr
 2024 22:19:01 -0700 (PDT)
Date: Tue, 09 Apr 2024 22:19:01 -0700
In-Reply-To: <8b9e2dc7-adef-4a2a-8284-f4885d3361bb@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035775f0615b72d01@google.com>
Subject: Re: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible
 code in z_erofs_get_gbuf
From: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, hsiangkao@linux.alibaba.com, 
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

rd
[    7.642260][    T1] usbcore: registered new interface driver dln2
[    7.645615][    T1] usbcore: registered new interface driver pn533_usb
[    7.653071][    T1] nfcsim 0.2 initialized
[    7.654695][    T1] usbcore: registered new interface driver port100
[    7.656867][    T1] usbcore: registered new interface driver nfcmrvl
[    7.665132][    T1] Loading iSCSI transport class v2.0-870.
[    7.683597][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.695844][    T1] ------------[ cut here ]------------
[    7.697288][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.699005][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.701375][    T1] Modules linked in:
[    7.702534][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00004-g38bac6fb80a8 #0
[    7.704651][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.706586][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.707973][    T1] Code: b2 00 00 00 e8 07 c9 e9 fc 5b 5d c3 cc cc cc c=
c e8 fb c8 e9 fc c6 05 11 fa e7 0a 01 90 48 c7 c7 20 37 1f 8c e8 07 64 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 db c8 e9 fc c6 05 ee f9 e7 0a 01 90 48 c7 c7
[    7.711681][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.713246][    T1] RAX: 80ca843c79c95400 RBX: ffff888020c7401c RCX: fff=
f8880166d0000
[    7.715799][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.718268][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    7.720624][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea0000843dc0
[    7.722734][    T1] R13: ffffea0000843dc8 R14: 1ffffd40001087b9 R15: 000=
0000000000000
[    7.725099][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.726800][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.728599][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.731733][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.733755][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.736386][    T1] Call Trace:
[    7.737123][    T1]  <TASK>
[    7.738006][    T1]  ? __warn+0x163/0x4e0
[    7.740239][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.741359][    T1]  ? report_bug+0x2b3/0x500
[    7.742315][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.744221][    T1]  ? handle_bug+0x3e/0x70
[    7.745585][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.746621][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.747841][    T1]  ? __warn_printk+0x292/0x360
[    7.749317][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.751175][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.753784][    T1]  __free_pages_ok+0xc60/0xd90
[    7.755034][    T1]  make_alloc_exact+0xa3/0xf0
[    7.756224][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.757834][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.758900][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.759818][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.761405][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.763004][    T1]  ? really_probe+0x2b8/0xad0
[    7.764204][    T1]  ? driver_probe_device+0x50/0x430
[    7.765429][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.766771][    T1]  ? ret_from_fork+0x4b/0x80
[    7.767981][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.769915][    T1]  vring_create_virtqueue+0xca/0x110
[    7.771623][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.773424][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.775021][    T1]  setup_vq+0xe9/0x2d0
[    7.775787][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.776793][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.778866][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.780614][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.782273][    T1]  vp_setup_vq+0xbf/0x330
[    7.783410][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.784986][    T1]  ? ioread16+0x2f/0x90
[    7.786652][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.788199][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.789141][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.790440][    T1]  virtscsi_init+0x8db/0xd00
[    7.791488][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.792682][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.794430][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.795521][    T1]  ? vp_get+0xfd/0x140
[    7.796236][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.797138][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.798431][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.800087][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.800985][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.801835][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.804175][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.805887][    T1]  really_probe+0x2b8/0xad0
[    7.807150][    T1]  __driver_probe_device+0x1a2/0x390
[    7.808227][    T1]  driver_probe_device+0x50/0x430
[    7.809376][    T1]  __driver_attach+0x45f/0x710
[    7.810502][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.811607][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.812602][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.813726][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.814800][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.816656][    T1]  bus_add_driver+0x347/0x620
[    7.817772][    T1]  driver_register+0x23a/0x320
[    7.818808][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.819842][    T1]  virtio_scsi_init+0x65/0xe0
[    7.820896][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.822020][    T1]  do_one_initcall+0x248/0x880
[    7.822891][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.823925][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.825313][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.826394][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.827532][    T1]  ? do_initcalls+0x1c/0x80
[    7.828853][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.830432][    T1]  do_initcall_level+0x157/0x210
[    7.831313][    T1]  do_initcalls+0x3f/0x80
[    7.832573][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.833476][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.834461][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.836095][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.837265][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.838679][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.839592][    T1]  kernel_init+0x1d/0x2b0
[    7.840621][    T1]  ret_from_fork+0x4b/0x80
[    7.841417][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.842402][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.843630][    T1]  </TASK>
[    7.844181][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.845673][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00004-g38bac6fb80a8 #0
[    7.847124][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.848661][    T1] Call Trace:
[    7.848661][    T1]  <TASK>
[    7.848661][    T1]  dump_stack_lvl+0x241/0x360
[    7.848661][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.848661][    T1]  ? __pfx__printk+0x10/0x10
[    7.848661][    T1]  ? _printk+0xd5/0x120
[    7.848661][    T1]  ? vscnprintf+0x5d/0x90
[    7.848661][    T1]  panic+0x349/0x860
[    7.848661][    T1]  ? __warn+0x172/0x4e0
[    7.858266][    T1]  ? __pfx_panic+0x10/0x10
[    7.858266][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.858266][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.858266][    T1]  __warn+0x346/0x4e0
[    7.858266][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.858266][    T1]  report_bug+0x2b3/0x500
[    7.858266][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.858266][    T1]  handle_bug+0x3e/0x70
[    7.868191][    T1]  exc_invalid_op+0x1a/0x50
[    7.868191][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.868191][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.868191][    T1] Code: b2 00 00 00 e8 07 c9 e9 fc 5b 5d c3 cc cc cc c=
c e8 fb c8 e9 fc c6 05 11 fa e7 0a 01 90 48 c7 c7 20 37 1f 8c e8 07 64 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 db c8 e9 fc c6 05 ee f9 e7 0a 01 90 48 c7 c7
[    7.868191][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.878283][    T1] RAX: 80ca843c79c95400 RBX: ffff888020c7401c RCX: fff=
f8880166d0000
[    7.878283][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.878283][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    7.878283][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea0000843dc0
[    7.878283][    T1] R13: ffffea0000843dc8 R14: 1ffffd40001087b9 R15: 000=
0000000000000
[    7.878283][    T1]  ? __warn_printk+0x292/0x360
[    7.888190][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.888190][    T1]  __free_pages_ok+0xc60/0xd90
[    7.888190][    T1]  make_alloc_exact+0xa3/0xf0
[    7.888190][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.888190][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.888190][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.888190][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.888190][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.898282][    T1]  ? really_probe+0x2b8/0xad0
[    7.898282][    T1]  ? driver_probe_device+0x50/0x430
[    7.898282][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.898282][    T1]  ? ret_from_fork+0x4b/0x80
[    7.898282][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.898282][    T1]  vring_create_virtqueue+0xca/0x110
[    7.898282][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.898282][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.908146][    T1]  setup_vq+0xe9/0x2d0
[    7.908146][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.908146][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.908146][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.908146][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.908146][    T1]  vp_setup_vq+0xbf/0x330
[    7.908146][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.908146][    T1]  ? ioread16+0x2f/0x90
[    7.908146][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.918266][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.918266][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.918266][    T1]  virtscsi_init+0x8db/0xd00
[    7.918266][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.918266][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.918266][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.918266][    T1]  ? vp_get+0xfd/0x140
[    7.918266][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.918266][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.918266][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.918266][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.928228][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.928228][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.928228][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.928228][    T1]  really_probe+0x2b8/0xad0
[    7.928228][    T1]  __driver_probe_device+0x1a2/0x390
[    7.928228][    T1]  driver_probe_device+0x50/0x430
[    7.928228][    T1]  __driver_attach+0x45f/0x710
[    7.928228][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.928228][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.928228][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.928228][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.938278][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.938278][    T1]  bus_add_driver+0x347/0x620
[    7.938278][    T1]  driver_register+0x23a/0x320
[    7.938278][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.938278][    T1]  virtio_scsi_init+0x65/0xe0
[    7.938278][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.938278][    T1]  do_one_initcall+0x248/0x880
[    7.938278][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.948187][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.948187][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.948187][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.948187][    T1]  ? do_initcalls+0x1c/0x80
[    7.948187][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.948187][    T1]  do_initcall_level+0x157/0x210
[    7.948187][    T1]  do_initcalls+0x3f/0x80
[    7.948187][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.948187][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.948187][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.948187][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.958283][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.958283][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.958283][    T1]  kernel_init+0x1d/0x2b0
[    7.958283][    T1]  ret_from_fork+0x4b/0x80
[    7.958283][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.958283][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.958283][    T1]  </TASK>
[    7.958283][    T1] Kernel Offset: disabled
[    7.958283][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2267282665=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 0ee3535ea
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
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0ee3535ea8ff21d50e44372bb1cfd147e299ab5b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240404-085507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0ee3535ea8ff21d50e44372bb1cfd147e2=
99ab5b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16dbfd89180000


Tested on:

commit:         38bac6fb erofs: add a reserved buffer pool for lz4 dec..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.g=
it dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D51cdcd4a8f33256=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D27cc650ef45b379df=
e5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

