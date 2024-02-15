Return-Path: <linux-fsdevel+bounces-11783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE585721A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87751F23F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F240F14830D;
	Thu, 15 Feb 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1agdiFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287B146007
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041280; cv=none; b=Hp7s+CMhC7mqxrUWBJ4vymccorOISzhLn+X16ZmUyApoU17gnhFunkZzZ/I+Kj8MkIslS/3KkP7d4/0ARRU1+Ucox+0Hm7VPAf/5I2pvqFuTxKrW7znv8mhDz5pg2mAcvnXyxdwqV51EWqTmWDjlA8srVOPSoiU8mScX2t0jgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041280; c=relaxed/simple;
	bh=XH/LH5AcQ9vTPSWj8ejMl5YLc1dGNFipWkDEygmqHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQp4J4Zl1l29sz5Y0woClca0ADDrOfO4YBuwFKh1DiybrNnpgcjqffI6Xgq5pGD8BaeefIKfT/+gOS+34Zzaaua00fJoB8XhUKs3CvzEblQHj2N1r7QxrUZG6Xdu3Lbd3W0Ko4xJpKKMXe/mGX0q+fIVEQ8Qx98SiaAgcnQhO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1agdiFf; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 18:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708041276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2uij+2SL3ce4+254m7l2JMunInmvxqqhYhnbhOg6QE=;
	b=V1agdiFf2PWalNLvXcX/pEaaYs1LzTR99jNKgHHksR9pk5/i4sCMiqHAc6qlownhM5WAyl
	OqzNpW/LSM50S1rLe7LeKiTEyj4Uqd2FpbwOOt1xn3GjS5Kqmd+qtGSoP3zkFaJ1MFitLS
	Rmu6c2taXzQ47IwNRs2zeWhJq1hQz2g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
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
Message-ID: <6mjunla45lkwqvkq7jegiw5lfmufg4y53zegevep3iwvy77xub@2nfmbeo6tvz2>
References: <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <38e34171-e116-46ee-8e2b-de7cc96d265e@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e34171-e116-46ee-8e2b-de7cc96d265e@intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 03:19:33PM -0800, Dave Hansen wrote:
> On 2/15/24 15:07, Steven Rostedt wrote:
> > Just adding the patches increases the size by 5k. But the rest shows an
> > increase of 259k, and you are worried about 4k (and possibly less?)???
> 
> Doesn't the new page_ext thingy add a pointer per 'struct page', or
> ~0.2% of RAM, or ~32MB on a 16GB laptop?  I, too, am confused why 4k is
> even remotely an issue.

page_ext adds a separate per-page array; it itself does not add a
pointer to strugt page, it's an array lookup that uses the page pfn.

We do add a pointer to page_ext, and that's (for now) unavoidable
overhead - but we'll be looking at referencing code tags by index, and
if that works out we'll be able to kill the page_ext dependency and just
store the alloc tag index in page bits.

