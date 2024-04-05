Return-Path: <linux-fsdevel+bounces-16205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E26A89A164
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C718C2884E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1A616FF49;
	Fri,  5 Apr 2024 15:37:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FD16F907
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331426; cv=none; b=ju+Ps0X2RLng4iJyNzwZDdggCc+krtML++dMuJZJtwka5lm/rmSTcxdNhv5U5SlXuIhVjntanp3YuHfyUl2bMfsj04KVIJHVF2dMtDrtQN1QjEnqkG3j0tJZ6HWyN3H9mttanWwaP4Kaee/vFD/oDxBfaiW/RSans3s8vR4qO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331426; c=relaxed/simple;
	bh=Eqg7zd/QST9m80hX8tzCCgytIUyKMEIYUxzKDGMunLo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZcpYlY5/zfaGvbzsnxCTHcW6DHUQWbHN4Jf5TGeKSJDu2XAwNTq2lH8pBAoVu4rEs6Qq544R61I7aErYI0B1nY0W8fbXX3NJ8vPXGoJsyU7QVVjK8l+jMEeGlxshTF/BJvU51BZ0+yLpUR9g3n8T752cVFBpHJHRAyInQFtxZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc78077032so224545739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 08:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331423; x=1712936223;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xKogxjIZVk1/fWjEvp+XETHn9KPKT+/XjMYzcN2I2I=;
        b=pr2tXXaBxZRpsX2G2qGibVNaP5FHRdLe6iutzA1n3Q8R0OYXIRzt7bMUm0LqPnGfmB
         s6YLEKRLVMaKoH4V2AAF3oMTK1Wd/GCfLcwqipoIwuH8EChu7iSCJDeVke6WRU3U4JKi
         oiQTjg9usqjeBLET8sKOOLR1KqcuASyKivGNF9xPrTC02j1kz/Xe5MUXio9X7BYd8JDg
         sep7v7JU6KcBogKfiymnQ49zh83khk+R1emzoDkQq7D5bSlpyzaFob+0r77czui8e4yJ
         +TO57eZNhL59LfYeQdLU/VS/UsSgoReV8Us5h7u3a4gXodNuKpk3F+WtAMsGqI/XoC0k
         K7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUx0pwDnZvdIxUCaCHiWMfNMXjvGZptCcywqBehxGWQIcRaoUts8cfFfGthRFuDQ37eJTtroK/p3QmkucfZyTpxO516V7rf1mPTe0eR6Q==
X-Gm-Message-State: AOJu0YzNK6EcTcfChPogofQfnO8/HHtKFJRDCtz+MFEG5Co7RFYtys3i
	PwK/Fi9LvrPCXqi8Cch/VNi0eO7BH8oHe73bv0e834d7RJP21FHVxN4949lNT2GDJOLLpq5V8Ry
	A6o2zg6LnwQ3RrXvFCkicy+b77LYo3S3rmqPqHI7ctNhEaynaHQqTgcA=
X-Google-Smtp-Source: AGHT+IE4eKpMQQc4p0ohc4eF9nfJZuQe830wyDTMXMc+uVkKMCyLz6KME2jA5aAloAy/OyIQMf+0OZlU/gQxTbCsl5jxSTVfuDKY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c82:b0:7d0:3436:d2e0 with SMTP id
 i2-20020a0566022c8200b007d03436d2e0mr72695iow.4.1712331423280; Fri, 05 Apr
 2024 08:37:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:37:03 -0700
