Return-Path: <linux-fsdevel+bounces-79654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOaUA7ceq2mPaAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 19:36:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A73226BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 19:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68408303A860
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197C36F404;
	Fri,  6 Mar 2026 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="rV4gAnPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQ1vmXmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2536EA84;
	Fri,  6 Mar 2026 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822195; cv=none; b=HE+hWJqdtpccX/PyaYi6rp5J718un2/TxZWPMz+wWr2sBTKMX7UwazON0nMkQQqHW0V3Db1cz5vCZUY7wnrcLsxWYGEfj2UCtahiRAFfEY3B6Lkeb3TsDlCGGuR8FpntihJNX1LybTDgWdftNV8BBeO+yX//6YD3U5acr4sOSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822195; c=relaxed/simple;
	bh=MioFg8H+x6BGVdQ2Kho+Jlj3WtQJMMDNSge4lQ+c4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K++znmH252HPIFElTX6pDezGGY252peLbfekmNs4dwpaIVDkoBbVVtO4fo+LGiq1BK7UbkfOb30wPuL9TccvB/WccQy0v+aU8/mB1yrbeS5JmcVEJutaudyzABklNT+USseywBG1s3+cHXAvW25l+Mpt/k6aDIYFXYqBSBU/BrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=rV4gAnPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQ1vmXmm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD82C140019B;
	Fri,  6 Mar 2026 13:36:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 13:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772822192; x=
	1772908592; bh=2pTPaXqxgwHDvp03QfXEc5xrZACRdvuBS2Z+HP6tANU=; b=r
	V4gAnPixTzzEHTLVdQZycCQsUOByNvAmzU6psupSOmpbmUytB2Ff0c0F/TAcL8zm
	cu4iY4oj97Wm6bkUTwl/Uuir1IvGN8gkAtZ0kfcRluPH0licc2TR8e9gl+yLHxZl
	TfTAFi9rZBrh+hrsouXa8eRYansgqXZGIFTco9EMbyru37lJSy64lCu+QADVkcBG
	7Bj5C7ehlEN5NVm/HFvKKX4lqw25HQi5dFkqTHeq8TE32cuAWlsNZkyj2jUhcR/5
	C2zadpiNoybGIt6RHcuxRxcd1u5YSFN6u0QlQYQh4zFq+i07bKKG5n7rlF6nxG1/
	/ehXNyYSgPMfHUPX/CeFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772822192; x=1772908592; bh=2pTPaXqxgwHDvp03QfXEc5xrZACRdvuBS2Z
	+HP6tANU=; b=BQ1vmXmm1dF3H/rZikqOPN1gW8jvAZDvJcwIYa/bDA2T62Mdykj
	bKmtnqpui/kigmmo88I8JaRjIriusRzvjl5IsnwjCOS3ia3oF7qc/36q23MlqUNc
	3JiP+3cxp8QkZ0pICc90w4syKpeoNRaYF4OYEHxowhjxaAtk3WK1LK+Sd2WY+XT9
	wE0mRqPYA4nNOrbJEDWBTY3P0v52jUW9cUiaFCDUjxjch3i3L1MjBb33ryn4EZh8
	ViQpZE9fsvGTbYqtisDC/1QTfdSCMWvFY9s85Ay4Gg8GNJFfSiEz/h5/Cl6AaqEj
	LisM6lxbZKA9f4lNd6MnuaAgXN+ef/oIw4w==
X-ME-Sender: <xms:sB6raXkO3HTbsqAseTrmyo5vI8hcxLCNw9C6UtKDrTDJXIqxGwZW2A>
    <xme:sB6raZUdxZtG61tHXMYsZV5rh7Fg4NhUi-WxmC9urP9piYNXAagLXhetr2t6yV5AK
    6Wcxpn4yH72r4UvWVCI8IPYhuqdMc3jcDPmZPZrM-f_jxiMuekrZ1U>
