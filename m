Return-Path: <linux-fsdevel+bounces-56617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E824AB19BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12F14E054A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB923497B;
	Mon,  4 Aug 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dvJvOBaY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="320s1qyN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dvJvOBaY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="320s1qyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15922D4C0
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290445; cv=none; b=aolLJ3iJGmRseXM5Ik3fcpGk3p3MJr6kIoDm50oxlRA7wjyZQ9WRfH3meEcAvsWmlie3y2hwwypXDaUJy4BCZdxKqH2e+ObZxIvfgvyu7jqsOJ3ab4tCPFV+TDLsmvfZZp9zENnVjSIsh3Ng7pJ/zQfNd4w5shp6rk9Gaufy2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290445; c=relaxed/simple;
	bh=fi6qkVgdTVg4FvJ7ah4M8mtfDEkXAskvaMKmWQ6DRF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsAgUoe6S7uxX9t+LCEtblGaWbKt/D8Lguhvesj4giMtuB4FwKKpGnvefQvtev/vXpJ0mtBknVynMp63AkoAKGuFQgEiXEzn2t+8XJcE4TonrnZrBs6UOdN7lyFEn2+nbapC+qzKFtWnQu5Qfp+PnaNZ4zsvoKR4PvCJsprm5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dvJvOBaY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=320s1qyN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dvJvOBaY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=320s1qyN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 236B21F387;
	Mon,  4 Aug 2025 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmMwva8sV0SbudeV1/yoQROf0pxeqH9DzddikxFTlgg=;
	b=dvJvOBaY9y0J3Mxp4Ls4zWMlHFTie8F37ywuPofKVy1B7P0Wp2iDqABSkHNxLJRSYOhBG3
	W6Zu+GJTBui+gy9bYUdKSDZoSxAkccw/iLURV5TwQObclro3XS2ChHaf5mAMm7ZiE4hLDT
	MzAewMFLgnhoXbMRTZ+Nulu9g2n3eSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmMwva8sV0SbudeV1/yoQROf0pxeqH9DzddikxFTlgg=;
	b=320s1qyNbVRh8wJjmV5L7Pj8pFXNNcdmupFEE5bRghqM0DKMAjkn0C3k2F0wgTGblj50Bb
	pCpNff+iKa2sBpAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dvJvOBaY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=320s1qyN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmMwva8sV0SbudeV1/yoQROf0pxeqH9DzddikxFTlgg=;
	b=dvJvOBaY9y0J3Mxp4Ls4zWMlHFTie8F37ywuPofKVy1B7P0Wp2iDqABSkHNxLJRSYOhBG3
	W6Zu+GJTBui+gy9bYUdKSDZoSxAkccw/iLURV5TwQObclro3XS2ChHaf5mAMm7ZiE4hLDT
	MzAewMFLgnhoXbMRTZ+Nulu9g2n3eSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmMwva8sV0SbudeV1/yoQROf0pxeqH9DzddikxFTlgg=;
	b=320s1qyNbVRh8wJjmV5L7Pj8pFXNNcdmupFEE5bRghqM0DKMAjkn0C3k2F0wgTGblj50Bb
	pCpNff+iKa2sBpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C74DD133D1;
	Mon,  4 Aug 2025 06:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5PILLwhZkGikTwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:54:00 +0000
Message-ID: <14c5a629-2169-4271-97b8-a1aba45a6e54@suse.de>
Date: Mon, 4 Aug 2025 08:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] block: align the bio after building it
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-3-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 236B21F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Ensure the entire size is aligned after it's built instead of ensuring
> each vector is block size aligned while constructing it. This makes it
> more flexible to accepting device valid vectors that would otherwise get
> rejected by overzealous alignment checks.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c | 58 +++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 92c512e876c8d..c050903e1be0c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1227,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
>   		extraction_flags |= ITER_ALLOW_P2PDMA;
>   
> -	/*
> -	 * Each segment in the iov is required to be a block size multiple.
> -	 * However, we may not be able to get the entire segment if it spans
> -	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
> -	 * result to ensure the bio's total size is correct. The remainder of
> -	 * the iov data will be picked up in the next bio iteration.
> -	 */
>   	size = iov_iter_extract_pages(iter, &pages,
>   				      UINT_MAX - bio->bi_iter.bi_size,
>   				      nr_pages, extraction_flags, &offset);
> @@ -1241,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   		return size ? size : -EFAULT;
>   
>   	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> -
> -	if (bio->bi_bdev) {
> -		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
> -		iov_iter_revert(iter, trim);
> -		size -= trim;
> -	}
> -
> -	if (unlikely(!size)) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> -
>   	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
>   		struct page *page = pages[i];
>   		struct folio *folio = page_folio(page);
> @@ -1297,6 +1278,44 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	return ret;
>   }
>   
> +static inline void bio_revert(struct bio *bio, unsigned int nbytes)
> +{
> +	bio->bi_iter.bi_size -= nbytes;
> +
> +	while (nbytes) {
> +		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +
> +		if (nbytes < bv->bv_len) {
> +			bv->bv_len -= nbytes;
> +			return;
> +		}
> +
> +		bio_release_page(bio, bv->bv_page);
> +		bio->bi_vcnt--;
> +		nbytes -= bv->bv_len;
> +       }
> +}
> +
> +static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
> +{
> +	struct block_device *bdev = bio->bi_bdev;
> +	size_t nbytes;
> +
> +	if (!bdev)
> +		return 0;
> +
> +	nbytes = bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
> +	if (!nbytes)
> +		return 0;
> +
> +	bio_revert(bio, nbytes);
> +	iov_iter_revert(iter, nbytes);
> +	if (!bio->bi_iter.bi_size)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   /**
>    * bio_iov_iter_get_pages - add user or kernel pages to a bio
>    * @bio: bio to add pages to
> @@ -1336,6 +1355,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   		ret = __bio_iov_iter_get_pages(bio, iter);
>   	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
>   
> +	ret = bio_align_to_lbs(bio, iter);
>   	return bio->bi_vcnt ? 0 : ret;

Wouldn't that cause the error from bio_align_to_lba() to be ignored
if bio->bi_vcnt is greater than 0?

>   }
>   EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);

Cheers,

Hsnnes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

