Return-Path: <linux-fsdevel+bounces-20265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B08D0977
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE91C219B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCC15EFCC;
	Mon, 27 May 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="0DJ+9IAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DC15E5C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831428; cv=none; b=gOigZ4XTMJgB+iY9OtXJcqddCiHz0m3gOdL4VLIs+Pth5lK8VAlZxXsPFSZjYJ52Kv/GbwrBAhtgoUpuaT9ItdYR9EWQSrvSouIqVhKltZMsZRql1ImbgXcl8jB92eH6hrswaXeCsxlzbbLnGo5yFSNVnqN8BtF3cjYOQSVhba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831428; c=relaxed/simple;
	bh=XI6erCDnrp+edCzPtCdt2hp9LgvvOZnP83lVYPYHph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaffY4vLWMKaGlxkaXbw7WJ7F4KcnXLtfbpA0UjkeAhtuiRbpRjB1tp6bBk0/Pwz/EuOWPddljXcLLxI3SnXtqApYyAzbHkzs4+iFIWnSoKlQ8lFLZiCT+aTPenXDDzgBDr7cgoH33bOJ6ShONp3fuIvLcxFeosi/Kd5TUt7sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=0DJ+9IAz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-351d309bbecso8582628f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716831425; x=1717436225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=0DJ+9IAzti2vugVYkKwZ+eJC/QJQBMTuE7BzanFIcrz86+S5rgwcYc8wUbHu0tc+0O
         wu0RYLQ4IUbKGdQy4+7VB+HtKxXkyj4RySCqJeCgRtr5lxhTp4bCuKsOCmCSXE0tIk10
         mYcf15pN735Pa1t4/yj0Y0eOEPI6ukHH89/wyS2VTveRXolA8FB3PGrQIhebf9Go57Bm
         6kgE9d2JEEUIEUA40Z8lNoXKByAbkbfnWYgqWYyM6g07H/desKIaXhyFOtjanSVomrx6
         pVG4OC4XizNAzfhFHSLmJs/KCIDU+nl6Kno0jQTwWvecS6yiqGk2vscEPjxkgURFCwO7
         +xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831425; x=1717436225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=vBomDbfZWa8WQ62KByIxVuBwZuLK3GC+cDF0TivShov97F9CK9mkpHp9bVb/pjgPRt
         7Dy+xbk1hlNXrOeDH7Rk+Zkk/xa8jCJK7vqjc2x808aOJKOycVVAcuKmJA7DrwAN1CAe
         9NWjvVEsqiTQlMbAU0imPGDyoaFh547uIOBvro2wneScUY53AkruavblB4x+wHHkm/KR
         A9Mo8xOr5lDH7dW8XHxnWzmAKQKAYdEp6jKJEe0uBapSphC7n36BBvdq6x0jjlh1gBf9
         2vAVWXLuyHIjmnx3+8vr8PgZsxP6ZISRtXsZj8jL99sZWLAIhchJK64yNpGX+XYQIceq
         9qXw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMzjYaUiczHCw3bgjk7eyKI7XWMyAvz4KZXugIv+Otf+GHPOBrfjFBKcQs6EYNBL3fNJuIzxivjlhtUWTrE3E6ZFHyYC96sB/3TkwBw==
X-Gm-Message-State: AOJu0YyJAVZ8kbM3R862FU4uTX+Y9j15bFfoYyv0gp+rO5dnElTsbfK+
	WPHLQRyzVU1m+CXJiT7GTC2iCIk4lYvFb+qOuYzrFBSJwRjOl6y+BSMHHIW51NM=
X-Google-Smtp-Source: AGHT+IFHCdjZfBLADJgWvonL4PKkMzOE4//76Gn2zYKCwqPkEaCY0W71oc+vzFaisXznPhCsroiviQ==
X-Received: by 2002:a05:6000:1001:b0:354:db70:3815 with SMTP id ffacd0b85a97d-355270567abmr9685956f8f.7.1716831425563;
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9530sm9512807f8f.81.2024.05.27.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Date: Mon, 27 May 2024 18:37:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240527173703.52wsstp5dnczaxrv@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240523114540.2856c109@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523114540.2856c109@gandalf.local.home>

On 05/23/24 11:45, Steven Rostedt wrote:
> On Wed, 15 May 2024 23:05:36 +0100
> Qais Yousef <qyousef@layalina.io> wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index df3aca89d4f5..5cb88b748ad6 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,8 +10,6 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -#define MAX_DL_PRIO		0
> > -
> >  static inline int dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> > @@ -19,6 +17,10 @@ static inline int dl_prio(int prio)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to DL class. PI-boosted
> > + * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int dl_task(struct task_struct *p)
> >  {
> >  	return dl_prio(p->prio);
> > diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> > index ab83d85e1183..6ab43b4f72f9 100644
> > --- a/include/linux/sched/prio.h
> > +++ b/include/linux/sched/prio.h
> > @@ -14,6 +14,7 @@
> >   */
> >  
> >  #define MAX_RT_PRIO		100
> > +#define MAX_DL_PRIO		0
> >  
> >  #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
> >  #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
> > diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> > index b2b9e6eb9683..a055dd68a77c 100644
> > --- a/include/linux/sched/rt.h
> > +++ b/include/linux/sched/rt.h
> > @@ -7,18 +7,43 @@
> >  struct task_struct;
> >  
> >  static inline int rt_prio(int prio)
> > +{
> > +	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static inline int realtime_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_RT_PRIO))
> >  		return 1;
> >  	return 0;
> >  }
> 
> I'm thinking we should change the above to bool (separate patch), as
> returning an int may give one the impression that it returns the actual
> priority number. Having it return bool will clear that up.
> 
> In fact, if we are touching theses functions, might as well change all of
> them to bool when returning true/false. Just to make it easier to
> understand what they are doing.

I can add a patch on top, sure.

> 
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to RT class. PI-boosted
> > + * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int rt_task(struct task_struct *p)
> >  {
> >  	return rt_prio(p->prio);
> >  }
> >  
> > -static inline bool task_is_realtime(struct task_struct *tsk)
> > +/*
> > + * Returns true if a task has a priority that belongs to RT or DL classes.
> > + * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
> > + * PI-boosted tasks.
> > + */
> > +static inline int realtime_task(struct task_struct *p)
> > +{
> > +	return realtime_prio(p->prio);
> > +}
> > +
> > +/*
> > + * Returns true if a task has a policy that belongs to RT or DL classes.
> > + * PI-boosted tasks will return false.
> > + */
> > +static inline bool realtime_task_policy(struct task_struct *tsk)
> >  {
> >  	int policy = tsk->policy;
> >  
> 
> 
> 
> > diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> > index 0469a04a355f..19d737742e29 100644
> > --- a/kernel/trace/trace_sched_wakeup.c
> > +++ b/kernel/trace/trace_sched_wakeup.c
> > @@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
> >  	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
> >  	 */
> >  	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
> > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > +	    (wakeup_rt && !realtime_task(p)) ||
> >  	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
> >  		return;
> >  
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

--
Qais Yousef

> 
> 

