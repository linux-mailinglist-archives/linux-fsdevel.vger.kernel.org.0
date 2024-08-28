Return-Path: <linux-fsdevel+bounces-27662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215D96351F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11991F22F21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EC1AD9EC;
	Wed, 28 Aug 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jO8UfRbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31F14BF8D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885932; cv=none; b=NvVZqOFuQXfayPSi3JRV5VOfKeJ9MGd88WEHL+NqeFhnYudtM/Xf8BOS0Efrgicy6heaAgEwBOUXFEV4WLJKCEDEcQsk1mTrKg6IkfnHjDsh/XTqK9WjEjsCAT75JqD/82ZwehL3SPwU0PDzO/5KyI8fTsm9MsmY6M0fpihd2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885932; c=relaxed/simple;
	bh=KxorIJ7llLzBSjs83yOETwE1Gn6/3ROnqcFhYI0rCI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucl4VGfBJ57Xshmdz+RaMcckyGMudmYWM6rZua8MZWc6HLUYncF9HvYEoPu34rJUgaL1PXcvjuk5q8kDFI7XTdU7PQyU8W1gnU89BLwqb4/qyNm8nS4QjCjKVXQp1YSxBHzwYOmTgBi9iF514jfHgWXowuczcu0a4sRorxqZFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jO8UfRbS; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 18:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724885927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y+KL6eyJT0WZ4G/3MDB1ADSECvGADNZEvjLZdjJmno=;
	b=jO8UfRbSvTlKwGbGO1SWxPISd9Oifb7my57CV2jUzlCzyC1pGXTD1cRKeKbppb4YSPzsnj
	+V0QqcLpILXiMCfIX3WU2w59Td+p5SLQ3PGxy3I/HHbjmYTDMmG3ymMl8bpS5nOtnjOvx1
	AkhGJU9hy6nK1v3V6HDAIJ2Cy6f5Z50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs959Pa5H5WeY5_i@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> > On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> > > On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > > > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > > > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > > > unsafe locks is a potential deadlock.
> > > 
> > > Kent, the approach you've taken with this was NACKed.  You merged it
> > > anyway (!).  Now you're spreading this crap further, presumably in an effort
> > > to make it harder to remove.
> > 
> > Excuse me? This is fixing a real issue which has been known for years.
> 
> If you mean a lack of GFP_NOWAIT support in vmalloc then this is not a
> bug but a lack of feature. vmalloc has never promissed to support this
> allocation mode and a scoped gfp flag will not magically make it work
> because there is a sleeping lock involved in an allocation path in some
> cases.
> 
> If you really need this feature to be added then you should clearly
> describe your usecase and listen to people who are familiar with the
> vmalloc internals rather than heavily pushing your direction which
> doesn't work anyway.

Michal, I'm plenty familiar with the vmalloc internals. Given that you
didn't even seem to be aware of how it doesn't respect gfp flags, you
seem to be the person who hasn't been up to speed in this discussion.

> > It was decided _years_ ago that PF_MEMALLOC flags were how this was
> > going to be addressed.
> 
> Nope! It has been decided that _some_ gfp flags are acceptable to be used
> by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
> modifiers and other flags so these are indeed safe to be used that way.

Decided by who?

Cite the list discussion, and the reasoning.

> > > Stop it.  Work with us to come up with an acceptable approach.  I
> > > think there is one that will work, but you need to listen to the people
> > > who're giving you feedback because Linux is too big of a code-base for
> > > you to understand everything.
> > 
> > No, you guys need to stop pushing broken shit.
> 
> This is not the way to work with other people. Seriously!

No, your patches and the reasoning you've been pushing are broken.

A safe interface is not one that "does not fail", a safe interface is
one that never invokes undefined behaviour - and generally that means
it'll return an error instead.

And programming in the kernel means that you check for errors, period.

This idea that you have of "safety" meaning "we'll just conveniently
remove or ignore the cases where GFP_NOFAIL would have to fail" is
complete and utter garbage.

