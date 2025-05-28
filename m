Return-Path: <linux-fsdevel+bounces-49951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E28AC639C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D13A78F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB724634F;
	Wed, 28 May 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNqcsvHH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i72A5JCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DA1990A7;
	Wed, 28 May 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419477; cv=none; b=c1wEY/s9/2ZvSqvS29sRt+f3sEwWymGRj6WRcCwpDC0H/Vs1Ude6EyXZdkb2HqMHI9FiESN3w5N500Wr/AOluM+LM0MIrlabFuvsJGwcOHshWpZ6r5N5EHEcOwCF1H8tu5vPwBknv2v2WxK82oDR0LS41kLRa7TWvZCYZjfiKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419477; c=relaxed/simple;
	bh=XqT576a4+pge7B4a4Rzz0v2Or+g/qgeLaa1Dg40HAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDnEnz7oTXacd9/v5x+ct8kNeyxigX2YmGHaiFW1M5arr5pGO3lk2E00PGS2WS5TOz0i+CAVHYQZEBYj5inuBS7GixK2gTIiqJnMiChSlVCYWdLIdvfFEHfFIzArd9+iM9bHRGvYmZhinix92Kzc8m4SiT/OWJZ6yF5shDxZMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNqcsvHH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i72A5JCB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 May 2025 10:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748419474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovrRv3FXIRrWqtjmQh9OpUxF47ZJQWlIULBJidB3gng=;
	b=wNqcsvHH6McVUSiMrlgCo3LTQwVwhgf0mPCMpt9R2KGu+FVTqTVg5a44RP2KRT8Pc5+bUL
	xAcg5mYhzBkLFccdvw9AEQMsMkcnwsOGdhqfA07+KXbUmfF/+Hs24egqAooz+xrvNoBJEC
	77TZ5xYpidvzv0TUnWNf/IrD9VLDfuy2y3vKm82746Gtjoa2KimeBWr8/YiNdTOic68Zd9
	TSHZ80jmP5k33g/IjGozXKDUflBl+oPF3WWmFd0LYehqLrJ89Z548y9LOpoe4ewY/JuUMG
	6adKo/tWZ5vPFEwHAhiJxsGzHdmjpzgpKgZelfxg3gj7mcJoA6FAbcT9utqs0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748419474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovrRv3FXIRrWqtjmQh9OpUxF47ZJQWlIULBJidB3gng=;
	b=i72A5JCBGUIF5ClurNrGNHBichGzZbPsYF1G187CWSqEG0evuQoIdcPRiH7PHQLMuLtxSf
	1uLDT5gD4W0S1DBg==
From: Nam Cao <namcao@linutronix.de>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
Message-ID: <20250528080432.Qke-VMIY@linutronix.de>
References: <20250523061104.3490066-1-namcao@linutronix.de>
 <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>
 <20250528061252.AeDA23yH@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528061252.AeDA23yH@linutronix.de>

On Wed, May 28, 2025 at 08:12:58AM +0200, Nam Cao wrote:
> On Wed, May 28, 2025 at 07:57:26AM +0200, Holger Hoffstätte wrote:
> > I have been running with v2 on 6.15.0 without any issues so far, but just
> > found this in my server's kern.log:
> 
> Thanks for testing!
> 
> > It seems the condition (!n) in __ep_remove is not always true and the WARN_ON triggers.
> > This is the first and only time I've seen this. Currently rebuilding with v3.
> 
> Yeah this means __ep_remove() thinks the item is in epoll's rdllist and
> attempt to remove it, but then couldn't actually find the item in the list.
> 
> __ep_remove() relies on the 'ready' flag, and this flags is quite
> complicated. And as my colleague pointed out off-list, I got memory
> ordering wrong for this flag. Therefore it is likely that you stepped on a
> bug with this flag.
> 
> I got rid of this flag in v3, so hopefully the problem goes away.

Sorry, I have been staring at this but still have no clue why. None of my
stress test can reproduce the issue.

Let me know if testing for v3 goes well.

Best regards,
Nam

