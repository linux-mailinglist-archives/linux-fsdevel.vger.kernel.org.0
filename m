Return-Path: <linux-fsdevel+bounces-57582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A5B23A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D3D178AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CFD2D0624;
	Tue, 12 Aug 2025 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ocj8znkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F932F0666;
	Tue, 12 Aug 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032252; cv=none; b=LaijVCdPVsxSZwmAAhGQbIIPF7zsV5fu4RsjI+siEFEmOuqFaSp/nOvd22YIfHgi7d3h13QgeL+iTYWaEZi4XrUJGl/uX0BKVSWElC9RR0vJ90fu5mweW5L805+mqRw1rsHrE2OYJIufpo3nB/dWRL3MuDzxMaMCS+V18WgCBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032252; c=relaxed/simple;
	bh=UjqKcPavgi3v8eyPCYAxsYZ2g7dIP2TKc/biQ4qOReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysf/nog8S1BDVwAGb9XkQnJbih8B0Ye9/HAI3M8R5Rj+Kc017hKdVlVpUanuFx2rGJrwFMXc7/Q5N5vLJy3mnFwLSl9uj0W9u8H/GFDGk1/szEztLIblWg1nTFJ1TvTMhfAyEl6ueZP4Z0DST0/bF89A+wEZA/5tXtvBenYdAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ocj8znkQ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 16:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755032237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2e80lClZC+hroA+JpkDKoaIfGaNEpk1W7TgTtMAGMI=;
	b=ocj8znkQG9LEv17BE+sL93aDDrH7o5lEkGwxKeLptm7IN+xGYDqa982CG7odUZcBYhPlR7
	KasC3WvNxhy9ztsmoo6RduIhzmM3zD3jjMsW8w2SmNoAdmNWZ1p8UAMSL2dHJVIOSjMMIc
	hv+x9uwPYskBkFbjO5fmFXeMtES+U7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <eby2jl7aidtbodivalgyha6w6pvesh6rgr765b2sr4vuv3z3r5@gspmak4tg4wu>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
 <aJukdHj1CSzo6PmX@kbusch-mbp>
 <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>
 <aJumQp0Vwst6eVxK@kbusch-mbp>
 <ib4xuwrvye7niwgubxpsjyz7jqe2qnvg2kqn7ojossoby2klex@kuy5yxuqnjdf>
 <aJup_fo6b6gNrGF0@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJup_fo6b6gNrGF0@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 02:54:21PM -0600, Keith Busch wrote:
> On Tue, Aug 12, 2025 at 04:45:48PM -0400, Kent Overstreet wrote:
> > On Tue, Aug 12, 2025 at 02:38:26PM -0600, Keith Busch wrote:
> > > On Tue, Aug 12, 2025 at 04:31:53PM -0400, Kent Overstreet wrote:
> > > > If you're interested, is it time to do some spec quoting and language
> > > > lawyering?
> > > 
> > > If you want to start or restart a thread on the block list specificaly
> > > for that topic, then sure, happy to spec talk with you. But I don't want
> > > to chat on this one. I just wanted to know what you were talking about
> > > because the description seemed underhanded.
> > 
> > Not underhanded, just straightforward - I've seen the test data, and the
> > spec seemed pretty clear to me...
> 
>   "the block layer developer who went on a four email rant where he,
>    charitably, misread the spec or the patchset or both"
> 
> Please revisit the thread and let me know me if you still stand by that
> description. I've no idea if you're talking about me or one of the other
> block developers on it, but I frankly don't see anything resembling what
> you're describing.

Well, since you asked, Christoph...

I want to say - no hard feelings, things being frosty between us goes
way back, and we've recently made efforts to work better together. But
that was pretty hard to respond to.

