Return-Path: <linux-fsdevel+bounces-6190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D9B814A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CF71F26809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61FA3032D;
	Fri, 15 Dec 2023 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0mcWyis";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZQHWaS2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0mcWyis";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZQHWaS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC830331;
	Fri, 15 Dec 2023 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 869A51F837;
	Fri, 15 Dec 2023 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702649791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyTCFcaBhr8n3TgugW3kFxWX67Uddaa/DXLnxQwKgFw=;
	b=a0mcWyisO6oSDqgiEYEN99ZUt2djbMmRTgp2mB2ypjTWYxyUWstA9KdRAi18LcXGtDEvfd
	3XN74BayKsu7MMLf1848JRe2hdaoowSenY08l8ZIY0IKHmaXSG4ZAP7RHQKpPB3dtWkXJh
	+kLsWMZpFtfMRJah8UpJvLSkp1iz8oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702649791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyTCFcaBhr8n3TgugW3kFxWX67Uddaa/DXLnxQwKgFw=;
	b=RZQHWaS2UNz88Bo5fCF0D/vj1Cv6VObgJ4HWkOz2fdROGvaea1VdZcofzfNs5PZ9zBuiyM
	/jOYiGmrUKB7hKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702649791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyTCFcaBhr8n3TgugW3kFxWX67Uddaa/DXLnxQwKgFw=;
	b=a0mcWyisO6oSDqgiEYEN99ZUt2djbMmRTgp2mB2ypjTWYxyUWstA9KdRAi18LcXGtDEvfd
	3XN74BayKsu7MMLf1848JRe2hdaoowSenY08l8ZIY0IKHmaXSG4ZAP7RHQKpPB3dtWkXJh
	+kLsWMZpFtfMRJah8UpJvLSkp1iz8oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702649791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyTCFcaBhr8n3TgugW3kFxWX67Uddaa/DXLnxQwKgFw=;
	b=RZQHWaS2UNz88Bo5fCF0D/vj1Cv6VObgJ4HWkOz2fdROGvaea1VdZcofzfNs5PZ9zBuiyM
	/jOYiGmrUKB7hKDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7832213A08;
	Fri, 15 Dec 2023 14:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oSxYHb9ffGXsaAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 14:16:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EBCEA07E0; Fri, 15 Dec 2023 15:16:31 +0100 (CET)
Date: Fri, 15 Dec 2023 15:16:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/11] writeback: Factor should_writeback_folio() out of
 write_cache_pages()
Message-ID: <20231215141631.aooan5rby6fwfdof@quack3>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-4-hch@lst.de>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a0mcWyis;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RZQHWaS2
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 869A51F837

On Thu 14-12-23 14:25:36, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Reduce write_cache_pages() by about 30 lines; much of it is commentary,
> but it all bundles nicely into an obvious function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I like this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 59 ++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 5d33e7b468e2cc..5a3df8665ff4f9 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2394,6 +2394,36 @@ static void writeback_get_batch(struct address_space *mapping,
>  			&wbc->fbatch);
>  }
>  
> +static bool should_writeback_folio(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio)
> +{
> +	/*
> +	 * Folio truncated or invalidated. We can freely skip it then,
> +	 * even for data integrity operations: the folio has disappeared
> +	 * concurrently, so there could be no real expectation of this
> +	 * data integrity operation even if there is now a new, dirty
> +	 * folio at the same pagecache index.
> +	 */
> +	if (unlikely(folio->mapping != mapping))
> +		return false;
> +
> +	/* Did somebody write it for us? */
> +	if (!folio_test_dirty(folio))
> +		return false;
> +
> +	if (folio_test_writeback(folio)) {
> +		if (wbc->sync_mode == WB_SYNC_NONE)
> +			return false;
> +		folio_wait_writeback(folio);
> +	}
> +
> +	BUG_ON(folio_test_writeback(folio));
> +	if (!folio_clear_dirty_for_io(folio))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
>   * @mapping: address space structure to write
> @@ -2462,38 +2492,13 @@ int write_cache_pages(struct address_space *mapping,
>  			wbc->done_index = folio->index;
>  
>  			folio_lock(folio);
> -
> -			/*
> -			 * Page truncated or invalidated. We can freely skip it
> -			 * then, even for data integrity operations: the page
> -			 * has disappeared concurrently, so there could be no
> -			 * real expectation of this data integrity operation
> -			 * even if there is now a new, dirty page at the same
> -			 * pagecache address.
> -			 */
> -			if (unlikely(folio->mapping != mapping)) {
> -continue_unlock:
> +			if (!should_writeback_folio(mapping, wbc, folio)) {
>  				folio_unlock(folio);
>  				continue;
>  			}
>  
> -			if (!folio_test_dirty(folio)) {
> -				/* someone wrote it for us */
> -				goto continue_unlock;
> -			}
> -
> -			if (folio_test_writeback(folio)) {
> -				if (wbc->sync_mode != WB_SYNC_NONE)
> -					folio_wait_writeback(folio);
> -				else
> -					goto continue_unlock;
> -			}
> -
> -			BUG_ON(folio_test_writeback(folio));
> -			if (!folio_clear_dirty_for_io(folio))
> -				goto continue_unlock;
> -
>  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> +
>  			error = writepage(folio, wbc, data);
>  			nr = folio_nr_pages(folio);
>  			if (unlikely(error)) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

