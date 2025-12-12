Return-Path: <linux-fsdevel+bounces-71196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF721CB8C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 13:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEB3306456B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA4275AF0;
	Fri, 12 Dec 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cfKnlzfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8CDDA9;
	Fri, 12 Dec 2025 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765541909; cv=none; b=LkH4YWLTBetQS6qxcXCcgBzLpNAtJewH1ARVwCyOhcyufaGjYfOAwD0VeA/UeDJVmfP5JB8uBXVJqsQ46zfW1Hv5v9SY/gNYVyvm7FV7dtYmUxlvs8fCe2nSDdaZKcaAksD8O1UNSwLGSNMmNxKEOo2Zjac9BmcJgFb1TnvcETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765541909; c=relaxed/simple;
	bh=mw0h/t3fuglas+ceLEgIu5K7B8qMABG0wCzi/XZVZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnGH78fxvkeRScu6RqwAoYkQELW+jhHFwn15jKDTjPKwSx2DVDtp0ZyA9WbeHYUgtbU7rvcX7ETuqygwFyWH9grYE3HOF73sScxQ/jr59SL29dKkG50SrbTQFu35qguVwMCYCOthBVITokU6e22pc7sk2yCwgjuw1e32pzdHRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cfKnlzfV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w4e7B+E8LkBy1p188ZJwv5Wln/swonn5oRIyMMDWppE=; b=cfKnlzfV9QrsH5hMOhmPUAJhXy
	XjEPNpRNJpEyUWUD58b2u3CldeYoF3Yxr90xzhUkPWmFS1Icv8hUVhfORCvWwE7UHE+RlwbWt7xVO
	vUeggPll8nmxfPGQsbuyfrPGqVqU41vL0lNYf7j8jUjLggJ8BRxZWITJ3vVe51BDVUW0hqkQupPc+
	f7WZx7HJjp4C3PcTjQnbWyuhUOFOYenRuQWMtitcijzVGhxR915iboxfs7Ee1vZy32cOADi1nX5gw
	D3x1yPOOSDbg/a0QcNlh5HrUrMb5n1ze3FR3M6LvMSEFYshjNaC35qw1f9xyIoqiBFvyMG1c8MC0u
	uyKZfm9A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU267-0000000FfEK-2ukU;
	Fri, 12 Dec 2025 12:18:11 +0000
Date: Fri, 12 Dec 2025 12:18:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Deepakkumar Karn <dkarn@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagemap: Add alert to mapping_set_release_always() for
 mapping with no release_folio
Message-ID: <aTwIAwjeSrALbVww@casper.infradead.org>
References: <20251210200104.262523-1-dkarn@redhat.com>
 <aTnn68vLGxFxO8kv@casper.infradead.org>
 <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>

On Thu, Dec 11, 2025 at 10:23:13AM +0100, Jan Kara wrote:
> On Wed 10-12-25 21:36:43, Matthew Wilcox wrote:
> > On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
> > >  static inline void mapping_set_release_always(struct address_space *mapping)
> > >  {
> > > +	/* Alert while setting the flag with no release_folio callback */
> > 
> > The comment is superfluous.
> 
> Agreed.
> 
> > > +	VM_WARN_ONCE(!mapping->a_ops->release_folio,
> > > +		     "Setting AS_RELEASE_ALWAYS with no release_folio");
> > 
> > But you haven't said why we need to do this.  Surely the NULL pointer
> > splat is enough to tell you that you did something stupid?
> 
> Well, but this will tell it much earlier and it will directly point to the
> place were you've done the mistake (instead of having to figure out why
> drop_buffers() is crashing on you). So I think this assert makes sense to
> ease debugging and as kind of self-reminding documentation :).

Oh.  So the real problem here is this:

        if (mapping && mapping->a_ops->release_folio)
                return mapping->a_ops->release_folio(folio, gfp);
        return try_to_free_buffers(folio);

We should have a block_release_folio(), change all the BH-based
filesystems to add it to their aops, and then change
filemap_release_folio() to do:

	if (mapping)
		return mapping->a_ops->release_folio(folio, gfp);
	return true;

(actually, can the !mapping case be hit?  surely this can't be called
for folios which have already been truncated?)

Then you get a nice NULL pointer dereference instead of calling into
try_to_free_buffers() which is as confusing as hell.

