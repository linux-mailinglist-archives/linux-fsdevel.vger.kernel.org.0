Return-Path: <linux-fsdevel+bounces-48038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFCAA8FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137313AB722
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D31FA859;
	Mon,  5 May 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlvdWb8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHrN2V5R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlvdWb8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHrN2V5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1681F8723
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437977; cv=none; b=hazC4PiTfw58F3zPdXg0HhJUy+dai9Qjv9S8dXCSB8994+A5RUGpnrcQkuXeMD00r+XZwKTWR1xa6XesPV8tgp5xfwNkfmWJQfxUmIFHbQh6t6Pz8CmhpdOAHR+QCwUwnHL2fZNasiDVoaSE43Yr7y8XH8RkuOkcUZ9fBU73GUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437977; c=relaxed/simple;
	bh=G97nd481/AY7ntHMhk/l9VaXH4yN/Jzgx0eacE8MhHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzaeTbZC8u4b386hWZMqW10gQOIaacCKf/aWtTCcn+huOYn3dSW2+E9LnJ1jhHCNr0+csmtyuffzUF1djIEnC7XkNp8uhXEpm8FED4/kw8WD8njS2yCzDOhMG+rYkkvd+dubShT7X3DUAiQc344ejWp2sI8JNqvO1092pu96Ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlvdWb8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHrN2V5R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlvdWb8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHrN2V5R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17D521F79C;
	Mon,  5 May 2025 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746437974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaNrb/5c3V76o6V9zjsgk79UN9zVm2u3ncLxvNGeBmc=;
	b=UlvdWb8QxfFPO/QFvWjPi5DxvFtJC6ExpXtw4Neg9GRMEt3z2Oi1JdmfuGl2wTFNmIm4yN
	BOL6PzFyp8WDAiDjpu6L+TFYSIMVQuEf5cSBBTdeRCWWjrZB2cTtpXT6uxYaFjpbVT+U5n
	QCcn9H0ezQ4I96N8RgL/fcJrK4O3k/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746437974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaNrb/5c3V76o6V9zjsgk79UN9zVm2u3ncLxvNGeBmc=;
	b=VHrN2V5RshMhLLo18Ovmd2V0Keagzi8yziEEoNNRaSOo5t77ydo+jiyPnhpe1/mLYzbe34
	KFZS+A5i/D3ZsNDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UlvdWb8Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VHrN2V5R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746437974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaNrb/5c3V76o6V9zjsgk79UN9zVm2u3ncLxvNGeBmc=;
	b=UlvdWb8QxfFPO/QFvWjPi5DxvFtJC6ExpXtw4Neg9GRMEt3z2Oi1JdmfuGl2wTFNmIm4yN
	BOL6PzFyp8WDAiDjpu6L+TFYSIMVQuEf5cSBBTdeRCWWjrZB2cTtpXT6uxYaFjpbVT+U5n
	QCcn9H0ezQ4I96N8RgL/fcJrK4O3k/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746437974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaNrb/5c3V76o6V9zjsgk79UN9zVm2u3ncLxvNGeBmc=;
	b=VHrN2V5RshMhLLo18Ovmd2V0Keagzi8yziEEoNNRaSOo5t77ydo+jiyPnhpe1/mLYzbe34
	KFZS+A5i/D3ZsNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C97713883;
	Mon,  5 May 2025 09:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fb0RA1aHGGiwbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 09:39:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5D0AA082A; Mon,  5 May 2025 11:39:25 +0200 (CEST)
Date: Mon, 5 May 2025 11:39:25 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 3/5] mm/readahead: Make space in struct
 file_ra_state
Message-ID: <eexjhch7oes6fljmo3zl3mfqst34uudtc62cclkzqihvpjzszt@g5ngpaatleif>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-4-ryan.roberts@arm.com>
X-Rspamd-Queue-Id: 17D521F79C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,arm.com:email,suse.cz:dkim,suse.cz:email];
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

On Wed 30-04-25 15:59:16, Ryan Roberts wrote:
> We need to be able to store the preferred folio order associated with a
> readahead request in the struct file_ra_state so that we can more
> accurately increase the order across subsequent readahead requests. But
> struct file_ra_state is per-struct file, so we don't really want to
> increase it's size.
> 
> mmap_miss is currently 32 bits but it is only counted up to 10 *
> MMAP_LOTSAMISS, which is currently defined as 1000. So 16 bits should be
> plenty. Redefine it to unsigned short, making room for order as unsigned
> short in follow up commit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |  2 +-
>  mm/filemap.c       | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..44362bef0010 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1042,7 +1042,7 @@ struct file_ra_state {
>  	unsigned int size;
>  	unsigned int async_size;
>  	unsigned int ra_pages;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  	loff_t prev_pos;
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b90cbeb4a1a..fa129ecfd80f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3207,7 +3207,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
>  	unsigned long vm_flags = vmf->vma->vm_flags;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> @@ -3275,7 +3275,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	struct file_ra_state *ra = &file->f_ra;
>  	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
> @@ -3595,7 +3595,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
>  static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  			struct folio *folio, unsigned long start,
>  			unsigned long addr, unsigned int nr_pages,
> -			unsigned long *rss, unsigned int *mmap_miss)
> +			unsigned long *rss, unsigned short *mmap_miss)
>  {
>  	vm_fault_t ret = 0;
>  	struct page *page = folio_page(folio, start);
> @@ -3657,7 +3657,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  
>  static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>  		struct folio *folio, unsigned long addr,
> -		unsigned long *rss, unsigned int *mmap_miss)
> +		unsigned long *rss, unsigned short *mmap_miss)
>  {
>  	vm_fault_t ret = 0;
>  	struct page *page = &folio->page;
> @@ -3699,7 +3699,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	struct folio *folio;
>  	vm_fault_t ret = 0;
>  	unsigned long rss = 0;
> -	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> +	unsigned int nr_pages = 0, folio_type;
> +	unsigned short mmap_miss = 0, mmap_miss_saved;
>  
>  	rcu_read_lock();
>  	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

