Return-Path: <linux-fsdevel+bounces-51444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A4AD6F20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8387B1898378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3AE2F4336;
	Thu, 12 Jun 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ostiY3Rp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1AhroKxm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ostiY3Rp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1AhroKxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C602F431D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728236; cv=none; b=MjcCqqz8cL+m+807FOfHrkxDxEciQPnUQdRPeIqb+gOBljRofIxpBKntjsxC/pPfwk4uNCzICMtTA4SqP1yNW8ClG19jgA8a2Piz+oGfy/PlcEoX4yE8WVgWtd2IgC9g4IkF24PD/oaQzOKYf0IubaZzgGUhBtsDkg4Ptdth+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728236; c=relaxed/simple;
	bh=kq26j+ZonXg6jnR+Mnw4tjN8HSwyVUlYB6lXgfqRozk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUdsKyOpo2ZBS0sy3pD11M0BulIp4QLIbNGJNi8I+l5cT4se5vMaVCGWkUU5xEZjWcaBhw2lCogN9UyiLwim6BM5bn/zyDNRKDZJxCJaSrtBpqKqtoFA/OBTCnANJG0YdKFyJ7PoT7ujG3nGPLlNpj3UE5NCWEtMAYjTT4RoY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ostiY3Rp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1AhroKxm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ostiY3Rp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1AhroKxm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE72D1F78E;
	Thu, 12 Jun 2025 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749728225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SAaMXZaNbH9WPPhkq8n7uqpbqPdSSaReMxj+cBGzwlY=;
	b=ostiY3RpZJXSgquqV3UuObYfhxZl2s8oXJIjcCg1VD5HPerbuGqFYh2atkjyaIMwIFjq5m
	0jS+xbUwQlVj24sgYsRHkuKZYoLJYCHvZLwNH95CdJr9T2Qj7+CCfMyXo+qlUHU+krnX2T
	TRRpt+Kl07T8600kqGW17mvRmgUbQhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749728225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SAaMXZaNbH9WPPhkq8n7uqpbqPdSSaReMxj+cBGzwlY=;
	b=1AhroKxmJjnWpTIb+AkEvXyY4Xk4mMuettRUVBqDGeEIzpmNOE1JS7n8+BDkKQET8AZq0/
	2wQV+K419+ufPQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749728225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SAaMXZaNbH9WPPhkq8n7uqpbqPdSSaReMxj+cBGzwlY=;
	b=ostiY3RpZJXSgquqV3UuObYfhxZl2s8oXJIjcCg1VD5HPerbuGqFYh2atkjyaIMwIFjq5m
	0jS+xbUwQlVj24sgYsRHkuKZYoLJYCHvZLwNH95CdJr9T2Qj7+CCfMyXo+qlUHU+krnX2T
	TRRpt+Kl07T8600kqGW17mvRmgUbQhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749728225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SAaMXZaNbH9WPPhkq8n7uqpbqPdSSaReMxj+cBGzwlY=;
	b=1AhroKxmJjnWpTIb+AkEvXyY4Xk4mMuettRUVBqDGeEIzpmNOE1JS7n8+BDkKQET8AZq0/
	2wQV+K419+ufPQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD75132D8;
	Thu, 12 Jun 2025 11:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JriCJuG7SmjrZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 11:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D716A099E; Thu, 12 Jun 2025 13:37:05 +0200 (CEST)
Date: Thu, 12 Jun 2025 13:37:05 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v5 4/5] mm/readahead: Store folio order in struct
 file_ra_state
Message-ID: <dhfhfcymhfdtqnwof4cqfhplgo24ho3kon3e7lrqwwgz26ehqr@g6h3g3yub4w4>
References: <20250609092729.274960-1-ryan.roberts@arm.com>
 <20250609092729.274960-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609092729.274960-5-ryan.roberts@arm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 09-06-25 10:27:26, Ryan Roberts wrote:
> Previously the folio order of the previous readahead request was
> inferred from the folio who's readahead marker was hit. But due to the
> way we have to round to non-natural boundaries sometimes, this first
> folio in the readahead block is often smaller than the preferred order
> for that request. This means that for cases where the initial sync
> readahead is poorly aligned, the folio order will ramp up much more
> slowly.
> 
> So instead, let's store the order in struct file_ra_state so we are not
> affected by any required alignment. We previously made enough room in
> the struct for a 16 order field. This should be plenty big enough since
> we are limited to MAX_PAGECACHE_ORDER anyway, which is certainly never
> larger than ~20.
> 
> Since we now pass order in struct file_ra_state, page_cache_ra_order()
> no longer needs it's new_order parameter, so let's remove that.
> 
> Worked example:
> 
> Here we are touching pages 17-256 sequentially just as we did in the
> previous commit, but now that we are remembering the preferred order
> explicitly, we no longer have the slow ramp up problem. Note
> specifically that we no longer have 2 rounds (2x ~128K) of order-2
> folios:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
> FOLIO  0x00040000  0x00050000       65536       64       80     16      4
> FOLIO  0x00050000  0x00060000       65536       80       96     16      4
> FOLIO  0x00060000  0x00080000      131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
> FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
> FOLIO  0x00100000  0x00120000      131072      256      288     32      5
> FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
> HOLE   0x00140000  0x00800000     7077888      320     2048   1728
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       |  6 ++++--
>  mm/internal.h      |  3 +--
>  mm/readahead.c     | 21 +++++++++++++--------
>  4 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 87e7d5790e43..b5172b691f97 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1041,6 +1041,7 @@ struct fown_struct {
>   *      and so were/are genuinely "ahead".  Start next readahead when
>   *      the first of these pages is accessed.
>   * @ra_pages: Maximum size of a readahead request, copied from the bdi.
> + * @order: Preferred folio order used for most recent readahead.
>   * @mmap_miss: How many mmap accesses missed in the page cache.
>   * @prev_pos: The last byte in the most recent read request.
>   *
> @@ -1052,6 +1053,7 @@ struct file_ra_state {
>  	unsigned int size;
>  	unsigned int async_size;
>  	unsigned int ra_pages;
> +	unsigned short order;
>  	unsigned short mmap_miss;
>  	loff_t prev_pos;
>  };
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7bb4ffca8487..4b5c8d69f04c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3232,7 +3232,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		if (!(vm_flags & VM_RAND_READ))
>  			ra->size *= 2;
>  		ra->async_size = HPAGE_PMD_NR;
> -		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> +		ra->order = HPAGE_PMD_ORDER;
> +		page_cache_ra_order(&ractl, ra);
>  		return fpin;
>  	}
>  #endif
> @@ -3268,8 +3269,9 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>  	ra->size = ra->ra_pages;
>  	ra->async_size = ra->ra_pages / 4;
> +	ra->order = 0;
>  	ractl._index = ra->start;
> -	page_cache_ra_order(&ractl, ra, 0);
> +	page_cache_ra_order(&ractl, ra);
>  	return fpin;
>  }
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 6b8ed2017743..f91688e2894f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -436,8 +436,7 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
>  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  			   gfp_t gfp);
>  
> -void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
> -		unsigned int order);
> +void page_cache_ra_order(struct readahead_control *, struct file_ra_state *);
>  void force_page_cache_ra(struct readahead_control *, unsigned long nr);
>  static inline void force_page_cache_readahead(struct address_space *mapping,
>  		struct file *file, pgoff_t index, unsigned long nr_to_read)
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 87be20ae00d0..95a24f12d1e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -457,7 +457,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
>  }
>  
>  void page_cache_ra_order(struct readahead_control *ractl,
> -		struct file_ra_state *ra, unsigned int new_order)
> +		struct file_ra_state *ra)
>  {
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t start = readahead_index(ractl);
> @@ -468,9 +468,12 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	unsigned int nofs;
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
> +	unsigned int new_order = ra->order;
>  
> -	if (!mapping_large_folio_support(mapping))
> +	if (!mapping_large_folio_support(mapping)) {
> +		ra->order = 0;
>  		goto fallback;
> +	}
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> @@ -478,6 +481,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
>  
> +	ra->order = new_order;
> +
>  	/* See comment in page_cache_ra_unbounded() */
>  	nofs = memalloc_nofs_save();
>  	filemap_invalidate_lock_shared(mapping);
> @@ -609,8 +614,9 @@ void page_cache_sync_ra(struct readahead_control *ractl,
>  	ra->size = min(contig_count + req_count, max_pages);
>  	ra->async_size = 1;
>  readit:
> +	ra->order = 0;
>  	ractl->_index = ra->start;
> -	page_cache_ra_order(ractl, ra, 0);
> +	page_cache_ra_order(ractl, ra);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_sync_ra);
>  
> @@ -621,7 +627,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	struct file_ra_state *ra = ractl->ra;
>  	pgoff_t index = readahead_index(ractl);
>  	pgoff_t expected, start, end, aligned_end, align;
> -	unsigned int order = folio_order(folio);
>  
>  	/* no readahead */
>  	if (!ra->ra_pages)
> @@ -644,7 +649,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	 * Ramp up sizes, and push forward the readahead window.
>  	 */
>  	expected = round_down(ra->start + ra->size - ra->async_size,
> -			1UL << order);
> +			1UL << folio_order(folio));
>  	if (index == expected) {
>  		ra->start += ra->size;
>  		/*
> @@ -673,15 +678,15 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	ra->size += req_count;
>  	ra->size = get_next_ra_size(ra, max_pages);
>  readit:
> -	order += 2;
> -	align = 1UL << min(order, ffs(max_pages) - 1);
> +	ra->order += 2;
> +	align = 1UL << min(ra->order, ffs(max_pages) - 1);
>  	end = ra->start + ra->size;
>  	aligned_end = round_down(end, align);
>  	if (aligned_end > ra->start)
>  		ra->size -= end - aligned_end;
>  	ra->async_size = ra->size;
>  	ractl->_index = ra->start;
> -	page_cache_ra_order(ractl, ra, order);
> +	page_cache_ra_order(ractl, ra);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_async_ra);
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

