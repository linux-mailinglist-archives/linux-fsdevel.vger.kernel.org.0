Return-Path: <linux-fsdevel+bounces-55414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E030AB09E88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2DA3AA32B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52846FB9;
	Fri, 18 Jul 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/f98m3P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JktdbcIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D03293C71;
	Fri, 18 Jul 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829202; cv=none; b=jyGuYqL5+p6S96EoFxidacY5xxoQodXZsBLS8NS4bF+CS4lAAGSiQ4twRCJ12R4rlqtA+twwfHdbX0aZqO9HN43ACqFAy7oHjDs70JEA3KQ3/Ett0ul5GRFRNRAbMPfVw+wR/j3FhfeHFkBIoPiDh8Iuak9mwUthWvZmXGZBXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829202; c=relaxed/simple;
	bh=fo7dMDrlXW/r0/8HGLb408wpfQ2KlP61XOvxXanDXAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z28ya1w3veAyfZDqinIGk+CLSvzEo5S39HQ9f5AVahbfCzGw8+To2dgplZ8/qbSxXyyxpdbyvg4i2pJuxBNteJU4ZMpgfkFEZDa9EdRP8HEgKlADlMBPTPBwSLbqTZ/qJEDDmy3vmkiLgqQIg0wGvWPb0z6HopFmWYUWk8TnKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/f98m3P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JktdbcIo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 10:59:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752829192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWlxW6vXsjgEyOx30tgpd5N2CQfifCbYx17NMEBHLTA=;
	b=e/f98m3P+mE1HzVOqsvi7eQujVelbnYqeMFOQGiW/mRHAIRSXvUTJRiehuOyv+OLNTQNLx
	zRJBcu2OZj3s5UGjowiQiU+jv9ZAyDgNXxaV5YwgZX3cgaHZcTrt6cCRVHvV47SeP2RIZo
	RbgSf2AhpJD2GE72uraNMTYhb7228sCVdY1gC0UTC9XFj09IeM6CPmYHpr4rEdAHo/JNKf
	C4J5WzD+MS40GJrpKUXVuE/8JpL7/07daVZgnehT0Av5p3lS6rQLcrF1GZEqbceBkePh4j
	1Rs7hWAM1UvIo5pOH3ZaDRfMjTagWftfstVIDnvGMmv9+EGOKvIHIdwKk9eZTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752829192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWlxW6vXsjgEyOx30tgpd5N2CQfifCbYx17NMEBHLTA=;
	b=JktdbcIoEsmHbIxRkp7x/0QorIGj0IemDDdoPM415sgKzRbFFP/s4P1dytSNS6PcCjD1/n
	LIJBTH8Yvqo2VbCw==
From: Nam Cao <namcao@linutronix.de>
To: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Khazhismel Kumykov <khazhy@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20250718085948.3xXGcxeQ@linutronix.de>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>

On Fri, Jul 18, 2025 at 09:38:27AM +0100, Soheil Hassas Yeganeh wrote:
> On Fri, Jul 18, 2025 at 8:52 AM Nam Cao <namcao@linutronix.de> wrote:
> >
> > ep_events_available() checks for available events by looking at ep->rdllist
> > and ep->ovflist. However, this is done without a lock, therefore the
> > returned value is not reliable. Because it is possible that both checks on
> > ep->rdllist and ep->ovflist are false while ep_start_scan() or
> > ep_done_scan() is being executed on other CPUs, despite events are
> > available.
> >
> > This bug can be observed by:
> >
> >   1. Create an eventpoll with at least one ready level-triggered event
> >
> >   2. Create multiple threads who do epoll_wait() with zero timeout. The
> >      threads do not consume the events, therefore all epoll_wait() should
> >      return at least one event.
> >
> > If one thread is executing ep_events_available() while another thread is
> > executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrongly
> > return no event for the former thread.
> 
> That is the whole point of epoll_wait with a zero timeout. We would want to
> opportunistically poll without much overhead, which will have more
> false positives.
> A caller that calls with a zero timeout should retry later, and will
> at some point observe the event.

Is this a documented behavior that users expect? I do not see this in the
man page.

It sounds completely broken to me that an event has been sitting there for
some time, but epoll_wait() says there is nothing.

> I'm not sure if we would want to add much more overheads, for higher precision.

Correctness before performance please. And I'm not sure what you mean by
"much more overheads". While this patch definitely adds some cycles in case
there is no event, epoll_wait() still returns "instantly".

Nam

