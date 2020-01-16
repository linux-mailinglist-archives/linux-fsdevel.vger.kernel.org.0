Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F713DECC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPPcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 10:32:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAPPcM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:32:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A696B6A2E0;
        Thu, 16 Jan 2020 15:32:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBF3C1E06F1; Thu, 16 Jan 2020 16:32:06 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:32:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     yu kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200116153206.GF8446@quack2.suse.cz>
References: <20200116063601.39201-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116063601.39201-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-01-20 14:36:01, yu kuai wrote:
> I noticed that generic/418 test may fail with small probability. And with
> futher investiation, it can be reproduced with:
> 
> ./src/dio-invalidate-cache -wp -b 4096 -n 8 -i 1 -f filename
> ./src/dio-invalidate-cache -wt -b 4096-n 8 -i 1 -f filename
> 
> The failure is because direct write wrote none-zero but buffer read got
> zero.
> 
> In the process of buffer read, if the page do not exist, readahead will
> be triggered.  __do_page_cache_readahead() will allocate page first. Next,
> if the file block is unwritten(or hole), iomap_begin() will set iomap->type
> to IOMAP_UNWRITTEN(or IOMAP_HOLE). Then, iomap_readpages_actor() will add
> page to page cache. Finally, iomap_readpage_actor() will zero the page.
> 
> However, there is no lock or serialization between initializing iomap and
> adding page to page cache against direct write. If direct write happen to
> fininsh between them, the type of iomap should be IOMAP_MAPPED instead of
> IOMAP_UNWRITTEN or IOMAP_HOLE. And the page will end up zeroed out in page
> cache, while on-disk page hold the data of direct write.
> 
> | thread 1                    | thread 2                   |
> | --------------------------  | -------------------------- |
> | generic_file_buffered_read  |                            |
> |  ondemand_readahead         |                            |
> |   read_pages                |                            |
> |    iomap_readpages          |                            |
> |     iomap_apply             |                            |
> |      xfs_read_iomap_begin   |                            |
> |                             | xfs_file_dio_aio_write     |
> |                             |  iomap_dio_rw              |
> |                             |   ioamp_apply              |
> |     ioamp_readpages_actor   |                            |
> |      iomap_next_page        |                            |
> |       add_to_page_cache_lru |                            |
> |      iomap_readpage_actor   |                            |
> |       zero_user             |                            |
> |    iomap_set_range_uptodate |                            |
> |                             | generic_file_buffered_read |
> |                             |  copy_page_to_iter        |

Thanks for the report and the patch. But the data integrity when mixing
buffered and direct IO like this is best effort only. We definitely do not
want to sacrifice performance of common cases or code complexity to make
cases like this work reliably.

								Honza

