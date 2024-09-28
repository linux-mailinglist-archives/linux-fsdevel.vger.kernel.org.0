Return-Path: <linux-fsdevel+bounces-30296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD4C988D22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 02:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80E41F22192
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27657494;
	Sat, 28 Sep 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGRVXxCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE803C0B
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Sep 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482275; cv=none; b=QEkTmjBfubbb4qtA5rcuDVin8ElcrmfGxfOAL+nU6lILCWaNyyTQD+DixHsyBoy4r2855A4y+0wWd3SfDxBvX5BbeWaGBYhUXO6bZYwiNfVN9U46VuOkeuWwIp+8YdrIJza973DrlFnreg7Gw3zOkDzzcXLJB09r3/Y5zHwljZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482275; c=relaxed/simple;
	bh=4diWrNHrePOMA8xSdvVndkk4fzZ/RX3fUE7c6KjSltg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVYQ1HlaJk3v1HNEtCt84pvbvT3Al/hg9hVsZZmM51sOBF4Np4YSdiezkwh54yvUw0Uc0FjdOBpTuxvAUp2eLKZVW0uRsmx1xeM18nQbokxbCYn1wi0gKLNcgS0eK8VOKKK6UmJwSuZeXPRHPO9NzHMsyVZlHQrJmqmSFCZxyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGRVXxCs; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Sep 2024 20:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727482271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrqukxTWx5XrBVnAUtnZnhHOGhnkF/yjI6dQx0NlESs=;
	b=AGRVXxCsWx5L22ff0J4oB5zCbKNrYkwwmFIwvfXPV7PdV3hoRJ1iVEIttc2pOM/80JQDcq
	WLgq9OKBdgHNvgAlxKjAoaTN7U97/RVyMJiviuF88BedHYDfr6POEr8tnMB/IywAp1d4CZ
	StGBJwW2+qkLiXxacEFJ3h/r7qb/DsY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dave Chinner <david@fromorbit.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <nlwn4yodlo54hdbyil3kyxhaqgg5dmmdfvizsyj77oczgzezt2@m3qbtep3fhln>
References: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
 <jeyayqez34guxgvzf4unzytbfgjv2thgrha5miul25y4eearp2@33junxiz2o7f>
 <ZvYAzh1gEw3u5nyD@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvYAzh1gEw3u5nyD@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 27, 2024 at 08:48:14AM GMT, Herbert Xu wrote:
> On Tue, Sep 24, 2024 at 10:48:07PM -0400, Kent Overstreet wrote:
> >
> > I've been noticing rhashtable resize is surprisingly heavy (the default
> > parameters don't ever shrink the table, which is why it's not seen as
> > much).
> 
> Most rhashtable users enable automatic shrinking.
> 
> > And, when I was torture testing that code I tripped over what appeared
> > to be an infinite loop in rht_bucket() when a rehsah is in progress,
> > which I worked around in
> > 
> >   a592cdf5164d bcachefs: don't use rht_bucket() in btree_key_cache_scan()
> 
> You must not walk the rhashtable internal data structures by hand.
> If you need to iterate through the whole table, use the provided
> walking mechanism.

I was just doing rht_for_each_entry_rcu() (open coded because you don't
provide a safe version).

> However, as rhashtable is dynamic, walking it during a resize may
> cause you to see some elements twice.  If you want to avoid that,
> set up your own linked list of all elements for a completely stable
> walk.

Yeah that's fine, but like I said, I was seeing an infinite loop inside
rht_bucket(). That would be an rhashtable bug...

