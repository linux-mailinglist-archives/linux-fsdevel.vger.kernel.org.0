Return-Path: <linux-fsdevel+bounces-11359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAD85306C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0092CB23C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7B42076;
	Tue, 13 Feb 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IzzOuWLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0SgjdETk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1vKe97ng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q/cSS8Vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4473A1D9;
	Tue, 13 Feb 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826854; cv=none; b=HTke6XWOkLqh/4ZGqYf8kug6K2SvVpxXv4UI+u7lPLdSYXnDd5CIPpEr6ALYfI6s0XWVv5QedLisazygrtrPy5lVocRjBN6Ptp59Kx/R6Bf51TD8qtqpERygUnsJavrXxerWGY8aSYkshTbGNgTLxDFIReRVHT856rV2Ym81RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826854; c=relaxed/simple;
	bh=HGeSUbH20H5u8KR22Rjn11xuDbNLM9XCx278xQ/uqQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5MUpCkOj2QBMyhsP4ZYC+bLyMh5PooeuVNXnoVUpFU7+tS0WuS4ddiE1FeO72pFqlkOoYXMj91Z1MxD1WDhK7eHWFObI8694rcga5pyFjxASGEpnPKlTxhH1gdM8+6SACQmXUKljhTsB0WtBrV9Tdv03A2qHNPC6uv7Jw8smxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IzzOuWLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0SgjdETk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1vKe97ng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q/cSS8Vb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF6AC21FEB;
	Tue, 13 Feb 2024 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0U/gj1IRFxhh4wCzcId+uJVmK6EIS7v2JGMcpz+WUE=;
	b=IzzOuWLpi+MJGssDb+e4PKvMiPOtRIphb6Mc/4K5yV8iaENtK5kM+DLk4vTT+N6PzmvrFv
	v074P/7sT7x34wkuI2sDX0w45LYFC261+D5QK3yGH4uXw5DjM2cUEEsz6nkTLTSEx6YL4f
	HdccHqJDWJ/0olxtsgCqpvV2KN6xn8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0U/gj1IRFxhh4wCzcId+uJVmK6EIS7v2JGMcpz+WUE=;
	b=0SgjdETkh4AegWI/LgkWHeT8s7QOqYLfLMciIZr94TSi0IfPk6hef+PE111DdNO4Yk3BYm
	rYVsjD6rhetPRTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0U/gj1IRFxhh4wCzcId+uJVmK6EIS7v2JGMcpz+WUE=;
	b=1vKe97ngXgeKYrqZm8h4h8dCcBkENYItl1Fj7PH7YG/AUYDn6uYn5OQJn8kpjwDuzJGXpd
	Ycpf5C/D5/CmhWYZraxC0a546nnXcxOeD8zh1aKRg0O6baPFolste5J2YWZIphyCpjzasc
	DdHfLk2wczx/7L7PTv3E+hz7KLqX4N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0U/gj1IRFxhh4wCzcId+uJVmK6EIS7v2JGMcpz+WUE=;
	b=q/cSS8VbW/p6pawJ4xQDhshj4zQ+W/tJGCFkWvz20UQWURwsz3xlqPhS/6QTrZt90knQJb
	GMxLHeg0wbDD8MBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A21431370C;
	Tue, 13 Feb 2024 12:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f9brJqJey2WSBwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 12:20:50 +0000
