Return-Path: <linux-fsdevel+bounces-47531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4635A9F630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEB716E7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C4281370;
	Mon, 28 Apr 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cx5PnLA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6F27FD63
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859009; cv=none; b=JeHLtQwOPl969HF0ft7Qk4MgVWWZniN39XPGsyX7q7V1z2yT1GptUs29aq/BPY78D8AEwjsHGLg227LkEJhSuiYu+B6ZvQ7hoML6OB2yUZN0Rp9isQVvXjoTpCSpPx6oHR3EWo+bIoMkDCBrqNtaH3Bz/IuLiS/Npjo8ly2MPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859009; c=relaxed/simple;
	bh=1pYUHNmmRhmffZ/oXj+QDXKvFyX8YH3f073PSotF/c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjUO7mjEdIzL8tw/TmDTgNTRqJoWz8ANANyZBX0DW69mQ51NHr+L9UCAq6sWvCQT8mOG8Gnyl6+r6gdAU6FQQxAfEtl2Sa6O6l9oniJgEdfsc+wbcl8rCQYp6jDkk3NGv97xKNlZdZ13HDUE0tz16W32rxIAT1tBhmpRFKOGUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cx5PnLA4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c3407a87aso75146925ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745859006; x=1746463806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8hjmFzsOPHOabsUErIWDP2Q0Dc1B9wUOOmnKrCLHDs=;
        b=cx5PnLA4nQ4H1hYujlmPLZeowamA+adiYp3Z15LrkYJ1rvx1QWaF4wewJKKxmUpG8c
         OIA2/VAUCpK7XdKIVdfBLhjkdd88V2JQJ8GIOBo62gVGZzjwLx5tU1K2947J7uGBSAie
         4x4yktv778R54sPnyvhNttWJ+xlUrgGqtYa0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745859006; x=1746463806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8hjmFzsOPHOabsUErIWDP2Q0Dc1B9wUOOmnKrCLHDs=;
        b=HklghvWHOTmX8og0LGhFIz37IGaqQFvw2DrNZj6PFegBXZSTydWnIFxJhNRjNZNJ6H
         n9V978b+2X+5oeQfR3qe5n2yTKoOL/4jCfFUYTCBWgt7N4KlUtetICoIvikPvMYdsYqM
         s78EZR5WhYZcaAfeE6JY2D0mRAbjUPzk9Mo3oNf5mqoXVv9f7DJI+CbXmcS7ivj6Y3q8
         fKS05tHdn8KzQHFpXfMk4UI4AA6pqL7XgBXnLqmSpzwBY5JE950ZNtXEaHobf/Z69PVN
         y6jW9iWn0CewPa0xq+HIrOuGtDbJDBFCdV/IF0cXYRgkh7dGrGfgjmKYwmZ9G+WB5B50
         wJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVIOiAZAF5AAHYCEB2+LHTn4PVqNxR0rCQjJHGj4+LV/21VyGJ3uMSQW1KZRo+dnZa3HQqoAjLdLNczksyP@vger.kernel.org
X-Gm-Message-State: AOJu0YxryqRKzoMQsbfLjVcQuMHSwKDuYzJ8f4brCx6oo2c294++WR+n
	Xl//aC8LyUEbjr4gp6ccwzbMyYhURneA848Jq1/feCKqdQGTAPy/rizrL8G5llE=
X-Gm-Gg: ASbGncv/BbIKHof2EyZKY+PXRRujiOBUqZyZXJUovgqbuGqrz8fojKKviBbcFxiYSW6
	ej9HvDNwMEDSYGFL8emHqTISAEx0KxWapNyWOaQl1wumeyOZbTnVf8mI61XWckw7bB97DxzG1QD
	f3bVkWQXPFRz25biW3uY+P6IKWXbY0k7S/CYNAwavtwePTztI4g1H9Y+knlKleeiZsMpFZPeMdW
	lVBWOihf9stq5Ro+JajMg8IHX7B8dsGWmc70D+0hVcHUmOKhbnf5NWU4gLIZQmIVUg0u2wc0qQp
	HaAWHa3feohYinj0czlBu9EoS+MVn3oUhUyKSEUmJXknwJq7PkxQx7O+aqWZv/DUuX5Muh2jto5
	x83nBNZTzcN2jjAaXdQ==
