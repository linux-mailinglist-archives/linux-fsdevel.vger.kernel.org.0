Return-Path: <linux-fsdevel+bounces-65060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB3BFA785
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78465657B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC22F5A36;
	Wed, 22 Oct 2025 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tQQAHmKk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z+t7udLx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cCOmOphU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="je/MybQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193D2F28E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116938; cv=none; b=K+6oS9cspmVndkmok7LqF1UNumNbpJXFS4y6KKvAM5mjt8jZK9fJ+Ede8e7DuKLHAc/0dIgi5jX+zLLFImUGTCXey3Lc34Zi/cQxJiFngQdTbNqYK27hnEt6XbjZHrBfJD6IbAralD4cCw3vhRot+sGuORmjmZiab2sHIbBk38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116938; c=relaxed/simple;
	bh=qe4z/LoLoycxB0TzIKylzsq3GuCWi1pax/9SGUwJcTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qofo/2J2CH63nTw/LHS/CbyrU1AkswFORKa/uNkQPDEuan+OmxObPRMdaQRCX6GRhANgDcoD/3xU1KnJOJNjM7blZsYm6JTWja+QvrUEHZiQ//xDMwpKr2V8NPb+Rq3uCglXzhwr85LxsL2kh60UXA03jcAPm0VZ3hUSBe7cfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tQQAHmKk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z+t7udLx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cCOmOphU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=je/MybQn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD4A11F38D;
	Wed, 22 Oct 2025 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqzOTcD6BeiMm0m3Qik1jWulQ22mecGBwnXl3IAyTY=;
	b=tQQAHmKkibpPDnyQgtlMZSpkOn0Wz/I7jjvBFmJ1qvbuwBsSG0bA9PF2p3G+1sn6u6ia24
	hoUy1YP3YoujGOMGP4IutV4Uyg/NbJoQYxFlSlgsQYdZdxwwa74r5xd8a2/QrycOarWv/o
	qYotXMZKxHCPNUUvlP1Hc1kOd1fMoL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqzOTcD6BeiMm0m3Qik1jWulQ22mecGBwnXl3IAyTY=;
	b=z+t7udLxKXENOYjuxaH7Jcb+kZuZMce0iuT2MA9UdsN3bWkDOc+XG5ndDikyJk0o5Gfekv
	3MQLjlYRZ2O6DyBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761116925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqzOTcD6BeiMm0m3Qik1jWulQ22mecGBwnXl3IAyTY=;
	b=cCOmOphUpqowelBvduOESBfAfveCRIu/36sTR7fYXJ2SFhx7BL2S8zVSdtb/9WhYFDajly
	mSl4RgSwmlo+INNAjRAabISO12kXXdDuraakTs+OaNwvP3n61f6SQf3dnx0FUi61/+uCGl
	REolJSuqpwdcd3tBghZ8ao1sTFwNIWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761116925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqzOTcD6BeiMm0m3Qik1jWulQ22mecGBwnXl3IAyTY=;
	b=je/MybQn3PHBim9ffU5JgGUHSwMYAjfNS7uirlQ8S7PQ57MsfShgooOxVdE8ZNMYzOrzId
	zN/00VF0MkMeMlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3C401339F;
	Wed, 22 Oct 2025 07:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M23uL/yC+GhCAQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 22 Oct 2025 07:08:44 +0000
Date: Wed, 22 Oct 2025 08:08:42 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
References: <20251017141536.577466-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri, Oct 17, 2025 at 03:15:36PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The protocol for page cache lookup is as follows:
> 
>   1. Locate a folio in XArray.
>   2. Obtain a reference on the folio using folio_try_get().
>   3. If successful, verify that the folio still belongs to
>      the mapping and has not been truncated or reclaimed.
>   4. Perform operations on the folio, such as copying data
>      to userspace.
>   5. Release the reference.
> 
> For short reads, the overhead of atomic operations on reference
> manipulation can be significant, particularly when multiple tasks access
> the same folio, leading to cache line bouncing.
> 
> <snip>
>+static inline unsigned long filemap_read_fast_rcu(struct address_space *mapping,
> +						  loff_t pos, char *buffer,
> +						  size_t size)
> +{
> +	XA_STATE(xas, &mapping->i_pages, pos >> PAGE_SHIFT);
> +	struct folio *folio;
> +	loff_t file_size;
> +	unsigned int seq;
> +
> +	lockdep_assert_in_rcu_read_lock();
> +
> +	/* Give up and go to slow path if raced with page_cache_delete() */
> +	if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt, seq))
> +		return false;
> +
> +	folio = xas_load(&xas);
> +	if (xas_retry(&xas, folio))
> +		return 0;
> +
> +	if (!folio || xa_is_value(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio))
> +		return 0;
> +
> +	/* No fast-case if readahead is supposed to started */
> +	if (folio_test_readahead(folio))
> +		return 0;
> +	/* .. or mark it accessed */
> +	if (!folio_test_referenced(folio))
> +		return 0;
> +
> +	/* i_size check must be after folio_test_uptodate() */
> +	file_size = i_size_read(mapping->host);
> +	if (unlikely(pos >= file_size))
> +		return 0;
> +	if (size > file_size - pos)
> +		size = file_size - pos;
> +
> +	/* Do the data copy */
> +	size = memcpy_from_file_folio(buffer, folio, pos, size);
> +	if (!size)
> +		return 0;
> +

I think we may still have a problematic (rare, possibly theoretical) race here where:

   T0				  		T1						T3
filemap_read_fast_rcu()    |							|
  folio = xas_load(&xas);  |							|
  /* ... */                |  /* truncate or reclaim frees folio, bumps delete	|
                           |     seq */						|  	folio_alloc() from e.g secretmem
  			   |							|	set_direct_map_invalid_noflush(!!)
memcpy_from_file_folio()   |							|

We may have to use copy_from_kernel_nofault() here? Or is something else stopping this from happening?

-- 
Pedro

