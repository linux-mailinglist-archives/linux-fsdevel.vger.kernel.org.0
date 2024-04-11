Return-Path: <linux-fsdevel+bounces-16744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A68A1FE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E1E1C22E5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3B17C6A;
	Thu, 11 Apr 2024 20:06:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFC17BC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865964; cv=none; b=GyloP3I774mD02lmsAe3EdYByTZnN9D7nitreWzudPORFWeE2qMV2Yxa3Wid7EtfszNfYs+w0tD4IrJOc06i0XN+smmkhlXhonAsKoP/+kpHTxc0/LbaQXLTvyNbBy4M2aMraE7ikD7zY5oQXRKfzAAqyOpKNLF8gRbzUhNvD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865964; c=relaxed/simple;
	bh=e9V1Hke4cOuauUK4C2rco+2S0D6gglIZ12r7JZm7W9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XBvVYtBv/PP1U3vD7HfMGQbCwa98lRtORoXI/1flXsW3f0IvqzloumfCNHnPCPuGlXbz89THxwdoopjktQsJAKjwvpkgTXLXBQXkpAISGxeL7rFZkbdMUP+zaHo+jX2dFOl9vzXUsYCqsvCpR35p3MHjT1SvLBntK6UjlitWq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d096c4d663so22954739f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865962; x=1713470762;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCYfTbTxbgMRvc87Bz92PmtSrOTbWiZLH+tgphNPang=;
        b=nReLS9jDhnbzalvlfs6YBMH3lupu7M5gaoa9RZAs5TkuMBBssvPizEYyN5rsKH4E9b
         6iGSdbMeovpbE+KiJzmlg0pgIGsMW5gNgUariarR/icR7/Pfp0l1HZAle90qmoTlADyl
         cP6XDRONgFRQ//fv0UWqYWmVbq7ITwCHkzxQOyj1oMtFRWVazi0aMACAAFGGBifHe1uQ
         OtWKYNHMARdWuF9GM83kkIG44ZanFVhSK8Qtd/wHClWywrptXl8yMsyMKg2yuCdo/WW7
         Wn9tVmUItxa/mZCYIvCBGGM/PdluCRrNBXIKOw3A6iOX5iuQNc9F2dzNVV9ZUKEbnNwV
         JR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVhv1Nt0eXzY+fnMO/5RDom5zXhApJhCKB9hLiF0bCinTDGo9/SyUAb57qFinIemc8QPn6LUAflSq+IflOooKsFChE6hJ0oX/pyTJPYEg==
X-Gm-Message-State: AOJu0Yw5p2JX+R8gUvUaHta4hZNsKvbA6eazy2TtYoqyW6mU4os3RVbu
	uSGQgwK3iJlE5bSNwWXcC1hemAxh1EuSdnC32tj1btNoGS2XTxrIMUOj5t5F/DnA6Xt9VYQjJSE
	4FRU2uiZssRycqdeAIjAGw/Uz535NYc+/GdXOW4RgDEnKUvjKb/AVQfE=
X-Google-Smtp-Source: AGHT+IGV+9DBgimfl3kQW6cKgPo10Yq68f6IcDkCmWmE4zCD8lpmyj3k+Clqt6gkxvdCLbXgOPLl4zQRVqk+WPJ8b0OjlzOX7IEI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8929:b0:482:c7c8:5019 with SMTP id
 jc41-20020a056638892900b00482c7c85019mr7829jab.0.1712865962284; Thu, 11 Apr
 2024 13:06:02 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:06:02 -0700
In-Reply-To: <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b04040615d7afde@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, krisman@suse.de, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

