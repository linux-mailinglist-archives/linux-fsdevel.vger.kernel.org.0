Return-Path: <linux-fsdevel+bounces-13334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0286EA38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8BD1F25BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7723C470;
	Fri,  1 Mar 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YzwdcyT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051F3C47C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324432; cv=none; b=Rv621GaTurxnb0EI6dCxwkfz+HxZgCTbL76NelP8cAkMIR6RUgGnGaZrKBB02NSuUm8/L5lAnP1wY2DpTtJzuBCYOJFljw0/1WG2cABS2feqO/9jcxZL/o4OHHDrycJoAP/eKCwKxJ/WwSfm+q1p04shS5qgtSEH0QXFgybt37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324432; c=relaxed/simple;
	bh=oYqlzbN8ZC/cfsADNJpfZdEK/88+MagJYUHtA3tpffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoxiKtiaoRQK20vy9ZRULPGSKv20Wt7EzyAAGtr7IPSDpHioxZre5e2rB75gLUQo3ANifvdk+dFWZaXbcVb7nX3sg5H+3JzvlToEyIs1coQh9CHKlYID+G2beOAR+N7J2iswjzx8eZc/nr+XxNMCFHKIAJ62U8FKaFXtdeO/0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YzwdcyT7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 15:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709324428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ziC2ak3d9B8hJ8C504tkyb1SDin2zWz3Q5ACLPf5R2o=;
	b=YzwdcyT7E4f/e+3i6aAmwaz8VLpYJRh2n0RamGMbKTgIHpnc0OXU3PMFjcwFGRdpi0Tki2
	XukTeoVnNEwMweK4U/lvH76itLATEB/yWn2iOmJ++l2wokEQ+biiWFYuxCxA6SdvI/7Yhu
	Cxkubp5lf40v6DwHsS6mPpczUh9Bp8s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeFtrzN34cLhjjHK@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 04:54:55PM +1100, Dave Chinner wrote:
> On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > While we are considering revising mm rules, I would really like to
> > revised the rule that GFP_KERNEL allocations are allowed to fail.
> > I'm not at all sure that they ever do (except for large allocations - so
> > maybe we could leave that exception in - or warn if large allocations
> > are tried without a MAY_FAIL flag).
> > 
> > Given that GFP_KERNEL can wait, and that the mm can kill off processes
> > and clear cache to free memory, there should be no case where failure is
> > needed or when simply waiting will eventually result in success.  And if
> > there is, the machine is a gonner anyway.
> 
> Yes, please!
> 
> XFS was designed and implemented on an OS that gave this exact
> guarantee for kernel allocations back in the early 1990s.  Memory
> allocation simply blocked until it succeeded unless the caller
> indicated they could handle failure. That's what __GFP_NOFAIL does
> and XFS is still heavily dependent on this behaviour.

I'm not saying we should get rid of __GFP_NOFAIL - actually, I'd say
let's remove the underscores and get rid of the silly two page limit.
GFP_NOFAIL|GFP_KERNEL is perfectly safe for larger allocations, as long
as you don't mind possibly waiting a bit.

But it can't be the default because, like I mentioned to Neal, there are
a _lot_ of different places where we allocate memory in the kernel, and
they have to be able to fail instead of shoving everything else out of
memory.

> This is the sort of thing I was thinking of in the "remove
> GFP_NOFS" discussion thread when I said this to Kent:
> 
> 	"We need to start designing our code in a way that doesn't require
> 	extensive testing to validate it as correct. If the only way to
> 	validate new code is correct is via stochastic coverage via error
> 	injection, then that is a clear sign we've made poor design choices
> 	along the way."
> 
> https://lore.kernel.org/linux-fsdevel/ZcqWh3OyMGjEsdPz@dread.disaster.area/
> 
> If memory allocation doesn't fail by default, then we can remove the
> vast majority of allocation error handling from the kernel. Make the
> common case just work - remove the need for all that code to handle
> failures that is hard to exercise reliably and so are rarely tested.
> 
> A simple change to make long standing behaviour an actual policy we
> can rely on means we can remove both code and test matrix overhead -
> it's a win-win IMO.

We definitely don't want to make GFP_NOIO/GFP_NOFS allocations nofail by
default - a great many of those allocations have mempools in front of
them to avoid deadlocks, and if you do that you've made the mempools
useless.

