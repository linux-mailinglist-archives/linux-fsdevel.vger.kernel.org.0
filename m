Return-Path: <linux-fsdevel+bounces-46210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26FA84683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF773BDFBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EA28C5CD;
	Thu, 10 Apr 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WC/SgvIy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6tUqsvd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JU+hH6VE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2m2WZbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C3202F71
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295919; cv=none; b=pRcK5vhFIzvvYl54Z5ACiR6Ek82EsOHH0YrTwRDiPu4QdxgF09dIXmQPzscQ8PmTZMXRiJ8W1fN/Ib8NKtSwqwQIdzOs8uv7kbUm8Mb7QouBt5xlNnkSA9PmBfDmAfjcBVnIBK28+PFzA6q0YcSLxZkJ0KyRhw7YeUSZJp7LZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295919; c=relaxed/simple;
	bh=GFRHcan0MxZfin3qnUtIo9yeaZkOhpMpmBF2lK/RJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpyHl0R4erzVu+QIkn/jz0hPwfSM6obb/fdXNQyzYeHUYv3Y3+i2piykRavi2dqlPe0e1Q7f/PCZW+OSochp+SN1KLXyAw1LP4XaSCxMZH2VlrVjsVDWi03jPyD9cc2xHOH/UKmOugk/17yEMHZJkCQsPrnd0AALV3OHH2KhOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WC/SgvIy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i6tUqsvd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JU+hH6VE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2m2WZbt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3E5C21164;
	Thu, 10 Apr 2025 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744295916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU5ScoH+7UlhrYAQP6ak2OPq7M4zSmzWu8pSjfnrvkg=;
	b=WC/SgvIyNSeYBd6tKbYkdnCZkVBeEPO0SPZg1HZDQlcxer6rA3ope+Ci52owutHqzddfCg
	OoLq7NE30dZmUeAoQD8KV542krQB9fyuvEyj6a20c6HUbRLHyvzizsCH7Zv60crnn5qZox
	a79fRZdpcH5lT9/hG6d05LkIaBn+mlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744295916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU5ScoH+7UlhrYAQP6ak2OPq7M4zSmzWu8pSjfnrvkg=;
	b=i6tUqsvdtxKiWoZGx11+Evk83U+67+43WjCVvZC7ATyCm82BJ9vGXHxoXoZ/hfTTH+HyYv
	x8ABpFSwajS/tCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744295915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU5ScoH+7UlhrYAQP6ak2OPq7M4zSmzWu8pSjfnrvkg=;
	b=JU+hH6VEzW+1J7sGX6bI6F9ze22i6ENNW/MEb8z1gtKGbVDezZIg4cRflK1Q2dWzil74yv
	7xbyLpLwRht7xfcHWNnAo2FhhtiRwaZp5e7DtV3ZaL3zVtB0ET5gUs5c/8QYG3Eelf+Lda
	f2zoURxsz633GFRzqfiSihnIvdCtddk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744295915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU5ScoH+7UlhrYAQP6ak2OPq7M4zSmzWu8pSjfnrvkg=;
	b=B2m2WZbtJKSCmtj2t6MlfvZdRMenks/oADjKbNb+OFJUWNJeuvBMHJ9U2e5fwLdv8dRWkq
	7Ae56jSV15vrKEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C170113886;
	Thu, 10 Apr 2025 14:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZVEsL+vX92eFfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Apr 2025 14:38:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 316AAA07A7; Thu, 10 Apr 2025 16:38:35 +0200 (CEST)
Date: Thu, 10 Apr 2025 16:38:35 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 2/8] fs/buffer: try to use folio lock for pagecache
 lookups
Message-ID: <plt72kbiee2sz32mqslvhmmlny6dqfeccnf2d325cus45qpo3t@m6t563ijkvr5>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410014945.2140781-3-mcgrof@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 09-04-25 18:49:39, Luis Chamberlain wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Callers of __find_get_block() may or may not allow for blocking
> semantics, and is currently assumed that it will not. Layout
> two paths based on this. Ultimately the i_private_lock scheme will
> be used as a fallback in non-blocking contexts. Otherwise
> always take the folio lock instead. The suggested trylock idea
> is implemented, thereby potentially reducing i_private_lock
> contention in addition to later enabling future migration support
> around with large folios and noref migration.
> 
> No change in semantics. All lookup users are non-blocking.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

...

> @@ -204,7 +195,19 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  	if (IS_ERR(folio))
>  		goto out;
>  
> -	spin_lock(&bd_mapping->i_private_lock);
> +	/*
> +	 * Folio lock protects the buffers. Callers that cannot block
> +	 * will fallback to serializing vs try_to_free_buffers() via
> +	 * the i_private_lock.
> +	 */
> +	if (!folio_trylock(folio)) {
> +		if (atomic) {
> +			spin_lock(&bd_mapping->i_private_lock);
> +			folio_locked = false;
> +		} else
> +			folio_lock(folio);
> +	}

Ewww, this is going to be pain. You will mostly use the folio_trylock() for
protecting the lookup, except when some insane workload / fuzzer manages to
trigger the other path which will lead to completely unreproducible bugs...
I'd rather do:

	if (atomic) {
		spin_lock(&bd_mapping->i_private_lock);
		folio_locked = false;
	} else {
		folio_lock(folio);
	}

I'd actually love to do something like:

	if (atomic) {
		if (!folio_trylock(folio))
			bail...
	} else {
		folio_lock(folio);
	}

but that may be just too radical this point and would need some serious
testing how frequent the trylock failures are. No point in blocking this
series with it. So just go with the deterministic use of i_private_lock for
atomic users for now.

								Honza

> +
>  	head = folio_buffers(folio);
>  	if (!head)
>  		goto out_unlock;
> @@ -236,7 +239,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  		       1 << blkbits);
>  	}
>  out_unlock:
> -	spin_unlock(&bd_mapping->i_private_lock);
> +	if (folio_locked)
> +		folio_unlock(folio);
> +	else
> +		spin_unlock(&bd_mapping->i_private_lock);
>  	folio_put(folio);
>  out:
>  	return ret;
> @@ -1388,14 +1394,15 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>   * it in the LRU and mark it as accessed.  If it is not present then return
>   * NULL
>   */
> -struct buffer_head *
> -__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> +static struct buffer_head *
> +find_get_block_common(struct block_device *bdev, sector_t block,
> +			unsigned size, bool atomic)
>  {
>  	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
>  
>  	if (bh == NULL) {
>  		/* __find_get_block_slow will mark the page accessed */
> -		bh = __find_get_block_slow(bdev, block);
> +		bh = __find_get_block_slow(bdev, block, atomic);
>  		if (bh)
>  			bh_lru_install(bh);
>  	} else
> @@ -1403,6 +1410,12 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
>  
>  	return bh;
>  }
> +
> +struct buffer_head *
> +__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> +{
> +	return find_get_block_common(bdev, block, size, true);
> +}
>  EXPORT_SYMBOL(__find_get_block);
>  
>  /**
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

