Return-Path: <linux-fsdevel+bounces-69226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57196C740BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99D7F34A6F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6C33769B;
	Thu, 20 Nov 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsJfGbXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242531813F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643313; cv=none; b=gBAsvJdWhlV1cgZq/KngQpgCc6OXBn6FOXTC7TEB+NefpWO30GgXGw9QJ04+3VQFUBj+PefmsnmSKCA43/1jrakQAR0BWd7HZAhbm5E0OgDGeRv0NWjawj78kCmeZ/PexutKCPPYaDaQJMK22CqrGDZ6WzzDRnSMs3SEqd/vQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643313; c=relaxed/simple;
	bh=ErNwmxiijiv5EHWv/h3vwXtgw18PY5Poi2mjJF6VtqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOQhR6KmR+80RJQZb2IMHkYQ4PDBwfeWjs3BZXhVsWPRQGoNEUClV692zffBDyEq6z5l4FDGyv3MG2QJWBla35lm72BryYB0uZP8JSmOCqzaNDcVCmcevTiWJU5H/SL/n8FK9IiJuJHSamOwQu8rYSR+Cnlq6P7mVNJ5kXBdzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsJfGbXY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b31507ed8so752482f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763643309; x=1764248109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL5G0+c5xZz8aJnyzIUKwf30/NDXSihWrQzUxGxYjIs=;
        b=LsJfGbXYn7u1bnHZ8Vp/jaMgaEZOsGT5LjKoaGdRzp7D65xFrHwFB2w5In2lSdxeK8
         L84j4W0kSlNy1w6DmeYUe9rKEDEoHdm4yBDVtR+4DSyXJetOxLaZ8o1Te5XkNkQpJ2De
         6wPpfViK3sHDBjjkZsnE0L7xUBhZL7L0Z+Fp+6UhWHmEMdbWkDFAXykomaAKfo2mkhuu
         51z66yr1SFdgBpaT4BcYj1qLq1DJ3sKaLbV1r8Rw8ESSEucfYwFJkr2q7SL0BxQOIM1m
         4TPhubQtiA6Mk7NFVFh4UZXVPafUhFmRefYCz2ye9W4aOKXtsOOjL5OmlUoA5HmqpOpB
         aNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643309; x=1764248109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GL5G0+c5xZz8aJnyzIUKwf30/NDXSihWrQzUxGxYjIs=;
        b=cXfO1mCibgrgOdXxqlRSQiUrXyqzBFRK5czBzQxI1qCAZZLripl/lMDYrRyg4UeROj
         0/NhIMB8JigZawo9CK/Vwx6tUqVaJ+8ZWv9V6AF7HolrbKjlilxn09Uy4c/YK9TWrYj5
         DmolAOhcMxlxjtCXNImUCQqwYYPh52oDuePu6sn73+lERx7AHWGnjQF//f55o9oTiI/J
         SP/AIOCuek5GeB/dvTdGmkhWSPPL32s/y6mcYpju6y0lA0Jan9YmMpkITp3t8eHAMUo2
         jvcVa1js0VdjwtJ4OwJXVRaNvGZVwkjrgfxemjvkhD2ptknj8UehAsIesC6H3tvcTDjx
         eD+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0Qd+SLiNAlVVt7wExL8srHOhFoN135skiV0OtrgmaI+9szfzR8x2XbmniYOiSdUAgqjRafvxADeq1K7/A@vger.kernel.org
X-Gm-Message-State: AOJu0YwobZkbOn6YQkPzQEr0ehB9+kGy5+SWxPqUlCtzI6WhA4NLPHmB
	Yj++nFdCmKLZnrnkshaLMa3OWMNjhUV3aXCfjLk/z6zpJdTF+pe+lka7
