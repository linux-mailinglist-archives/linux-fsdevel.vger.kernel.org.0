Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4F30C2E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhBBPDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 10:03:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235025AbhBBPDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:03:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FFF2ABD5;
        Tue,  2 Feb 2021 15:02:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61523DA6FC; Tue,  2 Feb 2021 16:00:45 +0100 (CET)
Date:   Tue, 2 Feb 2021 16:00:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 29/42] btrfs: introduce dedicated data write path for
 ZONED mode
Message-ID: <20210202150045.GY1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <698bfc6446634e06a9399fa819d0f19aba3b4196.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698bfc6446634e06a9399fa819d0f19aba3b4196.1611627788.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:25:07AM +0900, Naohiro Aota wrote:
> If more than one IO is issued for one file extent, these IO can be written
> to separate regions on a device. Since we cannot map one file extent to
> such a separate area, we need to follow the "one IO == one ordered extent"
> rule.
> 
> The Normal buffered, uncompressed, not pre-allocated write path (used by
> cow_file_range()) sometimes does not follow this rule. It can write a part
> of an ordered extent when specified a region to write e.g., when its
> called from fdatasync().
> 
> Introduces a dedicated (uncompressed buffered) data write path for ZONED
> mode. This write path will CoW the region and write it at once.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a9bf78eaed42..6d43aaa1f537 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1400,6 +1400,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  	return 0;
>  }
>  
> +static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
> +				       struct page *locked_page, u64 start,
> +				       u64 end, int *page_started,
> +				       unsigned long *nr_written)
> +{
> +	int ret;
> +
> +	ret = cow_file_range(inode, locked_page, start, end,
> +			     page_started, nr_written, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (*page_started)
> +		return 0;
> +
> +	__set_page_dirty_nobuffers(locked_page);
> +	account_page_redirty(locked_page);
> +	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
> +	*page_started = 1;
> +
> +	return 0;
> +}
> +
>  static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
>  					u64 bytenr, u64 num_bytes)
>  {
> @@ -1879,17 +1902,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  {
>  	int ret;
>  	int force_cow = need_force_cow(inode, start, end);
> +	const bool do_compress = inode_can_compress(inode) &&
> +		inode_need_compress(inode, start, end);

This would make sense to cache the values, but inode_need_compress is
quite heavy as it runs the compression heuristic. This would affect all
cases and drop some perf.

> +	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
>  
>  	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
> +		ASSERT(!zoned);
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, 1, nr_written);
>  	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
> +		ASSERT(!zoned);
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, 0, nr_written);
> -	} else if (!inode_can_compress(inode) ||
> -		   !inode_need_compress(inode, start, end)) {
> +	} else if (!do_compress && !zoned) {
>  		ret = cow_file_range(inode, locked_page, start, end,
>  				     page_started, nr_written, 1);
> +	} else if (!do_compress && zoned) {
> +		ret = run_delalloc_zoned(inode, locked_page, start, end,
> +					 page_started, nr_written);

The part of the condition is shared so it should be structured lik

	} else if (!<the compression checks>) {
		if (zoned)
			run_delalloc_zoned
		else
			cow_file_range
	} ...

>  	} else {
>  		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
>  		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
> -- 
> 2.27.0
