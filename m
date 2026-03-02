Return-Path: <linux-fsdevel+bounces-78872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COfeBG9VpWnR9AUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:16:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E121D5652
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE85E304262A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5438F23B;
	Mon,  2 Mar 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvEjFCwM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqAAIUzO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9W9Vysl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7AZC4XVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3A38D017
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442815; cv=none; b=DY6U1REdQKpX/CmELf2Tt974Led8LCSmOWFbM/Rp+JOKxPWCgUyITXG3OyUWbwLV0Z7fUzu7rOUmTwEV/Usfv0ciztaLAQCZp9iaAOtIewkb4B19sWkPMk3b7ig31SHg8Lgu4Sc4DeKFVuDEGAUahDSZBZyBpCJ8ZODWNOAjWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442815; c=relaxed/simple;
	bh=EAXjxsOEBeehC98taEW35gyDtS/n8loApDj0Bam/mco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REGlhChi96+oSPDZJ+BAvXdfrAVESw5MY8/+wXEQxa64/dxO0y8R6TbUUdBlYh6eWzSDdNqurY61ftx64CjmFPiJ46p2Xlsjr5MpyL3/EFpHmFFQp1JWQBO/TOnNX3CUOiA8qfHvNrmz9TXmmjJcMvY707uVXOrwEROLux53mIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvEjFCwM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqAAIUzO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9W9Vysl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7AZC4XVw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 310733E7C9;
	Mon,  2 Mar 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772442811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiUa0ECJNPtkTnLKrDvGHBfFKQ79sQHYL43l9NzCiHc=;
	b=IvEjFCwMg8Ig9GtG1dDAi58hup1nQvtBAtjeECQAyWwZdCIo/N2Wtz9V4ScqMC3i1Kc/9P
	BJl8rCMRij6Dzd7CULioRD1AxUHgYCUfs/G8b7USMupWSeSxwvTSSVBBvhg1adhiQUbsDL
	N8sjoY6XUREb5Rjda6utCrHWcrwv+6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772442811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiUa0ECJNPtkTnLKrDvGHBfFKQ79sQHYL43l9NzCiHc=;
	b=AqAAIUzOF2Yy8M0YGYw+xIT5ecVWBxEF7GGlyH2RlDAtVRjY8xURwtY0Fge1fc1Eu6m1b4
	1IWqT4IXLYEjjuCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772442810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiUa0ECJNPtkTnLKrDvGHBfFKQ79sQHYL43l9NzCiHc=;
	b=F9W9VyslnpsJVBa1jGUWLmw0W8jMV2z6VYvjzKm7M03b5bnq9P5qwL7/U0i1ZSQU6C2pbI
	YsbQUDFVtuTCrLlmWhf7TnblMwGoP1Lob8tLesykv8mR+l4wD8IjEbdEXww5Ti9BrUDE7t
	y0ogEiknF9fugD7F1izz71MC8hRbBh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772442810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiUa0ECJNPtkTnLKrDvGHBfFKQ79sQHYL43l9NzCiHc=;
	b=7AZC4XVwYmP//tW6373ZF3FORac015k3gIhkGjb//YXMNtGKxtqEb4iA817SUEpzMJ1ChM
	YqxVvGdP8on/5MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 174783EA69;
	Mon,  2 Mar 2026 09:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sbavBbpUpWnXYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 09:13:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CAF0DA0A27; Mon,  2 Mar 2026 10:13:29 +0100 (CET)
Date: Mon, 2 Mar 2026 10:13:29 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] block: enable RWF_DONTCACHE for block devices
Message-ID: <blipvn6pfxno5a2cih3e7y2l7g3cbj4yjb6hhwxrer26ma5x55@ez6hhpdfsi63>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-2-cd309ccd5868@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-blk-dontcache-v3-2-cd309ccd5868@columbia.edu>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,columbia.edu:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78872-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C4E121D5652
X-Rspamd-Action: no action

On Fri 27-02-26 11:41:08, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD paths, add block_write_begin_iocb() which threads
> the kiocb through so that buffer_head-based I/O can use DONTCACHE
> behavior. The existing block_write_begin() is preserved as a wrapper
> that passes a NULL iocb.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/fops.c                |  5 +++--
>  fs/buffer.c                 | 19 ++++++++++++++++---
>  include/linux/buffer_head.h |  3 +++
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 4d32785b31d9..d8165f6ba71c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -505,7 +505,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
>  			      unsigned len, struct folio **foliop,
>  			      void **fsdata)
>  {
> -	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
> +	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
> +				     blkdev_get_block);
>  }
>  
>  static int blkdev_write_end(const struct kiocb *iocb,
> @@ -967,7 +968,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
>  	.uring_cmd	= blkdev_uring_cmd,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..18f1d128bb19 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2241,14 +2241,19 @@ EXPORT_SYMBOL(block_commit_write);
>   *
>   * The filesystem needs to handle block truncation upon failure.
>   */
> -int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> +int block_write_begin_iocb(const struct kiocb *iocb,
> +		struct address_space *mapping, loff_t pos, unsigned len,
>  		struct folio **foliop, get_block_t *get_block)
>  {
>  	pgoff_t index = pos >> PAGE_SHIFT;
> +	fgf_t fgp_flags = FGP_WRITEBEGIN;
>  	struct folio *folio;
>  	int status;
>  
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
> +		fgp_flags |= FGP_DONTCACHE;
> +
> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>  			mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> @@ -2263,6 +2268,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  	*foliop = folio;
>  	return status;
>  }
> +
> +int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> +		struct folio **foliop, get_block_t *get_block)
> +{
> +	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
> +				      get_block);
> +}
>  EXPORT_SYMBOL(block_write_begin);
>  
>  int block_write_end(loff_t pos, unsigned len, unsigned copied,
> @@ -2591,7 +2603,8 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  		(*bytes)++;
>  	}
>  
> -	return block_write_begin(mapping, pos, len, foliop, get_block);
> +	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
> +				     get_block);
>  }
>  EXPORT_SYMBOL(cont_write_begin);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index b16b88bfbc3e..ddf88ce290f2 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
>  bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  		struct folio **foliop, get_block_t *get_block);
> +int block_write_begin_iocb(const struct kiocb *iocb,
> +		struct address_space *mapping, loff_t pos, unsigned len,
> +		struct folio **foliop, get_block_t *get_block);
>  int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block);
>  int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

