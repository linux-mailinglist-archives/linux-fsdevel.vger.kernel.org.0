Return-Path: <linux-fsdevel+bounces-48043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AEAA9093
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FD91890774
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA91FDE09;
	Mon,  5 May 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CFY+Bo+D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyrGr7IM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CFY+Bo+D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyrGr7IM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A871F3FC3
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439610; cv=none; b=et7/kWsoFQnLt9nLiRRughYlhSMaHmpuvmGjk4a/Scc4/gpT+vVIMGuw7nwkis5IiFn+6zvhIT3MM6VYiQ54MaVv5LX9yMliN6W1QxPizWF9xT7T9RuYgNWyuYVp+G84A7zT96CHkUxVK2iztbHm7gcZ7LQTsARukYJtU6axQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439610; c=relaxed/simple;
	bh=nlKuLgwyphuIzI6gkbuywQ4Yc9EOdbzVgtg7McxUqKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCi8HtoS+GWbEjtiBu+eZiPxJrTjncTGfaiFWVnoQ38nyWrj1cJiuFjFtbSv1Odw8Cg1qw6fkHPGmVCOHcvVOZkPCf4wk0bFvr0tLf1F9k+31iWG/xHJEkP3STES7h1UxJszpDcxoiaJEe2nqb3GCLuPX+a2O5rQUvOmB7BozUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CFY+Bo+D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyrGr7IM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CFY+Bo+D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyrGr7IM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A616421282;
	Mon,  5 May 2025 10:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746439606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uHrYEe/BCPIKsghK9cJ2gEqy5Nqd9eQ4C+mGF/QN4A=;
	b=CFY+Bo+DtYwUuRgBGl5AmLhRSuPGKPQIAQynukOPOCqzVtgYDAeQ4gsGHvWB40vrQLZ1zS
	joSg0B0ocmFM0tyX8U1z6G8YuN2iuO5RqPn4OkxGMEtzpTGFrp83K5mKDPCS9w3OLyFkIV
	OokPgUlPg9wkcdAbSF+agNyYk1v1aNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746439606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uHrYEe/BCPIKsghK9cJ2gEqy5Nqd9eQ4C+mGF/QN4A=;
	b=NyrGr7IMNGQ01PenLUsQ9R4tyXomoJxqrWT7MBSfOe2jqiijjmBvmsTisSeLYQYmw4WEr7
	UX+/PSAfcFLja/DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CFY+Bo+D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NyrGr7IM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746439606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uHrYEe/BCPIKsghK9cJ2gEqy5Nqd9eQ4C+mGF/QN4A=;
	b=CFY+Bo+DtYwUuRgBGl5AmLhRSuPGKPQIAQynukOPOCqzVtgYDAeQ4gsGHvWB40vrQLZ1zS
	joSg0B0ocmFM0tyX8U1z6G8YuN2iuO5RqPn4OkxGMEtzpTGFrp83K5mKDPCS9w3OLyFkIV
	OokPgUlPg9wkcdAbSF+agNyYk1v1aNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746439606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uHrYEe/BCPIKsghK9cJ2gEqy5Nqd9eQ4C+mGF/QN4A=;
	b=NyrGr7IMNGQ01PenLUsQ9R4tyXomoJxqrWT7MBSfOe2jqiijjmBvmsTisSeLYQYmw4WEr7
	UX+/PSAfcFLja/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92F1713883;
	Mon,  5 May 2025 10:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YyWGI7aNGGi4dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 10:06:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F95DA0670; Mon,  5 May 2025 12:06:46 +0200 (CEST)
Date: Mon, 5 May 2025 12:06:46 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 5/5] mm/filemap: Allow arch to request folio size
 for exec memory