> For consequences, the content in the page is zero while the content in the
> disk is not.
> 
> I tried to fix the problem by moving "add to page cache" before
> iomap_begin(). However, performance might be worse since iomap_begin()
> will be called for each page. I tested the performance for sequential
> read with fio:
> 
> kernel version: v5.5-rc6
> platform: arm64, 96 cpu
> fio version: fio-3.15-2
> test cmd:
> fio -filename=/mnt/testfile -rw=read -bs=4k -size=20g -direct=0 -fsync=0
> -numjobs=1 / 32 -ioengine=libaio -name=test -ramp_time=10 -runtime=120
> test result:
> |                  | without patch MiB/s | with patch MiB/s |
> | ---------------- | ------------------- | ---------------- |
> | ssd, numjobs=1   | 512                 | 512              |
> | ssd, numjobs=32  | 3615                | 3714             |
> | nvme, numjobs=1  | 1167                | 1118             |
> | nvme, numjobs=32 | 3679                | 3606             |
> 
> Test result shows that the impact on performance is minimal.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 104 ++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 828444e14d09..ccfa1a52d966 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -329,26 +329,44 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	return pos - orig_pos + plen;
>  }
>  
> -int
> -iomap_readpage(struct page *page, const struct iomap_ops *ops)
> +static int
> +do_iomap_readpage_apply(
> +	loff_t				offset,
> +	int				flag,
> +	const struct iomap_ops		*ops,
> +	struct iomap_readpage_ctx	*ctx,
> +	iomap_actor_t			actor,
> +	bool				fatal)
>  {
> -	struct iomap_readpage_ctx ctx = { .cur_page = page };
> -	struct inode *inode = page->mapping->host;
> -	unsigned poff;
> -	loff_t ret;
> -
> -	trace_iomap_readpage(page->mapping->host, 1);
> +	unsigned int			poff;
> +	loff_t				ret;
> +	struct page			*page = ctx->cur_page;
> +	struct inode			*inode = page->mapping->host;
>  
>  	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
> -		ret = iomap_apply(inode, page_offset(page) + poff,
> -				PAGE_SIZE - poff, 0, ops, &ctx,
> -				iomap_readpage_actor);
> +		ret = iomap_apply(inode, offset + poff, PAGE_SIZE - poff,
> +				  flag, ops, ctx, actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> +			if (fatal)
> +				return ret;
>  			SetPageError(page);
> -			break;
> +			return 0;
>  		}
>  	}
> +	return ret;
> +}
> +
> +
> +int
> +iomap_readpage(struct page *page, const struct iomap_ops *ops)
> +{
> +	struct iomap_readpage_ctx ctx = { .cur_page = page };
> +
> +	trace_iomap_readpage(page->mapping->host, 1);
> +
> +	do_iomap_readpage_apply(page_offset(page), 0, ops, &ctx,
> +				iomap_readpage_actor, false);
>  
>  	if (ctx.bio) {
>  		submit_bio(ctx.bio);
> @@ -395,34 +413,6 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
>  	return NULL;
>  }
>  
> -static loff_t
> -iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> -{
> -	struct iomap_readpage_ctx *ctx = data;
> -	loff_t done, ret;
> -
> -	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> -		}
> -		if (!ctx->cur_page) {
> -			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> -					pos, length, &done);
> -			if (!ctx->cur_page)
> -				break;
> -			ctx->cur_page_in_bio = false;
> -		}
> -		ret = iomap_readpage_actor(inode, pos + done, length - done,
> -				ctx, iomap, srcmap);
> -	}
> -
> -	return done;
> -}
> -
>  int
>  iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  		unsigned nr_pages, const struct iomap_ops *ops)
> @@ -433,22 +423,32 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	};
>  	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
>  	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> +	loff_t length = last - pos + PAGE_SIZE, ret = 0, done;
>  
>  	trace_iomap_readpages(mapping->host, nr_pages);
>  
> -	while (length > 0) {
> -		ret = iomap_apply(mapping->host, pos, length, 0, ops,
> -				&ctx, iomap_readpages_actor);
> +	for (done = 0; done < length; done += PAGE_SIZE) {
> +		if (ctx.cur_page) {
> +			if (!ctx.cur_page_in_bio)
> +				unlock_page(ctx.cur_page);
> +			put_page(ctx.cur_page);
> +			ctx.cur_page = NULL;
> +		}
> +		ctx.cur_page = iomap_next_page(mapping->host, ctx.pages,
> +					       pos, length, &done);
> +		if (!ctx.cur_page)
> +			break;
> +		ctx.cur_page_in_bio = false;
> +
> +		ret = do_iomap_readpage_apply(pos+done, 0, ops, &ctx,
> +					      iomap_readpage_actor, true);
>  		if (ret <= 0) {
> -			WARN_ON_ONCE(ret == 0);
> -			goto done;
> +			done = ret;
> +			break;
>  		}
> -		pos += ret;
> -		length -= ret;
> +
>  	}
> -	ret = 0;
> -done:
> +
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
>  	if (ctx.cur_page) {
> @@ -461,8 +461,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	 * Check that we didn't lose a page due to the arcance calling
>  	 * conventions..
>  	 */
> -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> -	return ret;
> +	WARN_ON_ONCE((done == length) && !list_empty(ctx.pages));
> +	return done;
>  }
>  EXPORT_SYMBOL_GPL(iomap_readpages);
>  
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
