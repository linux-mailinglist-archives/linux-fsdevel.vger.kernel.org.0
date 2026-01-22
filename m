Return-Path: <linux-fsdevel+bounces-74953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFCyDlR0cWm3HAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:50:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A86011F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61E463C45FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAC530EF8B;
	Thu, 22 Jan 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK0lKw4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059A30DEB8;
	Thu, 22 Jan 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043001; cv=none; b=b4V/jOhA7QCYpJkkbt22C+f+QA8KS6Q23tAUN//VIenB5d9Tn4cdQ9871NNSryEq41yp/ESE84/7VdEYRgKgnw61QccQ9HBOQuZo4L/imRXiLeMBp2jUiNqG0KyvPCi43W+sbMX+GBb6QPQP1Epy+PUorRrS0KkAQ84/9ZkqUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043001; c=relaxed/simple;
	bh=+RGcxUd99hoKacJIlN333sQGOxydL7izPv+L23h8zcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkGe2A8XLVIcy9ZDWChYhrP3IlyJJFPTFVnCK+yf1BXjwVZRKyfZukENmaY2xjRjm67iBiARiQ9FlJxh7RMWRgolSI2VXN7rHlySleaB5sPAsofimHpOk9MQuAdnFohiRrN9AlNHn7QD5W8W/PjO/uH65ZOLQgd7DVLloY+obDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK0lKw4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DF7C4CEF1;
	Thu, 22 Jan 2026 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769042999;
	bh=+RGcxUd99hoKacJIlN333sQGOxydL7izPv+L23h8zcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XK0lKw4ExB00ARnDoIDy5wZvd8pLpzQfC7Ez5CicNp0HgWWjh9PSw35XvG+Kieyue
	 oQ/VwWPc2Fv3HjjrpQIYxliRgfQH4Lp0RxpY5ArE5sUQqn/qeh2b6DdLsSLp/K1UMb
	 azxmb2XHWo/TJorITKHigE8a499NhBoiCI09agJRs96PdVUxZdpSLbK1epn6Ao7TsF
	 MIU8Q0NXP64BB+ieKYuheTv0bqp7HGTnQh4r04aYpFvgZss20nNcuajvjOYqCdVoOn
	 YN42xB+MOY8Lp4Skppm2zeXRT00fNnDICqrkB7SgnMoMCJdCULL+/+DN3HfAgTTlJ7
	 FdRp80WIUKHVA==
Date: Wed, 21 Jan 2026 16:49:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/15] iomap: add a bioset pointer to iomap_read_folio_ops
Message-ID: <20260122004959.GP5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-13-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74953-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 101A86011F
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:20AM +0100, Christoph Hellwig wrote:
> Optionally allocate the bio from the bioset provided in
> iomap_read_folio_ops.  If no bioset is provided, fs_bio_set is still
> used, which is the standard bioset for file systems.
> 
> Based on a patch from Goldwyn Rodrigues <rgoldwyn@suse.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks reasonable,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/bio.c        | 14 ++++++++++++--
>  include/linux/iomap.h |  6 ++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 903cb9fe759e..259a2bf95a43 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -24,11 +24,19 @@ static void iomap_bio_submit_read(const struct iomap_iter *iter,
>  	submit_bio(ctx->read_ctx);
>  }
>  
> +static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
> +{
> +	if (ctx->ops && ctx->ops->bio_set)
> +		return ctx->ops->bio_set;
> +	return &fs_bio_set;
> +}
> +
>  static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, size_t plen)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	unsigned int nr_vecs = DIV_ROUND_UP(iomap_length(iter), PAGE_SIZE);
> +	struct bio_set *bio_set = iomap_read_bio_set(ctx);
>  	struct folio *folio = ctx->cur_folio;
>  	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  	gfp_t orig_gfp = gfp;
> @@ -47,9 +55,11 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>  	 * having to deal with partial page reads.  This emulates what
>  	 * do_mpage_read_folio does.
>  	 */
> -	bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp);
> +	bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> +			gfp, bio_set);
>  	if (!bio)
> -		bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> +		bio = bio_alloc_bioset(iomap->bdev, 1, REQ_OP_READ, orig_gfp,
> +				bio_set);
>  	if (ctx->rac)
>  		bio->bi_opf |= REQ_RAHEAD;
>  	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b3f545d41720..24f884b6b0c4 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -515,6 +515,12 @@ struct iomap_read_ops {
>  	 */
>  	void (*submit_read)(const struct iomap_iter *iter,
>  			struct iomap_read_folio_ctx *ctx);
> +
> +	/*
> +	 * Optional, allows filesystem to specify own bio_set, so new bio's
> +	 * can be allocated from the provided bio_set.
> +	 */
> +	struct bio_set *bio_set;
>  };
>  
>  /*
> -- 
> 2.47.3
> 
> 

