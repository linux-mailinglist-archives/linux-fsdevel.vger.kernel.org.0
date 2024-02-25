Return-Path: <linux-fsdevel+bounces-12732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF5862D46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 22:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51531C21271
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B51BC22;
	Sun, 25 Feb 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mjt0ivCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F221B953
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708897713; cv=none; b=KXgy/HAl7xGHmtMcXDx2KfIjsad6RlNQzcfrOSAJNYLoCApcLCNccItlw357CW5zhgalZmoDNrOhmc32kFbYhAGD/HYRRHasCW2vkElbbCWqEZU3mJnQ8YyoiCpnztaozWbMGgxt2mH3Q8ghvTzqNkr3yGn4kq3PRw6WYhp1ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708897713; c=relaxed/simple;
	bh=dvUDecwBMflNx4CehdCSDahY5V9l4jB2UPQiq5FVREc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrGO3lKtdX8cNFIsxe3qkcJpl2fAp1yoZey4wcbRZpsCZb9YsekUILfwa8Ku/zyHxMKtJz02+jKGgURr9rF6K5YR5q0ZUj9A0FY+qkaHztyAXw3X8Rky9V8nnMljwYVejAAM4KC9+u8NTHK3Z8o61sD3yJ/qouZpX33gSEa8sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mjt0ivCt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 16:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708897709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZLPGWILyQb0uie5XWZz0sri12gIiwEuygESDSHUCVk=;
	b=Mjt0ivCt7EdkAJ/tpZ4vBCFUaqud0EetWM2nBfj0PDARbuDEYfLiwPCmO+8FQyUf1FXdfK
	FVg/OoP8xi3mQ8sb+oDtygwMJ6YTysy3H6B6s8jKttLHwjCDctJ7K1/6COxMO8MIW170zO
	y1pGGRjGU3Mg12gJagPvuo4QwPQgzCU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Laight <David.Laight@aculab.com>
Cc: 'Herbert Xu' <herbert@gondor.apana.org.au>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Graf <tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <22nvcwzzfq3ae2eva6m43wolfo3b3pit7xsauuux267hxciigi@52zuwg5yorg5>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <2a6001442b354c2fb5b881c2a9d75895@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6001442b354c2fb5b881c2a9d75895@AcuMS.aculab.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 02:47:45PM +0000, David Laight wrote:
> From: Kent Overstreet
> > Sent: 25 February 2024 03:19
> ..
> > when I implemented cuckoo (which is more obviously sensitive to a weak
> > hash function), I had to go with siphash, even jhash wasn't giving me
> > great reslts. and looking at the code it's not hard to see why, it's all
> > adds, and the rotates are byte aligned... you want mixed adds and xors
> > and the rotates to be more prime-ish.
> > 
> > right idea, just old...
> > 
> > what would be ideal is something more like siphash, but with fewer
> > rounds, so same number of instructions as jhash. xxhash might fit the
> > bill, I haven't looked at the code yet...
> 
> There is likely to be a point where scanning a list of values
> for the right hash value is faster than executing a hash function
> that is good enough to separate them to separate buckets.

Executing a bunch of alu ops that parallelize nicely is _fast_
(it's all xors/adds/rotates, chacha20 is a good example of how
the modern stuff works).

Also, for 2-way cuckoo there's an xor trick so you don't need to compute
a second hash.

But the key thing about cuckoo is that the loads on lookup _aren't
dependent_ - they can run in parallel. Every cache miss that goes all
the way to DRAM is stupidly expensive, remember - hundreds of
instructions, had you been able to keep the pipeline fed.

> You don't want to scan a linked list because they have horrid
> cache footprints.
> The locking is equally horrid - especially for remove.
> Arrays of pointers ar ethe way forward :-)

Well, maybe; I'm waiting to see fill factor numbers and benchmarks. Fill
factor was my concern when I was playing around with the concept; I used
it in a place where the hash table didn't need to be that big, and the
point was to avoid having to separately allocate the entries (and it
avoids the hassle of tombstone entries with linear/quadratic probing).

The fact that it requires a second dependent load, because buckets are
separately allocated, also looks like a big negative to me. I still
think a good lockless cuckoo hashing implementation ought to beat it.

