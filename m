Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA83BA1BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhGBNyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 09:54:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9448 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhGBNyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:54:49 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GGbz60mcMzZjqJ;
        Fri,  2 Jul 2021 21:49:06 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 2 Jul 2021 21:52:13 +0800
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
From:   Zhang Yi <yi.zhang@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
Message-ID: <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com>
Date:   Fri, 2 Jul 2021 21:52:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/2 21:23, Zhang Yi wrote:
> On 2021/7/2 17:38, Guoqing Jiang wrote:
>>
>>
>> On 7/2/21 4:51 PM, Sachin Sant wrote:
>>> While running LTP tests (chdir01) against 5.13.0-next20210701 booted on a Power server,
>>> following crash is encountered.
>>>
>>> [ 3051.182992] ext2 filesystem being mounted at /var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports timestamps until 2038 (0x7fffffff)
>>> [ 3051.621341] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
>>> [ 3051.624645] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
>>> [ 3051.624682] ext3 filesystem being mounted at /var/tmp/avocado_oau90dri/ltp-W0cFB5HtCy/lKhal5/mntpoint supports timestamps until 2038 (0x7fffffff)
>>> [ 3051.629026] Kernel attempted to read user page (13fda70000) - exploit attempt? (uid: 0)
>>> [ 3051.629074] BUG: Unable to handle kernel data access on read at 0x13fda70000
>>> [ 3051.629103] Faulting instruction address: 0xc0000000006fa5cc
>>> [ 3051.629118] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [ 3051.629130] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>> [ 3051.629148] Modules linked in: vfat fat btrfs blake2b_generic xor zstd_compress raid6_pq xfs loop sctp ip6_udp_tunnel udp_tunnel libcrc32c rpadlpar_io rpaphp dm_mod bonding rfkill sunrpc pseries_rng xts vmx_crypto uio_pdrv_genirq uio sch_fq_codel ip_tables ext4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: test_cpuidle_latency]
>>> [ 3051.629270] CPU: 10 PID: 274044 Comm: chdir01 Tainted: G        W  OE     5.13.0-next-20210701 #1
>>> [ 3051.629289] NIP:  c0000000006fa5cc LR: c008000006949bc4 CTR: c0000000006fa5a0
>>> [ 3051.629300] REGS: c000000f74de3660 TRAP: 0300   Tainted: G        W  OE      (5.13.0-next-20210701)
>>> [ 3051.629314] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000288  XER: 20040000
>>> [ 3051.629342] CFAR: c008000006957564 DAR: 00000013fda70000 DSISR: 40000000 IRQMASK: 0
>>> [ 3051.629342] GPR00: c008000006949bc4 c000000f74de3900 c0000000029bc800 c000000f88f0ab80
>>> [ 3051.629342] GPR04: ffffffffffffffff 0000000000000020 0000000024000282 0000000000000000
>>> [ 3051.629342] GPR08: c00000110628c828 0000000000000000 00000013fda70000 c008000006957550
>>> [ 3051.629342] GPR12: c0000000006fa5a0 c0000013ffffbe80 0000000000000000 0000000000000000
>>> [ 3051.629342] GPR16: 0000000000000000 0000000000000000 00000000100555f8 0000000010050d40
>>> [ 3051.629342] GPR20: 0000000000000000 0000000010026188 0000000010026160 c000000f88f0ac08
>>> [ 3051.629342] GPR24: 0000000000000000 c000000f88f0a920 0000000000000000 0000000000000002
>>> [ 3051.629342] GPR28: c000000f88f0ac50 c000000f88f0a800 c000000fc5577d00 c000000f88f0ab80
>>> [ 3051.629468] NIP [c0000000006fa5cc] percpu_counter_add_batch+0x2c/0xf0
>>> [ 3051.629493] LR [c008000006949bc4] __jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
>>> [ 3051.629526] Call Trace:
>>> [ 3051.629532] [c000000f74de3900] [c000000f88f0a84c] 0xc000000f88f0a84c (unreliable)
>>> [ 3051.629547] [c000000f74de3940] [c008000006949bc4] __jbd2_journal_remove_checkpoint+0x9c/0x280 [jbd2]
>>> [ 3051.629577] [c000000f74de3980] [c008000006949eb4] jbd2_log_do_checkpoint+0x10c/0x630 [jbd2]
>>> [ 3051.629605] [c000000f74de3a40] [c0080000069547dc] jbd2_journal_destroy+0x1b4/0x4e0 [jbd2]
>>> [ 3051.629636] [c000000f74de3ad0] [c00800000735d72c] ext4_put_super+0xb4/0x560 [ext4]
>>> [ 3051.629703] [c000000f74de3b60] [c000000000484d64] generic_shutdown_super+0xc4/0x1d0
>>> [ 3051.629720] [c000000f74de3bd0] [c000000000484f48] kill_block_super+0x38/0x90
>>> [ 3051.629736] [c000000f74de3c00] [c000000000485120] deactivate_locked_super+0x80/0x100
>>> [ 3051.629752] [c000000f74de3c30] [c0000000004bec1c] cleanup_mnt+0x10c/0x1d0
>>> [ 3051.629767] [c000000f74de3c80] [c000000000188b08] task_work_run+0xf8/0x170
>>> [ 3051.629783] [c000000f74de3cd0] [c000000000021a24] do_notify_resume+0x434/0x480
>>> [ 3051.629800] [c000000f74de3d80] [c000000000032910] interrupt_exit_user_prepare_main+0x1a0/0x260
>>> [ 3051.629816] [c000000f74de3de0] [c000000000032d08] syscall_exit_prepare+0x68/0x150
>>> [ 3051.629830] [c000000f74de3e10] [c00000000000c770] system_call_common+0x100/0x258
>>> [ 3051.629846] --- interrupt: c00 at 0x7fffa2b92ffc
>>> [ 3051.629855] NIP:  00007fffa2b92ffc LR: 00007fffa2b92fcc CTR: 0000000000000000
>>> [ 3051.629867] REGS: c000000f74de3e80 TRAP: 0c00   Tainted: G        W  OE      (5.13.0-next-20210701)
>>> [ 3051.629880] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000474  XER: 00000000
>>> [ 3051.629908] IRQMASK: 0
>>> [ 3051.629908] GPR00: 0000000000000034 00007fffc0242e20 00007fffa2c77100 0000000000000000
>>> [ 3051.629908] GPR04: 0000000000000000 0000000000000078 0000000000000000 0000000000000020
>>> [ 3051.629908] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [ 3051.629908] GPR12: 0000000000000000 00007fffa2d1a310 0000000000000000 0000000000000000
>>> [ 3051.629908] GPR16: 0000000000000000 0000000000000000 00000000100555f8 0000000010050d40
>>> [ 3051.629908] GPR20: 0000000000000000 0000000010026188 0000000010026160 00000000100288f0
>>> [ 3051.629908] GPR24: 00007fffa2d13320 00000000000186a0 0000000010025dd8 0000000010055688
>>> [ 3051.629908] GPR28: 0000000010024bb8 0000000000000001 0000000000000001 0000000000000000
>>> [ 3051.630022] NIP [00007fffa2b92ffc] 0x7fffa2b92ffc
>>> [ 3051.630032] LR [00007fffa2b92fcc] 0x7fffa2b92fcc
>>> [ 3051.630041] --- interrupt: c00
>>> [ 3051.630048] Instruction dump:
>>> [ 3051.630057] 60000000 3c4c022c 38422260 7c0802a6 fbe1fff8 fba1ffe8 7c7f1b78 fbc1fff0
>>> [ 3051.630078] f8010010 f821ffc1 e94d0030 e9230020 <7fca4aaa> 7fbe2214 7fa9fe76 7d2aea78
>>> [ 3051.630102] ---[ end trace 83afe3a19212c333 ]---
>>> [ 3051.633656]
>>> [ 3052.633681] Kernel panic - not syncing: Fatal exception
>>>
>>> 5.13.0-next-20210630 was good. Bisect points to following patch:
>>>
>>> commit 4ba3fcdde7e3
>>>           jbd2,ext4: add a shrinker to release checkpointed buffers
>>>
>>> Reverting this patch allows the test to run successfully.
>>
>> I guess the problem is j_jh_shrink_count was destroyed in ext4_put_super _>  jbd2_journal_unregister_shrinker
>> which is before the path ext4_put_super -> jbd2_journal_destroy -> jbd2_log_do_checkpoint to call
>> percpu_counter_dec(&journal->j_jh_shrink_count).
>>
>> And since jbd2_journal_unregister_shrinker is already called inside jbd2_journal_destroy, does it make sense
>> to do this?
>>
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1176,7 +1176,6 @@ static void ext4_put_super(struct super_block  *sb)
>>         ext4_unregister_sysfs(sb);
>>
>>         if (sbi->s_journal) {
>> -               jbd2_journal_unregister_shrinker(sbi->s_journal);
>>                 aborted = is_journal_aborted(sbi->s_journal);
>>                 err = jbd2_journal_destroy(sbi->s_journal);
>>                 sbi->s_journal = NULL;
>>
> 
> Hi Guoqing,
> 
> Thanks for your analyze. This problem cannot reproduce on x86_64 but 100% reproduce on arm64,
> it depends on the percpu counter code on different architecture.
> 
> Indeed, as you said, the real problem is invoke percpu_counter_dec(&journal->j_jh_shrink_count)
> after it was destroyed during umount, and I'm afraid that it may also affect ocfs2
> because it doesn't initialize the percpu counter before doing add/sub in
> __jbd2_journal_[insert|remove]_checkpoint().
> 
> I think the quick fix could be:
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 152880c298ca..48c7e5d17b38 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1352,17 +1352,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
>         if (!journal->j_wbuf)
>                 goto err_cleanup;
> 
> +       err = percpu_counter_init(&journal->j_jh_shrink_count, 0, GFP_KERNEL);
> +       if (err)
> +               goto err_cleanup;
> +
>         bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
>         if (!bh) {
>                 pr_err("%s: Cannot get buffer for journal superblock\n",
>                         __func__);
> -               goto err_cleanup;
> +               goto err_cleanup_cnt;
>         }
>         journal->j_sb_buffer = bh;
>         journal->j_superblock = (journal_superblock_t *)bh->b_data;
> 
>         return journal;
> 
> +err_cleanup_cnt:
> +       percpu_counter_destroy(&journal->j_jh_shrink_count);
>  err_cleanup:
>         kfree(journal->j_wbuf);
>         jbd2_journal_destroy_revoke(journal);
> @@ -2101,26 +2107,13 @@ static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
>   */
>  int jbd2_journal_register_shrinker(journal_t *journal)
>  {
> -       int err;
> -
>         journal->j_shrink_transaction = NULL;
> -
> -       err = percpu_counter_init(&journal->j_jh_shrink_count, 0, GFP_KERNEL);
> -       if (err)
> -               return err;
> -
>         journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
>         journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
>         journal->j_shrinker.seeks = DEFAULT_SEEKS;
>         journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> 
> -       err = register_shrinker(&journal->j_shrinker);
> -       if (err) {
> -               percpu_counter_destroy(&journal->j_jh_shrink_count);
> -               return err;
> -       }
> -
> -       return 0;
> +       return register_shrinker(&journal->j_shrinker);
>  }
>  EXPORT_SYMBOL(jbd2_journal_register_shrinker);
> 
> @@ -2132,7 +2125,6 @@ EXPORT_SYMBOL(jbd2_journal_register_shrinker);
>   */
>  void jbd2_journal_unregister_shrinker(journal_t *journal)
>  {
> -       percpu_counter_destroy(&journal->j_jh_shrink_count);
>         unregister_shrinker(&journal->j_shrinker);
>  }
>  EXPORT_SYMBOL(jbd2_journal_unregister_shrinker);
> @@ -2209,8 +2201,6 @@ int jbd2_journal_destroy(journal_t *journal)
>                 brelse(journal->j_sb_buffer);
>         }
> 
> -       jbd2_journal_unregister_shrinker(journal);
> -
>         if (journal->j_proc_entry)
>                 jbd2_stats_proc_exit(journal);
>         iput(journal->j_inode);
> @@ -2220,6 +2210,7 @@ int jbd2_journal_destroy(journal_t *journal)
>                 crypto_free_shash(journal->j_chksum_driver);
>         kfree(journal->j_fc_wbuf);
>         kfree(journal->j_wbuf);
> +       percpu_counter_destroy(&journal->j_jh_shrink_count);
>         kfree(journal);
> 
>         return err;
> 

Hi, Ted,

Sorry about not catching this problem, this fix is not format corrected,
if you think this fix is OK, I can send a patch after test.

Thanks,
Yi.
