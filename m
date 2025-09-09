Return-Path: <linux-fsdevel+bounces-60677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0CB4FFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519461C61246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15A2505AA;
	Tue,  9 Sep 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsAdqhMJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkTT70q4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsAdqhMJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkTT70q4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CF18A921
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429279; cv=none; b=ozz/iPoD707ZVjtN27/nVXGqpYoXr91Jbl1tiD4uek6Q65JvcMD3KgmgFyOaKjsZT/ZA5ozsz3n+BwZCFZLCXrRlIc7B3Oi4DFOitjLm9pilRknjlSoZ+bugi8tFEqhwcSlH336zMBk0nyY2eO86vLg0bcu1hsJ6/7RLjnG9zOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429279; c=relaxed/simple;
	bh=GCFc3dUJtj6syLVXnzeM88/P0C4otXHQAbqmiAnoKxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuvTnPpmzp08sSuDeK7ePY6iitjF8U/FVptGKKmHbDyxIGfKunyDuflLj/OHqeyG46bS5mnRbvzYrzcyKLEVxMVOKN+8a8TLtDshABlabFRaWapiNDai8WH+4q7lwBEyKFfdVLkJxR9ezAuQF5ne7gBiGt5R5Jdy9Q4LeF3s27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsAdqhMJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkTT70q4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsAdqhMJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkTT70q4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2548A1FF95;
	Tue,  9 Sep 2025 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMjuisp9t8XFgyyrcRhHqDOoH4i/8GEPNGid6fl7m38=;
	b=NsAdqhMJgY6c2vxy3ehQ+20TZisYYRx4aqpgzKppHNExNtYyEsj2w9qeo6xOx7HJKMNhz2
	Tzr7yGacyhHjttRdjHruJeqs2sx0JkBDCvUGEEYvSorDYpDpVFskhAG6CBWIj0sPu7DN6y
	WxJzY17FYkLGZqXJICJl7fpk41yUTQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMjuisp9t8XFgyyrcRhHqDOoH4i/8GEPNGid6fl7m38=;
	b=FkTT70q4tlbkJb2uMcd9/3OtBm7qIelJM3FeQG9er9j1YzCRHJOX/Y3bYmgY/+hcLN6+yd
	X/8eCTRADvL/SRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMjuisp9t8XFgyyrcRhHqDOoH4i/8GEPNGid6fl7m38=;
	b=NsAdqhMJgY6c2vxy3ehQ+20TZisYYRx4aqpgzKppHNExNtYyEsj2w9qeo6xOx7HJKMNhz2
	Tzr7yGacyhHjttRdjHruJeqs2sx0JkBDCvUGEEYvSorDYpDpVFskhAG6CBWIj0sPu7DN6y
	WxJzY17FYkLGZqXJICJl7fpk41yUTQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMjuisp9t8XFgyyrcRhHqDOoH4i/8GEPNGid6fl7m38=;
	b=FkTT70q4tlbkJb2uMcd9/3OtBm7qIelJM3FeQG9er9j1YzCRHJOX/Y3bYmgY/+hcLN6+yd
	X/8eCTRADvL/SRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AFA71388C;
	Tue,  9 Sep 2025 14:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eDyFBhw+wGjdeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:47:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6303A0A2D; Tue,  9 Sep 2025 16:47:55 +0200 (CEST)
Date: Tue, 9 Sep 2025 16:47:55 +0200
From: Jan Kara <jack@suse.cz>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] readahead: Add trace points
Message-ID: <2qebht2w4jvxm23kcdzyp645mdxf4xbivrant5inao5742en74@lrepdbs24jow>
References: <20250908145533.31528-2-jack@suse.cz>
 <iruyokxvyziqzq3qrcorpx6mq2pshs6beyvgsokqlcz7loane2@y4bdrxzzitwa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iruyokxvyziqzq3qrcorpx6mq2pshs6beyvgsokqlcz7loane2@y4bdrxzzitwa>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 09-09-25 14:41:33, Pankaj Raghav (Samsung) wrote:
> On Mon, Sep 08, 2025 at 04:55:34PM +0200, Jan Kara wrote:
> >  
> >  /*
> > @@ -314,6 +317,7 @@ static void do_page_cache_ra(struct readahead_control *ractl,
> >  	loff_t isize = i_size_read(inode);
> >  	pgoff_t end_index;	/* The last page we want to read */
> >  
> > +	trace_do_page_cache_ra(inode, index, nr_to_read, lookahead_size);
> 
> Any reason why put a probe here instead of page_cache_ra_unbounded as
> that is where the actual readahead happens?

Hum, no. Originally I had it in force_page_cache_ra() but then I've decided
do_page_cache_ra() is better because it captures also other places issuing
non-standard readahead. But you're right that placing the tracepoint in
page_cache_ra_unbounded() will achieve that as well and will be a more
standard place. I'll respin the patch. Thanks for suggestion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

