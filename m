Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445EE2C38FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 07:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgKYGLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 01:11:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7983 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYGLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:11:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CgrB346lSzhfQ7;
        Wed, 25 Nov 2020 14:11:23 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 25 Nov
 2020 14:11:36 +0800
Subject: Re: [PATCH 38/45] block: switch partition lookup to use struct
 block_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, "Mike Snitzer" <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <dm-devel@redhat.com>, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-bcache@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-39-hch@lst.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fec5c478-c7cb-ce29-a35d-3474fae1c96d@huawei.com>
Date:   Wed, 25 Nov 2020 14:11:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201124132751.3747337-39-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/24 21:27, Christoph Hellwig wrote:
> Use struct block_device to lookup partitions on a disk.  This removes
> all usage of struct hd_struct from the I/O path, and this allows removing
> the percpu refcount in struct hd_struct.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---
>   block/bio.c                        |  4 +-
>   block/blk-core.c                   | 66 ++++++++++++++----------------
>   block/blk-flush.c                  |  2 +-
>   block/blk-mq.c                     |  9 ++--
>   block/blk-mq.h                     |  7 ++--
>   block/blk.h                        |  4 +-
>   block/genhd.c                      | 56 +++++++++++++------------
>   block/partitions/core.c            |  7 +---
>   drivers/block/drbd/drbd_receiver.c |  2 +-
>   drivers/block/drbd/drbd_worker.c   |  2 +-
>   drivers/block/zram/zram_drv.c      |  2 +-
>   drivers/md/bcache/request.c        |  4 +-
>   drivers/md/dm.c                    |  4 +-
>   drivers/md/md.c                    |  4 +-
>   drivers/nvme/target/admin-cmd.c    | 20 ++++-----
>   fs/ext4/super.c                    | 18 +++-----
>   fs/ext4/sysfs.c                    | 10 +----
>   fs/f2fs/f2fs.h                     |  2 +-
>   fs/f2fs/super.c                    |  6 +--

For f2fs part,

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   include/linux/blkdev.h             |  8 ++--
>   include/linux/genhd.h              |  4 +-
>   include/linux/part_stat.h          | 17 ++++----
>   22 files changed, 120 insertions(+), 138 deletions(-)
