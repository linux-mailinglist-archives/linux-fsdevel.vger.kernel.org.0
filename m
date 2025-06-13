Return-Path: <linux-fsdevel+bounces-51577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85999AD8781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49727166715
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE0279DB1;
	Fri, 13 Jun 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EnXMlNk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9D256C73;
	Fri, 13 Jun 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806243; cv=none; b=INwlK6vLXehEm/TtHCwsjee3jmeA2ggJc0p6zomidhtvZA/W68GSxjUolVAN1wIeUVcvmbtQ2dG8e5VWyPiZhTay8YmM5jM4O+Ul/trUocrWlJsaOCHs+I0YN6A22UZnpqEDgvZPqvGhVkeXCIg0ZCwXaxXOqW9L0YJf+kpAtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806243; c=relaxed/simple;
	bh=F4rJ5BwcN0RB0dXEazhieLwPneVhkmrr00PMJvRARk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnfhDl7WFKQ7MwXcDWYpGPBtykRFSDAbNl/RBW33VC07j9VvkzWEGrl94ERUgDbgihG0GARghO/aZj1Drg4th6GqIWAqY27YPvnfRS4nBmIZ/mkVKrTfsbX937MxikOOdeKtDlLwC4MUj0HE4Xa7tPLJITa2+8iySwyeZYx3CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EnXMlNk/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aASqYL+WWuxJmDxdPdt+F1d81lP+5hpDbC2pdF/86eE=; b=EnXMlNk/zSmE/OIDI6rMYHXNgV
	VedHrx2OpJBjW0AqK3F9lBqvhpUR4g6YskJB6tA6tO72jrWS9FrF/YzaKMWbyo6VdcHoqE8wk6dJ8
	+vImWLMvJf5OU78k98Jb3t2VK1QOJDRvCUNvFdccZBAk6UOZPAR6NDWBDiHOziKbuOU8WtGKidrTD
	CrWyUUjXmPS6+6h15nO1NaWlc7mOotj0HAWCLt4POU5A/Q7TCyLtb73aXCZhoxi4LZ5M0+fNp7MUP
	qHFATGld5+McsDvcPhkZpBxtDviaB7zo1bz9DomoqkYAe5FTytnZSeIrwpkSX1vCHuneW4u/7lIZN
	0Asw2Xbw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ0XD-00000002xCO-1RDO;
	Fri, 13 Jun 2025 09:17:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 369073011E4; Fri, 13 Jun 2025 11:17:13 +0200 (CEST)
Date: Fri, 13 Jun 2025 11:17:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Tomasz Figa <tfiga@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] sched/wait: Add wait_event_state_exclusive()
Message-ID: <20250613091713.GD2278213@noisy.programming.kicks-ass.net>
References: <20250610045321.4030262-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610045321.4030262-1-senozhatsky@chromium.org>

On Tue, Jun 10, 2025 at 01:52:28PM +0900, Sergey Senozhatsky wrote:
> Allows exclusive waits with a custom @state.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> 
> v2: switched to wait_event_state_exclusive()
> 
>  include/linux/wait.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 327894f022cf..9ebb0d2e422a 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -968,6 +968,18 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
>  		      state, 0, timeout,					\
>  		      __ret = schedule_timeout(__ret))
>  
> +#define __wait_event_state_exclusive(wq, condition, state)			\
> +	___wait_event(wq, condition, state, 1, 0, schedule())
> +
> +#define wait_event_state_exclusive(wq, condition, state)			\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\
> +	if (!(condition))							\
> +		__ret = __wait_event_state_exclusive(wq, condition, state);	\
> +	__ret;									\
> +})
> +
>  #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
>  	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
>  		      TASK_KILLABLE, 0, timeout,				\
> -- 
> 2.50.0.rc1.591.g9c95f17f64-goog
> 

