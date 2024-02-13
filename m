Return-Path: <linux-fsdevel+bounces-11495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE5853FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EC7B2BDCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2463064;
	Tue, 13 Feb 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToFeO/6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E660B9D;
	Tue, 13 Feb 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865876; cv=none; b=KMSK4z1QXFUMuTBF6AZapCKZgNxG8z2W5hKkp7Dr874YIsiAMRI9Ml1n3e2x8e04DVvxzYaVIZ25Iqmg9ZboqwNSo6ZfHh/vh1WPHCpuHOfoaLPtJKKVMiJ+9rj/P3R63isyFJ/XQTR82P1bwuHL933bwdtHu5wsdiAbOHWumNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865876; c=relaxed/simple;
	bh=X0Q8mOE644bC3imQHDGeArc5j0LokHzXwsSyh29i+Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9mtBOGJXp0Wh5homJri2uQDHcwHXOGY953vVc+XL8aPQlxh/DNgqyd5Mdlb8RYz6/j02OE4Evkctq3CRByV2Cpxu0F50pA3v0Dc8uw8iQ/noZvYwn5J/jA2o++kx1bqlVQF1Pn1Zd3+CYKvarS9Ce4/J85u+uJ/67tBkYC2bGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToFeO/6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB84C433F1;
	Tue, 13 Feb 2024 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707865876;
	bh=X0Q8mOE644bC3imQHDGeArc5j0LokHzXwsSyh29i+Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToFeO/6+jy8tN6WMw9eFY02Tw10FVIJj0TtOdmp+JiL4zpeqrdgCde6EZ9ll9CJAy
	 1OK+abif+8+H7bsFIEpfrDm3YAN7M41xO4D/YqIqkoZGZlAqWX60w5gr3JcNSRcl36
	 0bIhf6109/T2xuy7HkFNOx0Aa+HR0zeUBKIDWagBaBAMIn2PFWaOAhOjjP23mN1cd4
	 ESybK6zKoW53LGpZ45YA1BMc65JF+Z4VwR3mU2yPMWH3e4aVOb+JyFVg/AZTrzGuUh
	 Ds4fMjUtaf6jp5gi0pHpMnV+658btAAZsWrfSkpePPAubncrnlIge4q0Ub/1BSK7ii
	 Er2ObuVloTNNw==
Date: Tue, 13 Feb 2024 15:11:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, axboe@kernel.dk,
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <20240213231115.GF6184@frogsfrogsfrogs>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <huysjw5jiyd7m7ouf6g5n2yptg7slxk3am457x2x4ecz277k4o@gjfy2lu7ntos>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <huysjw5jiyd7m7ouf6g5n2yptg7slxk3am457x2x4ecz277k4o@gjfy2lu7ntos>

On Tue, Feb 13, 2024 at 05:29:03PM -0500, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 11:17:32PM +0100, David Hildenbrand wrote:
> > On 13.02.24 23:09, Kent Overstreet wrote:
> > > On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> > > > On 13.02.24 22:58, Suren Baghdasaryan wrote:
> > > > > On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > 
> > > > > > On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > We're aiming to get this in the next merge window, for 6.9. The feedback
> > > > > > > we've gotten has been that even out of tree this patchset has already
> > > > > > > been useful, and there's a significant amount of other work gated on the
> > > > > > > code tagging functionality included in this patchset [2].
> > > > > > 
> > > > > > I suspect it will not come as a surprise that I really dislike the
> > > > > > implementation proposed here. I will not repeat my arguments, I have
> > > > > > done so on several occasions already.
> > > > > > 
> > > > > > Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> > > > > > this debugging feature will add a maintenance overhead for a very long
> > > > > > time. I can live with all the downsides of the proposed implementation
> > > > > > _as long as_ there is a wider agreement from the MM community as this is
> > > > > > where the maintenance cost will be payed. So far I have not seen (m)any
> > > > > > acks by MM developers so aiming into the next merge window is more than
> > > > > > little rushed.
> > > > >
> > > > > We tried other previously proposed approaches and all have their
> > > > > downsides without making maintenance much easier. Your position is
> > > > > understandable and I think it's fair. Let's see if others see more
> > > > > benefit than cost here.
> > > > 
> > > > Would it make sense to discuss that at LSF/MM once again, especially
> > > > covering why proposed alternatives did not work out? LSF/MM is not "too far"
> > > > away (May).

