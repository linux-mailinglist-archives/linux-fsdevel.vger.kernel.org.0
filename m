Return-Path: <linux-fsdevel+bounces-58577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C114B2F006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575536869CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7289212D7C;
	Thu, 21 Aug 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7e99MJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085342745E;
	Thu, 21 Aug 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762328; cv=none; b=SkDbWZBEZE/86zZF2up1kvAE+1Z2p/RjfpqxfnFiNFLG5oPaAOuSfJgMwT3p7WwrEaHDT/EvMi+6B4sxEAJFP+fhdiYV+tpMuC5/lF/QyQBopkA2/dJTXxiN9Q0RDcknx8m9aUfBbG4w8lIzS7AhqH20j1yHR3bLdLEAE0N2KBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762328; c=relaxed/simple;
	bh=422P2Pgks4HS6zHxMZma3U/z4rUYA1FhR348AlY5h3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5ruNNuH951PyJgUslmpQ7Hj5PlGWns2p57ApXdlnSfkh8JKvT97Y5p9PUfgUJW/pRQxCNd8YL8czw6hr2het/svrwtzT26N5UBPoa4rfWLh+d618I31deN/36ElxUNaa8kV//0Iqkbv7VkZfgi9Kbfx0Fx+mdmqMCBOuzRnq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7e99MJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F6C4CEED;
	Thu, 21 Aug 2025 07:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762327;
	bh=422P2Pgks4HS6zHxMZma3U/z4rUYA1FhR348AlY5h3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7e99MJqS8P/+i5jz5OraVdWgEmkQnrzKdlmYPnBMXUmy1nfhakK89fAOBHh0aWRY
	 rVPskH5dzNp1qmEwMqDRZVepUK9Xnw14CT7bxZIU2WRxOV/2a39Es177IdNolpGr8n
	 1igp4V+E8LatvrXp7+bbvVeSFRp1wI+HfDqHDQJJ7fabOpInL59NBFG/ShmbaWWgRu
	 S8+0HTOCXCDymQvKlSFAi/2gU0MnLMjNSV7xaGcBUxF/lzKL95MJUCeQawtZjzrdeS
	 Z0SajRLiPF6wHsNaP7lXSrHaAVb7yitP0zePsHLsFYWypMOU4V56g667Oz4GFCK61T
	 BDNs8O9CnRtGg==
Date: Thu, 21 Aug 2025 09:45:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	x86@kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250821-erkunden-gazellen-924d52f0a1c6@brauner>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
 <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
 <20250819003908.GF222315@ZenIV>
 <20250820234815.GA656679@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820234815.GA656679@ZenIV>

On Thu, Aug 21, 2025 at 12:48:15AM +0100, Al Viro wrote:
> On Tue, Aug 19, 2025 at 01:39:09AM +0100, Al Viro wrote:
> > I'm still trying to come up with something edible for lock_mount() -
> > the best approximation I've got so far is
> > 
> > 	CLASS(lock_mount, mp)(path);
> > 	if (IS_ERR(mp.mp))
> > 		bugger off
> 
> ... and that does not work, since DEFINE_CLASS() has constructor return
> a value that gets copied into the local variable in question.
> 
> Which is unusable for situations when a part of what constructor is
> doing is insertion of that local variable into a list.
> 
> __cleanup() per se is still usable, but... no DEFINE_CLASS for that kind
> of data structures ;-/

Just add the custom infrastructure that we need for this to work out imho.
If it's useful outside of our own realm then we can add it to cleanup.h
and if not we can just add our own header...

