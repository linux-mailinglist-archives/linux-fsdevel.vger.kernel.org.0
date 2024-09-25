Return-Path: <linux-fsdevel+bounces-30121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB898666E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842E3B2122C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FC13D2BE;
	Wed, 25 Sep 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUuYfd4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06B1369BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289524; cv=none; b=slz+CtoWcfj5Y5nORSvguH+c1shlppPD2e+sqe+QPXNRsIa8XQvREmm/PoSlbY3ESb5DsI9pPVJs6rO4xgLJmCrmGP0+wqTn3xxdxQZW0YaY6XHsQDUQPRZ7exawizVKlx9A2NqpAYirF6QjNRzWztzKjtkuwCgGG7aSjVQlB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289524; c=relaxed/simple;
	bh=JVKFkjhydaMKPc1PC4D+X35Li+Gx1GS1qnGbfKgICMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRXUPro/hcRR6eVbv8ILUR5r2R8jzN/d0Zj2Yc6UVA8/1K6DaYJv22TyaV8VdXx02v2vV14zQ1Uk7MOCprg/DFQkHEJBU0lIJkgqT3Te5vrphIv/rOEdZUB8voWy9z0jTVT43fzznMYAdskEiJtS8ZNwCK1puQk5x2ROWK3+mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUuYfd4j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-207349fa3d7so27255ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727289522; x=1727894322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAwUsCBYvsBvH+rTIy3VTYfawJRtH/z/DBLYTwRvoDQ=;
        b=JUuYfd4jouTYaTk8H61tI7YWNjcw6/0+ziwCnPDbXHFSx505nAJ0ZnBmfPeqLhKY3E
         r1Zj3477byu1zCjpWXsRyFtROoBOAkh1x6/PbkjZGIVPH4+fOZr91bfTb/OQhV4IzykJ
         LKyY2I+NJw3EMBSWppUYMyY9Qfcx72lt7gtu12a8NPRgUULqvqgRB5xHhfhpCJezqeY+
         kUNTouElAYzsy4Y+DQj04aVnX1sReVmuVqRViI4GE7o4WJziQN4P43petuHkwu9VNiku
         PVqdk9y7mKYccUVNPQe65u4F6OrlIhdG28Nambb4kNYtLnmHO81JIKDgRI0hhM4hkYKJ
         Dn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289522; x=1727894322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAwUsCBYvsBvH+rTIy3VTYfawJRtH/z/DBLYTwRvoDQ=;
        b=R25DAJA7SsLCm9KwG3UJf5ucmNhQ4QG87aEGqWs7i0HAWV7s19tSNG1ZjntfwkA80G
         eSZpuGPOSyg1iXTr/N3ETMXqOqLcX8Dzrcm/o3CXmtd0fIvNjv2TGq00aI/9w94lutJF
         n89AglzrV5CBTQLtP7SrLM4cLoXVEAyRgYId1o6/nfEfNe1Gf/UwAYUqyBRvMOfJ93yK
         Ce4ye4p5ytyNcWcLNDwZhE748WXwi4oBmIdGdhOJVsNZJ6gqn5S5UUtzJHSPVjmJPMuQ
         KvKvGigwLm6IhBb4oO+F0jsf4GISLiy1sYFRoHAwsz4jS/+/Zeze44jfaxDIhPai5blQ
         +l/w==
X-Forwarded-Encrypted: i=1; AJvYcCW9ozyDQqmIrBSL4bmPgPgEYYxddO7+fLONrSCK2w8+b734czyhmcLAD1E0Nk3TzPU17w4n+lOnwVkH/m4T@vger.kernel.org
X-Gm-Message-State: AOJu0YwItMwTbPZETKaRFp1LxcWa7X7WQ4Dk5NVJ1W7+dh6ePWwqTDkB
	4bmvr6KS1FatugvBw2zvnZMU6DOBI2XSfqlk7URRzMAVSqvf5cU/cMWOGv1nKpPTIRNKNBqzG0W
	826p0mVdgpONRWtq9ebvCvaHuVDZOc3tRhaSd
X-Google-Smtp-Source: AGHT+IEcXCpXotrQE81fnFVdze99a4YZ0Ycn4Rt6hsoKJd9DK86/HBv/Sjnn9Ah1hFKZoWzawUrE9yU6tudDQWMYb1c=
X-Received: by 2002:a17:902:e743:b0:207:14a8:734e with SMTP id
 d9443c01a7336-20b1b35c79cmr326965ad.6.1727289521611; Wed, 25 Sep 2024
 11:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner> <20240919123635.2472105-1-bgeffon@google.com>
