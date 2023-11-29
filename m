Return-Path: <linux-fsdevel+bounces-4144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE417FCF34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6322822FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C7101DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP6ipguo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C663C9;
	Wed, 29 Nov 2023 05:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81F5C433C8;
	Wed, 29 Nov 2023 05:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701234402;
	bh=QgiD5M4ptciPq9nPtGUIQzrlQH0E7zgy24x3SmXQWHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP6ipguos3ZyuZP00itHIKDei+lubFkCJdgHaZustwyoKdsnRwuwyQNLEMWoDF0lI
	 6ZqlkG+bKsfWKEyt0r/hT3mVU3LnQaWa9qTX/IBIkUkYyPR4ouyRsoEgyMLMyQKJCp
	 bjcB1TWXTlBDgVAtReJQ7xSBf4RE8CxtaLZyMmQ385yNd30bM+0Dl/dECsqtl4BJxn
	 hwCBM7237Ja//fL8WKBuxvvNO3SwiPRPvZvBivjdoOa01Htx1RtkeB82CK+IzHpJ5j
	 4Cy0c/o6xFbMPzaNGR5yajSC2SdR2hhApYhc8SzTyStpRpr98Clk03qi1uL/rhmA9U
	 Hgx3BYZ9119Tg==
Date: Tue, 28 Nov 2023 21:06:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/13] iomap: factor out a iomap_writepage_map_block
 helper
Message-ID: <20231129050642.GQ4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-12-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:18PM +0100, Christoph Hellwig wrote:
> Split the loop body that calls into the file system to map a block and
> add it to the ioend into a separate helper to prefer for refactoring of
> the surrounding code.
> 
> Note that this was the only place in iomap_writepage_map that could
> return an error, so include the call to ->discard_folio into the new
> helper as that will help to avoid code duplication in the future.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Simple enough hoist,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 72 +++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e1d5076251702d..9f223820f60d22 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1723,6 +1723,45 @@ static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  	wbc_account_cgroup_owner(wbc, &folio->page, len);
>  }
>  
> +static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
> +		struct writeback_control *wbc, struct folio *folio,
> +		struct inode *inode, u64 pos, unsigned *count,
> +		struct list_head *submit_list)
> +{
> +	int error;
> +
> +	error = wpc->ops->map_blocks(wpc, inode, pos);
> +	if (error)
> +		goto fail;
> +	trace_iomap_writepage_map(inode, &wpc->iomap);
> +
> +	switch (wpc->iomap.type) {
> +	case IOMAP_INLINE:
> +		WARN_ON_ONCE(1);
> +		error = -EIO;
> +		break;
> +	case IOMAP_HOLE:
> +		break;
> +	default:
> +		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, submit_list);
> +		(*count)++;
> +	}
> +
> +fail:
> +	/*
> +	 * We cannot cancel the ioend directly here on error.  We may have
> +	 * already set other pages under writeback and hence we have to run I/O
> +	 * completion to mark the error state of the pages under writeback
> +	 * appropriately.
> +	 *
> +	 * Just let the file system know what portion of the folio failed to
> +	 * map.
> +	 */
> +	if (error && wpc->ops->discard_folio)
> +		wpc->ops->discard_folio(folio, pos);
> +	return error;
> +}
> +
>  /*
>   * Check interaction of the folio with the file end.
>   *
> @@ -1807,7 +1846,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
> -	int error = 0, count = 0, i;
> +	unsigned count = 0;
> +	int error = 0, i;
>  	LIST_HEAD(submit_list);
>  
>  	trace_iomap_writepage(inode, pos, folio_size(folio));
> @@ -1833,19 +1873,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>  		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
>  			continue;
> -
> -		error = wpc->ops->map_blocks(wpc, inode, pos);
> +		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode, pos,
> +				&count, &submit_list);
>  		if (error)
>  			break;
> -		trace_iomap_writepage_map(inode, &wpc->iomap);
> -		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE)) {
> -			error = -EIO;
> -			break;
> -		}
> -		if (wpc->iomap.type == IOMAP_HOLE)
> -			continue;
> -		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, &submit_list);
> -		count++;
>  	}
>  	if (count)
>  		wpc->nr_folios++;
> @@ -1855,23 +1886,6 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	WARN_ON_ONCE(folio_test_writeback(folio));
>  	WARN_ON_ONCE(folio_test_dirty(folio));
>  
> -	/*
> -	 * We cannot cancel the ioend directly here on error.  We may have
> -	 * already set other pages under writeback and hence we have to run I/O
> -	 * completion to mark the error state of the pages under writeback
> -	 * appropriately.
> -	 */
> -	if (unlikely(error)) {
> -		/*
> -		 * Let the filesystem know what portion of the current page
> -		 * failed to map. If the page hasn't been added to ioend, it
> -		 * won't be affected by I/O completion and we must unlock it
> -		 * now.
> -		 */
> -		if (wpc->ops->discard_folio)
> -			wpc->ops->discard_folio(folio, pos);
> -	}
> -
>  	/*
>  	 * We can have dirty bits set past end of file in page_mkwrite path
>  	 * while mapping the last partial folio. Hence it's better to clear
> -- 
> 2.39.2
> 
> 

