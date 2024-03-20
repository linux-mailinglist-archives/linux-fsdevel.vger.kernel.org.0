Return-Path: <linux-fsdevel+bounces-14919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB28817A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B3C1C2135E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D48562D;
	Wed, 20 Mar 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NEFybc15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5484A43
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961764; cv=none; b=Rf84JloWf6+4iXGcVG8mjHJEHZtjhqRI6iVWshsmo8sllb4qtOGB1hmQazYY6bcMmswiuz4CDl+pmK794x+bxTmV7qUNQLP/2pqBI4x97iAC3FGmI+pZR2bopxDtAtO9uS7sIlqkhLgPbIE1hbPu0yVcgBjVwM0s6/8L9apQQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961764; c=relaxed/simple;
	bh=Pd+MNEr8JOAN89f7XbQ1aj7LFt1Td2jcy+MF4mO6Di4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlWl6NKCLxOff55bVdTQV5dvxmw/tb6Cl2I6Bb0/W90/t2/OnArfKRHdBMXDZU8SR55LQvRo6kkGvqVmNGn0GONa1pA8OpU54NIF1ux1wejfDAtqklo/naslvwuxA5IJ+U1B5GriCau1rAaeTomt6UiBrybIrlix5TDZ3AJEVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NEFybc15; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Mar 2024 15:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710961757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTEWayW9aPquw6DO2+U/3LY8xFsyNhj8KMMbEd/vHoc=;
	b=NEFybc15veLUTIsek+CPE/P7R4LQEyH+LrbWjxgvsu6lW5JWOhQWycf+EHjXWp9FBavdpp
	ZNA8CEVi500eKdikuW1Ws3wpr93/AxDgkEHKQPazsDnQPZYsEkru4BT3RHw+0ECyUayjF6
	bPJafHLW5RvsjqulZy3Ep9aHkPqJUC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, NeilBrown <neilb@suse.de>, 
	Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <5vwztnuwnu4tdcopfxgdqiv2qkgdsvdskvrs6sdpadj4fcgti7@v4otdcsc6uxr>
References: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 20, 2024 at 09:32:52PM +0300, Dan Carpenter wrote:
> On Tue, Mar 12, 2024 at 03:46:32PM +0100, Vlastimil Babka wrote:
> > But if we change it to effectively mean GFP_NOFAIL (for non-costly
> > allocations), there should be a manageable number of places to change to a
> > variant that allows failure.
> 
> What does that even mean if GFP_NOFAIL can fail for "costly" allocations?
> I thought GFP_NOFAIL couldn't fail at all...
> 
> Unfortunately, it's common that when we can't decide on a sane limit for
> something people just say "let the user decide based on how much memory
> they have".  I have added some integer overflow checks which allow the
> user to allocate up to UINT_MAX bytes so I know this code is out
> there.  We can't just s/GFP_KERNEL/GFP_NOFAIL/.
> 
> From a static analysis perspective it would be nice if the callers
> explicitly marked which allocations can fail and which can't.

GFP_NOFAIL throws a warning if the allocation size is > 2 pages, which
is a separate issue from whether the allocation becomes fallible -
someone would have to - oh, I don't know, read the code to answer that
question.

I think we can ditch the 2 page limit on GFP_NOFAIL, though.

