Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1C2817E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgJBQ2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 12:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgJBQ2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601656109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=70JScOKxW9Zxu+UiD1G7Jl71g5JgqZDIZicmaCIjGI8=;
        b=HghPi+BQtN2xjKNsN/q8Jw+Xk+tStpfKBj4Ru3hINhAZw+wRyGwHiX9sOC41kpXOd28c8j
        8aFIBO/uBo76tUNUvh0gWGSZ78XVyz1Lf95gU6nMqlSkkFMKcMXxWU/poINcgLoBsdOdL0
        XlwLUBXCo0ibgKOyFvXjugAaKZFH89g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-TAYnJU6AMs6EvxdrbR2tuQ-1; Fri, 02 Oct 2020 12:28:27 -0400
X-MC-Unique: TAYnJU6AMs6EvxdrbR2tuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 400841084C97;
        Fri,  2 Oct 2020 16:28:25 +0000 (UTC)
Received: from ovpn-113-213.rdu2.redhat.com (ovpn-113-213.rdu2.redhat.com [10.10.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 589A178803;
        Fri,  2 Oct 2020 16:28:18 +0000 (UTC)
Message-ID: <5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com>
Subject: virtiofs: WARN_ON(out_sgs + in_sgs != total_sgs)
From:   Qian Cai <cai@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Fri, 02 Oct 2020 12:28:17 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running some fuzzing on virtiofs from a non-privileged user could trigger a
warning in virtio_fs_enqueue_req():

WARN_ON(out_sgs + in_sgs != total_sgs);

# /usr/libexec/virtiofsd --socket-path=/tmp/vhostqemu -o source=$TESTDIR -o cache=always -o no_posix_lock
...
# mount -t virtiofs myfs /tmp
$ cd /tmp
$ trinity -C 48 --arch 64

From the log, the final piece of the code from the process was:

ioctl(fd=343, cmd=0x5a004000, arg=0x40000000);

[ 4327.977314] WARNING: CPU: 2 PID: 12259 at fs/fuse/virtio_fs.c:1151 virtio_fs_enqueue_req+0xa86/0xdb0 [virtiofs]
[ 4327.983910] Modules linked in: cmtp kernelcapi hidp bnep bridge stp llc dlci pppoe rfcomm nfnetlink pptp gre can_bcm bluetooth ecdh_generic ecc l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppoxw
[ 4327.984068]  sunrpc dm_mirror dm_region_hash dm_log dm_mod
[ 4328.046826] CPU: 2 PID: 12259 Comm: trinity-c20 Kdump: loaded Not tainted 5.9.0-rc7-next-20201002+ #5
[ 4328.053714] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 4328.059513] RIP: 0010:virtio_fs_enqueue_req+0xa86/0xdb0 [virtiofs]
[ 4328.063812] Code: c1 e7 05 48 03 7c 24 10 6a 00 e8 85 a4 ff ff 8d 48 01 58 41 8d 54 0d 00 e9 d2 fb ff ff 48 89 ef e8 8f 33 5e f9 e9 42 fe ff ff <0f> 0b e9 c7 fb ff ff 48 8b 7c 24 08 e8 c9 49 cf f8 0f b6 45 19
[ 4328.076709] RSP: 0018:ffff8889fbb4f9c0 EFLAGS: 00010297
[ 4328.079112] RAX: 0000000000000000 RBX: ffff8889c9ad88a8 RCX: 0000000000000003
[ 4328.083725] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffff88810575c1cc
[ 4328.089156] RBP: ffff8889fbb4fe20 R08: ffffed1020aeb83c R09: 0000000000001000
[ 4328.095906] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
[ 4328.101870] R13: 0000000000000004 R14: 0000000000000003 R15: ffff8889c9ad88d8
[ 4328.106674] FS:  00007f1129d21740(0000) GS:ffff888a7e900000(0000) knlGS:0000000000000000
[ 4328.111642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4328.114333] CR2: 000000000000002f CR3: 000000090f4ea005 CR4: 0000000000770ee0
[ 4328.117623] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4328.122782] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4328.128516] PKRU: 55555550
[ 4328.130769] Call Trace:
[ 4328.131992]  ? virtio_fs_probe+0x14d0/0x14d0 [virtiofs]
[ 4328.134465]  ? trace_hardirqs_on+0x1c/0x110
[ 4328.136419]  ? make_kprojid+0x20/0x20
[ 4328.138936]  ? __is_kernel_percpu_address+0x63/0x1e0
[ 4328.141899]  ? __module_address+0x3f/0x370
[ 4328.143835]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 4328.146248]  ? virtio_fs_wake_pending_and_unlock+0x18b/0x610 [virtiofs]
[ 4328.149323]  ? lock_downgrade+0x730/0x730
[ 4328.151217]  ? lock_acquire+0x17f/0x7e0
[ 4328.152998]  ? fuse_simple_request+0x233/0x9f0 [fuse]
[ 4328.155360]  ? rcu_read_unlock+0x40/0x40
[ 4328.157169]  virtio_fs_wake_pending_and_unlock+0x1f0/0x610 [virtiofs]
virtio_fs_wake_pending_and_unlock at fs/fuse/virtio_fs.c:1227 (discriminator 10)
[ 4328.160173]  ? queue_request_and_unlock+0x11e/0x290 [fuse]
[ 4328.162685]  fuse_simple_request+0x3b2/0x9f0 [fuse]
__fuse_request_send at fs/fuse/dev.c:421
(inlined by) fuse_simple_request at fs/fuse/dev.c:503
[ 4328.164933]  fuse_do_ioctl+0x6c6/0x1280 [fuse]
[ 4328.166992]  ? fuse_readahead+0x1410/0x1410 [fuse]
[ 4328.169213]  ? hrtimer_forward+0x1b0/0x1b0
[ 4328.171113]  ? hrtimer_cancel+0x20/0x20
[ 4328.172903]  ? ioctl_file_clone+0x120/0x120
[ 4328.174849]  ? _raw_spin_unlock_irq+0x24/0x30
[ 4328.176871]  ? fuse_allow_current_process+0x235/0x2a0 [fuse]
[ 4328.181615]  __x64_sys_ioctl+0x128/0x190
[ 4328.184832]  do_syscall_64+0x33/0x40
[ 4328.190405]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4328.196680] RIP: 0033:0x7f112963478d
[ 4328.200415] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[ 4328.214734] RSP: 002b:00007ffd75a76ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 4328.220222] RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f112963478d
[ 4328.224383] RDX: 0000000040000000 RSI: 000000005a004000 RDI: 0000000000000157
[ 4328.228838] RBP: 0000000000000010 R08: 00000000000000a6 R09: 000000002e2e2e2e
[ 4328.233241] R10: fffffffffffffffc R11: 0000000000000246 R12: 0000000000000002
[ 4328.237136] R13: 00007f1129c8e058 R14: 00007f1129d216c0 R15: 00007f1129c8e000
[ 4328.240635] CPU: 2 PID: 12259 Comm: trinity-c20 Kdump: loaded Not tainted 5.9.0-rc7-next-20201002+ #5
[ 4328.248370] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 4328.254499] Call Trace:
[ 4328.256522]  dump_stack+0x99/0xcb
[ 4328.259336]  __warn.cold.11+0xe/0x55
[ 4328.261944]  ? virtio_fs_enqueue_req+0xa86/0xdb0 [virtiofs]
[ 4328.264929]  report_bug+0x1af/0x260
[ 4328.266673]  handle_bug+0x44/0x80
[ 4328.270439]  exc_invalid_op+0x13/0x40
[ 4328.273490]  asm_exc_invalid_op+0x12/0x20
[ 4328.276814] RIP: 0010:virtio_fs_enqueue_req+0xa86/0xdb0 [virtiofs]
[ 4328.281866] Code: c1 e7 05 48 03 7c 24 10 6a 00 e8 85 a4 ff ff 8d 48 01 58 41 8d 54 0d 00 e9 d2 fb ff ff 48 89 ef e8 8f 33 5e f9 e9 42 fe ff ff <0f> 0b e9 c7 fb ff ff 48 8b 7c 24 08 e8 c9 49 cf f8 0f b6 45 19
[ 4328.294322] RSP: 0018:ffff8889fbb4f9c0 EFLAGS: 00010297
[ 4328.299571] RAX: 0000000000000000 RBX: ffff8889c9ad88a8 RCX: 0000000000000003
[ 4328.305197] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffff88810575c1cc
[ 4328.308930] RBP: ffff8889fbb4fe20 R08: ffffed1020aeb83c R09: 0000000000001000
[ 4328.313548] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
[ 4328.318783] R13: 0000000000000004 R14: 0000000000000003 R15: ffff8889c9ad88d8
[ 4328.322338]  ? virtio_fs_probe+0x14d0/0x14d0 [virtiofs]
[ 4328.324902]  ? trace_hardirqs_on+0x1c/0x110
[ 4328.328759]  ? make_kprojid+0x20/0x20
[ 4328.331336]  ? __is_kernel_percpu_address+0x63/0x1e0
[ 4328.333882]  ? __module_address+0x3f/0x370
[ 4328.337281]  ? lockdep_hardirqs_on_prepare+0x4d0/0x4d0
[ 4328.341248]  ? virtio_fs_wake_pending_and_unlock+0x18b/0x610 [virtiofs]
[ 4328.345799]  ? lock_downgrade+0x730/0x730
[ 4328.348017]  ? lock_acquire+0x17f/0x7e0
[ 4328.350546]  ? fuse_simple_request+0x233/0x9f0 [fuse]
[ 4328.355082]  ? rcu_read_unlock+0x40/0x40
[ 4328.358741]  virtio_fs_wake_pending_and_unlock+0x1f0/0x610 [virtiofs]
[ 4328.362663]  ? queue_request_and_unlock+0x11e/0x290 [fuse]
[ 4328.366070]  fuse_simple_request+0x3b2/0x9f0 [fuse]
[ 4328.368684]  fuse_do_ioctl+0x6c6/0x1280 [fuse]
[ 4328.371398]  ? fuse_readahead+0x1410/0x1410 [fuse]
[ 4328.373750]  ? hrtimer_forward+0x1b0/0x1b0
[ 4328.375807]  ? hrtimer_cancel+0x20/0x20
[ 4328.378899]  ? ioctl_file_clone+0x120/0x120
[ 4328.380978]  ? _raw_spin_unlock_irq+0x24/0x30
[ 4328.383097]  ? fuse_allow_current_process+0x235/0x2a0 [fuse]
[ 4328.387317]  __x64_sys_ioctl+0x128/0x190
[ 4328.390560]  do_syscall_64+0x33/0x40
[ 4328.393175]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4328.396953] RIP: 0033:0x7f112963478d
[ 4328.399000] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[ 4328.411726] RSP: 002b:00007ffd75a76ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 4328.417652] RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f112963478d
[ 4328.422766] RDX: 0000000040000000 RSI: 000000005a004000 RDI: 0000000000000157
[ 4328.427831] RBP: 0000000000000010 R08: 00000000000000a6 R09: 000000002e2e2e2e
[ 4328.433501] R10: fffffffffffffffc R11: 0000000000000246 R12: 0000000000000002
[ 4328.438662] R13: 00007f1129c8e058 R14: 00007f1129d216c0 R15: 00007f1129c8e000
[ 4328.443667] irq event stamp: 0
[ 4328.446682] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 4328.451788] hardirqs last disabled at (0): [<ffffffffb8fa08d7>] copy_process+0x18a7/0x5f00
[ 4328.456792] softirqs last  enabled at (0): [<ffffffffb8fa0913>] copy_process+0x18e3/0x5f00
[ 4328.462852] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 4328.467521] ---[ end trace d6b440e9dac66d6a ]---

