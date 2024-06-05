Return-Path: <linux-fsdevel+bounces-21027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C58FC7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6197C280DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF819191494;
	Wed,  5 Jun 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zt2q2PrD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="px31ShHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335118FDB0;
	Wed,  5 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579971; cv=none; b=fkIQS5cPtytcPJtjPiuq51Ge/Ll1WsHlvIKJdUgwrqo7ELbvrgjX1/U9NMq1D43jBMQFFWPFeOsU2ijkS0ZMZLhYe1ZERLVtuw7qS+TEAO47XgtR/sEOFe3z40A6NwViZ8bl4a/w41sesyLIYy7gd0RnGtGBegC39JL3tiEO+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579971; c=relaxed/simple;
	bh=XK/6HEEBqel68I4qK7gMpEapm1Fxtw7b6xoXSUyCcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f618067mXSJcajGmgxVCXb6e9ULIo977C0ijYZlfguOafJVbAgndO26V4AmvwQ+eDT9P3VeQb4SaAHBpe+vM/V1WXGKsCrudpQufN/E3cSOjo+uv4kKrIdnuBjNYW79Ela3+DSh6751fw5d78AVz+syqUxYVtgq6aNWnkpQa0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zt2q2PrD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=px31ShHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 11:32:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717579968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqwF6CTuXeq+g+O4kDSfN50ZkhRT5kp25rJRvwHPMcI=;
	b=Zt2q2PrD6wFLokbQU71Rs1+GTzXllFXex0MMiwdX4MjEKr9z9gOJrUeQqam/hFdzaa7mki
	g/hkMmRLC1MiOnsh/Yey+fom476gN0shd6kiaX/dAGhd/+4ufEBEN1W/GKGM4A0I8QH2bb
	pjXC7GNwVpuEXtd/ZSGx44Uz83Qpqwz0Y6iPZZwvrRXR1cAzNVdjVn3zWTxQ8RWHDZoojN
	+ypTbR+g1vBz2OSUsMp3h6IUzxQ7JVppPJJeyXKpz43O3cmbDtnyQFi5UAkMkIbQYPFjLn
	JxQb86r8eLT91EG4urdxHmxOiienUDhAvctHZkpz3CNmFBGWc1uVMlOQTBlanA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717579968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqwF6CTuXeq+g+O4kDSfN50ZkhRT5kp25rJRvwHPMcI=;
	b=px31ShHVt0BtWQye4D7Rmd+CGJ4wSj2rDWjbybZnQrvi82q4iRNH0pTMA6Xwt7ctN7NP+n
	cyAi0Dc2KlPdQ/AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240605093246.4h0kCR67@linutronix.de>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>

On 2024-06-04 17:57:46 [+0200], Daniel Bristot de Oliveira wrote:
> On 6/4/24 16:42, Qais Yousef wrote:
> > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > +	    (wakeup_rt && !realtime_task(p)) ||
> 
> I do not like bikeshedding, and no hard feelings...
> 
> But rt is a shortened version of realtime, and so it is making *it less*
> clear that we also have DL here.

Can SCHED_DL be considered a real-time scheduling class as in opposite
to SCHED_BATCH for instance? Due to its requirements it fits for a real
time scheduling class, right?
And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.

> -- Daniel

Sebastian

