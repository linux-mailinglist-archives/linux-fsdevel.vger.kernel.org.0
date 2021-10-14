Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6B42DBEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJNOna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 10:43:30 -0400
Received: from u164.east.ru ([195.170.63.164]:48284 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhJNOn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:43:29 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2021 10:43:27 EDT
Received: by u164.east.ru (Postfix, from userid 1000)
        id DC2E5CF7E2; Thu, 14 Oct 2021 17:31:23 +0300 (MSK)
Date:   Thu, 14 Oct 2021 17:31:23 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [sparc64] kernel OOPS (was: [PATCH 4/5] block: move the bdi from the
 request_queue to the gendisk)
Message-ID: <20211014143123.GA22126@u164.east.ru>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141744.1203023-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:17:43PM +0200, Christoph Hellwig wrote:
> The backing device information only makes sense for file system I/O,
> and thus belongs into the gendisk and not the lower level request_queue
> structure.  Move it there.



Hello!

Using util-linux/ test suite, got the following kernel OOPS:

root@ttip:/home/mator# cd /1/mator/util-linux/tests
root@ttip:/1/mator/util-linux/tests# uname -a
Linux ttip 5.15.0-rc5 #280 SMP Mon Oct 11 12:50:27 MSK 2021 sparc64 GNU/Linux

root@ttip:/1/mator/util-linux/tests# for i in {1..5}; do echo run $i; ./run.sh fdisk; done
run 1

-------------------- util-linux regression tests --------------------

                    For development purpose only.
                 Don't execute on production system!

       kernel: 5.15.0-rc5

      options: --srcdir=/1/mator/util-linux/tests/.. \
               --builddir=/1/mator/util-linux/tests/..

        fdisk: align 512/4K                   ... OK
        fdisk: align 512/4K +alignment_offset ...

^^ hangs

(using bash 'for' cycle, since it's not always OOPS on the first run, but with probability of about 95%)

console/kernel logs (5.15.0-rc5):

[  151.232610] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[  151.232680] scsi host0: scsi_debug: version 0190 [20200710]
[  151.232680]   dev_size_mb=50, opts=0x0, submit_queues=1, statistics=0
[  151.238292] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7
[  151.239514] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  151.240739] sd 0:0:0:0: Power-on or device reset occurred
[  151.249191] sd 0:0:0:0: [sda] 102400 512-byte logical blocks: (52.4 MB/50.0 MiB)
[  151.249226] sd 0:0:0:0: [sda] 4096-byte physical blocks
[  151.253293] sd 0:0:0:0: [sda] Write Protect is off
[  151.261403] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[  151.273553] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[  151.443048] sd 0:0:0:0: [sda] Attached SCSI disk
[  152.500133]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[  152.772862] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  153.136441] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[  153.136509] scsi host0: scsi_debug: version 0190 [20200710]
[  153.136509]   dev_size_mb=50, opts=0x0, submit_queues=1, statistics=0
[  153.141634] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7
[  153.142777] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  153.143829] sd 0:0:0:0: Power-on or device reset occurred
[  153.152034] sd 0:0:0:0: [sda] physical block alignment offset: 3584
[  153.152246] sd 0:0:0:0: [sda] 102400 512-byte logical blocks: (52.4 MB/50.0 MiB)
[  153.152277] sd 0:0:0:0: [sda] 4096-byte physical blocks
[  153.156347] sd 0:0:0:0: [sda] Write Protect is off
[  153.164454] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[  153.176605] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[  153.334960] sd 0:0:0:0: [sda] Attached SCSI disk
[  154.435981]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[  154.708897] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  154.766352] Unable to handle kernel NULL pointer dereference
[  154.766391] tsk->{mm,active_mm}->context = 0000000000000206
[  154.766418] tsk->{mm,active_mm}->pgd = fff800003cf98000
[  154.766440]               \|/ ____ \|/
[  154.766440]               "@'/ .. \`@"
[  154.766440]               /_| \__/ |_\
[  154.766440]                  \__U_/
[  154.766488] swapper/0(0): Oops [#1]
[  154.766508] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc5 #280
[  154.766536] TSTATE: 0000004480001603 TPC: 00000000009b8b1c TNPC: 00000000009b8ec4 Y: 00000000    Not tainted
[  154.766573] TPC: <latency_exceeded+0x1c/0x3e0>
[  154.766600] g0: 8226a448beb34e3c g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000000000
[  154.766632] g4: 0000000000faf680 g5: fff800042963c000 g6: 0000000000f90000 g7: 000000000000ffff
[  154.766663] o0: 0000000000000000 o1: 000000000000ffff o2: 000000000000000e o3: 0000000000f0c350
[  154.766694] o4: 0000000001200768 o5: 000000000124b508 sp: fff800042f8671a1 ret_pc: 00000000009ca4a0
[  154.766727] RPC: <_find_next_bit+0x160/0x1c0>
[  154.766751] l0: 7fffffffffffffff l1: fff800042a803ea8 l2: fff800042a803f28 l3: fff800042a803fa8
[  154.766783] l4: f6b5b5b4df3cd40c l5: 00000000014b5800 l6: 00000000014b5800 l7: fff800042f867c78
[  154.766815] i0: fff8000047b97400 i1: fff800004fcd1980 i2: 0000000000000100 i3: 0000000000000100
[  154.766846] i4: 0000000000000000 i5: 0000000000000000 i6: fff800042f867251 i7: 00000000009b8f10
[  154.766877] I7: <wb_timer_fn+0x30/0x1c0>
[  154.766897] Call Trace:
[  154.766911] [<00000000009b8f10>] wb_timer_fn+0x30/0x1c0
[  154.766934] [<000000000099b564>] blk_stat_timer_fn+0x184/0x1a0
[  154.766962] [<00000000004fe90c>] call_timer_fn+0xec/0x200
[  154.766987] [<00000000004fec6c>] __run_timers+0x24c/0x340
[  154.767010] [<00000000004fed74>] run_timer_softirq+0x14/0x40
[  154.767033] [<0000000000cada0c>] __do_softirq+0x1ac/0x3c0
[  154.767061] [<000000000042bb74>] do_softirq_own_stack+0x34/0x60
[  154.767090] [<000000000046c97c>] irq_exit+0x7c/0x120
[  154.767116] [<0000000000cad6b8>] timer_interrupt+0x98/0xc0
[  154.767140] [<00000000004209d4>] tl0_irq14+0x14/0x20
[  154.767162] [<000000000042c384>] arch_cpu_idle+0xa4/0xc0
[  154.767185] [<0000000000cab0d4>] default_idle_call+0xb4/0x160
[  154.767208] [<00000000004a7414>] do_idle+0x114/0x1a0
[  154.767234] [<00000000004a771c>] cpu_startup_entry+0x1c/0xa0
[  154.767258] [<0000000000ca1f2c>] rest_init+0x14c/0x15c
[  154.767285] [<00000000011469a8>] arch_call_rest_init+0xc/0x1c
[  154.767314] Disabling lock debugging due to kernel taint
[  154.767321] Caller[00000000009b8f10]: wb_timer_fn+0x30/0x1c0
[  154.767330] Caller[000000000099b564]: blk_stat_timer_fn+0x184/0x1a0
[  154.767339] Caller[00000000004fe90c]: call_timer_fn+0xec/0x200
[  154.767347] Caller[00000000004fec6c]: __run_timers+0x24c/0x340
[  154.767354] Caller[00000000004fed74]: run_timer_softirq+0x14/0x40
[  154.767362] Caller[0000000000cada0c]: __do_softirq+0x1ac/0x3c0
[  154.767371] Caller[000000000042bb74]: do_softirq_own_stack+0x34/0x60
[  154.767379] Caller[000000000046c97c]: irq_exit+0x7c/0x120
[  154.767388] Caller[0000000000cad6b8]: timer_interrupt+0x98/0xc0
[  154.767396] Caller[00000000004209d4]: tl0_irq14+0x14/0x20
[  154.767404] Caller[000000000042c370]: arch_cpu_idle+0x90/0xc0
[  154.767412] Caller[0000000000cab0d4]: default_idle_call+0xb4/0x160
[  154.767420] Caller[00000000004a7414]: do_idle+0x114/0x1a0
[  154.767428] Caller[00000000004a771c]: cpu_startup_entry+0x1c/0xa0
[  154.767436] Caller[0000000000ca1f2c]: rest_init+0x14c/0x15c
[  154.767444] Caller[00000000011469a8]: arch_call_rest_init+0xc/0x1c
[  154.767453] Caller[0000000001146f5c]: start_kernel+0x52c/0x544
[  154.767462] Caller[0000000001149ff0]: start_early_boot+0x68/0x78
[  154.767470] Caller[0000000000ca1dc0]: tlb_fixup_done+0x4c/0x6c
[  154.767479] Caller[0000000000027414]: 0x27414
[  154.767486] Instruction DUMP:
[  154.767488]  fa5e2028
[  154.767494]  c25860b0
[  154.767499]  02c740eb
[  154.767504] <f6586148>
[  154.767509]  c25e2030
[  154.767514]  22c040e9
[  154.767519]  c45e2050
[  154.767523]  7fed2bd5
[  154.767528]  01000000
[  154.767533]
[  154.767542] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  154.768930] Press Stop-A (L1-A) from sun keyboard or send break
[  154.768930] twice on console to return to the boot prom
[  154.768940] ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---