X-ME-Received: <xmr:sB6raUeS2VzRQzWeX2q8zJ2zZlVXlYF0yS3tsTnmQ54_ZyEo5wLzpqxKirgt3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopegtrghrghgvshestghlohhuughflhgrrhgvrdgtohhm
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopeifihhllhhirghmrdhkuhgthhgrrhhskhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgtohhm
X-ME-Proxy: <xmx:sB6rafld6T4kTc__iWBEOr7MOlKfc6tHEzLApN0mdyuQRQ2qARUhnw>
    <xmx:sB6raeD2VdPTU7fcmOoxwmVKGukDPYvhJCG0kw6bGGKad3WgO-_uYg>
    <xmx:sB6raZfbH0ovGCEUbLQRm9DAASMbv8iLjd9J9UDYECKVnY1kRJWZCQ>
    <xmx:sB6raR4vu26qAHggOlP6YS4UmQZDnL13b8pTHmvtrSchkvtzCLC8ug>
    <xmx:sB6rabH-fUjQKSyMRWgPkp_pQq9ZWDK5ECaC7Fhe_Nqrz32AH81gQKBt>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 13:36:31 -0500 (EST)
Date: Fri, 6 Mar 2026 18:36:30 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org, 
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aasddOvIfcMYp3sk@thinkstation>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasAo8qRCV9XSuax@casper.infradead.org>
X-Rspamd-Queue-Id: 79A73226BB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-79654-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,shutemov.name:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:28:19PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > folio_split() needs to be sure that it's the only one holding a reference
> > > to the folio.  To that end, it calculates the expected refcount of the
> > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > freezing will fail.
> > > 
> > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > the entire folio_split can happen, then it calls folio_try_get() and
> > > succeeds, but it no longer covers the index we were looking for.  That's
> > > what the xas_reload() is trying to prevent -- if the index is for a
> > > folio which has changed, then the xas_reload() should come back with a
> > > different folio and we goto repeat.
> > > 
> > > So how did we get through this with a reference to the wrong folio?
> > 
> > What would xas_reload() return if we raced with split and index pointed
> > to a tail page before the split?
> > 
> > Wouldn't it return the folio that was a head and check will pass?
> 
> It's not supposed to return the head in this case.  But, check the code:
> 
>         if (!node)
>                 return xa_head(xas->xa);
>         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
>                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
>                 entry = xa_entry(xas->xa, node, offset);
>                 if (!xa_is_sibling(entry))
>                         return entry;
>                 offset = xa_to_sibling(entry);
>         }
>         return xa_entry(xas->xa, node, offset);
> 
> (obviously CONFIG_XARRAY_MULTI is enabled)
> 
> !node is almost certainly not true -- that's only the case if there's a
> single entry at offset 0, and we're talking about a situation where we
> have a large folio.
> 
> I think we have two cases to consider; one where we've allocated a new
> node because we split an entry from order >=6 to order <6, and one where
> we just split an entry that stays at the same level in the tree.
> 
> So let's say we're looking up an entry at index 1499 and first we got
> a folio that is at index 1024 order 9.  So first, let's look at what
> happens if it's split into two order-8 folios.  We get a reference on the
> first one, then we calculate offset as ((1499 >> 6) & 63) which is 23.
> Unless folio splitting is buggy, the original folio is in slot 16 and
> has sibling entries in 17,18,19 and the new folio is in slot 20 and has
> sibling entries in 21,22,23.  So we should find a sibling entry in slot
> 23 that points to 20, then return the new folio in slot 20 which would
> mismatch the old folio that we got a refcount on.
> 
> Then let's consider what happens if we split the index at 1499 into an
> order-0 folio.  folio split allocated a new node and put it at offset 23
> (and populated the new node, but we don't need to be concerned with that
> here).  This time the lookup finds the new node and actually returns the
> node instead of a folio.  But that's OK, because we'ree just checking
> for pointer equality, and there's no way this node compares equal to
> any folio we found (not least because it has a low bit set to indicate
> this is a node and not a pointer).  So again the pointer equality check
> fails and we drop the speculative refcount we obtained and retry the loop.

Thanks for the analysis. It is very helpful. I don't understand xarray
internals.

> Have I missed something?  Maybe a memory ordering problem?

I also considered reclaim/refault scenario, but I don't see anything.

Maybe memory ordering. Who knows. I guess we need more breadcrumbs.

The proposed change doesn't fix anything, but hides the problem.
It would be better to downgrade the VM_BUG_ON_FOLIO() to a warning +
retry.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

