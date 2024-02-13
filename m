Return-Path: <linux-fsdevel+bounces-11396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81085367C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FE61C20D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D0604B2;
	Tue, 13 Feb 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqdU2nsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A636027F;
	Tue, 13 Feb 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842795; cv=none; b=s/83NkovCzOs0x+OBHqbz/EX70FA0JlwtcHzTqcnUOoVHWH8xYzRUH6I1qwSB9/4UdMIYGOR91/agyzWkkeUgEJr8/0nJNTY9uGGMEb6UFvay84+PJc6odQoTujrG5Tuse7JYMtZIVWbXCsrPcJG3/4fPKnKqvAUlsQeaZpmu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842795; c=relaxed/simple;
	bh=tbs1Z8Amiwm27iNPaiqfjyYdo8SY3K2w682a+PlnzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSCX3Fj4lALK+GQ569bc+JtbjNwnSATlcjp0FQs6fLtkYv2KZAWKIzfK9H8evARf3qgvxcmVavtcVGJhwg+GvfhiL2sQMHUiYoSi3rbiAJBnIsts3wTdAe71LqQlHfFa2F5eBxuR8MVGlOHiRvlU7KYvR62WDvlaShk5sQoyo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqdU2nsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E891AC43399;
	Tue, 13 Feb 2024 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842795;
	bh=tbs1Z8Amiwm27iNPaiqfjyYdo8SY3K2w682a+PlnzMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqdU2nsuvjv3jLoYMdzGZFfmMFcTuZrLsbrxNizJjJL86utpl1zF/XWGBUEnKN9PS
	 90ZQlOXSfZC6yMXzKIJ5CEBf8R6SYiBiXWPP9paDfXDJujmy9FnrpTcsmCwCZXCH3/
	 sT67w/2LuTb5oNxloyW1b+AVBZNganeWlUs4H5NOBWRfhsYUWi4rgCqF8o1Ym3fSZH
	 OLpalrT4dHJl5naSP2I2C6dvz12kH3/BxgBT5r/AjSzX6buLRZx5FFJvgrkmxqucHR
	 Dz5JOkG/vJ0LUJGPHaV3jp3wz7j1xUAEzHsbUtcAAkgp5V2o4aMrMhd+Sp72QrJoXm
	 t7QiR9zj0ZYpQ==
Date: Tue, 13 Feb 2024 08:46:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 04/14] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Message-ID: <20240213164634.GV6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-5-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:03AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> mapping_min_order of pages if the bdi->ra_pages is less than that.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good to me,
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/readahead.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2648ec4f0494..4fa7d0e65706 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -138,7 +138,12 @@
>  void
>  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
>  {
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +	unsigned int max_pages = inode_to_bdi(mapping->host)->io_pages;
> +
>  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> +	if (ra->ra_pages < min_nrpages && min_nrpages < max_pages)
> +		ra->ra_pages = min_nrpages;
>  	ra->prev_pos = -1;
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
> -- 
> 2.43.0
> 
> 