bisected to the following kernel commit:

linux-2.6$ git bisect bad
edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba is the first bad commit
commit edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Aug 9 16:17:43 2021 +0200

    block: move the bdi from the request_queue to the gendisk

    The backing device information only makes sense for file system I/O,
    and thus belongs into the gendisk and not the lower level request_queue
    structure.  Move it there.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
    Link: https://lore.kernel.org/r/20210809141744.1203023-5-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 block/bfq-iosched.c           |  4 ++--
 block/blk-cgroup.c            |  7 +++----
 block/blk-core.c              | 13 +++----------
 block/blk-mq.c                |  2 +-
 block/blk-settings.c          | 14 +++++++++-----
 block/blk-sysfs.c             | 26 ++++++++++++--------------
 block/blk-wbt.c               | 10 +++++-----
 block/genhd.c                 | 23 ++++++++++++++---------
 drivers/block/drbd/drbd_req.c |  5 ++---
 drivers/block/pktcdvd.c       |  8 +++-----
 fs/block_dev.c                |  4 ++--
 fs/fat/fatent.c               |  1 +
 include/linux/blkdev.h        |  3 ---
 include/linux/genhd.h         |  1 +
 14 files changed, 58 insertions(+), 63 deletions(-)


linux-2.6$ git bisect log
git bisect start
# good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
git bisect good 7d2a07b769330c34b4deabeed939325c77a7ec2f
# bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
git bisect bad 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
# bad: [1b4f3dfb4792f03b139edf10124fcbeb44e608e6] Merge tag 'usb-serial-5.15-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
git bisect bad 1b4f3dfb4792f03b139edf10124fcbeb44e608e6
# good: [29ce8f9701072fc221d9c38ad952de1a9578f95c] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 29ce8f9701072fc221d9c38ad952de1a9578f95c
# bad: [e7c1bbcf0c315c56cd970642214aa1df3d8cf61d] Merge tag 'hwmon-for-v5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect bad e7c1bbcf0c315c56cd970642214aa1df3d8cf61d
# bad: [679369114e55f422dc593d0628cfde1d04ae59b3] Merge tag 'for-5.15/block-2021-08-30' of git://git.kernel.dk/linux-block
git bisect bad 679369114e55f422dc593d0628cfde1d04ae59b3
# good: [c7a5238ef68b98130fe36716bb3fa44502f56001] Merge tag 's390-5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good c7a5238ef68b98130fe36716bb3fa44502f56001
# good: [e5e726f7bb9f711102edea7e5bd511835640e3b4] Merge tag 'locking-core-2021-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good e5e726f7bb9f711102edea7e5bd511835640e3b4
# bad: [158ee7b65653d9f841823c249014c2d0dfdeeb8f] block: mark blkdev_fsync static
git bisect bad 158ee7b65653d9f841823c249014c2d0dfdeeb8f
# bad: [b75f4aed88febe903bd40a6128b74edd2388417e] bcache: move the del_gendisk call out of bcache_device_free
git bisect bad b75f4aed88febe903bd40a6128b74edd2388417e
# good: [cf179948554a2e0d2b622317bf6bf33138ac36e5] block: add disk sequence number
git bisect good cf179948554a2e0d2b622317bf6bf33138ac36e5
# good: [89f871af1b26d98d983cba7ed0e86effa45ba5f8] dm: delay registering the gendisk
git bisect good 89f871af1b26d98d983cba7ed0e86effa45ba5f8
# bad: [99d26de2f6d79badc80f55b54bd90d4cb9d1ad90] writeback: make the laptop_mode prototypes available unconditionally
git bisect bad 99d26de2f6d79badc80f55b54bd90d4cb9d1ad90
# good: [1008162b2782a3624d12b0aee8da58bc75d12e19] block: add a queue_has_disk helper
git bisect good 1008162b2782a3624d12b0aee8da58bc75d12e19
# bad: [a11d7fc2d05fb509cd9e33d4093507d6eda3ad53] block: remove the bd_bdi in struct block_device
git bisect bad a11d7fc2d05fb509cd9e33d4093507d6eda3ad53
# bad: [edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba] block: move the bdi from the request_queue to the gendisk
git bisect bad edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba
# first bad commit: [edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba] block: move the bdi from the request_queue to the gendisk


