Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58C11FD7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 05:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLPEJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 23:09:15 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43516 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfLPEJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 23:09:15 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2AC147E941C;
        Mon, 16 Dec 2019 15:09:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ighgz-0007Uv-AQ; Mon, 16 Dec 2019 15:09:09 +1100
Date:   Mon, 16 Dec 2019 15:09:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: stop shrinker while fs is freezed
Message-ID: <20191216040909.GJ19213@dread.disaster.area>
References: <20191213222440.11519-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213222440.11519-1-junxiao.bi@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=71tRPUrxQiDM1EGBlgAA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:24:40PM -0800, Junxiao Bi wrote:
> Shrinker could be blocked by freeze while dropping the last reference of
> some inode that had been removed. As "s_umount" lock was acquired by the
> Shrinker before blocked, the thaw will hung by this lock. This caused a
> deadlock.
> 
>  crash7latest> set 132
>      PID: 132
>  COMMAND: "kswapd0:0"
>     TASK: ffff9cdc9dfb5f00  [THREAD_INFO: ffff9cdc9dfb5f00]
>      CPU: 6
>    STATE: TASK_UNINTERRUPTIBLE
>  crash7latest> bt
>  PID: 132    TASK: ffff9cdc9dfb5f00  CPU: 6   COMMAND: "kswapd0:0"
>   #0 [ffffaa5d075bf900] __schedule at ffffffff8186487c
>   #1 [ffffaa5d075bf998] schedule at ffffffff81864e96
>   #2 [ffffaa5d075bf9b0] rwsem_down_read_failed at ffffffff818689ee
>   #3 [ffffaa5d075bfa40] call_rwsem_down_read_failed at ffffffff81859308
>   #4 [ffffaa5d075bfa90] __percpu_down_read at ffffffff810ebd38
>   #5 [ffffaa5d075bfab0] __sb_start_write at ffffffff812859ef
>   #6 [ffffaa5d075bfad0] xfs_trans_alloc at ffffffffc07ebe9c [xfs]
>   #7 [ffffaa5d075bfb18] xfs_free_eofblocks at ffffffffc07c39d1 [xfs]
>   #8 [ffffaa5d075bfb80] xfs_inactive at ffffffffc07de878 [xfs]
>   #9 [ffffaa5d075bfba0] __dta_xfs_fs_destroy_inode_3543 at ffffffffc07e885e [xfs]
>  #10 [ffffaa5d075bfbd0] destroy_inode at ffffffff812a25de
>  #11 [ffffaa5d075bfbe8] evict at ffffffff812a2b73
>  #12 [ffffaa5d075bfc10] dispose_list at ffffffff812a2c1d
>  #13 [ffffaa5d075bfc38] prune_icache_sb at ffffffff812a421a
>  #14 [ffffaa5d075bfc70] super_cache_scan at ffffffff812870a1
>  #15 [ffffaa5d075bfcc8] shrink_slab at ffffffff811eebb3
>  #16 [ffffaa5d075bfdb0] shrink_node at ffffffff811f4788
>  #17 [ffffaa5d075bfe38] kswapd at ffffffff811f58c3
>  #18 [ffffaa5d075bff08] kthread at ffffffff810b75d5
>  #19 [ffffaa5d075bff50] ret_from_fork at ffffffff81a0035e

How did you get a file that needed EOF block trimming to be disposed
of when the filesystem is frozen?

Part of freezing the filesystem is tossing all the reclaimable
inodes out of the cache, which means all the inodes that might
require EOF block trimming should have already been removed from the
cache before the freeze goes into effect....

>  crash7latest> set 31060
>      PID: 31060
>  COMMAND: "safefreeze"
>     TASK: ffff9cd292868000  [THREAD_INFO: ffff9cd292868000]
>      CPU: 2
>    STATE: TASK_UNINTERRUPTIBLE
>  crash7latest> bt
>  PID: 31060  TASK: ffff9cd292868000  CPU: 2   COMMAND: "safefreeze"
>   #0 [ffffaa5d10047c90] __schedule at ffffffff8186487c
>   #1 [ffffaa5d10047d28] schedule at ffffffff81864e96
>   #2 [ffffaa5d10047d40] rwsem_down_write_failed at ffffffff81868f18
>   #3 [ffffaa5d10047dd8] call_rwsem_down_write_failed at ffffffff81859367
>   #4 [ffffaa5d10047e20] down_write at ffffffff81867cfd
>   #5 [ffffaa5d10047e38] thaw_super at ffffffff81285d2d
>   #6 [ffffaa5d10047e60] do_vfs_ioctl at ffffffff81299566
>   #7 [ffffaa5d10047ee8] sys_ioctl at ffffffff81299709
>   #8 [ffffaa5d10047f28] do_syscall_64 at ffffffff81003949
>   #9 [ffffaa5d10047f50] entry_SYSCALL_64_after_hwframe at ffffffff81a001ad
>      RIP: 0000000000453d67  RSP: 00007ffff9c1ce78  RFLAGS: 00000206
>      RAX: ffffffffffffffda  RBX: 0000000001cbe92c  RCX: 0000000000453d67
>      RDX: 0000000000000000  RSI: 00000000c0045878  RDI: 0000000000000014
>      RBP: 00007ffff9c1cf80   R8: 0000000000000000   R9: 0000000000000012
>      R10: 0000000000000008  R11: 0000000000000206  R12: 0000000000401fb0
>      R13: 0000000000402040  R14: 0000000000000000  R15: 0000000000000000
>      ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b
> 
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  fs/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index cfadab2cbf35..adc18652302b 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -80,6 +80,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  	if (!trylock_super(sb))
>  		return SHRINK_STOP;
>  
> +	if (sb->s_writers.frozen != SB_UNFROZEN) {
> +		up_read(&sb->s_umount);
> +		return SHRINK_STOP;
> +	}

Ah, no. Now go run a filesystem traversal over a filesystem with a
few tens of million files in it while the filesystem is frozen, and
what the dentry and inode cache grow and grow until you run out of
memory....

THe shrinker *needs* to run while the filesystem is frozen, but it
should not be tripping over files that need modification on
eviction. Working out how we got a file that required truncation
during eviction is the first thing to do here so we can then
determine if a) we should have caught it at freeze time, b) whether
it can be caught at freeze time, c) whether it can safely be skipped
during a freeze, or d) something else....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