X-Gm-Gg: ASbGncvjq/SXGnwMh4rJX2iDUBGsgwpvpeRNMQnoUekhv9KjtNaGBhyyV1WBQQJCsBg
	O9a4LaoV4uFvIppJSYSVsG/2pktkGORVUV+fqfDroSBtooSck+UuJwdpc8A5ayt/JN+kE6fS2uA
	ZdC9O9v8NxjZ7uh93eTEcm+/KkAxhXN34NQ8aZByJnBBKnRTNblKY6epjTCprJLSJvMzI3A+vqC
	5eMd0iRbv+1AZuEQcrZwX/hwlKk7jO/v8hGJ8apdLqglupJY7GHDBmbbAeHDKnSxSgvZCrUjNus
	H+elQM+M3AeCeApaz2pETLrzwcMcEbEv76i3G9fthSZlNC1mJ82qR9zr337SbmA2RzgddN2VWGV
	HzR1i1AFnoilWL4ZAMlq0cqZj8H+KGSHNApYQ+HNq4TFcGPek+fNGl3+27JAkOJHcz8dGZIP08z
	RmPT9h9f/0JWzwFenzs9wt50JrusAH/rcYASRZPf/vw3kIYYSx0/xp
X-Google-Smtp-Source: AGHT+IFU7kfWfvCTzsg6mmHTeWF/Bfj6Cwbkq5zHUE7KNXvkB7ee4cOXGRDIAiPbZDCgY5IenhM3aw==
X-Received: by 2002:a5d:584d:0:b0:429:ba48:4d6 with SMTP id ffacd0b85a97d-42cb9a19612mr2600256f8f.10.1763643308985;
        Thu, 20 Nov 2025 04:55:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm5241066f8f.9.2025.11.20.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:55:08 -0800 (PST)
Date: Thu, 20 Nov 2025 12:55:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Christoph Lameter <cl@gentwo.org>,
 David Hildenbrand <david@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Tejun Heo
 <tj@kernel.org>, Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <20251120125505.7ec8dfc6@pumpkin>
In-Reply-To: <0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-40-david.laight.linux@gmail.com>
	<0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 10:36:16 +0000
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I guess you decided to drop all reviewers for the series...?
> 
> I do wonder what the aversion to sending to more people is, email for review is
> flawed but I don't think it's problematic to ensure that people signed up to
> review everything for maintained files are cc'd...

Even sending all 44 patches to all the mailing lists was over 5000 emails.
Sending to all 124 maintainers and lists is some 50000 emails.
And that is just the maintainers, not the reviewers etc.
I don't have access to a mail server that will let me send more than
500 messages/day (the gmail limit is 100).
So each patch was send to the maintainers for the files it contained,
that reduced it to just under 400 emails.

> 
> On Wed, Nov 19, 2025 at 10:41:35PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.  
> 
> you're changing min_t(int, ...) too? This commit message seems incomplete as a
> result.

Ok, I used the same commit message for most of the 44 patches.
The large majority are 'unsigned int' ones.

> 
> None of the changes you make here seem to have any bearing on reality, so I
> think the commit message should reflect that this is an entirely pedantic change
> for the sake of satisfying a check you feel will reveal actual bugs in the
> future or something?
> 
> Commit messages should include actual motivation rather than a theoretical one.
> 
> >
> > In this case the 'unsigned long' values are small enough that the result
> > is ok.
> >
> > (Similarly for clamp_t().)
> >
> > Detected by an extra check added to min_t().  
> 
> In general I really question the value of the check when basically every use
> here is pointless...?
> 
> I guess idea is in future it'll catch some real cases right?
> 
> Is this check implemented in this series at all? Because presumably with the
> cover letter saying you couldn't fix the CFS code etc. you aren't? So it's just
> laying the groundwork for this?

I could fix the CFS code, but not with a trivial patch.
I also wanted to put the 'fixes' in the first few patches, I didn't realise
how bad that code was until I looked again.
(I've also not fixed all the drivers I don't build.)

