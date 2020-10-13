Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAD28D2D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgJMRLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 13:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbgJMRLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602609078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BxgJAedkTxNeoFEj4CJqnDSiOv0hQFrVuhZouCWEnGQ=;
        b=OumCOYdlqyB9HoSNW3qYlcGVxgVD2dvOGfjv96eLrUJNOR5NTtW/la1eH7WU0YsdXScMcL
        ALgJJNWPMl0yGhZiICdHDl7lElIZ3WK9yxDzJHIH3/ibXX3s5MDv/4XQ5zRvd4rkNOAAQ+
        v9Yuh1cm7ajI/dIsnaEfWbKUZMWYJ2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-2QdnnfHiO8-LLkuyxYudyw-1; Tue, 13 Oct 2020 13:11:14 -0400
X-MC-Unique: 2QdnnfHiO8-LLkuyxYudyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59B36408C;
        Tue, 13 Oct 2020 17:11:12 +0000 (UTC)
Received: from ovpn-118-16.rdu2.redhat.com (ovpn-118-16.rdu2.redhat.com [10.10.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFE973665;
        Tue, 13 Oct 2020 17:11:06 +0000 (UTC)
Message-ID: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
Subject: Unbreakable loop in fuse_fill_write_pages()
From:   Qian Cai <cai@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Tue, 13 Oct 2020 13:11:05 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running some fuzzing on virtiofs with an unprivileged user on today's linux-next 
could trigger soft-lockups below.

# virtiofsd --socket-path=/tmp/vhostqemu -o source=$TESTDIR -o cache=always -o no_posix_lock

Basically, everything was blocking on inode_lock(inode) because one thread
(trinity-c33) was holding it but stuck in the loop in fuse_fill_write_pages()
and unable to exit for more than 10 minutes before I executed sysrq-t.
Afterwards, the systems was totally unresponsive:

kernel:NMI watchdog: Watchdog detected hard LOCKUP on cpu 8

To exit the loop, it needs,

iov_iter_advance(ii, tmp) to set "tmp" to non-zero for each iteration.

and

	} while (iov_iter_count(ii) && count < fc->max_write &&
		 ap->num_pages < max_pages && offset == 0);

== the thread is stuck in the loop ==
[10813.290694] task:trinity-c33     state:D stack:25888 pid:254219 ppid: 87180
flags:0x00004004
[10813.292671] Call Trace:
[10813.293379]  __schedule+0x71d/0x1b50
[10813.294182]  ? __sched_text_start+0x8/0x8
[10813.295146]  ? mark_held_locks+0xb0/0x110
[10813.296117]  schedule+0xbf/0x270
[10813.296782]  ? __lock_page_killable+0x276/0x830
[10813.297867]  io_schedule+0x17/0x60
[10813.298772]  __lock_page_killable+0x33b/0x830
[10813.299695]  ? wait_on_page_bit+0x710/0x710
[10813.300609]  ? __lock_page_or_retry+0x3c0/0x3c0
[10813.301894]  ? up_read+0x1a3/0x730
[10813.302791]  ? page_cache_free_page.isra.45+0x390/0x390
[10813.304077]  filemap_fault+0x2bd/0x2040
[10813.305019]  ? read_cache_page_gfp+0x10/0x10
[10813.306041]  ? lock_downgrade+0x700/0x700
[10813.306958]  ? replace_page_cache_page+0x1130/0x1130
[10813.308124]  __do_fault+0xf5/0x530
[10813.308968]  handle_mm_fault+0x1c0e/0x25b0
[10813.309955]  ? copy_page_range+0xfe0/0xfe0
[10813.310895]  do_user_addr_fault+0x383/0x820
[10813.312084]  exc_page_fault+0x56/0xb0
[10813.312979]  asm_exc_page_fault+0x1e/0x30
[10813.313978] RIP: 0010:iov_iter_fault_in_readable+0x271/0x350
fault_in_pages_readable at include/linux/pagemap.h:745
(inlined by) iov_iter_fault_in_readable at lib/iov_iter.c:438
[10813.315293] Code: 48 39 d7 0f 82 1a ff ff ff 0f 01 cb 0f ae e8 44 89 c0 8a 0a
0f 01 ca 88 4c 24 70 85 c0 74 da e9 f8 fe ff ff 0f 01 cb 0f ae e8 <8a> 11 0f 01
ca 88 54 24 30 85 c0 0f 85 04 ff ff ff 48 29 ee e9
 45
[10813.319196] RSP: 0018:ffffc90017ccf830 EFLAGS: 00050246
[10813.320446] RAX: 0000000000000000 RBX: 1ffff92002f99f08 RCX: 00007fe284f1004c
[10813.322202] RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffff8887a7664000
[10813.323729] RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000000
[10813.325282] R10: ffffc90017ccfd48 R11: ffffed102789d5ff R12: ffff8887a7664020
[10813.326898] R13: ffffc90017ccfd40 R14: dffffc0000000000 R15: 0000000000e0df6a
[10813.328456]  ? iov_iter_revert+0x8e0/0x8e0
[10813.329404]  ? copyin+0x96/0xc0
[10813.330230]  ? iov_iter_copy_from_user_atomic+0x1f0/0xa40
[10813.331742]  fuse_perform_write+0x3eb/0xf20 [fuse]
fuse_fill_write_pages at fs/fuse/file.c:1150
(inlined by) fuse_perform_write at fs/fuse/file.c:1226
[10813.332880]  ? fuse_file_fallocate+0x5f0/0x5f0 [fuse]
[10813.334090]  fuse_file_write_iter+0x6b7/0x900 [fuse]
[10813.335191]  do_iter_readv_writev+0x42b/0x6d0
[10813.336161]  ? new_sync_write+0x610/0x610
[10813.337194]  do_iter_write+0x11f/0x5b0
[10813.338177]  ? __sb_start_write+0x229/0x2d0
[10813.339169]  vfs_writev+0x16d/0x2d0
[10813.339973]  ? vfs_iter_write+0xb0/0xb0
[10813.340950]  ? __fdget_pos+0x9c/0xb0
[10813.342039]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10813.343120]  ? rcu_read_lock_bh_held+0xb0/0xb0
[10813.344104]  ? find_held_lock+0x33/0x1c0
[10813.345050]  do_writev+0xfb/0x1e0
[10813.345920]  ? vfs_writev+0x2d0/0x2d0
[10813.346802]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10813.348026]  ? syscall_enter_from_user_mode+0x1c/0x50
[10813.349197]  do_syscall_64+0x33/0x40
[10813.350026]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

