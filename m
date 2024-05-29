Return-Path: <linux-fsdevel+bounces-20409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41D8D2E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39453289E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C616729D;
	Wed, 29 May 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkWAFrkW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18aBzXJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7E1E86E;
	Wed, 29 May 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968096; cv=none; b=qflAifSJRwp5aLaBbPuK53rNhd53eSFGwwP2G2BVo833ntWxqgRDKV9gG8Afc1Ff8pMIr6nTHgd4yJSQuB5IPqyVhBzynWFcHf6TQiYSGf3loADM3THuMrKH7VxbD9VEqXWUaTd2LOsn2vYF+sOZXMc3il1jJ046WP90MzP8gWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968096; c=relaxed/simple;
	bh=J3pSsWUPvYQZmX6tPmgdskzDWH8jsyiuRbZHnmaPwGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0Nf8NOf9saz8QGYlRdND3IlcWdbA2fZn9CYO4n8UAfwqoVgIDgte9MYKWWopYJOu/SVW446gwA6MIEZrYj7YjfF9GzVNpYit+YzewyZku3tm4li2T5H+EccOHDtczUaXFw4Wnq1eDvK6gHrVxSuuL1NxXC5w3riJCBNBl/wlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkWAFrkW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18aBzXJk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 09:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716968093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7mHIbpcdtYFJ1w3GFH1CGLaSQctBjceRPKxBiR4wnc=;
	b=DkWAFrkW5M0eSiId0W/ZyzPB1JiACgJRIL1zt7m8JNJToCpGV8MBJQ+jiLRYS2+KhHmLO4
	rhJAwxZz8u9XkmekBs+Aa/seNB9I4XvwLVy9l1BTX8V29jR+ibsPTFKxnTNbZ9+lyiX+IW
	Ayn1wBjwX0HjidnIaPTOp/DykOv2df/KpVInqAwPDqvS5SNqf0vc05B47vHt2JE/8jtCnY
	iflxRoxi8yc30HnEjz8DKOWeOIzHj9qvsApb4qh9IZ171mV/cE9xw3n5SEoFHHa6qbjwU0
	IwSxwEAQb3RMLTBQ+jWx9Z4DpzCkYH7O8/dBUs3gfBj2OGsd7+JdfiufrOQYlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716968093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7mHIbpcdtYFJ1w3GFH1CGLaSQctBjceRPKxBiR4wnc=;
	b=18aBzXJkU20fSjBtZe7CRO+mWR20Y2UL/579NdAL4djPY5KIoJsQOKxIEs0Wx08v7/NZ7K
	twlzQPpM1esmKvAw==
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
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Message-ID: <20240529073451.IIA7HXMj@linutronix.de>
References: <20240527234508.1062360-1-qyousef@layalina.io>
 <20240527234508.1062360-4-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527234508.1062360-4-qyousef@layalina.io>

On 2024-05-28 00:45:08 [+0100], Qais Yousef wrote:
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 5cb88b748ad6..87d2370dd3db 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -10,7 +10,7 @@
>  
>  #include <linux/sched.h>
>  
> -static inline int dl_prio(int prio)
> +static inline bool dl_prio(int prio)
>  {
>  	if (unlikely(prio < MAX_DL_PRIO))
>  		return 1;

if we return a bool we should return true/ false.

Sebastian

