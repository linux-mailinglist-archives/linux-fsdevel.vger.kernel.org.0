Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E813CA39C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhGORNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 13:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhGORNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A4E613CC;
        Thu, 15 Jul 2021 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626369050;
        bh=+ayAiRpCIpf3ASBtjjuElicFKPHwiSZC5A0/PmNIOnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9sjMOdmbJenTa3awNb2roq0qUAzvY3W9ByO1Wu9qAu/UI8tdlMzRz32dxxujgVeQ
         NsbTDpY/cmT86qY02Egk3Q5wP5xxc5Jqp6EVK6sxFDTsEHSIlUQ1OxjDSfKdA+sOLx
         XexF1Zkw4z5Ky38/Zhd73EUo5fdmqQxG4orEafDGNkBZbi4AdSrcheZAnZg2TCQOYQ
         YEVqYVd5I7siEY5Tc6pw1udUt2wwvdc90c6hc9Up1thLdH8Dp9wJD/emjO3u6UR9IS
         w4q6XpoLFGksoUi7o33smnT8dm1dTkTZIUJebpl0B6CycO/bq0BdFshaOpulZScd3X
         arXOjrnlvNyhg==
Date:   Thu, 15 Jul 2021 10:10:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Roman Gushchin <guro@fb.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <20210715171050.GB22357@magnolia>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org>
 <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:51:50AM +0800, Boyang Xue wrote:
> On Thu, Jul 15, 2021 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > It's unclear to me that where to find the required address in the
> > > addr2line command line, i.e.
> > >
> > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > <what address here?>
> >
> > ./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394
> >
> 
> Thanks! The result is the same as the
> 
> addr2line -i -e
> /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> FFFF8000102D6DD0
> 
> But this script is very handy.
> 
> # /usr/src/kernels/5.14.0-0.rc1.15.bx.el9.aarch64/scripts/faddr2line
> /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> cleanup_offlin
> e_cgwbs_workfn+0x320/0x394
> cleanup_offline_cgwbs_workfn+0x320/0x394:
> arch_atomic64_fetch_add_unless at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
> (inlined by) arch_atomic64_add_unless at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
> (inlined by) atomic64_add_unless at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
> (inlined by) atomic_long_add_unless at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
> (inlined by) percpu_ref_tryget_many at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
> (inlined by) percpu_ref_tryget at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
> (inlined by) wb_tryget at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
> (inlined by) wb_tryget at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
> (inlined by) cleanup_offline_cgwbs_workfn at
> /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679
> 
> # vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
> ```
> static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> {
>         struct bdi_writeback *wb;
>         LIST_HEAD(processed);
> 
>         spin_lock_irq(&cgwb_lock);
> 
>         while (!list_empty(&offline_cgwbs)) {
>                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
>                                       offline_node);
>                 list_move(&wb->offline_node, &processed);
> 
>                 /*
>                  * If wb is dirty, cleaning up the writeback by switching
>                  * attached inodes will result in an effective removal of any
>                  * bandwidth restrictions, which isn't the goal.  Instead,
>                  * it can be postponed until the next time, when all io
>                  * will be likely completed.  If in the meantime some inodes
>                  * will get re-dirtied, they should be eventually switched to
>                  * a new cgwb.
>                  */
>                 if (wb_has_dirty_io(wb))
>                         continue;
> 
>                 if (!wb_tryget(wb))  <=== line#679
>                         continue;
> 
>                 spin_unlock_irq(&cgwb_lock);
>                 while (cleanup_offline_cgwb(wb))
>                         cond_resched();
>                 spin_lock_irq(&cgwb_lock);
> 
>                 wb_put(wb);
>         }
> 
>         if (!list_empty(&processed))
>                 list_splice_tail(&processed, &offline_cgwbs);
> 
>         spin_unlock_irq(&cgwb_lock);
> }
> ```
> 
> BTW, this bug can be only reproduced on a non-debug production built
> kernel (a.k.a kernel rpm package), it's not reproducible on a debug
> build with various debug configuration enabled (a.k.a kernel-debug rpm
> package)

FWIW I've also seen this regularly on x86_64 kernels on ext4 with all
default mkfs settings when running generic/256.

# FSTYP=ext4 MOUNT_OPTIONS="-o acl,user_xattr," ./check
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 flax-mtr00 5.14.0-rc1-xfsx #rc1 SMP
PREEMPT Wed Jul 14 17:36:18 PDT 2021
MKFS_OPTIONS  -- /dev/sdf
MOUNT_OPTIONS -- -o acl,user_xattr, /dev/sdf /opt

generic/256
Message from syslogd@flax-mtr00 at Jul 15 09:58:14 ...
 kernel:[ 2508.987522] Dumping ftrace buffer:

And the dmesg looks like:

run fstests generic/256 at 2021-07-15 09:56:34
EXT4-fs (sdf): mounted filesystem with ordered data mode. Opts: acl,user_xattr. Quota mode: none.
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 108604 Comm: u9:3 Not tainted 5.14.0-rc1-xfsx #rc1 486fb938eb99d57e79080268009b49f63f777aec
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_unbound cleanup_offline_cgwbs_workfn
RIP: 0010:cleanup_offline_cgwbs_workfn+0x1ef/0x220
Code: ff ff f0 48 83 28 01 0f 85 55 ff ff ff 48 8b 83 60 ff ff ff 48 8d bb 58 ff ff ff ff 50 08 e9 3f ff ff ff 48 8b 93 60 ff ff ff <48> 8b 02 48 85 c0 0f 84 2c ff ff ff 48 8d 48 01 f0 48 0f b1 0a 75
RSP: 0018:ffffc9000278be60 EFLAGS: 00010006
RAX: 0000000000000003 RBX: ffff888282dc0b30 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffc9000278be60 RDI: ffff888282dc0b30
RBP: ffff888282dc0800 R08: ffff88828006af30 R09: ffff88828006af30
R10: 000000000000000f R11: 000000000000000f R12: ffffc9000278be60
R13: ffff8881000d6800 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000102262003 CR4: 00000000001706a0
Call Trace:
 process_one_work+0x1dd/0x3c0
 worker_thread+0x53/0x3c0
 ? rescuer_thread+0x390/0x390
 kthread+0x149/0x170
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x1f/0x30
Modules linked in: ext2 ext4 jbd2 dm_flakey mbcache xfs libcrc32c ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables bfq iptable_filter pvpanic_mmio pvpanic sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: jbd2]
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 242113b767739fb9 ]---

The faddr2line output points at the same line of code.

--D
