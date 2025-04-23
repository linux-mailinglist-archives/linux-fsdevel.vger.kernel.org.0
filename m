Return-Path: <linux-fsdevel+bounces-47037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB9A97EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E67AE125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087091B4247;
	Wed, 23 Apr 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zU/1xQ0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ArKjOUS9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zU/1xQ0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ArKjOUS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6A1D5CEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388444; cv=none; b=JVqxhFAzXHeZBGtfLdEU1KASeWLEJRCEiwu3Ke0I7hZq/urhCxzAmo4DjsDW3B4ictd6j3BoMC8RavEVA2fPTNLrjB7jSKzkmoW0jy/wBX6GpNaa1SA4seCE5hNymek2/eZCen0z4ZmBII/pqnyClahWZ7Cbz/xK418BaItodGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388444; c=relaxed/simple;
	bh=y8dtzYTvAXWQ/yTHzlAHfQgDYKClcG6hA3zwC0LDrI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/pi0oYQMjiBVA12KGtgNmWvUmxugBN8I6faixzPmaHhT4be2O9tw3sTp35UpKqYCAqeIFzbVhd6neQEyc11hLXg5kBcgpIDucmluS8Q1dOqfyiXDBjZZ2zrBYZDkAaiCSS7lL9h3HsoVwf9Oxd2b1zHo7JulTTfAPaiWE7oe4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zU/1xQ0s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ArKjOUS9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zU/1xQ0s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ArKjOUS9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 725DB1F38E;
	Wed, 23 Apr 2025 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=958amM+66Hhr9wKtvA4VcJgVSaxlEUvwp0G0OyP7nVg=;
	b=zU/1xQ0sy/I44pP6hDXIMKcg6XXeNbgnk65a9Gsqpe2d+rUxZdY1ar1yrBsGigp2eJBdz7
	Caz/IQrznnskHMKQIS1blFSDPBkeoHxOM+r+dTMIqs69tnyepPet/fl7oT6yO53CwlVzNq
	xmDZMPPA3KHZJDxXhq89F4yXfKsCVLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=958amM+66Hhr9wKtvA4VcJgVSaxlEUvwp0G0OyP7nVg=;
	b=ArKjOUS9F7deR985t2VffPTtWO4RM0X4OqufkG9EJFvej9GaZ815hPt5Jc9LSA73hWyMUD
	/6zjMTaEpc4HrJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=958amM+66Hhr9wKtvA4VcJgVSaxlEUvwp0G0OyP7nVg=;
	b=zU/1xQ0sy/I44pP6hDXIMKcg6XXeNbgnk65a9Gsqpe2d+rUxZdY1ar1yrBsGigp2eJBdz7
	Caz/IQrznnskHMKQIS1blFSDPBkeoHxOM+r+dTMIqs69tnyepPet/fl7oT6yO53CwlVzNq
	xmDZMPPA3KHZJDxXhq89F4yXfKsCVLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=958amM+66Hhr9wKtvA4VcJgVSaxlEUvwp0G0OyP7nVg=;
	b=ArKjOUS9F7deR985t2VffPTtWO4RM0X4OqufkG9EJFvej9GaZ815hPt5Jc9LSA73hWyMUD
	/6zjMTaEpc4HrJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5A213691;
	Wed, 23 Apr 2025 06:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gd76IJeDCGgYTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:07:19 +0000
Message-ID: <af8353ec-3648-457c-aa68-99af6392a74c@suse.de>
Date: Wed, 23 Apr 2025 08:07:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] block: add a bdev_rw_virt helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4dj9zzjoqkf1d3y4dfoejhya)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,lst.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/22/25 16:26, Christoph Hellwig wrote:
> Add a helper to perform synchronous I/O on a kernel direct map range.
> Currently this is implemented in various places in usually not very
> efficient ways, so provide a generic helper instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c         | 30 ++++++++++++++++++++++++++++++
>   include/linux/bio.h |  5 ++++-
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4e6c85a33d74..a6a867a432cf 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1301,6 +1301,36 @@ int submit_bio_wait(struct bio *bio)
>   }
>   EXPORT_SYMBOL(submit_bio_wait);
>   
> +/**
> + * bdev_rw_virt - synchronously read into / write from kernel mapping
> + * @bdev:	block device to access
> + * @sector:	sector to accasse
> + * @data:	data to read/write
> + * @len:	length to read/write
> + * @op:		operation (e.g. REQ_OP_READ/REQ_OP_WRITE)
> + *
> + * Performs synchronous I/O to @bdev for @data/@len.  @data must be in
> + * the kernel direct mapping and not a vmalloc address.
> + */
> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
> +		size_t len, enum req_op op)
> +{
> +	struct bio_vec bv;
> +	struct bio bio;
> +	int error;
> +
> +	if (WARN_ON_ONCE(is_vmalloc_addr(data)))
> +		return -EIO;
> +
> +	bio_init(&bio, bdev, &bv, 1, op);
> +	bio.bi_iter.bi_sector = sector;
> +	bio_add_virt_nofail(&bio, data, len);
> +	error = submit_bio_wait(&bio);
> +	bio_uninit(&bio);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(bdev_rw_virt);
> +
>   static void bio_wait_end_io(struct bio *bio)
>   {
>   	complete(bio->bi_private);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 0678b67162ee..17a10220c57d 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -402,7 +402,6 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>   
>   struct request_queue;
>   
> -extern int submit_bio_wait(struct bio *bio);
>   void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>   	      unsigned short max_vecs, blk_opf_t opf);
>   extern void bio_uninit(struct bio *);
> @@ -434,6 +433,10 @@ static inline void bio_add_virt_nofail(struct bio *bio, void *vaddr,
>   	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
>   }
>   
> +int submit_bio_wait(struct bio *bio);
> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
> +		size_t len, enum req_op op);
> +
>   int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
>   void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
>   void __bio_release_pages(struct bio *bio, bool mark_dirty);

Any specific reason why the declaration of 'submit_bio_wait()' is moved?

Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