In-Reply-To: <CAOQ4uxhm5m9CvX0y2RcJGuP=vryZLp9M+tS6vH1o_9BGUqxrvg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039026a06155b3a12@google.com>
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
[    8.144672][    T1] usbcore: registered new interface driver dln2
[    8.146814][    T1] usbcore: registered new interface driver pn533_usb
[    8.154721][    T1] nfcsim 0.2 initialized
[    8.156856][    T1] usbcore: registered new interface driver port100
[    8.158745][    T1] usbcore: registered new interface driver nfcmrvl
[    8.168709][    T1] Loading iSCSI transport class v2.0-870.
[    8.188275][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.202624][    T1] ------------[ cut here ]------------
[    8.204252][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.206219][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.208638][    T1] Modules linked in:
[    8.209556][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00001-g70d370568b75 #0
[    8.214301][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.217361][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.218680][    T1] Code: b2 00 00 00 e8 77 99 f2 fc 5b 5d c3 cc cc cc c=
c e8 6b 99 f2 fc c6 05 11 1e f0 0a 01 90 48 c7 c7 e0 5e 1e 8c e8 b7 35 b5 f=
c 90 <0f> 0b 90 90 eb d9 e8 4b 99 f2 fc c6 05 ee 1d f0 0a 01 90 48 c7 c7
[    8.223425][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.225385][    T1] RAX: 1f757896feb95b00 RBX: ffff8881482a2d7c RCX: fff=
f888016ac8000
[    8.227629][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.229990][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1c396e0
[    8.232520][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    8.234601][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    8.236876][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.239600][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.240914][    T1] CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 000=
00000003506f0
[    8.243303][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.245750][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.247945][    T1] Call Trace:
[    8.248964][    T1]  <TASK>
[    8.250217][    T1]  ? __warn+0x163/0x4e0
[    8.251589][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.253743][    T1]  ? report_bug+0x2b3/0x500
[    8.254770][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.256336][    T1]  ? handle_bug+0x3e/0x70
[    8.257030][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.258667][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.259957][    T1]  ? __warn_printk+0x292/0x360
[    8.261215][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.263208][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.264293][    T1]  __free_pages_ok+0xc54/0xd80
[    8.265404][    T1]  make_alloc_exact+0xa3/0xf0
[    8.266560][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.267988][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.269965][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.271058][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.272057][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.273466][    T1]  ? really_probe+0x2b8/0xad0
[    8.275102][    T1]  ? driver_probe_device+0x50/0x430
[    8.276174][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.277826][    T1]  ? ret_from_fork+0x4b/0x80
[    8.279140][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.281586][    T1]  vring_create_virtqueue+0xca/0x110
[    8.283311][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.285146][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.286554][    T1]  setup_vq+0xe9/0x2d0
[    8.287916][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.289684][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.291329][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.292741][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.294786][    T1]  vp_setup_vq+0xbf/0x330
[    8.296422][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.297504][    T1]  ? ioread16+0x2f/0x90
[    8.298989][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.300925][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.302291][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.303546][    T1]  virtscsi_init+0x8db/0xd00
[    8.304820][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.305808][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.307015][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.308290][    T1]  ? vp_get+0xfd/0x140
[    8.309405][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.310389][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.311500][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.312348][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.313977][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.314859][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.315766][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.316886][    T1]  really_probe+0x2b8/0xad0
[    8.317711][    T1]  __driver_probe_device+0x1a2/0x390
[    8.318525][    T1]  driver_probe_device+0x50/0x430
[    8.319567][    T1]  __driver_attach+0x45f/0x710
[    8.320525][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.321841][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.322872][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.324235][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.326127][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.327579][    T1]  bus_add_driver+0x347/0x620
[    8.328989][    T1]  driver_register+0x23a/0x320
[    8.330318][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.332178][    T1]  virtio_scsi_init+0x65/0xe0
[    8.333752][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.334950][    T1]  do_one_initcall+0x248/0x880
[    8.336015][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.337202][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.338254][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    8.339378][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.341464][    T1]  ? do_initcalls+0x1c/0x80
[    8.342223][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.343161][    T1]  do_initcall_level+0x157/0x210
[    8.344252][    T1]  do_initcalls+0x3f/0x80
[    8.345400][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.346571][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.349024][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.350664][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.352143][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.353430][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.354609][    T1]  kernel_init+0x1d/0x2b0
[    8.355433][    T1]  ret_from_fork+0x4b/0x80
[    8.356203][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.357092][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.358282][    T1]  </TASK>
[    8.359166][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.360941][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller-00001-g70d370568b75 #0
[    8.363085][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    8.363411][    T1] Call Trace:
[    8.363411][    T1]  <TASK>
[    8.363411][    T1]  dump_stack_lvl+0x241/0x360
[    8.363411][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.363411][    T1]  ? __pfx__printk+0x10/0x10
[    8.363411][    T1]  ? _printk+0xd5/0x120
[    8.363411][    T1]  ? vscnprintf+0x5d/0x90
[    8.363411][    T1]  panic+0x349/0x860
[    8.363411][    T1]  ? __warn+0x172/0x4e0
[    8.363411][    T1]  ? __pfx_panic+0x10/0x10
[    8.363411][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.363411][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.363411][    T1]  __warn+0x346/0x4e0
[    8.363411][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.363411][    T1]  report_bug+0x2b3/0x500
[    8.363411][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.363411][    T1]  handle_bug+0x3e/0x70
[    8.363411][    T1]  exc_invalid_op+0x1a/0x50
[    8.363411][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.363411][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.363411][    T1] Code: b2 00 00 00 e8 77 99 f2 fc 5b 5d c3 cc cc cc c=
c e8 6b 99 f2 fc c6 05 11 1e f0 0a 01 90 48 c7 c7 e0 5e 1e 8c e8 b7 35 b5 f=
c 90 <0f> 0b 90 90 eb d9 e8 4b 99 f2 fc c6 05 ee 1d f0 0a 01 90 48 c7 c7
[    8.363411][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.363411][    T1] RAX: 1f757896feb95b00 RBX: ffff8881482a2d7c RCX: fff=
f888016ac8000
[    8.363411][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.363411][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1c396e0
[    8.363411][    T1] R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: fff=
fea000502cdc0
[    8.363411][    T1] R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 000=
0000000000000
[    8.363411][    T1]  ? __warn_printk+0x292/0x360
[    8.363411][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.363411][    T1]  __free_pages_ok+0xc54/0xd80
[    8.363411][    T1]  make_alloc_exact+0xa3/0xf0
[    8.363411][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.363411][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.363411][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.363411][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.363411][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.363411][    T1]  ? really_probe+0x2b8/0xad0
[    8.363411][    T1]  ? driver_probe_device+0x50/0x430
[    8.363411][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.363411][    T1]  ? ret_from_fork+0x4b/0x80
[    8.363411][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.363411][    T1]  vring_create_virtqueue+0xca/0x110
[    8.363411][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.363411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363411][    T1]  setup_vq+0xe9/0x2d0
[    8.363411][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.363411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363411][    T1]  vp_setup_vq+0xbf/0x330
[    8.363411][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.363411][    T1]  ? ioread16+0x2f/0x90
[    8.363411][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.363411][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.363411][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.363411][    T1]  virtscsi_init+0x8db/0xd00
[    8.363411][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.363411][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.363411][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.363411][    T1]  ? vp_get+0xfd/0x140
[    8.363411][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.363411][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.363411][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.363411][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.363411][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.363411][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.363411][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.363411][    T1]  really_probe+0x2b8/0xad0
[    8.363411][    T1]  __driver_probe_device+0x1a2/0x390
[    8.363411][    T1]  driver_probe_device+0x50/0x430
[    8.363411][    T1]  __driver_attach+0x45f/0x710
[    8.363411][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.363411][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.363411][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.363411][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.363411][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.363411][    T1]  bus_add_driver+0x347/0x620
[    8.363411][    T1]  driver_register+0x23a/0x320
[    8.363411][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.363411][    T1]  virtio_scsi_init+0x65/0xe0
[    8.363411][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.363411][    T1]  do_one_initcall+0x248/0x880
[    8.363411][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.363411][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.363411][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    8.363411][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.363411][    T1]  ? do_initcalls+0x1c/0x80
[    8.363411][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.363411][    T1]  do_initcall_level+0x157/0x210
[    8.363411][    T1]  do_initcalls+0x3f/0x80
[    8.363411][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.363411][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.363411][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.363411][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.363411][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.363411][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.363411][    T1]  kernel_init+0x1d/0x2b0
[    8.363411][    T1]  ret_from_fork+0x4b/0x80
[    8.363411][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.363411][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.363411][    T1]  </TASK>
[    8.363411][    T1] Kernel Offset: disabled
[    8.363411][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2829307758=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D16ae7ead180000


Tested on:

commit:         70d37056 kernfs: annotate different lockdep class for ..
git tree:       https://github.com/amir73il/linux/ vfs-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd45c08b2154c215=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8b1bfb238=
b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

