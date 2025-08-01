Return-Path: <linux-fsdevel+bounces-56525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D85B1864E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B5F56161A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5051E25EF;
	Fri,  1 Aug 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTvMd8fP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8rG1Y2T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTvMd8fP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8rG1Y2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C621E22E6
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068053; cv=none; b=cmhirJHO1a8eLw5UFugIrZa2zWIyWX1kMCdaNDc00pHG//FpXV16h8SkR0asgLbuyD6D9oPwDevrn0q91VmzqIYYF70EHB//QYch/nbBWav40D2p1m3Fp4TmgEa8S3XhJUdoQ+qpFS/VzCOUuBXjVT6KChw1CVrCgzLJfjCuM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068053; c=relaxed/simple;
	bh=cohJcfQcrYxn8Gw3YK3VyWdNBd4ZK3emMkpp+5IBJVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onRsz9OvjUpPW2R+tqxMpdwplTmqIGPIGOnWCLGnQVEjOOOk8UgKQ+RztZl4fsEXbN1pRUCGEy4cZzFh5I+uHmtxUzj54araCTWbBgSiE9Fb8eJZlyxvFNftccMsIFaht+zjKZzuYgkQwewAVGNsNxETogz0Uso7jO9RPW86YVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTvMd8fP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8rG1Y2T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTvMd8fP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8rG1Y2T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28BF61F807;
	Fri,  1 Aug 2025 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754068049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIn07FzSOON6Sss2YzS5j+2jnVsbdr3lR+vtWJREsnc=;
	b=dTvMd8fPb8gGc6GhZknZCTjPtDcLg3ghKhGpoUh4JrdKviglDTsyYpzv/Y5UyiAjDZKO8X
	lW1HIODrh4itndKGaG7oM33oEC+nfhcmCXasa0PF4/nxs3j20Iz2uaQyt33nP1fJxf8u8c
	0+6W5BfWPvnRrrICYtGX8wOOXQzWNjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754068049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIn07FzSOON6Sss2YzS5j+2jnVsbdr3lR+vtWJREsnc=;
	b=G8rG1Y2TTTfn3/O5bnuG6GmLI9tQj+vFm46NVWyAtcipq5grjegc02U5LSzbty18tkePWX
	cIpN0KuRoFuKn3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754068049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIn07FzSOON6Sss2YzS5j+2jnVsbdr3lR+vtWJREsnc=;
	b=dTvMd8fPb8gGc6GhZknZCTjPtDcLg3ghKhGpoUh4JrdKviglDTsyYpzv/Y5UyiAjDZKO8X
	lW1HIODrh4itndKGaG7oM33oEC+nfhcmCXasa0PF4/nxs3j20Iz2uaQyt33nP1fJxf8u8c
	0+6W5BfWPvnRrrICYtGX8wOOXQzWNjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754068049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIn07FzSOON6Sss2YzS5j+2jnVsbdr3lR+vtWJREsnc=;
	b=G8rG1Y2TTTfn3/O5bnuG6GmLI9tQj+vFm46NVWyAtcipq5grjegc02U5LSzbty18tkePWX
	cIpN0KuRoFuKn3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1414B13876;
	Fri,  1 Aug 2025 17:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAChBFH0jGjxTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Aug 2025 17:07:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65535A09FB; Fri,  1 Aug 2025 19:07:28 +0200 (CEST)
Date: Fri, 1 Aug 2025 19:07:28 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, 
	jack@suse.cz, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v1 05/10] mm: add filemap_dirty_folio_pages() helper
Message-ID: <ghghf7cynwbmthtozlthggdscnmgvkmnq6s3gkcl4qp2zxubee@azmf2dxubund>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-6-joannelkoong@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 31-07-25 17:21:26, Joanne Koong wrote:
> Add filemap_dirty_folio_pages() which takes in the number of pages to dirty.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
...
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b0ae10a6687d..a3805988f3ad 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2732,7 +2732,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>   * try_to_free_buffers() to fail.
>   */
>  void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
> -			     int warn, long nr_pages)
> +			     int warn, long nr_pages, bool newly_dirty)
>  {
>  	unsigned long flags;
>  
> @@ -2740,12 +2740,29 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
>  	if (folio->mapping) {	/* Race with truncate? */
>  		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
>  		folio_account_dirtied(folio, mapping, nr_pages);
> -		__xa_set_mark(&mapping->i_pages, folio_index(folio),
> -				PAGECACHE_TAG_DIRTY);
> +		if (newly_dirty)
> +			__xa_set_mark(&mapping->i_pages, folio_index(folio),
> +					PAGECACHE_TAG_DIRTY);
>  	}
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);

I think this is a dangerous coding pattern. What is making sure that by the
time you get here newly_dirty is still valid? I mean the dirtying can race
e.g. with writeback and so it can happen that the page is clean by the time
we get here but newly_dirty is false. We are often protected by page lock
when dirtying a folio but not always... So if nothing else this requires a
careful documentation about correct use.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

