Return-Path: <linux-fsdevel+bounces-76044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAjjCjipgGmeAAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:40:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0858CCE0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2625A3068D64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDB3369961;
	Mon,  2 Feb 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ws/xc31N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJdLt/42";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ws/xc31N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vJdLt/42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F8369235
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039154; cv=none; b=iZ3WhN59pxQVgp9jZHxkXPOlLwWXkfeTtjk37AGgelHTpsBQ8Ln5gFdgQEgHlYDaNDQyf8+NNchC6pPNhc+raePXcEbB2oXG6O30tV0ZMdSf4StFEAYNZf3sUXo1wS57xn2+4jzqcmzek5F70pFUJZuFPqbkcXj6Z9m1Apjjxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039154; c=relaxed/simple;
	bh=q5ZbXaRSTFyba3ZJxKd0w/2syuOEQfW+Rql0zjQs4cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyFpX3OeFOz5VYf42f17aert9KzC8zK52nrGVB1CSuogH1Zp7RD2rdja23HtvvzF+Ly+/zaRdCxRDM7x0eY6SfZMVgevLTsrU2H3+HerP3pSQqj1U2rk4i3aqsILtz1sfFfLw9B3ysXp1oLW8lidwxlAoNsBUFrt3hsOgx86sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ws/xc31N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJdLt/42; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ws/xc31N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vJdLt/42; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 622725BCFE;
	Mon,  2 Feb 2026 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770039151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5plI+HfqZziecUak4ZWGn/wnaJEmJVeBgs6AWYMzk+Q=;
	b=ws/xc31Ns1Vvsm9OyW8xqN+9wRVHLt/q/NsCl7KLWnFBsxyJYzrtLmSL63UeYRONzjahJA
	3ja6h1kh+614x346JBkAIIB6iMiGWAQzTGHNPigpvLxkFOQQkMG3zuP7P3qHGM22G4uSJ7
	Vpzh4sB98HKFc2q4GRNP9Twl8v6UHmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770039151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5plI+HfqZziecUak4ZWGn/wnaJEmJVeBgs6AWYMzk+Q=;
	b=vJdLt/42ofHM+luzwtAdmqnRi/1JPT8d7hB/BSuh+kkdUGaocut9O908SaiqPYhvZO5Ub3
	gBAO02GvRLQM2tDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770039151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5plI+HfqZziecUak4ZWGn/wnaJEmJVeBgs6AWYMzk+Q=;
	b=ws/xc31Ns1Vvsm9OyW8xqN+9wRVHLt/q/NsCl7KLWnFBsxyJYzrtLmSL63UeYRONzjahJA
	3ja6h1kh+614x346JBkAIIB6iMiGWAQzTGHNPigpvLxkFOQQkMG3zuP7P3qHGM22G4uSJ7
	Vpzh4sB98HKFc2q4GRNP9Twl8v6UHmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770039151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5plI+HfqZziecUak4ZWGn/wnaJEmJVeBgs6AWYMzk+Q=;
	b=vJdLt/42ofHM+luzwtAdmqnRi/1JPT8d7hB/BSuh+kkdUGaocut9O908SaiqPYhvZO5Ub3
	gBAO02GvRLQM2tDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 486103EA62;
	Mon,  2 Feb 2026 13:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkGjEW+ngGmyaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 13:32:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 030E6A08F8; Mon,  2 Feb 2026 14:32:30 +0100 (CET)
Date: Mon, 2 Feb 2026 14:32:30 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/11] ext4: move ->read_folio and ->readahead to
 readahead.c
Message-ID: <dbxzia62hlrwhowtxj6nzjgfvqf6zdn7y22rwgfxha35hwltcz@ys3mms55u4lc>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-4-hch@lst.de>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76044-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0858CCE0C
X-Rspamd-Action: no action

On Mon 02-02-26 07:06:32, Christoph Hellwig wrote:
> Keep all the read into pagecache code in a single file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Whatever :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h     |  4 ++--
>  fs/ext4/inode.c    | 27 ---------------------------
>  fs/ext4/readpage.c | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..a8a448e20ef8 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3735,8 +3735,8 @@ static inline void ext4_set_de_type(struct super_block *sb,
>  }
>  
>  /* readpages.c */
> -extern int ext4_mpage_readpages(struct inode *inode,
> -		struct readahead_control *rac, struct folio *folio);
> +int ext4_read_folio(struct file *file, struct folio *folio);
> +void ext4_readahead(struct readahead_control *rac);
>  extern int __init ext4_init_post_read_processing(void);
>  extern void ext4_exit_post_read_processing(void);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 8c2ef98fa530..e98954e7d0b3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3380,33 +3380,6 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  	return ret;
>  }
>  
> -static int ext4_read_folio(struct file *file, struct folio *folio)
> -{
> -	int ret = -EAGAIN;
> -	struct inode *inode = folio->mapping->host;
> -
> -	trace_ext4_read_folio(inode, folio);
> -
> -	if (ext4_has_inline_data(inode))
> -		ret = ext4_readpage_inline(inode, folio);
> -
> -	if (ret == -EAGAIN)
> -		return ext4_mpage_readpages(inode, NULL, folio);
> -
> -	return ret;
> -}
> -
> -static void ext4_readahead(struct readahead_control *rac)
> -{
> -	struct inode *inode = rac->mapping->host;
> -
> -	/* If the file has inline data, no need to do readahead. */
> -	if (ext4_has_inline_data(inode))
> -		return;
> -
> -	ext4_mpage_readpages(inode, rac, NULL);
> -}
> -
>  static void ext4_invalidate_folio(struct folio *folio, size_t offset,
>  				size_t length)
>  {
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 267594ef0b2c..bf84952ebf94 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -45,6 +45,7 @@
>  #include <linux/pagevec.h>
>  
>  #include "ext4.h"
> +#include <trace/events/ext4.h>
>  
>  #define NUM_PREALLOC_POST_READ_CTXS	128
>  
> @@ -209,7 +210,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
>  	return i_size_read(inode);
>  }
>  
> -int ext4_mpage_readpages(struct inode *inode,
> +static int ext4_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct folio *folio)
>  {
>  	struct bio *bio = NULL;
> @@ -394,6 +395,34 @@ int ext4_mpage_readpages(struct inode *inode,
>  	return 0;
>  }
>  
> +int ext4_read_folio(struct file *file, struct folio *folio)
> +{
> +	int ret = -EAGAIN;
> +	struct inode *inode = folio->mapping->host;
> +
> +	trace_ext4_read_folio(inode, folio);
> +
> +	if (ext4_has_inline_data(inode))
> +		ret = ext4_readpage_inline(inode, folio);
> +
> +	if (ret == -EAGAIN)
> +		return ext4_mpage_readpages(inode, NULL, folio);
> +
> +	return ret;
> +}
> +
> +void ext4_readahead(struct readahead_control *rac)
> +{
> +	struct inode *inode = rac->mapping->host;
> +
> +	/* If the file has inline data, no need to do readahead. */
> +	if (ext4_has_inline_data(inode))
> +		return;
> +
> +	ext4_mpage_readpages(inode, rac, NULL);
> +}
> +
> +
>  int __init ext4_init_post_read_processing(void)
>  {
>  	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, SLAB_RECLAIM_ACCOUNT);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

