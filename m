Return-Path: <linux-fsdevel+bounces-11376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C6C853410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65351F2A518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D87604BF;
	Tue, 13 Feb 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yx8bhuuO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l1buCSUe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yx8bhuuO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l1buCSUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3D5EE60;
	Tue, 13 Feb 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836427; cv=none; b=EI+dKmOhhXmrIla36Lijt9gJy2CNGvjU8A8NyoupVc9tW1tSZggzQRCKl1x97dPLvkEbl+CJ4bZdsbola+Xpol0KBrWLDGOyMOGj/Rzay2fBPrdhHeRVa1TtcID/xS0OTKHiyBaGhgTLZQ0Ln+dsOpFtAKmr3b3vUjOAIdMrVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836427; c=relaxed/simple;
	bh=F6pWm+RTPVNM7Q44s48VQMSFXUhUQNpQZFAyi5YMh88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOSBfR6Ehh1zHfCOqzuFK5/Uizi80HuD9IJ1NX9gG0ZIP/c5AvGUxsBRP+04IxwvwlOZQkmBH85DUgZ4P7VJqtqgLl2vGfcqZ0/k4y6PjMzu3yRv0F2Pj7yBPW6ynKmIBsw2O0giZkkl1r1oQHMR3douJkEup+LXDaAWizu3sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yx8bhuuO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l1buCSUe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yx8bhuuO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l1buCSUe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8D221FCDC;
	Tue, 13 Feb 2024 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArpPiTfnbkTBU8OZLKbGI4ie43bBKud/SXQgIGfKgxI=;
	b=Yx8bhuuOC18foTA2lcF9p0RUNg+ZfZaof58enHKPcMZHPiBQ6nOg5Jf3/wvDnUZZ6U4s67
	rIsE2VGBZFA62Os+xNRvoj5y+X1Ui42LRTm7Yh7irpsqJLqoqyMAVlVXva7guTIePbPa4w
	JT3audGPU99aERj1Dwnc+VQzCtfuWfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArpPiTfnbkTBU8OZLKbGI4ie43bBKud/SXQgIGfKgxI=;
	b=l1buCSUer1e4eWHzK3fMtI1UaxGPU3+5EVMB9NmeydHTZdt+aiQmOIAb+FmHHqpXc/+fXZ
	Np1X31e5OqX9mPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArpPiTfnbkTBU8OZLKbGI4ie43bBKud/SXQgIGfKgxI=;
	b=Yx8bhuuOC18foTA2lcF9p0RUNg+ZfZaof58enHKPcMZHPiBQ6nOg5Jf3/wvDnUZZ6U4s67
	rIsE2VGBZFA62Os+xNRvoj5y+X1Ui42LRTm7Yh7irpsqJLqoqyMAVlVXva7guTIePbPa4w
	JT3audGPU99aERj1Dwnc+VQzCtfuWfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArpPiTfnbkTBU8OZLKbGI4ie43bBKud/SXQgIGfKgxI=;
	b=l1buCSUer1e4eWHzK3fMtI1UaxGPU3+5EVMB9NmeydHTZdt+aiQmOIAb+FmHHqpXc/+fXZ
	Np1X31e5OqX9mPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E86013404;
	Tue, 13 Feb 2024 15:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wLjtEQeEy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 15:00:23 +0000
