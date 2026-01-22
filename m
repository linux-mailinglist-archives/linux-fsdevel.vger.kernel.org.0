Return-Path: <linux-fsdevel+bounces-74949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH4BKppycWkPHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:43:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D3160022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7539D5031A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040830149E;
	Thu, 22 Jan 2026 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPHKoMtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35A302779;
	Thu, 22 Jan 2026 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042573; cv=none; b=i3nEc6IEdGboJZb0WLMHXf1EaMugYAdtSlb+kJw3pvbjyxI5BKpLwdJJkgoRS5R1sQ2TPz663gM8o4IKcfSNzCGhfiRvgSex4qsAT5/CLjUQDfc0q7Q/RT0sWh9oNFprQMR/VQ3K0/G16TjS5hPTYmViKw2pm4Z9+YckH4JZpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042573; c=relaxed/simple;
	bh=zTvk5vEuJ1hY3a+qHumNJYq0hPQOLYEvNChRIX9z6iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPPQ89UVNd156/OZV98wv9wjny0N5CLzKcS7ElMPgOEfB0dYfX09YcYn+G4LR6glWk/F+uTc9dpSHOuG7Gwfsj0QXnoEYoAw9IasWb//UjJoH3CoaLCG7k+YECutVnqrwkaag9uTKvbFTp9NMoHx/umGXxauJQO59+pB646UOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPHKoMtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A27C4CEF1;
	Thu, 22 Jan 2026 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769042571;
	bh=zTvk5vEuJ1hY3a+qHumNJYq0hPQOLYEvNChRIX9z6iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPHKoMtmcAsV3DTj8WS410UH0rRuuNPb1osoy7cLsuBANJVx9jr/Tw4UPdDanlYN5
	 6XPUgBMxhddY5tF15ni+BJ3I/L1gfg3nNWMwJ+B64LUyDhu5G2edTmI0aPB1TEEhg0
	 uKg4eRwrbmd3Txz9igyHzuoTpwIkR3849VVz4oSvzHfnJ+swjwOQDNG5H+dBo/l58u
	 zRNW0tu5fpfiBVvXp9mcNuegzfWRp097Mga0QiN3l0PcJk1fKybMOb7m53Qb6WLIok
	 Qm34XIwLHYK84+oAMGM3fjwZZLk3LJZ0nqr3i/DkSbHD8wf0XplLd//oj+Uz4nbBrk
	 zlkQNGq0fvDZA==
Date: Wed, 21 Jan 2026 16:42:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/15] iomap: refactor iomap_bio_read_folio_range
Message-ID: <20260122004250.GL5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-9-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74949-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 54D3160022
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:16AM +0100, Christoph Hellwig wrote:
> Split out the logic to allocate a new bio and only keep the fast path
> that adds more data to an existing bio in iomap_bio_read_folio_range.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like a simple function split to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/bio.c | 69 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index fc045f2e4c45..578b1202e037 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -26,45 +26,50 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
>  		submit_bio(bio);
>  }
>  
> -static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
> +static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, size_t plen)
>  {
> -	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;
> -	size_t poff = offset_in_folio(folio, pos);
> -	loff_t length = iomap_length(iter);
> -	sector_t sector;
> +	unsigned int nr_vecs = DIV_ROUND_UP(iomap_length(iter), PAGE_SIZE);
> +	struct folio *folio = ctx->cur_folio;
> +	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> +	gfp_t orig_gfp = gfp;
>  	struct bio *bio = ctx->read_ctx;
>  
> -	sector = iomap_sector(iomap, pos);
> -	if (!bio || bio_end_sector(bio) != sector ||
> -	    !bio_add_folio(bio, folio, plen, poff)) {
> -		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> -		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> +	if (bio)
> +		submit_bio(bio);
> +
> +	/* Same as readahead_gfp_mask: */
> +	if (ctx->rac)
> +		gfp |= __GFP_NORETRY | __GFP_NOWARN;
>  
> -		if (bio)
> -			submit_bio(bio);
> +	/*
> +	 * If the bio_alloc fails, try it again for a single page to avoid
> +	 * having to deal with partial page reads.  This emulates what
> +	 * do_mpage_read_folio does.
> +	 */
> +	bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp);
> +	if (!bio)
> +		bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> +	if (ctx->rac)
> +		bio->bi_opf |= REQ_RAHEAD;
> +	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
> +	bio->bi_end_io = iomap_read_end_io;
> +	bio_add_folio_nofail(bio, folio, plen,
> +			offset_in_folio(folio, iter->pos));
> +	ctx->read_ctx = bio;
> +}
> +
> +static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, size_t plen)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	struct bio *bio = ctx->read_ctx;
>  
> -		if (ctx->rac) /* same as readahead_gfp_mask */
> -			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> -				     gfp);
> -		/*
> -		 * If the bio_alloc fails, try it again for a single page to
> -		 * avoid having to deal with partial page reads.  This emulates
> -		 * what do_mpage_read_folio does.
> -		 */
> -		if (!bio)
> -			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> -		if (ctx->rac)
> -			bio->bi_opf |= REQ_RAHEAD;
> -		bio->bi_iter.bi_sector = sector;
> -		bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio_nofail(bio, folio, plen, poff);
> -		ctx->read_ctx = bio;
> -	}
> +	if (!bio ||
> +	    bio_end_sector(bio) != iomap_sector(&iter->iomap, iter->pos) ||
> +	    !bio_add_folio(bio, folio, plen, offset_in_folio(folio, iter->pos)))
> +		iomap_read_alloc_bio(iter, ctx, plen);
>  	return 0;
>  }
>  
> -- 
> 2.47.3
> 
> 

