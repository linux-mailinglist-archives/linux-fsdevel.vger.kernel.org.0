Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4C2C7F41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgK3HwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:52:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgK3HwG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:52:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06B55AC55;
        Mon, 30 Nov 2020 07:51:25 +0000 (UTC)
Subject: Re: [PATCH 44/45] block: merge struct block_device and struct
 hd_struct
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-45-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <75432706-8726-2c86-a080-40c45e6144c3@suse.de>
Date:   Mon, 30 Nov 2020 08:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-45-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:15 PM, Christoph Hellwig wrote:
> Instead of having two structures that represent each block device with
> different life time rules, merge them into a single one.  This also
> greatly simplifies the reference counting rules, as we can use the inode
> reference count as the main reference count for the new struct
> block_device, with the device model reference front ending it for device
> model interaction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-cgroup.c        |   9 ++-
>   block/blk.h               |   2 +-
>   block/genhd.c             |  89 +++++++++--------------------
>   block/partitions/core.c   | 116 +++++++++++++++-----------------------
>   fs/block_dev.c            |   9 ---
>   include/linux/blk_types.h |   8 ++-
>   include/linux/blkdev.h    |   1 -
>   include/linux/genhd.h     |  40 +++----------
>   init/do_mounts.c          |  21 ++++---
>   kernel/trace/blktrace.c   |  43 +++-----------
>   10 files changed, 108 insertions(+), 230 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
