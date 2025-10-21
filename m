Return-Path: <linux-fsdevel+bounces-64921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D3BF6952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56F5425AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50E333457;
	Tue, 21 Oct 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Iu0Nbs2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tTzz138w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510028E3F;
	Tue, 21 Oct 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051546; cv=none; b=qbqcO0feTF2Pk15YJfi2emtoY9GFaxV6m4K2Vp7luQ9wKBvzgPixwO1lhFhrJqFOWBu1kXwfk3u5WzarVkn2eGVvN0uHGglfHuglIIJoyX3BVBo9Qg1UAQg6sqIdtBo6mK7kfgRfJFOSxpHD54KHLoSyIBpXh40u08PIuQcebrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051546; c=relaxed/simple;
	bh=B2TBrIZlJ+6+39PwLMHOTM7WjiHBDX6OqlBY5Gb/qVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5dxV8W/vGLm2ULCTcV0fWc0GLqDJSrJJOa9H5mAS/nT4cng89IO94tm9LXQ9hdwYYqqmeNGJi3k1vVWeEJ6sW9l0kFhhLDK2jRlRaUEIvr/d62F/yGf0iZmg5VN5fEsybfChBgHPOEnbBX8JmJ+Sm4F/DISxyrg2KTB2yoAaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Iu0Nbs2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tTzz138w; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 2FDFE1301A85;
	Tue, 21 Oct 2025 08:59:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 08:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761051542; x=
	1761058742; bh=2BQz6WVGS/q7CoPgGFcDnRp4byTd9FtCIByaV/xWRBA=; b=I
	u0Nbs2jQ8scGOdlO5MSp5Iaw6ZkGgzZsk2Ni+x5jNebxkbpdRmP30ov3WZKA/6rK
	a+YVToRNRH0d7287O20I5yJ19rhG96cw3B+GHG0XDhLT5U1CTBkbyKlbzkPkU4E3
	kca9GkhSQtBbHmUfUgg4Nh0rCSZMzpBR/rPWO50BQIvc9kimdGSTEh+b+mnoqw/+
	8elYQQ5VyqEXK/C0rQjk/CUcLKGMDZvQNHs2YyqdgJQpz3YAshnJhsp/nOo/gL0B
	6ChuOJLdCrFCu4ViE/MB9C73fJeKaKC/QicqwanbhVaREZw3lFLeLFjWCFXnqH3j
	TsECokSk8qwRWeEbVjctQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761051542; x=1761058742; bh=2BQz6WVGS/q7CoPgGFcDnRp4byTd9FtCIBy
	aV/xWRBA=; b=tTzz138wLHFqxyRZlbaEaJIDtP3ldZ/m0Q9xHkLxSzS7xnc9oyc
	a12LRJV2/2if/+ATYSL+lEyeMvTgWZRyXB1qHW2RlQiUSM7W1rVBD1Mq4/n7xFMG
	a1FthGqplIWb967o3StanE0Lmo5J5SdYjy0NRBHkGddMHJ84Di8uHOM04q8Arq17
	K+2vTnHQVVsg6dYY3Ui24wNnln4cpZokOh0+cXX7fC33OE7m81HqyJzw2iaAVn+P
	NHAIMI02bdgISpVacCK396O9gSyY9SEYQ0tz/wdpJaN6+2767xkNr8GLqB+pAKOT
	UGsTsjeriBZcnNatsqe0+kejXyJMnL1pyZA==
X-ME-Sender: <xms:lIP3aAV2xwidlRlCX3eb0sVyC_sPV7X97w600lh_0B8xxrcDymAvog>
    <xme:lIP3aHcgHQJXzLkKegj1NF30F8IRwg2dKw14hPhMRBEdjOF_tjWSOCDVT1QSV8nRt
    7oL8sS2JcSnWPAYxcQIZmaYkK26qD2zYIuWDzWt7mc1LYUrKHRstCM>
