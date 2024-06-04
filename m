Return-Path: <linux-fsdevel+bounces-20948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02588FB221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FB5282E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CE1465A0;
	Tue,  4 Jun 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qzuNcmwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE7146595
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503998; cv=none; b=VSiebo2bDrysZEwerOlur20+O330dR1SYIAkP/w1H2jJ5sBlPggR/Jybad9IvC8MMvU+xHcxjQPnhQhYs1E4DfO8sbJLJpD/G0rfoEjolVVRlBmHxPIvXOtuBDaA3sB6RQv7sVGC1EtgL7mEm5bB3YiQxyE9Zl1AHbvK7gNSg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503998; c=relaxed/simple;
	bh=cabTH94ZxbKOLC3KQ/kbjnDdCSgt2Vtz1izEnaneciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFwfj+PI/wKQamOybFETcf6wVZQP0+IaHi1xOfPWvUB6ZNoHH6q18So/bmhrAkzAwFwqAQctpkOexBzRMCEV6mjdh2m2YBm/Gb64IfPyaTLD7/imUR9q6jLrAkOl0gb5YgQyOTMgTMABciCrhTxUO/fzxCWOlkCnhCByZvQfASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=qzuNcmwJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42133f8432aso22852135e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717503995; x=1718108795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wirbdRLWKxynbDeQYlgqnwEHsv5grhz29Os93lpSf5Q=;
        b=qzuNcmwJLGPH6XM+aSU9Y5AAM9lD3lt9XSu74FDoWLURZ8hjaS2g5PC2B2iElCDkqX
         xtWTcQ48nQWmQQ/LCSdka+/oXzMfEepkzuqLGGvMY+8XbVzBWK1voccYgpki5xIk6iCh
         xs+uKrS6fGQRfUzX9GoH/ipmiHUmgduQLFWc7KyQZCnD05olUQnNaVlDi86qUYh87LCX
         3rydthL6AGxOnSnsI/EgZrOhuKsVZ2vGL22AtopKWHRWcKEBeERNivSKn6b4UWPmlLS8
         O2Wx0CPgQvRgoNYJ79Je1NbrHJ8so70Umo7v8udMrraXJYqcMo85nXaPlbjBbwD99q9f
         3yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503995; x=1718108795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wirbdRLWKxynbDeQYlgqnwEHsv5grhz29Os93lpSf5Q=;
        b=w4p1oAUoYoEZqDCe5Cj7QYJtcdwAmsW310pHmMeD4nASURCh2BuSyHReuUrYC8Nxrh
         58/sbPz+Yy/im6aQ+rrCzmyFkdb4cCtXaLuy/THIt6Rnd0OMYaFweI1/f/y7wC6J+nZ6
         hC1nh76qjTcvG35zJHNjTD0TF0qqZF0YjDknSjLxXuf0LZEKHUDgW9jarPHiQb3m9GmE
         p88r15cNDtiaq1YA4JMoft4CJw/Y4r6VLzDGNhBHj6bfRAHYCemPm0BCOkGM0VTnzzHb
         HG4jCg7EWjoYVun9144xN9CQyp1Gf5tfGbF0G/sh1hiiwJ5Kze/iMuaoXUiKI2a3Gy5Y
         9vtw==
X-Forwarded-Encrypted: i=1; AJvYcCXOxfmHO9+OxYlryHHQtl6zXJuEYvd0AlAeO4xQtTQwbUMlClo43LeGRb5C1L8NTFV5i9wfW5ExDlTGq7CE0S9dpU3W2eYEsS+f6Kqk0w==
X-Gm-Message-State: AOJu0YxxOgf6c7f96Y+Efpcr6U4mbYfgYcXN/S4esqcuEKCqewA6tArU
	7LGZs3lWwC1lJJvcTiL84eVUnzBzpPDaqwlPJ10qdTRLKyEkNggDB4HoDDY1Kvg=
X-Google-Smtp-Source: AGHT+IGIZgGSS/PWE54q5X7JbJs712JoGI7T0PbD52fooF8vEqAkQLTKVUVAxk3tEHmCbhFHMtXxaw==
X-Received: by 2002:a05:600c:350b:b0:421:5329:20b with SMTP id 5b1f17b1804b1-421532906b0mr9899205e9.33.1717503995116;
        Tue, 04 Jun 2024 05:26:35 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42132d5308csm137660745e9.35.2024.06.04.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:26:34 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:26:33 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Metin Kaya <metin.kaya@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 2/2] sched/rt, dl: Convert functions to return bool
Message-ID: <20240604122633.ais2zq6kytfcvj6a@airbuntu>
References: <20240601213309.1262206-1-qyousef@layalina.io>
 <20240601213309.1262206-3-qyousef@layalina.io>
 <417b39d1-8de8-4234-92dc-f1ef5fd95da7@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <417b39d1-8de8-4234-92dc-f1ef5fd95da7@arm.com>

On 06/03/24 08:33, Metin Kaya wrote:
> On 01/06/2024 10:33 pm, Qais Yousef wrote:
> > {rt, realtime, dl}_{task, prio}() functions return value is actually
> > a bool.  Convert their return type to reflect that.
> > 
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >   include/linux/sched/deadline.h |  8 ++++----
> >   include/linux/sched/rt.h       | 16 ++++++++--------
> >   2 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 5cb88b748ad6..f2053f46f1d5 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,18 +10,18 @@
> >   #include <linux/sched.h>
> > -static inline int dl_prio(int prio)
> > +static inline bool dl_prio(int prio)
> >   {
> >   	if (unlikely(prio < MAX_DL_PRIO))
> > -		return 1;
> > -	return 0;
> > +		return true;
> > +	return false;
> 
> Nit: `return unlikely(prio < MAX_DL_PRIO)` would be simpler.
> The same can be applied to rt_prio() and realtime_prio(). This would make
> {dl, rt, realtime}_task() single-liner. Maybe further simplification can be
> done.

Fair. Thanks.

> 
> >   }
> >   /*
> >    * Returns true if a task has a priority that belongs to DL class. PI-boosted
> >    * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
> >    */
> > -static inline int dl_task(struct task_struct *p)
> > +static inline bool dl_task(struct task_struct *p)
> >   {
> >   	return dl_prio(p->prio);
> >   }
> > diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> > index a055dd68a77c..efbdd2e57765 100644
> > --- a/include/linux/sched/rt.h
> > +++ b/include/linux/sched/rt.h
> > @@ -6,25 +6,25 @@
> >   struct task_struct;
> > -static inline int rt_prio(int prio)
> > +static inline bool rt_prio(int prio)
> >   {
> >   	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> > -		return 1;
> > -	return 0;
> > +		return true;
> > +	return false;
> >   }
> > -static inline int realtime_prio(int prio)
> > +static inline bool realtime_prio(int prio)
> >   {
> >   	if (unlikely(prio < MAX_RT_PRIO))
> > -		return 1;
> > -	return 0;
> > +		return true;
> > +	return false;
> >   }
> >   /*
> >    * Returns true if a task has a priority that belongs to RT class. PI-boosted
> >    * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
> >    */
> > -static inline int rt_task(struct task_struct *p)
> > +static inline bool rt_task(struct task_struct *p)
> >   {
> >   	return rt_prio(p->prio);
> >   }
> > @@ -34,7 +34,7 @@ static inline int rt_task(struct task_struct *p)
> >    * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
> >    * PI-boosted tasks.
> >    */
> > -static inline int realtime_task(struct task_struct *p)
> > +static inline bool realtime_task(struct task_struct *p)
> >   {
> >   	return realtime_prio(p->prio);
> >   }
> 

