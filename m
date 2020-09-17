Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF4F26D7CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIQJhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgIQJhA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:37:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87C08AC61;
        Thu, 17 Sep 2020 09:37:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 554E71E12E1; Thu, 17 Sep 2020 11:36:55 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:36:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 07/12] bdi: remove BDI_CAP_CGROUP_WRITEBACK
Message-ID: <20200917093655.GG7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:27, Christoph Hellwig wrote:
> Just checking SB_I_CGROUPWB for cgroup writeback support is enough.
> Either the file system allocates its own bdi (e.g. btrfs), in which case
> it is known to support cgroup writeback, or the bdi comes from the block
> layer, which always supports cgroup writeback.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c            | 1 -
>  fs/btrfs/disk-io.c          | 1 -
>  include/linux/backing-dev.h | 8 +++-----
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 18c092f8d69175..d81ee511ec8b01 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -538,7 +538,6 @@ struct request_queue *blk_alloc_queue(int node_id)
>  	if (!q->stats)
>  		goto fail_stats;
>  
> -	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
>  	q->node = node_id;
>  
>  	atomic_set(&q->nr_active_requests_shared_sbitmap, 0);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 047934cea25efa..e24927bddd5829 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3091,7 +3091,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_sb_buffer;
>  	}
>  
> -	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
>  	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
>  	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
>  
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 0b06b2d26c9aa3..52583b6f2ea05d 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -123,7 +123,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>   * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
>   * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
>   *
> - * BDI_CAP_CGROUP_WRITEBACK: Supports cgroup-aware writeback.
>   * BDI_CAP_SYNCHRONOUS_IO: Device is so fast that asynchronous IO would be
>   *			   inefficient.
>   */
> @@ -233,9 +232,9 @@ int inode_congested(struct inode *inode, int cong_bits);
>   * inode_cgwb_enabled - test whether cgroup writeback is enabled on an inode
>   * @inode: inode of interest
>   *
> - * cgroup writeback requires support from both the bdi and filesystem.
> - * Also, both memcg and iocg have to be on the default hierarchy.  Test
> - * whether all conditions are met.
> + * Cgroup writeback requires support from the filesystem.  Also, both memcg and
> + * iocg have to be on the default hierarchy.  Test whether all conditions are
> + * met.
>   *
>   * Note that the test result may change dynamically on the same inode
>   * depending on how memcg and iocg are configured.
> @@ -247,7 +246,6 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
>  	return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>  		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
>  		bdi_cap_account_dirty(bdi) &&
> -		(bdi->capabilities & BDI_CAP_CGROUP_WRITEBACK) &&
>  		(inode->i_sb->s_iflags & SB_I_CGROUPWB);
>  }
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