Message-ID: <b2xibk62rakzb3ln7i4evdtqrkd75xboj5y4vfqf2fyt3y7g5a@5x7qqsjpanxd>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-6-ryan.roberts@arm.com>
X-Rspamd-Queue-Id: A616421282
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 30-04-25 15:59:18, Ryan Roberts wrote:
> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read into a set of folios with an
> arch-specified order and in a naturally aligned manner. We no longer
> center the read on the faulting page but simply align it down to the
> previous natural boundary. Additionally, we don't bother with an
> asynchronous part.
> 
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" feature, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low likelihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
> 
> The reason for the low likelihood is that the current readahead
> algorithm starts with an order-0 folio and increases the folio order by
> 2 every time the readahead mark is hit. But most executable memory tends
> to be accessed randomly and so the readahead mark is rarely hit and most
> executable folios remain order-0.
> 
> So let's special-case the read(ahead) logic for executable mappings. The
> trade-off is performance improvement (due to more efficient storage of
> the translations in iTLB) vs potential for making reclaim more difficult
> (due to the folios being larger so if a part of the folio is hot the
> whole thing is considered hot). But executable memory is a small portion
> of the overall system memory so I doubt this will even register from a
> reclaim perspective.
> 
> I've chosen 64K folio size for arm64 which benefits both the 4K and 16K
> base page size configs. Crucially the same amount of data is still read
> (usually 128K) so I'm not expecting any read amplification issues. I
> don't anticipate any write amplification because text is always RO.
> 
> Note that the text region of an ELF file could be populated into the
> page cache for other reasons than taking a fault in a mmapped area. The
> most common case is due to the loader read()ing the header which can be
> shared with the beginning of text. So some text will still remain in
> small folios, but this simple, best effort change provides good
> performance improvements as is.
> 
> Confine this special-case approach to the bounds of the VMA. This
> prevents wasting memory for any padding that might exist in the file
> between sections. Previously the padding would have been contained in
> order-0 folios and would be easy to reclaim. But now it would be part of
> a larger folio so more difficult to reclaim. Solve this by simply not
> reading it into memory in the first place.
> 
> Benchmarking
> ============
> TODO: NUMBERS ARE FOR V3 OF SERIES. NEED TO RERUN FOR THIS VERSION.
> 
> The below shows nginx and redis benchmarks on Ampere Altra arm64 system.
> 
> First, confirmation that this patch causes more text to be contained in
> 64K folios:
> 
> | File-backed folios     |   system boot   |      nginx      |      redis      |
> | by size as percentage  |-----------------|-----------------|-----------------|
> | of all mapped text mem | before |  after | before |  after | before |  after |
> |========================|========|========|========|========|========|========|
> | base-page-4kB          |    26% |     9% |    27% |     6% |    21% |     5% |
> | thp-aligned-8kB        |     4% |     2% |     3% |     0% |     4% |     1% |
> | thp-aligned-16kB       |    57% |    21% |    57% |     6% |    54% |    10% |
> | thp-aligned-32kB       |     4% |     1% |     4% |     1% |     3% |     1% |
> | thp-aligned-64kB       |     7% |    65% |     8% |    85% |     9% |    72% |
> | thp-aligned-2048kB     |     0% |     0% |     0% |     0% |     7% |     8% |
> | thp-unaligned-16kB     |     1% |     1% |     1% |     1% |     1% |     1% |
> | thp-unaligned-32kB     |     0% |     0% |     0% |     0% |     0% |     0% |
> | thp-unaligned-64kB     |     0% |     0% |     0% |     1% |     0% |     1% |
> | thp-partial            |     1% |     1% |     0% |     0% |     1% |     1% |
> |------------------------|--------|--------|--------|--------|--------|--------|
> | cont-aligned-64kB      |     7% |    65% |     8% |    85% |    16% |    80% |
> 
> The above shows that for both workloads (each isolated with cgroups) as
> well as the general system state after boot, the amount of text backed
> by 4K and 16K folios reduces and the amount backed by 64K folios
> increases significantly. And the amount of text that is contpte-mapped
> significantly increases (see last row).
> 
> And this is reflected in performance improvement:
> 
> | Benchmark                                     |          Improvement |
> +===============================================+======================+
> | pts/nginx (200 connections)                   |                8.96% |
> | pts/nginx (1000 connections)                  |                6.80% |
> +-----------------------------------------------+----------------------+
> | pts/redis (LPOP, 50 connections)              |                5.07% |
> | pts/redis (LPUSH, 50 connections)             |                3.68% |
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/mm/filemap.c b/mm/filemap.c
> index e61f374068d4..37fe4a55c00d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3252,14 +3252,40 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
> -	/*
> -	 * mmap read-around
> -	 */
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -	ra->size = ra->ra_pages;
> -	ra->async_size = ra->ra_pages / 4;
> -	ra->order = 0;
> +	if (vm_flags & VM_EXEC) {
> +		/*
> +		 * Allow arch to request a preferred minimum folio order for
> +		 * executable memory. This can often be beneficial to
> +		 * performance if (e.g.) arm64 can contpte-map the folio.
> +		 * Executable memory rarely benefits from readahead, due to its
> +		 * random access nature, so set async_size to 0.
> +		 *
> +		 * Limit to the boundaries of the VMA to avoid reading in any
> +		 * pad that might exist between sections, which would be a waste
> +		 * of memory.
> +		 */
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long start = vma->vm_pgoff;
> +		unsigned long end = start + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
> +		unsigned long ra_end;
> +
> +		ra->order = exec_folio_order();
> +		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
> +		ra->start = max(ra->start, start);
> +		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
> +		ra_end = min(ra_end, end);
> +		ra->size = ra_end - ra->start;
> +		ra->async_size = 0;
> +	} else {
> +		/*
> +		 * mmap read-around
> +		 */
> +		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +		ra->size = ra->ra_pages;
> +		ra->async_size = ra->ra_pages / 4;
> +		ra->order = 0;
> +	}
>  	ractl._index = ra->start;
>  	page_cache_ra_order(&ractl, ra);
>  	return fpin;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