You want to stall this effort for *three months* to schedule a meeting?

I would love to have better profiling of memory allocations inside XFS
so that we can answer questions like "What's going on with these
allocation stalls?" or "What memory is getting used, and where?" more
quickly than we can now.

Right now I get to stare at tracepoints and printk crap until my eyes
bleed, and maybe dchinner comes to my rescue and figures out what's
going on sooner than I do.  More often we just never figure it out
because only the customer can reproduce the problem, the reams of data
produced by ftrace is unmanageable, and BPF isn't always available.

I'm not thrilled by the large increase in macro crap in the allocation
paths, but I don't know of a better way to instrument things.  Our
attempts to use _RET_IP in XFS to instrument its code paths have never
worked quite right w.r.t. inlined functions and whatnot.

> > > > I recall that the last LSF/MM session on this topic was a bit unfortunate
> > > > (IMHO not as productive as it could have been). Maybe we can finally reach a
> > > > consensus on this.

From my outsider's perspective, nine months have gone by since the last
LSF.  Who has come up with a cleaner/better/faster way to do what Suren
and Kent have done?  Were those code changes integrated into this
patchset?  Or why not?

Most of what I saw in 2023 involved compiler changes (great; now I have
to wait until RHEL 11/Debian 14 to use it) and/or still utilize fugly
macros.

Recalling all the way back to suggestions made in 2022, who wrote the
prototype for doing this via ftrace?  Or BPF?  How well did that go for
counting allocation events and the like?  I saw Tejun saying something
about how they use BPF aggressively inside Meta, but that was about it.

Were any of those solutions significantly better than what's in front of
us here?

I get it, a giant patch forcing everyone to know the difference between
alloc_foo and alloc_foo_noperf offends my (yours?) stylistic
sensibilities.  On the other side, making analysis easier during
customer escalations means we kernel people get data, answers, and
solutions sooner instead of watching all our time get eaten up on L4
support and backporting hell.

> > > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > > need to see a serious proposl - what we had at the last LSF was people
> > > jumping in with half baked alternative proposals that very much hadn't
> > > been thought through, and I see no need to repeat that.
> > > 
> > > Like I mentioned, there's other work gated on this patchset; if people
> > > want to hold this up for more discussion they better be putting forth
> > > something to discuss.
> > 
> > I'm thinking of ways on how to achieve Michal's request: "as long as there
> > is a wider agreement from the MM community". If we can achieve that without
> > LSF, great! (a bi-weekly MM meeting might also be an option)
> 
> A meeting wouldn't be out of the question, _if_ there is an agenda, but:
> 
> What's that coffeee mug say? I just survived another meeting that
> could've been an email?

I congratulate you on your memory of my kitchen mug.  Yes, that's what
it says.

> What exactly is the outcome we're looking for?
> 
> Is there info that people are looking for? I think we summed things up
> pretty well in the cover letter; if there are specifics that people
> want to discuss, that's why we emailed the series out.
> 
> There's people in this thread who've used this patchset in production
> and diagnosed real issues (gigabytes of memory gone missing, I heard the
> other day); I'm personally looking for them to chime in on this thread
> (Johannes, Pasha).
> 
> If it's just grumbling about "maintenance overhead" we need to get past
> - well, people are going to have to accept that we can't deliver
> features without writing code, and I'm confident that the hooking in
> particular is about as clean as it's going to get, _regardless_ of
> toolchain support; and moreover it addresses what's been historically a
> pretty gaping hole in our ability to profile and understand the code we
> write.

Are you and Suren willing to pay whatever maintenance overhead there is?

--D

