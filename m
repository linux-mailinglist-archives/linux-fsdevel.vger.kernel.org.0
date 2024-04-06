Return-Path: <linux-fsdevel+bounces-16262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1889A972
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33048B21E9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C0225CF;
	Sat,  6 Apr 2024 07:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F72206E
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387107; cv=none; b=W6IMFJQMMAGQX9CWmnWmciWDoyqTOd/+BPhdb1y6PsDGgpRqn20I/fN+N6hD3Gd5dm+5kM1QdgTSc7MAV6x5ZoqLh7JmfgwXzKj5zHzua5p7gvhRuzOiEop+FT8sNuRJQcLPGfpUrMD9KbXnocbvamKWn88Qnbe+orqMOR/e4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387107; c=relaxed/simple;
	bh=VhfaIZy08qkQ8PYcznUhnR3YvLYrKUw3bfbVJeQ9kZY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u1i+jlAG4DyVk18x8tZkqz3nVtHK2VkLFsvmGXe7zp0djD6brmoeLKUtLtRmNDcviQNItr66xN0tlB0CDvsO7ZalN6DKtqtjvyXodaZ5Vjqr1r3xhy5hSB8z5Lm/lSQ7OZxCZg8BUpw9zCv0L3ib/y4Ip/JpvGqOEx3bAB5Pvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368185c12d7so26291625ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Apr 2024 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712387104; x=1712991904;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwcDjFua0ycpkiWBU498WgcSuxdRT+0eyLfOaXXWwk8=;
        b=nHfJJ8NMojZyg0I+jAkcK/xkn+RyFgsnjPkrXeBX9kW4+383CSZj7Rg1SFpRWEc5P3
         O9lMpdPs8FFX6/dOS6lvryfhEM13+a/nzC9+FdnwokvjZtE87daYwrwz4fNcLaZhICcM
         0VkjFIv2I+yeW7Jv+ADDJ0qbcsX2bMRvw1dN7s/NdlAcOd77p/CVKeLvwdEsclggWua8
         3Wtwza5ZK5R5ao/helorRGJu9DkeqcJLONRT6l5bkODl0Pn+VxqOIB0C0kTCsHvEcLi1
         MUEE56zcsFp38iBa1eZUMMw8YU7AE/pPPZtgwZJqoPSYeGlU211NzNaV0PA/516iD4rR
         otBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAEn9GIXpPaU4tO4tzAcxsCrqi2qWG6rsj8HRhoGxpuqvsqHKho3K9GzIE2PHnDT4SXL2rTgUpFEkbCglmYSuSSaE02ode4uyWtyGHXQ==
X-Gm-Message-State: AOJu0YwA9PYMLc6pVAwpnCQ4rWgJ3ze8S30+pdrpdiyp87ijyoqtRG7V
	jqFsiH99Spu7mOGHDsIGl4UtDT8osCkcOY4gnsR2sgp6ULYfbltlwMdD5h+4TfoyYTYIGe77j3o
	ApMExVvM5wo8c9XwbO17aKAl8yfiotRww/bfn5OUMn/DpwabhzhkiYFc=
X-Google-Smtp-Source: AGHT+IFr1oEOe7sOwP3cZk5IlvuX6DKPCbyHKxyVfYMSByGDuLIE52Bag/2ApLVTXogTKugLSKtAi6QavzQVfj9zMrsEAz9VK2fe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3108:b0:366:1f71:1f69 with SMTP id
 bg8-20020a056e02310800b003661f711f69mr232095ilb.2.1712387104203; Sat, 06 Apr
 2024 00:05:04 -0700 (PDT)
Date: Sat, 06 Apr 2024 00:05:04 -0700
In-Reply-To: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000107743061568319c@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, gregkh@linuxfoundation.org, 
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, valesini@yandex-team.ru, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

