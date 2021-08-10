Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5B3E83D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhHJThF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 15:37:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56203 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhHJThE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628624202; x=1660160202;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OENhXJP57mLYLukgJGz50I0jHh6p6SELiMOo4VCXnT4=;
  b=NcPqIDGgzlAt9xFl/fNRVjGMqLfxM8otHD4Sx8SsLT1jwbkkkYrguR2c
   bXfjfg3Iik6G13oIZoCOZEIuMqSA8xBFZD80Elt6/M66zErLq3ybttVfi
   /DhlueG9Q2dY5sxbGXAfKpzIRAI+/MBYq7Wl3wL0HM9GknKvBlctUo20H
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Aug 2021 12:36:42 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Aug 2021 12:36:41 -0700
Received: from [10.111.168.10] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Aug
 2021 12:36:40 -0700
Subject: Re: move the bdi from the request_queue to the gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210809141744.1203023-1-hch@lst.de>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
Date:   Tue, 10 Aug 2021 15:36:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/9/2021 10:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the pointer to the bdi from the request_queue
> to the bdi, better matching the life time rules of the different
> objects.

Reverting this series fixed an use-after-free in bdev_evict_inode().

[ 3710.755078][    T1] BUG: KASAN: use-after-free in bdev_evict_inode+0x454/0x4d0
wb_put_many at /root/linux-next/./include/linux/backing-dev-defs.h:250
(inlined by) wb_put at /root/linux-next/./include/linux/backing-dev-defs.h:268
(inlined by) inode_detach_wb at /root/linux-next/./include/linux/writeback.h:251
(inlined by) bdev_evict_inode at /root/linux-next/fs/block_dev.c:832
[ 3710.762312][    T1] Read of size 8 at addr ffff000859ff6060 by task shutdown/1
[ 3710.769533][    T1] 
[ 3710.771721][    T1] CPU: 29 PID: 1 Comm: shutdown Not tainted 5.14.0-rc5-next-20210810+ #88
[ 3710.780073][    T1] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[ 3710.788600][    T1] Call trace:
[ 3710.791741][    T1]  dump_backtrace+0x0/0x3b8
[ 3710.796103][    T1]  show_stack+0x20/0x30
[ 3710.800115][    T1]  dump_stack_lvl+0x8c/0xb8
[ 3710.804472][    T1]  print_address_description.constprop.0+0x74/0x3c8
[ 3710.810913][    T1]  kasan_report+0x1f0/0x208
[ 3710.815270][    T1]  __asan_report_load8_noabort+0x34/0x60
[ 3710.820755][    T1]  bdev_evict_inode+0x454/0x4d0
[ 3710.825459][    T1]  evict+0x20c/0x400
evict at /root/linux-next/fs/inode.c:595
[ 3710.829208][    T1]  iput.part.0+0x53c/0x7a8
[ 3710.833477][    T1]  iput+0x48/0x68
[ 3710.836964][    T1]  disk_release+0x168/0x1d8
[ 3710.841322][    T1]  device_release+0xec/0x1f0
[ 3710.845766][    T1]  kobject_release+0xe4/0x360
[ 3710.850299][    T1]  kobject_put+0x7c/0x138
[ 3710.854481][    T1]  put_device+0x1c/0x30
[ 3710.858489][    T1]  blk_cleanup_disk+0x64/0x88
[ 3710.863021][    T1]  cleanup_mapped_device+0x128/0x1e8 [dm_mod]
[ 3710.868974][    T1]  __dm_destroy+0x314/0x618 [dm_mod]
[ 3710.874140][    T1]  dm_destroy+0x1c/0x28 [dm_mod]
[ 3710.878955][    T1]  dev_remove+0x214/0x2f8 [dm_mod]
[ 3710.883947][    T1]  ctl_ioctl+0x490/0xb58 [dm_mod]
[ 3710.888850][    T1]  dm_ctl_ioctl+0x18/0x28 [dm_mod]
[ 3710.893842][    T1]  __arm64_sys_ioctl+0x114/0x180
[ 3710.898636][    T1]  invoke_syscall.constprop.0+0xdc/0x1d8
[ 3710.904123][    T1]  do_el0_svc+0xe4/0x2a8
[ 3710.908219][    T1]  el0_svc+0x64/0x130
[ 3710.912057][    T1]  el0t_64_sync_handler+0xb0/0xb8
[ 3710.916934][    T1]  el0t_64_sync+0x180/0x184
[ 3711.007417][    T1] 
[ 3711.009600][    T1] Freed by task 1:
[ 3711.013172][    T1]  kasan_save_stack+0x28/0x58
[ 3711.017702][    T1]  kasan_set_track+0x28/0x40
[ 3711.022144][    T1]  kasan_set_free_info+0x28/0x50
[ 3711.026933][    T1]  __kasan_slab_free+0xfc/0x150
[ 3711.031636][    T1]  slab_free_freelist_hook+0x108/0x208
[ 3711.036947][    T1]  kfree+0x154/0x3c8
[ 3711.040695][    T1]  release_bdi+0x80/0xc0
[ 3711.044790][    T1]  bdi_put+0x54/0xb0
[ 3711.048537][    T1]  disk_release+0x70/0x1d8
[ 3711.052807][    T1]  device_release+0xec/0x1f0
[ 3711.057251][    T1]  kobject_release+0xe4/0x360
[ 3711.061782][    T1]  kobject_put+0x7c/0x138
[ 3711.065964][    T1]  put_device+0x1c/0x30
[ 3711.069974][    T1]  blk_cleanup_disk+0x64/0x88
blk_cleanup_disk at /root/linux-next/block/genhd.c:1355
[ 3711.074503][    T1]  cleanup_mapped_device+0x128/0x1e8 [dm_mod]
[ 3711.080451][    T1]  __dm_destroy+0x314/0x618 [dm_mod]
[ 3711.085617][    T1]  dm_destroy+0x1c/0x28 [dm_mod]
[ 3711.090434][    T1]  dev_remove+0x214/0x2f8 [dm_mod]
[ 3711.095424][    T1]  ctl_ioctl+0x490/0xb58 [dm_mod]
[ 3711.100328][    T1]  dm_ctl_ioctl+0x18/0x28 [dm_mod]
[ 3711.105317][    T1]  __arm64_sys_ioctl+0x114/0x180
[ 3711.110108][    T1]  invoke_syscall.constprop.0+0xdc/0x1d8
[ 3711.115594][    T1]  do_el0_svc+0xe4/0x2a8
[ 3711.119691][    T1]  el0_svc+0x64/0x130
[ 3711.123527][    T1]  el0t_64_sync_handler+0xb0/0xb8
[ 3711.128402][    T1]  el0t_64_sync+0x180/0x184
[ 3711.132759][    T1] 
[ 3711.134941][    T1] Last potentially related work creation:
[ 3711.140511][    T1]  kasan_save_stack+0x28/0x58
[ 3711.145041][    T1]  kasan_record_aux_stack+0xf4/0x128
[ 3711.150179][    T1]  insert_work+0x58/0x2c0
[ 3711.154361][    T1]  __queue_work+0x644/0x18d0
[ 3711.158802][    T1]  __queue_delayed_work+0x14c/0x228
[ 3711.163853][    T1]  mod_delayed_work_on+0xc0/0x128
[ 3711.168729][    T1]  wb_shutdown+0x174/0x230
[ 3711.172999][    T1]  bdi_unregister+0x158/0x480
[ 3711.177527][    T1]  del_gendisk+0x410/0x548
[ 3711.181797][    T1]  cleanup_mapped_device+0x190/0x1e8 [dm_mod]
[ 3711.187745][    T1]  __dm_destroy+0x314/0x618 [dm_mod]
[ 3711.192909][    T1]  dm_destroy+0x1c/0x28 [dm_mod]
[ 3711.197725][    T1]  dev_remove+0x214/0x2f8 [dm_mod]
[ 3711.202716][    T1]  ctl_ioctl+0x490/0xb58 [dm_mod]
[ 3711.207620][    T1]  dm_ctl_ioctl+0x18/0x28 [dm_mod]
[ 3711.212611][    T1]  __arm64_sys_ioctl+0x114/0x180
[ 3711.217402][    T1]  invoke_syscall.constprop.0+0xdc/0x1d8
[ 3711.222889][    T1]  do_el0_svc+0xe4/0x2a8
[ 3711.226985][    T1]  el0_svc+0x64/0x130
[ 3711.230823][    T1]  el0t_64_sync_handler+0xb0/0xb8
[ 3711.235699][    T1]  el0t_64_sync+0x180/0x184
[ 3711.240055][    T1] 
[ 3711.242237][    T1] Second to last potentially related work creation:
[ 3711.248673][    T1]  kasan_save_stack+0x28/0x58
[ 3711.253203][    T1]  kasan_record_aux_stack+0xf4/0x128
[ 3711.258340][    T1]  insert_work+0x58/0x2c0
[ 3711.262522][    T1]  __queue_work+0x644/0x18d0
[ 3711.266964][    T1]  delayed_work_timer_fn+0x6c/0xa0
[ 3711.271927][    T1]  call_timer_fn+0x224/0xbb0
[ 3711.276371][    T1]  __run_timers.part.0+0x548/0xb58
[ 3711.281336][    T1]  run_timer_softirq+0x80/0x118
[ 3711.286039][    T1]  _stext+0x2d4/0x11ac
[ 3711.289961][    T1] 
[ 3711.292142][    T1] The buggy address belongs to the object at ffff000859ff6000
[ 3711.292142][    T1]  which belongs to the cache kmalloc-4k of size 4096
[ 3711.306045][    T1] The buggy address is located 96 bytes inside of
[ 3711.306045][    T1]  4096-byte region [ffff000859ff6000, ffff000859ff7000)
[ 3711.319169][    T1] The buggy address belongs to the page:
[ 3711.324653][    T1] page:ffffffc002167e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff000859fd2000 pfn:0x8d9f8
[ 3711.335954][    T1] head:ffffffc002167e00 order:3 compound_mapcount:0 compound_pincount:0
[ 3711.344129][    T1] flags: 0x7ffff800010200(slab|head|node=0|zone=0|lastcpupid=0xfffff)
[ 3711.352137][    T1] raw: 007ffff800010200 ffffffc002168208 ffffffc002140e08 ffff000012911580
[ 3711.360574][    T1] raw: ffff000859fd2000 00000000002a0002 00000001ffffffff 0000000000000000
[ 3711.369008][    T1] page dumped because: kasan: bad access detected
[ 3711.375272][    T1] 
[ 3711.377454][    T1] Memory state around the buggy address:
[ 3711.382936][    T1]  ffff000859ff5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3711.390848][    T1]  ffff000859ff5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3711.398762][    T1] >ffff000859ff6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3711.406674][    T1]                                                        ^
[ 3711.413719][    T1]  ffff000859ff6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3711.421632][    T1]  ffff000859ff6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

