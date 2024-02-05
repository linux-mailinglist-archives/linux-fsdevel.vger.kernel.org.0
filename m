Return-Path: <linux-fsdevel+bounces-10260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A58498ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B831C217AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894F18E3A;
	Mon,  5 Feb 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWlGlpjg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDIaZo/o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZYJ3k7Ln";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4hfbs10r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE718E00;
	Mon,  5 Feb 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132856; cv=none; b=sBcxdwYNZL3ARQptZALSMuRA6G8bwBgFeo2BJobyAz7fJYHzrE7PbWUyelS6KuF1C+2rPEgEvq6+uFkF2ahbXWw3vlxQ8AuZhwCR5Pu5FqWRVPb8JWJiUE502uO1GlYPI3vzuTmdhO/7pHPDVL/55KvscQLVeUvPrO8AxbyXITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132856; c=relaxed/simple;
	bh=gf0D6upjqXr6wfjvr+pd9lvlUyDKq+kblrTY2ZtM6vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDr9ME9v7mX56ADrrhmgjQLutCdV33RFj5T/+cJ2CDxbPHFgUWNGrFfSZD2RPO1scy7lkg11iX0vMCGQPNQ5dXODAgxsmxydH4GuPx2Ja9aLoHNtkZ5/RFKlzvr6A0Jn566JqHvQDb5zEY+dr9M3TlQMmHIMJqBy4JLQ1XbWxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWlGlpjg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDIaZo/o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZYJ3k7Ln; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4hfbs10r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2A731F8BD;
	Mon,  5 Feb 2024 11:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707132853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SxzjtBf487sMzoXkTo79HeTFHw6kYb0uZ9SjI1QhA=;
	b=nWlGlpjgTnSsdsU/4IcQAUBsJUNt8O2LS7OBMRW/5yB+zMgVMogO2G+6I+vWntP+poRgnm
	rJEEvOz0fexQj7YIOTCnK1gEBres+5IfiNKztez0kJBxSCZubRQY7oqWlUHl9OyDx08GxV
	Nz03ign2qpbSzbzEwnVZ2F11yM2fnds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707132853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SxzjtBf487sMzoXkTo79HeTFHw6kYb0uZ9SjI1QhA=;
	b=rDIaZo/oPFtJBnyilzrNT6NyPncrgL7uudHAAz46rJPOfXzKlJfWp0h67EmRzw9xkWlVmC
	HVxRsmi3P39nLwBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707132852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SxzjtBf487sMzoXkTo79HeTFHw6kYb0uZ9SjI1QhA=;
	b=ZYJ3k7LnR8sbw5nxKHiqRmRqE91mDOoDVovLO4nQPFElWqeuESWMWhrS0AtUOcZADAOk5p
	WhqBGGaMCP30TWpTUlaQDHggmWK25bcY7BmIUu+lbMnxnOvo6MaFQs+bv1zSmYhChgz/f3
	8eXa9KFGPXdAs/s2cJDz6xXwRqfBf5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707132852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/SxzjtBf487sMzoXkTo79HeTFHw6kYb0uZ9SjI1QhA=;
	b=4hfbs10r0RNUuNudNYnaEV4nGp5Cc7TlxBs/M1B2a7tinE1tu2CGehJdf1sMy0vBpiYjnY
	z5Wxwt1PVqxCDIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68F8136F5;
	Mon,  5 Feb 2024 11:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ZR0MLTHwGVeQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 11:34:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7903EA0809; Mon,  5 Feb 2024 12:34:12 +0100 (CET)
Date: Mon, 5 Feb 2024 12:34:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] writeback: rework the loop termination condition
 in write_cache_pages