> 
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  mm/gup.c      | 4 ++--
> >  mm/memblock.c | 2 +-
> >  mm/memory.c   | 2 +-
> >  mm/percpu.c   | 2 +-
> >  mm/truncate.c | 3 +--
> >  mm/vmscan.c   | 2 +-
> >  6 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index a8ba5112e4d0..55435b90dcc3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
> >  	unsigned int nr = 1;
> >
> >  	if (folio_test_large(folio))
> > -		nr = min_t(unsigned int, npages - i,
> > -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
> > +		nr = min(npages - i,
> > +			 folio_nr_pages(folio) - folio_page_idx(folio, next));  
> 
> There's no cases where any of these would discard significant bits. But we
> ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.

The (implicit) cast to unsigned int is irrelevant - that happens after the min().
The issue is that 'npages' is 'unsigned long' so can (in theory) be larger than 4G.
Ok that would be a 16TB buffer, but someone must have decided that npages might
not fit in 32 bits otherwise they wouldn't have used 'unsigned long'.

> 
> But at the same time I guess no harm.
> 
> >
> >  	*ntails = nr;
> >  	return folio;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e23e16618e9b..19b491d39002 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2208,7 +2208,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
> >  		 * the case.
> >  		 */
> >  		if (start)
> > -			order = min_t(int, MAX_PAGE_ORDER, __ffs(start));
> > +			order = min(MAX_PAGE_ORDER, __ffs(start));  
> 
> I guess this would already be defaulting to int anyway.

Actually that one is also fixed by patch 0001 - which changes the return
type of the x86-64 __ffs() to unsigned int.
Which will be why min_t() was used in the first place.
I probably did this edit first.

> 
> >  		else
> >  			order = MAX_PAGE_ORDER;
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 74b45e258323..72f7bd71d65f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2375,7 +2375,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
> >
> >  	while (pages_to_write_in_pmd) {
> >  		int pte_idx = 0;
> > -		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
> > +		const int batch_size = min(pages_to_write_in_pmd, 8);  
> 
> Feels like there's just a mistake in pages_to_write_in_pmd being unsigned long?

Changing that would be a different 'fix'.

> Again I guess correct because we're not going to even come close to ulong64
> issues with a count of pages to write.

That fact that the count of pages is small is why the existing code isn't wrong.
The patch can't make things worse.

> 
> >
> >  		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
> >  		if (!start_pte) {
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 81462ce5866e..cad59221d298 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1228,7 +1228,7 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
> >  	/*
> >  	 * Search to find a fit.
> >  	 */
> > -	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> > +	end = umin(start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> >  		    pcpu_chunk_map_bits(chunk));  
> 
> Is it really that useful to use umin() here? I mean in examples above all the
> values would be positive too. Seems strange to use umin() when everything involves an int?
> 
> >  	bit_off = pcpu_find_zero_area(chunk->alloc_map, end, start, alloc_bits,
> >  				      align_mask, &area_off, &area_bits);
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 91eb92a5ce4f..7a56372d39a3 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -849,8 +849,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
> >  		unsigned int offset, end;
> >
> >  		offset = from - folio_pos(folio);
> > -		end = min_t(unsigned int, to - folio_pos(folio),
> > -			    folio_size(folio));
> > +		end = umin(to - folio_pos(folio), folio_size(folio));  
> 
> Again confused about why we choose to use umin() here...
> 
> min(loff_t - loff_t, size_t)
> 
> so min(long long, unsigned long)

Which is a signedness error because both are 64bit.
min(s64, u32) also reports a signedness error even though u32 is promoted
to s64, allowing that would bloat min() somewhat (and it isn't common).

> 
> And I guess based on fact we don't expect delta between from and folio start to
> be larger than a max folio size.

The problem arises if 'to - folio_pos(folio)' doesn't fit in 32 bits
(and its low 32bit are small).
I think that might be possible if truncating a large file.
So this might be a real bug.

> 
> So probably fine.
> 
> >  		folio_zero_segment(folio, offset, end);
> >  	}
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b2fc8b626d3d..82cd99a5d843 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3489,7 +3489,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
> >
> >  static bool suitable_to_scan(int total, int young)
> >  {
> > -	int n = clamp_t(int, cache_line_size() / sizeof(pte_t), 2, 8);
> > +	int n = clamp(cache_line_size() / sizeof(pte_t), 2, 8);  
> 
> int, size_t (but a size_t way < INT_MAX), int, int

Unfortunately even if cache_line_size() is u32, the division makes the result
size_t and gcc doesn't detect the value as being 'smaller that it used to be'.

	David

> 
> So seems fine.
> 
> >
> >  	/* suitable if the average number of young PTEs per cacheline is >=1 */
> >  	return young * n >= total;
> > --
> > 2.39.5
> >  
> 
> Generally the changes look to be correct but pointless.


