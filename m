Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACB3B99E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 02:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhGBAIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 20:08:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38655 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234063AbhGBAIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:08:32 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3A27610451FC;
        Fri,  2 Jul 2021 10:05:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lz6gv-001hPP-7o; Fri, 02 Jul 2021 10:05:57 +1000
Date:   Fri, 2 Jul 2021 10:05:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org,
        CKI Project <cki-project@redhat.com>
Subject: Re: 1 lock held by xfs_repair/276634
Message-ID: <20210702000557.GA219491@dread.disaster.area>
References: <CA+QYu4pPRr-KQB2b1YsZSYfAb11_hnL+UH8WTj3N5_x9yX8WnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4pPRr-KQB2b1YsZSYfAb11_hnL+UH8WTj3N5_x9yX8WnA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=VwQbUJbxAAAA:8 a=CFcHuH0UAAAA:20
        a=vfzsticYAAAA:8 a=7-415B0cAAAA:8 a=xKs6jjFv48UruDLS-AEA:9
        a=CjuIK1q_8ugA:10 a=lxpmHu_XA5BgEnvxp0EM:22 a=NWVoK91CQySWRX1oVYDe:22
        a=AjGcO6oz07-iQ99wixmX:22 a=yVpCJ3KIzPkIoG9xwaWi:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 12:44:30PM +0200, Bruno Goncalves wrote:
> Hello,
> 
> We have hit this lock problem during xfstest [1] on aarch64. The whole
> console.log is available on [2].

fstests is not the place to report test failures. They should be
directed to the list for the subsystem that failed. In this case,
probably linux-xfs@vger.kernel.org. I haven't cc'd that list
because....

> 
> 10847.013727] run fstests generic/023 at 2021-05-15 17:21:46
> [10863.635560] XFS (sda4): Unmounting Filesystem
> [10865.095328] BUG: sleeping function called from invalid context at (null):3550
> [10865.102695] in_atomic(): 0, irqs_disabled(): 128, non_block: 0,
> pid: 276634, name: xfs_repair
> [10865.111223] 1 lock held by xfs_repair/276634:
> [10865.115579]  #0: ffff000168f654d0
> (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_exit_release+0x40/0xe4
> [10865.125091] irq event stamp: 150
> [10865.128314] hardirqs last  enabled at (149): [<ffff8000101a2778>]
> uaccess_ttbr0_enable+0xa8/0xc0
> [10865.137096] hardirqs last disabled at (150): [<ffff8000101a2838>]
> uaccess_ttbr0_disable+0xa8/0xb4
> [10865.145964] softirqs last  enabled at (132): [<ffff800010016490>]
> put_cpu_fpsimd_context+0x30/0x70
> [10865.154921] softirqs last disabled at (130): [<ffff800010016408>]
> get_cpu_fpsimd_context+0x8/0x60
> [10865.163792] CPU: 31 PID: 276634 Comm: xfs_repair Not tainted 5.13.0-rc1 #1
> [10865.170663] Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS
> F02 08/06/2019
> [10865.178054] Call trace:
> [10865.180496]  dump_backtrace+0x0/0x1c0
> [10865.184156]  show_stack+0x24/0x30
> [10865.187467]  dump_stack+0xf8/0x164
> [10865.190867]  ___might_sleep+0x174/0x250
> [10865.194700]  __might_sleep+0x60/0xa0
> [10865.198272]  __might_fault+0x3c/0x90
> [10865.201847]  exit_robust_list+0xac/0x36c
> [10865.205767]  exit_robust_list+0x9c/0x36c
> [10865.209686]  futex_exit_release+0xa8/0xe4
> [10865.213692]  exit_mm_release+0x28/0x44
> [10865.217438]  exit_mm+0x2c/0x27c
> [10865.220579]  do_exit+0x1f0/0x454
> [10865.223804]  __arm64_sys_exit+0x24/0x2c
> [10865.227638]  invoke_syscall+0x50/0x120
> [10865.231384]  el0_svc_common.constprop.0+0x68/0x104
> [10865.236172]  do_el0_svc+0x30/0x9c
> [10865.239483]  el0_svc+0x2c/0x54
> [10865.242538]  el0_sync_handler+0x1a4/0x1b0
> [10865.246544]  el0_sync+0x19c/0x1c0

... this is likely a futex bug or some other platform kernel
bug.  xfs_repair is just the userspace application that is tripping
over it.

> We don't reproduce this often, but the first time I've seen it was
> with 'Commit: f36edc5533b2 - Merge tag 'arc-5.13-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc'
> 
> [1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
> [2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/05/15/303402899/build_aarch64_redhat%3A1264727321/tests/9991652_aarch64_2_console.log

Yup, there's a second occurrence of this same "sleeping in
invalid context" bug from something called "stress-ng" on a rwsem:

[ 2277.799926] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1352 
[ 2277.808464] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 125191, name: stress-ng 
[ 2277.816908] no locks held by stress-ng/125191. 
[ 2277.821356] irq event stamp: 2482 
[ 2277.824682] hardirqs last  enabled at (2481): [<ffff800010341e0c>] __uaccess_ttbr0_enable+0x7c/0x90 
[ 2277.833742] hardirqs last disabled at (2482): [<ffff800010342130>] __do_sys_mincore+0x310/0x354 
[ 2277.842448] softirqs last  enabled at (30): [<ffff800010016490>] put_cpu_fpsimd_context+0x30/0x70 
[ 2277.851329] softirqs last disabled at (28): [<ffff800010016408>] get_cpu_fpsimd_context+0x8/0x60 
[ 2277.860125] CPU: 11 PID: 125191 Comm: stress-ng Not tainted 5.13.0-rc1 #1 
[ 2277.866919] Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS F02 08/06/2019 
[ 2277.874319] Call trace: 
[ 2277.876772]  dump_backtrace+0x0/0x1c0 
[ 2277.880443]  show_stack+0x24/0x30 
[ 2277.883765]  dump_stack+0xf8/0x164 
[ 2277.887170]  ___might_sleep+0x174/0x250 
[ 2277.891003]  __might_sleep+0x60/0xa0 
[ 2277.894575]  down_read+0x38/0xa0 
[ 2277.897802]  __do_sys_mincore+0xe0/0x354 
[ 2277.901723]  __arm64_sys_mincore+0x28/0x8c 
[ 2277.905816]  invoke_syscall+0x50/0x120 
[ 2277.909563]  el0_svc_common.constprop.0+0x68/0x104 
[ 2277.914350]  do_el0_svc+0x30/0x9c 
[ 2277.917661]  el0_svc+0x2c/0x54 
[ 2277.920716]  el0_sync_handler+0x1a4/0x1b0 
[ 2277.924722]  el0_sync+0x19c/0x1c0 

There are also RCU lock warnings immediately after this:

"kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!"

occuring in core memory allocation code, followed by other
interleaved warning mess.

So, really, this looks like a platform bug or unbalanced irq
enable/disable somewhere in the kernel and has nothing to do with
the xfs_repair process that triggered it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
