Return-Path: <linux-fsdevel+bounces-11497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E0853FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247A2B2C3A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE56310A;
	Tue, 13 Feb 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9atok+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD0629FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865973; cv=none; b=UT1Shj1/OXEQXTJZ7mEqqUrQB0wWTF0PzTu+xuMbABwty9bTOjO5eDcex6Ky1acVe7FLMYfIhA+axbifUx2sNzJ2VbyHd4ZgFDusVLK7JGE3kZ4q125PDbZ3puEno/lnxkuPWpOQe/rTSr56HcvXUx8aH7TmliOHwym6n7NXWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865973; c=relaxed/simple;
	bh=t/GNKJjR0V0zS70LICAX4TznhKRY5yMu/IpFWVmDNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMO7D2Ceedag3vUt/9+/gJDRfEoy2cu/zRYQ5fpXP81ga0JkdxysnFMjP38fXyQT+Oi7rEuRUFiRso54Onf/WP4xUd2tYXWgy7qWD3/cTS6PkAx+fqpHY8kJ9J8cvzZraIMgOiB/FLnInfsU/Ef3gRtch1qz2ixSbmdKoP9+4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9atok+b; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 18:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707865969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0TdyX1LIEW+TxM6rJOce5L4g2KmC9LD2hQu+Hn6Qhs=;
	b=h9atok+bNTD+zHkmI6A2NHUgvmo8eVZgh6aU/9Qcl03lpjJfJ/1wsuZzmWLjw+g7wxcsRp
	JX8RPH+/uKCoYHAC2BLMPKw+KQV5cFLc7TOGWPD9OGUL0fPCpEuqn3SpP9ZYd3I1wcCauT
	g+9IJHpgkBrntaAMqtoVKGKLAjbphxI=
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
Message-ID: <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
References: <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 12:02:30AM +0100, David Hildenbrand wrote:
> On 13.02.24 23:59, Suren Baghdasaryan wrote:
> > On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > 
> > > On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
> > > > On 13.02.24 23:30, Suren Baghdasaryan wrote:
> > > > > On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > > 
> > > > > > On 13.02.24 23:09, Kent Overstreet wrote:
> > > > > > > On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> > > > > > > > On 13.02.24 22:58, Suren Baghdasaryan wrote:
> > > > > > > > > On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> > > > > > > > > > [...]
> > > > > > > > > > > We're aiming to get this in the next merge window, for 6.9. The feedback
> > > > > > > > > > > we've gotten has been that even out of tree this patchset has already
> > > > > > > > > > > been useful, and there's a significant amount of other work gated on the
> > > > > > > > > > > code tagging functionality included in this patchset [2].
> > > > > > > > > > 
> > > > > > > > > > I suspect it will not come as a surprise that I really dislike the
> > > > > > > > > > implementation proposed here. I will not repeat my arguments, I have
> > > > > > > > > > done so on several occasions already.
> > > > > > > > > > 
> > > > > > > > > > Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> > > > > > > > > > this debugging feature will add a maintenance overhead for a very long
> > > > > > > > > > time. I can live with all the downsides of the proposed implementation
> > > > > > > > > > _as long as_ there is a wider agreement from the MM community as this is
> > > > > > > > > > where the maintenance cost will be payed. So far I have not seen (m)any
> > > > > > > > > > acks by MM developers so aiming into the next merge window is more than
> > > > > > > > > > little rushed.
> > > > > > > > > 
> > > > > > > > > We tried other previously proposed approaches and all have their
> > > > > > > > > downsides without making maintenance much easier. Your position is
> > > > > > > > > understandable and I think it's fair. Let's see if others see more
> > > > > > > > > benefit than cost here.
> > > > > > > > 
> > > > > > > > Would it make sense to discuss that at LSF/MM once again, especially
> > > > > > > > covering why proposed alternatives did not work out? LSF/MM is not "too far"
> > > > > > > > away (May).
> > > > > > > > 
> > > > > > > > I recall that the last LSF/MM session on this topic was a bit unfortunate
> > > > > > > > (IMHO not as productive as it could have been). Maybe we can finally reach a
> > > > > > > > consensus on this.
> > > > > > > 
> > > > > > > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > > > > > > need to see a serious proposl - what we had at the last LSF was people
> > > > > > > jumping in with half baked alternative proposals that very much hadn't
> > > > > > > been thought through, and I see no need to repeat that.
> > > > > > > 
> > > > > > > Like I mentioned, there's other work gated on this patchset; if people
> > > > > > > want to hold this up for more discussion they better be putting forth
> > > > > > > something to discuss.
> > > > > > 
> > > > > > I'm thinking of ways on how to achieve Michal's request: "as long as
> > > > > > there is a wider agreement from the MM community". If we can achieve
> > > > > > that without LSF, great! (a bi-weekly MM meeting might also be an option)
> > > > > 
> > > > > There will be a maintenance burden even with the cleanest proposed
> > > > > approach.
> > > > 
> > > > Yes.
> > > > 
> > > > > We worked hard to make the patchset as clean as possible and
> > > > > if benefits still don't outweigh the maintenance cost then we should
> > > > > probably stop trying.
> > > > 
> > > > Indeed.
> > > > 
> > > > > At LSF/MM I would rather discuss functonal
> > > > > issues/requirements/improvements than alternative approaches to
> > > > > instrument allocators.
> > > > > I'm happy to arrange a separate meeting with MM folks if that would
> > > > > help to progress on the cost/benefit decision.
> > > > Note that I am only proposing ways forward.
> > > > 
> > > > If you think you can easily achieve what Michal requested without all that,
> > > > good.
> > > 
> > > He requested something?
> > 
> > Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> > possible until the compiler feature is developed and deployed. And it
> > still would require changes to the headers, so don't think it's worth
> > delaying the feature for years.
> > 
> 
> I was talking about this: "I can live with all the downsides of the proposed
> implementationas long as there is a wider agreement from the MM community as
> this is where the maintenance cost will be payed. So far I have not seen
> (m)any acks by MM developers".
> 
> I certainly cannot be motivated at this point to review and ack this,
> unfortunately too much negative energy around here.

David, this kind of reaction is exactly why I was telling Andrew I was
going to submit this as a direct pull request to Linus.

This is an important feature; if we can't stay focused ot the technical
and get it done that's what I'll do.