In-Reply-To: <20240919123635.2472105-1-bgeffon@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 25 Sep 2024 14:38:02 -0400
Message-ID: <CADyq12w2KRUZCu0hLA8TJH-e+766Jq_vG9SDYtDBYXzR=r9wvg@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: brauner@kernel.org
Cc: bristot@redhat.com, bsegall@google.com, cmllamas@google.com, 
	dietmar.eggemann@arm.com, ebiggers@kernel.org, jack@suse.cz, 
	jing.xia@unisoc.com, juri.lelli@redhat.com, ke.wang@unisoc.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	xuewen.yan94@gmail.com, xuewen.yan@unisoc.com, Benoit Lize <lizeb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this patch really needs help with the commit message, something lik=
e:

wait_queue_func_t accepts 4 arguments (struct wait_queue_entry
*wq_entry, unsigned mode, int flags, void *key);

In the case of poll and select the wait queue function is pollwake in
fs/select.c, this wake function passes
the third argument flags as the sync parameter to the
default_wake_function defined in kernel/sched/core.c. This
argument is passed along to try_to_wake_up which continues to pass
down the wake flags to select_task_rq and finally
in the case of CFS select_task_rq_fair. In select_task_rq_fair the
sync flag is passed down to the wake_affine_* functions
in kernel/sched/fair.c which accept and honor the sync flag.

Epoll however when reciving the WF_SYNC flag completely drops it on
the floor, the wakeup function used
by epoll is defined in fs/eventpoll.c, ep_poll_callback. This callback
receives a sync flag just like pollwake;
however, it never does anything with it. Ultimately it wakes up the
waiting task directly using wake_up.

This shows that there seems to be a divergence between poll/select and
epoll regarding honoring sync wakeups.

I have tested this patch through self tests and numerous runs of the
perf benchmarks for epoll. All tests past and
I did not see any observable performance changes in epoll_wait.

Reviewed-by: Brian Geffon <bgeffon@google.com>
Tested-by: Brian Geffon <bgeffon@google.com>
Reported-by: Benoit Lize <lizeb@google.com>


On Thu, Sep 19, 2024 at 8:36=E2=80=AFAM Brian Geffon <bgeffon@google.com> w=
rote:
>
> We've also observed this issue on ChromeOS, it seems like it might long-s=
tanding epoll bug as it diverges from the behavior of poll. Any chance a ma=
intainer can take a look?
>
> Thanks
> Brian
>
> On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> > Now, the epoll only use wake_up() interface to wake up task.
> > However, sometimes, there are epoll users which want to use
> > the synchronous wakeup flag to hint the scheduler, such as
> > Android binder driver.
> > So add a wake_up_sync() define, and use the wake_up_sync()
> > when the sync is true in ep_poll_callback().
> >
> > Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  fs/eventpoll.c       | 5 ++++-
> >  include/linux/wait.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 882b89edc52a..9b815e0a1ac5 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *=
wait, unsigned mode, int sync, v
> >                               break;
> >                       }
> >               }
> > -             wake_up(&ep->wq);
> > +             if (sync)
> > +                     wake_up_sync(&ep->wq);
> > +             else
> > +                     wake_up(&ep->wq);
> >       }
> >       if (waitqueue_active(&ep->poll_wait))
> >               pwake++;
> > diff --git a/include/linux/wait.h b/include/linux/wait.h
> > index 8aa3372f21a0..2b322a9b88a2 100644
> > --- a/include/linux/wait.h
> > +++ b/include/linux/wait.h
> > @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_=
head);
> >  #define wake_up_all(x)                       __wake_up(x, TASK_NORMAL,=
 0, NULL)
> >  #define wake_up_locked(x)            __wake_up_locked((x), TASK_NORMAL=
, 1)
> >  #define wake_up_all_locked(x)                __wake_up_locked((x), TAS=
K_NORMAL, 0)
> > +#define wake_up_sync(x)                      __wake_up_sync(x, TASK_NO=
RMAL)
> >
> >  #define wake_up_interruptible(x)     __wake_up(x, TASK_INTERRUPTIBLE, =
1, NULL)
> >  #define wake_up_interruptible_nr(x, nr)      __wake_up(x, TASK_INTERRU=
PTIBLE, nr, NULL)
> > --
> > 2.25.1
> >
>

