Return-Path: <linux-fsdevel+bounces-48029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B12AA8E81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F39B173367
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B41F4262;
	Mon,  5 May 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AM8EToKs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRT7Pp8w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STeDkduy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+AQHZoO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C1E5218
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434966; cv=none; b=PUwbxaxT7WSL0je9goX4jFsbHo8FUyC3hwvc4goU20GvKvv1OffNl+MikTZ2UyQccF7avW4tvPk2SIRNPPoKgQ2JUfskvB3DjfI5vIn6Y7Bu88tA5lJmsbVdK9SqF5eaH+pmpDT95EYkkNRzPQYuP0rV30sY8hpOBxF0LcQ2VkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434966; c=relaxed/simple;
	bh=NAeqC6/FYx8dC3TIuDYKeAURUGJiVLt/sVt2OOlgU40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw+wMb2XRdrjmD8eR/5yjBN1A9tTn0VJcQnQo4cpmOJusc0BYid/OCKKufbJd3g1nlSgVIbwoGLCceKo6Vyp2jJ5b2ep0zP5U3U/Oj8k+2ZQBoECOHKW9q+ViTJBhwRVBj8v6x2nvNMYbU3HP6znm/P7JeN0lohYjgtgSfFShdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AM8EToKs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRT7Pp8w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STeDkduy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+AQHZoO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC12221291;
	Mon,  5 May 2025 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746434963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FY/d0FTareElI5ojAGucw4B8fFGBumNl/AF4B3106Qc=;
	b=AM8EToKsH0MwK9Vt1LrWdXyWBDZS8IqBXLg/EwWaARxncsS0xGLhXAZQflp+mmkxT1z9Zr
	Iv82u4zgSvJ59Ynay4f2IU6FxexEY3pVfB8POcJcNS6aFqUw4OsgYBqQbXBN9xAMLsTeoL
	7p6Lmb75pMH2kt5t8bvJIRrgSO5E/Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746434963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FY/d0FTareElI5ojAGucw4B8fFGBumNl/AF4B3106Qc=;
	b=LRT7Pp8wsk3ajIbZ9ALH3p2tfITHVg8Ta2uPe+jSR3SNyGGjPXwXAIlWfDySSaiqFC9qmQ
	WvuIJNKZ5Nqiy9Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746434962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FY/d0FTareElI5ojAGucw4B8fFGBumNl/AF4B3106Qc=;
	b=STeDkduyhkyQ263oplCmstFe759d0Q+npT/2tCbyNWrkEij9rYKPCHoN25HljYaqFHFeNE
	InIKCGU37rB05gbQvX4YvvrYJMybkJnA70qzLI5eb77Caae4PtfWYO8GB5i/5TYpFpels5
	ojZUrmUyXkS/O0I2np597bfFvGqAwMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746434962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FY/d0FTareElI5ojAGucw4B8fFGBumNl/AF4B3106Qc=;
	b=k+AQHZoONj1yHOhQ0/GlEmqBxEPoihlaQucbermViajGEmDN7PKyEt2+xclYaT45C6X+so
	blbaqKuTs5QsxWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFE21372E;
	Mon,  5 May 2025 08:49:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V2BxNZJ7GGjYYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 08:49:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A0C0A082A; Mon,  5 May 2025 10:49:22 +0200 (CEST)
Date: Mon, 5 May 2025 10:49:22 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
Message-ID: <r6yekqlahpit3tniwqw4bmjd5htelqsyg2vjotnmqb622u424t@bfpzbdwli37p>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-2-ryan.roberts@arm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,arm.com:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,arm.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 30-04-25 15:59:14, Ryan Roberts wrote:
> page_cache_ra_order() takes a parameter called new_order, which is
> intended to express the preferred order of the folios that will be
> allocated for the readahead operation. Most callers indeed call this
> with their preferred new order. But page_cache_async_ra() calls it with
> the preferred order of the previous readahead request (actually the
> order of the folio that had the readahead marker, which may be smaller
> when alignment comes into play).
> 
> And despite the parameter name, page_cache_ra_order() always treats it
> at the old order, adding 2 to it on entry. As a result, a cold readahead
> always starts with order-2 folios.
> 
> Let's fix this behaviour by always passing in the *new* order.
> 
> Worked example:
> 
> Prior to the change, mmaping an 8MB file and touching each page
> sequentially, resulted in the following, where we start with order-2
> folios for the first 128K then ramp up to order-4 for the next 128K,
> then get clamped to order-5 for the rest of the file because pa_pages is
> limited to 128K:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00004000      16384        0        4      4      2
> FOLIO  0x00004000  0x00008000      16384        4        8      4      2
> FOLIO  0x00008000  0x0000c000      16384        8       12      4      2
> FOLIO  0x0000c000  0x00010000      16384       12       16      4      2
> FOLIO  0x00010000  0x00014000      16384       16       20      4      2
> FOLIO  0x00014000  0x00018000      16384       20       24      4      2
> FOLIO  0x00018000  0x0001c000      16384       24       28      4      2
> FOLIO  0x0001c000  0x00020000      16384       28       32      4      2
> FOLIO  0x00020000  0x00030000      65536       32       48     16      4
> FOLIO  0x00030000  0x00040000      65536       48       64     16      4
> FOLIO  0x00040000  0x00060000     131072       64       96     32      5
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
> ...
> 
> After the change, the same operation results in the first 128K being
> order-0, then we start ramping up to order-2, -4, and finally get
> clamped at order-5:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00001000       4096        0        1      1      0
> FOLIO  0x00001000  0x00002000       4096        1        2      1      0
> FOLIO  0x00002000  0x00003000       4096        2        3      1      0
> FOLIO  0x00003000  0x00004000       4096        3        4      1      0
> FOLIO  0x00004000  0x00005000       4096        4        5      1      0
> FOLIO  0x00005000  0x00006000       4096        5        6      1      0
> FOLIO  0x00006000  0x00007000       4096        6        7      1      0
> FOLIO  0x00007000  0x00008000       4096        7        8      1      0
> FOLIO  0x00008000  0x00009000       4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000       4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000       4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000       4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000       4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000       4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000       4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000       4096       15       16      1      0
> FOLIO  0x00010000  0x00011000       4096       16       17      1      0
> FOLIO  0x00011000  0x00012000       4096       17       18      1      0
> FOLIO  0x00012000  0x00013000       4096       18       19      1      0
> FOLIO  0x00013000  0x00014000       4096       19       20      1      0
> FOLIO  0x00014000  0x00015000       4096       20       21      1      0
> FOLIO  0x00015000  0x00016000       4096       21       22      1      0
> FOLIO  0x00016000  0x00017000       4096       22       23      1      0
> FOLIO  0x00017000  0x00018000       4096       23       24      1      0
> FOLIO  0x00018000  0x00019000       4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000       4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
> FOLIO  0x00030000  0x00034000      16384       48       52      4      2
> FOLIO  0x00034000  0x00038000      16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000      16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000      16384       60       64      4      2
> FOLIO  0x00040000  0x00050000      65536       64       80     16      4
> FOLIO  0x00050000  0x00060000      65536       80       96     16      4
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000     131072      192      224     32      5
> ...
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Makes sense and looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/readahead.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a4e96b69702..8bb316f5a842 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < mapping_max_folio_order(mapping))
> -		new_order += 2;
> -
>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
> @@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	ra->size = get_next_ra_size(ra, max_pages);
>  	ra->async_size = ra->size;
>  readit:
> +	order += 2;
>  	ractl->_index = ra->start;
>  	page_cache_ra_order(ractl, ra, order);
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