== soft-lockups ==
[10579.953730][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10579.955016][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10579.956467][  T348] task:trinity-c25     state:D stack:26704 pid:253906 ppid: 87180 flags:0x00004002
[10579.958028][  T348] Call Trace:
[10579.958609][  T348]  __schedule+0x71d/0x1b50
[10579.959309][  T348]  ? __sched_text_start+0x8/0x8
[10579.960144][  T348]  schedule+0xbf/0x270
[10579.960774][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10579.961828][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10579.962675][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10579.963721][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10579.964658][  T348]  ? lock_acquire+0x1c8/0x820
[10579.965453][  T348]  ? down_write+0x138/0x150
[10579.966237][  T348]  ? down_write+0xb3/0x150
[10579.966994][  T348]  down_write+0x138/0x150
[10579.967787][  T348]  ? down_write_killable_nested+0x170/0x170
[10579.968844][  T348]  fuse_flush+0x1a0/0x500 [fuse]
[10579.969732][  T348]  ? fuse_file_lock+0x190/0x190 [fuse]
[10579.970741][  T348]  filp_close+0x97/0x110
[10579.971560][  T348]  put_files_struct+0x15a/0x250
[10579.972393][  T348]  do_exit+0x8a9/0x23a0
[10579.973107][  T348]  ? mm_update_next_owner+0x740/0x740
[10579.974048][  T348]  ? up_read+0x1a3/0x730
[10579.974712][  T348]  ? down_read_nested+0x420/0x420
[10579.975589][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10579.976686][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10579.977625][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10579.978522][  T348]  do_group_exit+0xeb/0x2d0
[10579.979329][  T348]  __x64_sys_exit_group+0x35/0x40
[10579.980173][  T348]  do_syscall_64+0x33/0x40
[10579.980898][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10579.981979][  T348] RIP: 0033:0x7fe287a39256
[10579.982726][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a3922c.
[10579.983989][  T348] RSP: 002b:00007ffc5fb89ee8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[10579.985426][  T348] RAX: ffffffffffffffda RBX: 00007fe288002000 RCX: 00007fe287a39256
[10579.986747][  T348] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[10579.988090][  T348] RBP: 0000000000001000 R08: 00000000000000e7 R09: ffffffffffffff80
[10579.989422][  T348] R10: 0000000000000005 R11: 0000000000000206 R12: 00007fe288002001
[10579.990762][  T348] R13: 00007fe288002fe9 R14: 000000000000003a R15: 0000000055555556
[10579.992179][  T348] INFO: task trinity-c38:253929 blocked for more than 122 seconds.
[10579.993503][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10579.994787][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10579.996298][  T348] task:trinity-c38     state:D stack:26896 pid:253929 ppid: 87180 flags:0x00000004
[10579.997897][  T348] Call Trace:
[10579.998475][  T348]  __schedule+0x71d/0x1b50
[10579.999216][  T348]  ? __sched_text_start+0x8/0x8
[10580.000107][  T348]  schedule+0xbf/0x270
[10580.000823][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.001794][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.002676][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.003684][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.004650][  T348]  ? lock_acquire+0x1c8/0x820
[10580.005405][  T348]  ? chmod_common+0x148/0x390
[10580.006219][  T348]  ? lock_acquire+0x1c8/0x820
[10580.007035][  T348]  ? rcu_read_unlock+0x40/0x40
[10580.007765][  T348]  ? down_write+0x138/0x150
[10580.008562][  T348]  down_write+0x138/0x150
[10580.009244][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.010254][  T348]  ? __sb_start_write+0x229/0x2d0
[10580.011140][  T348]  chmod_common+0x148/0x390
[10580.011949][  T348]  ? __x64_sys_chroot+0x1e0/0x1e0
[10580.012740][  T348]  ? lock_downgrade+0x700/0x700
[10580.013567][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10580.014569][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.015460][  T348]  __x64_sys_fchmod+0x6c/0xa0
[10580.016249][  T348]  do_syscall_64+0x33/0x40
[10580.017004][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.017995][  T348] RIP: 0033:0x7fe287a6778d
[10580.018796][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a67763.
[10580.020098][  T348] RSP: 002b:00007ffc5fb8abe8 EFLAGS: 00000246 ORIG_RAX: 000000000000005b
[10580.021572][  T348] RAX: ffffffffffffffda RBX: 000000000000005b RCX: 00007fe287a6778d
[10580.022902][  T348] RDX: fffffffffffffffb RSI: 0000000000000084 RDI: 00000000000001a0
[10580.024246][  T348] RBP: 000000000000005b R08: 00000000bcbcbcbc R09: 00000000000000d8
[10580.025580][  T348] R10: 00bfa42b104256ef R11: 0000000000000246 R12: 0000000000000002
[10580.026934][  T348] R13: 00007fe288043058 R14: 00007fe2881546c0 R15: 00007fe288043000
[10580.028237][  T348] INFO: task trinity-c2:254053 blocked for more than 122 seconds.
[10580.029594][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.030838][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.032359][  T348] task:trinity-c2      state:D stack:26704 pid:254053 ppid: 87180 flags:0x00004002
[10580.033911][  T348] Call Trace:
[10580.034442][  T348]  __schedule+0x71d/0x1b50
[10580.035243][  T348]  ? __sched_text_start+0x8/0x8
[10580.036011][  T348]  schedule+0xbf/0x270
[10580.036750][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.037721][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.038554][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.039528][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.040460][  T348]  ? lock_acquire+0x1c8/0x820
[10580.041325][  T348]  ? down_write+0x138/0x150
[10580.042058][  T348]  ? down_write+0xb3/0x150
[10580.042833][  T348]  down_write+0x138/0x150
[10580.043535][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.044569][  T348]  fuse_flush+0x1a0/0x500 [fuse]
[10580.045408][  T348]  ? fuse_file_lock+0x190/0x190 [fuse]
[10580.046338][  T348]  filp_close+0x97/0x110
[10580.047069][  T348]  put_files_struct+0x15a/0x250
[10580.047884][  T348]  do_exit+0x8a9/0x23a0
[10580.048652][  T348]  ? mm_update_next_owner+0x740/0x740
[10580.049585][  T348]  ? up_read+0x1a3/0x730
[10580.050306][  T348]  ? down_read_nested+0x420/0x420
[10580.051309][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10580.052326][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.053330][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.054269][  T348]  do_group_exit+0xeb/0x2d0
[10580.054996][  T348]  __x64_sys_exit_group+0x35/0x40
[10580.055871][  T348]  do_syscall_64+0x33/0x40
[10580.056661][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.057602][  T348] RIP: 0033:0x7fe287a39256
[10580.058376][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a3922c.
[10580.059638][  T348] RSP: 002b:00007ffc5fb89f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[10580.061034][  T348] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe287a39256
[10580.062400][  T348] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[10580.063772][  T348] RBP: 0000000000001000 R08: 00000000000000e7 R09: ffffffffffffff80
[10580.065155][  T348] R10: 0000000000000005 R11: 0000000000000206 R12: 00007fe28813f058
[10580.066553][  T348] R13: 00007fe28813f058 R14: 0000000000000001 R15: 0000000000000030
[10580.067903][  T348] INFO: task trinity-c18:254111 blocked for more than 122 seconds.
[10580.069228][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.070412][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.071999][  T348] task:trinity-c18     state:D stack:26704 pid:254111 ppid: 87180 flags:0x00004002
[10580.073522][  T348] Call Trace:
[10580.074081][  T348]  __schedule+0x71d/0x1b50
[10580.074837][  T348]  ? __sched_text_start+0x8/0x8
[10580.075639][  T348]  schedule+0xbf/0x270
[10580.076359][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.077348][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.078158][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.079179][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.080200][  T348]  ? lock_acquire+0x1c8/0x820
[10580.080946][  T348]  ? down_write+0x138/0x150
[10580.081715][  T348]  ? down_write+0xb3/0x150
[10580.082530][  T348]  down_write+0x138/0x150
[10580.083205][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.084211][  T348]  fuse_flush+0x1a0/0x500 [fuse]
[10580.085075][  T348]  ? fuse_file_lock+0x190/0x190 [fuse]
[10580.085977][  T348]  filp_close+0x97/0x110
[10580.086671][  T348]  put_files_struct+0x15a/0x250
[10580.087576][  T348]  do_exit+0x8a9/0x23a0
[10580.088207][  T348]  ? _raw_spin_unlock+0x1/0x30
[10580.089073][  T348]  ? _raw_spin_unlock_irq+0x1f/0x30
[10580.090009][  T348]  ? signal_setup_done+0x1a3/0x230
[10580.090875][  T348]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10580.091871][  T348]  ? mm_update_next_owner+0x740/0x740
[10580.092796][  T348]  ? fpu__clear+0xd5/0x240
[10580.093593][  T348]  ? __local_bh_enable_ip+0xa0/0xf0
[10580.094518][  T348]  ? fpu__clear+0xeb/0x240
[10580.095331][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10580.096347][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.097322][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.098190][  T348]  do_group_exit+0xeb/0x2d0
[10580.099028][  T348]  __x64_sys_exit_group+0x35/0x40
[10580.099905][  T348]  do_syscall_64+0x33/0x40
[10580.100637][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.101694][  T348] RIP: 0033:0x7fe287a39256
[10580.102472][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a3922c.
[10580.103736][  T348] RSP: 002b:00007ffc5fb89ce8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[10580.105231][  T348] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007fe287a39256
[10580.106578][  T348] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[10580.107917][  T348] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[10580.109213][  T348] R10: 0000000000000005 R11: 0000000000000206 R12: 00007ffc5fb8aa00
[10580.110526][  T348] R13: 0000000000423e96 R14: 00007ffc5fb8ab40 R15: 0000000000000001
[10580.111923][  T348] INFO: task trinity-c14:254134 blocked for more than 123 seconds.
[10580.113207][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.114465][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.115942][  T348] task:trinity-c14     state:D stack:26448 pid:254134 ppid: 87180 flags:0x00000004
[10580.117496][  T348] Call Trace:
[10580.118065][  T348]  __schedule+0x71d/0x1b50
[10580.118804][  T348]  ? __sched_text_start+0x8/0x8
[10580.119711][  T348]  schedule+0xbf/0x270
[10580.120378][  T348]  schedule_preempt_disabled+0xc/0x20
[10580.121307][  T348]  __mutex_lock+0x9f1/0x1360
[10580.122117][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.122828][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
[10580.123780][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.124696][  T348]  ? rcu_read_lock_bh_held+0xb0/0xb0
[10580.125522][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.126289][  T348]  __fdget_pos+0x9c/0xb0
[10580.126981][  T348]  do_writev+0x6d/0x1e0
[10580.127650][  T348]  ? vfs_writev+0x2d0/0x2d0
[10580.128394][  T348]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10580.129423][  T348]  ? syscall_enter_from_user_mode+0x1c/0x50
[10580.130416][  T348]  do_syscall_64+0x33/0x40
[10580.131233][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.132250][  T348] RIP: 0033:0x7fe287a6778d
[10580.133013][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a67763.
[10580.134223][  T348] RSP: 002b:00007ffc5fb8abe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[10580.135718][  T348] RAX: ffffffffffffffda RBX: 0000000000000014 RCX: 00007fe287a6778d
[10580.137065][  T348] RDX: 0000000000000049 RSI: 000000000267d300 RDI: 00000000000001a0
[10580.138443][  T348] RBP: 0000000000000014 R08: 00000000efefefef R09: 000000005e5e5e5e
[10580.139820][  T348] R10: 0041a7001010e807 R11: 0000000000000246 R12: 0000000000000002
[10580.141190][  T348] R13: 00007fe2880eb058 R14: 00007fe2881546c0 R15: 00007fe2880eb000
[10580.142571][  T348] INFO: task trinity-c36:254165 blocked for more than 123 seconds.
[10580.143924][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.145158][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.146636][  T348] task:trinity-c36     state:D stack:26704 pid:254165 ppid: 87180 flags:0x00000004
[10580.148260][  T348] Call Trace:
[10580.148789][  T348]  __schedule+0x71d/0x1b50
[10580.149532][  T348]  ? __sched_text_start+0x8/0x8
[10580.150343][  T348]  schedule+0xbf/0x270
[10580.151044][  T348]  schedule_preempt_disabled+0xc/0x20
[10580.152006][  T348]  __mutex_lock+0x9f1/0x1360
[10580.152777][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.153484][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
[10580.154432][  T348]  ? find_held_lock+0x33/0x1c0
[10580.155220][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.155934][  T348]  __fdget_pos+0x9c/0xb0
[10580.156660][  T348]  __x64_sys_getdents+0xff/0x230
[10580.157488][  T348]  ? __x64_sys_old_readdir+0x170/0x170
[10580.158429][  T348]  ? iterate_dir+0x610/0x610
[10580.159176][  T348]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10580.160214][  T348]  ? syscall_enter_from_user_mode+0x1c/0x50
[10580.161253][  T348]  do_syscall_64+0x33/0x40
[10580.162005][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.162964][  T348] RIP: 0033:0x7fe287a6778d
[10580.163713][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a67763.
[10580.164940][  T348] RSP: 002b:00007ffc5fb8abe8 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
[10580.166354][  T348] RAX: ffffffffffffffda RBX: 000000000000004e RCX: 00007fe287a6778d
[10580.167703][  T348] RDX: 0000000000000004 RSI: 00007fe285f4c000 RDI: 00000000000001a0
[10580.169039][  T348] RBP: 000000000000004e R08: fffffffffffffff9 R09: fffffffffffffff6
[10580.170347][  T348] R10: 149a823509203c58 R11: 0000000000000246 R12: 0000000000000002
[10580.171835][  T348] R13: 00007fe288051058 R14: 00007fe2881546c0 R15: 00007fe288051000
[10580.173198][  T348] INFO: task trinity-c10:254420 blocked for more than 123 seconds.
[10580.174601][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.175869][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.177311][  T348] task:trinity-c10     state:D stack:26896 pid:254420 ppid: 87180 flags:0x00000004
[10580.178940][  T348] Call Trace:
[10580.179573][  T348]  __schedule+0x71d/0x1b50
[10580.180306][  T348]  ? __sched_text_start+0x8/0x8
[10580.181142][  T348]  schedule+0xbf/0x270
[10580.181874][  T348]  schedule_preempt_disabled+0xc/0x20
[10580.182748][  T348]  __mutex_lock+0x9f1/0x1360
[10580.183502][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.184251][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
[10580.185163][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.186072][  T348]  ? rcu_read_lock_bh_held+0xb0/0xb0
[10580.187012][  T348]  ? __task_pid_nr_ns+0x127/0x3a0
[10580.187871][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.188578][  T348]  __fdget_pos+0x9c/0xb0
[10580.189326][  T348]  ksys_read+0x66/0x1c0
[10580.189998][  T348]  ? vfs_write+0x5b0/0x5b0
[10580.190818][  T348]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10580.191920][  T348]  ? syscall_enter_from_user_mode+0x1c/0x50
[10580.192936][  T348]  do_syscall_64+0x33/0x40
[10580.193615][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.194632][  T348] RIP: 0033:0x7fe287a6778d
[10580.195401][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a67763.
[10580.196638][  T348] RSP: 002b:00007ffc5fb8abe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[10580.198043][  T348] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe287a6778d
[10580.199400][  T348] RDX: 0000000000001000 RSI: 00007fe285b4c000 RDI: 00000000000001a0
[10580.200781][  T348] RBP: 0000000000000000 R08: 00aa60de2c3afd2c R09: 000000000000e000
[10580.202209][  T348] R10: ffffffffffffffdb R11: 0000000000000246 R12: 0000000000000002
[10580.203567][  T348] R13: 00007fe288107058 R14: 00007fe2881546c0 R15: 00007fe288107000
[10580.204886][  T348] INFO: task trinity-c42:254437 blocked for more than 123 seconds.
[10580.206177][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.207398][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.208828][  T348] task:trinity-c42     state:D stack:27088 pid:254437 ppid: 87180 flags:0x00000004
[10580.210393][  T348] Call Trace:
[10580.210891][  T348]  __schedule+0x71d/0x1b50
[10580.211768][  T348]  ? __sched_text_start+0x8/0x8
[10580.212537][  T348]  schedule+0xbf/0x270
[10580.213236][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.214213][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.215010][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.215990][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.216942][  T348]  ? lock_acquire+0x1c8/0x820
[10580.217787][  T348]  ? mark_lock.part.47+0x109/0x1910
[10580.218584][  T348]  ? down_write+0x138/0x150
[10580.219335][  T348]  ? down_write+0xb3/0x150
[10580.220101][  T348]  down_write+0x138/0x150
[10580.220792][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.221843][  T348]  fuse_file_write_iter+0x22e/0x900 [fuse]
[10580.222859][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.223904][  T348]  new_sync_write+0x3aa/0x610
[10580.224631][  T348]  ? new_sync_read+0x600/0x600
[10580.225427][  T348]  ? vfs_write+0x36c/0x5b0
[10580.226166][  T348]  ? rcu_read_lock_any_held+0xcd/0xf0
[10580.227018][  T348]  vfs_write+0x3e9/0x5b0
[10580.227804][  T348]  ksys_pwrite64+0x116/0x140
[10580.228621][  T348]  ? __x64_sys_pread64+0xf0/0xf0
[10580.229375][  T348]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10580.230364][  T348]  ? syscall_enter_from_user_mode+0x1c/0x50
[10580.231427][  T348]  do_syscall_64+0x33/0x40
[10580.232203][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.233152][  T348] RIP: 0033:0x7fe287a6778d
[10580.233913][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a67763.
[10580.235172][  T348] RSP: 002b:00007ffc5fb8abe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
[10580.236639][  T348] RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007fe287a6778d
[10580.237930][  T348] RDX: 0000000000000986 RSI: 000000000266e960 RDI: 00000000000001a0
[10580.239174][  T348] RBP: 0000000000000012 R08: 00000000232714aa R09: 0000000000000077
[10580.240466][  T348] R10: 4200490003c05550 R11: 0000000000000246 R12: 0000000000000002
[10580.241848][  T348] R13: 00007fe288027058 R14: 00007fe2881546c0 R15: 00007fe288027000
[10580.243194][  T348] INFO: task trinity-subchil:254451 blocked for more than 123 seconds.
[10580.244565][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.245760][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.247194][  T348] task:trinity-subchil state:D stack:27664 pid:254451 ppid:254226 flags:0x00004000
[10580.248682][  T348] Call Trace:
[10580.249157][  T348]  __schedule+0x71d/0x1b50
[10580.249926][  T348]  ? __sched_text_start+0x8/0x8
[10580.250653][  T348]  schedule+0xbf/0x270
[10580.251479][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.252378][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.253114][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.254133][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.255099][  T348]  ? lock_acquire+0x1c8/0x820
[10580.255813][  T348]  ? down_write+0x138/0x150
[10580.256597][  T348]  ? down_write+0xb3/0x150
[10580.257350][  T348]  down_write+0x138/0x150
[10580.258012][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.259034][  T348]  fuse_flush+0x1a0/0x500 [fuse]
[10580.259927][  T348]  ? fuse_file_lock+0x190/0x190 [fuse]
[10580.260774][  T348]  filp_close+0x97/0x110
[10580.261521][  T348]  put_files_struct+0x15a/0x250
[10580.262402][  T348]  do_exit+0x8a9/0x23a0
[10580.263052][  T348]  ? mm_update_next_owner+0x740/0x740
[10580.263949][  T348]  ? up_read+0x1a3/0x730
[10580.264699][  T348]  ? down_read_nested+0x420/0x420
[10580.265463][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10580.266417][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.267335][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.268302][  T348]  do_group_exit+0xeb/0x2d0
[10580.268978][  T348]  __x64_sys_exit_group+0x35/0x40
[10580.269801][  T348]  do_syscall_64+0x33/0x40
[10580.270565][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.271568][  T348] RIP: 0033:0x7fe287a39256
[10580.272331][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a3922c.
[10580.273576][  T348] RSP: 002b:00007ffc5fb8ac68 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
[10580.275038][  T348] RAX: ffffffffffffffda RBX: 00007fe2880b3000 RCX: 00007fe287a39256
[10580.276310][  T348] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[10580.277673][  T348] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[10580.279016][  T348] R10: 0000000000000005 R11: 0000000000000202 R12: 00007fe2880b3000
[10580.280344][  T348] R13: 00007fe2880b3058 R14: 0000000000000000 R15: 0000000000000030
[10580.281779][  T348] INFO: task trinity-subchil:254452 blocked for more than 123 seconds.
[10580.283124][  T348]       Tainted: G           O      5.9.0-next-20201013+ #2
[10580.284289][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10580.285737][  T348] task:trinity-subchil state:D stack:27664 pid:254452 ppid:254342 flags:0x00004000
[10580.287279][  T348] Call Trace:
[10580.287752][  T348]  __schedule+0x71d/0x1b50
[10580.288578][  T348]  ? __sched_text_start+0x8/0x8
[10580.289384][  T348]  schedule+0xbf/0x270
[10580.289993][  T348]  rwsem_down_write_slowpath+0x8ea/0xf30
[10580.290973][  T348]  ? rwsem_mark_wake+0x8d0/0x8d0
[10580.291919][  T348]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[10580.292913][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.293864][  T348]  ? lock_acquire+0x1c8/0x820
[10580.294685][  T348]  ? down_write+0x138/0x150
[10580.295407][  T348]  ? down_write+0xb3/0x150
[10580.296178][  T348]  down_write+0x138/0x150
[10580.296964][  T348]  ? down_write_killable_nested+0x170/0x170
[10580.297959][  T348]  fuse_flush+0x1a0/0x500 [fuse]
[10580.298792][  T348]  ? fuse_file_lock+0x190/0x190 [fuse]
[10580.299719][  T348]  filp_close+0x97/0x110
[10580.300390][  T348]  put_files_struct+0x15a/0x250
[10580.301290][  T348]  do_exit+0x8a9/0x23a0
[10580.301918][  T348]  ? mm_update_next_owner+0x740/0x740
[10580.302843][  T348]  ? up_read+0x1a3/0x730
[10580.303605][  T348]  ? down_read_nested+0x420/0x420
[10580.304378][  T348]  ? syscall_enter_from_user_mode+0x17/0x50
[10580.305392][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.306346][  T348]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10580.307267][  T348]  do_group_exit+0xeb/0x2d0
[10580.307925][  T348]  __x64_sys_exit_group+0x35/0x40
[10580.308785][  T348]  do_syscall_64+0x33/0x40
[10580.309512][  T348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10580.310465][  T348] RIP: 0033:0x7fe287a39256
[10580.311280][  T348] Code: Unable to access opcode bytes at RIP 0x7fe287a3922c.
[10580.312520][  T348] RSP: 002b:00007ffc5fb8ac68 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
[10580.313932][  T348] RAX: ffffffffffffffda RBX: 00007fe2880c1000 RCX: 00007fe287a39256
[10580.315276][  T348] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[10580.316697][  T348] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[10580.318096][  T348] R10: 0000000000000005 R11: 0000000000000202 R12: 00007fe2880c1000
[10580.319423][  T348] R13: 00007fe2880c1058 R14: 0000000000000000 R15: 0000000000000030
[10580.320790][  T348] 
[10580.320790][  T348] Showing all locks held in the system:
[10580.322269][  T348] 1 lock held by khungtaskd/348:
[10580.323092][  T348]  #0: ffffffff984ceee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.52+0x0/0x30
[10580.324875][  T348] 2 locks held by systemd-journal/787:
[10580.325886][  T348] 5 locks held by in:imjournal/54792:
[10580.326834][  T348] 2 locks held by trinity-c11/253653:
[10580.327686][  T348]  #0: ffff888bccaf2098 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x9c9/0xec0
[10580.329282][  T348]  #1: ffffffff984ceee0 (rcu_read_lock){....}-{1:2}, at: perf_iterate_sb+0x0/0x510
[10580.330893][  T348] 1 lock held by trinity-c25/253906:
[10580.331886][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.333762][  T348] 2 locks held by trinity-c38/253929:
[10580.334690][  T348]  #0: ffff888133e59430 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x37/0xa0
[10580.336191][  T348]  #1: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: chmod_common+0x148/0x390
[10580.338056][  T348] 2 locks held by trinity-c3/254046:
[10580.338886][  T348]  #0: ffff888bcd1b2098 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x208/0x1b50
[10580.340366][  T348]  #1: ffff88814c96d620 (&ctx->lock){-.-.}-{2:2}, at: __perf_event_task_sched_out+0x41e/0x1450
[10580.342178][  T348] 1 lock held by trinity-c2/254053:
[10580.343074][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.344792][  T348] 1 lock held by trinity-c18/254111:
[10580.345695][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.347647][  T348] 1 lock held by trinity-c14/254134:
[10580.348480][  T348]  #0: ffff888765a3c730 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x9c/0xb0
[10580.350051][  T348] 1 lock held by trinity-c36/254165:
[10580.350867][  T348]  #0: ffff888765a3c730 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x9c/0xb0
[10580.352486][  T348] 3 locks held by trinity-c33/254219:
[10580.353342][  T348]  #0: ffff888765a3c730 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x9c/0xb0
[10580.354938][  T348]  #1: ffff888133e59430 (sb_writers#16){.+.+}-{0:0}, at: vfs_writev+0x20d/0x2d0
[10580.356485][  T348]  #2: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_file_write_iter+0x22e/0x900 [fuse]
[10580.358569][  T348] 2 locks held by trinity-c17/254306:
[10580.359425][  T348]  #0: ffff888bcca72098 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x9c9/0xec0
[10580.361024][  T348]  #1: ffff888926d8b820 (&ctx->lock){-.-.}-{2:2}, at: __perf_event_task_sched_out+0x41e/0x1450
[10580.362834][  T348] 2 locks held by trinity-c34/254348:
[10580.363761][  T348]  #0: ffff888bccc32098 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x208/0x1b50
[10580.365306][  T348]  #1: ffffffff984e2f08 (tk_core.seq.seqcount){----}-{0:0}, at: __perf_event_task_sched_out+0x41e/0x1450
[10580.367250][  T348] 1 lock held by trinity-c10/254420:
[10580.368134][  T348]  #0: ffff888765a3c730 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x9c/0xb0
[10580.369683][  T348] 2 locks held by trinity-c42/254437:
[10580.370590][  T348]  #0: ffff888133e59430 (sb_writers#16){.+.+}-{0:0}, at: vfs_write+0x36c/0x5b0
[10580.372159][  T348]  #1: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_file_write_iter+0x22e/0x900 [fuse]
[10580.374134][  T348] 1 lock held by trinity-subchil/254451:
[10580.375141][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.376963][  T348] 1 lock held by trinity-subchil/254452:
[10580.377925][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.379894][  T348] 1 lock held by trinity-c28/254453:
[10580.380783][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.382701][  T348] 1 lock held by trinity-subchil/254454:
[10580.383660][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.385554][  T348] 1 lock held by trinity-subchil/254455:
[10580.386562][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.388314][  T348] 1 lock held by trinity-c27/254456:
[10580.389224][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.391160][  T348] 1 lock held by trinity-subchil/254457:
[10580.392087][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.393979][  T348] 1 lock held by trinity-subchil/254460:
[10580.394948][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.396757][  T348] 1 lock held by trinity-c9/254461:
[10580.397644][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.399508][  T348] 1 lock held by trinity-subchil/254462:
[10580.400442][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.402424][  T348] 1 lock held by trinity-c24/254464:
[10580.403378][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.405237][  T348] 1 lock held by trinity-c46/254466:
[10580.406179][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.408058][  T348] 1 lock held by trinity-subchil/254468:
[10580.409026][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.410934][  T348] 1 lock held by trinity-c34/254469:
[10580.411903][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.413665][  T348] 1 lock held by trinity-subchil/254470:
[10580.414648][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.416421][  T348] 1 lock held by trinity-subchil/254471:
[10580.417365][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.419298][  T348] 1 lock held by trinity-subchil/254472:
[10580.420149][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.422064][  T348] 1 lock held by trinity-c30/254474:
[10580.422953][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.424714][  T348] 1 lock held by trinity-subchil/254475:
[10580.425695][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.427465][  T348] 1 lock held by trinity-c31/254476:
[10580.428366][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.430304][  T348] 1 lock held by trinity-c11/254477:
[10580.431160][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.433073][  T348] 1 lock held by trinity-c0/254478:
[10580.433979][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.435779][  T348] 1 lock held by trinity-subchil/254481:
[10580.436739][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.438628][  T348] 1 lock held by trinity-c29/254482:
[10580.439521][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.441414][  T348] 1 lock held by trinity-c8/254484:
[10580.442344][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.444198][  T348] 1 lock held by trinity-c5/254485:
[10580.445123][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.447055][  T348] 1 lock held by trinity-c15/254486:
[10580.447923][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.449816][  T348] 1 lock held by trinity-subchil/254487:
[10580.450749][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.452639][  T348] 1 lock held by trinity-c4/254488:
[10580.453494][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.455363][  T348] 1 lock held by trinity-subchil/254489:
[10580.456303][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.458074][  T348] 1 lock held by trinity-c3/254490:
[10580.458975][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.460773][  T348] 1 lock held by trinity-c21/254493:
[10580.461776][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.463657][  T348] 1 lock held by trinity-subchil/254495:
[10580.464497][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.466363][  T348] 1 lock held by trinity-subchil/254496:
[10580.467312][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.469139][  T348] 1 lock held by trinity-subchil/254497:
[10580.470096][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.471975][  T348] 1 lock held by trinity-c32/254498:
[10580.472774][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.474634][  T348] 1 lock held by trinity-c43/254499:
[10580.475441][  T348]  #0: ffff8886e59d2088 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_flush+0x1a0/0x500 [fuse]
[10580.477308][  T348] 
[10580.477652][  T348] =============================================
[10580.477652][  T348

