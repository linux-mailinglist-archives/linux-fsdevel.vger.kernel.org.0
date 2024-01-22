Return-Path: <linux-fsdevel+bounces-8384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253FE83591C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA5281D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F337E;
	Mon, 22 Jan 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r15nLcb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361036B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886325; cv=none; b=PcyR3rZ9ipkXuptOsikt1EPq/jipJQz7uJGyHI1T5ho+iMUe9gQFchCTWz4j27nJxwT0Wun9zYYERtBoTtSAQo3ftEGaPieoGGwM/GIKRqeYH47xAL5isS7VN6BcQ5A/gpK4124IblvnwLMrdOQVOlK+JUT9D/MOZtwKM3wdVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886325; c=relaxed/simple;
	bh=J3/J437+dknRFnmCgKj/LtRTTXPb5CI46BVtwub2dlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm12UWpwjPdcAPvjg/v9uC1r0xy3YKzzw3mwnxGBpsFtZsQ+6MRE3Ks4oGz/4fMZkUPgxB5fXeeSzceUGeICBhHv0V9zsm3oQJPZ2sYirhw0y1rQfYmYAs5XLDRPzNtzrUp85iW6DLN5yXbt0DQwL4NWPBxewqDQ4PeIhiP4Miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r15nLcb4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=w7rTMujnGS1vflDu+GGEO7dgVhJq77rHLVCuvhrlBNw=; b=r15nLcb4lZXOFEReq+PSbjJ7ng
	xbkLbrT8GEn3W9lv3x7ZawzVQNgte8xYDo3b9WDLsFiWoiZWwSajIf45L7coeZNZ2RH+se+i7ny/2
	Ucxw2lqlQqeCC3XbibYH/IyfhJ+jTy4SDrUoh5CeEIStE6KRWBf7pTStSfrxIGrSNt4FT9cYFSXwF
	fa3dj5alJqdeq5orpv1178tOGbRRe6VAdGLgJFkvT57sM+qFCIvJZ9nK24zSpyZwCiWTpPcXWolkV
	dPwYxK2e2JXXY5gd6mSkI9HvQhOXo0vY8qLmLrD/JzaTiBgaMjHJzgn87Yq0ffdTJgxssIxR3mfyR
	hAMhHgcA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRixQ-0000000EYbY-2NBf;
	Mon, 22 Jan 2024 01:18:36 +0000
Date: Mon, 22 Jan 2024 01:18:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, g@casper.infradead.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	lsf-pc@lists.linux-foundation.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
Message-ID: <Za3CbL5U7dFp6aL2@casper.infradead.org>
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
 <ZFvGP211N+CuGEUT@moria.home.lan>
 <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com>

On Sun, Jan 21, 2024 at 06:39:26PM -0500, Pasha Tatashin wrote:
> On Wed, May 10, 2023 at 12:28 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > Hasn't been addressed yet, but we were just talking about moving the
> > codetag pointer from page_ext to page last night for memory overhead
> > reasons.
> >
> > The disadvantage then is that the memory overhead doesn't go down if you
> > disable memory allocation profiling at boot time...
> >
> > But perhaps the performance overhead is low enough now that this is not
> > something we expect to be doing as much?
> >
> > Choices, choices...
> 
> I would like to participate in this discussion, specifically to

Umm, this is a discussion proposal for last year, not this.  I don't
remember if a followup discussion has been proposed for this year?

> 2. Reducing the memory overhead by not using page_ext pointer, but
> instead use n-bits in the page->flags.
> 
> The number of buckets is actually not that large, there is no need to
> keep 8-byte pointer in page_ext, it could be an idx in an array of a
> specific size. There could be buckets that contain several stacks.

There are a lot of people using "n bits in page->flags" and I don't
have a good feeling for how many we really have left.  MGLRU uses a
variable number of bits.  There's PG_arch_2 and PG_arch_3.  There's
PG_uncached.  There's PG_young and PG_idle.  And of course we have
NUMA node (10 bits?), section (?), zone (3 bits?)  I count 28 bits
allocated with all the CONFIG enabled, then 13 for node+zone, so it
certainly seems like there's a lot free on 64-bit, but it'd be
nice to have it written out properly.

Related, what do we think is going to happen with page_ext in a memdesc
world (also what's going to happen with the kmsan goop in struct page?)

I see page_idle_ops, page_owner_ops and page_table_check_ops.
page_idle_ops only uses the 8 byte flags.  page_owner_ops uses an extra
64 bytes (!).  page_table_check uses an extra 8 bytes.

page_idle looks to be for folios only.  page_table_check seems like
it should be folded into pgdesc.  page_owner maybe gets added to every
allocation rather than every page (but that's going to be interesting
for memdescs which don't normally need an allocation).

That seems to imply that we can get rid of page_ext entirely, which will
be nice.  I don't understand kmsan well enough to understand what to
do about it.  If it's per-allocation, we can handle it like page_owner.
If it really is per-page, we can make it an ifdef in struct page itself.
I think it's OK to grow struct page for such a rarely used debugging
option.

