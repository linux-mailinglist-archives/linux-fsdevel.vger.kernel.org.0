Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E83B9E67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhGBJkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:40:55 -0400
Received: from out0.migadu.com ([94.23.1.103]:27231 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhGBJku (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:40:50 -0400
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625218696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWJ+pqDT0mb1en6A52Tk3LmCoscuU9h3+MdS6wNnXpo=;
        b=S7UNFDqRBtCV1Vxrghz/uh4InvwBHSoL4HrpnjdG/E0/OWehVxGnuShbynzAYCW8UshBo+
        oAgJ97xfFZqaHUcHDLxz2NNb41KNgT9t/mpQTmksr0/BXG0qrgJnSaBLRTiMy1awaFMM1K
        7vTS7yhxz0Kct+8REfCeEIMsNp3693A=
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, yi.zhang@huawei.com, jack@suse.cz
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
Date:   Fri, 2 Jul 2021 17:38:10 +0800
MIME-Version: 1.0
In-Reply-To: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/2/21 4:51 PM, Sachin Sant wrote:
> While running LTP tests (chdir01) against 5.13.0-next20210701 booted on a Power server,
> following crash is encountered.
>
> [ 3051.182992] ext2 filesystem being mounted at /var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports timestamps until 2038 (0x7fffffff)
> [ 3051.621341] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> [ 3051.624645] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [ 3051.624682] ext3 filesystem being mounted at /var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports timestamps until 2038 (0x7fffffff)
> [ 3051.629026] Kernel attempted to read user page (13fda70000) - exploit attempt? (uid: 0)
> [ 3051.629074] BUG: Unable to handle kernel data access on read at 0x13fda70000
> [ 3051.629103] Faulting instruction address: 0xc0000000006fa5cc
> [ 3051.629118] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 3051.629130] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> [ 3051.629148] Modules linked in: vfat fat btrfs blake2b_generic xor zstd_compress raid6_pq xfs loop sctp ip6_udp_tunnel udp_tunnel libcrc32c rpadlpar_io rpaphp dm_mod bonding rfkill sunrpc pseries_rng xts vmx_crypto uio_pdrv_genirq uio sch_fq_codel ip_tables ext4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: test_cpuidle_latency]
> [ 3051.629270] CPU: 10 PID: 274044 Comm: chdir01 Tainted: G        W  OE     5.13.0-next-20210701 #1
> [ 3051.629289] NIP:  c0000000006fa5cc LR: c008000006949bc4 CTR: c0000000006fa5a0
> [ 3051.629300] REGS: c000000f74de3660 TRAP: 0300   Tainted: G        W  OE      (5.13.0-next-20210701)
> [ 3051.629314] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000288  XER: 20040000
> [ 3051.629342] CFAR: c008000006957564 DAR: 00000013fda70000 DSISR: 40000000 IRQMASK: 0
> [ 3051.629342] GPR00: c008000006949bc4 c000000f74de3900 c0000000029bc800 c000000f88f0ab80
> [ 3051.629342] GPR04: ffffffffffffffff 0000000000000020 0000000024000282 0000000000000000
> [ 3051.629342] GPR08: c00000110628c828 0000000000000000 00000013fda70000 c008000006957550
> [ 3051.629342] GPR12: c0000000006fa5a0 c0000013ffffbe80 0000000000000000 0000000000000000
> [ 3051.629342] GPR16: 0000000000000000 0000000000000000 00000000100555f8 0000000010050d40
> [ 3051.629342] GPR20: 0000000000000000 0000000010026188 0000000010026160 c000000f88f0ac08
> [ 3051.629342] GPR24: 0000000000000000 c000000f88f0a920 0000000000000000 0000000000000002
> [ 3051.629342] GPR28: c000000f88f0ac50 c000000f88f0a800 c000000fc5577d00 c000000f88f0ab80
> [ 3051.629468] NIP [c0000000006fa5cc] percpu_counter_add_batch+0x2c/0xf0
> [ 3051.629493] LR [c008000006949bc4] __jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
> [ 3051.629526] Call Trace:
> [ 3051.629532] [c000000f74de3900] [c000000f88f0a84c] 0xc000000f88f0a84c (unreliable)
> [ 3051.629547] [c000000f74de3940] [c008000006949bc4] __jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
> [ 3051.629577] [c000000f74de3980] [c008000006949eb4] jbd2_log_do_checkpoint+0x10c/0x630 [jbd2]
> [ 3051.629605] [c000000f74de3a40] [c0080000069547dc] jbd2_journal_destroy+0x1b4/0x4e0 [jbd2]
> [ 3051.629636] [c000000f74de3ad0] [c00800000735d72c] ext4_put_super+0xb4/0x560 [ext4]
> [ 3051.629703] [c000000f74de3b60] [c000000000484d64] generic_shutdown_super+0xc4/0x1d0
> [ 3051.629720] [c000000f74de3bd0] [c000000000484f48] kill_block_super+0x38/0x90
> [ 3051.629736] [c000000f74de3c00] [c000000000485120] deactivate_locked_super+0x80/0x100
> [ 3051.629752] [c000000f74de3c30] [c0000000004bec1c] cleanup_mnt+0x10c/0x1d0
> [ 3051.629767] [c000000f74de3c80] [c000000000188b08] task_work_run+0xf8/0x170
> [ 3051.629783] [c000000f74de3cd0] [c000000000021a24] do_notify_resume+0x434/0x480
> [ 3051.629800] [c000000f74de3d80] [c000000000032910] interrupt_exit_user_prepare_main+0x1a0/0x260
> [ 3051.629816] [c000000f74de3de0] [c000000000032d08] syscall_exit_prepare+0x68/0x150
> [ 3051.629830] [c000000f74de3e10] [c00000000000c770] system_call_common+0x100/0x258
> [ 3051.629846] --- interrupt: c00 at 0x7fffa2b92ffc
> [ 3051.629855] NIP:  00007fffa2b92ffc LR: 00007fffa2b92fcc CTR: 0000000000000000
> [ 3051.629867] REGS: c000000f74de3e80 TRAP: 0c00   Tainted: G        W  OE      (5.13.0-next-20210701)
> [ 3051.629880] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000474  XER: 00000000
> [ 3051.629908] IRQMASK: 0
> [ 3051.629908] GPR00: 0000000000000034 00007fffc0242e20 00007fffa2c77100 0000000000000000
> [ 3051.629908] GPR04: 0000000000000000 0000000000000078 0000000000000000 0000000000000020
> [ 3051.629908] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [ 3051.629908] GPR12: 0000000000000000 00007fffa2d1a310 0000000000000000 0000000000000000
> [ 3051.629908] GPR16: 0000000000000000 0000000000000000 00000000100555f8 0000000010050d40
> [ 3051.629908] GPR20: 0000000000000000 0000000010026188 0000000010026160 00000000100288f0
> [ 3051.629908] GPR24: 00007fffa2d13320 00000000000186a0 0000000010025dd8 0000000010055688
> [ 3051.629908] GPR28: 0000000010024bb8 0000000000000001 0000000000000001 0000000000000000
> [ 3051.630022] NIP [00007fffa2b92ffc] 0x7fffa2b92ffc
> [ 3051.630032] LR [00007fffa2b92fcc] 0x7fffa2b92fcc
> [ 3051.630041] --- interrupt: c00
> [ 3051.630048] Instruction dump:
> [ 3051.630057] 60000000 3c4c022c 38422260 7c0802a6 fbe1fff8 fba1ffe8 7c7f1b78 fbc1fff0
> [ 3051.630078] f8010010 f821ffc1 e94d0030 e9230020 <7fca4aaa> 7fbe2214 7fa9fe76 7d2aea78
> [ 3051.630102] ---[ end trace 83afe3a19212c333 ]---
> [ 3051.633656]
> [ 3052.633681] Kernel panic - not syncing: Fatal exception
>
> 5.13.0-next-20210630 was good. Bisect points to following patch:
>
> commit 4ba3fcdde7e3
>           jbd2,ext4: add a shrinker to release checkpointed buffers
>
> Reverting this patch allows the test to run successfully.

I guess the problem is j_jh_shrink_count was destroyed in ext4_put_super 
_>  jbd2_journal_unregister_shrinker
which is before the path ext4_put_super -> jbd2_journal_destroy -> 
jbd2_log_do_checkpoint to call
percpu_counter_dec(&journal->j_jh_shrink_count).

And since jbd2_journal_unregister_shrinker is already called inside 
jbd2_journal_destroy, does it make sense
to do this?

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1176,7 +1176,6 @@ static void ext4_put_super(struct super_block *sb)
         ext4_unregister_sysfs(sb);

         if (sbi->s_journal) {
-               jbd2_journal_unregister_shrinker(sbi->s_journal);
                 aborted = is_journal_aborted(sbi->s_journal);
                 err = jbd2_journal_destroy(sbi->s_journal);
                 sbi->s_journal = NULL;

Thanks,
Guoqing