Message-ID: <487c0bec-4229-4add-bec4-1711f0b9bbee@suse.de>
Date: Tue, 13 Feb 2024 13:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/14] filemap: align the index to mapping_min_order in
 the page cache
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-3-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.09

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. So when adding new
> folios to the page cache we must ensure the index used is aligned to the
> mapping_min_order as the page cache requires the index to be aligned to
> the order of the folio.
> 
> A higher order folio than min_order by definition is a multiple of the
> min_order. If an index is aligned to an order higher than a min_order, it
> will also be aligned to the min order.
> 
> This effectively introduces no new functional changes when min order is
> not set other than a few rounding computations that should result in the
> same value.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/filemap.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db..323a8e169581 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2479,14 +2479,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>   {
>   	struct file *filp = iocb->ki_filp;
>   	struct address_space *mapping = filp->f_mapping;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>   	struct file_ra_state *ra = &filp->f_ra;
> -	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
> +	pgoff_t index = round_down(iocb->ki_pos >> PAGE_SHIFT, min_nrpages);
>   	pgoff_t last_index;
>   	struct folio *folio;
>   	int err = 0;
>   
>   	/* "last_index" is the index of the page beyond the end of the read */
>   	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	last_index = round_up(last_index, min_nrpages);

Huh? 'last_index' is unset here; sure you mean 'iocb->ki_pos + count' ?

And what's the rationale to replace 'DIV_ROUND_UP' with 'round_up' ?

>   retry:
>   	if (fatal_signal_pending(current))
>   		return -EINTR;
> @@ -2502,8 +2504,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>   	if (!folio_batch_count(fbatch)) {
>   		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>   			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, index, fbatch);
>   		if (err == AOP_TRUNCATED_PAGE)
>   			goto retry;
>   		return err;
> @@ -3095,7 +3096,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	struct file *file = vmf->vma->vm_file;
>   	struct file_ra_state *ra = &file->f_ra;
>   	struct address_space *mapping = file->f_mapping;
> -	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);
> +	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
> +	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
>   	struct file *fpin = NULL;
>   	unsigned long vm_flags = vmf->vma->vm_flags;
>   	unsigned int mmap_miss;
> @@ -3147,10 +3151,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	 */
>   	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>   	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +	ra->start = round_down(ra->start, min_nrpages);
>   	ra->size = ra->ra_pages;
>   	ra->async_size = ra->ra_pages / 4;
>   	ractl._index = ra->start;
> -	page_cache_ra_order(&ractl, ra, 0);
> +	page_cache_ra_order(&ractl, ra, min_order);
>   	return fpin;
>   }
>   
> @@ -3164,7 +3169,9 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>   {
>   	struct file *file = vmf->vma->vm_file;
>   	struct file_ra_state *ra = &file->f_ra;
> -	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);
> +	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
> +	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
>   	struct file *fpin = NULL;
>   	unsigned int mmap_miss;
>   
> @@ -3212,13 +3219,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>   	struct file *file = vmf->vma->vm_file;
>   	struct file *fpin = NULL;
>   	struct address_space *mapping = file->f_mapping;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int nrpages = 1UL << min_order;
>   	struct inode *inode = mapping->host;
> -	pgoff_t max_idx, index = vmf->pgoff;
> +	pgoff_t max_idx, index = round_down(vmf->pgoff, nrpages);
>   	struct folio *folio;
>   	vm_fault_t ret = 0;
>   	bool mapping_locked = false;
>   
>   	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	max_idx = round_up(max_idx, nrpages);
> +

Same here.
(And the additional whitespace can probably go ...)

>   	if (unlikely(index >= max_idx))
>   		return VM_FAULT_SIGBUS;
>   
> @@ -3317,13 +3328,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>   	 * We must recheck i_size under page lock.
>   	 */
>   	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	max_idx = round_up(max_idx, nrpages);
> +

See above.

>   	if (unlikely(index >= max_idx)) {
>   		folio_unlock(folio);
>   		folio_put(folio);
>   		return VM_FAULT_SIGBUS;
>   	}
>   
> -	vmf->page = folio_file_page(folio, index);
> +	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
> +
> +	vmf->page = folio_file_page(folio, vmf->pgoff);
>   	return ret | VM_FAULT_LOCKED;
>   
>   page_not_uptodate:
> @@ -3658,6 +3673,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>   {
>   	struct folio *folio;
>   	int err;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +
> +	index = round_down(index, min_nrpages);
>   
>   	if (!filler)
>   		filler = mapping->a_ops->read_folio;

Cheers,

Hannes


