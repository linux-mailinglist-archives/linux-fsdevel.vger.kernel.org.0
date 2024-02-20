Return-Path: <linux-fsdevel+bounces-12168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F285C2B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B91F2209E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150A77631;
	Tue, 20 Feb 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fxyuYm2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF97768FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450367; cv=none; b=bnDz7MpbMjekqRBkZffr9PbpZEjPpX+Xq0It8z6PhbHBZS5oX9PLgU4YkW/DeibCbxPkbEgfJaRfRKEYz5KjxSfjvGkK5uPHxfl90xCjbaUYIFqiFrJS13dEW2SSRCPFkWRXNE8P8OFCmFGj6ZJx5ZbhMXWSLX60LJ3S/bflRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450367; c=relaxed/simple;
	bh=vLoBhOInKMXmUWflzrfzPFlT60Q1ZisK5pqmlkGmoR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/9O8BSay9DESk1+v0mh7Pv4Iw8xK10Bl2GToE4JlMOpJtyLU8IjkhzR0Dfp33EDtCrcT2h5xhJbHhchemN0gKWHBomdYNVMjoVaiMvVbdTuziLHcTL8w3b0gxLGO7dcBC3gthoq7SR1ZnC+PiY+GYot4Un7AsUCjYO8efI9ST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fxyuYm2K; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 12:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708450363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OL5xFDTNv2eO4cGs2LE/aYT6r12sFC1afgYu/aCZ6KM=;
	b=fxyuYm2KyZqwOjeFMmi1Let2DbXxCie5EhloySkSitC8BRgYw+g8xhKzEPRyrpwaBbr/TU
	0tafzqcQ40XKTEmAPrIZ3Iw4O895GFa3q7oGe4uavWICcPdzTfB8TRB60MOp0jzPbPvQnG
	iSWlmNcgFKjgbSQNuTfPAxD2k6jceVg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <jwhienldkk4gfxcv5giaxbphp5irfleo2c2inezaj34xu4gkmh@uujdnks2r5w6>
References: <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home>
 <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
 <ZdTSAWwNng9rmKtg@tiehlicka>
 <qnpkravlw4d5zic4djpku6ffghargekkohsolrnus3bvwipa7g@lfbucg3r4zbz>
 <ZdTgWb7eNtF4hLw2@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTgWb7eNtF4hLw2@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 06:24:41PM +0100, Michal Hocko wrote:
> On Tue 20-02-24 12:18:49, Kent Overstreet wrote:
> > On Tue, Feb 20, 2024 at 05:23:29PM +0100, Michal Hocko wrote:
> > > On Mon 19-02-24 09:17:36, Suren Baghdasaryan wrote:
> > > [...]
> > > > For now I think with Vlastimil's __GFP_NOWARN suggestion the code
> > > > becomes safe and the only risk is to lose this report. If we get cases
> > > > with reports missing this data, we can easily change to reserved
> > > > memory.
> > > 
> > > This is not just about missing part of the oom report. This is annoying
> > > but not earth shattering. Eating into very small reserves (that might be
> > > the only usable memory while the system is struggling in OOM situation)
> > > could cause functional problems that would be non trivial to test for.
> > > All that for debugging purposes is just lame. If you want to reuse the code
> > > for a different purpose then abstract it and allocate the buffer when you
> > > can afford that and use preallocated on when in OOM situation.
> > > 
> > > We have always went extra mile to avoid potentially disruptive
> > > operations from the oom handling code and I do not see any good reason
> > > to diverge from that principle.
> > 
> > Michal, I gave you the logic between dedicated reserves and system
> > reserves. Please stop repeating these vague what-ifs.
> 
> Your argument makes little sense and it seems that it is impossible to
> explain that to you. I gave up on discussing this further with you.

It was your choice to not engage with the technical discussion. And if
you're not going to engage, repeating the same arguments that I already
responded to 10 or 20 emails later is a pretty dishonest way to argue.

You've been doing this kind of grandstanding throughout the entire
discussion across every revision of the patchset.

Knock it off.

