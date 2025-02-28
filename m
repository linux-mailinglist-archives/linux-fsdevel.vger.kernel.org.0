Return-Path: <linux-fsdevel+bounces-42856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC3A49BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D7B173FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC326E63D;
	Fri, 28 Feb 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYAKBT+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4GvZ/zPh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYAKBT+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4GvZ/zPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E582620C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752236; cv=none; b=AtDk+K9NG2Au3fXERXGAiTBe0qAydEtmoNDknzw/fMSOK/ZiIHvgUrSL/QHxYLLkTMe4Mu5/jLpjc8aVtrdxyFLnIq+qeDGsKzmScEPKbsk3oAyRI+5PeenXP7hw3qaISMNzylwTYm0UkYFZLTPrTxgPNpG95BmGfwu5TS6uBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752236; c=relaxed/simple;
	bh=F8zm6YQaiTa2XSTUkduNae4RXOCv5ivV4wzwzDD4rUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyZqZc3FhiyXbDPx3naOnHoZHJtcgdkcUx0WeiPxSq0T+yj0E26KkbqAGJ8DSn5CqbhUPE3+9nwj8bHgU6w0/fcB1UQRleDe1i3QTILOXK8N0HlswTx/Vd3K+a33Rfrb+rx3BDDlCKuoP/cpYbuOW6QkLkVcnCcHFcEpyGRMaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYAKBT+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4GvZ/zPh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYAKBT+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4GvZ/zPh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD1A21F37E;
	Fri, 28 Feb 2025 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hIseiRro5ZDlr43rKJfqqqfDFAsRrvZFt1JC6oL9YnE=;
	b=LYAKBT+gywT+qOSiQz8ecqjdOm74+q98gaYP+YDKnR/F87TfZ49MUFJCNNaCOcWKbmgQLS
	WT4Is2KV6rpun1S5H7p1LknkSJMhoBqEGr1nrDGqP/ECkfZ7DWHQ1sXauPaq50BhqIO5Us
	BRaoMBbN8QL0GNoficVjRfl/n42qetI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hIseiRro5ZDlr43rKJfqqqfDFAsRrvZFt1JC6oL9YnE=;
	b=4GvZ/zPhVrNKc8AKw7Z3I51uT11w12XQImbuBKgAD8dbx0C4zOwPocieku2c1mKwRj+N2H
	3nfHK40ttQG74GAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LYAKBT+g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4GvZ/zPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hIseiRro5ZDlr43rKJfqqqfDFAsRrvZFt1JC6oL9YnE=;
	b=LYAKBT+gywT+qOSiQz8ecqjdOm74+q98gaYP+YDKnR/F87TfZ49MUFJCNNaCOcWKbmgQLS
	WT4Is2KV6rpun1S5H7p1LknkSJMhoBqEGr1nrDGqP/ECkfZ7DWHQ1sXauPaq50BhqIO5Us
	BRaoMBbN8QL0GNoficVjRfl/n42qetI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hIseiRro5ZDlr43rKJfqqqfDFAsRrvZFt1JC6oL9YnE=;
	b=4GvZ/zPhVrNKc8AKw7Z3I51uT11w12XQImbuBKgAD8dbx0C4zOwPocieku2c1mKwRj+N2H
	3nfHK40ttQG74GAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E45C137AC;
	Fri, 28 Feb 2025 14:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtGOIGfFwWerMQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 14:17:11 +0000
Message-ID: <503c4ba7-c667-444a-b396-e85c46469f0a@suse.cz>
Date: Fri, 28 Feb 2025 15:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] mm/filemap: add mempolicy support to the filemap
 layer
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, david@redhat.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, tabba@google.com
References: <20250226082549.6034-1-shivankg@amd.com>
 <20250226082549.6034-2-shivankg@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250226082549.6034-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD1A21F37E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/26/25 09:25, Shivank Garg wrote:
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> Add NUMA mempolicy support to the filemap allocation path by introducing
> new APIs that take a mempolicy argument:
> - filemap_grab_folio_mpol()
> - filemap_alloc_folio_mpol()
> - __filemap_get_folio_mpol()
> 
> These APIs allow callers to specify a NUMA policy during page cache
> allocations, enabling fine-grained control over memory placement. This is
> particularly needed by KVM when using guest-memfd memory backends, where
> the guest memory needs to be allocated according to the NUMA policy
> specified by VMM.
> 
> The existing non-mempolicy APIs remain unchanged and continue to use the
> default allocation behavior.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

<snip>

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1001,11 +1001,17 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>  
>  #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
> +		struct mempolicy *mpol)
>  {
>  	int n;
>  	struct folio *folio;
>  
> +	if (mpol)
> +		return folio_alloc_mpol_noprof(gfp, order, mpol,
> +					       NO_INTERLEAVE_INDEX,
> +					       numa_node_id());
> +
>  	if (cpuset_do_page_mem_spread()) {
>  		unsigned int cpuset_mems_cookie;
>  		do {
> @@ -1018,6 +1024,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>  	}
>  	return folio_alloc_noprof(gfp, order);
>  }
> +EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
> +
> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +{
> +	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
> +}
>  EXPORT_SYMBOL(filemap_alloc_folio_noprof);
>  #endif

Here it seems to me:

- filemap_alloc_folio_noprof() could stay unchanged
- filemap_alloc_folio_mpol_noprof() would
  - call folio_alloc_mpol_noprof() if (mpol)
  - call filemap_alloc_folio_noprof() otherwise

The code would be a bit more clearly structured that way?

> @@ -1881,11 +1893,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>  }
>  
>  /**
> - * __filemap_get_folio - Find and get a reference to a folio.
> + * __filemap_get_folio_mpol - Find and get a reference to a folio.
>   * @mapping: The address_space to search.
>   * @index: The page index.
>   * @fgp_flags: %FGP flags modify how the folio is returned.
>   * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
> + * @mpol: The mempolicy to apply when allocating a new folio.
>   *
>   * Looks up the page cache entry at @mapping & @index.
>   *
> @@ -1896,8 +1909,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>   *
>   * Return: The found folio or an ERR_PTR() otherwise.
>   */
> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		fgf_t fgp_flags, gfp_t gfp)
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
> +		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
>  {
>  	struct folio *folio;
>  
> @@ -1967,7 +1980,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			err = -ENOMEM;
>  			if (order > min_order)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order);
> +			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
>  			if (!folio)
>  				continue;
>  
> @@ -2003,6 +2016,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_clear_dropbehind(folio);
>  	return folio;
>  }
> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
> +
> +struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> +		fgf_t fgp_flags, gfp_t gfp)
> +{
> +	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL);
> +}
>  EXPORT_SYMBOL(__filemap_get_folio);
>  
>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,


