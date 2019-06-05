Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA26F35E67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFENyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 09:54:07 -0400
Received: from foss.arm.com ([217.140.101.70]:60536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFENyG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:54:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A8180D;
        Wed,  5 Jun 2019 06:54:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455D73F246;
        Wed,  5 Jun 2019 06:54:04 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:54:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: "Dentry still in use" splats in v5.2-rc3
Message-ID: <20190605135401.GB30925@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

While fuzzing arm64 v5.2-rc3, Syzkaller started hitting splats of the
form:

    BUG: Dentry (____ptrval____){i=1,n=/}  still in use (2) [unmount of bpf bpf]

... which I can reliably reproduce with the following C program
(partially minimized from what Syzkaller auto-generated).

It looks like any filesystem will do. I've seen splats with "bpf",
"hugetlbfs", "rpc_pipefs", and "tmpfs", and can reproduce the problem
with any of these.

Any ideas?

I'm using the config from my fuzzing/5.2-rc3 branch on kernel.org [1].

Thanks,
Mark.

----
#include <unistd.h>
#include <sys/syscall.h>

/*
 * NOTE: these are the arm64 numbers
 */
#ifndef __NR_fsconfig
#define __NR_fsconfig 431
#endif
#ifndef __NR_fsmount
#define __NR_fsmount 432
#endif
#ifndef __NR_fsopen
#define __NR_fsopen 430
#endif

int main(void)
{
        int fs, mnt;

        fs = syscall(__NR_fsopen, "bpf", 0);
        syscall(__NR_fsconfig, fs, 6, 0, 0, 0);
        mnt = syscall(__NR_fsmount, fs, 0, 0);
        fchdir(mnt);

        close(fs);
        close(mnt);
}

----

----
[   29.746323][  T245] BUG: Dentry (____ptrval____){i=1,n=/}  still in use (2) [unmount of bpf bpf]
[   29.748645][  T245] WARNING: CPU: 3 PID: 245 at fs/dcache.c:1529 umount_check+0x170/0x1b8
[   29.750313][  T245] CPU: 3 PID: 245 Comm: repro Not tainted 5.2.0-rc3-00004-gff694e8 #1
[   29.752165][  T245] Hardware name: linux,dummy-virt (DT)
[   29.753406][  T245] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   29.754640][  T245] pc : umount_check+0x170/0x1b8
[   29.755708][  T245] lr : umount_check+0x170/0x1b8
[   29.756821][  T245] sp : ffff8000647b7ac0
[   29.757730][  T245] x29: ffff8000647b7ac0 x28: ffff20001073dc38 
[   29.759047][  T245] x27: ffff8000666f4788 x26: ffff800064732040 
[   29.760428][  T245] x25: ffff10000c8e6325 x24: ffff200014f62500 
[   29.761755][  T245] x23: 0000000000000001 x22: ffff200015041e80 
[   29.763061][  T245] x21: ffff8000647aec80 x20: 0000000000000002 
[   29.764441][  T245] x19: ffff8000666f4788 x18: 0000000000000000 
[   29.765764][  T245] x17: 0000000000000000 x16: 0000000000000000 
[   29.767064][  T245] x15: 0000000000000000 x14: ffff200014f70788 
[   29.768445][  T245] x13: 00000000f2000000 x12: ffff10000d566546 
[   29.769774][  T245] x11: 1ffff0000d566545 x10: ffff10000d566545 
[   29.771098][  T245] x9 : 1ffff0000d566545 x8 : dfff200000000000 
[   29.772484][  T245] x7 : ffff10000d566546 x6 : ffff80006ab32a2f 
[   29.773820][  T245] x5 : ffff10000d566546 x4 : ffff10000d566546 
[   29.775155][  T245] x3 : 1fffe40002d30afc x2 : 24cbddc7f4015a00 
[   29.776539][  T245] x1 : 0000000000000000 x0 : 000000000000004c 
[   29.777868][  T245] Call trace:
[   29.778598][  T245]  umount_check+0x170/0x1b8
[   29.779574][  T245]  d_walk.part.2+0x100/0x6a0
[   29.780610][  T245]  do_one_tree+0x34/0x58
[   29.781577][  T245]  shrink_dcache_for_umount+0x60/0x110
[   29.782752][  T245]  generic_shutdown_super+0x68/0x360
[   29.783913][  T245]  kill_anon_super+0x44/0x70
[   29.784932][  T245]  kill_litter_super+0x4c/0x60
[   29.786054][  T245]  deactivate_locked_super+0x8c/0xf0
[   29.787214][  T245]  deactivate_super+0xd8/0xf8
[   29.788278][  T245]  cleanup_mnt+0x90/0x128
[   29.789388][  T245]  __cleanup_mnt+0x1c/0x28
[   29.790362][  T245]  task_work_run+0x124/0x198
[   29.791374][  T245]  do_notify_resume+0x664/0x778
[   29.792440][  T245]  work_pending+0x8/0x14
[   29.793439][  T245] irq event stamp: 1502
[   29.794374][  T245] hardirqs last  enabled at (1501): [<ffff2000102afd48>] console_unlock+0x700/0xcc0
[   29.796424][  T245] hardirqs last disabled at (1502): [<ffff200010082110>] do_debug_exception+0x118/0x438
[   29.798605][  T245] softirqs last  enabled at (1498): [<ffff200010083574>] __do_softirq+0xbc4/0x10c8
[   29.800639][  T245] softirqs last disabled at (1443): [<ffff20001019f96c>] irq_exit+0x2c4/0x338
[   29.802581][  T245] ---[ end trace cd8baed7622b7c8b ]---
[   29.804034][  T245] VFS: Busy inodes after unmount of bpf. Self-destruct in 5 seconds.  Have a nice day...
----

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git fuzzing/5.2-rc3
