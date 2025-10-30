Return-Path: <linux-fsdevel+bounces-66505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6338C21659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC483B1ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BC73678A7;
	Thu, 30 Oct 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fzqA7RrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYxcjzd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C732DA757;
	Thu, 30 Oct 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844126; cv=none; b=JVpknWbQe4moOEgihY3evJ8NGpWNqKZw6atiMuW86kq9AvY2d+mS6m+eyhZNEY8Nqq0KpXyTHs/38aOSi3fLbw9tuLarxuaVAyRSrmrFC/FqM9xqYEl1MWZJ+u8G7dn5NBLlfvLkpgynSXkqhxaMVKsCCpA5MIzIZqhiEj+i50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844126; c=relaxed/simple;
	bh=vc75/PA1yFgbihy04XQA5P+X3UnJtsMhMSF/Dy1XvlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUC8qoP3vTiRKk8lEHaLx6xAnJyR14q/SM01BO9Pazoph3pgLyVRyubgQlR29+4QgQLuhPqpmvdHmD4/rWUJtVGepF07tzjPCg3BRLZ+p9HysEsi+N2SnHM5a/DQrPURZ+1Rc5+IyndH8XufFSYgOTl4Sl2xtLBm52cN8nfczJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fzqA7RrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYxcjzd8; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id C22D31300170;
	Thu, 30 Oct 2025 13:08:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 13:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761844121; x=
	1761851321; bh=EBGM2Vv9TJf/GNvQJ15/TyEfo7R1Zl+KDezv+7vNYys=; b=f
	zqA7RrY3r3DxOB0UNbAuDkRa1wodtQgwolh8fHCXQ+t54/t1hKutu0n3sMDIcucF
	z0HLPogI+7J0enxTAr3MLNhe9w7owC3kZGCGG6Kyg92bAbeWyq0d5qtoiOgChqwv
	csHeI7h9y97DFwez4ZOL+WvwQsoXjJF5+rJAvPo+/LmB1KaiN134qPCPAvBPznld
	NQjdJD444p5YbQGwPhErbymXOb/g9fQEE1BbYhHOxHIFIatS944z0EggI+H1fIyd
	uxTrfMPE2TiGP/s4valktuA7s68T1mRWrUiptSWISCE0P084l5K4D5ITg7Ua83s4
	NCjigWefFS0AAcm9dQe0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761844121; x=1761851321; bh=EBGM2Vv9TJf/GNvQJ15/TyEfo7R1Zl+KDez
	v+7vNYys=; b=RYxcjzd8vMhaz5r6rq4XYY/0IBUZEddlwqWJ/DCJplirfZ7Muw1
	xhIapnHgUvDDBbvMsL5R2mzFj5tqEFTNGayzqn1ISyMnZyHfBGUWrLlSRZsX1DFY
	3FUbU0UBNxDrFanzboOIE4Qgy9clWEgBuo4GhP14TwRdXKYKqSItrl8Xt274L/B/
	T8T+QAfABBXgdxPOODNtJ8afJVBhUMFq1JQoQxA71l6UWQCMR5uwsUU9qdqe0zLI
	UJtHOUFdXMwTmMS8PVWwryO3in34izPaD2QGtZmdIp5wsy64onajTYHbQy2yaIR2
	uGNJ/h+YbdAhq/fsPOS/fmadvRCrKQdaAQg==
X-ME-Sender: <xms:l5sDaRfEbRVAUn6j8sDCiRP3iYPu5-wH3nE5_tsw2fLzj9ynM6lEJQ>
    <xme:l5sDaW4-vmcw62Pyf5ciBu2Pjqt_GU8AurbVOyVyFxWORPaPBZqcy0LRjHyC1wk6S
    IhfiZ5CSU2fnKFKKATxcymH7Skrc776_9cjRYRiypCDgdm41vlVX_h5>
