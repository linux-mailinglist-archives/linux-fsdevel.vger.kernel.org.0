Return-Path: <linux-fsdevel+bounces-36973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEF9EB877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD7A1887858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F113049E;
	Tue, 10 Dec 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uil0BzFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81D23ED65
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852627; cv=none; b=Gp7s0KP0WDeqISwzPHx3semkY76HWeXhqw3yVhEwe/Ix+wCIRaNUcMQ5f7umYhhuzHs5c12wO5r3p363SNnSjMTIijasTVbIWbn+hh1STPJ1Qqtb/zE/QYbREcFX7U8vvlU6yYf9EEsL2KZ/2iCFwdXpQPqmtzX02MHqfLB9wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852627; c=relaxed/simple;
	bh=gQEg9p/kQ3qq8M3mg/+604/x/t/5uOQD2Jq2JjytWJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQHXOD7JI3zdIeLSJUete7tuaw7igb38cXifnpzr0pKkvPTbnYoUgqAXPGuJoEjLMHd6GEWo17oMgeXo9JkFWvs0Stry5s4F3xZx9pIS0SlzEu+u8x2nReEH9p/xEKSjtGXSvrfieKixH9MhoXLW7EbMLr+pBEwmQ1jkpx/By7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uil0BzFg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Dec 2024 12:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733852621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hwG4ZSEW3C0c0haKC2wSrW5OH2jsVGGuch/6H6WO++A=;
	b=uil0BzFgaBZKqVMPHshduH5UOSywoRKUra564d/Vygl/p+8s97uJDUfRDKVYAs2ACfQoXv
	fv5artvRoZAVym5QGLBVHuAQt9JduYf3Ax8bWoyMZaBEcPGeFZj1/nTSFGNCmihZsH/ZJA
	Q5q37Mi0U3UQzQ8yV6+RNM+Ry9nHKh4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <cxdcbgguwgvjimmr2tl5qdiszambkmin65y5ncdyqqxsiybrma@bicelbxa2tyd>
References: <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
 <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>
 <Z1h1mAIZlvbQIVNB@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1h1mAIZlvbQIVNB@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 10, 2024 at 05:08:40PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 10, 2024 at 11:54:18AM -0500, Kent Overstreet wrote:
> > I get the impression you might be flailing a bit, it seems you're not
> > exactly sure what's going on, and either Willy or Josef previously
> > alluded to a lack of assertions - so I'm going to echo that.
> 
> This comes across very patronising.  You don't know Joanne and I
> suggest you refrain from making assumptions.
> 
> > Haven't looked at the relevant patches yet, but if you'd like me to look
> > and offer suggestions I'd be happy to.
> 
> You should probably read more carefully and think a little harder about
> what you're writing.  I made some suggestions about what could be done
> to narrow down the bug to a specific path; Josef looked at the patch and
> found something that looked wrong.  I confirmed it looked wrong.  Josef
> sent a patch; Joanne fixed a problem with that patch.
> 
> This does not entitle you to say that Joanne is flailing.

Seriously?

