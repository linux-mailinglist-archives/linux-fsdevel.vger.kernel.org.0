Return-Path: <linux-fsdevel+bounces-8378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB308358AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5589D281EAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255339847;
	Sun, 21 Jan 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwrMmWhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD538FA7;
	Sun, 21 Jan 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705878871; cv=none; b=rCDl3VDjbBgBD5PENLzE31/hNfCjh6J8S3W/v9M+aW6S1tJ3YY8stWFpPvYz8BaNnm/vh28EiU/Q7n7hu0MuQsmjMQrX67/2IH5QwO0vnSGkc9WGYFeQi7ZUJ1YzmCBBJs71gjlW3qftMcTgDWs/wMDJpq8S8P7yAYKS4EUGbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705878871; c=relaxed/simple;
	bh=Mh9PVSQYANrqrO+FvQLj5G3wnFRRpOE7utVAp6P8OjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSkfyJQx12mmgQgNPBaqj6+KKYn7YwlTh6QrDxBYvZM8LGbvlZu5JvbBo+TUOlew4cG6RgNAxrGWOctdiwy5XsrUQ5KlywWpBdBMlylJCXU7rNtEdjAM1DiBS3hQRExE6VBlU3Lahn0L0urgMUfC/IiifxhT4nRBXHMt5JBi+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dwrMmWhs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hodzsNfeO881T3HKDoyGW3i33i1ny5GXxcx80Zpa8fI=; b=dwrMmWhsCHyS7VdvpHts5vieKc
	ZBOxoH2FKOIBwyqNYGOX67iGKd04ZDk3z/k6M/G5RmU6HxjQSZUzKYZ0VXhvcU9SnYTv2lwE6+PY/
	sCN6mCRqeTsmgEANF/efUw7Fx6v8gLC3tP62jQLTQRsCr5th0kOfpF/oszdOSXNiD9db3UxR/xXFg
	fVTiFDHA237JXnvjl8lojlgburTWeechbkrmykLNIlQOJaMY4BKrrPNq8kdRIUFoFv1513cghDT5F
	aU8tspFcLakmHq1e0GKelDzmvGhnVIrARjpsXg4AXoOif+RFq1lKcuUS8Y1u4EGFBAcEF9vRxUAKC
	Q6n4Rwcw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRh19-0000000EHq9-16IX;
	Sun, 21 Jan 2024 23:14:19 +0000
Date: Sun, 21 Jan 2024 23:14:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <tatashin@google.com>,
	Sourav Panda <souravpanda@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Za2lS-jG1s-HCqbx@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <b04b65df-b25f-4457-8952-018dd4479651@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04b65df-b25f-4457-8952-018dd4479651@google.com>

On Sun, Jan 21, 2024 at 01:00:40PM -0800, David Rientjes wrote:
> On Fri, 19 Jan 2024, Matthew Wilcox wrote:
> > It's probably worth doing another roundup of where we are on our journey
> > to separating folios, slabs, pages, etc.  Something suitable for people
> > who aren't MM experts, and don't care about the details of how page
> > allocation works.  I can talk for hours about whatever people want to
> > hear about but some ideas from me:
> > 
> >  - Overview of how the conversion is going
> >  - Convenience functions for filesystem writers
> >  - What's next?
> >  - What's the difference between &folio->page and page_folio(folio, 0)?
> >  - What are we going to do about bio_vecs?
> >  - How does all of this work with kmap()?
> > 
> > I'm sure people would like to suggest other questions they have that
> > aren't adequately answered already and might be of interest to a wider
> > audience.
> > 
> 
> Thanks for proposing this again, Matthew, I'd definitely like to be 
> involved in the discussion as I think a couple of my colleagues, cc'd, 
> would has well.  Memory efficiency is a top priority for 2024 and, thus, 
> getting on a pathway toward reducing the overhead of struct page is very 
> important for our hosts that are not using large amounts of 1GB hugetlb.
> 
> I've seen your other thread regarding how the page allocator can be 
> enlightened for memdesc, so I'm hoping that can either be covered in this 
> topic or a separate topic.

I'd like to keep this topic relevant to as many people as possible.
I can add a proposal for a topic on both the PCP and Buddy allocators
(I have a series of Thoughts on how the PCP allocator works in a memdesc
world that I haven't written down & sent out yet).

Or we can cover the page allocators in your biweekly meetings.  Maybe both
since not everybody can attend either the phone call or the conference.

> Especially important for us would be the division of work so that we can 
> parallelize development as much as possible for things like memdesc.  If 
> there are any areas that just haven't been investigated yet but we *know* 
> we'll need to address to get to the new world of memdesc, I think we'd 
> love to discuss that.

Thee's so much work to be done!  And it's mostly parallelisable and almost
trivial.  It's just largely on the filesystem-page cache interaction, so
it's not terribly interesting.  See, for example, the ext2, ext4, gfs2,
nilfs2, ufs and ubifs patchsets I've done over the past few releases.
I have about half of an ntfs3 patchset ready to send.

There's a bunch of work to be done in DRM to switch from pages to folios
due to their use of shmem.  You can also grep for 'page->mapping' (because
fortunately we aren't too imaginative when it comes to naming variables)
and find 270 places that need to be changed.  Some are comments, but
those still need to be updated!

Anything using lock_page(), get_page(), set_page_dirty(), using
&folio->page, any of the functions in mm/folio-compat.c needs auditing.
We can make the first three of those work, but they're good indicators
that the code needs to be looked at.

There is some interesting work to be done, and one of the things I'm
thinking hard about right now is how we're doing folio conversions
that make sense with today's code, and stop making sense when we get
to memdescs.  That doesn't apply to anything interacting with the page
cache (because those are folios now and in the future), but it does apply
to one spot in ext4 where it allocates memory from slab and attaches a
buffer_head to it ...

