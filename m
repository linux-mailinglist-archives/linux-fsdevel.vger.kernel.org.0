Return-Path: <linux-fsdevel+bounces-4145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFA7FCF35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA29B215B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550B1078B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmxrjck3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E23D8F;
	Wed, 29 Nov 2023 05:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80F0C433C8;
	Wed, 29 Nov 2023 05:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701234879;
	bh=3vskK8wdeN6V29tl59r57aLzkzTNpZbEqXqUX4c7m9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bmxrjck3oh+/eGkVx+LPT6K+j6AJ8SGIbVOACNtYzCazsGf5+QenvjMFJQUxBGMQE
	 SJI5bT07l9ERLb8kllcrIT80jJRbNXk4rELRk0MGARc7QxnR4xQICKUNfW1+P3lORm
	 iYxoSZDlBkFBsd6F1KbqBZFd8hV2r8jsHoS8AzNJEx088N538oSIHTegAnEycom6AU
	 64pH1omlV8XqLZnf1m9Aj1Cdn7g5+FhpeI325KsFhDLI4kYpW1FV9qFGWGFnvamWag
	 COuwtB/pw0iPYBcr48mF+//3rhm+sQUwwbMTKAyxHPnTOXXhUEb41IJdlHOOgCmdpy
	 eEvuNQW/ElLZg==
