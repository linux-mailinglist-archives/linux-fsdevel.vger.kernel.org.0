Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83B642468B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhJFTP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJFTP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:15:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EEEC061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 12:13:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d131so7861479ybd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=HZTBMYTxHAVoXO3KmV59H++aiwnX3UQsSdivq7c1bJo=;
        b=D2a/0YfZL9js2NWMIC9g1jM+C+Di8S6kmgbfwmCUssOVq0BR2e92AbcE4mEIpYpwJt
         ir17Jt+VFWcP6HGBiVBGUgKlyY4P/OFkLExj7lNOYu+aRB0pf3aJ/P3d39KzuBVaHoxf
         1OrrU5wuk+twyDtybB7Tk/UR3MvYm4lx87zTbFZXhZvp48KyHBJGYRjpQF1JoaLgMsFO
         bxoYUD4voLyhtsa0Qaow2uW8EAMdMRaox83k7hYEjZx6tINoQ3TxdYU9wx080lmtCvxq
         ZJDuZpYcdPhnmYOQi/4jVY7pYlzT9KneShJ49NNSqncfjyNnnXESEoeH9fhmJQxJINav
         ANaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HZTBMYTxHAVoXO3KmV59H++aiwnX3UQsSdivq7c1bJo=;
        b=dKJFynDaiOKrXP1cjgvh8YGuIk4SoON086lDhafkS4UlINwvO+NEFOqJvkHlCi1vFq
         tUr15bXnZWU6kWpyjv2mGKlrz112u1lyIOIaK4mywV0H5l+rOO6VTL1vF1MRL1kUxqNi
         O3Myb2b7+a4ylmuxZ0lZUaQpqq5zxEJg4FZmPTS+VgBug2NGtJ3/fsudfVRTKwzI0+5f
         GwMXmZVz7xWToYt/N+UpWpdmkeg/Q9I594BpOmVVLUbHvwfkzraA57BSvXVZjjTMbOSx
         3vhwYtRd1K4nG0QLbMFz0UDXYDsdTWt8sHwLuqpDcVdxHjuO62RUZM3KPPhBq70AR24Y
         n99Q==
X-Gm-Message-State: AOAM53219JrHwtb4k2vXoU7kGE0uWcnRHGg6hw1bSuimCr8kd/aZ9wSy
        Qn5HNnHOmFyllNowNgGOL8VAVSsqDgK8DvO+5Dk+htxyPmU+gfrK
X-Google-Smtp-Source: ABdhPJwlt79qtJitcJM6lX/K1aJG4XloJDeif6vwAF2tFQtICD3nzPRe3TpbV/I/yzCwBlL5p8gsXkwydQIquEbvfbg=
X-Received: by 2002:a25:5443:: with SMTP id i64mr30098148ybb.125.1633547615277;
 Wed, 06 Oct 2021 12:13:35 -0700 (PDT)
MIME-Version: 1.0
From:   Frank Dinoff <fdinoff@google.com>
Date:   Wed, 6 Oct 2021 15:13:19 -0400
Message-ID: <CAAmZXrsGg2xsP1CK+cbuEMumtrqdvD-NKnWzhNcvn71RV3c1yw@mail.gmail.com>
Subject: fuse: kernel panic while using splice (lru corruption)
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm experiencing a kernel panic while using fuse related to SPLICE_F_MOVE.

Some stack traces

