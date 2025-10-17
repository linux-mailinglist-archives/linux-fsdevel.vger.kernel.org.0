Return-Path: <linux-fsdevel+bounces-64508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D518BEAF18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CC81AE2ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5CB2F361F;
	Fri, 17 Oct 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="LYEeNVUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHyF/q8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BE2F1FFA;
	Fri, 17 Oct 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720418; cv=none; b=VSOeztvJOWCFFdXpWGYqX8DseJ34VW7mZVhQgluVbkxFq/bI+ZX053iwVCncdpnU0DtcFsDKLDO0Do2wXUx9jLwX5VF2LSQZGZz1A6XKD4xX+uaZOjrbABQdRJwCUStZr4fvXmF+9GiXVi3XSm47Ym8ZszblceGRbExO7qhrE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720418; c=relaxed/simple;
	bh=LkKHTc+flctuXYq0MGe/r5VNBCk/+J7P1uANnUIrz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpEvD4lrWyaKR2YvGXhkKpr6mfJsklS8I+y0+rN4dlZ6rJ+xJVvOhasgi4ZNIRotG8m2pMk9sMBkxDnvFAw7hzbKfrzNGNx8v7LwfWnDiXJDwvT/9KnQ7PyfU38z1e5xHoIryPzlNtYEoAem2vBSl3l3v70R3fTiGL60+ePndQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=LYEeNVUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHyF/q8a; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 8DE74130074E;
	Fri, 17 Oct 2025 13:00:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Oct 2025 13:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760720413; x=
	1760727613; bh=FHeABDDNpBcuH/HxHTgtiS8h1Pih1w3YqjzpkSvYXEk=; b=L
	YEeNVUi/9EqRu8aINAmTgi97ip/bfdsnzAod6qhb1fATOgyYJOymJ61PJdRpLbfz
	KE/5rtXyrO5mxjBAgsf2XX3uAK94kscXmKkAo692H/rdYW7750fgVEN5LeDXAO3u
	AkPKykEO4qGIMy8DckWtbE1xfKTdbn3fofU5VYQklmK1Frt2YdfNWM/rszptGF3D
	MSCLY6wSin1fAd9CsjADQ6V3M5lEZ7T9iP0/3i/i+N5Q8K+Go4bG+RrV3B9e0g9W
	z3b0Rzc7mJnWPN0ADSKWFWrs+F+uDRGb0k+DO7vhv+anGTDmvqxkYBHqDTW15p0f
	FaWEKXHczG1iXljTUT0iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760720413; x=1760727613; bh=FHeABDDNpBcuH/HxHTgtiS8h1Pih1w3Yqjz
	pkSvYXEk=; b=lHyF/q8auVcPkYBtF/i4yGzZNyGpmUeLbBTOhY5tXfkGtWcrhby
	brA66/eRwRTjQKfL86nlHFYvvCFfG8+PEiBZrxAKSzH/FSQEfizDxoAcgXv+tFun
	MpLiM1IytVS5i/HtEIS5isZWtzPG/OFZarK8ww0lwqQwpfytffqF10i67BSJxUFD
	T/mGFZKDepkl1wqRcIuqAt+QrdFJMg4Nx2lrWhZ8n/Paz9WtYah+O9k4sR8eJFCJ
	WlbibUAIwLR7PUzzr3OZqdnL1HXqP9KhAjMgHQzMEbpX4nko66NejRuGljWVfyU9
	dJxJjv6ed17yPYjslzVmDMPdLOZ/kB92Bwg==
X-ME-Sender: <xms:HHbyaF50ErfQ7-IyA2sJ_MPN6iRS1Wbxo11_-S2HR4z9pPDS6Sx2jw>
    <xme:HHbyaDXHfG0R7heMApuKjBTsSfdt4TEWE1c-2XKTXxikp4bkfm3cIcY3xFiJxo4ud
    KIkGOL2BPG9h7X9skeG7MGcu6ROqDDY21XMp4FlyEu_DCP_gPReIeA>
X-ME-Received: <xmr:HHbyaB6ztCj2bQSfrFMoqKlCenY59AGw9wcmDhJ2v7JFc9fR3UX-hoong955Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprh
    gtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgt
    ghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprdhrrghghhgrvhesshgrmh
    hsuhhnghdrtghomhdprhgtphhtthhopeiilhgrnhhgsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:HHbyaMGOveeNjZzAudyjrneAsdQGCnxByQQ3CeT6yrPQXV1mM_U-sQ>
    <xmx:HHbyaM-mmumzQdSLYF_ohtJW-tIDdjFEnZRfFZiRd7Put-BzBVmH9w>
    <xmx:HHbyaGUHVMec6kjyA4moEn1w_zq_DjqTYrS7npJoD7GOn0HPmlX34g>
    <xmx:HHbyaGHJSStwXVZPq5lbZP0eP8Y8sp0bv-dbLF7I2qita5FdKSZl9Q>
    <xmx:HXbyaGDxeFYyep87XcNsuCiogm5tjteWZHVpNxCOXMXxQ3J93r6agDIe>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 13:00:11 -0400 (EDT)
Date: Fri, 17 Oct 2025 18:00:09 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Darrick J. Wong" <djwong@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>, akpm@linux-foundation.org, 
	linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <r74wgxke6ewkt3okbkrnd6lbatjrms4rcxws7dhvfwf2oi4yb4@g5aev2vz4nl4>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
 <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
 <aPFyqwdv1prLXw5I@dread.disaster.area>
 <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>
 <20251017160241.GF6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017160241.GF6174@frogsfrogsfrogs>

