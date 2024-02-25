Return-Path: <linux-fsdevel+bounces-12694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591728628F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5A1F21596
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53C7484;
	Sun, 25 Feb 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TtTotn1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA95664
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831119; cv=none; b=kmph+gDaec80+rB/Xqxl2leKED8nIlLDCJf0yBjtXh3TqmMA0dgVl51SrhNNvHWUkDryMyZ4Ufjxm7SanbOSBLMAd5oVJuPrkmztdCpL5zA64RfBql8qRxfMnnEZEukOwfY31z8JCWHMQqQYtN/N6LmnY5d21vKUzEbPROt4tOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831119; c=relaxed/simple;
	bh=H6aDVYj/xJAeBB4FwsyU9gVzxd5e8XFBkWclh4nutxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9nDinX4860j+YMvLeHg29utSIJSrpQ6lwrObxSYshEWs2gk5fK7u36DFfU/62W2p1LwYYZmvF91pyQpu0bmx/dHH22ztU94jn5RbZsaWmuCKCK4As8qjSUDSUw9p+ikV4WHDBQjtOWnHdvxxU66h9N7PZpVdRIx2Q3Q6uhK8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TtTotn1Z; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Feb 2024 22:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708831115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFn6W6U4L0su1Wfy+lZLYSD3C6FtmzaANUHZ73XSo8o=;
	b=TtTotn1Zt7Oioseodlv67q6zr9SBuqavSMX1nUmBb4idYhnyma3q5JhSBaE9ICRZmiRzSm
	4Drn0ijg1NjwxZKo/uOP3C7lC+PU++Gr//SaDHpnX2Gx2+nN4ZQNYITNBk2Xs+gqqijeFf
	iCIvatgD8wiNm4CrIepy4PmqSBDsxyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Laight <David.Laight@aculab.com>
Cc: 'Herbert Xu' <herbert@gondor.apana.org.au>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Graf <tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 24, 2024 at 10:10:27PM +0000, David Laight wrote:
> From: Herbert Xu
> > Sent: 24 February 2024 00:21
> > 
> > On Thu, Feb 22, 2024 at 08:37:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > >
> > > Where I expect rosebush to shine is on dependent cache misses.
> > > I've assumed an average chain length of 10 for rhashtable in the above
> > > memory calculations.  That means on average a lookup would take five cache
> > > misses that can't be speculated.  Rosebush does a linear walk of 4-byte
> > 
> > Normally an rhashtable gets resized when it reaches 75% capacity
> > so the average chain length should always be one.
> 
> The average length of non-empty hash chains is more interesting.
> You don't usually search for items in empty chains.
> The only way you'll get all the chains of length one is if you've
> carefully picked the data so that it hashed that way.
> 
> I remember playing around with the elf symbol table for a browser
> and all its shared libraries.
> While the hash function is pretty trivial, it really didn't matter
> whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
> chains were always long.

that's a pretty bad hash, even golden ratio hash would be better, but
still bad; you really should be using at least jhash.

you really want a good avalanche effect, because in real world usage
your entropy is often only in a relatively few bits.

when I implemented cuckoo (which is more obviously sensitive to a weak
hash function), I had to go with siphash, even jhash wasn't giving me
great reslts. and looking at the code it's not hard to see why, it's all
adds, and the rotates are byte aligned... you want mixed adds and xors
and the rotates to be more prime-ish.

right idea, just old...

what would be ideal is something more like siphash, but with fewer
rounds, so same number of instructions as jhash. xxhash might fit the
bill, I haven't looked at the code yet...

