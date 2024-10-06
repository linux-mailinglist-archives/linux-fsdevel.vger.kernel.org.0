Return-Path: <linux-fsdevel+bounces-31102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C1991BE7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 03:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894481C20E3A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D435166F14;
	Sun,  6 Oct 2024 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHvG1uzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF81662EF
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728179804; cv=none; b=RlDe0WiGUyb6bFydWFhRycgPGJyYifFLsYFLvFPK0DT7qYtCfaM88qS6byJ4ZVAdbGKBrMYrXbLhBAoqXaKrHsSSW733FHxkXjo2bteg3pBirbOydRTdTAQ/I95Fe84KFMvWwg9hecoWpYtr2h39OHtBFovJgLaWML5mDewBc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728179804; c=relaxed/simple;
	bh=W5n2YU4QYClAkBUY46U5PjuC1TvuyQDbXqJIUIDs8QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMqTNtqFtziQ7SB7tJuteoYeO4K16FwkpJUNjfexgp5sQvVvjrE+9S3a6MlP/zmVFncmEBB5bKvfJfZ2/lkZ9GoQ6GKcvvDqexTM3MxVSo8/Ztb7Zpe4X+CQ74Nq80xcLd+nJuu1xWmE6OVNasx2UEaLj0vhfltMwFsV6yAGAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DHvG1uzh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 21:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728179799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnnHTDOn4QrAu1ULVkfdeQk3x6v9dEhgIZ7d2QgOsVc=;
	b=DHvG1uzha+RVUdKvfClOmkw4ftOPlaP1pEp2dR6pDiSim1fKwT8xMuk1a9LuumSwqCCol4
	mDQlaFwaIY29deO50w0wxl16dAIsFJd8tT1Z+rHTU7bqs+VdD7OmnpmPs1ujzM6LGNocSF
	o6epLVNwqmMnNP53/g8Srag7xu0JVWs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Carl E. Thompson" <cet@carlthompson.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <coczqmiqvuy4h74j462mjyro3skeybyt2y3kcqdcuwy4bwibjy@pquinazt4h22>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <345264611.558.1728177653590@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345264611.558.1728177653590@mail.carlthompson.net>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 06:20:53PM GMT, Carl E. Thompson wrote:
> Here is a user's perspective from someone who's built a career from Linux (thanks to all of you)...
> 
> The big hardship with testing bcachefs before it was merged into the kernel was that it couldn't be built as an out-of-tree module and instead a whole other kernel tree needed to be built. That was a pain.
> 
> Now, the core kernel infrastructure changes that bcachefs relies on are in the kernel and bcachefs can very easily and quickly be built as an out-of-tree module in just a few seconds. I submit to all involved that maybe that's the best way to go **for now**. 
> 
> Switching to out of tree for now would make it much easier for Kent to have the fast-paced development model he desires for this stage in bcachefs' development. It would also make using and testing bcachefs much easier for power users like me because when an issue is detected we could get a fix or new feature much faster than having to wait for a distribution to ship the next kernel version and with less ancillary risk than building and using a less-tested kernel tree. Distributions themselves also are very familiar with packaging up out-of-tree modules and distribution tools like dkms make using them dead simple even for casual users.
> 
> The way things are now isn't great for me as a Linux power user. I
> often want to use the latest or even RC kernels on my systems to get
> some new hardware support or other feature and I'm used to being able
> to do that without too many problems. But recently I've had to skip
> cutting-edge kernel versions that I otherwise wanted to try because
> there have been issues in bcachefs that I didn't want to have to face
> or work around. Switching to an out of tree module for now would be
> the best of all worlds for me because I could pick and choose which
> combination of kernel / bcachefs to use for each system and situation.

Carl - thanks, I wasn't aware of this.

Can you give me details? 6.11 had the disk accounting rewrite, which was
huge and (necessarily) had some fallout, if you're seeing regressions
otherwise that are slipping through then - yes it's time to slow down
and reevaluate.

Details would be extremely helpful, so we can improve our regression
testing.

