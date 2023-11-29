Return-Path: <linux-fsdevel+bounces-4138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B57FCF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9121C2094F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110410945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCI8hLee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5444383;
	Wed, 29 Nov 2023 04:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D0C433C7;
	Wed, 29 Nov 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701233419;
	bh=ZeUKPG6cuO+JGl1qM3nM/OfgoCGbJ54tniVqix00L+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCI8hLeeulZ/hsLfv03kQQfOIpWeMd6l59jdkJrM5HNGgSESbjyhUJv1YioqqSLz1
	 0SGL4kJByEBuzgEYJK/jizQJh8y6l4+wsn5lA2sCywqGyXqkVzWLWl2c3AETHIKFsI
	 +dYtZwTyU1linoh1pKrkKSEKlGMCv3bBfr6uD1BteO2dsmv5q3JJnSZ0CGgqwvrECL
	 eEOA+ezynHMuI02L8xAy8lupudGj9ocjsXwo1e0TKcXDtd21MVCQW0WFKYPzOPTfGV
	 Csjhbv7CoTYPslyKOdyOw/l5YPkciobVEyRbnLFpfiodhic1I8TKNlLDnbNegywOoE
	 MCdhyPKEpPnGw==
Date: Tue, 28 Nov 2023 20:50:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/13] iomap: move all remaining per-folio logic into
 xfs_writepage_map
Message-ID: <20231129045018.GL4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-7-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:13PM +0100, Christoph Hellwig wrote:
> Move the tracepoint and the iomap check from iomap_do_writepage into
> iomap_writepage_map.  This keeps all logic in one places, and leaves
> iomap_do_writepage just as the wrapper for the callback conventions of
> write_cache_pages, which will go away when that is convertd to an
> iterator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With the two fixes from Ritesh and Josef added, I think this looks like
a simple enough movement.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4a5a21809b0182..5834aa46bdb8cf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1842,19 +1842,25 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>   * At the end of a writeback pass, there will be a cached ioend remaining on the
>   * writepage context that the caller will need to submit.
>   */
> -static int
> -iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct inode *inode,
> -		struct folio *folio, u64 end_pos)
> +static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> +		struct writeback_control *wbc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode = folio->mapping->host;
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>  	u64 pos = folio_pos(folio);
> +	u64 end_pos = pos + folio_size(folio);
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> +	trace_iomap_writepage(inode, pos, folio_size(folio));
> +
> +	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +		folio_unlock(folio);
> +		return 0;
> +	}
>  	WARN_ON_ONCE(end_pos <= pos);
>  
>  	if (!ifs && nblocks > 1) {
> @@ -1952,28 +1958,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	return error;
>  }
>  
> -/*
> - * Write out a dirty page.
> - *
> - * For delalloc space on the page, we need to allocate space and flush it.
> - * For unwritten space on the page, we need to start the conversion to
> - * regular allocated space.
> - */
>  static int iomap_do_writepage(struct folio *folio,
>  		struct writeback_control *wbc, void *data)
>  {
> -	struct iomap_writepage_ctx *wpc = data;
> -	struct inode *inode = folio->mapping->host;
> -	u64 end_pos = folio_pos(folio) + folio_size(folio);
> -
> -	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
> -
> -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> -		folio_unlock(folio);
> -		return 0;
> -	}
> -
> -	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
> +	return iomap_writepage_map(data, wbc, folio);
>  }
>  
>  int
> -- 
> 2.39.2
> 
> 