kernel/console logs for 5.14.0-rc4-00051-gedb0872f44ec :

ttip login: [   27.667716] SCSI subsystem initialized
[   27.680003] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[   27.680069] scsi host0: scsi_debug: version 0190 [20200710]
[   27.680069]   dev_size_mb=50, opts=0x0, submit_queues=1, statistics=0
[   27.685444] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7
[   27.692723] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[   27.699206] sd 0:0:0:0: Power-on or device reset occurred
[   27.707641] sd 0:0:0:0: [sda] 102400 512-byte logical blocks: (52.4 MB/50.0 MiB)
[   27.707676] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   27.711747] sd 0:0:0:0: [sda] Write Protect is off
[   27.719862] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   27.732012] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[   27.882257] sd 0:0:0:0: [sda] Attached SCSI disk
[   29.203392]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[   29.486552] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   29.517694] Unable to handle kernel NULL pointer dereference
[   29.517722] tsk->{mm,active_mm}->context = 0000000000000422
[   29.517748] tsk->{mm,active_mm}->pgd = fff800004b1c4000
[   29.517770]               \|/ ____ \|/
[   29.517770]               "@'/ .. \`@"
[   29.517770]               /_| \__/ |_\
[   29.517770]                  \__U_/
[   29.517820] swapper/15(0): Oops [#1]
[   29.517841] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 5.14.0-rc4-00051-gedb0872f44ec #308
[   29.517876] TSTATE: 0000004480001600 TPC: 00000000009af598 TNPC: 00000000009af59c Y: 00000000    Not tainted
[   29.517913] TPC: <latency_exceeded+0x18/0x400>
[   29.517942] g0: fff800003fdd86c0 g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000000000
[   29.517974] g4: fff8000034f013c0 g5: fff8000429a12000 g6: fff8000034f3c000 g7: 000000000000ffff
[   29.518006] o0: 0000000000000000 o1: 000000000000ffff o2: 0000000000000000 o3: 0000000000ef8a50
[   29.518038] o4: 00000000011ee728 o5: 0000000001238c88 sp: fff800042efef1a1 ret_pc: 00000000009c0d40
[   29.518071] RPC: <_find_next_bit+0x160/0x1c0>
[   29.518093] l0: fff800042abc7d88 l1: fff800042abc7ea8 l2: fff800042abc7f28 l3: fff800042abc7fa8
[   29.518126] l4: f6b5b5b4df3cd40c l5: 00000000014a3800 l6: 00000000014a3800 l7: fff800042efefc78
[   29.518158] i0: fff800004b071a00 i1: fff8000042589080 i2: 0000000000000100 i3: 0000000000000100
[   29.518190] i4: 0000000000000000 i5: 0000000000000000 i6: fff800042efef251 i7: 00000000009af9b0
[   29.518221] I7: <wb_timer_fn+0x30/0x1c0>
[   29.518241] Call Trace:
[   29.518255] [<00000000009af9b0>] wb_timer_fn+0x30/0x1c0
[   29.518278] [<0000000000990024>] blk_stat_timer_fn+0x184/0x1a0
[   29.518304] [<00000000004fdcec>] call_timer_fn+0xec/0x200
[   29.518329] [<00000000004fe050>] __run_timers+0x250/0x340
[   29.518352] [<00000000004fe154>] run_timer_softirq+0x14/0x40
[   29.518376] [<0000000000c9e9ac>] __do_softirq+0x1ac/0x3c0
[   29.518403] [<000000000042bbb4>] do_softirq_own_stack+0x34/0x60
[   29.518432] [<000000000046c63c>] irq_exit+0x7c/0x120
[   29.518456] [<0000000000c9e658>] timer_interrupt+0x98/0xc0
[   29.518481] [<00000000004209d4>] tl0_irq14+0x14/0x20
[   29.518504] [<000000000042c3c4>] arch_cpu_idle+0xa4/0xc0
[   29.518528] [<0000000000c9c034>] default_idle_call+0xb4/0x160
[   29.518552] [<00000000004a6bf8>] do_idle+0x118/0x1a0
[   29.518575] [<00000000004a6efc>] cpu_startup_entry+0x1c/0xa0
[   29.518599] [<000000000043fe2c>] smp_callin+0x10c/0x120
[   29.518622] [<0000000000fa4fb4>] after_lock_tlb+0x1a8/0x1bc
[   29.518649] Disabling lock debugging due to kernel taint
[   29.518656] Caller[00000000009af9b0]: wb_timer_fn+0x30/0x1c0
[   29.518664] Caller[0000000000990024]: blk_stat_timer_fn+0x184/0x1a0
[   29.518673] Caller[00000000004fdcec]: call_timer_fn+0xec/0x200
[   29.518681] Caller[00000000004fe050]: __run_timers+0x250/0x340
[   29.518689] Caller[00000000004fe154]: run_timer_softirq+0x14/0x40
[   29.518697] Caller[0000000000c9e9ac]: __do_softirq+0x1ac/0x3c0
[   29.518706] Caller[000000000042bbb4]: do_softirq_own_stack+0x34/0x60
[   29.518714] Caller[000000000046c63c]: irq_exit+0x7c/0x120
[   29.518723] Caller[0000000000c9e658]: timer_interrupt+0x98/0xc0
[   29.518731] Caller[00000000004209d4]: tl0_irq14+0x14/0x20
[   29.518739] Caller[000000000042c3b0]: arch_cpu_idle+0x90/0xc0
[   29.518747] Caller[0000000000c9c034]: default_idle_call+0xb4/0x160
[   29.518756] Caller[00000000004a6bf8]: do_idle+0x118/0x1a0
[   29.518764] Caller[00000000004a6efc]: cpu_startup_entry+0x1c/0xa0
[   29.518772] Caller[000000000043fe2c]: smp_callin+0x10c/0x120
[   29.518780] Caller[0000000000fa4fb4]: after_lock_tlb+0x1a8/0x1bc
[   29.518788] Caller[0000000000000000]: 0x0
[   29.518796] Instruction DUMP:
[   29.518798]  c25e2060
[   29.518804]  fa5e2028
[   29.518809]  c25860c8
[   29.518814] <c2586320>
[   29.518819]  02c740ec
[   29.518825]  f6586148
[   29.518829]  c25e2030
[   29.518834]  22c040ea
[   29.518839]  c45e2050
[   29.518844]
[   29.518853] Kernel panic - not syncing: Aiee, killing interrupt handler!
[   29.520474] Press Stop-A (L1-A) from sun keyboard or send break
[   29.520474] twice on console to return to the boot prom
[   29.520485] ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

sparc64 kernel 5.14.0-rc4-00050-g1008162b2782 never hangs/OOPS on this
util-linux fdisk test.

PS: compiled with gcc-10 
$ gcc --version
gcc (Debian 10.3.0-11) 10.3.0
