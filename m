Return-Path: <linux-fsdevel+bounces-21028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC18FC7F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 11:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D089281EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B61922F2;
	Wed,  5 Jun 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5rcPLyF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KvP6XaFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0EC257B;
	Wed,  5 Jun 2024 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579994; cv=none; b=M6F3LyFpRRJF7s8KtKkD2o1wLnNJrtyv9wui6E9vCrPWrDrLnmblw5mWY+MjeXHIzSg51eU3BCX/Llosm4bVTSdWCsxNnx4xiW69BA5WqfHGlRfEMbMmlPEp+nO8jvHniW9+11sWAQus1OzNC1Kt4ZmF+NlmiN+LKl2VwCtbfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579994; c=relaxed/simple;
	bh=B61tA63KbpXfZktTbcuBLB4bpYvnBjHJDASbK+sOtAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDJ01rMQaVv/qH1off+58JL8ZC8qnk9niw0FSc7Cfh3klJpThD9By0GzPFC5gK13eScD1W4U1rMHADZy0iYO8k+YmVZkk5uwXEjyI/AtdpFfdg6chDyXj0xRaF32VSCZSUqyd500/pZhjOlfcxo+Nujlk7iHexcsaEOpGF6sXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5rcPLyF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KvP6XaFR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 11:33:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717579991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B61tA63KbpXfZktTbcuBLB4bpYvnBjHJDASbK+sOtAo=;
	b=m5rcPLyFK0070UTaCOcQIeOSHyH+3FFROc89Mo+vVFznBW0r/574OQG0JH7oL5KHjZ8kTN
	AolGrI+GtVvBWC5UisJUDigLCfRLJupOEnn4p7RhBoTPNSU9V88NjTqRKTq7gRGaYCieK6
	gP2CdkUzEkvsfhRjp0alXbi9QTVFtRQ04BpjfuPDHaqBvez0wFC9ovSpLuuSgVGopbpVvl
	JDQPPR+ZEkzLEsg2+X1cxs18S7XnxicvS1SuD24zDPZJMMBM+8HO/rC3TOdUdH22jK3a1l
	5NJwJBQYwCXlsJtQSvOYFtJvKkd3PmK02TtymLJqNpPjuLr53LTH994atfEt9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717579991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B61tA63KbpXfZktTbcuBLB4bpYvnBjHJDASbK+sOtAo=;
	b=KvP6XaFRDHV5L8VP9gdw+5QgKXaUmZlobZut5gMGifYgnuzjQDAHRrXBWXUpb66CGKD0Z9
	ypPcnox7X8UvKUAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 0/2] Clean up usage of rt_task()
Message-ID: <20240605093310.tQbD0ywa@linutronix.de>
References: <20240604144228.1356121-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604144228.1356121-1-qyousef@layalina.io>

On 2024-06-04 15:42:26 [+0100], Qais Yousef wrote:
> Make rt_task() return true only for RT class and add new realtime_task() to
> return true for RT and DL classes to avoid some confusion the old API can
> cause.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

