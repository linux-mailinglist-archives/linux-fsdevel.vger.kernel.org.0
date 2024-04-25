Return-Path: <linux-fsdevel+bounces-17790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60B8B2372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DD7B28FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765714A4D7;
	Thu, 25 Apr 2024 14:03:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043C14A0B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053785; cv=none; b=OPvkydFNVnjQJ5P6M/pTT9jPnNO5/kTegnonJJCZu3fL3s5f4Z7NRVi1Pz76adwu+lHTc84BmAZ2A7snXONjRwOALobqr8uEM7o8iKFKvSwJMvcb4Xh6H5saSp9pXyu9L1UzjGNcq12IIzC6I3zRQrpGEpm5mWdF+hpX5WwVc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053785; c=relaxed/simple;
	bh=Ur9heTqEb7j7/C36LVoQF4XVZWj2yVx5bb4BOv2B81w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bMJI0quOmP1h4WlpJQz5kGisYzaSL6+uRLibwcpDlvlly5x633JIlP/IEhoET7GnJwzBlrH4TDJmJLDnBhIICwmjdydDo1eApvQC1GNWEykUemxcNrzW3alqIV/hzcTVoNU2eZzAuql3t4lTNiH94bBSB67JDu2me6ia2B/j258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7de8d4b339dso105985139f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 07:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053783; x=1714658583;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbu4sBShjUWT70B5cAw3x4DCO9Kl2R83zlzt32Awcq4=;
        b=gE+ppMv7ZSdJAyAGah7mR5leeTqeY3y94NRhDLs9PDIOd04xKDZIlInUYCDPIbN6kp
         0I4nq7j61CQGY18mDZQ7mS8d+P0wVt5YKlSuAPfswV/vuHgiFt7rMKn02h5xvuHjtfbl
         TFGAjLHJql2Tf5ojrgXlHfK+xlMH2ldCr1fdmW9bCunQXO9O4cqPs4Jdf/Z6td3kBD7b
         fVNnrryyYGgQVdW1BdikhTrVtH+nf5RsFMWjHvT5HwZgwaG7lAO1xyX9VBNYkyueRzJt
         E+oArPA0wP4DcZOZ+zPPY8U3JtRbPm4gG5KFNkO8sZfJdyuwiT+XkLOV6munecPWpb4d
         N+yA==
X-Forwarded-Encrypted: i=1; AJvYcCXulStOf1xChg0vcwuufwC4Y245L5Mm59IoWYGGgiHhJt3bA5FE6ywTPl/HJYtRVsgam8ihlGUFjLvuirxOitYazbrjZixW1mZaXR2GPw==
X-Gm-Message-State: AOJu0YwFBEhS+Y+hpo4xBE7ppPodlPUq3EEawEL+SJkadidmwC0Dnwyh
	63iOOwAG0sHd1SEB7SO/DZAj4w/2F1ifXuKZS+SNWw5ZGd10CeZrxEqi/GQcZ7eYm5bzvoZN2Dv
	moMSfRC3EdLb3S2IVdYDNM7sb4WpqgPRyW0lwxAadq0QSrt1XxibI/60=
X-Google-Smtp-Source: AGHT+IEUdMKaSNZFthhRzd3GfFmA1ikn5mS42qjqNPjREfi79pP01XUXD66jainBFpglV5oKMc5Kz9cxwKFx406EXSf1pyH2y+0B
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841e:b0:486:e390:16a5 with SMTP id
 iq30-20020a056638841e00b00486e39016a5mr293770jab.3.1714053782795; Thu, 25 Apr
 2024 07:03:02 -0700 (PDT)
