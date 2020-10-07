Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F972868D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgJGUJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 16:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbgJGUJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602101340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z+/oOj0baWV0RSAtFxHWl1u8yWXLZEvgiiY2lKgmr7Y=;
        b=ebtc7mTNEOyubn+q1BdOOsVo5NNNsZSVjbYh+H5VcFmL4gslg4ZXlOZ6aLz7fwuUzM8Byr
        7PzZvOkPE1AxRONzvGgTeKAu5Cchbltz+/W5A2VzCY4W1E51fG4YqHpUwVlvxGj0AO3Ih1
        HNilq4PwHlgRJC1O/f/E67EBPl05q0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-cJgi5oy-N-SNSBOEjolWmw-1; Wed, 07 Oct 2020 16:08:58 -0400
X-MC-Unique: cJgi5oy-N-SNSBOEjolWmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB2B57001;
        Wed,  7 Oct 2020 20:08:57 +0000 (UTC)
Received: from ovpn-66-246.rdu2.redhat.com (ovpn-66-246.rdu2.redhat.com [10.10.66.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3A960BEC;
        Wed,  7 Oct 2020 20:08:51 +0000 (UTC)
Message-ID: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
Subject: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
From:   Qian Cai <cai@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Wed, 07 Oct 2020 16:08:50 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running some fuzzing by a unprivileged user on virtiofs could trigger the
warning below. The warning was introduced not long ago by the commit
c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
insertion").

From the logs, the last piece of the fuzzing code is:

fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)

[main]  testfile fd:426 filename:trinity-testfile2 flags:2 fopened:1 fcntl_flags:42c00 global:1
[main]   start: 0x7f39a58e6000 size:4KB  name: trinity-testfile2 global:1

[15969.175004][T179559] WARNING: CPU: 0 PID: 179559 at fs/fuse/file.c:1732 tree_insert.part.40+0x0/0x10 [fuse]
[15969.180644][T179559] Modules linked in: loop isofs kvm_intel kvm irqbypass nls_ascii nls_cp437 vfat fat ip_tables x_tables virtiofs fuse sr_mod sd_mod cdrom ata_piix virtio_pci virtio_ring e1000 virtio libat]
[15969.197671][T179559] CPU: 0 PID: 179559 Comm: trinity-c24 Tainted: G           O      5.9.0-rc8-next-20201007+ #1
[15969.204027][T179559] Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
[15969.208993][T179559] RIP: 0010:tree_insert.part.40+0x0/0x10 [fuse]
[15969.213593][T179559] Code: 44 24 10 48 8b 74 24 08 48 8b 0c 24 e9 40 fc ff ff 66 0f 1f 84 00 00 00 00 00 0f 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 b0
[15969.224348][T179559] RSP: 0018:ffffc90007fc77f8 EFLAGS: 00010286
[15969.227798][T179559] RAX: ffff8884b8f73500 RBX: ffff8884b8f76900 RCX: ffff8889e45ff910
[15969.233572][T179559] RDX: 0000000000000000 RSI: ffff8884b8f76900 RDI: ffff8884b8f735b0
[15969.238282][T179559] RBP: ffffea000550c880 R08: ffff8884b8f769f8 R09: fffff52000ff8ef2
[15969.243394][T179559] R10: 0000000000000003 R11: fffff52000ff8ef2 R12: ffff8889e45ff480
[15969.247845][T179559] R13: ffffea0004d71380 R14: ffff88818285c000 R15: ffff8889e45ff9b0
[15969.252884][T179559] FS:  00007f39a8ab7740(0000) GS:ffff888bcc600000(0000) knlGS:0000000000000000
[15969.258385][T179559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15969.262647][T179559] CR2: 000000000000008f CR3: 0000000557d56005 CR4: 0000000000770ef0
[15969.268492][T179559] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[15969.273773][T179559] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[15969.278030][T179559] PKRU: 55555554
[15969.279920][T179559] Call Trace:
[15969.282279][T179559]  fuse_writepage_locked+0xa20/0xd10 [fuse]
[15969.285587][T179559]  fuse_launder_page+0x5b/0xc0 [fuse]
[15969.288303][T179559]  invalidate_inode_pages2_range+0x709/0xa90
invalidate_inode_pages2_range at mm/truncate.c:765
[15969.292495][T179559]  ? truncate_exceptional_pvec_entries.part.18+0x460/0x460
[15969.296605][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.301015][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.304427][T179559]  ? rcu_read_unlock+0x40/0x40
[15969.306759][T179559]  ? _raw_spin_unlock+0x1a/0x30
[15969.309124][T179559]  ? fuse_change_attributes+0x237/0x540 [fuse]
[15969.313701][T179559]  fuse_do_getattr+0x28b/0xd50 [fuse]
fuse_do_getattr at fs/fuse/dir.c:962
[15969.316774][T179559]  ? do_syscall_64+0x33/0x40
[15969.319617][T179559]  ? fuse_dentry_revalidate+0x6c0/0x6c0 [fuse]
[15969.323498][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.326591][T179559]  ? find_held_lock+0x33/0x1c0
[15969.328989][T179559]  ? rwlock_bug.part.1+0x90/0x90
[15969.332202][T179559]  fuse_permission+0x29c/0x3c0 [fuse]
[15969.335564][T179559]  ? __kasan_kmalloc.constprop.11+0xc1/0xd0
[15969.338445][T179559]  inode_permission+0x2c1/0x390
[15969.342187][T179559]  vfs_getxattr+0x43/0x80
[15969.344605][T179559]  getxattr+0xe5/0x210
[15969.347120][T179559]  ? path_listxattr+0x100/0x100
[15969.350019][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.354014][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.356977][T179559]  ? find_held_lock+0x33/0x1c0
[15969.359631][T179559]  ? __task_pid_nr_ns+0x127/0x3a0
[15969.363099][T179559]  ? lock_downgrade+0x730/0x730
[15969.365714][T179559]  ? syscall_enter_from_user_mode+0x17/0x50
[15969.369104][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.374492][T179559]  __x64_sys_fgetxattr+0xd9/0x140
[15969.377317][T179559]  do_syscall_64+0x33/0x40
[15969.380588][T179559]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[15969.384059][T179559] RIP: 0033:0x7f39a83ca78d
[15969.386559][T179559] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8
[15969.399200][T179559] RSP: 002b:00007ffe920f3778 EFLAGS: 00000246 ORIG_RAX: 00000000000000c1
[15969.405661][T179559] RAX: ffffffffffffffda RBX: 00000000000000c1 RCX: 00007f39a83ca78d
[15969.411274][T179559] RDX: 00007f39a8abf000 RSI: 00007f39a69af000 RDI: 00000000000001aa
[15969.415813][T179559] RBP: 00000000000000c1 R08: 0000000004800000 R09: 000000000000003e
[15969.421984][T179559] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[15969.426794][T179559] R13: 00007f39a8a08058 R14: 00007f39a8ab76c0 R15: 00007f39a8a08000
[15969.432779][T179559] CPU: 0 PID: 179559 Comm: trinity-c24 Tainted: G           O      5.9.0-rc8-next-20201007+ #1
[15969.439042][T179559] Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
[15969.442756][T179559] Call Trace:
[15969.442756][T179559]  dump_stack+0x99/0xcb
[15969.448559][T179559]  __warn.cold.13+0xe/0x55
[15969.450606][T179559]  ? fuse_write_file_get.isra.35.part.36+0x10/0x10 [fuse]
[15969.450606][T179559]  report_bug+0x1af/0x260
[15969.460111][T179559]  handle_bug+0x44/0x80
[15969.462805][T179559]  exc_invalid_op+0x13/0x40
[15969.462805][T179559]  asm_exc_invalid_op+0x12/0x20
[15969.462805][T179559] RIP: 0010:tree_insert.part.40+0x0/0x10 [fuse]
[15969.474710][T179559] Code: 44 24 10 48 8b 74 24 08 48 8b 0c 24 e9 40 fc ff ff 66 0f 1f 84 00 00 00 00 00 0f 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 b0
[15969.474710][T179559] RSP: 0018:ffffc90007fc77f8 EFLAGS: 00010286
[15969.497893][T179559] RAX: ffff8884b8f73500 RBX: ffff8884b8f76900 RCX: ffff8889e45ff910
[15969.497893][T179559] RDX: 0000000000000000 RSI: ffff8884b8f76900 RDI: ffff8884b8f735b0
[15969.497893][T179559] RBP: ffffea000550c880 R08: ffff8884b8f769f8 R09: fffff52000ff8ef2
[15969.510577][T179559] R10: 0000000000000003 R11: fffff52000ff8ef2 R12: ffff8889e45ff480
[15969.516419][T179559] R13: ffffea0004d71380 R14: ffff88818285c000 R15: ffff8889e45ff9b0
[15969.516419][T179559]  fuse_writepage_locked+0xa20/0xd10 [fuse]
[15969.516419][T179559]  fuse_launder_page+0x5b/0xc0 [fuse]
[15969.532794][T179559]  invalidate_inode_pages2_range+0x709/0xa90
[15969.532794][T179559]  ? truncate_exceptional_pvec_entries.part.18+0x460/0x460
[15969.541808][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.544178][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.544178][T179559]  ? rcu_read_unlock+0x40/0x40
[15969.552839][T179559]  ? _raw_spin_unlock+0x1a/0x30
[15969.552839][T179559]  ? fuse_change_attributes+0x237/0x540 [fuse]
[15969.552839][T179559]  fuse_do_getattr+0x28b/0xd50 [fuse]
[15969.552839][T179559]  ? do_syscall_64+0x33/0x40
[15969.552839][T179559]  ? fuse_dentry_revalidate+0x6c0/0x6c0 [fuse]
[15969.552839][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.552839][T179559]  ? find_held_lock+0x33/0x1c0
[15969.552839][T179559]  ? rwlock_bug.part.1+0x90/0x90
[15969.552839][T179559]  fuse_permission+0x29c/0x3c0 [fuse]
[15969.552839][T179559]  ? __kasan_kmalloc.constprop.11+0xc1/0xd0
[15969.590685][T179559]  inode_permission+0x2c1/0x390
[15969.590685][T179559]  vfs_getxattr+0x43/0x80
[15969.590685][T179559]  getxattr+0xe5/0x210
[15969.590685][T179559]  ? path_listxattr+0x100/0x100
[15969.600479][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.600479][T179559]  ? rcu_read_lock_bh_held+0xb0/0xb0
[15969.600479][T179559]  ? find_held_lock+0x33/0x1c0
[15969.600479][T179559]  ? __task_pid_nr_ns+0x127/0x3a0
[15969.600479][T179559]  ? lock_downgrade+0x730/0x730
[15969.600479][T179559]  ? syscall_enter_from_user_mode+0x17/0x50
[15969.600479][T179559]  ? rcu_read_lock_sched_held+0x9c/0xd0
[15969.600479][T179559]  __x64_sys_fgetxattr+0xd9/0x140
[15969.630463][T179559]  do_syscall_64+0x33/0x40
[15969.630463][T179559]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[15969.630463][T179559] RIP: 0033:0x7f39a83ca78d
[15969.630463][T179559] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8
[15969.650571][T179559] RSP: 002b:00007ffe920f3778 EFLAGS: 00000246 ORIG_RAX: 00000000000000c1
[15969.650571][T179559] RAX: ffffffffffffffda RBX: 00000000000000c1 RCX: 00007f39a83ca78d
[15969.650571][T179559] RDX: 00007f39a8abf000 RSI: 00007f39a69af000 RDI: 00000000000001aa
[15969.672210][T179559] RBP: 00000000000000c1 R08: 0000000004800000 R09: 000000000000003e
[15969.672418][T179559] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[15969.680577][T179559] R13: 00007f39a8a08058 R14: 00007f39a8ab76c0 R15: 00007f39a8a08000
[15969.689364][T179559] irq event stamp: 2861013
[15969.692445][T179559] hardirqs last  enabled at (2861023): [<ffffffff84c2aecf>] console_unlock+0x81f/0xa20
[15969.698923][T179559] hardirqs last disabled at (2861030): [<ffffffff84c2addb>] console_unlock+0x72b/0xa20
[15969.706311][T179559] softirqs last  enabled at (2860498): [<ffffffff8600061b>] __do_softirq+0x61b/0x95d
[15969.713236][T179559] softirqs last disabled at (2860383): [<ffffffff85e00ec2>] asm_call_irq_on_stack+0x12/0x20
[15969.720777][T179559] ---[ end trace b6274835e0c14c38 ]---