> 
> Diffstat:
>  block/bfq-iosched.c           |    4 ++--
>  block/blk-cgroup.c            |    7 +++----
>  block/blk-core.c              |   18 +++---------------
>  block/blk-mq.c                |    2 +-
>  block/blk-settings.c          |   22 ++++++++++++++--------
>  block/blk-sysfs.c             |   28 +++++++++++++---------------
>  block/blk-wbt.c               |   10 +++++-----
>  block/genhd.c                 |   23 ++++++++++++++---------
>  block/ioctl.c                 |    7 ++++---
>  drivers/block/drbd/drbd_nl.c  |    2 +-
>  drivers/block/drbd/drbd_req.c |    5 ++---
>  drivers/block/pktcdvd.c       |    8 +++-----
>  drivers/md/dm-table.c         |    2 +-
>  drivers/nvme/host/core.c      |    2 +-
>  fs/block_dev.c                |   13 +------------
>  fs/fat/fatent.c               |    1 +
>  fs/nilfs2/super.c             |    2 +-
>  fs/super.c                    |    2 +-
>  fs/xfs/xfs_buf.c              |    2 +-
>  include/linux/backing-dev.h   |    2 +-
>  include/linux/blk_types.h     |    1 -
>  include/linux/blkdev.h        |    6 ++----
>  include/linux/genhd.h         |    1 +
>  mm/backing-dev.c              |    3 +++
>  mm/page-writeback.c           |    2 --
>  25 files changed, 79 insertions(+), 96 deletions(-)
> 
