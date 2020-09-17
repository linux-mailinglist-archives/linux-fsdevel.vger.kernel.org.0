Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51AB26D7A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIQJ1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIQJ1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C817AFEC;
        Thu, 17 Sep 2020 09:28:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 50F3D1E12E1; Thu, 17 Sep 2020 11:27:42 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:27:42 +0200
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
        cgroups@vger.kernel.org
Subject: Re: [PATCH 11/12] bdi: invert BDI_CAP_NO_ACCT_WB
Message-ID: <20200917092742.GD7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-12-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:31, Christoph Hellwig wrote:
> Replace BDI_CAP_NO_ACCT_WB with a positive BDI_CAP_WRITEBACK_ACCT to
> make the checks more obvious.  Also remove the pointless
> bdi_cap_account_writeback wrapper that just obsfucates the check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fuse/inode.c             |  3 ++-
>  include/linux/backing-dev.h | 13 +++----------
>  mm/backing-dev.c            |  1 +
>  mm/page-writeback.c         |  4 ++--
>  4 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 17b00670fb539e..581329203d6860 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1050,7 +1050,8 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>  		return err;
>  
>  	/* fuse does it's own writeback accounting */
> -	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
> +	sb->s_bdi->capabilities &= ~BDI_CAP_WRITEBACK_ACCT;
> +	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
>  
>  	/*
>  	 * For a single fuse filesystem use max 1% of dirty +
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 5da4ea3dd0cc5c..b217344a2c63be 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -120,17 +120,17 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>   *
>   * BDI_CAP_NO_ACCT_DIRTY:  Dirty pages shouldn't contribute to accounting
>   * BDI_CAP_NO_WRITEBACK:   Don't write pages back
> - * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
> + * BDI_CAP_WRITEBACK_ACCT: Automatically account writeback pages
>   * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
>   */
>  #define BDI_CAP_NO_ACCT_DIRTY	0x00000001
>  #define BDI_CAP_NO_WRITEBACK	0x00000002
> -#define BDI_CAP_NO_ACCT_WB	0x00000004
> +#define BDI_CAP_WRITEBACK_ACCT	0x00000004
>  #define BDI_CAP_STRICTLIMIT	0x00000010
>  #define BDI_CAP_CGROUP_WRITEBACK 0x00000020
>  
>  #define BDI_CAP_NO_ACCT_AND_WRITEBACK \
> -	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_ACCT_WB)
> +	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY)
>  
>  extern struct backing_dev_info noop_backing_dev_info;
>  
> @@ -179,13 +179,6 @@ static inline bool bdi_cap_account_dirty(struct backing_dev_info *bdi)
>  	return !(bdi->capabilities & BDI_CAP_NO_ACCT_DIRTY);
>  }
>  
> -static inline bool bdi_cap_account_writeback(struct backing_dev_info *bdi)
> -{
> -	/* Paranoia: BDI_CAP_NO_WRITEBACK implies BDI_CAP_NO_ACCT_WB */
> -	return !(bdi->capabilities & (BDI_CAP_NO_ACCT_WB |
> -				      BDI_CAP_NO_WRITEBACK));
> -}
> -
>  static inline bool mapping_cap_writeback_dirty(struct address_space *mapping)
>  {
>  	return bdi_cap_writeback_dirty(inode_to_bdi(mapping->host));
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index f9a2842bd81c3d..ab0415dde5c66c 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -744,6 +744,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
>  		kfree(bdi);
>  		return NULL;
>  	}
> +	bdi->capabilities = BDI_CAP_WRITEBACK_ACCT;
>  	bdi->ra_pages = VM_READAHEAD_PAGES;
>  	bdi->io_pages = VM_READAHEAD_PAGES;
>  	return bdi;
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e9c36521461aaa..0139f9622a92da 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2738,7 +2738,7 @@ int test_clear_page_writeback(struct page *page)
>  		if (ret) {
>  			__xa_clear_mark(&mapping->i_pages, page_index(page),
>  						PAGECACHE_TAG_WRITEBACK);
> -			if (bdi_cap_account_writeback(bdi)) {
> +			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
>  				struct bdi_writeback *wb = inode_to_wb(inode);
>  
>  				dec_wb_stat(wb, WB_WRITEBACK);
> @@ -2791,7 +2791,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
>  						   PAGECACHE_TAG_WRITEBACK);
>  
>  			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
> -			if (bdi_cap_account_writeback(bdi))
> +			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
>  				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
>  
>  			/*
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
