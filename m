Return-Path: <linux-fsdevel+bounces-11470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECA853E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A281F1C2623B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A62626C6;
	Tue, 13 Feb 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wiJHD1ro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C116217F
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862164; cv=none; b=DXzWje/aKWCVbwPpPmSLgMwGewtIXwt4HvLEsCFHAu++TcVL610epNtaq/nSrcln2CI1MNWa46bYKUtpXWC+s75OVYBEgjEmnQ8dgjTACyUiU0m86/ndckjabX/Jm3/AIGVgyeycDpEwUG5x96sjY2E9V80HT8Ndl1dB/O2QNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862164; c=relaxed/simple;
	bh=CQb32P5/QLDxINSuKEKh86H/jAnvOUAlJuL9HRgom5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcKunuaznsmFet/Gl4J0Ns8DOvTa4V9XNcekMB9wdpqDSFgbqQlV5kbTFXFuV4pQXd85onr2pWwv96cBm528Bnxfp62YSWRE2+doJVwutJfeTmKnLjgep5VixLBzNrsPKPKYq0gT9EgdD/SfHfiw0WBZtTZibqnKQbgQBjPEeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wiJHD1ro; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 17:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707862160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K19bAPZc3Kc3I3XpLB02dh4st8ojApfa6FF0rrEkdlU=;
	b=wiJHD1rocU4W8es0ltTxc6zAKxsWq50Cz4wsYEYyTUt+NDk4yTr58JN+k2ZAwaGAMttrjn
	Ck50Qdg/1aaDREh6YRmyahMrRfD0jYD6p78aHLEPD5//ML214VVyZeX2kIoz692QSHm6HT
	8WN0b9HNN/rXmUQrlAmcLAijp1Fq9O8=
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
Message-ID: <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
> On 13.02.24 22:58, Suren Baghdasaryan wrote:
> > On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > 
> > > On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> > > [...]
> > > > We're aiming to get this in the next merge window, for 6.9. The feedback
> > > > we've gotten has been that even out of tree this patchset has already
> > > > been useful, and there's a significant amount of other work gated on the
> > > > code tagging functionality included in this patchset [2].
> > > 
> > > I suspect it will not come as a surprise that I really dislike the
> > > implementation proposed here. I will not repeat my arguments, I have
> > > done so on several occasions already.
> > > 
> > > Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> > > this debugging feature will add a maintenance overhead for a very long
> > > time. I can live with all the downsides of the proposed implementation
> > > _as long as_ there is a wider agreement from the MM community as this is
> > > where the maintenance cost will be payed. So far I have not seen (m)any
> > > acks by MM developers so aiming into the next merge window is more than
> > > little rushed.
> > 
> > We tried other previously proposed approaches and all have their
> > downsides without making maintenance much easier. Your position is
> > understandable and I think it's fair. Let's see if others see more
> > benefit than cost here.
> 
> Would it make sense to discuss that at LSF/MM once again, especially
> covering why proposed alternatives did not work out? LSF/MM is not "too far"
> away (May).
> 
> I recall that the last LSF/MM session on this topic was a bit unfortunate
> (IMHO not as productive as it could have been). Maybe we can finally reach a
> consensus on this.

I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
need to see a serious proposl - what we had at the last LSF was people
jumping in with half baked alternative proposals that very much hadn't
been thought through, and I see no need to repeat that.

Like I mentioned, there's other work gated on this patchset; if people
want to hold this up for more discussion they better be putting forth
something to discuss.