Message-ID: <2baca96f-1d97-4a9e-875f-7aa53626e090@suse.de>
Date: Tue, 13 Feb 2024 16:00:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/14] readahead: align index to mapping_min_order in
 ondemand_ra and force_ra
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-6-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Yx8bhuuO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l1buCSUe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,samsung.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: B8D221FCDC
X-Spam-Flag: NO

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Align the ra->start and ra->size to mapping_min_order in
> ondemand_readahead(), and align the index to mapping_min_order in
> force_page_cache_ra(). This will ensure that the folios allocated for
> readahead that are added to the page cache are aligned to
> mapping_min_order.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/readahead.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 4fa7d0e65706..5e1ec7705c78 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -315,6 +315,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
>   	struct file_ra_state *ra = ractl->ra;
>   	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>   	unsigned long max_pages, index;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>   
>   	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
>   		return;
> @@ -324,6 +325,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
>   	 * be up to the optimal hardware IO size
>   	 */
>   	index = readahead_index(ractl);
> +	if (!IS_ALIGNED(index, min_nrpages)) {
> +		unsigned long old_index = index;
> +
> +		index = round_down(index, min_nrpages);
> +		nr_to_read += (old_index - index);
> +	}
> +
>   	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
>   	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
>   	while (nr_to_read) {
> @@ -332,6 +340,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
>   		if (this_chunk > nr_to_read)
>   			this_chunk = nr_to_read;
>   		ractl->_index = index;
> +		VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
>   		do_page_cache_ra(ractl, this_chunk, 0);
>   
>   		index += this_chunk;
> @@ -344,11 +353,20 @@ void force_page_cache_ra(struct readahead_control *ractl,
>    * for small size, x 4 for medium, and x 2 for large
>    * for 128k (32 page) max ra
>    * 1-2 page = 16k, 3-4 page 32k, 5-8 page = 64k, > 8 page = 128k initial
> + *
> + * For higher order address space requirements we ensure no initial reads
> + * are ever less than the min number of pages required.
> + *
> + * We *always* cap the max io size allowed by the device.
>    */
> -static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
> +static unsigned long get_init_ra_size(unsigned long size,
> +				      unsigned int min_nrpages,
> +				      unsigned long max)
>   {
>   	unsigned long newsize = roundup_pow_of_two(size);
>   
> +	newsize = max_t(unsigned long, newsize, min_nrpages);
> +
>   	if (newsize <= max / 32)
>   		newsize = newsize * 4;
>   	else if (newsize <= max / 4)
> @@ -356,6 +374,8 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>   	else
>   		newsize = max;
>   
> +	VM_BUG_ON(newsize & (min_nrpages - 1));
> +
>   	return newsize;
>   }
>   
> @@ -364,14 +384,16 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>    *  return it as the new window size.
>    */
>   static unsigned long get_next_ra_size(struct file_ra_state *ra,
> +				      unsigned int min_nrpages,
>   				      unsigned long max)
>   {
> -	unsigned long cur = ra->size;
> +	unsigned long cur = max(ra->size, min_nrpages);
>   
>   	if (cur < max / 16)
>   		return 4 * cur;
>   	if (cur <= max / 2)
>   		return 2 * cur;
> +
>   	return max;
>   }
>   
> @@ -561,7 +583,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	unsigned long add_pages;
>   	pgoff_t index = readahead_index(ractl);
>   	pgoff_t expected, prev_index;
> -	unsigned int order = folio ? folio_order(folio) : 0;
> +	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(ractl->mapping);
> +	unsigned int order = folio ? folio_order(folio) : min_order;
> +
> +	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
>   
>   	/*
>   	 * If the request exceeds the readahead window, allow the read to
> @@ -583,8 +609,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	expected = round_down(ra->start + ra->size - ra->async_size,
>   			1UL << order);
>   	if (index == expected || index == (ra->start + ra->size)) {
> -		ra->start += ra->size;
> -		ra->size = get_next_ra_size(ra, max_pages);
> +		ra->start += round_down(ra->size, min_nrpages);
> +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
>   		ra->async_size = ra->size;
>   		goto readit;
>   	}
> @@ -603,13 +629,18 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   				max_pages);
>   		rcu_read_unlock();
>   
> +		start = round_down(start, min_nrpages);
> +
> +		VM_BUG_ON(folio->index & (folio_nr_pages(folio) - 1));
> +
>   		if (!start || start - index > max_pages)
>   			return;
>   
>   		ra->start = start;
>   		ra->size = start - index;	/* old async_size */
> +

Stale whitespace.

>   		ra->size += req_size;
> -		ra->size = get_next_ra_size(ra, max_pages);
> +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
>   		ra->async_size = ra->size;
>   		goto readit;
>   	}
> @@ -646,7 +677,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   
>   initial_readahead:
>   	ra->start = index;
> -	ra->size = get_init_ra_size(req_size, max_pages);
> +	ra->size = get_init_ra_size(req_size, min_nrpages, max_pages);
>   	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
>   
>   readit:
> @@ -657,7 +688,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	 * Take care of maximum IO pages as above.
>   	 */
>   	if (index == ra->start && ra->size == ra->async_size) {
> -		add_pages = get_next_ra_size(ra, max_pages);
> +		add_pages = get_next_ra_size(ra, min_nrpages, max_pages);
>   		if (ra->size + add_pages <= max_pages) {
>   			ra->async_size = add_pages;
>   			ra->size += add_pages;
> @@ -668,6 +699,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	}
>   
>   	ractl->_index = ra->start;
> +	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
>   	page_cache_ra_order(ractl, ra, order);
>   }
>   
Otherwise looks good.

Cheers,

Hannes


