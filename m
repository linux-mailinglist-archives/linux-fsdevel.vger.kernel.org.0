Return-Path: <linux-fsdevel+bounces-48037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBBAA8FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A04F7A5CE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172D1F9EC0;
	Mon,  5 May 2025 09:37:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548B1459F7
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437862; cv=none; b=Qx0j7vwg4GJNA87sY32mOZDPxJN5qK4zHx+Y5muJ9MilfOTOYA9ySqh+yIEEi/UjGEW4qt8KiWRnpfXeh6AKs3G2l3IxsriUfgGcReEtF2DcUBQxfRJybNyek7BpaQi6iAtSUOGrqlPKCSrglHbvTktnZCb4tvIlTXB0oWMQ+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437862; c=relaxed/simple;
	bh=ba2hWlxchqI1r03nzBeqAuqkxolyG8QFR2s4GUBTLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg8y49AxVdD3wUg/qF8+lsnLPCBRpg3heKLO9cMedVJJnVHSVO8cmzE63YaRzNqO1lbUD+sLFNOxJtXI4R5bPvxNazhJH+grg40fu9deNcmtY9apF1FveyeDtr/MmHoamkgsSX5MppREVwQX10VGP3RMltTlgbdIakQtgiq+wIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCE7D211E9;
	Mon,  5 May 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFA1B13883;
	Mon,  5 May 2025 09:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pdHcKuKGGGhCbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 09:37:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DB05A082A; Mon,  5 May 2025 11:37:38 +0200 (CEST)
Date: Mon, 5 May 2025 11:37:38 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 2/5] mm/readahead: Terminate async readahead on
 natural boundary
Message-ID: <67wws7qs5v3poq6sefrrt4dgdn4ejh52mg5x7ycbxqvrfdvow3@zraqczowrvrl>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-3-ryan.roberts@arm.com>
 <3myknukhnrtdb4y5i6ewcgpubg2fopxc35ii6a4oy5ffgn7xdf@uileryotgd7z>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3myknukhnrtdb4y5i6ewcgpubg2fopxc35ii6a4oy5ffgn7xdf@uileryotgd7z>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BCE7D211E9
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Mon 05-05-25 11:13:26, Jan Kara wrote:
> On Wed 30-04-25 15:59:15, Ryan Roberts wrote:
> > Previously asynchonous readahead would read ra_pages (usually 128K)
> > directly after the end of the synchonous readahead and given the
> > synchronous readahead portion had no alignment guarantees (beyond page
> > boundaries) it is possible (and likely) that the end of the initial 128K
> > region would not fall on a natural boundary for the folio size being
> > used. Therefore smaller folios were used to align down to the required
> > boundary, both at the end of the previous readahead block and at the
> > start of the new one.
> > 
> > In the worst cases, this can result in never properly ramping up the
> > folio size, and instead getting stuck oscillating between order-0, -1
> > and -2 folios. The next readahead will try to use folios whose order is
> > +2 bigger than the folio that had the readahead marker. But because of
> > the alignment requirements, that folio (the first one in the readahead
> > block) can end up being order-0 in some cases.
> > 
> > There will be 2 modifications to solve this issue:
> > 
> > 1) Calculate the readahead size so the end is aligned to a folio
> >    boundary. This prevents needing to allocate small folios to align
> >    down at the end of the window and fixes the oscillation problem.
> > 
> > 2) Remember the "preferred folio order" in the ra state instead of
> >    inferring it from the folio with the readahead marker. This solves
> >    the slow ramp up problem (discussed in a subsequent patch).
> > 
> > This patch addresses (1) only. A subsequent patch will address (2).
> > 
> > Worked example:
> > 
> > The following shows the previous pathalogical behaviour when the initial
> > synchronous readahead is unaligned. We start reading at page 17 in the
> > file and read sequentially from there. I'm showing a dump of the pages
> > in the page cache just after we read the first page of the folio with
> > the readahead marker.

<snip>

> Looks good. When I was reading this code some time ago, I also felt we
> should rather do some rounding instead of creating small folios so thanks
> for working on this. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

But now I've also remembered why what you do here isn't an obvious win.
There are storage devices (mostly RAID arrays) where optimum read size
isn't a power of 2. Think for example a RAID-0 device composed from three
disks. It will have max_pages something like 384 (512k * 3). Suppose we are
on x86 and max_order is 9. Then previously (if we were lucky with
alignment) we were alternating between order 7 and order 8 pages in the
page cache and do optimally sized IOs od 1536k. Now you will allocate all
folios of order 8 (nice) but reads will be just 1024k and you'll see
noticeable drop in read throughput (not nice). Note that this is not just a
theoretical example but a real case we have hit when doing performance
testing of servers and for which I was tweaking readahead code in the past.

So I think we need to tweak this logic a bit. Perhaps we should round_down
end to the minimum alignment dictated by 'order' and maxpages? Like:

1 << min(order, ffs(max_pages) + PAGE_SHIFT - 1)

If you set badly aligned readahead size manually, you will get small pages
in the page cache but that's just you being stupid. In practice, hardware
induced readahead size need not be powers of 2 but they are *sane* :).

								Honza

> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 8bb316f5a842..82f9f623f2d7 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -625,7 +625,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
> >  	unsigned long max_pages;
> >  	struct file_ra_state *ra = ractl->ra;
> >  	pgoff_t index = readahead_index(ractl);
> > -	pgoff_t expected, start;
> > +	pgoff_t expected, start, end, aligned_end;
> >  	unsigned int order = folio_order(folio);
> >  
> >  	/* no readahead */
> > @@ -657,7 +657,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
> >  		 * the readahead window.
> >  		 */
> >  		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
> > -		ra->async_size = ra->size;
> >  		goto readit;
> >  	}
> >  
> > @@ -678,9 +677,13 @@ void page_cache_async_ra(struct readahead_control *ractl,
> >  	ra->size = start - index;	/* old async_size */
> >  	ra->size += req_count;
> >  	ra->size = get_next_ra_size(ra, max_pages);
> > -	ra->async_size = ra->size;
> >  readit:
> >  	order += 2;
> > +	end = ra->start + ra->size;
> > +	aligned_end = round_down(end, 1UL << order);
> > +	if (aligned_end > ra->start)
> > +		ra->size -= end - aligned_end;
> > +	ra->async_size = ra->size;
> >  	ractl->_index = ra->start;
> >  	page_cache_ra_order(ractl, ra, order);
> >  }
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