[   52.864466] CPU: 1 PID: 10619 Comm: cp Not tainted 5.15.0-upstream-DEV #7
[   52.879137] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[   52.888490] RIP: 0010:__list_del_entry_valid+0x69/0x80
[   52.893907] Code: 7f 12 84 31 c0 e8 2d 42 55 00 0f 0b 48 c7 c7 37
8e 10 84 31 c0 e8 1d 42 55 00 0f 0b 48 c7 c7 19 52 19 84 31 c0 e8 0d
42 55 00 <0f> 0b 48 c7 c7 8e e7 15 84 31 c0 e8 fd 41 55 00 0f 0b 00 00
00 cc
[   52.980251] RSP: 0018:ffff8938ea093978 EFLAGS: 00010046
[   52.994508] RAX: 0000000000000054 RBX: ffffd8d7c5914ec0 RCX: 45fe15c1d0642d00
[   53.001774] RDX: ffff893939d230b8 RSI: ffff893939d17510 RDI: ffff893939d17510
[   53.009039] RBP: ffff8938ea093978 R08: 0000000000000000 R09: ffffffff8492dbf0
[   53.016312] R10: 00000000ffff7fff R11: 0000000000000000 R12: ffff8938ea093a98
[   53.023575] R13: ffff8938ced23400 R14: 000000000000000d R15: ffff8938ced23400
[   53.030843] FS:  00007f8bd4b1d740(0000) GS:ffff893939d00000(0000)
knlGS:0000000000000000
[   53.039064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.044939] CR2: 000000000020c86e CR3: 0000000164572003 CR4: 00000000003706e0
[   53.087945] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   53.105377] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   53.119206] Call Trace:
[   53.121786]  release_pages+0x1d0/0x490
[   53.125856]  __pagevec_release+0x4f/0x60
[   53.129914]  invalidate_inode_pages2_range+0x5c4/0x600
[   53.135186]  ? kmem_cache_free+0x7c/0x100
[   53.139330]  invalidate_inode_pages2+0x17/0x20
[   53.143907]  fuse_finish_open+0x75/0x150
[   53.147976]  fuse_open_common+0x113/0x120
[   53.152117]  fuse_open+0x10/0x20
[   53.155487]  do_dentry_open+0x263/0x360
[   53.167370]  vfs_open+0x2d/0x30
[   53.173633]  path_openat+0xa0f/0xd90
[   53.177353]  ? mntput+0x23/0x40
[   53.180635]  ? path_put+0x1e/0x30
[   53.184104]  do_filp_open+0xc7/0x170
[   53.187933]  do_sys_openat2+0x91/0x170
[   53.195012]  __x64_sys_openat+0x7e/0xa0
[   53.198989]  do_syscall_64+0x44/0xa0
[   53.202714]  ? exc_page_fault+0x71/0x160
[   53.211294]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   53.219256] RIP: 0033:0x7f8bd4c4bec2
[   53.231375] Code: 8d 48 08 48 89 4d d8 8b 18 48 8b 05 90 8d 07 00
83 38 00 75 30 b8 01 01 00 00 41 89 da bf 9c ff ff ff 4c 89 f6 44 89
fa 0f 05 <48> 89 c3 48 3d 00 f0 ff ff 77 42 89 d8 48 81 c4 c8 00 00 00
5b 41
[   53.261026] RSP: 002b:00007ffd4ae55570 EFLAGS: 00000246 ORIG_RAX:
0000000000000101
[   53.268738] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8bd4c4bec2
[   53.284714] RDX: 0000000000000000 RSI: 00007ffd4ae57bbc RDI: 00000000ffffff9c
[   53.305198] RBP: 00007ffd4ae55650 R08: 0000000000000000 R09: 00007ffd4ae55baf
[   53.312469] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   53.319736] R13: 00000000000081a4 R14: 00007ffd4ae57bbc R15: 0000000000000000
[   53.327003] Modules linked in: 9p 9pnet_virtio 9pnet vfat fat
virtio_net net_failover failover
[   53.335755] ---[ end trace 086000a6a6747ea3 ]---

With CONFIG_DEBUG_VM it looks like we are trying to add a page to the lru that
is already on the lru.

