Return-Path: <linux-fsdevel+bounces-53103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D2AEA309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798075645C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D02ECD22;
	Thu, 26 Jun 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S03IpRZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZniZOsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649611DD877;
	Thu, 26 Jun 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953408; cv=none; b=Woe2OzQryOj9D8MfdDExPh02sgeHU0ZGvpoT4GhMxwXbBQpmXgLpZywNqb5LvoY3Nkhw1jPLrGDcVleVDYhQzv2um5vAXeg+t/8LyKERzc63q6ouPHoOJD6tQ0EtDmatQK50m+0XYJOozQXdATduM6WeSObMx5jo+7V4X52lyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953408; c=relaxed/simple;
	bh=rybJN06mgv13zdPiHHr7i1lOk1LsqKXQE/QFVRIo3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw1UqTlulVlDfjdh/Ky3MxDOutPUEAnH+2Aza4X/oh+vGD6CTF9F4JTlz3T09E5jLzmnx8mSUI5mfPsgcSCIQLfJdxyEA03WXzA46npUYfs8P1NFaA8oPUMyzxGYG/SdKPUmQZNM6eDfa9ddKolbjFuD2eI3Un0lz1QZKVHiswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S03IpRZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZniZOsd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 17:56:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750953405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CodcwG6/9zB1OloXEa4wLT73oaQphHh7S1TbMwPPLgo=;
	b=S03IpRZyOvD9X0dEIRWKWTDzsd8obfRxF9hpgysuvqYdEGzFrT83beOPgC/xHhijF85IIV
	+e+vCeK1LFmpc3bwuhitHe9idDRjBedeLWJmiUsEfbUSb3jZxIULMvRWohx/YlYIaroiQU
	Yckb1LaEKScYirKyNvqNvVQYGo4/RjMZncxvg3+CIi1/V58FQvoc1O8o0xwtI1BJTU14qF
	xM0+fVo77wSWn/NOS3DWhKonDfggeMj4cL2PjxYZIx7VtiRPisJnCziPLGJHlJ3T+VSJBC
	04+lW1tGo9RbdIzfnWHSVtPm11VnlVRe4D3MFgQ5PukuNSYvwmKg8YWs85+bVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750953405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CodcwG6/9zB1OloXEa4wLT73oaQphHh7S1TbMwPPLgo=;
	b=0ZniZOsd029mDmTdhfI7TFTg+t6muQle+KJuI9j67bbNxvAntpTSiH8mIKM/H/2autdodf
	csGWhKKJZL+HjiDA==
From: Nam Cao <namcao@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250626155640.q8tGTFT-@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <841pr6msql.fsf@jogness.linutronix.de>
 <20250626154954.NH9L0mtz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626154954.NH9L0mtz@linutronix.de>

On Thu, Jun 26, 2025 at 05:49:54PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-26 17:29:46 [+0206], John Ogness wrote:
> > > @@ -361,10 +348,14 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
> > >  	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
> > >  }
> > >  
> > > -/* Tells us if the item is currently linked */
> > > -static inline int ep_is_linked(struct epitem *epi)
> > > +/*
> > > + * Add the item to its container eventpoll's rdllist; do nothing if the item is already on rdllist.
> > > + */
> > > +static void epitem_ready(struct epitem *epi)
> > >  {
> > > -	return !list_empty(&epi->rdllink);
> > > +	if (&epi->rdllink == cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))
> > 
> > Perhaps:
> > 
> > 	if (try_cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))
> 
> Not sure this is the same.
> This will write back the current value of epi->rdllink.next to
> epi->rdllink if epi->rdllink.next is not &epi->rdllink.
> 
> The intention is to check if epi->rdllink.next is set to &epi->rdllink
> (pointing to itself) and if so set it NULL just to avoid to ensure
> further cmpxchg() will fail here.

Exactly, thanks Sebastian.

I tested the suggestion, and systemd blew up.

Nam

