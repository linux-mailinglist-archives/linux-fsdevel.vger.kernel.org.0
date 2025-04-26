Return-Path: <linux-fsdevel+bounces-47437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B376A9D754
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 05:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0128C7B2040
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9620371F;
	Sat, 26 Apr 2025 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMnyjBQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19A15A864
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745636450; cv=none; b=NxsS869rw9RamarIhjzHNO1TZsizXRzDqj+via8UowCMyLhVUDiD1BJ+GFVgp4wCqd/SQWaCB61nIs30NmW497obZaSlLrPkrUwAsFiCZ6g2gxuwZO7jWN2pLNLNaLR3/fj62Pj31e62WhB3fMzh4YDgiIpxAJwcUwoDbbJQCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745636450; c=relaxed/simple;
	bh=wMrLh6+JBD71sbzGOVePWFTaJpeQD1TA2pNoVbtpJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppQyOKhMYFmNcTNJCmla11aN/wcVNhF//xoP6fPB+i/HYOEvv/Vt/CA1FOtnYBUhgR0qSmLIoVy4JWjt/kQIyertyYNoDmJpL10uULSbXqUeiEGKDwryqamgcynG9Shu+PwhM4v0LZt7HvSFoFbnTHAk2lcfrAZmmE+jZegFsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMnyjBQ2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Apr 2025 23:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745636435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brMWIiS2FVkjG+Wb7CsJ7g3GTpla+vdPud2BrTa9MLc=;
	b=KMnyjBQ2CUbCMU2ywwOi5FYezdGRIZLVvr//sm4pA6VY99MGMrN/+wN5DR79RxJe6i1nLP
	IoSw4nRSaQyhccFsN1ccAkdjRwnV0gDFm4QEwKezsjsKdwLnX3A5v8o5AWMalYJTZJl4lC
	zmeHc5jnpLHp5iqxu0e5AOVq3bthdWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 07:47:09PM -0700, Linus Torvalds wrote:
> On Fri, 25 Apr 2025 at 18:38, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> > >
> > > The thing is, you absolutely cannot make the case-insensitive lookup
> > > be the fast case.
> >
> > That's precisely what the dcache code does, and is the source of the
> > problems.
> 
> I think you're confused, and don't know what you are talking about.
> You'd better go learn how the dcache actually works.

No, what I wrote is exactly how CI lookups work with the dcache. Go have
a look.

