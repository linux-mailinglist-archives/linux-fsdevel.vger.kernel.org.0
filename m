Return-Path: <linux-fsdevel+bounces-37696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D19F5D19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0A97A218E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AFB12A177;
	Wed, 18 Dec 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riq+nY01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499F2E630;
	Wed, 18 Dec 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734490075; cv=none; b=njuO+RMHfQmygsG2XEP8iGUg23PvAGF3g+FBNLtPN1SqDXNgDyrHz6x4WvCvivkkb8Zef6pjRBiGb4aKCHDL6GzdaxUbOVCbx3NHGwImvbu9+bcQt4jOuNgWxsZp6KiFfOkrbLtX//Uwix8NYEH4ORSrG7cb+utoydZ3Y0EPyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734490075; c=relaxed/simple;
	bh=tnGx6pTsNvbBrbAYxGS0Gs9cemvIkinG+zu49qyWpHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFXu1fIsYb86LN20JsiuiN2ZNc19jKMGNCECLes2a3RW+klaCGoKUZL6RMVpQyF5dFMlOT0cFJc/CP2qIlGVsdgbJresO8ClYBdhjhp6blyMMHKXTyZWbGfxUzxrzN4WUNtqyR/gB4DkNeYYN0e6BiD26B92W0tMgdD80VWtGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riq+nY01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7133EC4CED3;
	Wed, 18 Dec 2024 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734490074;
	bh=tnGx6pTsNvbBrbAYxGS0Gs9cemvIkinG+zu49qyWpHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riq+nY01m2S7K/GguawyBy09WBzMdRSYLQUjnnzLIYUWOGc+btM9hBiPQDTgpwoHH
	 sd06n0DwzmdKpMYxVAtGW07CAiqxb3VjTnpzTpC+LmyNPCHTXGneV2EcD33DCnj5Ma
	 DyjbScaLUwPRSUjExECdhdfUtVxFe8dU8vUP7HobrcfnGa9dO78qnqapgtAcx1t56u
	 VWXOmDwnHCbGs7y1qSVjxYDCRGQu+b5YPDK3hGyS5irR+zLQWStF/avuqwHOC7IzgF
	 WQK0wHctEos+kHe8twbeC+RfCrGyr1uo7055sWSEBCSjQ3NW6cNPoydxu9HsG6ZNoz
	 XQn0Ablkfej4Q==
Date: Tue, 17 Dec 2024 18:47:53 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de, willy@infradead.org, dave@stgolabs.net,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH 5/5] fs/buffer: reduce stack usage on bh_read_iter()
Message-ID: <Z2I32cnkTMpk7_n1@bombadil.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <20241218022626.3668119-6-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218022626.3668119-6-mcgrof@kernel.org>

On Tue, Dec 17, 2024 at 06:26:26PM -0800, Luis Chamberlain wrote:
> Now that we can read asynchronously buffer heads from a folio in
> chunks,  we can chop up bh_read_iter() with a smaller array size.
> Use an array of 8 to avoid stack growth warnings on systems with
> huge base page sizes.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/buffer.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b8ba72f2f211..bfa9c09b8597 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2415,7 +2415,10 @@ static void bh_read_batch_async(struct folio *folio,
>           (__tmp);					\
>           (__tmp) = bh_next(__tmp, __head))
>  
> +#define MAX_BUF_CHUNK 8
> +
>  struct bh_iter {
> +	int chunk_number;
>  	sector_t iblock;
>  	get_block_t *get_block;
>  	bool any_get_block_error;

Oh... this can be cleaned up even further, chunk_idx and be removed now,
and we can also remove the unused i variable... I'll wait for more
feedback for a v2.

  Luis

