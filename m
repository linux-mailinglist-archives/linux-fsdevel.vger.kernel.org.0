Return-Path: <linux-fsdevel+bounces-15610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCC890B3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA88D29999A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E913AA43;
	Thu, 28 Mar 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1xfM/sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18113A89B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657341; cv=none; b=Qt6B7tiB8kO5oL3m87lrsBigOX37hIPhCf75t8WgEUWQLpoh0++vyFurvMbl5VmiSZeWGjzV3rLpuvCma4zWAnGqN0J0H3v9GCTikRlVEduFkrCg3wo709NvKrPAwL9Ay5RXtU9rIoUU3bCJw9OLo2VCJOITB3snT5FwRu5OJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657341; c=relaxed/simple;
	bh=v6O4Uqk52YbEsaRRH8ACq+JI9VweRdHN6fwD+VY99LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaW1vVDknDj8907rX+4H/dp7dR15Hv39JEmLq2VGTCdWnlgLZyirA0P6Zvc2kqIdO/NgruoJuhjxjHE4dwzyl/DLHaiqb5OyhM4Nzm3JVyFIN4inKqVQppFJNQqh1+ljH4WGjqhNNBzOv5iDZf0C6+43tizW/7bpmlsjtwVtRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1xfM/sk; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 16:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711657337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SITu3wP6qaILu57znUskVSN6H9osyOHT4Gb41FteW/Y=;
	b=t1xfM/sk4la00t065yw/dchJtSd86DyHJ5hZsC77hI3tD6MWdTT1Xhr+DJZxHogBRqAlv2
	VvI/3ZhGyUghQnky940nynaLU+ZcO+Dg2ZNUQXtqMkuZiWU+UN7Tob6gPhBCiYaT9Nv7UV
	zNUs/Hgip5OP/EHxeC07CyVObPP73YQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 28, 2024 at 10:13:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 28, 2024 at 03:55:32PM -0400, Kent Overstreet wrote:
> > > On Thu, Mar 28, 2024 at 03:40:02PM -0400, Kent Overstreet wrote:
> > > > Collecting latency numbers at various key places is _enormously_ useful.
> > > > The hard part is deciding where it's useful to collect; that requires
> > > > intimate knowledge of the code. Once you're defining those collection
> > > > poitns statically, doing it with BPF is just another useless layer of
> > > > indirection.
> > > 
> > > Given how much flexibility helps with debugging, claiming it useless is a
> > > stretch.
> > 
> > Well, what would it add?
> 
> It depends on the case but here's an example. If I'm seeing occasional tail
> latency spikes, I'd want to know whether there's any correation with
> specific types or sizes of IOs and if so who's issuing them and why. With
> BPF, you can detect those conditions to tag and capture where exactly those
> IOs are coming from and aggregate the result however you like across
> thousands of machines in production without anyone noticing. That's useful,
> no?

That's cool, but really esoteric. We need to be able to answer basic
questions and build an overall picture of what the system is doing
without having to reach for the big stuff.

Most users are never going to touch tracing, let alone BPF; that's too
much setup. But I can and do regularly tell users "check this, this and
this" and debug things on that basis without ever touching their
machine.

And basic latency numbers are really easy for users to understand, that
makes them doubly worthwhile to collect and make visible.

> Also, actual percentile disribution is almost always a lot more insightful
> than more coarsely aggregated numbers. We can't add all that to fixed infra.
> In most cases not because runtime overhead would be too hight but because
> the added interface and code complexity and maintenance overhead isn't
> justifiable given how niche, adhoc and varied these use cases get.

You can't calculate percentiles accurately and robustly in one pass -
that only works if your input data obeys a nice statistical
distribution, and the cases we care about are the ones where it doesn't.

> 
> > > > The time stats stuff I wrote is _really_ cheap, and you really want this
> > > > stuff always on so that you've actually got the data you need when
> > > > you're bughunting.
> > > 
> > > For some stats and some use cases, always being available is useful and
> > > building fixed infra for them makes sense. For other stats and other use
> > > cases, flexibility is pretty useful too (e.g. what if you want percentile
> > > distribution which is filtered by some criteria?). They aren't mutually
> > > exclusive and I'm not sure bdi wb instrumentation is on top of enough
> > > people's minds.
> > > 
> > > As for overhead, BPF instrumentation can be _really_ cheap too. We often run
> > > these programs per packet.
> > 
> > The main things I want are just
> >  - elapsed time since last writeback IO completed, so we can see at a
> >    glance if it's stalled
> >  - time stats on writeback io initiation to completion
> > 
> > The main value of this one will be tracking down tail latency issues and
> > finding out where in the stack they originate.
> 
> Yeah, I mean, if always keeping those numbers around is useful for wide
> enough number of users and cases, sure, go ahead and add fixed infra. I'm
> not quite sure bdi wb stats fall in that bucket given how little attention
> it usually gets.

I think it should be getting a lot more attention given that memory
reclaim and writeback are generally implicated whenever a user complains
about their system going out to lunch.

