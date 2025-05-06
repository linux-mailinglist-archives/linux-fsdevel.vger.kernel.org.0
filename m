Return-Path: <linux-fsdevel+bounces-48226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E4AAC2A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298ED1C283FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5727AC20;
	Tue,  6 May 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yH7gPjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gh6bh0xG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yH7gPjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gh6bh0xG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3027A11D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530961; cv=none; b=flxykQfiRmKqYJxdxIdgLcc6EbvJOqqg83Psq8OqSX6ULkVeLamLyNxG9QXEPQvNktl14Qty1OakooKNEHutrl9dFaSoVirjwC3h7ml/d4JfgqNUDh03oS1wShjIurxV8CyFIKGon189YmUIvyJ5UxtC7eI6NIpyBzrNdJLHTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530961; c=relaxed/simple;
	bh=UCiRwoKCczKQelZQIZ7Oqlla4xs6gcm381bkG1CRt7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzUy1G0Af3kEQeQUi35e+3PAU8sPQH/ab5zc2bXg0o4VQhxMMcfN5lXhRjI0Xr/O7XYaaI5kYGcSQmqUgb60e1+U28LFqNwCJ7DQWA+dX9b90IaGXRAC1pxBddXbWvv9kh/CQIaUkGSdpy5R/lBdICEeBJ/l+dBqJ+RftOAx4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yH7gPjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gh6bh0xG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yH7gPjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gh6bh0xG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCA9210F4;
	Tue,  6 May 2025 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746530957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWsIcamJBKCW1LLn+/GWBAN99qwgm/lCnEVszYMLa1k=;
	b=2yH7gPjn31Qn8K+bOhIGJWYkJJqa+IIBWn6zVUY4wdLmUaEXPUxzU+S1G5OryNOqbR1529
	qtljQxahgr9JcoiYAqeIvyGVL6h7kXnTvoWr1njgxJxo1g2k5SSQjbY45vWx0qFaBItZv/
	KLvkx2iq6lcf8oCYggb0yRTllNIDeg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746530957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWsIcamJBKCW1LLn+/GWBAN99qwgm/lCnEVszYMLa1k=;
	b=Gh6bh0xGqiSxLYImzkKJXichdiW+rLDUwEU1yXrflVpRXwUFX0rMWGHa/1fjqtxYlyXJXQ
	tnU5mzZ1KDMLpZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2yH7gPjn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gh6bh0xG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746530957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWsIcamJBKCW1LLn+/GWBAN99qwgm/lCnEVszYMLa1k=;
	b=2yH7gPjn31Qn8K+bOhIGJWYkJJqa+IIBWn6zVUY4wdLmUaEXPUxzU+S1G5OryNOqbR1529
	qtljQxahgr9JcoiYAqeIvyGVL6h7kXnTvoWr1njgxJxo1g2k5SSQjbY45vWx0qFaBItZv/
	KLvkx2iq6lcf8oCYggb0yRTllNIDeg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746530957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWsIcamJBKCW1LLn+/GWBAN99qwgm/lCnEVszYMLa1k=;
	b=Gh6bh0xGqiSxLYImzkKJXichdiW+rLDUwEU1yXrflVpRXwUFX0rMWGHa/1fjqtxYlyXJXQ
	tnU5mzZ1KDMLpZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E19D137CF;
	Tue,  6 May 2025 11:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKGrIo3yGWhSFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 May 2025 11:29:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49933A09BE; Tue,  6 May 2025 13:29:13 +0200 (CEST)
Date: Tue, 6 May 2025 13:29:13 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 2/5] mm/readahead: Terminate async readahead on
 natural boundary
Message-ID: <mq7vno6v7mrrquya4kogseej4fasfyq574ersgdxdhateho7md@bvmy6y4ccgyz>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-3-ryan.roberts@arm.com>
 <3myknukhnrtdb4y5i6ewcgpubg2fopxc35ii6a4oy5ffgn7xdf@uileryotgd7z>
 <67wws7qs5v3poq6sefrrt4dgdn4ejh52mg5x7ycbxqvrfdvow3@zraqczowrvrl>
 <cbfad787-fcb8-43ce-8fd9-e9495116534d@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfad787-fcb8-43ce-8fd9-e9495116534d@arm.com>
