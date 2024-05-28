Return-Path: <linux-fsdevel+bounces-20332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537688D1865
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D031F23EEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CC16A39E;
	Tue, 28 May 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZdJK/WJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XnYitsrG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0gXaoKLd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uNCD0nT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2D17C7F;
	Tue, 28 May 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891646; cv=none; b=jJdggJzTKrX4NvAaWDjwUnoRfxknvaxIF4pCx6RPXt9l/0b60mCf2imjiw3QwAfqz/HnoMhbr5Fs5x4NUEcOKmiI118eAseZ32K0fHmF8I/wPZahmxS0JpHpxHIzy/CWGwpexP5YnhorgvIbv66I2Q9I8kXKtItYqTtiJ28/odU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891646; c=relaxed/simple;
	bh=1ABfCWn4+79GUVPys3lwmqiobbkRVoHuP01O/CWZluY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDsPt2qVy/d45b3kQo64RnEjW6ghSc5l3zYpUUlLevV1/UxYSIHR429Zx4scg4RLVvMv1N+xAvQm7iipHoRzBWX/05Xtv3px1VoZoYmZJcJtnCENyBIP20xRMClmpyxegbV9oEEXfEBxM4FtWPZAbNLS87Ro3d9bfnwsKpZCOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZdJK/WJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XnYitsrG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0gXaoKLd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uNCD0nT1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC71A21F4C;
	Tue, 28 May 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716891643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF7PC65/Wxvqm7PDuhbYG43Mw/LteX4wRnY8H+kpTw4=;
	b=ZdJK/WJSpXcfvUt0kpyNWmINdEif0Fr478qdCL1v1GIOG62PwQ5vHfl24GGdssilDzV/Lk
	1vSnCLrILzbJiOotPBiWm5F//PEOXUSYth/BWcbmcbiIE/LAnfUtQwR30OM7cBLcmptHwx
	kMKFuQ/Qw2NTGFuyQH+EcigFZ496hYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716891643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF7PC65/Wxvqm7PDuhbYG43Mw/LteX4wRnY8H+kpTw4=;
	b=XnYitsrGa/X9LuBEbrJE+PuGz5zrCERrg6/pvdKXpDJ8YEm6/UKx7GZRbgINWxyf3hYPgQ
	luo+rSfVTrdNprBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716891642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF7PC65/Wxvqm7PDuhbYG43Mw/LteX4wRnY8H+kpTw4=;
	b=0gXaoKLdzVWsVhHZwyAFekXJ4Y+Y+Vx4BYr/OzQkJlU+O84hqXijJbgdeCqUyTYthIZdTd
	wAD3RDQsusVyYOAG4fuiwLMbFEd5Ww9Ye7Z6PRW+YgF6LsmKmKyOYJsY+ZP68N4KfhSNh8
	hICNyC5Pc3OUAA4WX2uz39qd54rdrMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716891642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF7PC65/Wxvqm7PDuhbYG43Mw/LteX4wRnY8H+kpTw4=;
	b=uNCD0nT1sE8t+O1QCtfERGEDDDbGLorLqe/XZMBMdES1dOGxR3w5oj0m0TmzCpQXCNcTvc
	10kld8GBrUc7o4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 786D613A6B;
	Tue, 28 May 2024 10:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a8mLG/qvVWZ3DQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 28 May 2024 10:20:42 +0000
Message-ID: <e732a6ea-ade2-4398-b1ac-9e552fd365f5@suse.de>
Date: Tue, 28 May 2024 12:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandan.babu@oracle.com
Cc: ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, kernel@pankajraghav.com, mcgrof@kernel.org
References: <20240527210125.1905586-1-willy@infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240527210125.1905586-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,nvidia.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On 5/27/24 23:01, Matthew Wilcox (Oracle) wrote:
> We need filesystems to be able to communicate acceptable folio sizes
> to the pagecache for a variety of uses (e.g. large block sizes).
> Support a range of folio sizes between order-0 and order-31.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> For this version, I fixed the TODO that the maximum folio size was not
> being honoured.  I made some other changes too like adding const, moving
> the location of the constants, checking CONFIG_TRANSPARENT_HUGEPAGE, and
> dropping some of the functions which aren't needed until later patches.
> (They can be added in the commits that need them).  Also rebased against
> current Linus tree, so MAX_PAGECACHE_ORDER no longer needs to be moved).
> 
>   include/linux/pagemap.h | 81 +++++++++++++++++++++++++++++++++++------
>   mm/filemap.c            |  6 +--
>   mm/readahead.c          |  4 +-
>   3 files changed, 73 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1ed9274a0deb..c6aaceed0de6 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,13 +204,18 @@ enum mapping_flags {
>   	AS_EXITING	= 4, 	/* final truncate in progress */
>   	/* writeback related tags are not used */
>   	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>   				   folio contents */
> -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> +	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
> +	AS_FOLIO_ORDER_MIN = 16,
> +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
>   };
>   
> +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>   /**
>    * mapping_set_error - record a writeback error in the address_space
>    * @mapping: the mapping in which an error should be set
> @@ -359,9 +364,48 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   #define MAX_PAGECACHE_ORDER	8
>   #endif
>   
> +/*
> + * mapping_set_folio_order_range() - Set the orders supported by a file.
> + * @mapping: The address space of the file.
> + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which base size (min) and maximum size (max) of folio the VFS
> + * can use to cache the contents of the file.  This should only be used
> + * if the filesystem needs special handling of folio sizes (ie there is
> + * something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> +		unsigned int min, unsigned int max)
> +{
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return;
> +
Errm. Sure? When transparent hugepages are _enabled_ we don't support 
this feature?
Confused.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