Message-ID: <20240205113412.ceemxahic7bpodip@quack3>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203071147.862076-6-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZYJ3k7Ln;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4hfbs10r
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D2A731F8BD
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sat 03-02-24 08:11:39, Christoph Hellwig wrote:
> Rework the way we deal with the cleanup after the writepage call.
> 
> First handle the magic AOP_WRITEPAGE_ACTIVATE separately from real error
> returns to get it out of the way of the actual error handling path.
> 
> The split the handling on intgrity vs non-integrity branches first,
> and return early using a goto for the non-ingegrity early loop condition
> to remove the need for the done and done_index local variables, and for
> assigning the error to ret when we can just return error directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 84 ++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 51 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c7c494526bc650..88b2c4c111c01b 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2396,13 +2396,12 @@ int write_cache_pages(struct address_space *mapping,
>  		      void *data)
>  {
>  	int ret = 0;
> -	int done = 0;
>  	int error;
>  	struct folio_batch fbatch;
> +	struct folio *folio;
>  	int nr_folios;
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
> -	pgoff_t done_index;
>  	xa_mark_t tag;
>  
>  	folio_batch_init(&fbatch);
> @@ -2419,8 +2418,7 @@ int write_cache_pages(struct address_space *mapping,
>  	} else {
>  		tag = PAGECACHE_TAG_DIRTY;
>  	}
> -	done_index = index;
> -	while (!done && (index <= end)) {
> +	while (index <= end) {
>  		int i;
>  
>  		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> @@ -2430,11 +2428,7 @@ int write_cache_pages(struct address_space *mapping,
>  			break;
>  
>  		for (i = 0; i < nr_folios; i++) {
> -			struct folio *folio = fbatch.folios[i];
> -			unsigned long nr;
> -
> -			done_index = folio->index;
> -
> +			folio = fbatch.folios[i];
>  			folio_lock(folio);
>  
>  			/*
> @@ -2469,45 +2463,32 @@ int write_cache_pages(struct address_space *mapping,
>  
>  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  			error = writepage(folio, wbc, data);
> -			nr = folio_nr_pages(folio);
> -			wbc->nr_to_write -= nr;
> -			if (unlikely(error)) {
> -				/*
> -				 * Handle errors according to the type of
> -				 * writeback. There's no need to continue for
> -				 * background writeback. Just push done_index
> -				 * past this page so media errors won't choke
> -				 * writeout for the entire file. For integrity
> -				 * writeback, we must process the entire dirty
> -				 * set regardless of errors because the fs may
> -				 * still have state to clear for each page. In
> -				 * that case we continue processing and return
> -				 * the first error.
> -				 */
> -				if (error == AOP_WRITEPAGE_ACTIVATE) {
> -					folio_unlock(folio);
> -					error = 0;
> -				} else if (wbc->sync_mode != WB_SYNC_ALL) {
> -					ret = error;
> -					done_index = folio->index + nr;
> -					done = 1;
> -					break;
> -				}
> -				if (!ret)
> -					ret = error;
> +			wbc->nr_to_write -= folio_nr_pages(folio);
> +
> +			if (error == AOP_WRITEPAGE_ACTIVATE) {
> +				folio_unlock(folio);
> +				error = 0;
>  			}
>  
>  			/*
> -			 * We stop writing back only if we are not doing
> -			 * integrity sync. In case of integrity sync we have to
> -			 * keep going until we have written all the pages
> -			 * we tagged for writeback prior to entering this loop.
> +			 * For integrity writeback we have to keep going until
> +			 * we have written all the folios we tagged for
> +			 * writeback above, even if we run past wbc->nr_to_write
> +			 * or encounter errors.
> +			 * We stash away the first error we encounter in
> +			 * wbc->saved_err so that it can be retrieved when we're
> +			 * done.  This is because the file system may still have
> +			 * state to clear for each folio.
> +			 *
> +			 * For background writeback we exit as soon as we run
> +			 * past wbc->nr_to_write or encounter the first error.
>  			 */
> -			done_index = folio->index + nr;
> -			if (wbc->nr_to_write <= 0 &&
> -			    wbc->sync_mode == WB_SYNC_NONE) {
> -				done = 1;
> -				break;
> +			if (wbc->sync_mode == WB_SYNC_ALL) {
> +				if (error && !ret)
> +					ret = error;
> +			} else {
> +				if (error || wbc->nr_to_write <= 0)
> +					goto done;
>  			}
>  		}
>  		folio_batch_release(&fbatch);
> @@ -2524,14 +2505,15 @@ int write_cache_pages(struct address_space *mapping,
>  	 * of the file if we are called again, which can only happen due to
>  	 * -ENOMEM from the file system.
>  	 */
> -	if (wbc->range_cyclic) {
> -		if (done)
> -			mapping->writeback_index = done_index;
> -		else
> -			mapping->writeback_index = 0;
> -	}
> -
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = 0;
>  	return ret;
> +
> +done:
> +	folio_batch_release(&fbatch);
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = folio->index + folio_nr_pages(folio);
> +	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

