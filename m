Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4307B2B79AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKRI4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:51650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRI4N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:56:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7igakkmhEI4CwNFDZCT70CUptcTv+K/s+YCPQmQlu9Q=;
        b=Y++3q5UJgDUWDlWdeDn6mQNNYdWrbUeFS91t9OchR29jrBjxggFIPk/Zt9w7d5o8Y5Vame
        8OeLl6cMI/636YtXiKuW5EanOqCgIw218k8knrDwI/S+PfWCYEvotYadONsuLQegM5GdhK
        3wwWlNOxGUloBVFJNsllEo8czXvQANE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6417AD2F;
        Wed, 18 Nov 2020 08:56:11 +0000 (UTC)
Subject: Re: merge struct block_device and struct hd_struct
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
References: <20201118084800.2339180-1-hch@lst.de>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <22ca5396-0253-f286-9eab-d417b2e0b3ad@suse.com>
Date:   Wed, 18 Nov 2020 09:56:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph,

On 18.11.2020 09:47, Christoph Hellwig wrote:
> Diffstat:
>  block/bio.c                                  |    6 
>  block/blk-cgroup.c                           |   50 +-
>  block/blk-core.c                             |   85 +--
>  block/blk-flush.c                            |    2 
>  block/blk-iocost.c                           |   36 -
>  block/blk-lib.c                              |    2 
>  block/blk-merge.c                            |    6 
>  block/blk-mq.c                               |   11 
>  block/blk-mq.h                               |    5 
>  block/blk.h                                  |   92 ----
>  block/genhd.c                                |  444 +++++---------------
>  block/ioctl.c                                |    7 
>  block/partitions/core.c                      |  238 +++--------
>  drivers/block/drbd/drbd_receiver.c           |    2 
>  drivers/block/drbd/drbd_worker.c             |    2 
>  drivers/block/loop.c                         |   21 
>  drivers/block/nbd.c                          |    6 
>  drivers/block/xen-blkback/common.h           |    4 
>  drivers/block/xen-blkfront.c                 |   20 
>  drivers/block/zram/zram_drv.c                |   20 
>  drivers/md/bcache/request.c                  |    4 
>  drivers/md/bcache/super.c                    |   53 --
>  drivers/md/dm-table.c                        |    9 
>  drivers/md/dm.c                              |   16 
>  drivers/md/md.c                              |    8 
>  drivers/mtd/mtdsuper.c                       |   17 
>  drivers/nvme/target/admin-cmd.c              |   20 
>  drivers/s390/block/dasd.c                    |    8 
>  drivers/s390/block/dasd_ioctl.c              |    9 
>  drivers/scsi/scsicam.c                       |    2 
>  drivers/target/target_core_file.c            |    6 
>  drivers/target/target_core_pscsi.c           |    7 
>  drivers/usb/gadget/function/storage_common.c |    8 
>  fs/block_dev.c                               |  578 ++++++++-------------------
>  fs/btrfs/sysfs.c                             |   15 
>  fs/btrfs/volumes.c                           |   13 
>  fs/ext4/super.c                              |   18 
>  fs/ext4/sysfs.c                              |   10 
>  fs/f2fs/checkpoint.c                         |    5 
>  fs/f2fs/f2fs.h                               |    2 
>  fs/f2fs/super.c                              |    8 
>  fs/f2fs/sysfs.c                              |    9 
>  fs/inode.c                                   |    3 
>  fs/internal.h                                |    7 
>  fs/io_uring.c                                |   10 
>  fs/pipe.c                                    |    5 
>  fs/pstore/blk.c                              |    2 
>  fs/quota/quota.c                             |   40 +
>  fs/statfs.c                                  |    2 
>  fs/super.c                                   |   86 ----
>  include/linux/blk-cgroup.h                   |    4 
>  include/linux/blk_types.h                    |   26 +
>  include/linux/blkdev.h                       |   24 -
>  include/linux/fs.h                           |    5 
>  include/linux/genhd.h                        |  104 ----
>  include/linux/part_stat.h                    |   17 
>  init/do_mounts.c                             |  271 +++++-------
>  kernel/trace/blktrace.c                      |   54 --
>  mm/filemap.c                                 |    9 
>  59 files changed, 837 insertions(+), 1716 deletions(-)

since this isn't the first series from you recently spamming
xen-devel, may I ask that you don't Cc entire series to lists
which are involved with perhaps just one out of the many patches?
IMO Cc lists should be compiled on a per-patch basis; the cover
letter may of course be sent to the union of all of them.

Thanks much,
Jan
