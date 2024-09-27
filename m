Return-Path: <linux-fsdevel+bounces-30208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8734987C3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 02:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A291F24418
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FDEEA6;
	Fri, 27 Sep 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ae1hDkvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7AEACD;
	Fri, 27 Sep 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727398114; cv=none; b=B5YsZF+et1Nvq+wFvICWUVFc/vkSVVgPdQKYkOS8PdAT2rNiWub9aDyoj9ABDhIhOpXEW0/x3GSLp+5SKPzgh2EEvj/t4Uj0+w0cannl1VQ7vWzSI5EvGrY1JRKozxef2/Y9mquLXDKvZTpLHMvTbCo+YhTi/iXqCWZoEHRvfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727398114; c=relaxed/simple;
	bh=NZoZG5Fq/KN0fXsfXGJBfvPGTUFN3ANPPxnXaQGlogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsyzCO5/W/4YILfU/MQwEsmH0Mi79qxPKR6xFDJzGpAjjvF7RCtrY59vWLEkIvYE0HKct+wp/2q1/5wu3uSivcrmFxkEgGZ1iw3NT5RB6Ryb7pSACNYgU2zfX8hUKeOJhIULnn3kj/nC5p/dy4zA/lp8HGZKrPe62fYjl/ti2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ae1hDkvV; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UEwo8Z5dWn7UoZgdVw71nh1ggeBZQz2H3RZ0PCeeF84=; b=Ae1hDkvVuXXGOZm9UJW4yz8i37
	16+GvwjVbLy+LuFntcIMX87idMKt6tX3DKXJheVBVZwftahl2q/2UMLY0LRseEHL7nUQURCvtQFoH
	Hja+699crclwa/0odJPdTVsCzjLdgy+zbFYfK0KTD0T5+2Q70BJ/FNIlqHne4HvMoeNosqjdBUpJN
	oYOOr/NdYXBPt8rrzsNWFVAEhqEdQSXyNs9fcux76QmJORPWv4AO6cyl3Evrvh31bPOzFe7toSKuQ
	RopYUhpt7N83NSqL6UiqG4hWs3/mFmmHF96RD+R3qNSehIpwx/s3BfyuLHqXtS6565hJakUDG50OS
	klnKs14Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1styzg-0059mK-2F;
	Fri, 27 Sep 2024 08:48:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Sep 2024 08:48:14 +0800
Date: Fri, 27 Sep 2024 08:48:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvYAzh1gEw3u5nyD@gondor.apana.org.au>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
 <jeyayqez34guxgvzf4unzytbfgjv2thgrha5miul25y4eearp2@33junxiz2o7f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeyayqez34guxgvzf4unzytbfgjv2thgrha5miul25y4eearp2@33junxiz2o7f>

On Tue, Sep 24, 2024 at 10:48:07PM -0400, Kent Overstreet wrote:
>
> I've been noticing rhashtable resize is surprisingly heavy (the default
> parameters don't ever shrink the table, which is why it's not seen as
> much).

Most rhashtable users enable automatic shrinking.

> And, when I was torture testing that code I tripped over what appeared
> to be an infinite loop in rht_bucket() when a rehsah is in progress,
> which I worked around in
> 
>   a592cdf5164d bcachefs: don't use rht_bucket() in btree_key_cache_scan()

You must not walk the rhashtable internal data structures by hand.
If you need to iterate through the whole table, use the provided
walking mechanism.

However, as rhashtable is dynamic, walking it during a resize may
cause you to see some elements twice.  If you want to avoid that,
set up your own linked list of all elements for a completely stable
walk.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