Date: Tue, 28 Nov 2023 21:14:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/13] iomap: submit ioends immediately
Message-ID: <20231129051439.GR4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-13-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:19PM +0100, Christoph Hellwig wrote:
> Currently the writeback code delays submitting fill ioends until we
> reach the end of the folio.  The reason for that is that otherwise
> the end I/O handler could clear the writeback bit before we've even
> finished submitting all I/O for the folio.
> 
> Add a bias to ifs->write_bytes_pending while we are submitting I/O
> for a folio so that it never reaches zero until all I/O is completed
> to prevent the early writeback bit clearing, and remove the now
> superfluous submit_list.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok, we'll see what happens in the last patch...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 157 ++++++++++++++++++++---------------------
>  1 file changed, 75 insertions(+), 82 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9f223820f60d22..a01b0686e7c8a0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1620,30 +1620,34 @@ static void iomap_writepage_end_bio(struct bio *bio)
>   * Submit the final bio for an ioend.
>   *
>   * If @error is non-zero, it means that we have a situation where some part of
> - * the submission process has failed after we've marked pages for writeback
> - * and unlocked them.  In this situation, we need to fail the bio instead of
> - * submitting it.  This typically only happens on a filesystem shutdown.
> + * the submission process has failed after we've marked pages for writeback.
> + * We cannot cancel ioend directly in that case, so call the bio end I/O handler
> + * with the error status here to run the normal I/O completion handler to clear
> + * the writeback bit and let the file system proess the errors.
>   */
> -static int
> -iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
> -		int error)
> +static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  {
> +	if (!wpc->ioend)
> +		return error;
> +
> +	/*
> +	 * Let the file systems prepare the I/O submission and hook in an I/O
> +	 * comletion handler.  This also needs to happen in case after a
> +	 * failure happened so that the file system end I/O handler gets called
> +	 * to clean up.
> +	 */
>  	if (wpc->ops->prepare_ioend)
> -		error = wpc->ops->prepare_ioend(ioend, error);
> +		error = wpc->ops->prepare_ioend(wpc->ioend, error);
> +
>  	if (error) {
> -		/*
> -		 * If we're failing the IO now, just mark the ioend with an
> -		 * error and finish it.  This will run IO completion immediately
> -		 * as there is only one reference to the ioend at this point in
> -		 * time.
> -		 */
> -		ioend->io_bio.bi_status = errno_to_blk_status(error);
> -		bio_endio(&ioend->io_bio);
> -		return error;
> +		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&wpc->ioend->io_bio);
> +	} else {
> +		submit_bio(&wpc->ioend->io_bio);
>  	}
>  
> -	submit_bio(&ioend->io_bio);
> -	return 0;
> +	wpc->ioend = NULL;
> +	return error;
>  }
>  
>  static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> @@ -1698,19 +1702,28 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)
>  /*
>   * Test to see if we have an existing ioend structure that we could append to
>   * first; otherwise finish off the current ioend and start another.
> + *
> + * If a new ioend is created and cached, the old ioend is submitted to the block
> + * layer instantly.  Batching optimisations are provided by higher level block
> + * plugging.
> + *
> + * At the end of a writeback pass, there will be a cached ioend remaining on the
> + * writepage context that the caller will need to submit.
>   */
> -static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> +static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, loff_t pos, struct list_head *iolist)
> +		struct inode *inode, loff_t pos)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	unsigned len = i_blocksize(inode);
>  	size_t poff = offset_in_folio(folio, pos);
> +	int error;
>  
>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
>  new_ioend:
> -		if (wpc->ioend)
> -			list_add(&wpc->ioend->io_list, iolist);
> +		error = iomap_submit_ioend(wpc, 0);
> +		if (error)
> +			return error;
>  		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
>  	}
>  
> @@ -1721,12 +1734,12 @@ static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		atomic_add(len, &ifs->write_bytes_pending);
>  	wpc->ioend->io_size += len;
>  	wbc_account_cgroup_owner(wbc, &folio->page, len);
> +	return 0;
>  }
>  
>  static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, u64 pos, unsigned *count,
> -		struct list_head *submit_list)
> +		struct inode *inode, u64 pos, unsigned *count)
>  {
>  	int error;
>  
> @@ -1743,7 +1756,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  	case IOMAP_HOLE:
>  		break;
>  	default:
> -		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, submit_list);
> +		iomap_add_to_ioend(wpc, wbc, folio, inode, pos);
>  		(*count)++;
>  	}
>  
> @@ -1820,35 +1833,21 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -/*
> - * We implement an immediate ioend submission policy here to avoid needing to
> - * chain multiple ioends and hence nest mempool allocations which can violate
> - * the forward progress guarantees we need to provide. The current ioend we're
> - * adding blocks to is cached in the writepage context, and if the new block
> - * doesn't append to the cached ioend, it will create a new ioend and cache that
> - * instead.
> - *
> - * If a new ioend is created and cached, the old ioend is returned and queued
> - * locally for submission once the entire page is processed or an error has been
> - * detected.  While ioends are submitted immediately after they are completed,
> - * batching optimisations are provided by higher level block plugging.
> - *
> - * At the end of a writeback pass, there will be a cached ioend remaining on the
> - * writepage context that the caller will need to submit.
> - */
>  static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = folio->mapping->host;
> -	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	unsigned count = 0;
>  	int error = 0, i;
> -	LIST_HEAD(submit_list);
> +
> +	WARN_ON_ONCE(!folio_test_locked(folio));
> +	WARN_ON_ONCE(folio_test_dirty(folio));
> +	WARN_ON_ONCE(folio_test_writeback(folio));
>  
>  	trace_iomap_writepage(inode, pos, folio_size(folio));
>  
> @@ -1858,12 +1857,27 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	}
>  	WARN_ON_ONCE(end_pos <= pos);
>  
> -	if (!ifs && nblocks > 1) {
> -		ifs = ifs_alloc(inode, folio, 0);
> -		iomap_set_range_dirty(folio, 0, end_pos - pos);
> +	if (nblocks > 1) {
> +		if (!ifs) {
> +			ifs = ifs_alloc(inode, folio, 0);
> +			iomap_set_range_dirty(folio, 0, end_pos - pos);
> +		}
> +
> +		/*
> +		 * Keep the I/O completion handler from clearing the writeback
> +		 * bit until we have submitted all blocks by adding a bias to
> +		 * ifs->write_bytes_pending, which is dropped after submitting
> +		 * all blocks.
> +		 */
> +		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
> +		atomic_inc(&ifs->write_bytes_pending);
>  	}
>  
> -	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
> +	/*
> +	 * Set the writeback bit ASAP, as the I/O completion for the single
> +	 * block per folio case happen hit as soon as we're submitting the bio.
> +	 */
> +	folio_start_writeback(folio);
>  
>  	/*
>  	 * Walk through the folio to find areas to write back. If we
> @@ -1874,18 +1888,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>  			continue;
>  		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode, pos,
> -				&count, &submit_list);
> +				&count);
>  		if (error)
>  			break;
>  	}
>  	if (count)
>  		wpc->nr_folios++;
>  
> -	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
> -	WARN_ON_ONCE(!folio_test_locked(folio));
> -	WARN_ON_ONCE(folio_test_writeback(folio));
> -	WARN_ON_ONCE(folio_test_dirty(folio));
> -
>  	/*
>  	 * We can have dirty bits set past end of file in page_mkwrite path
>  	 * while mapping the last partial folio. Hence it's better to clear
> @@ -1893,35 +1902,21 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 */
>  	iomap_clear_range_dirty(folio, 0, folio_size(folio));
>  
> -	if (error && !count) {
> -		folio_unlock(folio);
> -		goto done;
> -	}
> -
> -	folio_start_writeback(folio);
> -	folio_unlock(folio);
> -
>  	/*
> -	 * Preserve the original error if there was one; catch
> -	 * submission errors here and propagate into subsequent ioend
> -	 * submissions.
> +	 * Usually the writeback bit is cleared by the I/O completion handler.
> +	 * But we may end up either not actually writing any blocks, or (when
> +	 * there are multiple blocks in a folio) all I/O might have finished
> +	 * already at this point.  In that case we need to clear the writeback
> +	 * bit ourselves right after unlocking the page.
>  	 */
> -	list_for_each_entry_safe(ioend, next, &submit_list, io_list) {
> -		int error2;
> -
> -		list_del_init(&ioend->io_list);
> -		error2 = iomap_submit_ioend(wpc, ioend, error);
> -		if (error2 && !error)
> -			error = error2;
> +	folio_unlock(folio);
> +	if (ifs) {
> +		if (atomic_dec_and_test(&ifs->write_bytes_pending))
> +			folio_end_writeback(folio);
> +	} else {
> +		if (!count)
> +			folio_end_writeback(folio);
>  	}
> -
> -	/*
> -	 * We can end up here with no error and nothing to write only if we race
> -	 * with a partial page truncate on a sub-page block sized filesystem.
> -	 */
> -	if (!count)
> -		folio_end_writeback(folio);
> -done:
>  	mapping_set_error(inode->i_mapping, error);
>  	return error;
>  }
> @@ -1941,9 +1936,7 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  
>  	wpc->ops = ops;
>  	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
> -	if (!wpc->ioend)
> -		return ret;
> -	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> +	return iomap_submit_ioend(wpc, ret);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
>  
> -- 
> 2.39.2
> 
> 