X-ME-Received: <xmr:l5sDact4LWwQ_sm4Xuu2ry_oAjKJRVqPr9Dx5WRqdCWiBdyz1TWy37wBoKCn5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhughhhugesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:l5sDaZpVsBfopTvTTD9UER8SFeUaymDekQq7UaJWg-ItdQfg2EfFEQ>
    <xmx:l5sDaRQ4lCV0A9erSNCB7PERxmnzo8OfY-Fh7wqtEsu7uiFxRurP5w>
    <xmx:l5sDaeSNxWoGzZMNG0DlR3jg7KmJ_ai6TDQBdyGiqVYEoIFeRlVD5Q>
    <xmx:l5sDadkcGMgQIAxZCc1L9jnIKS4ADIZPvyx34kxOWGhvyposUBVorQ>
    <xmx:mZsDaQ599w40kuT9dAJqaPG74YgYY--Dmi2H6_K3InCV7vR_Uccwgc7P>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 13:08:39 -0400 (EDT)
Date: Thu, 30 Oct 2025 17:08:37 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Hugh Dickins <hughd@google.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <nwkpojnictbg6jicccpxyfi63ol4tmfajrlx24u5xxoxx7lv5f@jkw3o7j6tlfs>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <96102837-402d-c671-1b29-527f2b5361bf@google.com>
 <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com>
 <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>
 <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
 <24aa941e-64b2-14cd-6209-536c1304cf9d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24aa941e-64b2-14cd-6209-536c1304cf9d@google.com>

On Wed, Oct 29, 2025 at 10:59:24PM -0700, Hugh Dickins wrote:
> On Wed, 29 Oct 2025, Kiryl Shutsemau wrote:
> > On Wed, Oct 29, 2025 at 01:31:45AM -0700, Hugh Dickins wrote:
> > > On Mon, 27 Oct 2025, David Hildenbrand wrote:
> > > ...
> > > > 
> > > > Just so we are on the same page: this is not about which folio sizes we
> > > > allocate (like what Baolin fixed) but what/how much to map.
> > > > 
> > > > I guess this patch here would imply the following changes
> > > > 
> > > > 1) A file with a size that is not PMD aligned will have the last (unaligned
> > > > part) not mapped by PMDs.
> > > > 
> > > > 2) Once growing a file, the previously-last-part would not be mapped by PMDs.
> > > 
> > > Yes, the v2 patch was so, and the v3 patch fixes it.
> > > 
> > > khugepaged might have fixed it up later on, I suppose.
> > > 
> > > Hmm, does hpage_collapse_scan_file() or collapse_pte_mapped_thp()
> > > want a modification, to prevent reinserting a PMD after a failed
> > > non-shmem truncation folio_split?  And collapse_file() after a
> > > successful non-shmem truncation folio_split?
> > 
> > I operated from an assumption that file collapse is still lazy as I
> > wrote it back it the days and doesn't install PMDs. It *seems* to be
> > true for khugepaged, but not MADV_COLLAPSE.
> > 
> > Hm...
> > 
> > > Conversely, shouldn't MADV_COLLAPSE be happy to give you a PMD
> > > if the map size permits, even when spanning EOF?
> > 
> > Filesystem folks say allowing the folio to be mapped beyond
> > round_up(i_size, PAGE_SIZE) is a correctness issue, not only POSIX
> > violation.
> > 
> > I consider dropping 'install_pmd' from collapse_pte_mapped_thp() so the
> > fault path is source of truth of whether PMD can be installed or not.
> 
> (Didn't you yourself just recently enhance that?)

I failed to adjust my mental model :P

> > 
> > Objections?
> 
> Yes, I would probably object (or perhaps want to allow until EOF);
> but now it looks to me like we can agree no change is needed there.
> 
> I was mistaken in raising those khugepaged/MADV_COLLAPSE doubts,
> because file_thp_enabled(vma) is checked in the !shmem !anonymous
> !dax case, and file_thp_enabled(vma) still limits to
> CONFIG_READ_ONLY_THP_FOR_FS=y, refusing to allow collapse if anyone
> has the file open for writing (and you cannot truncate or hole-punch
> without write permission); and pagecache is invalidated afterwards
> if there are any THPs when reopened for writing (presumably for
> page_mkwrite()-ish consistency reasons, which you interestingly
> pointed to in another mail where I had worried about ENOSPC after
> split failure).
> 
> But shmem is simple, does not use page_mkwrite(), and is fine to
> continue with install_pmd here, just as it's fine to continue
> with huge page spanning EOF as you're now allowing in v3.
> 
> But please double check my conclusion there, it's so easy to
> get lost in the maze of hugepage permissions and prohibitions.

Your analysis looks correct to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

