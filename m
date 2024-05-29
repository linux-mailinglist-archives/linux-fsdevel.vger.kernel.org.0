Return-Path: <linux-fsdevel+bounces-20427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52B8D34F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11512B23D86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684E17BB06;
	Wed, 29 May 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIiPydyI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWMmKXMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31021383A5;
	Wed, 29 May 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980134; cv=none; b=QD3/n8ugl0SioMPAnfrNFbLbFLI/raL7IrQmJL3pSBPNQl+rTpjIzYmT/wSvNvO5vW1BthMMqCLqByqDKMESKfMXZWnkJ31r/YyHn0kL9R18qLjUQyyQrtAuqwkHavluqn1x8VvKHWcJexAD4AiHUWo+oH3QPYqk9Fh/qhbUdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980134; c=relaxed/simple;
	bh=mAikLLuh69xtKMVd3whtMNnLuRnE3TGMOm2WH1S+BsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpfPFyTc3LxSTFkd/u2rkqocG9k3XqRVYKAySP7HCyEIh8NfwB4C+6E47zs88RVZoBKLnyQ3uvI1LnyQdnZF+xRMwipQCRevx+JLWYWanahYQEsXdHiyfl+WIsFt+fTWofzi6ZTkyS00GM2rHEd23sBw+KuIjjCvGjQC2b34Tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIiPydyI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWMmKXMo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 12:55:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716980130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA4MurLmU5SxwWcecswp4Ycsr4tLHf95RZmBe+KV4Os=;
	b=LIiPydyIabQcexxpMGlHDwk+xDOwD49YeVE2z3EFDkv4NOkGQWKrRMz/w0qwCEIgoia2TC
	Sj9iBqTx3uyhhHcZ81eGCrVLWNAX1fyEcOPvglWi30UXBO7kNnE3O5UmGQOpY9CCIZz4SL
	FrY4p9p08wpyliiYpKWf5vjQvjBglWco7ewffQ/HYuwMf/Z+jXBELPB7oRMarMSld5OVjM
	U0XQFWNmM4yXgKIPQab2vssaNZy1pxxnWWcYzwC8THlNIYQ62vPtwa1C7VWYdj0CfALXPk
	rogzb/UV4U7ehUWtgJi9Cmv0CcLnrH8mIRUuOGiENY1ybpmlhVnRYJ2nexXX1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716980130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA4MurLmU5SxwWcecswp4Ycsr4tLHf95RZmBe+KV4Os=;
	b=kWMmKXMouZlb+L2nNi1Gctnzl7Fmj8Wnd+alYWGuPzfsL8UgoSIOWdwof0ZhHtnnsOJBZ6
	138VYhyCmiD3z4AQ==
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
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240529105528.9QBTCqCr@linutronix.de>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529103409.3iiemroaavv5lh2p@airbuntu>

On 2024-05-29 11:34:09 [+0100], Qais Yousef wrote:
> > behaviour. But then it is insistent which matters only in the RT case.
> > Puh. Any sched folks regarding policy?
> 
> I am not sure I understood you here. Could you rephrase please?

Right now a SCHED_OTHER task boosted to a realtime priority gets
slack=0. In the !RT scenario everything is fine.
For RT the slack=0 also happens but the init of the timer looks at the
policy instead at the possible boosted priority and uses a different
clock attribute. This can lead to a delayed wake up (so avoiding the
slack does not solve the problem).

This is not consistent because IMHO the clock setup & slack should be
handled equally. So I am asking the sched folks for a policy and I am
leaning towards looking at task-policy in this case instead of prio
because you shouldn't do anything that can delay.

Sebastian

