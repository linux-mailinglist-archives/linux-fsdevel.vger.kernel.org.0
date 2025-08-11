Return-Path: <linux-fsdevel+bounces-57303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38DB205B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D8D188B5E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BEB23D2A0;
	Mon, 11 Aug 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ZYwJzj33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lw/u2PNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098372264C7;
	Mon, 11 Aug 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908599; cv=none; b=mIhtw8zgpEojStQwwEOZNvBp7luwem6ZPYvHJjCDNd51ztx1PMoJZ8In3u+DRCotvdFN6LRgiGoeRWXjjn4DT07Tzxv0cJC/ZjLi2egsZxs91qp/CZcvxqE1VPe2h1bSs7eOqqqEoM56SDtpS2Ts+UEXa/RqY92N9VJIltrzzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908599; c=relaxed/simple;
	bh=cI+cNKDa9mnavxrQZJDacURYTScB7hGATRfNuLhEhlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC/2gzKu4RQBgUk47pz3XnyG2odgFLYNYUNmeXxj9nxSdRDT6BYIptbM+LQAz0zdQDOw0GGvEy26BeCg5+o811bqA0WfGiGgTRe2vCWrtS5XLKsiM3jRMRLTWSxSfGYJO942e6lXBcGMDihXSrGt/FiWqqPi5yqZ/+mQNgU1xx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ZYwJzj33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lw/u2PNS; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 63CD11300191;
	Mon, 11 Aug 2025 06:36:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 11 Aug 2025 06:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754908594; x=
	1754915794; bh=3ir52tZmodooRvQScQwDhVxAmA5y/JQn5auuY4m6agI=; b=Z
	YwJzj33xYsZBUJ6IzJ0WxB7ZPZ+NTd64XV3Jz1dl2fvYAxNzZqiEtfHmMBJ2dEjF
	jKsaTTRFIar75JV/WXJ7sAat2l3PPKC7Ypb/SFtLg97g2ylkT6Q+AwUTyeH3ytyW
	C5+k5l+T8OXQiTCGWyRj1cpraEq+jwmJ+lUEucZq8BAleJMuubOB1FeqeZL+9Oem
	7w4b1iN3mORNUKRRBHFjl839Zr8Q/X/Trze38YmDdAU5FrnwNOuQqUfX8JKr6vtF
	C29Z8eIEgAOZTIT6E0KsP/cEi/l6pYvchnrlf8pnCE1zyAM1RSmkM135KlCcEN0O
	UI9DCOz2+1AhB+gIcoisw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754908594; x=1754915794; bh=3ir52tZmodooRvQScQwDhVxAmA5y/JQn5au
	uY4m6agI=; b=lw/u2PNSpIOo4ODXYLXgQDAIDVQVNJ3cuT/pt2oak+p6hymj6Xl
	TRKUQgcUrq/GPM7Q8mKax6iMD4p1MBQDa/v4DrS/c+Fte3wWPNbeSfqzYKHuJgol
	Vwr+9t45ICKWovIldVz7rHak7NsrkLjyGvhCvcX6UAZ0KSSBEIFk2EygetByQcg7
	kxzQaz+n+OmC1EyGVb9naUnnPfv5JgkXkbno7qbAvbDUbwYObdc5iT0kGjcv084a
	vlnQjymLIS//aiGkw3A/tGIVKtX4eQI9FHXB5SaFl1E0NnTOJS7QlJ0KpbKUnold
	Rv4D4LR5w9WAOpQvYYCiTZ5IueMmz/serGg==
X-ME-Sender: <xms:sMeZaPaai9YTIfw37ejKGZ3uGQwKZvHuCiE7-KvW-M9p-7Uk-iOpjg>
    <xme:sMeZaFgwkWilAXNt0CQgdPvo93xCwzEUapb2eKzTFKmLJpbLRRUrDTcHm5-AMsWEM
    r3kzzuQ8G9wkII6XCI>
X-ME-Received: <xmr:sMeZaEUiO8h_lYXko7NSPUjZ-CuHAgkNr-N1frHBBn69VDhV0BaagnTqIgq6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepkhgvrhhnvghlsehprghnkhgrjhhrrghghhgrvhdrtghomhdprh
    gtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhihrghn
    rdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngh
    eslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhu
    shgvrdgtiidprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthhope
    hrphhptheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sMeZaPV_84z0yhD5XP_EVdFCaSDz6zDY0-Ijs-UIqVV-oE-oIRcrPg>
    <xmx:sMeZaAiOMRpSac9hXOdj4hbOcGAs28WlUd9C-IzToTaV7WNs3ipB1A>
    <xmx:sMeZaELPkPI7mE-7kWSuW_m46t4dVUS4Rq9m-8LNs0ubdR2tcmsfxw>
    <xmx:sMeZaNelP9kaRfzsgLdrlb2R4FxaIHU5LPHs6wHSrQbQQF3MpikgFA>
    <xmx:sseZaEdV8sqEXHjuevFSSbmlXO3_7TfRosx8ii5M5eEv0tu70ejlW2xN>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 06:36:31 -0400 (EDT)
Date: Mon, 11 Aug 2025 11:36:29 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
 <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>

On Mon, Aug 11, 2025 at 12:21:23PM +0200, David Hildenbrand wrote:
> On 11.08.25 12:17, Kiryl Shutsemau wrote:
> > On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
> > > > 
> > > > Well, my worry is that 2M can be a high tax for smaller machines.
> > > > Compile-time might be cleaner, but it has downsides.
> > > > 
> > > > It is also not clear if these users actually need physical HZP or virtual
> > > > is enough. Virtual is cheap.
> > > 
> > > The kernel config flag (default =N) literally says don't use unless you
> > > have plenty of memory :)
> > > 
> > > So this isn't an issue.
> > 
> > Distros use one-config-fits-all approach. Default N doesn't help
> > anything.
> 
> You'd probably want a way to say "use the persistent huge zero folio if you
> machine has more than X Gigs". That's all reasonable stuff that can be had
> on top of this series.

We have 'totalram_pages() < (512 << (20 - PAGE_SHIFT))' check in
hugepage_init(). It can [be abstracted out and] re-used.

-- 
Kiryl Shutsemau / Kirill A. Shutemov

