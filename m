Return-Path: <linux-fsdevel+bounces-75130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKXlKTlmcmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:02:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47A6BE26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 136A331678D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6700F3876AF;
	Thu, 22 Jan 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdpNxxwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8738758D;
	Thu, 22 Jan 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102783; cv=none; b=glcKK/C6uoFUWoDxub3icwsSC9B/mTBpbezBCqXV1M86g0/vDFAxEMzgS3L2bg43IR/00rhX5Xga2oJzvtCrDojQwzIIdXKMPaOOhgJAOjInCoY54pW9h1AoOXTJx+n8gvB4t097btvs0NZLsLoV6WMuNGUHUgnzkpKtm1f2Mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102783; c=relaxed/simple;
	bh=+uprx3K11EFrSbxk+wVY/WJnH/k03EUP11gqmh7JhEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k79RejFsJ2DoWOg8P4QiVVoNinWmi7fbNIjbZrkwlFtcdlW8FnGwvQdJnddTBqfckgrtuQ2gvPpWtwjoWzm8ChIngcxob0/xFPIvzNN8BtLTIg78JxoNMPv2kvNsuArw1YLxuIodbHHfhR4imMKUEoJnF0HyvhCWq1Z0zUoG1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdpNxxwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA28C116C6;
	Thu, 22 Jan 2026 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102780;
	bh=+uprx3K11EFrSbxk+wVY/WJnH/k03EUP11gqmh7JhEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdpNxxwYXwtPCmE21HJ5h7uyAT0nq72KYG/ooW2ub/SjnlFs8yxUvKWWl0gqnLSrY
	 S9C4lpcRJsj/ZvFkGC+RN/xFkTG0Zwxi4+FSgGFXRlO0vyEhfycWwi9ni5n7v8k7Lg
	 PXojlwy/WGUxvlW5qCl37awdjU5SSS6G7HbyDvfGVZFGV6Al7yXmRpObMd+vNVZxvE
	 HbOdyIAf4+joTy+FCg5ikTPJo1duBaOm9/9Es/59/u+T/F9+59tMkLFo+BSZkmjfZx
	 bGv2XokV6UE6tH6wL/CrazpDCBqCROf43eTSYNLHJGIpwBQC/udApAmw4n3uaNVfbP
	 dZYzLnDwf1ePw==
Date: Thu, 22 Jan 2026 09:26:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/14] block: remove bio_release_page
Message-ID: <20260122172620.GW5945@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75130-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A47A6BE26
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 08:44:11AM +0100, Christoph Hellwig wrote:
> Merge bio_release_page into the only remaining caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio.c |  4 +++-
>  block/blk.h | 11 -----------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 12cd3c5f6d6d..c51b4e2470e2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1195,7 +1195,9 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>  			break;
>  		}
>  
> -		bio_release_page(bio, bv->bv_page);
> +		if (bio_flagged(bio, BIO_PAGE_PINNED))
> +			unpin_user_page(bv->bv_page);
> +
>  		bio->bi_vcnt--;
>  		nbytes -= bv->bv_len;
>  	} while (nbytes);
> diff --git a/block/blk.h b/block/blk.h
> index 980eef1f5690..886238cae5f1 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -595,17 +595,6 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
>  
>  struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  		struct lock_class_key *lkclass);
> -
> -/*
> - * Clean up a page appropriately, where the page may be pinned, may have a
> - * ref taken on it or neither.
> - */
> -static inline void bio_release_page(struct bio *bio, struct page *page)
> -{
> -	if (bio_flagged(bio, BIO_PAGE_PINNED))
> -		unpin_user_page(page);
> -}
> -
>  struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
>  
>  int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> -- 
> 2.47.3
> 
> 

