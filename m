Return-Path: <linux-fsdevel+bounces-10078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48184798F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696FE285213
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614D15E5C4;
	Fri,  2 Feb 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nW/FA4Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F715E5AF;
	Fri,  2 Feb 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901738; cv=none; b=q/3EQGNaVKcZs+avTQvSLweA+fMX0edtEt/OJjXZbePRFyHtd07XI1PZRgQAGKuVKqBsPXIAiCi0IvpxKwPugGh4BfQbEXmYvipmOgWhyvA5PCSCNprnmmKgMHu82fIJw8Os6413fIZIhKG/evldQTNT6+HXAC6rnBEi5Nn5Xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901738; c=relaxed/simple;
	bh=it57iC0Igo2jLKJwB8vC8jU7CPpKri8373gtvCysQz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTrYKjYgS2aPdATOaK/0vlbHbRY3dQ1Bz/bD0w2y9NCPbzCLgyB0XksDxj1MAI0DlNtYEfp+J9KGKcOidA7Ns3TpkkLWm4mApA3MFoaFBVD5NzS6eRYuHUGmhTtAVpNES+B6uwGyHvYGbAf55/eSJ6Xp4rkageC2Dx5XyFaQjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nW/FA4Uy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eL4LwatgR0k7zkyz5LeWPxwi/V/nQ0lFnAvigMlFZ0s=; b=nW/FA4Uyt8zdHwT6NLbAYLGz2g
	EdNmZ0RFlDFl6Cg3+HLSqSutlQAX42Vhdo0i2vUU5fW7g99ur14g9H8dTRDy539219y7agQyqrXNY
	fJnTi6fZTy9kNmzOWDyG08Up16q8ByCJQZzu9BSQhYbad2yl3rINCQoUgcUoBUskUMdPFZS9q6n7/
	V/iaawGVobY3BzdAsGmL4xFiG4EjMo4zYGf9fEPMsnQpKcxdCjEUBpyVw2piZWJWUa82tBHEWmbgS
	aMDTHT1feqgXxG2839cruejVUfnXorPLiZLTWwkQh1V43t9FzWQzzNJrod3ZCmqs4Bi/NlsPTC3Rr
	wU5HANeA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVz75-00000001sSe-3iYR;
	Fri, 02 Feb 2024 19:22:11 +0000
Date: Fri, 2 Feb 2024 19:22:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <Zb1A44esSQVJOezg@casper.infradead.org>
References: <Zbz8VAKcO56rBh6b@casper.infradead.org>
 <2701740.1706864989@warthog.procyon.org.uk>
 <2761655.1706889464@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2761655.1706889464@warthog.procyon.org.uk>

On Fri, Feb 02, 2024 at 03:57:44PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > So my modest proposal is that we completely rearchitect how we handle
> > swap.  Instead of putting swp entries in the page tables (and in shmem's
> > case in the page cache), we turn swap into an (object, offset) lookup
> > (just like a filesystem).  That means that each anon_vma becomes its
> > own swap object and each shmem inode becomes its own swap object.
> > The swap system can then borrow techniques from whichever filesystem
> > it likes to do (object, offset, length) -> n x (device, block) mappings.
> 
> That's basically what I'm suggesting, I think, but offloading the mechanics
> down to a filesystem.  That would be fine with me.  bcachefs is an {key,val}
> store right?

Hmm.  That's not a bad idea.  So instead of having a swapfile, we
could create a swap directory on an existing filesystem.  Or if we
want to partition the drive and have a swap partition we just
mkfs.favourite that and tell it that root is the swap directory.

I think this means we do away with the swap cache?  If the page has been
brought back in, we'd be able to find it in the anon_vma's page cache
rather than having to search the global swap cache.

> > I think my proposal above works for you?  For each file you want to cache,
> > create a swap object, and then tell swap when you want to read/write to
> > the local swap object.  What you do need is to persist the objects over
> > a power cycle.  That shouldn't be too hard ... after all, filesystems
> > manage to do it.
> 
> Sure - but there is an integrity constraint that doesn't exist with swap.
> 
> There is also an additional feature of fscache: unless the cache entry is
> locked in the cache (e.g. we're doing diconnected operation), we can throw
> away an object from fscache and recycle it if we need space.  In fact, this is
> the way OpenAFS works: every write transaction done on a file/dir on the
> server is done atomically and is given a monotonically increasing data version
> number that is then used as part of the index key in the cache.  So old
> versions of the data get recycled as the cache needs to make space.
> 
> Which also means that if swap needs more space, it can just kick stuff out of
> fscache if it is not locked in.

Ah, more requirements ;-)

> > All we need to do is figure out how to name the lookup (I don't think we
> > need to use strings to name the swap object, but obviously we could).  Maybe
> > it's just a stream of bytes.
> 
> A binary blob would probably be better.
> 
> I would use a separate index to map higher level organisations, such as
> cell+volume in afs or the server address + share name in cifs to an index
> number that can be used in the cache.
> 
> Further, I could do with a way to invalidate all objects matching a particular
> subkey.

That seems to map to a directory hierarchy?

So, named swap objects for fscache; anonymous ones for anon memory?

