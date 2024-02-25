Return-Path: <linux-fsdevel+bounces-12691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21118628BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 02:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406C0282211
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D14C94;
	Sun, 25 Feb 2024 01:22:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DF10E4;
	Sun, 25 Feb 2024 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708824140; cv=none; b=KHU3sOVhBiUH/JVQf0qq2MSW6GiWyYSwv9vnBtY5KTucuOwDZdYviMx0SFxfl37qkqezTO292Ykg++WrO6C6iiGB3RvJvAoR9514U80geQgg58J2cxrpM0NFio7up8Vs7R58/jIOl0p/ds8um6wbpz1MdFJOwzL9I2ST/wH/blQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708824140; c=relaxed/simple;
	bh=8MxMrxDjatcZ9KrlHxfNOi3v9JyPHdQJ3JtwZyYIXhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt77nqfgl2MyzI0N3+BgYEVMenMMHKWX3WVO66WI4FHHUqqf33306BdiuM+KOJqKth5jobvfM+zjQQkda0BYEWkkKHUNvyxYk69XpXFkH0Ek4KuybcAcRsY0Z8xCEaFf9eZi4p/IUilPmvuuJNw2eT4rxZUqviiJHPXrphuQ0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1re2ij-00HTZ9-Uf; Sun, 25 Feb 2024 08:50:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 25 Feb 2024 08:50:36 +0800
Date: Sun, 25 Feb 2024 08:50:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Laight <David.Laight@aculab.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <ZdqO3G6Fb4wYhVEj@gondor.apana.org.au>
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

On Sat, Feb 24, 2024 at 10:10:27PM +0000, David Laight wrote:
>
> > Normally an rhashtable gets resized when it reaches 75% capacity
> > so the average chain length should always be one.
> 
> The average length of non-empty hash chains is more interesting.
> You don't usually search for items in empty chains.
> The only way you'll get all the chains of length one is if you've
> carefully picked the data so that it hashed that way.

Sure.  But given the 75% capacity, you'd need a really bad hash
function to get an *average* (not worst-case) chain length of
10.

> I remember playing around with the elf symbol table for a browser
> and all its shared libraries.
> While the hash function is pretty trivial, it really didn't matter
> whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
> chains were always long.

Even in the unlikely event of bad luck and everything bunches up
together, we change theh hash function (through hash_rnd) every
time we resize so you would expect things to even out after the
resize event.

A rehash is also automatically triggered if the worst-case chain
length exceeds 16.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

