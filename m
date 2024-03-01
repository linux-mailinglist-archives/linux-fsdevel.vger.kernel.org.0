Return-Path: <linux-fsdevel+bounces-13236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D886D9D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0AB1C22B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860D42AA2;
	Fri,  1 Mar 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wbWsA8Bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6641C8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260770; cv=none; b=Vjl7yMzITbkLYQ52qShYtUFlZobn/RuF83ozqrzZd7SjhzQecf2u3VkTDTR4JGKjajU3IUz2TIJjV5MzFggrdQVl75VdutrQmMDlLUxM4GmzGQas/jA7KPq+Aal1+0X3/8nfIBOzV5PRZHErc9AdFhNxzvUjXO/Itdy5Hc2Iukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260770; c=relaxed/simple;
	bh=Ej4Kzu+l4SzCfEiFrFTnlTwW2JrL++g1J+6pbTV7wRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/ND7K+NXJdo2pmsGoXGyjXmuJhozw1WoAxLeOjI0OdhkhWEoiigowQCektrSIhcrfowYa5m2cKodOp15JBTfJyft4JycATHyEnlGlSrn1WIafpgGquchARZ/d3I51r9ONEjtVNdClGkITI+MdCBEq0GsN2KJl2ws0h+bkHpsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wbWsA8Bz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 21:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709260765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIdqVtaB4EaLn9myWUsTONCxMWnwP/dnVDmb+7RniiM=;
	b=wbWsA8Bzo/kNI9c7umS0uxXcpyy7MlRRLjD3vAq+rslNvG1bdGlG4jQ+wLV3FAXTNs/i1t
	O6oHkvMh/GFszhT2luJw0gOfYSff41OPXQoSqFp/RXDkd3Wn8qT7uSm/bY4sNyrj2gW7ON
	elsACZaxTLWwyLd4QqTyBB97U0hBYNI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170925937840.24797.2167230750547152404@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> On Thu, 29 Feb 2024, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Recent discussions [1] suggest that greater mutual understanding between
> > > > memory reclaim on the one hand and RCU on the other might be in order.
> > > >
> > > > One possibility would be an open discussion.  If it would help, I would
> > > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > > some ways that RCU's reactions and responses could be enhanced if needed.
> > > >
> > > 
> > > Adding fsdevel as this should probably be a cross track session.
> > 
> > Perhaps broaden this slightly.  On the THP Cabal call we just had a
> > conversation about the requirements on filesystems in the writeback
> > path.  We currently tell filesystem authors that the entire writeback
> > path must avoid allocating memory in order to prevent deadlock (or use
> > GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> > writing pagecache back will not allocate memory in, eg, the network stack,
> > the device driver, and any other layers the write must traverse.
> > 
> > With the removal of ->writepage from vmscan, perhaps we can make
> > filesystem authors lives easier by relaxing this requirement as pagecache
> > should be cleaned long before we get to reclaiming it.
> > 
> > I don't think there's anything to be done about swapping anon memory.
> > We probably don't want to proactively write anon memory to swap, so by
> > the time we're in ->swap_rw we really are low on memory.
> > 
> > 
> 
> While we are considering revising mm rules, I would really like to
> revised the rule that GFP_KERNEL allocations are allowed to fail.
> I'm not at all sure that they ever do (except for large allocations - so
> maybe we could leave that exception in - or warn if large allocations
> are tried without a MAY_FAIL flag).
> 
> Given that GFP_KERNEL can wait, and that the mm can kill off processes
> and clear cache to free memory, there should be no case where failure is
> needed or when simply waiting will eventually result in success.  And if
> there is, the machine is a gonner anyway.
> 
> Once upon a time user-space pages could not be ripped out of a process
> by the oom killer until the process actually exited, and that meant that
> GFP_KERNEL allocations of a process being oom killed should not block
> indefinitely in the allocator.  I *think* that isn't the case any more.
> 
> Insisting that GFP_KERNEL allocations never returned NULL would allow us
> to remove a lot of untested error handling code....

If memcg ever gets enabled for all kernel side allocations we might
start seeing failures of GFP_KERNEL allocations.

I've got better fault injection code coming, I'll be posting it right
after memory allocation profiling gets merged - that'll help with the
testing situation.

The big blocker on enabling memcg for all kernel allocations is
performance overhead, but I hear that's getting worked on as well.

We'd probably want to add a gfp flag to annotate which allocations we
want to fail because of memcg, though...

