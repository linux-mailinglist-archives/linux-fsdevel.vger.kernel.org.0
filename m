Return-Path: <linux-fsdevel+bounces-11573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2744E854DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46C8B287F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A685FF03;
	Wed, 14 Feb 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="If7KvAk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672425FDD9;
	Wed, 14 Feb 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927455; cv=none; b=odNFf8tdzQwUwyrZ6GVVnIaQ0PdvDQvzdFMsyqjJwg+FWKnGyZ+Iy6fgQeDas+fZF8pCs0RKDY3L7jCv/DoflAmCQ5wu7lQv9wVNAbufkOWPQQx4z58qrJ4P9NrXLI56iKbrFyVtyMG/omdH89AmyE6p06o+VpabCJL0HHwmqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927455; c=relaxed/simple;
	bh=BMkf3NLk/iLQr+WYsIcfjcR7/4kHgrAc/NsrN13AxP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKlo8vDAfWeUikhWaH5kZlzTKliONVxkZcuvbn8Ce3rI7nttKlxKEdq/wmg118x/toqnYJSyfX9S1M30ScS1sTFdFzjtM38S5w7ddKjjbUD6229yoRszvFOu5nLNf7Lx616bmz97Th3MKAXpb7n0BnGUG5S8B1GJGAHld4lBeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=If7KvAk3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 11:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707927450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvW8w5yUCB+T24tws0BE+nRUAXqLznpxXzLB9RssHjE=;
	b=If7KvAk3S44JHt8xTRFRLZGFB9HhXr9yTjM5WxyEi5xNjIqcYGBYlgszfmKzpB+BaRdtGZ
	n3N+YeR7XUwHyIMey1lTARWNjfYN024v3AgKYdiCjuLtH6AdMtTaqstAHFyfDaYzOPE5KS
	nEweGtuqjPMrA6xlO/8Dh+ORbNs02fU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <udgv2gndh4leah734rfp7ydfy5dv65kbqutse6siaewizoooyw@pdd3tcji5yld>
References: <20240212213922.783301-1-surenb@google.com>
 <20240214062020.GA989328@cmpxchg.org>
 <ZczSSZOWMlqfvDg8@tiehlicka>
 <ifz44lao4dbvvpzt7zha3ho7xnddcdxgp4fkeacqleu5lo43bn@f3dbrmcuticz>
 <ZczkFH1dxUmx6TM3@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczkFH1dxUmx6TM3@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 05:02:28PM +0100, Michal Hocko wrote:
> On Wed 14-02-24 10:01:14, Kent Overstreet wrote:
> > On Wed, Feb 14, 2024 at 03:46:33PM +0100, Michal Hocko wrote:
> > > On Wed 14-02-24 01:20:20, Johannes Weiner wrote:
> > > [...]
> > > > I agree we should discuss how the annotations are implemented on a
> > > > technical basis, but my take is that we need something like this.
> > > 
> > > I do not think there is any disagreement on usefulness of a better
> > > memory allocation tracking. At least for me the primary problem is the
> > > implementation. At LFSMM last year we have heard that existing tracing
> > > infrastructure hasn't really been explored much. Cover letter doesn't
> > > really talk much about those alternatives so it is really hard to
> > > evaluate whether the proposed solution is indeed our best way to
> > > approach this.
> > 
> > Michal, we covered this before.
> 
> It is a good practice to summarize previous discussions in the cover
> letter. Especially when there are different approaches discussed over a
> longer time period or when the topic is controversial.
> 
> I do not see anything like that here. Neither for the existing tracing
> infrastructure, page owner nor performance concerns discussed before
> etc. Look, I do not want to nit pick or insist on formalisms but having
> those data points layed out would make any further discussion much more
> smooth.

You don't want to nitpick???

Look, you've been consistently sidestepping the technical discussion; it
seems all you want to talk about is process or "your nack".

If we're going to have a technical discussion, it's incumbent upon all
of us to /keep the focus on the technical/; that is everyone's
responsibility.

I'm not going to write a 20 page cover letter and recap every dead end
that was proposed. That would be a lot of useless crap for eveyone to
wade through. I'm going to summarize the important stuff, and keep the
focus on what we're doing and documenting it. If you want to take part
in a discussion, it's your responsibility to be reading with
comprehension and finding useful things to say.

You gotta stop with this this derailing garbage.

