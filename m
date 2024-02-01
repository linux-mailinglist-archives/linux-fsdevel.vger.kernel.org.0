Return-Path: <linux-fsdevel+bounces-9829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A344C84543B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88CF1C26450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052B615CD71;
	Thu,  1 Feb 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgbICBFw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQoeTL6v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgbICBFw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQoeTL6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07D15B0FA;
	Thu,  1 Feb 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780273; cv=none; b=NJsOzf0aq2yz+f7vr1PNTXBTCMOno4LRYKg43nhCcxF6qn28DV0+t6uD7Gfr8GO4QAaqgX0QhdTn885d8qVBD74KifpMhWAn+s0A2UsqOShxKV/nWMp1r2IOveWwLNMF9VdVxCrbTQLDt62H3kMwP8B7+DS/mNgt123ERCYraFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780273; c=relaxed/simple;
	bh=oi5QejTDiTPdw5JK4FsH5vF44q8eRzpf9aXlYTZ0eec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1piXPa2IJDt2aFeVptCt9nk42iemsJbOIu/ph0vQ8riqFHAU589Y2IMHqD1Pw6hiNlggb2tspY9fqSU9HLM1M2Rn28+lAQgI0pY5jbsvAGgtPJu0rJNcD5TO5ttrRiQYK7PwvyleuuTAkJE/pWC0R2BxApQfof5ZefVRH2gQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgbICBFw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQoeTL6v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgbICBFw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQoeTL6v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1EC122168;
	Thu,  1 Feb 2024 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw5Km38+9mHgHXuGiLgV165ByO4XGRf+Ps4iZpq/mhw=;
	b=DgbICBFwQUioRqWHnu/WREm50kyZ9FBXR7GJM7GRGBSlhVnnckOkWAnXNpEppLsHNUKJKB
	9c6yI/w6oivyqUea/bdrplZ2IGL0Nun4Lis/jADxpi8dujdpSnN5Br4uY13egIuBIDtXs1
	V4g1HwPYMNwQCv1cYEMSRBBUL2Rl118=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw5Km38+9mHgHXuGiLgV165ByO4XGRf+Ps4iZpq/mhw=;
	b=LQoeTL6vqQbbhc31167aNVBkOPwDjV1PNhX9ShezoGmZ0jnq8E3YC93JBL0dc42Tl1KLg1
	hJV5h+RXV3u09ZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw5Km38+9mHgHXuGiLgV165ByO4XGRf+Ps4iZpq/mhw=;
	b=DgbICBFwQUioRqWHnu/WREm50kyZ9FBXR7GJM7GRGBSlhVnnckOkWAnXNpEppLsHNUKJKB
	9c6yI/w6oivyqUea/bdrplZ2IGL0Nun4Lis/jADxpi8dujdpSnN5Br4uY13egIuBIDtXs1
	V4g1HwPYMNwQCv1cYEMSRBBUL2Rl118=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw5Km38+9mHgHXuGiLgV165ByO4XGRf+Ps4iZpq/mhw=;
	b=LQoeTL6vqQbbhc31167aNVBkOPwDjV1PNhX9ShezoGmZ0jnq8E3YC93JBL0dc42Tl1KLg1
	hJV5h+RXV3u09ZBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B612A13594;
	Thu,  1 Feb 2024 09:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id w1BrLG1mu2VrVAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:37:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64447A0809; Thu,  1 Feb 2024 10:37:49 +0100 (CET)
Date: Thu, 1 Feb 2024 10:37:49 +0100
From: Jan Kara <jack@suse.cz>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
Message-ID: <20240201093749.ll7uzgt7ixy7kkhw@quack3>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201100835.1626685-3-liushixin2@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 01-02-24 18:08:35, Liu Shixin wrote:
> When the pagefault is not for write and the refault distance is close,
> the page will be activated directly. If there are too many such pages in
> a file, that means the pages may be reclaimed immediately.
> In such situation, there is no positive effect to read-ahead since it will
> only waste IO. So collect the number of such pages and when the number is
> too large, stop bothering with read-ahead for a while until it decreased
> automatically.
> 
> Define 'too large' as 10000 experientially, which can solves the problem
> and does not affect by the occasional active refault.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

So I'm not convinced this new logic is needed. We already have
ra->mmap_miss which gets incremented when a page fault has to read the page
(and decremented when a page fault found the page already in cache). This
should already work to detect trashing as well, shouldn't it? If it does
not, why?

								Honza

> ---
>  include/linux/fs.h      |  2 ++
>  include/linux/pagemap.h |  1 +
>  mm/filemap.c            | 16 ++++++++++++++++
>  mm/readahead.c          |  4 ++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a704951..f2a1825442f5a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -960,6 +960,7 @@ struct fown_struct {
>   *      the first of these pages is accessed.
>   * @ra_pages: Maximum size of a readahead request, copied from the bdi.
>   * @mmap_miss: How many mmap accesses missed in the page cache.
> + * @active_refault: Number of active page refault.
>   * @prev_pos: The last byte in the most recent read request.
>   *
>   * When this structure is passed to ->readahead(), the "most recent"
> @@ -971,6 +972,7 @@ struct file_ra_state {
>  	unsigned int async_size;
>  	unsigned int ra_pages;
>  	unsigned int mmap_miss;
> +	unsigned int active_refault;
>  	loff_t prev_pos;
>  };
>  
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d2..da9eaf985dec4 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1256,6 +1256,7 @@ struct readahead_control {
>  	pgoff_t _index;
>  	unsigned int _nr_pages;
>  	unsigned int _batch_count;
> +	unsigned int _active_refault;
>  	bool _workingset;
>  	unsigned long _pflags;
>  };
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db7..4de80592ab270 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3037,6 +3037,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  
>  #ifdef CONFIG_MMU
>  #define MMAP_LOTSAMISS  (100)
> +#define ACTIVE_REFAULT_LIMIT	(10000)
>  /*
>   * lock_folio_maybe_drop_mmap - lock the page, possibly dropping the mmap_lock
>   * @vmf - the vm_fault for this fault.
> @@ -3142,6 +3143,18 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
> +	ractl._active_refault = READ_ONCE(ra->active_refault);
> +	if (ractl._active_refault)
> +		WRITE_ONCE(ra->active_refault, --ractl._active_refault);
> +
> +	/*
> +	 * If there are a lot of refault of active pages in this file,
> +	 * that means the memory reclaim is ongoing. Stop bothering with
> +	 * read-ahead since it will only waste IO.
> +	 */
> +	if (ractl._active_refault >= ACTIVE_REFAULT_LIMIT)
> +		return fpin;
> +
>  	/*
>  	 * mmap read-around
>  	 */
> @@ -3151,6 +3164,9 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	ra->async_size = ra->ra_pages / 4;
>  	ractl._index = ra->start;
>  	page_cache_ra_order(&ractl, ra, 0);
> +
> +	WRITE_ONCE(ra->active_refault, ractl._active_refault);
> +
>  	return fpin;
>  }
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index cc4abb67eb223..d79bb70a232c4 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -263,6 +263,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			folio_set_readahead(folio);
>  		ractl->_workingset |= folio_test_workingset(folio);
>  		ractl->_nr_pages++;
> +		if (unlikely(folio_test_workingset(folio)))
> +			ractl->_active_refault++;
> +		else if (unlikely(ractl->_active_refault))
> +			ractl->_active_refault--;
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

