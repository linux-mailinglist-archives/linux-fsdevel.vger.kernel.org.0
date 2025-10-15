Return-Path: <linux-fsdevel+bounces-64247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8CBDF78C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08915189C2B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150B335BA6;
	Wed, 15 Oct 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGT/6glt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F330D41;
	Wed, 15 Oct 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543309; cv=none; b=O2bvYNJskQQ4lvO6qV+nV3Q+n58rkQxMFR9uvDaWKkW7m4vHiRcvcywJmlwfx0axDR706qHJTYvgzs2msjOs5OZTFuT2X70AsUqvevd6d1Llm+WB1eF2CT026EFPqECxuYu7PaW98Jb2wKfUo5wRAXD9fiBN62wQGq0BoAmjXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543309; c=relaxed/simple;
	bh=PcbD53IFifY51gjnE3lF1GZ9oomY08lolU7XOa7R1yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLSX1PTWMUXrplq/YOaLnpO0R2Ge/8rPNG0+f8B44sF8o4vwpDOkOJaNTXfAbx3Fg3X4rHWNEZbmIJaoiSpZulu2Y/nNEX+xUsDEf+Yk2jTnShHQbYv6q/FXDKCI12w7C+6k7vHbaB4SJbY+X1F5mykoZLYbyo7qpIo7pJHrBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGT/6glt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA4C4CEF9;
	Wed, 15 Oct 2025 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543309;
	bh=PcbD53IFifY51gjnE3lF1GZ9oomY08lolU7XOa7R1yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGT/6gltZPJO/FyYdlzCYW8E53mSDMc15Fbkhf2G1qeh1fzUiO8x41AQQ2cKyY21c
	 J1xg5b+79/nGS295RKo7cSJ2MicE20a9wDH3GrJGN875lLkXSX23X5E8+3uaep2oKU
	 sANESm35StR8asw4Iwjz5YJqWSLfRnmww36hIH9jjmSlrwAOKUZ79v1IB2uNo3rYN6
	 ofMJIeLd0HfjBZyMTuBcuJgirXGj6fqZktdoYDhb0NWsnbzSwi93u5oqpQ7ejKb77u
	 5NyRQ22RrCf7NsILcn1I0mSqX4ibvgDilMcr6kxwME3Eb4v0WlnQyt3VWNW13T3IKD
	 X/K5vvyFlLAWA==
Date: Wed, 15 Oct 2025 08:48:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Message-ID: <20251015154828.GZ6188@frogsfrogsfrogs>
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015062728.60104-2-hch@lst.de>

On Wed, Oct 15, 2025 at 03:27:14PM +0900, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks pretty simple to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fs-writeback.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..11fd08a0efb8 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1893,16 +1893,12 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
>  	 *                   (maybe slowly) sync all tagged pages
>  	 */
>  	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
> -		pages = LONG_MAX;
> -	else {
> -		pages = min(wb->avg_write_bandwidth / 2,
> -			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> -		pages = min(pages, work->nr_pages);
> -		pages = round_down(pages + MIN_WRITEBACK_PAGES,
> -				   MIN_WRITEBACK_PAGES);
> -	}
> +		return LONG_MAX;
>  
> -	return pages;
> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	pages = min(pages, work->nr_pages);
> +	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
>  }
>  
>  /*
> -- 
> 2.47.3
> 
> 