[  133.194168] invalid opcode: 0000 [#1] SMP PTI
[  133.197918] CPU: 1 PID: 10035 Comm: fusexmp Not tainted 5.15.0-dbg-DEV #5
[  133.213134] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[  133.213134] RIP: 0010:lru_cache_add+0x1be/0x1f0
[  133.213134] Code: c7 c6 1c 6c 01 8c e8 41 8d 03 00 0f 0b 48 c7 c6
1c 6c 01 8c e8 33 8d 03 00 0f 0b 48 89 df 48 c7 c6 60 12 fe 8b e8 22
8d 03 00 <0f> 0b 48 c7 c6 d8 6b ff 8b e8 14 8d 03 00 0f 0b 48 c7 c6 1c
6c 01
[  133.213134] RSP: 0018:ffff9eb7c319fb88 EFLAGS: 00010296
[  133.213134] RAX: bbc197b826b34400 RBX: ffffeb5405464e80 RCX: bbc197b826b34400
[  133.213134] RDX: c0000000ffff7fff RSI: 0000000000000004 RDI: ffff8e52b9d17868
[  133.213134] RBP: ffff9eb7c319fb90 R08: 0000000000000000 R09: ffffffff8c73ef80
[  133.213134] R10: 00000000ffff7fff R11: 0000000000000000 R12: 0000000000000000
[  133.303035] R13: ffffeb5405464e80 R14: ffff9eb7c319fd70 R15: 0000000000001000
[  133.303035] FS:  00007fe9b5aef700(0000) GS:ffff8e52b9d00000(0000)
knlGS:0000000000000000
[  133.303035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.303035] CR2: 000000000020c86e CR3: 0000000106ab2006 CR4: 00000000003706e0
[  133.303035] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  133.303035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  133.303035] Call Trace:
[  133.303035]  fuse_copy_page+0x60e/0xa80
[  133.303035]  fuse_copy_args+0xd1/0x1e0
[  133.303035]  fuse_dev_do_write+0x14f6/0x1b20
[  133.303035]  ? __kmalloc_node+0x3c/0x50
[  133.303035]  ? __mutex_unlock_slowpath+0x3d/0x230
[  133.303035]  fuse_dev_splice_write+0x364/0x410
[  133.303035]  do_splice+0x551/0x870
[  133.303035]  ? rcu_lock_release+0x10/0x20
[  133.303035]  ? __fget_files+0x15a/0x170
[  133.303035]  __se_sys_splice+0x15e/0x210
[  133.303035]  __x64_sys_splice+0x29/0x30
[  133.303035]  do_syscall_64+0x44/0xa0
[  133.303035]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  133.303035] RIP: 0033:0x7fe9bab60953
[  133.303035] Code: 49 89 ca b8 13 01 00 00 0f 05 48 3d 01 f0 ff ff
73 34 c3 48 83 ec 08 e8 0b 0b 00 00 48 89 04 24 49 89 ca b8 13 01 00
00 0f 05 <48> 8b 3c 24 48 89 c2 e8 51 0b 00 00 48 89 d0 48 83 c4 08 48
3d 01
[  133.553661] RSP: 002b:00007fe9b5aee8c0 EFLAGS: 00000297 ORIG_RAX:
0000000000000113
[  133.553661] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9bab60953
[  133.553661] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 00000000000000cd
[  133.553661] RBP: 00007fe9b5aee9d0 R08: 0000000000040010 R09: 0000000000000001
[  133.553661] R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000040010
[  133.553661] R13: 00007fe9b5aee9e0 R14: 00007fe9b5aeea00 R15: 00000624ffc22440
[  133.553661] Modules linked in: 9p 9pnet_virtio 9pnet vfat fat
virtio_net net_failover failover
[  133.625460] ---[ end trace bef475c49a5ebe99 ]---

The following reproduces the panic.

In libfuse modify and build example/passthrough.c:
$ git clone https://github.com/libfuse/libfuse
$ cd libfuse
# Enable FUSE_CAP_SLICE_WRITE and FUSE_CAP_SPLICE_MOVE in xmp_init.
$ sed -i 's/(void) conn;/conn->want |= FUSE_CAP_SPLICE_WRITE |
FUSE_CAP_SPLICE_MOVE;/' example/passthrough.c
$ mkdir build; cd build; meson ..; ninja

$ mkdir /tmp/fuse
$ example/passthrough /tmp/fuse
$ dd if=/dev/zero of=/tmp/zeros bs=1M count=100
$ while true; do /tmp/fuse/bin/cp /tmp/fuse/tmp/zeros /dev/null & done

---

https://github.com/libfuse/libfuse/commit/3b17db6f7417d5396230bfd56a64cae4e1e2a47c
changed libfuse to use vmsplice for malloced pages. Reverting this commit makes
the splices and kernel panics go away.
