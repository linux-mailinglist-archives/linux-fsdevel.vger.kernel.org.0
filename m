Return-Path: <linux-fsdevel+bounces-11775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B58570CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBB1283742
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CC145347;
	Thu, 15 Feb 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s7GjinpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD613B299
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037680; cv=none; b=j+sVq2rbkuW/CcYbwVm35cds16L/j8aHaXTEOCRBRZsmgH4cVjxuISBksxGPWWk4y9V7xciT/rSnceqgNcR5WRNM72OmA29+1Ez1pHCef6ACw5EeX6tOcxwf/trd8CL1/rW+hblcGMRo7+ziUDFeREJcvlFDuJduDFnyDnUARFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037680; c=relaxed/simple;
	bh=vpFxO4vaBL6utiq3PQIPAVgPBDoFbQo1foIo5AqK8Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPnz+knajRjFhlxtNKF1BmuhwFV/nRaGEsYPsZycjZDYh+CINgp0frNPer/1v0Px1fxmvFFYf7uLIiNDM8e0xiCQN8859age0NYp9b+bnh305C9FRvKowWEaJSPrmNO6DqYL4jvatHjC+iC9IdxAbbk0XzF7SXCz0MRsbDAVnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s7GjinpF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 17:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708037676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDSi9l3t5jb4xqm42oA6b90TgSdD5o5/qEQqj726Xko=;
	b=s7GjinpFAKYCSUH++IShUfbdX2oRHH7jMoJOiFXnURQJriQJpk2c1g6IKodkBsWFrf3tMo
	lRA7KcUWR9thLhS4EQcOGTvPoXKrv2i+J/AXkZWZfF3jhzdVpibqSVtKnHN1t1gucGHdc8
	uhGVZUZbURioLMmI/fU2b1rDFnFpKMs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
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
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <ojym6woqflzp6qarjgfubzq6wjgcju4cv4t3kfpfk77xhnxt3t@xmuarv3rdqsq>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <Zc6ILbveSQvDtayj@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6ILbveSQvDtayj@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 10:54:53PM +0100, Michal Hocko wrote:
> On Thu 15-02-24 15:33:30, Kent Overstreet wrote:
> > If we want this report to be 100% reliable, then yes the preallocated
> > buffer makes sense - but I don't think 100% makes sense here; I think we
> > can accept ~99% and give back that 4k.
> 
> Think about that from the memory reserves consumers. The atomic reserve
> is a scarse resource and now you want to use it for debugging purposes
> for which you could have preallocated.

_Memory_ is a finite resource that we shouldn't be using unnecessarily. 

We don't need this for the entire time we're under memory pressure; just
the short duration it takes to generate the report, then it's back
available for other users.

You would have us dedicate 4k, from system bootup, that can never be
used by other users.

Again: this makes no sense. The whole point of having watermarks and
shared reserves is so that every codepath doesn't have to have its own
dedicated, private reserve, so that we can make better use of a shared
finite resource.

