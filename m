Return-Path: <linux-fsdevel+bounces-48040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D914AA901E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4411706C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D951F4289;
	Mon,  5 May 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o8okGg/+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4S5rgwGK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o8okGg/+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4S5rgwGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73E224CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438783; cv=none; b=XvYa+qjZabYUyC7ZD1Xb8Y5WDS8Xo99Y1Te6oElgr0SK5ryleQOV84TV1tvlVgywEDr8UwhwIQ7R3viv6HQCyqT4yJFuE+8rffNjjsSc4JG+wExyMcXFGXj48vjkxQAAceBjgRMQTSUrNzQzh1b1vr3JOcRcdQP6IovyyyD/5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438783; c=relaxed/simple;
	bh=7IGzS+H+A2oF7/uxD2o3fmpAzjodB53pZyU4CAmfVkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7FyFHrK6OtsoWrNHut2+E2o4t35v9HRJ1axRQhX4OG/8wB5TcCLXqRdKYncE3g6hJoP9BBB0Pk4pkTsn5T5uLhPSaJ0RwBQxQjHjM9Ro5S+KpEUMIPfckTXVV74NjUNqrw03Vu62eeCmGP3YORexrjaagJt8gV4D1Ip2tt7db8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o8okGg/+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4S5rgwGK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o8okGg/+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4S5rgwGK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A797921284;
	Mon,  5 May 2025 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746438779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utEcYmPzi75tBBr1KPTD9Ao4NpHZqIdSmjTjxwEplbw=;
	b=o8okGg/+K3DCf5QTCTgixqzxYorI5hidAenUdxMQbnDCNtHUgy8r/ACuLvIGe1sb03HfZh
	zC6Hw2zzPr4X9XIR328qCUUznNVDjD7O8hT7DYcmqR3lWoRvd0xuh6teQuLyIUgruYIJNJ
	kA+bHdYTgLzzf2qVSDSodR20pNtGNNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746438779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utEcYmPzi75tBBr1KPTD9Ao4NpHZqIdSmjTjxwEplbw=;
	b=4S5rgwGKNxA3QOK7Vy+0cJvPP0kfdam9XhEFGYx3+SjKnw9GScOHiiVALf5mzxWRbLeSip
	bU/JhR5mHqu/aJCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o8okGg/+";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4S5rgwGK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746438779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utEcYmPzi75tBBr1KPTD9Ao4NpHZqIdSmjTjxwEplbw=;
	b=o8okGg/+K3DCf5QTCTgixqzxYorI5hidAenUdxMQbnDCNtHUgy8r/ACuLvIGe1sb03HfZh
	zC6Hw2zzPr4X9XIR328qCUUznNVDjD7O8hT7DYcmqR3lWoRvd0xuh6teQuLyIUgruYIJNJ
	kA+bHdYTgLzzf2qVSDSodR20pNtGNNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746438779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utEcYmPzi75tBBr1KPTD9Ao4NpHZqIdSmjTjxwEplbw=;
	b=4S5rgwGKNxA3QOK7Vy+0cJvPP0kfdam9XhEFGYx3+SjKnw9GScOHiiVALf5mzxWRbLeSip
	bU/JhR5mHqu/aJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92FDF13883;
	Mon,  5 May 2025 09:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9kzfI3uKGGjPcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 09:52:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5668AA0670; Mon,  5 May 2025 11:52:55 +0200 (CEST)
Date: Mon, 5 May 2025 11:52:55 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 4/5] mm/readahead: Store folio order in struct
 file_ra_state
Message-ID: <hsh7gqrzzxmgihjnud6p6iqbysustua3rv7vkfgknz4vho4hhx@jvzfztjk4cc4>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-5-ryan.roberts@arm.com>
X-Rspamd-Queue-Id: A797921284
X-Spam-Score: -4.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 15:59:17, Ryan Roberts wrote:
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

...

> @@ -469,6 +469,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
>  	unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
> +	unsigned int new_order = ra->order;
>  
>  	/*
>  	 * Fallback when size < min_nrpages as each folio should be
> @@ -483,6 +484,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
>  
> +	ra->order = new_order;
> +
>  	/* See comment in page_cache_ra_unbounded() */
>  	nofs = memalloc_nofs_save();
>  	filemap_invalidate_lock_shared(mapping);
> @@ -525,6 +528,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	 * ->readahead() may have updated readahead window size so we have to
>  	 * check there's still something to read.
>  	 */
> +	ra->order = 0;

Hum, so you reset desired folio order if readahead hit some pre-existing
pages in the page cache. Is this really desirable? Why not leave the
desired order as it was for the next request?

>  	if (ra->size > index - start)
>  		do_page_cache_ra(ractl, ra->size - (index - start),
>  				 ra->async_size);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

