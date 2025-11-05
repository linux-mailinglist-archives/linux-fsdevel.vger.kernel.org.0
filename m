Return-Path: <linux-fsdevel+bounces-67147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3DC36522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B770623B57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE033EAFD;
	Wed,  5 Nov 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOPg+LHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fBDLO1F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOPg+LHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fBDLO1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAE33E353
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355553; cv=none; b=jyscpkC1FGn6jRQT6bKpPRfBvzPTvfvph20SYN1aL3dzrZsf7D4Zw6122d2wDVbMvo2izZa3hIfSX0HfDkb8/L2aXMkcbHVyKWXfgb23b+FKpsAGWvdwKTVUGytpXJy9a88ldJmiyH+DCsDBBhH40FXJH38zdZ4IenHmyRodifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355553; c=relaxed/simple;
	bh=EjlKUtNHqDKQw/INUf1si5y4KGCdguruY4CNlDjBZBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnqE8G1Gx2ehOHf5g4n2tL6Ob9avuOd7SuCby2PeEwD5h+ST8kS7nk5etJNlbt2DL5zgsDed16qN5UkbktRbwryJNtRGWAFxjhXz14SID2uMu9KCEYIMXX+Vn0F5EY3r4AUAiekMey8DwPgRYJB86ZfSaJYy+97YcyB/6ioOu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOPg+LHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fBDLO1F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOPg+LHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fBDLO1F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D37AE1F393;
	Wed,  5 Nov 2025 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762355549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwBH7iM0sPxUEaHRpT+jUi+gGcVAjv29IOeKwGDaXZs=;
	b=vOPg+LHG7W8Yk1HS6Dsqqv3MuWG2XGmqog16SM/nz7u6dEMJPe3i9AhFhwP/WfJVXmvQcV
	QWH4iMuF1SSTkpoQe/WLl/HtHn4D7b3y2PCeNYRSq3zsRKURpLzDnArWbzFfZtLKKvzbKk
	QuWyoiheskgZBExMQm9+VQqcZ4b5XfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762355549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwBH7iM0sPxUEaHRpT+jUi+gGcVAjv29IOeKwGDaXZs=;
	b=3fBDLO1F7aXeoa1qyCsw7hVXRdwyz8+2qPyK704dPWdvmcYFcrqpQGEUIV0fpFTM3pjpyw
	BPMYDGJJBtmN/qBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762355549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwBH7iM0sPxUEaHRpT+jUi+gGcVAjv29IOeKwGDaXZs=;
	b=vOPg+LHG7W8Yk1HS6Dsqqv3MuWG2XGmqog16SM/nz7u6dEMJPe3i9AhFhwP/WfJVXmvQcV
	QWH4iMuF1SSTkpoQe/WLl/HtHn4D7b3y2PCeNYRSq3zsRKURpLzDnArWbzFfZtLKKvzbKk
	QuWyoiheskgZBExMQm9+VQqcZ4b5XfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762355549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwBH7iM0sPxUEaHRpT+jUi+gGcVAjv29IOeKwGDaXZs=;
	b=3fBDLO1F7aXeoa1qyCsw7hVXRdwyz8+2qPyK704dPWdvmcYFcrqpQGEUIV0fpFTM3pjpyw
	BPMYDGJJBtmN/qBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B30C1132DD;
	Wed,  5 Nov 2025 15:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mI/pKV1pC2lFeQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 15:12:29 +0000
Message-ID: <39f2d0d3-de79-4e13-a577-83a3aeb5cf1b@suse.cz>
Date: Wed, 5 Nov 2025 16:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] blk-crypto: use mempool_alloc_bulk for encrypted bio
 page allocation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-mm@kvack.org
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-10-hch@lst.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251031093517.1603379-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/31/25 10:34, Christoph Hellwig wrote:
> @@ -192,6 +205,29 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
>  	bio->bi_write_stream	= bio_src->bi_write_stream;
>  	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
>  	bio_clone_blkg_association(bio, bio_src);
> +
> +	/*
> +	 * Move page array up in the allocated memory for the bio vecs as far as
> +	 * possible so that we can start filling biovecs from the beginning
> +	 * without overwriting the temporary page array.
> +	 */
> +	static_assert(PAGE_PTRS_PER_BVEC > 1);
> +	pages = (struct page **)bio->bi_io_vec;
> +	pages += nr_segs * (PAGE_PTRS_PER_BVEC - 1);
> +
> +	/*
> +	 * Try a bulk allocation first.  This could leave random pages in the
> +	 * array unallocated, but we'll fix that up later in mempool_alloc_bulk.
> +	 *
> +	 * Note: alloc_pages_bulk needs the array to be zeroed, as it assumes
> +	 * any non-zero slot already contains a valid allocation.
> +	 */
> +	memset(pages, 0, sizeof(struct page *) * nr_segs);
> +	if (alloc_pages_bulk(GFP_NOFS, nr_segs, pages) < nr_segs) {
> +		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
> +				nr_segs, GFP_NOIO);

Why do the GFP flags differ?

> +	}
> +	*pages_ret = pages;
>  	return bio;
>  }
>  
> @@ -234,6 +270,7 @@ static blk_status_t __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  	struct scatterlist src, dst;
>  	union blk_crypto_iv iv;
>  	struct bio *enc_bio = NULL;
> +	struct page **enc_pages;
>  	unsigned int nr_segs;
>  	unsigned int enc_idx = 0;
>  	unsigned int j;
> @@ -259,11 +296,10 @@ static blk_status_t __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  
>  		if (!enc_bio) {
>  			enc_bio = blk_crypto_alloc_enc_bio(src_bio,
> -					min(nr_segs, BIO_MAX_VECS));
> +					min(nr_segs, BIO_MAX_VECS), &enc_pages);
>  		}
>  
> -		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
> -				GFP_NOIO);
> +		enc_page = enc_pages[enc_idx];
>  		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
>  				src_bv.bv_offset);
>  


