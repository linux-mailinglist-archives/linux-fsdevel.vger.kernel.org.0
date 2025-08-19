Return-Path: <linux-fsdevel+bounces-58234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97436B2B71E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF719646EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E427F728;
	Tue, 19 Aug 2025 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KR7Rk8BE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24A18E3F;
	Tue, 19 Aug 2025 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571181; cv=none; b=iLe66nhHY3mgu6GQqtjL7njy5doQ3RGt7/MeQFlJK1zMnDV+Jrz3rBudtiBI0gTtVg0SG7C7TNaB8/UqQkXphNc1faD5e5/LE1xiAs6yP4tttMGFMpXvXAEY0WdBMxpGEDSNNKLvpjYKDVA9XACi5L7xxvxNAtuXf5O8/Bxz/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571181; c=relaxed/simple;
	bh=TN2ocsaYNhdfe3/z+EADsm8essH3vl8sypYjjegrTMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxx7+tVQaLt5XJ/9Ffeh803bTCI4ihfe5vIAZT4Vzoj3xrK5CReIyAslUsWkNXyUFlVWCVeuaIK9jFpy+b/q4d55kQzdDnXE2794Dch182m8c9Aq2w9H3sWrXZh+auXMaHM8iWqqgC6UvyJgllagPZnIegEo3QVZocm36Au6lIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KR7Rk8BE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wUhaNFsToitgdaTkuztvZ6hkSHZHvb02b0d7C/3jRpg=; b=KR7Rk8BEECLyGzAUql4YzTGydq
	ZLxT0MxL8c8TkrvGzV2buFajt8NviB4m7arDi8ct0xQN3NFYqKAGozqmsQ4f92ivc3EtJR7tM2/ch
	6eGlWcDgpND/oaseaBV+36Tb6cxsL+nVgaBhKmH3nIOTWvNLdB24ITY1i4ZJODf42z/axNphgRMaI
	DkA9BR0OxYWgL4guh29sryK9jh1w7C+7ZGY8GlkpKLt89YlIu8mWhMh9OCz3W/txhC2PELnNcoFXf
	iXd4NlbWWanDQEOEGqcvywpX03EiPLwQ/RYt4wEsWcCUu0xEymfOXPUfij6twCMV1qO/AuVBfjPsZ
	ljZHbQxA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoCG3-0000000EugE-3hli;
	Tue, 19 Aug 2025 02:39:31 +0000
Date: Tue, 19 Aug 2025 03:39:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <aKPj4_-3wNu2v4J2@casper.infradead.org>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>

On Mon, Aug 18, 2025 at 02:36:31PM -0700, Linus Torvalds wrote:
> I realize some people have grown up being told that "goto is bad". Or
> have been told that exception handling should be baked into the
> language and be asynchronous. Both of those ideas are complete and
> utter garbage, and the result of minds that cannot comprehend reality.
> 
> Asynchronous exceptions are horrific and tend to cause huge
> performance problems (think setjmp()). The Linux kernel exception
> model with explicit exception points is not only "that's how you have
> to do it in C", it's also technically superior.
> 
> And "goto" is fine, as long as you have legible syntax and don't use
> it to generate spaghetti code. Being able to write bad code with goto
> doesn't make 'goto' bad - you can write bad code with *anything*.

Even Dijkstra doesn't argue against using goto for exception handling,

"I remember having read the explicit recommendation to restrict the use
of the go to statement to alarm exits, but I have not been able to trace
it; presumably, it has been made by C.A.R. Hoare."

https://www.cs.utexas.edu/~EWD/transcriptions/EWD02xx/EWD215.html