X-ME-Received: <xmr:lIP3aFNcuRIysS19vtnzVN6wLnwjUfz6BB66ssoQ_y_erg0WidrD7qfxHr0yrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:lIP3aBK3H8pJWAfW3LP7jxo-p1wDVSoWUnhDwmxUKzZ94ZtLRDK_Qw>
    <xmx:lIP3aIhRgIuEHHV34Q9Xol83t-JuXj4jxa_KgsDvS7X1Hz3JGlovIA>
    <xmx:lIP3aHfpqtd9apDpVpafNN0MSaljOxEVwWDlcmsvMwHA3PgaAwSPrQ>
    <xmx:lIP3aI6IaZtHA95MdfMHNCGdQmCbj5gfAKpBBlPk0alqG1nhs6JG9Q>
    <xmx:loP3aCEqqnEHMFF7p32xvhRuxRxEn60rpIXeqa2xBzSxIMGJgjm3j82M>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 08:58:59 -0400 (EDT)
Date: Tue, 21 Oct 2025 13:58:57 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <imqowmshevu7egxfbc6kglh7o7sedy5s7xl4qw24gc5iyrbrat@67wxpi36t4i7>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
 <fb51f195-b4d1-4bf4-84cf-87d433f8ac86@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb51f195-b4d1-4bf4-84cf-87d433f8ac86@redhat.com>

On Tue, Oct 21, 2025 at 02:33:39PM +0200, David Hildenbrand wrote:
> On 21.10.25 08:35, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > supposed to generate SIGBUS.
> > 
> > This behavior might not be respected on truncation.
> > 
> > During truncation, the kernel splits a large folio in order to reclaim
> > memory. As a side effect, it unmaps the folio and destroys PMD mappings
> > of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> > are preserved.
> > 
> > However, if the split fails, PMD mappings are preserved and the user
> > will not receive SIGBUS on any accesses within the PMD.
> > 
> > Unmap the folio on split failure. It will lead to refault as PTEs and
> > preserve SIGBUS semantics.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > ---
> >   mm/truncate.c | 29 ++++++++++++++++++++++++++---
> >   1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 91eb92a5ce4f..cdb698b5f7fa 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -177,6 +177,28 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
> >   	return 0;
> >   }
> > +static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
> > +{
> > +	enum ttu_flags ttu_flags =
> > +		TTU_RMAP_LOCKED |
> > +		TTU_SYNC |
> > +		TTU_BATCH_FLUSH |
> 
> I recall that this flag interacts with try_to_unmap_flush() /
> try_to_unmap_flush_dirty().
> 
> See unmap_folio() as one example.
> 
> If so, aren't we missing such a call or is the flush implied already
> somehow?

My bad. TTU_RMAP_LOCKED also should not be there.

Will fix.

> > +		TTU_SPLIT_HUGE_PMD |
> > +		TTU_IGNORE_MLOCK;
> > +	int ret;
> > +
> > +	ret = try_folio_split(folio, split_at, NULL);
> > +
> > +	/*
> > +	 * If the split fails, unmap the folio, so it will be refaulted
> > +	 * with PTEs to respect SIGBUS semantics.
> > +	 */
> > +	if (ret)
> > +		try_to_unmap(folio, ttu_flags);
> 
> Just wondering: do we want to check whether the folio is now actually
> completely unmapped through !folio_mapped() and try to handle if it isn't
> (maybe just warn? Don't know)
> 
> We usually check after try_to_unmap() whether we actually found all mappings
> (see unmap_poisoned_folio()). I recall some corner cases where unmapping
> could fail, but I don't remember whether that's specific to anonymous pages
> only.

I will add WARN_ON(folio_mapped(folio)).

> 
> > +
> > +	return ret;
> > +}
> > +
> >   /*
> >    * Handle partial folios.  The folio may be entirely within the
> >    * range if a split has raced with us.  If not, we zero the part of the
> > @@ -224,7 +246,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
> >   		return true;
> >   	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
> > -	if (!try_folio_split(folio, split_at, NULL)) {
> > +	if (!try_folio_split_or_unmap(folio, split_at)) {
> >   		/*
> >   		 * try to split at offset + length to make sure folios within
> >   		 * the range can be dropped, especially to avoid memory waste
> > @@ -249,12 +271,13 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
> >   			goto out;
> >   		/*
> > +		 * Split the folio.
> 
> I'd drop that. It's not particularly helpful given that we call
> try_folio_split_or_unmap() and mention further above "try to split at
> offset".

Okay.

> Nothing else jumped at me!

Thanks for the review!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