viperboard
[    8.566509][    T1] usbcore: registered new interface driver dln2
[    8.568801][    T1] usbcore: registered new interface driver pn533_usb
[    8.579446][    T1] nfcsim 0.2 initialized
[    8.581035][    T1] usbcore: registered new interface driver port100
[    8.583546][    T1] usbcore: registered new interface driver nfcmrvl
[    8.595440][    T1] Loading iSCSI transport class v2.0-870.
[    8.614503][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.624792][    T1] ------------[ cut here ]------------
[    8.626075][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.627319][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.629053][    T1] Modules linked in:
[    8.629654][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00388-g3398bf34c993 #0
[    8.631954][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.634054][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.635268][    T1] Code: b2 00 00 00 e8 d7 93 f0 fc 5b 5d c3 cc cc cc c=
c e8 cb 93 f0 fc c6 05 ae 5c ee 0a 01 90 48 c7 c7 40 80 1e 8c e8 e7 2e b3 f=
c 90 <0f> 0b 90 90 eb d9 e8 ab 93 f0 fc c6 05 8b 5c ee 0a 01 90 48 c7 c7
[    8.638923][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.639822][    T1] RAX: 9b6fe4ff1df42a00 RBX: ffff888021006ccc RCX: fff=
f888016ac0000
[    8.641085][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.642968][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    8.645656][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000502fdc0
[    8.646945][    T1] R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 000=
0000000000000
[    8.648121][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.650496][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.652023][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    8.653935][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.655934][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.657851][    T1] Call Trace:
[    8.658338][    T1]  <TASK>
[    8.658807][    T1]  ? __warn+0x163/0x4e0
[    8.659517][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.660549][    T1]  ? report_bug+0x2b3/0x500
[    8.661574][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.663372][    T1]  ? handle_bug+0x3e/0x70
[    8.664928][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.666599][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.668117][    T1]  ? __warn_printk+0x292/0x360
[    8.670085][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.671620][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.673520][    T1]  __free_pages_ok+0xc54/0xd80
[    8.675020][    T1]  make_alloc_exact+0xa3/0xf0
[    8.676151][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.677685][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.678762][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.679763][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.681408][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.683147][    T1]  ? really_probe+0x2b8/0xad0
[    8.684759][    T1]  ? driver_probe_device+0x50/0x430
[    8.685967][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.687403][    T1]  ? ret_from_fork+0x4b/0x80
[    8.688676][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.690045][    T1]  vring_create_virtqueue+0xca/0x110
[    8.691014][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.692612][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.693924][    T1]  setup_vq+0xe9/0x2d0
[    8.695355][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.696851][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.699030][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.700639][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.702131][    T1]  vp_setup_vq+0xbf/0x330
[    8.703279][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.704850][    T1]  ? ioread16+0x2f/0x90
[    8.706423][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.707372][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.708975][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.709918][    T1]  virtscsi_init+0x8db/0xd00
[    8.710723][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.711813][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.713608][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.714998][    T1]  ? vp_get+0xfd/0x140
[    8.715786][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.716933][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.718052][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.719084][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.719983][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.721406][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.722392][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.723354][    T1]  really_probe+0x2b8/0xad0
[    8.725227][    T1]  __driver_probe_device+0x1a2/0x390
[    8.726307][    T1]  driver_probe_device+0x50/0x430
[    8.727156][    T1]  __driver_attach+0x45f/0x710
[    8.727968][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.728999][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.730291][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.731396][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.732523][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.733601][    T1]  bus_add_driver+0x347/0x620
[    8.734733][    T1]  driver_register+0x23a/0x320
[    8.735723][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.736859][    T1]  virtio_scsi_init+0x65/0xe0
[    8.737729][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.739109][    T1]  do_one_initcall+0x248/0x880
[    8.740693][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.742428][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.745322][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    8.746957][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.748064][    T1]  ? do_initcalls+0x1c/0x80
[    8.749434][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.750232][    T1]  do_initcall_level+0x157/0x210
[    8.751547][    T1]  do_initcalls+0x3f/0x80
[    8.752397][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.754091][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.755229][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.757834][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.759572][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.761202][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.762156][    T1]  kernel_init+0x1d/0x2b0
[    8.763250][    T1]  ret_from_fork+0x4b/0x80
[    8.764029][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.765039][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.766178][    T1]  </TASK>
[    8.766835][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.768906][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00388-g3398bf34c993 #0
[    8.770531][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.772129][    T1] Call Trace:
[    8.772129][    T1]  <TASK>
[    8.772129][    T1]  dump_stack_lvl+0x241/0x360
[    8.772129][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.772129][    T1]  ? __pfx__printk+0x10/0x10
[    8.772129][    T1]  ? _printk+0xd5/0x120
[    8.772129][    T1]  ? vscnprintf+0x5d/0x90
[    8.772129][    T1]  panic+0x349/0x860
[    8.772129][    T1]  ? __warn+0x172/0x4e0
[    8.772129][    T1]  ? __pfx_panic+0x10/0x10
[    8.772129][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.781563][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.781563][    T1]  __warn+0x346/0x4e0
[    8.781563][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.781563][    T1]  report_bug+0x2b3/0x500
[    8.781563][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.781563][    T1]  handle_bug+0x3e/0x70
[    8.781563][    T1]  exc_invalid_op+0x1a/0x50
[    8.781563][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.781563][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.791455][    T1] Code: b2 00 00 00 e8 d7 93 f0 fc 5b 5d c3 cc cc cc c=
c e8 cb 93 f0 fc c6 05 ae 5c ee 0a 01 90 48 c7 c7 40 80 1e 8c e8 e7 2e b3 f=
c 90 <0f> 0b 90 90 eb d9 e8 ab 93 f0 fc c6 05 8b 5c ee 0a 01 90 48 c7 c7
[    8.791455][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.791455][    T1] RAX: 9b6fe4ff1df42a00 RBX: ffff888021006ccc RCX: fff=
f888016ac0000
[    8.791455][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.791455][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    8.801572][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000502fdc0
[    8.801572][    T1] R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 000=
0000000000000
[    8.801572][    T1]  ? __warn_printk+0x292/0x360
[    8.801572][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.801572][    T1]  __free_pages_ok+0xc54/0xd80
[    8.801572][    T1]  make_alloc_exact+0xa3/0xf0
[    8.801572][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.801572][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.811433][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.811433][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.811433][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.811433][    T1]  ? really_probe+0x2b8/0xad0
[    8.811433][    T1]  ? driver_probe_device+0x50/0x430
[    8.811433][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.811433][    T1]  ? ret_from_fork+0x4b/0x80
[    8.811433][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.811433][    T1]  vring_create_virtqueue+0xca/0x110
[    8.821568][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.821568][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.821568][    T1]  setup_vq+0xe9/0x2d0
[    8.821568][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.821568][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.821568][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.821568][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.821568][    T1]  vp_setup_vq+0xbf/0x330
[    8.831450][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.831450][    T1]  ? ioread16+0x2f/0x90
[    8.831450][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.831450][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.831450][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.831450][    T1]  virtscsi_init+0x8db/0xd00
[    8.831450][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.831450][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.831450][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.831450][    T1]  ? vp_get+0xfd/0x140
[    8.831450][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.841557][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.841557][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.841557][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.841557][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.841557][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.841557][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.841557][    T1]  really_probe+0x2b8/0xad0
[    8.841557][    T1]  __driver_probe_device+0x1a2/0x390
[    8.841557][    T1]  driver_probe_device+0x50/0x430
[    8.841557][    T1]  __driver_attach+0x45f/0x710
[    8.851437][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.851437][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.851437][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.851437][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.851437][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.851437][    T1]  bus_add_driver+0x347/0x620
[    8.851437][    T1]  driver_register+0x23a/0x320
[    8.851437][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.851437][    T1]  virtio_scsi_init+0x65/0xe0
[    8.851437][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.851437][    T1]  do_one_initcall+0x248/0x880
[    8.861551][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.861551][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.861551][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    8.861551][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.861551][    T1]  ? do_initcalls+0x1c/0x80
[    8.861551][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.861551][    T1]  do_initcall_level+0x157/0x210
[    8.861551][    T1]  do_initcalls+0x3f/0x80
[    8.861551][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.871429][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.871429][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.871429][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.871429][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.871429][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.871429][    T1]  kernel_init+0x1d/0x2b0
[    8.871429][    T1]  ret_from_fork+0x4b/0x80
[    8.871429][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.871429][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.871429][    T1]  </TASK>
[    8.871429][    T1] Kernel Offset: disabled
[    8.871429][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3147238964=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 51c4dcff8
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
/syzkaller/prog.GitRevision=3D51c4dcff83b0574620c280cc5130ef59cc4a2e32 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240403-123700'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D51c4dcff83b0574620c280cc5130ef59cc4a2e32 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240403-123700'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D51c4dcff83b0574620c280cc5130ef59cc4a2e32 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240403-123700'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"51c4dcff83b0574620c280cc5130ef59cc=
4a2e32\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16a356f6180000


Tested on:

commit:         3398bf34 kernfs: annotate different lockdep class for ..
git tree:       https://github.com/amir73il/linux/ vfs-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc5cda112a843805=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8b1bfb238=
b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

