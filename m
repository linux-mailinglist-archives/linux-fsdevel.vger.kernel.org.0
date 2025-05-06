Return-Path: <linux-fsdevel+bounces-48211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B23AABFDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CA5521D98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84026C3BB;
	Tue,  6 May 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ0Wt0b3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAD13B5A0
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524285; cv=none; b=HXjG/Q75FU8Iv3r3Q6U+QuRRAmHgRAiuzB1BSCrO3YN6If3D5J3ezIavAML4mV4TyWm651Nu2LsLfXCSmJ1e1+NNV2MKYYOj+ed/KDL0J/2T/PP4jwvOzE9tTn37GMs9IYf4zVOcVe+OKTQ7j74l3QG2YMKcygeDslJ5xFXfv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524285; c=relaxed/simple;
	bh=lWGa0YzrsNAidmLriSFiLbACP+Cqxph9ERknEriSXo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F6k7MVbM5TQ6OykyE4lydMgYjXqexupP4sBCeKbt9DjDbo1cRSWIkwCPTLwHFAvyDjHQXPBmBgKIP5yO8SVzu/f1E4ul8j3mLtahWKQID4eWtRlHqpGbopYonwL+fzZdg5xTbYBHwCgytUCHNsGb2+yZUJTgLnEXeHuAXV21aDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ0Wt0b3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYE/iJaEWWkj3XAUdt6Y2MRIMxQS8xkxYEL2g+iqr/4=;
	b=KZ0Wt0b3ns7XddfhQo2GF/1kYiOjT2oXBq3h7/T17922JPwJKQahy/mod4dRbWGn/6QjeI
	qkVbdBJMVhvVYUuC0lXPh5BVAiD85oa538y2eCxx8268ywnxlLESoA0+/SohsWdM7d8baB
	cnjugEx6NZ5zz0J3hFAAArPbyJuFHX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-iFm3h89cPpWZhsWYwYIa7Q-1; Tue,
 06 May 2025 05:37:58 -0400
X-MC-Unique: iFm3h89cPpWZhsWYwYIa7Q-1
X-Mimecast-MFC-AGG-ID: iFm3h89cPpWZhsWYwYIa7Q_1746524274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93ECB1800ECB;
	Tue,  6 May 2025 09:37:53 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58A8E18001D7;
	Tue,  6 May 2025 09:37:45 +0000 (UTC)
Date: Tue, 6 May 2025 11:37:42 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
    Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>, 
    Kent Overstreet <kent.overstreet@linux.dev>, 
    Mike Snitzer <snitzer@kernel.org>, Chris Mason <clm@fb.com>, 
    Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
    Andreas Gruenbacher <agruenba@redhat.com>, 
    Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
    Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
    slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
    linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
    linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
    linux-pm@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 14/19] dm-integrity: use bio_add_virt_nofail
In-Reply-To: <20250430212159.2865803-15-hch@lst.de>
Message-ID: <0c339358-8139-aafb-dc30-6b96d42d25cf@redhat.com>
References: <20250430212159.2865803-1-hch@lst.de> <20250430212159.2865803-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Wed, 30 Apr 2025, Christoph Hellwig wrote:

> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it, and do the same for the
> similar pattern using bio_add_page for adding the first segment after
> a bio allocation as that can't fail either.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-integrity.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 2a283feb3319..9dca9dbabfaa 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -2557,14 +2557,8 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
>  		char *mem;
>  
>  		outgoing_bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recheck_bios);
> -
> -		r = bio_add_page(outgoing_bio, virt_to_page(outgoing_data), ic->sectors_per_block << SECTOR_SHIFT, 0);
> -		if (unlikely(r != (ic->sectors_per_block << SECTOR_SHIFT))) {
> -			bio_put(outgoing_bio);
> -			bio->bi_status = BLK_STS_RESOURCE;
> -			bio_endio(bio);
> -			return;
> -		}
> +		bio_add_virt_nofail(outgoing_bio, outgoing_data,
> +				ic->sectors_per_block << SECTOR_SHIFT);
>  
>  		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
>  		if (IS_ERR(bip)) {
> @@ -3211,7 +3205,8 @@ static void integrity_recalc_inline(struct work_struct *w)
>  
>  	bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recalc_bios);
>  	bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
> -	__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
> +	bio_add_virt_nofail(bio, recalc_buffer,
> +			range.n_sectors << SECTOR_SHIFT);
>  	r = submit_bio_wait(bio);
>  	bio_put(bio);
>  	if (unlikely(r)) {
> @@ -3228,7 +3223,8 @@ static void integrity_recalc_inline(struct work_struct *w)
>  
>  	bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_WRITE, GFP_NOIO, &ic->recalc_bios);
>  	bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
> -	__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
> +	bio_add_virt_nofail(bio, recalc_buffer,
> +			range.n_sectors << SECTOR_SHIFT);
>  
>  	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
>  	if (unlikely(IS_ERR(bip))) {
> -- 
> 2.47.2
> 
> 