Date: Thu, 25 Apr 2024 07:03:02 -0700
In-Reply-To: <bf941367-5efc-4e79-8cac-208016e5a9b4@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9b4020616ec3e05@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in f2fs_get_node_info
From: syzbot <syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

][    T1] usbcore: registered new interface driver port100
[    7.895087][    T1] usbcore: registered new interface driver nfcmrvl
[    7.905107][    T1] Loading iSCSI transport class v2.0-870.
[    7.922010][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.931607][    T1] ------------[ cut here ]------------
[    7.932648][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.933996][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.935773][    T1] Modules linked in:
[    7.936430][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00035-g5f5d424df7e0 #0
[    7.938346][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    7.940220][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.941129][    T1] Code: b2 00 00 00 e8 e7 3e f2 fc 5b 5d c3 cc cc cc c=
c e8 db 3e f2 fc c6 05 d1 c3 ce 0a 01 90 48 c7 c7 60 57 fe 8b e8 37 bd b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 3e f2 fc c6 05 ae c3 ce 0a 01 90 48 c7 c7
[    7.944817][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.946204][    T1] RAX: 66500b6c8a695200 RBX: ffff88814074d61c RCX: fff=
f8880166c8000
[    7.947881][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.949474][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    7.950651][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000083fdc0
[    7.952066][    T1] R13: ffffea000083fdc8 R14: 1ffffd4000107fb9 R15: 000=
0000000000000
[    7.953537][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.955023][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.956765][    T1] CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    7.958239][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.959594][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.960858][    T1] Call Trace:
[    7.961668][    T1]  <TASK>
[    7.962214][    T1]  ? __warn+0x163/0x4e0
[    7.963029][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.964034][    T1]  ? report_bug+0x2b3/0x500
[    7.964911][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.965754][    T1]  ? handle_bug+0x3e/0x70
[    7.966390][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.967476][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.968393][    T1]  ? __warn_printk+0x292/0x360
[    7.969171][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.969977][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.971093][    T1]  __free_pages_ok+0xc54/0xd80
[    7.971989][    T1]  make_alloc_exact+0xa3/0xf0
[    7.972707][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.974010][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.975606][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.976506][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.977276][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.978066][    T1]  ? really_probe+0x2b8/0xad0
[    7.978729][    T1]  ? driver_probe_device+0x50/0x430
[    7.979895][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.980907][    T1]  ? ret_from_fork+0x4b/0x80
[    7.981907][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.983053][    T1]  vring_create_virtqueue+0xca/0x110
[    7.984261][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.985081][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.986232][    T1]  setup_vq+0xe9/0x2d0
[    7.987144][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.988136][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.989737][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.990898][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.992460][    T1]  vp_setup_vq+0xbf/0x330
[    7.993445][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.994457][    T1]  ? ioread16+0x2f/0x90
[    7.995411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.996442][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.997332][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.998606][    T1]  virtscsi_init+0x8db/0xd00
[    7.999359][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.000096][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.001321][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.002518][    T1]  ? vp_get+0xfd/0x140
[    8.003649][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.004550][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.005302][    T1]  ? vp_setup_vq+0x26d/0x330
[    8.006401][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.007509][    T1]  ? vp_set_status+0x1a/0x40
[    8.008360][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.009422][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.010463][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.011159][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.012074][    T1]  really_probe+0x2b8/0xad0
[    8.012764][    T1]  __driver_probe_device+0x1a2/0x390
[    8.013825][    T1]  driver_probe_device+0x50/0x430
[    8.014890][    T1]  __driver_attach+0x45f/0x710
[    8.015600][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.016479][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.017551][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.018401][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.019494][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.020300][    T1]  bus_add_driver+0x347/0x620
[    8.020992][    T1]  driver_register+0x23a/0x320
[    8.021940][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.022834][    T1]  virtio_scsi_init+0x65/0xe0
[    8.023816][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.024765][    T1]  do_one_initcall+0x248/0x880
[    8.025532][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.026403][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.027532][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.028306][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.029137][    T1]  ? do_initcalls+0x1c/0x80
[    8.029885][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.031051][    T1]  do_initcall_level+0x157/0x210
[    8.032038][    T1]  do_initcalls+0x3f/0x80
[    8.032723][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.033666][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.034835][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.035863][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.036989][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.037733][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.038424][    T1]  kernel_init+0x1d/0x2b0
[    8.039045][    T1]  ret_from_fork+0x4b/0x80
[    8.039774][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.040688][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.041498][    T1]  </TASK>
[    8.041923][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.042985][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00035-g5f5d424df7e0 #0
[    8.043627][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.043627][    T1] Call Trace:
[    8.043627][    T1]  <TASK>
[    8.043627][    T1]  dump_stack_lvl+0x241/0x360
[    8.043627][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.043627][    T1]  ? __pfx__printk+0x10/0x10
[    8.043627][    T1]  ? _printk+0xd5/0x120
[    8.043627][    T1]  ? vscnprintf+0x5d/0x90
[    8.043627][    T1]  panic+0x349/0x860
[    8.043627][    T1]  ? __warn+0x172/0x4e0
[    8.043627][    T1]  ? __pfx_panic+0x10/0x10
[    8.043627][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.053439][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.053439][    T1]  __warn+0x346/0x4e0
[    8.053439][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.053439][    T1]  report_bug+0x2b3/0x500
[    8.053439][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.053439][    T1]  handle_bug+0x3e/0x70
[    8.053439][    T1]  exc_invalid_op+0x1a/0x50
[    8.053439][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.053439][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.053439][    T1] Code: b2 00 00 00 e8 e7 3e f2 fc 5b 5d c3 cc cc cc c=
c e8 db 3e f2 fc c6 05 d1 c3 ce 0a 01 90 48 c7 c7 60 57 fe 8b e8 37 bd b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 bb 3e f2 fc c6 05 ae c3 ce 0a 01 90 48 c7 c7
[    8.063386][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.063386][    T1] RAX: 66500b6c8a695200 RBX: ffff88814074d61c RCX: fff=
f8880166c8000
[    8.063386][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.063386][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    8.063386][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000083fdc0
[    8.063386][    T1] R13: ffffea000083fdc8 R14: 1ffffd4000107fb9 R15: 000=
0000000000000
[    8.073474][    T1]  ? __warn_printk+0x292/0x360
[    8.073474][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.073474][    T1]  __free_pages_ok+0xc54/0xd80
[    8.073474][    T1]  make_alloc_exact+0xa3/0xf0
[    8.073474][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.073474][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.073474][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.073474][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.073474][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.073474][    T1]  ? really_probe+0x2b8/0xad0
[    8.073474][    T1]  ? driver_probe_device+0x50/0x430
[    8.083348][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.083348][    T1]  ? ret_from_fork+0x4b/0x80
[    8.083348][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.083348][    T1]  vring_create_virtqueue+0xca/0x110
[    8.083348][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.083348][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.083348][    T1]  setup_vq+0xe9/0x2d0
[    8.083348][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.083348][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.083348][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.083348][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.083348][    T1]  vp_setup_vq+0xbf/0x330
[    8.093441][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.093441][    T1]  ? ioread16+0x2f/0x90
[    8.093441][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.093441][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.093441][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.093441][    T1]  virtscsi_init+0x8db/0xd00
[    8.093441][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.093441][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.093441][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.093441][    T1]  ? vp_get+0xfd/0x140
[    8.093441][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.103383][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.103383][    T1]  ? vp_setup_vq+0x26d/0x330
[    8.103383][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    8.103383][    T1]  ? vp_set_status+0x1a/0x40
[    8.103383][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.103383][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.103383][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.103383][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.103383][    T1]  really_probe+0x2b8/0xad0
[    8.103383][    T1]  __driver_probe_device+0x1a2/0x390
[    8.113498][    T1]  driver_probe_device+0x50/0x430
[    8.113498][    T1]  __driver_attach+0x45f/0x710
[    8.113498][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.113498][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.113498][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.113498][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.113498][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.113498][    T1]  bus_add_driver+0x347/0x620
[    8.113498][    T1]  driver_register+0x23a/0x320
[    8.113498][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.113498][    T1]  virtio_scsi_init+0x65/0xe0
[    8.123379][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.123379][    T1]  do_one_initcall+0x248/0x880
[    8.123379][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.123379][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.123379][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.123379][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.123379][    T1]  ? do_initcalls+0x1c/0x80
[    8.123379][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.123379][    T1]  do_initcall_level+0x157/0x210
[    8.123379][    T1]  do_initcalls+0x3f/0x80
[    8.123379][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.133466][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.133466][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.133466][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.133466][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.133466][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.133466][    T1]  kernel_init+0x1d/0x2b0
[    8.133466][    T1]  ret_from_fork+0x4b/0x80
[    8.133466][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.133466][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.133466][    T1]  </TASK>
[    8.133466][    T1] Kernel Offset: disabled
[    8.133466][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build543475362=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 36c961ad9
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
/syzkaller/prog.GitRevision=3D36c961ad9dc0e5b72efc784a57717424a02bfa00 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240422-084642'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D36c961ad9dc0e5b72efc784a57717424a02bfa00 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240422-084642'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D36c961ad9dc0e5b72efc784a57717424a02bfa00 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240422-084642'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"36c961ad9dc0e5b72efc784a57717424a0=
2bfa00\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1241f68b180000


Tested on:

commit:         5f5d424d f2fs: fix to do sanity check on i_xattr_nid i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.gi=
t bugfix/syzbot
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ace29459a0a191=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3694e283cf5c40df6=
d14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

