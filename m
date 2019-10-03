Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0357C9860
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfJCGk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 02:40:29 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59618 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfJCGk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:40:29 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 23D8A363142;
        Thu,  3 Oct 2019 16:40:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iFumk-0002ge-E2; Thu, 03 Oct 2019 16:40:22 +1000
Date:   Thu, 3 Oct 2019 16:40:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     xfs <linux-xfs@vger.kernel.org>, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Message-ID: <20191003064022.GX16973@dread.disaster.area>
References: <20191003015247.GI13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003015247.GI13108@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=AlvNkb72p1A4h0nWLzkA:9
        a=CjuIK1q_8ugA:10 a=bgkb7jb39BYA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-fsdevel, linux-block, tejun ]

On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> Does anyone /else/ see this crash in generic/299 on a V4 filesystem (tho
> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop up
> on generic/299 though only 80% of the time.
> 
> --D
> 
> [ 1806.186197] run fstests generic/299 at 2019-10-02 18:15:30
> [ 1808.279874] XFS (sdb): Mounting V4 Filesystem
> [ 1808.283519] XFS (sdb): Ending clean mount
> [ 1808.284530] XFS (sdb): Quotacheck needed: Please wait.
> [ 1808.317062] XFS (sdb): Quotacheck: Done.
> [ 1808.319821] Mounted xfs file system at /opt supports timestamps until 2038 (0x7fffffff)
> [ 1886.218794] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [ 1886.219787] #PF: supervisor read access in kernel mode
> [ 1886.220638] #PF: error_code(0x0000) - not-present page
> [ 1886.221496] PGD 0 P4D 0 
> [ 1886.221970] Oops: 0000 [#1] PREEMPT SMP
> [ 1886.222596] CPU: 2 PID: 227320 Comm: kworker/u10:2 Tainted: G        W         5.4.0-rc1-djw #rc1
> [ 1886.224016] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
> [ 1886.225261] Workqueue: writeback wb_workfn (flush-8:16)
> [ 1886.225926] RIP: 0010:__lock_acquire+0x4c3/0x1490
> [ 1886.226595] Code: 00 00 00 48 8b 74 24 48 65 48 33 34 25 28 00 00 00 8b 44 24 04 0f 85 a1 0f 00 00 48 83 c4 50 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 3f 20 66 6d 82 41 ba 00 00 00 00 45 0f 45 d0 83 fe 01 0f 87
> [ 1886.229146] RSP: 0000:ffffc900052c3bc0 EFLAGS: 00010002
> [ 1886.230008] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
> [ 1886.231238] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
> [ 1886.236382] RBP: ffff888077f80000 R08: 0000000000000001 R09: 0000000000000001
> [ 1886.241630] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [ 1886.243530] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000018
> [ 1886.244669] FS:  0000000000000000(0000) GS:ffff88807e000000(0000) knlGS:0000000000000000
> [ 1886.245941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1886.246913] CR2: 0000000000000018 CR3: 0000000072f7b003 CR4: 00000000001606a0
> [ 1886.247834] Call Trace:
> [ 1886.248217]  ? mark_held_locks+0x47/0x70
> [ 1886.248810]  ? trace_hardirqs_on_thunk+0x1a/0x20
> [ 1886.249445]  lock_acquire+0x90/0x180
> [ 1886.249876]  ? __wake_up_common_lock+0x62/0xc0
> [ 1886.250577]  _raw_spin_lock_irqsave+0x3e/0x80
> [ 1886.251327]  ? __wake_up_common_lock+0x62/0xc0
> [ 1886.252538]  __wake_up_common_lock+0x62/0xc0
> [ 1886.257318]  wb_workfn+0x10e/0x610
> [ 1886.260171]  ? __lock_acquire+0x268/0x1490
> [ 1886.266124]  ? process_one_work+0x1da/0x5d0
> [ 1886.266941]  process_one_work+0x25b/0x5d0
> [ 1886.267759]  worker_thread+0x3d/0x3a0
> [ 1886.268497]  ? process_one_work+0x5d0/0x5d0
> [ 1886.269285]  kthread+0x121/0x140
> [ 1886.269808]  ? kthread_park+0x80/0x80
> [ 1886.270317]  ret_from_fork+0x3a/0x50
> [ 1886.270811] Modules linked in: xfs libcrc32c dm_flakey ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip_set_hash_ip ip_set_hash_net xt_tcpudp bfq xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter sch_fq_codel ip_tables x_tables nfsv4 af_packet [last unloaded: scsi_debug]
> [ 1886.274144] Dumping ftrace buffer:
> [ 1886.274637]    (ftrace buffer empty)
> [ 1886.275129] CR2: 0000000000000018
> [ 1886.275567] ---[ end trace 20db199015efe614 ]---
> [ 1886.278601] RIP: 0010:__lock_acquire+0x4c3/0x1490
> [ 1886.283408] Code: 00 00 00 48 8b 74 24 48 65 48 33 34 25 28 00 00 00 8b 44 24 04 0f 85 a1 0f 00 00 48 83 c4 50 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 3f 20 66 6d 82 41 ba 00 00 00 00 45 0f 45 d0 83 fe 01 0f 87
> 

generic/270 w/ xfs-dax on pmem triggers it within 3 runs every time
here. Bisect points to this commit:

$ git bisect bad
5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d is the first bad commit
commit 5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d
Author: Tejun Heo <tj@kernel.org>
Date:   Mon Aug 26 09:06:52 2019 -0700

    writeback: Generalize and expose wb_completion
    
    wb_completion is used to track writeback completions.  We want to use
    it from memcg side for foreign inode flushes.  This patch updates it
    to remember the target waitq instead of assuming bdi->wb_waitq and
    expose it outside of fs-writeback.c.
    
    Reviewed-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Tejun Heo <tj@kernel.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 fs/fs-writeback.c                | 47 ++++++++++++----------------------------
 include/linux/backing-dev-defs.h | 20 +++++++++++++++++
 include/linux/backing-dev.h      |  2 ++
 3 files changed, 36 insertions(+), 33 deletions(-)


$ git bisect log
git bisect start
# bad: [3a8e9ac89e6a5106cfb6b85d4c9cf9bfa3519bc7] writeback: add tracepoints for cgroup foreign writebacks
git bisect bad 3a8e9ac89e6a5106cfb6b85d4c9cf9bfa3519bc7
# good: [b8e24a9300b0836a9d39f6b20746766b3b81f1bd] block: annotate refault stalls from IO submission
git bisect good b8e24a9300b0836a9d39f6b20746766b3b81f1bd
# bad: [ed288dc0d4aa29f65bd25b31b5cb866aa5664ff9] writeback: Separate out wb_get_lookup() from wb_get_create()
git bisect bad ed288dc0d4aa29f65bd25b31b5cb866aa5664ff9
# good: [320ea869a12cec206756207c6ca5f817ec45c7f2] block: improve the gap check in __bio_add_pc_page
git bisect good 320ea869a12cec206756207c6ca5f817ec45c7f2
# good: [7ea88e229e9df18ecd624b0d39f3dba87432ba33] null_blk: create a helper for mem-backed ops
git bisect good 7ea88e229e9df18ecd624b0d39f3dba87432ba33
# good: [38b4e09fbccab6457536563823222921c49601bb] null_blk: fix inline misuse
git bisect good 38b4e09fbccab6457536563823222921c49601bb
# bad: [34f8fe501f0624de115d087680c84000b5d9abc9] bdi: Add bdi->id
git bisect bad 34f8fe501f0624de115d087680c84000b5d9abc9
# bad: [5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d] writeback: Generalize and expose wb_completion
git bisect bad 5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d
# first bad commit: [5b9cce4c7eb0696558dfd4946074ae1fb9d8f05d] writeback: Generalize and expose wb_completio
$

Not obvious to me what is wrong with that commit right now, but the
bisect is solid. Kinda surprised to see such significant
fs-writeback changes in 5.4, though, because there was nothing sent
to the -fsdevel list for review in the last dev cycle.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
