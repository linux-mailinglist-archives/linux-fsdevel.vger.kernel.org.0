Return-Path: <linux-fsdevel+bounces-30297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4A988D37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 02:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ACFAB21D15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130411CA1;
	Sat, 28 Sep 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="OYQ+MFgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134910A19;
	Sat, 28 Sep 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727484465; cv=none; b=uC4zQX//TlAonPhn8ObN9tOCIXes6sGSpiH2mAcG8wGX6BZVmEo1V+TaIF8yptXdqEO5A4EbVtQuI9XFi+AtBVCL+8hdPef6WCN1hskVqv81xYHioONXntgnt5ClWR4sSpRMoXMh6pPUl2Uqvq+okn5DSyUsQygPlhgna7ppii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727484465; c=relaxed/simple;
	bh=yCsVypw9UcLb+YOktbLz1AblsRn70oqRwRo8CRYU4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI4DJmUuhtBbHC0T5z94jWngIiKQogqE3FA9yXM6ZxDo8OBWodb2LZ5AL3QovvCIhbWCT94XeMlLyBF1FImp9Vv9jp27S8eogJCqB6PZhRQmYcVI4VPgl+s7QU5NVKMalMPBWJBuYL7kUvMVQW+ENSnIc2wGL6HAd2XLv8qi4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=OYQ+MFgD; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qYqPtrNpt3gRQXhveLSu29jwHNc5+OrTNCW/cEqmJZI=; b=OYQ+MFgDgj+inwXcaaRck8R88n
	91tJZ/vrIwoXGAgZEAcadqNiy744DHQdIbeaE/mEXs5u/8hoWwCkjLm4cmneD9Bv8kGkV9oB0P46K
	5gkGdlpOQN26QVSa/NjlLo8cLEfv7l6vm1p5fYvo09zo5TX0PsQhnheG7YMVWbquKdSw74qaxkdvd
	EziXONHxNpiuZnSxDmLz2jPsxGuWLRDeP0Ld+RF3Z4TfnfKdiv0UpWwRwfPxCtd9uBpocNBd7C/TE
	OLpLJeel3kdjVJ7HEFGdy31dWwpToVcKF0zZ3lQZTy8lSG8jxGPBwkwqZix7tbIH0LYAgrm3YUo+V
	fPjA8hFg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1suLSK-005Mey-37;
	Sat, 28 Sep 2024 08:47:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 28 Sep 2024 08:47:18 +0800
Date: Sat, 28 Sep 2024 08:47:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvdSFlaEkk7fqZVl@gondor.apana.org.au>
References: <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
 <jeyayqez34guxgvzf4unzytbfgjv2thgrha5miul25y4eearp2@33junxiz2o7f>
 <ZvYAzh1gEw3u5nyD@gondor.apana.org.au>
 <nlwn4yodlo54hdbyil3kyxhaqgg5dmmdfvizsyj77oczgzezt2@m3qbtep3fhln>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlwn4yodlo54hdbyil3kyxhaqgg5dmmdfvizsyj77oczgzezt2@m3qbtep3fhln>

On Fri, Sep 27, 2024 at 08:11:06PM -0400, Kent Overstreet wrote:
>
> > > And, when I was torture testing that code I tripped over what appeared
> > > to be an infinite loop in rht_bucket() when a rehsah is in progress,
> > > which I worked around in
> > > 
> > >   a592cdf5164d bcachefs: don't use rht_bucket() in btree_key_cache_scan()
> > 
> > You must not walk the rhashtable internal data structures by hand.
> > If you need to iterate through the whole table, use the provided
> > walking mechanism.
> 
> I was just doing rht_for_each_entry_rcu() (open coded because you don't
> provide a safe version).

I'm talking about the commit a592cd above.  You were doing this:

	for (i = 0; i < tbl->size; i++)
		rht_for_each_entry_rcu(ck, pos, tbl, i, hash) {

This is absolutely not allowed.  The rhashtable must only be accessed
through the published API and not iterated over directly.  This is
guaranteed to break during a resize/rehash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

