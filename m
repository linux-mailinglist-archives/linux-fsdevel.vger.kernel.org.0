Return-Path: <linux-fsdevel+bounces-11489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07736853F35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8557EB2C594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7A634FB;
	Tue, 13 Feb 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d6oZDfuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4B627FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864622; cv=none; b=HI8wWLbQgNX9HxYn1/viNMUihtsZ0/l/TS9xHa7UyOh6mRV8LabBWcqDFbRJ7sbxAETIH2IYOb3bUFnKOBOgefCLs+YB/PCGkhibpHRillU7/pSRXX1mlvvFhX+wHxlTHSAhLh4EUm9ONlUsv28Qpc5Teh3M3VJa0JwPdBM1LlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864622; c=relaxed/simple;
	bh=mnQeHdgfKd4auHjv2tW4/02mQfMb9y+DoY2fOGMIveo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmeBLrjQEDrBXHVsiVwHI3yONzGqQItEn5RfRH3sDuNLf+IjPEs0RminWM+EG7H5SUPGXRELbWfc5NN6K6cr+UrjX+LO/hfFDAGFfm9m5/Ff/4nvwt/lKxZu70qspuTKU0VssJYvypHInR2f+Aj+o9WxeG/MMJYCeC/kW0feXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d6oZDfuz; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 17:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707864618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiv4lM5HdhNU9bAiRFQZPMt1GA0MoNC/u5JMEJbfz1E=;
	b=d6oZDfuzS9N5a1qMbAKQ6zykd9yi5/xuQTmJuP4NK+YG9v3rNyDZZwDU2xN8Y2FicoJDuR
	aO5Kuq9UCaA2KN9t39NpZ8EYZI34DD/+bkBS6+86bRfaQK36VndzqUyNd6byW8mhlIELi0
	1iDpFn6Sx8ce8Gl7n1t1eE2XT/JFYxA=
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
Message-ID: <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
> On 13.02.24 23:30, Suren Baghdasaryan wrote:
> > On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
> > > 
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
> > > > > 
> > > > > I recall that the last LSF/MM session on this topic was a bit unfortunate
> > > > > (IMHO not as productive as it could have been). Maybe we can finally reach a
> > > > > consensus on this.
> > > > 
> > > > I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> > > > need to see a serious proposl - what we had at the last LSF was people
> > > > jumping in with half baked alternative proposals that very much hadn't
> > > > been thought through, and I see no need to repeat that.
> > > > 
> > > > Like I mentioned, there's other work gated on this patchset; if people
> > > > want to hold this up for more discussion they better be putting forth
> > > > something to discuss.
> > > 
> > > I'm thinking of ways on how to achieve Michal's request: "as long as
> > > there is a wider agreement from the MM community". If we can achieve
> > > that without LSF, great! (a bi-weekly MM meeting might also be an option)
> > 
> > There will be a maintenance burden even with the cleanest proposed
> > approach.
> 
> Yes.
> 
> > We worked hard to make the patchset as clean as possible and
> > if benefits still don't outweigh the maintenance cost then we should
> > probably stop trying.
> 
> Indeed.
> 
> > At LSF/MM I would rather discuss functonal
> > issues/requirements/improvements than alternative approaches to
> > instrument allocators.
> > I'm happy to arrange a separate meeting with MM folks if that would
> > help to progress on the cost/benefit decision.
> Note that I am only proposing ways forward.
> 
> If you think you can easily achieve what Michal requested without all that,
> good.

He requested something?

