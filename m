Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64333CAF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhCPBpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:45:19 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36432 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232323AbhCPBo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:44:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0US4JnEj_1615859094;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0US4JnEj_1615859094)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 09:44:55 +0800
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <7358d5ae-afd6-f0d9-5535-b1d7ecfbd785@linux.alibaba.com>
Date:   Tue, 16 Mar 2021 09:44:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210315200242.67355-2-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/16/21 4:02 AM, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Add a sequence number to the disk devices. This number is put in the
> uevent so userspace can correlate events when a driver reuses a device,
> like the loop one.
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  block/genhd.c         | 19 +++++++++++++++++++
>  include/linux/genhd.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 8c8f543572e6..92debcb9e061 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1215,8 +1215,17 @@ static void disk_release(struct device *dev)
>  		blk_put_queue(disk->queue);
>  	kfree(disk);
>  }
> +
> +static int block_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +
> +	return add_uevent_var(env, "DISKSEQ=%llu", disk->diskseq);
> +}
> +
>  struct class block_class = {
>  	.name		= "block",
> +	.dev_uevent	= block_uevent,
>  };
>  
>  static char *block_devnode(struct device *dev, umode_t *mode,
> @@ -1388,6 +1397,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
>  	disk_to_dev(disk)->class = &block_class;
>  	disk_to_dev(disk)->type = &disk_type;
>  	device_initialize(disk_to_dev(disk));
> +	inc_diskseq(disk);
> +
>  	return disk;
>  
>  out_destroy_part_tbl:
> @@ -1938,3 +1949,11 @@ static void disk_release_events(struct gendisk *disk)
>  	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
>  	kfree(disk->ev);
>  }
> +
> +void inc_diskseq(struct gendisk *disk)
> +{
> +	static atomic64_t diskseq;
> +
> +	disk->diskseq = atomic64_inc_return(&diskseq);
> +}
> +EXPORT_SYMBOL_GPL(inc_diskseq);

Hi, I'm quite interested in this 'seqnum'. Actually I'm also planing to
add support for some sort of 'seqnum' when supporting IO polling for dm
devices, so that every time dm device changes its dm table, the seqnum
will be increased.

As for your patch, @diskseq is declared as one static variable in
inc_diskseq(). Then I doubt if all callers of inc_diskseq() will share
*one* counting when inc_diskseq() is compiled as the separate call entry
rather than inlined.



> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index f364619092cc..632141b360d2 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -167,6 +167,7 @@ struct gendisk {
>  	int node_id;
>  	struct badblocks *bb;
>  	struct lockdep_map lockdep_map;
> +	u64 diskseq;
>  };
>  
>  /*
> @@ -326,6 +327,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
>  #endif /* CONFIG_SYSFS */
>  
>  extern struct rw_semaphore bdev_lookup_sem;
> +extern void inc_diskseq(struct gendisk *disk);
>  
>  dev_t blk_lookup_devt(const char *name, int partno);
>  void blk_request_module(dev_t devt);
> 

-- 
Thanks,
Jeffle