X-Google-Smtp-Source: AGHT+IHY3bokBHGJg2FzLyU1MQSqp3umpxucPs1Yju26bRC8o6rQvZzZFlDgWiTF1ZIeMvuMwyeRJQ==
X-Received: by 2002:a17:903:298e:b0:223:52fc:a15a with SMTP id d9443c01a7336-22de6058d25mr4907115ad.33.1745859005858;
        Mon, 28 Apr 2025 09:50:05 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm85222465ad.201.2025.04.28.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:50:04 -0700 (PDT)
Date: Mon, 28 Apr 2025 09:50:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <aA-xutxtw3jd00Bz@LQ3V64L9R2>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>

On Mon, Apr 28, 2025 at 02:14:45PM +0200, Jan Kara wrote:
> On Sat 26-04-25 14:29:15, Christian Brauner wrote:
> > On Wed, Apr 16, 2025 at 06:58:25PM +0000, Joe Damato wrote:
> > > Avoid an edge case where epoll_wait arms a timer and calls schedule()
> > > even if the timer will expire immediately.
> > > 
> > > For example: if the user has specified an epoll busy poll usecs which is
> > > equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
> > > unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
> > > consumed the entire timeout duration so it is unnecessary to induce
> > > scheduling latency by calling schedule() (via schedule_hrtimeout_range).
> > > 
> > > This can be measured using a simple bpftrace script:
> > > 
> > > tracepoint:sched:sched_switch
> > > / args->prev_pid == $1 /
> > > {
> > >   print(kstack());
> > >   print(ustack());
> > > }
> > > 
> > > Before this patch is applied:
> > > 
> > >   Testing an epoll_wait app with busy poll usecs set to 1000, and
> > >   epoll_wait timeout set to 1ms using the script above shows:
> > > 
> > >      __traceiter_sched_switch+69
> > >      __schedule+1495
> > >      schedule+32
> > >      schedule_hrtimeout_range+159
> > >      do_epoll_wait+1424
> > >      __x64_sys_epoll_wait+97
> > >      do_syscall_64+95
> > >      entry_SYSCALL_64_after_hwframe+118
> > > 
> > >      epoll_wait+82
> > > 
> > >   Which is unexpected; the busy poll usecs should have consumed the
> > >   entire timeout and there should be no reason to arm a timer.
> > > 
> > > After this patch is applied: the same test scenario does not generate a
> > > call to schedule() in the above edge case. If the busy poll usecs are
> > > reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
> > > armed as expected.
> > > 
> > > Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  v2: 
> > >    - No longer an RFC and rebased on vfs/vfs.fixes
> > >    - Added Jan's Reviewed-by
> > >    - Added Fixes tag
> > >    - No functional changes from the RFC
> > > 
> > >  rfcv1: https://lore.kernel.org/linux-fsdevel/20250415184346.39229-1-jdamato@fastly.com/
> > > 
> > >  fs/eventpoll.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 100376863a44..4bc264b854c4 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -1996,6 +1996,14 @@ static int ep_try_send_events(struct eventpoll *ep,
> > >  	return res;
> > >  }
> > >  
> > > +static int ep_schedule_timeout(ktime_t *to)
> > > +{
> > > +	if (to)
> > > +		return ktime_after(*to, ktime_get());
> > > +	else
> > > +		return 1;
> > > +}
> > > +
> > >  /**
> > >   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
> > >   *           event buffer.
> > > @@ -2103,7 +2111,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> > >  
> > >  		write_unlock_irq(&ep->lock);
> > >  
> > > -		if (!eavail)
> > > +		if (!eavail && ep_schedule_timeout(to))
> > >  			timed_out = !schedule_hrtimeout_range(to, slack,
> > >  							      HRTIMER_MODE_ABS);
> > 
> > Isn't this buggy? If @to is non-NULL and ep_schedule_timeout() returns
> > false you want to set timed_out to 1 to break the wait. Otherwise you
> > hang, no?
> 
> Yep, looks like that. Good spotting!

Thank you for spotting that and sorry for the trouble.

Christian / Jan what would be the correct way for me to deal with
this? Would it be to post a v3 (re-submitting the patch in its
entirety) or to post a new patch that fixes the original and lists
the commit sha from vfs.fixes with a Fixes tag ?

I was going to propose the following, which if I understand
correctly, should fix the issue Christian identified:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4bc264b854c4..1a5d1147f082 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,

                write_unlock_irq(&ep->lock);

-               if (!eavail && ep_schedule_timeout(to))
+               if (!ep_schedule_timeout(to))
+                       timed_out = 1;
+               else if (!eavail)
                        timed_out = !schedule_hrtimeout_range(to, slack,
                                                              HRTIMER_MODE_ABS);
                __set_current_state(TASK_RUNNING);

