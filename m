Return-Path: <linux-fsdevel+bounces-75173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNk4Bl67cmniowAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:05:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 448AA6EAA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7A0A3006926
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF429B8E5;
	Fri, 23 Jan 2026 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQMITqxz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9626ED3F;
	Fri, 23 Jan 2026 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126739; cv=none; b=KyTshN+XVDpppQc6guqwDl/btb8Xu2NpzCn2JRb9jbcBEtsC6qDpXyUEzOM1E/+7VXF3WIn/vvdKbQcUksvyHSNGhnFHZzk9kYJPtiUSokEjiepb3uNxphxPpIltuEjvAlzmEd3u0GQrwvLtbtpJm3uFpoAU8XYRlmGhZxz3AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126739; c=relaxed/simple;
	bh=+zdaxdd+FKvDLq2p+eusDmW9bflGlW+vBVsXf0EFRPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLCV6daBNpHDnBR2PjEiz465PEhRnHcUow/4XkUgowYtJBvruqZUnM0JQiS3uZ8RA15E3661HVbz/ey95Es3isgWviJLLOcZapnOzQzY+nNcZ299pLHecpllszHaMAW/7BRxM74Q9dMdkP2K8nXoFeIMDGeD8w+Xg0Dxi9zBN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQMITqxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247F0C116C6;
	Fri, 23 Jan 2026 00:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769126738;
	bh=+zdaxdd+FKvDLq2p+eusDmW9bflGlW+vBVsXf0EFRPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQMITqxzY/0z47DMSelQAiV+9tZ5xTWGApBqVRh8HnwvVG7gQVZgUArcMpfNik7sd
	 t8MZ7UE+rRKVcENVRzyjDu2GaQZJX8FpYdsmYUEM9c5VIIiSKx9o4UpIQmg9ui8K+k
	 M4MXlutrE8chXX5te5oziddrDzgdcK/E3GUBsXQD6lC7fX7RA/5hAguZrEEi2mAUSX
	 zOwIGk5Zrbk1duNRMD0zp5NJNJrB8INpuagfn5R+zknq/Guq6GMQAqbF0Eibdj8nZG
	 tlj2+kajNcP05SNeEA7WvUCiTdaN5zR5768spv1lmA/LOKhJvwXKkMDHrOC0xUrr6V
	 H3BMBnZQunNiw==
Date: Thu, 22 Jan 2026 16:05:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/15] block: factor out a bio_integrity_setup_default
 helper
Message-ID: <20260123000537.GG5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-3-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75173-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 448AA6EAA2
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:10AM +0100, Christoph Hellwig wrote:
> Add a helper to set the seed and check flag based on useful defaults
> from the profile.
> 
> Note that this includes a small behavior change, as we ow only sets the

"...as we only set the seed if..." ?

> seed if any action is set, which is fine as nothing will look at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity-auto.c    | 14 ++------------
>  block/bio-integrity.c         | 16 ++++++++++++++++
>  include/linux/bio-integrity.h |  1 +
>  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
> index 3a4141a9de0c..5345d55b9998 100644
> --- a/block/bio-integrity-auto.c
> +++ b/block/bio-integrity-auto.c
> @@ -88,7 +88,6 @@ bool __bio_integrity_endio(struct bio *bio)
>   */
>  void bio_integrity_prep(struct bio *bio, unsigned int action)
>  {
> -	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_data *bid;
>  
>  	bid = mempool_alloc(&bid_pool, GFP_NOIO);
> @@ -96,17 +95,8 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
>  	bid->bio = bio;
>  	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
>  	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
> -
> -	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
> -
> -	if (action & BI_ACT_CHECK) {
> -		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> -			bid->bip.bip_flags |= BIP_IP_CHECKSUM;
> -		if (bi->csum_type)
> -			bid->bip.bip_flags |= BIP_CHECK_GUARD;
> -		if (bi->flags & BLK_INTEGRITY_REF_TAG)
> -			bid->bip.bip_flags |= BIP_CHECK_REFTAG;
> -	}
> +	if (action & BI_ACT_CHECK)
> +		bio_integrity_setup_default(bio);
>  
>  	/* Auto-generate integrity metadata if this is a write */
>  	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 6bdbb4ed2d1a..0e8ebe84846e 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -101,6 +101,22 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
>  		kfree(bvec_virt(bv));
>  }
>  
> +void bio_integrity_setup_default(struct bio *bio)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	bip_set_seed(bip, bio->bi_iter.bi_sector);
> +
> +	if (bi->csum_type) {
> +		bip->bip_flags |= BIP_CHECK_GUARD;
> +		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)

/me wonders if this should be a switch, but it'd be a pretty lame one.

	switch (bi->csum_type) {
	case BLK_INTEGRITY_CSUM_NONE:
		break;
	case BLK_INTEGRITY_CSUM_IP:
		bip->bip_flags |= BIP_IP_CHECKSUM;
		fallthrough;
	case BLK_INTEGRITY_CSUM_CRC:
	case BLK_INTEGRITY_CSUM_CRC64:
		bip->bip_flags |= BIP_CHECK_GUARD;
		break;
	}

<shrug> I'll let you decide if you want slightly better typechecking.

With the commit message fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +			bip->bip_flags |= BIP_IP_CHECKSUM;
> +	}
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +		bip->bip_flags |= BIP_CHECK_REFTAG;
> +}
> +
>  /**
>   * bio_integrity_free - Free bio integrity payload
>   * @bio:	bio containing bip to be freed
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index 276cbbdd2c9d..232b86b9bbcb 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -143,5 +143,6 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>  
>  void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
>  void bio_integrity_free_buf(struct bio_integrity_payload *bip);
> +void bio_integrity_setup_default(struct bio *bio);
>  
>  #endif /* _LINUX_BIO_INTEGRITY_H */
> -- 
> 2.47.3
> 
> 

