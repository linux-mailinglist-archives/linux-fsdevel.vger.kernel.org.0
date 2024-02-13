Return-Path: <linux-fsdevel+bounces-11499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566D854006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B501C262AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDC6311B;
	Tue, 13 Feb 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c32gpRAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B263106;
	Tue, 13 Feb 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866659; cv=none; b=jNQi+WjTGlyM+quE5ZmJEp9KWBFlAYfXY2tErLiJPOtNosN53fm3xtClITCmVQZcNsWCkzyBJ+3g/R3n5FlPO6clg72s01fTkP6efFLhuqar86qftXgXOJiOZfoe4FUptTeGZCUhDyRv9tHwghC4PLNcQ1vd6CcNWcNHSf34FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866659; c=relaxed/simple;
	bh=xIizX9hn9H7P4Qd1S3ByJZRil7O6yirntX5vI1pah/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7oKUDG61FmJSEPE5NLGEtA1nVJL7lQImi9CjwKzyebHSeONusYzH5PdnhcP57cDSbnGwmn5jcFEKz+D6r3by8YrWk+RpXMc0F/DFza1mqKswuRecHLkXv816vjqTdn2bqDwCjrrcuZPuhRi+HxNx5GAIpi3Pur4r81U57iKw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c32gpRAo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 18:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707866654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQNc5sF3dDkI4DLDAhoYo17ANIh5r48U4JW8o4GQNhc=;
	b=c32gpRAodKvVWo/dAGE7p0OKZvQsg2a1GAjZJKaKoPfPgt/c0QgWj0DzjKFTBELehY1nCG
	a4JOjQxa7unZ1UtEicdIDQHsS8YcmUoqe+A+4fh0TNMzc/i3PX4pCZ0c/DY3/q7x1FVmjP
	BpCIJi0jKmMyPh6iHQyV213S+IzwS28=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <vxsk7w7z57rgwqgreeq2j4xq5klxeorfhjfysu3re3i6bomh5z@36p2iqhzxjfd>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <huysjw5jiyd7m7ouf6g5n2yptg7slxk3am457x2x4ecz277k4o@gjfy2lu7ntos>
 <20240213231115.GF6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213231115.GF6184@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 03:11:15PM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 05:29:03PM -0500, Kent Overstreet wrote:
> > On Tue, Feb 13, 2024 at 11:17:32PM +0100, David Hildenbrand wrote:
> > > On 13.02.24 23:09, Kent Overstreet wrote:
> > > > On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> > > > > On 13.02.24 22:58, Suren Baghdasaryan wrote:
> > > > > > On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > 
> > > > > > > On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> > > > > > > [...]
> > > > > > > > We're aiming to get this in the next merge window, for 6.9. The feedback
> > > > > > > > we've gotten has been that even out of tree this patchset has already
> > > > > > > > been useful, and there's a significant amount of other work gated on the
> > > > > > > > code tagging functionality included in this patchset [2].
> > > > > > > 
> > > > > > > I suspect it will not come as a surprise that I really dislike the
> > > > > > > implementation proposed here. I will not repeat my arguments, I have
> > > > > > > done so on several occasions already.
> > > > > > > 
> > > > > > > Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> > > > > > > this debugging feature will add a maintenance overhead for a very long
> > > > > > > time. I can live with all the downsides of the proposed implementation
> > > > > > > _as long as_ there is a wider agreement from the MM community as this is
> > > > > > > where the maintenance cost will be payed. So far I have not seen (m)any
> > > > > > > acks by MM developers so aiming into the next merge window is more than
> > > > > > > little rushed.
> > > > > >
> > > > > > We tried other previously proposed approaches and all have their
> > > > > > downsides without making maintenance much easier. Your position is
> > > > > > understandable and I think it's fair. Let's see if others see more
> > > > > > benefit than cost here.
> > > > > 
> > > > > Would it make sense to discuss that at LSF/MM once again, especially
> > > > > covering why proposed alternatives did not work out? LSF/MM is not "too far"
> > > > > away (May).
> 
> You want to stall this effort for *three months* to schedule a meeting?
> 
> I would love to have better profiling of memory allocations inside XFS
> so that we can answer questions like "What's going on with these
> allocation stalls?" or "What memory is getting used, and where?" more
> quickly than we can now.
> 
> Right now I get to stare at tracepoints and printk crap until my eyes
> bleed, and maybe dchinner comes to my rescue and figures out what's
> going on sooner than I do.  More often we just never figure it out
> because only the customer can reproduce the problem, the reams of data
> produced by ftrace is unmanageable, and BPF isn't always available.
> 
> I'm not thrilled by the large increase in macro crap in the allocation
> paths, but I don't know of a better way to instrument things.  Our
> attempts to use _RET_IP in XFS to instrument its code paths have never
> worked quite right w.r.t. inlined functions and whatnot.
> 
> > > > > I recall that the last LSF/MM session on this topic was a bit unfortunate
> > > > > (IMHO not as productive as it could have been). Maybe we can finally reach a
> > > > > consensus on this.
> 
> From my outsider's perspective, nine months have gone by since the last
> LSF.  Who has come up with a cleaner/better/faster way to do what Suren
> and Kent have done?  Were those code changes integrated into this
> patchset?  Or why not?
> 
> Most of what I saw in 2023 involved compiler changes (great; now I have
> to wait until RHEL 11/Debian 14 to use it) and/or still utilize fugly
> macros.
> 
> Recalling all the way back to suggestions made in 2022, who wrote the
> prototype for doing this via ftrace?  Or BPF?  How well did that go for
> counting allocation events and the like?  I saw Tejun saying something
> about how they use BPF aggressively inside Meta, but that was about it.
> 
> Were any of those solutions significantly better than what's in front of
> us here?
> 
> I get it, a giant patch forcing everyone to know the difference between
> alloc_foo and alloc_foo_noperf offends my (yours?) stylistic
> sensibilities.  On the other side, making analysis easier during
> customer escalations means we kernel people get data, answers, and
> solutions sooner instead of watching all our time get eaten up on L4
> support and backporting hell.
> 
> > > > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > > > need to see a serious proposl - what we had at the last LSF was people
> > > > jumping in with half baked alternative proposals that very much hadn't
> > > > been thought through, and I see no need to repeat that.
> > > > 
> > > > Like I mentioned, there's other work gated on this patchset; if people
> > > > want to hold this up for more discussion they better be putting forth
> > > > something to discuss.
> > > 
> > > I'm thinking of ways on how to achieve Michal's request: "as long as there
> > > is a wider agreement from the MM community". If we can achieve that without
> > > LSF, great! (a bi-weekly MM meeting might also be an option)
> > 
> > A meeting wouldn't be out of the question, _if_ there is an agenda, but:
> > 
> > What's that coffeee mug say? I just survived another meeting that
> > could've been an email?
> 
> I congratulate you on your memory of my kitchen mug.  Yes, that's what
> it says.
> 
> > What exactly is the outcome we're looking for?
> > 
> > Is there info that people are looking for? I think we summed things up
> > pretty well in the cover letter; if there are specifics that people
> > want to discuss, that's why we emailed the series out.
> > 
> > There's people in this thread who've used this patchset in production
> > and diagnosed real issues (gigabytes of memory gone missing, I heard the
> > other day); I'm personally looking for them to chime in on this thread
> > (Johannes, Pasha).
> > 
> > If it's just grumbling about "maintenance overhead" we need to get past
> > - well, people are going to have to accept that we can't deliver
> > features without writing code, and I'm confident that the hooking in
> > particular is about as clean as it's going to get, _regardless_ of
> > toolchain support; and moreover it addresses what's been historically a
> > pretty gaping hole in our ability to profile and understand the code we
> > write.
> 
> Are you and Suren willing to pay whatever maintenance overhead there is?

I'm still wondering what this supposed "maintenance overhead" is going
to be...

As I use this patch series I occasionally notice places where a bunch of
memory is being accounted to one line of code, and it would better be
accounted to a caller - but then it's just a couple lines of code to fix
that. You switch that callsite to the _noprof() version of whatever
allocation it's doing, then add an alloc_hooks() wrapper at the place
you do want it accounted.

That doesn't really feel like overhead to me, just the normal tweaking
your tools to get the most out of them.

I will continue to do that for the code I'm looking at, yes.

If other people are doing that too, it'll be because they're also using
memory allocation profiling and finding it valuable.

I did notice earlier that we're still lacking documentation in the
Documentation/ directory; the workflow for "how you shift accounting to
the right spot" is something that should go in there.