viperboard
[    7.499011][    T1] usbcore: registered new interface driver dln2
[    7.500804][    T1] usbcore: registered new interface driver pn533_usb
[    7.507181][    T1] nfcsim 0.2 initialized
[    7.508964][    T1] usbcore: registered new interface driver port100
[    7.511844][    T1] usbcore: registered new interface driver nfcmrvl
[    7.519814][    T1] Loading iSCSI transport class v2.0-870.
[    7.539126][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.550224][    T1] ------------[ cut here ]------------
[    7.551264][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.552627][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.554218][    T1] Modules linked in:
[    7.554791][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc3-=
syzkaller-00014-geb06a4b6cca5 #0
[    7.556609][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.558128][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.559937][    T1] Code: b2 00 00 00 e8 87 70 e7 fc 5b 5d c3 cc cc cc c=
c e8 7b 70 e7 fc c6 05 0c 5d e5 0a 01 90 48 c7 c7 40 4b 1f 8c e8 17 ee a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 5b 70 e7 fc c6 05 e9 5c e5 0a 01 90 48 c7 c7
[    7.563097][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.564240][    T1] RAX: 6f40bd285f2a6000 RBX: ffff888147ed00fc RCX: fff=
f8880166d0000
[    7.565743][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.567236][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c39af8
[    7.568531][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000503edc0
[    7.570021][    T1] R13: ffffea000503edc8 R14: 1ffffd4000a07db9 R15: 000=
0000000000000
[    7.571764][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.573270][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.574232][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.575566][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.576737][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.578004][    T1] Call Trace:
[    7.578712][    T1]  <TASK>
[    7.579189][    T1]  ? __warn+0x163/0x4e0
[    7.580052][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.580896][    T1]  ? report_bug+0x2b3/0x500
[    7.581593][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.582383][    T1]  ? handle_bug+0x3e/0x70
[    7.583169][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.584335][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.585285][    T1]  ? __warn_printk+0x292/0x360
[    7.586058][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.586882][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.587666][    T1]  __free_pages_ok+0xc60/0xd90
[    7.588339][    T1]  make_alloc_exact+0xa3/0xf0
[    7.589220][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.590378][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.591429][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.592174][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.592853][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.593892][    T1]  ? really_probe+0x2b8/0xad0
[    7.594581][    T1]  ? driver_probe_device+0x50/0x430
[    7.595325][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.596200][    T1]  ? ret_from_fork+0x4b/0x80
[    7.597705][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.599051][    T1]  vring_create_virtqueue+0xca/0x110
[    7.599905][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.600626][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.601770][    T1]  setup_vq+0xe9/0x2d0
[    7.602429][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.603153][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.604003][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.604758][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.605623][    T1]  vp_setup_vq+0xbf/0x330
[    7.606388][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.607239][    T1]  ? ioread16+0x2f/0x90
[    7.608129][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.609047][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.609880][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.610578][    T1]  virtscsi_init+0x8db/0xd00
[    7.611247][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.612058][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.612860][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.613671][    T1]  ? vp_get+0xfd/0x140
[    7.614243][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.614969][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.615847][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.616678][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.617627][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.618392][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.619262][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.620216][    T1]  really_probe+0x2b8/0xad0
[    7.621124][    T1]  __driver_probe_device+0x1a2/0x390
[    7.621980][    T1]  driver_probe_device+0x50/0x430
[    7.622710][    T1]  __driver_attach+0x45f/0x710
[    7.623413][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.624299][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.625118][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.625993][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.626858][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.627837][    T1]  bus_add_driver+0x347/0x620
[    7.628735][    T1]  driver_register+0x23a/0x320
[    7.629982][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.631006][    T1]  virtio_scsi_init+0x65/0xe0
[    7.631802][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.632612][    T1]  do_one_initcall+0x248/0x880
[    7.633404][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.634540][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.635786][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.636889][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.637652][    T1]  ? do_initcalls+0x1c/0x80
[    7.638456][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.639227][    T1]  do_initcall_level+0x157/0x210
[    7.640192][    T1]  do_initcalls+0x3f/0x80
[    7.640818][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.641593][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.642546][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.643506][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.644295][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.645313][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.646036][    T1]  kernel_init+0x1d/0x2b0
[    7.646660][    T1]  ret_from_fork+0x4b/0x80
[    7.647368][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.648542][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.649812][    T1]  </TASK>
[    7.650346][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.651620][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc3-=
syzkaller-00014-geb06a4b6cca5 #0
[    7.653389][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.655321][    T1] Call Trace:
[    7.655801][    T1]  <TASK>
[    7.656252][    T1]  dump_stack_lvl+0x241/0x360
[    7.657006][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.657825][    T1]  ? __pfx__printk+0x10/0x10
[    7.658542][    T1]  ? _printk+0xd5/0x120
[    7.659343][    T1]  ? vscnprintf+0x5d/0x90
[    7.659705][    T1]  panic+0x349/0x860
[    7.659705][    T1]  ? __warn+0x172/0x4e0
[    7.659705][    T1]  ? __pfx_panic+0x10/0x10
[    7.659705][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.659705][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.659705][    T1]  __warn+0x346/0x4e0
[    7.659705][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.659705][    T1]  report_bug+0x2b3/0x500
[    7.659705][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.659705][    T1]  handle_bug+0x3e/0x70
[    7.659705][    T1]  exc_invalid_op+0x1a/0x50
[    7.659705][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.659705][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.659705][    T1] Code: b2 00 00 00 e8 87 70 e7 fc 5b 5d c3 cc cc cc c=
c e8 7b 70 e7 fc c6 05 0c 5d e5 0a 01 90 48 c7 c7 40 4b 1f 8c e8 17 ee a9 f=
c 90 <0f> 0b 90 90 eb d9 e8 5b 70 e7 fc c6 05 e9 5c e5 0a 01 90 48 c7 c7
[    7.659705][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.659705][    T1] RAX: 6f40bd285f2a6000 RBX: ffff888147ed00fc RCX: fff=
f8880166d0000
[    7.659705][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.659705][    T1] RBP: 0000000000000004 R08: ffffffff815800a2 R09: fff=
ffbfff1c39af8
[    7.659705][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000503edc0
[    7.659705][    T1] R13: ffffea000503edc8 R14: 1ffffd4000a07db9 R15: 000=
0000000000000
[    7.659705][    T1]  ? __warn_printk+0x292/0x360
[    7.659705][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.659705][    T1]  __free_pages_ok+0xc60/0xd90
[    7.659705][    T1]  make_alloc_exact+0xa3/0xf0
[    7.659705][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.659705][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.659705][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.659705][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.659705][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.659705][    T1]  ? really_probe+0x2b8/0xad0
[    7.659705][    T1]  ? driver_probe_device+0x50/0x430
[    7.659705][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.659705][    T1]  ? ret_from_fork+0x4b/0x80
[    7.659705][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.659705][    T1]  vring_create_virtqueue+0xca/0x110
[    7.659705][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.659705][    T1]  setup_vq+0xe9/0x2d0
[    7.659705][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.659705][    T1]  vp_setup_vq+0xbf/0x330
[    7.659705][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.659705][    T1]  ? ioread16+0x2f/0x90
[    7.659705][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.709861][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.709861][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.709861][    T1]  virtscsi_init+0x8db/0xd00
[    7.709861][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.709861][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.709861][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.709861][    T1]  ? vp_get+0xfd/0x140
[    7.709861][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.709861][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.709861][    T1]  ? kernfs_add_one+0x156/0x8b0
[    7.709861][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.709861][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.709861][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.709861][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.709861][    T1]  really_probe+0x2b8/0xad0
[    7.709861][    T1]  __driver_probe_device+0x1a2/0x390
[    7.709861][    T1]  driver_probe_device+0x50/0x430
[    7.709861][    T1]  __driver_attach+0x45f/0x710
[    7.709861][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.709861][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.709861][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.709861][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.709861][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.709861][    T1]  bus_add_driver+0x347/0x620
[    7.709861][    T1]  driver_register+0x23a/0x320
[    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.709861][    T1]  virtio_scsi_init+0x65/0xe0
[    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.709861][    T1]  do_one_initcall+0x248/0x880
[    7.709861][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.709861][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.709861][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.709861][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.709861][    T1]  ? do_initcalls+0x1c/0x80
[    7.709861][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.709861][    T1]  do_initcall_level+0x157/0x210
[    7.709861][    T1]  do_initcalls+0x3f/0x80
[    7.709861][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.709861][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.709861][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.709861][    T1]  kernel_init+0x1d/0x2b0
[    7.709861][    T1]  ret_from_fork+0x4b/0x80
[    7.709861][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.709861][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.709861][    T1]  </TASK>
[    7.709861][    T1] Kernel Offset: disabled
[    7.709861][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1437292946=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 56086b24b
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
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D56086b24bdfd822d3b227edb3064db443cd8c971 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-083312'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"56086b24bdfd822d3b227edb3064db443c=
d8c971\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1523635d180000


Tested on:

commit:         eb06a4b6 fsnotify: do not handle events on a shutting ..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3335b6cc973feec=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67b45f16d=
4e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

