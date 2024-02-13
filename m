Return-Path: <linux-fsdevel+bounces-11478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CBA853EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CF1C25A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E08626C9;
	Tue, 13 Feb 2024 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NkR1gNLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48F6281E
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863359; cv=none; b=oY2w82kRpKIzl1+PO/8xhBbNxT74nE4fDb+U7g4h6i8cf8+Qa4aTAwtFUz9sC4HSjj+UAQMeaaKhPqGU0FBI0pFyfiApmgdtZZ+bw/AOAT3/4+k/XgI1jcN8gr5OBCR9x7AHJQCmoTQKIG8gIzeIESLzR9hIwk1E/afZh3MeWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863359; c=relaxed/simple;
	bh=s+BcvKq+A48EUw1jpY7zV7egs67MQ2caE5VLt8B0MeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHQqKeNPR7kEzXfUB3jOdQI6fxyCKex/C0BUUVzBGBGPqsfTpFC9JmaKRi6nBiDy4iT7mzW+qR+GRM2HXabEwC1rwG85u02uNXljAp2G6j9XuhvhNAf+sRre2uMdA26G3kGKG0g4DMt1Voau4xgWixJtuOsXp22mr+GUMJjfBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NkR1gNLT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 17:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707863355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wx/MC+bC4jjIx0YLEQfGF9XmXIKmKElg0ARBnR+PN7U=;
	b=NkR1gNLT+RslhaXlT2mq+xaYEQdluCzm3dX/A6JCoEiHuJfxIoq5giPdBQiazQrbxW3d3H
	NAWI1FOS39F6bwgQHKcV40dBRXc+mP8riyFuX3w+XvU40iyQ62zvPPtotTap95Rpir3zAT
	qPzlJdKC0PPafov0tierh8SpKFGEJjc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
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
Message-ID: <huysjw5jiyd7m7ouf6g5n2yptg7slxk3am457x2x4ecz277k4o@gjfy2lu7ntos>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 11:17:32PM +0100, David Hildenbrand wrote:
> On 13.02.24 23:09, Kent Overstreet wrote:
> > On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> > > On 13.02.24 22:58, Suren Baghdasaryan wrote:
> > > > On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > 
> > > > > On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > We're aiming to get this in the next merge window, for 6.9. The feedback
> > > > > > we've gotten has been that even out of tree this patchset has already
> > > > > > been useful, and there's a significant amount of other work gated on the
> > > > > > code tagging functionality included in this patchset [2].
> > > > > 
> > > > > I suspect it will not come as a surprise that I really dislike the
> > > > > implementation proposed here. I will not repeat my arguments, I have
> > > > > done so on several occasions already.
> > > > > 
> > > > > Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> > > > > this debugging feature will add a maintenance overhead for a very long
> > > > > time. I can live with all the downsides of the proposed implementation
> > > > > _as long as_ there is a wider agreement from the MM community as this is
> > > > > where the maintenance cost will be payed. So far I have not seen (m)any
> > > > > acks by MM developers so aiming into the next merge window is more than
> > > > > little rushed.
> > > > 
> > > > We tried other previously proposed approaches and all have their
> > > > downsides without making maintenance much easier. Your position is
> > > > understandable and I think it's fair. Let's see if others see more
> > > > benefit than cost here.
> > > 
> > > Would it make sense to discuss that at LSF/MM once again, especially
> > > covering why proposed alternatives did not work out? LSF/MM is not "too far"
> > > away (May).
> > > 
> > > I recall that the last LSF/MM session on this topic was a bit unfortunate
> > > (IMHO not as productive as it could have been). Maybe we can finally reach a
> > > consensus on this.
> > 
> > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > need to see a serious proposl - what we had at the last LSF was people
> > jumping in with half baked alternative proposals that very much hadn't
> > been thought through, and I see no need to repeat that.
> > 
> > Like I mentioned, there's other work gated on this patchset; if people
> > want to hold this up for more discussion they better be putting forth
> > something to discuss.
> 
> I'm thinking of ways on how to achieve Michal's request: "as long as there
> is a wider agreement from the MM community". If we can achieve that without
> LSF, great! (a bi-weekly MM meeting might also be an option)

A meeting wouldn't be out of the question, _if_ there is an agenda, but:

What's that coffeee mug say? I just survived another meeting that
could've been an email? What exactly is the outcome we're looking for?

Is there info that people are looking for? I think we summed things up
pretty well in the cover letter; if there are specifics that people
want to discuss, that's why we emailed the series out.

There's people in this thread who've used this patchset in production
and diagnosed real issues (gigabytes of memory gone missing, I heard the
other day); I'm personally looking for them to chime in on this thread
(Johannes, Pasha).

If it's just grumbling about "maintenance overhead" we need to get past
- well, people are going to have to accept that we can't deliver
features without writing code, and I'm confident that the hooking in
particular is about as clean as it's going to get, _regardless_ of
toolchain support; and moreover it addresses what's been historically a
pretty gaping hole in our ability to profile and understand the code we
write.

