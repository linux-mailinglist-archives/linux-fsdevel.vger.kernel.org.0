Return-Path: <linux-fsdevel+bounces-13238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366B86D9EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E11F230CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F54405FE;
	Fri,  1 Mar 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VymsT+Zp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D63FE55
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262615; cv=none; b=N+QZX/B1Kve0uAqNW5cSfV5DfpEVmRDsNdzgcxT8O9vlBEmQxoWx1fAATQ/KFY8MEkyHRCMakOLksPqcEIkP7TMecwdfbyuoRoM1bJc0f1eOq55AX8C0krLZmKNc0vyIf2Ox0828HIDrutaIkOjG4hkuQrtPEj2BDNlCK/EXehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262615; c=relaxed/simple;
	bh=jOdql4sytD7JRlp1sVobcavYPQAwOoGbNTAbg4hFtrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai5tpVvKX2C1Ctd8An7RAk5d2T7cxuezfunNP/QZeEDSXVsSxKCxJEdpAwLcxYn/otN7908Gv7xvdR7FICNnVIaI0mV6m//cK+dk70AhMPu+llCa82bbVKmOwIC2xpwMMnldgrbNUNkL+4plV1BIPK95BVr5tMSSSt5xyQy3nMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VymsT+Zp; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 22:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709262610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1H2jOGnASL5yJnW2d++8ehyB71UlfbyZz1T0lnOHuo=;
	b=VymsT+Zp3zdR1qRlgK1Op86nDz72vFwUg/GSB21aax9A+k2xTJL0nsbrwCcPWVUJlCWyqs
	5yvJyVlozCRGBWbnBVK41k4QJu95zR7B8MG1Y+H24+p5/COjQZzVEIUpDCwfBnTSy85HsU
	NtJSHWoVaX/TASvyG6U16yWYi/k2ils=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>, 
	paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
 <ZeFCFGc8Gncpstd8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeFCFGc8Gncpstd8@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 02:48:52AM +0000, Matthew Wilcox wrote:
> On Thu, Feb 29, 2024 at 09:39:17PM -0500, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > Insisting that GFP_KERNEL allocations never returned NULL would allow us
> > > to remove a lot of untested error handling code....
> > 
> > If memcg ever gets enabled for all kernel side allocations we might
> > start seeing failures of GFP_KERNEL allocations.
> 
> Why would we want that behaviour?  A memcg-limited allocation should
> behave like any other allocation -- block until we've freed some other
> memory in this cgroup, either by swap or killing or ...

It's not uncommon to have a more efficient way of doing something if you
can allocate more memory, but still have the ability to run in a more
bounded amount of space if you need to; I write code like this quite
often.

Or maybe you just want the syscall to return an error instead of
blocking for an unbounded amount of time if userspace asks for something
silly.

Honestly, relying on the OOM killer and saying that because that now we
don't have to write and test your error paths is a lazy cop out.

The same kind of thinking got us overcommit, where yes we got an
increase in efficiency, but the cost was that everyone started assuming
and relying on overcommit, so now it's impossible to run without
overcommit enabled except in highly controlled environments.

And that means allocation failure as an effective signal is just
completely busted in userspace. If you want to write code in userspace
that uses as much memory as is available and no more, you _can't_,
because system behaviour goes to shit if you have overcommit enabled or
a bunch of memory gets wasted if overcommit is disabled because everyone
assumes that's just what you do.

Let's _not_ go that route in the kernel. I have pointy sticks to
brandish at people who don't want to deal with properly handling errors.

