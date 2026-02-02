Return-Path: <linux-fsdevel+bounces-76045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJK6FpaogGmeAAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:37:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D4BCCD4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04E230069A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DE36A005;
	Mon,  2 Feb 2026 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgHGkwsD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6IazOQPV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgHGkwsD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6IazOQPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F42D6E44
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039382; cv=none; b=YKmyapVL+T41IKCgkjTBSVOj+4r7fA/8WHkeuynNezTckD8lm7FJDT4Juelzhga8GLPbU+Hm9uKzsVbBTIj14gj4FhOmXcKbxzrBFLRgB0eojtFBOsKIKTk5cp9N4cRd0tE+MvfXd81GAsMUXTxptsxpkB7iaxzZMe7UjQ4gl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039382; c=relaxed/simple;
	bh=TqPN2+yJXgFdD2YhU3pY+vZos73eSW2Y6C3K3FfMOtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGI+0eSNKibQ4/otW6W3ue9gP8i00mvPKYRpXxa5/1tqKHPatfnGDYbQ+r+bh/voF4YqFjSoyD8ag1zRQG5oPreO/Pe2tbTYcsg8airNOxLedHmWYQdmKasqvugBfJTsLgbuVwFRLUzPHABhxwGEHZ+lv3E8X+j977RsxiZW3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgHGkwsD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6IazOQPV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgHGkwsD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6IazOQPV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5615BCFE;
	Mon,  2 Feb 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770039379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
	b=mgHGkwsDwZhO6atbUu6nt1bxZsy/zGmgKDzMxj6pnmrn1QE7S8zYdKvcLfxlwGVHlrOr19
	QM2Cs1QkCD1XUMhhxl7qoEz+J+sUbALu/XZFbIWdkLi0Lqq8BAySCuYawgXpfg6Wi9sc7U
	H2F4vZyqWToBYlmR1QsMbBJCVR+S0QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770039379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
	b=6IazOQPVfhBn+IRmJxPuIPDbd+tMWB+KbFPhjToHvwzsv25CizNrBF+Ii0h/iFfV8Nf3kJ
	SpU5TOugMtYZdJCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mgHGkwsD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6IazOQPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770039379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
	b=mgHGkwsDwZhO6atbUu6nt1bxZsy/zGmgKDzMxj6pnmrn1QE7S8zYdKvcLfxlwGVHlrOr19
	QM2Cs1QkCD1XUMhhxl7qoEz+J+sUbALu/XZFbIWdkLi0Lqq8BAySCuYawgXpfg6Wi9sc7U
	H2F4vZyqWToBYlmR1QsMbBJCVR+S0QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770039379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/EPEbNnnr8uAiYZHpEsuna5VNl7uH08rLKo26QCkNc=;
	b=6IazOQPVfhBn+IRmJxPuIPDbd+tMWB+KbFPhjToHvwzsv25CizNrBF+Ii0h/iFfV8Nf3kJ
	SpU5TOugMtYZdJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27BFF3EA62;
	Mon,  2 Feb 2026 13:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xdCyCVOogGmOJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 13:36:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE784A08F8; Mon,  2 Feb 2026 14:36:18 +0100 (CET)
Date: Mon, 2 Feb 2026 14:36:18 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 02/11] readahead: push invalidate_lock out of
 page_cache_ra_unbounded
Message-ID: <vu3c3isevxhsayshrgv4yj2xfkeugbtx4jaryrdxehz57vq6ho@mkrueh7j55fe>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-3-hch@lst.de>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,lst.de:email,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76045-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: C4D4BCCD4C
X-Rspamd-Action: no action

On Mon 02-02-26 07:06:31, Christoph Hellwig wrote:
> Require the invalidate_lock to be held over calls to
> page_cache_ra_unbounded instead of acquiring it in this function.
> 
> This prepares for calling page_cache_ra_unbounded from ->readahead for
> fsverity read-ahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index da029fed4e5a..c9b9fcdd0cae 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  	pgoff_t redirty_idx = page_idx;
>  	int page_len = 0, ret = 0;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(&ractl, len, 0);
> +	filemap_invalidate_unlock_shared(mapping);
>  
>  	do {
>  		folio = read_cache_folio(mapping, page_idx, NULL, NULL);
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 1a88decace53..8e0d6fde802f 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -26,10 +26,13 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
>  	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
> -		if (!IS_ERR(folio))
> +		if (!IS_ERR(folio)) {
>  			folio_put(folio);
> -		else if (num_ra_pages > 1)
> +		} else if (num_ra_pages > 1) {
> +			filemap_invalidate_lock_shared(inode->i_mapping);
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> +			filemap_invalidate_unlock_shared(inode->i_mapping);
> +		}
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  	}
>  	if (IS_ERR(folio))
> diff --git a/mm/readahead.c b/mm/readahead.c
> index b415c9969176..25f81124beb6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -204,7 +204,8 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>   * not the function you want to call.  Use page_cache_async_readahead()
>   * or page_cache_sync_readahead() instead.
>   *
> - * Context: File is referenced by caller.  Mutexes may be held by caller.
> + * Context: File is referenced by caller, and ractl->mapping->invalidate_lock
> + * must be held by the caller in shared mode.  Mutexes may be held by caller.
>   * May sleep, but will not reenter filesystem to reclaim memory.
>   */
>  void page_cache_ra_unbounded(struct readahead_control *ractl,
> @@ -228,9 +229,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	lockdep_assert_held_read(&mapping->invalidate_lock);
> +
>  	trace_page_cache_ra_unbounded(mapping->host, index, nr_to_read,
>  				      lookahead_size);
> -	filemap_invalidate_lock_shared(mapping);
>  	index = mapping_align_index(mapping, index);
>  
>  	/*
> @@ -300,7 +302,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 * will then handle the error.
>  	 */
>  	read_pages(ractl);
> -	filemap_invalidate_unlock_shared(mapping);
>  	memalloc_nofs_restore(nofs);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
> @@ -314,9 +315,9 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
>  static void do_page_cache_ra(struct readahead_control *ractl,
>  		unsigned long nr_to_read, unsigned long lookahead_size)
>  {
> -	struct inode *inode = ractl->mapping->host;
> +	struct address_space *mapping = ractl->mapping;
>  	unsigned long index = readahead_index(ractl);
> -	loff_t isize = i_size_read(inode);
> +	loff_t isize = i_size_read(mapping->host);
>  	pgoff_t end_index;	/* The last page we want to read */
>  
>  	if (isize == 0)
> @@ -329,7 +330,9 @@ static void do_page_cache_ra(struct readahead_control *ractl,
>  	if (nr_to_read > end_index - index)
>  		nr_to_read = end_index - index + 1;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
> +	filemap_invalidate_unlock_shared(mapping);
>  }
>  
>  /*
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

