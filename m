Return-Path: <linux-fsdevel+bounces-74958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDkNC7p3cWkJHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:04:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF3602B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA394FA61F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84F325729;
	Thu, 22 Jan 2026 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0YLdRka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37D3271F9;
	Thu, 22 Jan 2026 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043881; cv=none; b=J4gqe9eF9hlR+1+gtY0TBxD1DRvmogNVavllx+a/oSsOuGk/aPqasiEsYeKPMRg1EkG2ELrxB1WKkOhV7P4NKS1otJJzNxAuj0CPoouC3dQieiDAJo10H83ybzzjmQb7zgsbv2qrjeyaz7ocJpeaHHLPRvaLpBe7iqRXqTrpv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043881; c=relaxed/simple;
	bh=1M92osCLOAcqjlx4r3JdGnpfGhqcLTqReWA2nBg/AIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkmDjOdUBOtPfLn2DSm1S3TPk/iqdyRTjbBqkHodP7WQM2qwIaODmOpEt76I+op+3fvUEvJLDCEucpSrGVDlmN8Pa2R74c2U8Q2K0TZYE3Fm/xIgBPExi7SS2mW7NorogIAAlNInqlelxeKVGlNW55A1jmwP/6AeOX9xVh1x24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0YLdRka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7DDC4CEF1;
	Thu, 22 Jan 2026 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043881;
	bh=1M92osCLOAcqjlx4r3JdGnpfGhqcLTqReWA2nBg/AIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0YLdRkaNfuxT7wUTVLHlkztvm6FQZD3l7TDCZkD3zxGGQpW07Pwo90piIw5zs68C
	 3MJAtfNMs4DQ+AjUI+V7O1xF4iAM5peyQvKaUI/+FkK10XlR73HvVNlS+HF0Jz44Mf
	 alLcAN852JSV8gm7b6dK5jys6sq/GmDEx4X1yXG4e0FIv676QyNXwCn7GqUSO0LLeX
	 RbV01AfSBdEt86TjrgK+rApqYF74UGBgiur21KQgUWcGwNdsejwjeYv4OSYB/6uDZG
	 MGCkNjhyU6LxxGDAeacc7H8kQ6GOztELwXsFm7ll1CLz21zmF3gyM1O/gA7UmnKq30
	 zItthxwTb/13g==
Date: Wed, 21 Jan 2026 17:04:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to
 bio_iov_iter_bounce
Message-ID: <20260122010440.GT5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-8-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74958-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: CBAF3602B4
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:15AM +0100, Christoph Hellwig wrote:
> Allow the file system to limit the size processed in a single
> bounce operation.  This is needed when generating integrity data
> so that the size of a single integrity segment can't overflow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c          | 17 ++++++++++-------
>  fs/iomap/direct-io.c |  2 +-
>  include/linux/bio.h  |  2 +-
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index da795b1df52a..e89b24dc0283 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1293,9 +1293,10 @@ static void bio_free_folios(struct bio *bio)
>  	}
>  }
>  
> -static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
> +static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
> +		size_t maxlen)
>  {
> -	size_t total_len = iov_iter_count(iter);
> +	size_t total_len = min(maxlen, iov_iter_count(iter));
>  
>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>  		return -EINVAL;
> @@ -1333,9 +1334,10 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
>  	return 0;
>  }
>  
> -static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
> +static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
> +		size_t maxlen)
>  {
> -	size_t len = min(iov_iter_count(iter), SZ_1M);
> +	size_t len = min3(iov_iter_count(iter), maxlen, SZ_1M);
>  	struct folio *folio;
>  
>  	folio = folio_alloc_greedy(GFP_KERNEL, &len);
> @@ -1372,6 +1374,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
>   * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
>   * @bio:	bio to send
>   * @iter:	iter to read from / write into
> + * @maxlen:	maximum size to bounce
>   *
>   * Helper for direct I/O implementations that need to bounce buffer because
>   * we need to checksum the data or perform other operations that require
> @@ -1379,11 +1382,11 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
>   * copies the data into it.  Needs to be paired with bio_iov_iter_unbounce()
>   * called on completion.
>   */
> -int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter)
> +int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen)
>  {
>  	if (op_is_write(bio_op(bio)))
> -		return bio_iov_iter_bounce_write(bio, iter);
> -	return bio_iov_iter_bounce_read(bio, iter);
> +		return bio_iov_iter_bounce_write(bio, iter, maxlen);
> +	return bio_iov_iter_bounce_read(bio, iter, maxlen);
>  }
>  
>  static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9c572de0d596..842fc7fecb2d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -326,7 +326,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
>  	if (dio->flags & IOMAP_DIO_BOUNCE)
> -		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
> +		ret = bio_iov_iter_bounce(bio, dio->submit.iter, UINT_MAX);

Nitpicking here, but shouldn't this be SIZE_MAX?

--D

>  	else
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
>  					     alignment - 1);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 95cfc79b88b8..df0d7e71372a 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -479,7 +479,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
>  
> -int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
> +int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen);
>  void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
>  
>  extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
> -- 
> 2.47.3
> 
> 