On Fri, Oct 17, 2025 at 09:02:41AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 17, 2025 at 03:28:32PM +0100, Kiryl Shutsemau wrote:
> > On Fri, Oct 17, 2025 at 09:33:15AM +1100, Dave Chinner wrote:
> > > On Thu, Oct 16, 2025 at 11:22:00AM +0100, Kiryl Shutsemau wrote:
> > > > On Wed, Oct 15, 2025 at 10:57:26AM -0700, Darrick J. Wong wrote:
> > > > > On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> > > > > > On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > > > > > > Hi there,
> > > > > > > 
> > > > > > > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > > > > > > with the following:
> > > > > > > 
> > > > > > > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > > > > > > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > > > > > > @@ -1,2 +1,10 @@
> > > > > > >  QA output created by 749
> > > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > > >  Silence is golden
> > > > > > > 
> > > > > > > This test creates small files of various sizes, maps the EOF block, and
> > > > > > > checks that you can read and write to the mmap'd page up to (but not
> > > > > > > beyond) the next page boundary.
> > > > > > > 
> > > > > > > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > > > > > > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > > > > > > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > > > > > > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > > > > > > to the second 4096 bytes should produce a SIGBUS.
> > > > > > 
> > > > > > Does anybody actually relies on this behaviour (beyond xfstests)?
> > > > > 
> > > > > Beats me, but the mmap manpage says:
> > > > ...
> > > > > POSIX 2024 says:
> > > > ...
> > > > > From both I would surmise that it's a reasonable expectation that you
> > > > > can't map basepages beyond EOF and have page faults on those pages
> > > > > succeed.
> > > > 
> > > > <Added folks form the commit that introduced generic/749>
> > > > 
> > > > Modern kernel with large folios blurs the line of what is the page.
> > > > 
> > > > I don't want play spec lawyer. Let's look at real workloads.
> > > 
> > > Or, more importantly, consider the security-related implications of
> > > the change....
> > > 
> > > > If there's anything that actually relies on this SIGBUS corner case,
> > > > let's see how we can fix the kernel. But it will cost some CPU cycles.
> > > > 
> > > > If it only broke syntactic test case, I'm inclined to say WONTFIX.
> > > > 
> > > > Any opinions?
> > > 
> > > Mapping beyond EOF ranges into userspace address spaces is a
> > > potential security risk. If there is ever a zeroing-beyond-EOF bug
> > > related to large folios (history tells us we are *guaranteed* to
> > > screw this up somewhere in future), then allowing mapping all the
> > > way to the end of the large folio could expose a -lot more- stale
> > > kernel data to userspace than just what the tail of a PAGE_SIZE
> > > faulted region would expose.
> > 
> > Could you point me to the details on a zeroing-beyond-EOF bug?
> > I don't have context here.
> 
> Create a file whose size is neither aligned to PAGE_SIZE nor the fs
> block size.  The pagecache only maps full folios, so the last folio in
> the pagecache will have EOF in the middle of it.
> 
> So what do you put in the folio beyond EOF?  Most Linux filesystems
> write zeroes to the post-EOF bytes at some point before writing the
> block out to disk so that we don't persist random stale kernel memory.
> 
> Now you want to mmap that EOF folio into a userspace process.  It was
> stupid to allow that because the contents of the folio beyond EOF are
> undefined.  But we're stuck with this stupid API.
> 
> So now we need to zero the post-EOF folio contents before taking the
> first fault on the mmap region, because we don't want the userspace
> program to be able to load random stale kernel memory.
> 
> We also don't want programs to be able to store information in the mmap
> region beyond EOF to prevent abuse, so writeback has to zero the post
> EOF contents before writing the pagecache to disk.
>
> > But if it is, as you saying, *guaranteed* to happen again, maybe we
> > should slap __GFP_ZERO on page cache allocations? It will address the
> > problem at the root.
> 
> Weren't you complaining upthread about spending CPU cycles?  GFP_ZERO
> on every page loaded into the pagecache isn't free either.

+Linus.

True. __GFP_ZERO is stupid solution.

I think the folio has to be fully populated on read up from backing
storage. Before it is marked uptodate. If it crosses i_size, the tail
has to be zeroed. No additional overhead for folios fully with i_size.

But if you insist that is inevitably going to be broken, __GFP_ZERO
would solve problem with data leaking at the root.


Whether to zero the memory again on writeback is less critical in my
view. It could only have whatever legitimate user wrote there and is not
a data leak. Or am I wrong?

> > Although, I think you are being dramatic about "*guaranteed*"...
> 
> He's not, post-EOF folio zeroing has broken in weird subtle ways every
> 1-2 years for the nearly 20 years I've worked in filesystems.
> 
> > If we solved problem of zeroing upto PAGE_SIZE border, I don't see
> > why zeroing upto folio_size() border any conceptually different.
> > Might require some bug squeezing, sure.
> 
> We already do that, but that's not the issue here.
> 
> The issue here is that you are *breaking* XFS behavior that is
> documented in the mmap manpage.  This worked as documented in 6.17, and
> now it doesn't work.

As I described, it was broken, but in a less obvious way. Order-9 folios
are mapped as PMD regardless of i_size before my recent changes. They
*usually* get split on truncate, but it is not guaranteed because split
can fail.

We can "fix" this too by giving up mapping folios as PMD (or coalesced
PTEs) if they cross i_size boundary.

I think it is bad trade off. It will require more work in page fault and
reduce TLB hit rate.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