X-Rspamd-Queue-Id: 9CCA9210F4
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 06-05-25 10:28:11, Ryan Roberts wrote:
> On 05/05/2025 10:37, Jan Kara wrote:
> > On Mon 05-05-25 11:13:26, Jan Kara wrote:
> >> On Wed 30-04-25 15:59:15, Ryan Roberts wrote:
> >>> Previously asynchonous readahead would read ra_pages (usually 128K)
> >>> directly after the end of the synchonous readahead and given the
> >>> synchronous readahead portion had no alignment guarantees (beyond page
> >>> boundaries) it is possible (and likely) that the end of the initial 128K
> >>> region would not fall on a natural boundary for the folio size being
> >>> used. Therefore smaller folios were used to align down to the required
> >>> boundary, both at the end of the previous readahead block and at the
> >>> start of the new one.
> >>>
> >>> In the worst cases, this can result in never properly ramping up the
> >>> folio size, and instead getting stuck oscillating between order-0, -1
> >>> and -2 folios. The next readahead will try to use folios whose order is
> >>> +2 bigger than the folio that had the readahead marker. But because of
> >>> the alignment requirements, that folio (the first one in the readahead
> >>> block) can end up being order-0 in some cases.
> >>>
> >>> There will be 2 modifications to solve this issue:
> >>>
> >>> 1) Calculate the readahead size so the end is aligned to a folio
> >>>    boundary. This prevents needing to allocate small folios to align
> >>>    down at the end of the window and fixes the oscillation problem.
> >>>
> >>> 2) Remember the "preferred folio order" in the ra state instead of
> >>>    inferring it from the folio with the readahead marker. This solves
> >>>    the slow ramp up problem (discussed in a subsequent patch).
> >>>
> >>> This patch addresses (1) only. A subsequent patch will address (2).
> >>>
> >>> Worked example:
> >>>
> >>> The following shows the previous pathalogical behaviour when the initial
> >>> synchronous readahead is unaligned. We start reading at page 17 in the
> >>> file and read sequentially from there. I'm showing a dump of the pages
> >>> in the page cache just after we read the first page of the folio with
> >>> the readahead marker.
> > 
> > <snip>
> > 
> >> Looks good. When I was reading this code some time ago, I also felt we
> >> should rather do some rounding instead of creating small folios so thanks
> >> for working on this. Feel free to add:
> >>
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > But now I've also remembered why what you do here isn't an obvious win.
> > There are storage devices (mostly RAID arrays) where optimum read size
> > isn't a power of 2. Think for example a RAID-0 device composed from three
> > disks. It will have max_pages something like 384 (512k * 3). Suppose we are
> > on x86 and max_order is 9. Then previously (if we were lucky with
> > alignment) we were alternating between order 7 and order 8 pages in the
> > page cache and do optimally sized IOs od 1536k. 
> 
> Sorry I'm struggling to follow some of this, perhaps my superficial
> understanding of all the readahead subtleties is starting to show...
> 
> How is the 384 figure provided? I'd guess that comes from bdi->io_pages, and
> bdi->ra_pages would remain the usual 32 (128K)?

Sorry, I have been probably too brief in my previous message :)
bdi->ra_pages is actually set based on optimal IO size reported by the
hardware (see blk_apply_bdi_limits() and how its callers are filling in
lim->io_opt). The 128K you speak about is just a last-resort value if
hardware doesn't provide one. And some storage devices do report optimal IO
size that is not power of two.

Also note that bdi->ra_pages can be tuned in sysfs and a lot of users
actually do this (usually from their udev rules). We don't have to perform
well when some odd value gets set but you definitely cannot assume
bdi->ra_pages is 128K :).

> In which case, for mmap, won't
> we continue to be limited by ra_pages and will never get beyond order-5? (for
> mmap req_size is always set to ra_pages IIRC, so ractl_max_pages() always just
> returns ra_pages). Or perhaps ra_pages is set to 384 somewhere, but I'm not
> spotting it in the code...
> 
> I guess you are also implicitly teaching me something about how the block layer
> works here too... if there are 2 read requests for an order-7 and order-8, then
> the block layer will merge those to a single read (upto the 384 optimal size?)

Correct. In fact readahead code will already perform this merging when
submitting the IO.

> but if there are 2 reads of order-8 then it won't merge because it would be
> bigger than the optimal size and it won't split the second one at the optimal
> size either? Have I inferred that correctly?

With the code as you modify it, you would round down ra->size from 384 to
256 and submit only one 1MB sized IO (with one order-8 page). And this will
cause regression in read throughput for such devices because they now don't
get buffer large enough to run at full speed.

> > Now you will allocate all
> > folios of order 8 (nice) but reads will be just 1024k and you'll see
> > noticeable drop in read throughput (not nice). Note that this is not just a
> > theoretical example but a real case we have hit when doing performance
> > testing of servers and for which I was tweaking readahead code in the past.
> > 
> > So I think we need to tweak this logic a bit. Perhaps we should round_down
> > end to the minimum alignment dictated by 'order' and maxpages? Like:
> > 
> > 1 << min(order, ffs(max_pages) + PAGE_SHIFT - 1)
> 
> Sorry I'm staring at this and struggling to understand the "PAGE_SHIFT -
> 1" part?

My bad. It should have been:

1 << min(order, ffs(max_pages) - 1)

> I think what you are suggesting is that the patch becomes something like
> this:
> 
> ---8<---
> +	end = ra->start + ra->size;
> +	aligned_end = round_down(end, 1UL << min(order, ilog2(max_pages)));

Not quite. ilog2() returns the most significant bit set but we really want
to align to the least significant bit set. So when max_pages is 384, we
want to align to at most order-7 (aligning the end more does not make sense
when you want to do IO 384 pages large). That's why I'm using ffs() and not
ilog2().

> +	if (aligned_end > ra->start)
> +		ra->size -= end - aligned_end;
> +	ra->async_size = ra->size;
> ---8<---
> 
> So if max_pages=384, then aligned_end will be aligned down to a maximum
> of the previous 1MB boundary?

No, it needs to be aligned only to previous 512K boundary because we want
to do IOs 3*512K large.

Hope things are a bit clearer now :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

