Return-Path: <linux-fsdevel+bounces-75176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLujMRG8cmn6owAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:08:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87B6EB41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58AE301BCDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C82DE711;
	Fri, 23 Jan 2026 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei6UgpRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15709A930;
	Fri, 23 Jan 2026 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126908; cv=none; b=SsWWi3Yk2PsnHiOeVoQ3ny902ww7tv35mBynBc+uOyciCyK91EAKkyp9+LVDmok09PSZzhZ50e4ssWrWkKhN2WvvfakMKYepRBP3fz8JoYceM7+lUp3QoD1RC4I/o75TxiGE8DM2Ze9vDz6oAQ7bv7jX7IIpu47Dg/LvN5/1bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126908; c=relaxed/simple;
	bh=0KhxGRFeoUft5cbVL7XoiJGX3u8gGpNV6LUULQBikaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDiEOTJJ9xxDqTCzdfdXE/H9teGtvXkSVtxczF6QGHv/eKm1irQXWKwyew3ZocwzpQs+27HzG9Q60pAHVCUnBWmetRQy9EUG78Mkh+I20qsmdi6jeTJyQblfGdxsqCZVU1NvULyYeOj5H0Gq/5wjFJbTynDENn1Wej0gRYRp7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei6UgpRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F116C116C6;
	Fri, 23 Jan 2026 00:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769126906;
	bh=0KhxGRFeoUft5cbVL7XoiJGX3u8gGpNV6LUULQBikaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei6UgpRju41pP4wXOXI3XtdTcNkMqai4qJDGlXNJl9Gxu6JpIVthHqElmO7kkNhen
	 jV6uIynZSKLayxdqeoDrW0gb0WR+q4CvoicHhGdlinp0GTPFg2jjzgny5zCS+H4zV4
	 BD+1F0ZzBx77lAEzoOZ0YO1zgwpjY2IUA1LvBOdGVJji5OJmY2MVZkqjnO3n6ueCAG
	 iLbjq3HXjsxlfDRZp2WD7KGLIWEXCQeEdaK41JUlRHUahKPE87M+RyNCYbkdZOVHQa
	 EBXRx33+iPSDJgXe65ObdZa2HI1dKRU0aLPe2K6jDwXegbq9zo0ZZKIdE6TaB3z9XM
	 w9BvTe6MxvZVA==
Date: Thu, 22 Jan 2026 16:08:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 05/15] block: make max_integrity_io_size public
Message-ID: <20260123000825.GJ5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-6-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75176-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 4C87B6EB41
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:13AM +0100, Christoph Hellwig wrote:
> File systems that generate integrity will need this, so move it out
> of the block private or blk-mq specific headers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems reasonable to me given what I saw in the rest of the patchset...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/blk-settings.c          | 13 -------------
>  include/linux/blk-integrity.h |  5 -----
>  include/linux/blkdev.h        | 18 ++++++++++++++++++
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a9e65dc090da..dabfab97fbab 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -123,19 +123,6 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
>  	return 0;
>  }
>  
> -/*
> - * Maximum size of I/O that needs a block layer integrity buffer.  Limited
> - * by the number of intervals for which we can fit the integrity buffer into
> - * the buffer size.  Because the buffer is a single segment it is also limited
> - * by the maximum segment size.
> - */
> -static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
> -{
> -	return min_t(unsigned int, lim->max_segment_size,
> -		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
> -			lim->integrity.interval_exp);
> -}
> -
>  static int blk_validate_integrity_limits(struct queue_limits *lim)
>  {
>  	struct blk_integrity *bi = &lim->integrity;
> diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> index 91d12610d252..b2f34f696a4f 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -8,11 +8,6 @@
>  
>  struct request;
>  
> -/*
> - * Maximum contiguous integrity buffer allocation.
> - */
> -#define BLK_INTEGRITY_MAX_SIZE		SZ_2M
> -
>  enum blk_integrity_flags {
>  	BLK_INTEGRITY_NOVERIFY		= 1 << 0,
>  	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c1f3e6bcc217..8d4e622c1f98 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1875,6 +1875,24 @@ static inline int bio_split_rw_at(struct bio *bio,
>  	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
>  }
>  
> +/*
> + * Maximum contiguous integrity buffer allocation.
> + */
> +#define BLK_INTEGRITY_MAX_SIZE		SZ_2M
> +
> +/*
> + * Maximum size of I/O that needs a block layer integrity buffer.  Limited
> + * by the number of intervals for which we can fit the integrity buffer into
> + * the buffer size.  Because the buffer is a single segment it is also limited
> + * by the maximum segment size.
> + */
> +static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
> +{
> +	return min_t(unsigned int, lim->max_segment_size,
> +		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
> +			lim->integrity.interval_exp);
> +}
> +
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
>  #endif /* _LINUX_BLKDEV_H */
> -- 
> 2.47.3
> 
> 

