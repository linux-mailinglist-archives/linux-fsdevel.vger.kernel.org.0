Return-Path: <linux-fsdevel+bounces-55409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE9B09E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DC9A800DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA02949F4;
	Fri, 18 Jul 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqz89RGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E201E1A3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827949; cv=none; b=Z3bkofCXU507aiHwzI09HKJk3pRMbhzycxzjcQ/Fw61rvrdly3LndHuoyPS5SZkbjUWVpb1mlTy1+J/JWzf3AB9ZYeNk0ezp57rtvj0uluuy/tv8HKrE58jxzyMWlTA6Hg9ScW1O6tieUiK/TwpXGtMqwW1EJwWc9uXmQNXfFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827949; c=relaxed/simple;
	bh=HV3mPl6MSYbW9XmYhqL0JUwYQluuDEhKVGZbLd7tbSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkTjknhoNd8cZFRaPpVZhXsDrcXeYUGs8AF5IQQMwvNN0V/ktW+FGcmAds/fmVjZ7i6WCDmJW00dumv8biSHXy7Q4usBTe7Zd71SrquxmtuuU6wygoRQoChudJCldKXBGbDXSdclhiWKzTmkssRRXcXL9bu6WweTh2t0518mzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hqz89RGu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso113491cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752827945; x=1753432745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udrYzqsG6zKD6Rhq5jUrYPXE4BiEAdJOTycG7GhLQII=;
        b=Hqz89RGuZzHtgoSGE0C2o/r7a2QPvNrH6QeHhYgAoP0xAud5ybplO1qSUCxNLBalwQ
         pg8E+JD4/inzjLF2C/sRb6U1b/ddTXvrc93Lw5x1E8eDdOXb06wFdLtdIlq/W9yLUJos
         On4JrQVSwo+kOmPrygJSvfCTmpRIE2u989OVoR51KICPlJ7qFHjHL5mHbIDFpmOMcRBN
         iVJMDp4uzg9rQoFNoILxflbqh2y1mq4/RLnphtiu+24tNYVvJhObmzPXRO7cMJR2aP/R
         mSx9IY/m3LBl95Si9EGoU/YfV/SjPPTC1VZ+P1nztduAgqfMJ+31NccE2K/JraxGsvnN
         0UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827945; x=1753432745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udrYzqsG6zKD6Rhq5jUrYPXE4BiEAdJOTycG7GhLQII=;
        b=gxGPoozB+mPOeDiC7AHyIm7G2OFg1UahDuOxeJTJCq1owlqSKP/QInLKPShAcbF9iF
         nyai2xewzKzMCbQdgoqbalLLVbJ+wzISzKdzxSyJ0J8iRPc9DpmXQtm9WvZAx5W+WI8F
         rB+wwOsLCZzSeuDy5kL/sphqHEDS8HU3kbN8gI2aYkSjn8+W1BjgTvrgGyEkec+lf5V6
         rzDjske+88ITe69Yh+kZ2JnphQR3N3E3d6VySZwKo9KNCs5dvtPbON7M05qh2Aa/3HNF
         ylVfjLZur39VbYipu/obbt/6q+lgnhXUrJXYBcjUW/P59q0RNyn7E5VRw8/KlOj19OXa
         H1SA==
X-Forwarded-Encrypted: i=1; AJvYcCXYxynmejhv+j4L41OI25owxXVnn4/ncRYMVPtJvSlzxNfCnJRKSjGc9c5CZKPrFMc+kDAge6gCnb9QJiLM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DGgkVv8eKydG334TxB/nVpPOEK6vZZVNyw0P5fnVoNWe7FIa
	qECf89j8waTKm4ryWSAFKHmEe0llmMaQbFy1GcJbeESSRamJsW+pE7AOLDQoQohHJfFMGrbDp21
	Egjz2+goKx6GrOsA91whZSW80ZdBeOAkEvVyCax8/
X-Gm-Gg: ASbGncvXWY4PufSk3Lk+rVGjAQ3dJIi74ui/7C15tnmZ0AfGAU2iZMO+PI/Hrddf7qK
	ayMBkj+LcJ669sroj7Q4A1AU9MilRN9ySeZ9TQaRHGgYPDz3PbdfnDCDUpz5rmg5s4Eb75UrYxm
	XeVGpFrB3NfoaP2wgtYQMYAWQkHe/reVfgSjMXfomaktLk7IYElx+SNzvejlPDynfVjONrKETfo
	ZuXtivXrvc8XQi1gqZvRmpuXw7gIFRarqj2ZQ==
X-Google-Smtp-Source: AGHT+IFZWhzx20M9Gw8trywQy21X6aj6Ujnf+GXyOsXwiCt5Tl0RmCoH6sEvHzscHL3TaCOr5PVWkjpGBEYykqUGK0g=
X-Received: by 2002:a05:622a:4a87:b0:4a8:19d5:e9bb with SMTP id
 d75a77b69052e-4abb13dfdf4mr4200641cf.13.1752827944683; Fri, 18 Jul 2025
 01:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
In-Reply-To: <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 18 Jul 2025 09:38:27 +0100
X-Gm-Features: Ac12FXzgn06jDeUNMyDy69uNTY69aPVmkscuVzoPHZoBvxff8P-gX2NCfWFyWn0
Message-ID: <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Khazhismel Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 8:52=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> ep_events_available() checks for available events by looking at ep->rdlli=
st
> and ep->ovflist. However, this is done without a lock, therefore the
> returned value is not reliable. Because it is possible that both checks o=
n
> ep->rdllist and ep->ovflist are false while ep_start_scan() or
> ep_done_scan() is being executed on other CPUs, despite events are
> available.
>
> This bug can be observed by:
>
>   1. Create an eventpoll with at least one ready level-triggered event
>
>   2. Create multiple threads who do epoll_wait() with zero timeout. The
>      threads do not consume the events, therefore all epoll_wait() should
>      return at least one event.
>
> If one thread is executing ep_events_available() while another thread is
> executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrongly
> return no event for the former thread.

That is the whole point of epoll_wait with a zero timeout.  We would want t=
o
opportunistically poll without much overhead, which will have more
false positives.
A caller that calls with a zero timeout should retry later, and will
at some point
observe the event.

I'm not sure if we would want to add much more overheads, for higher precis=
ion.

Thanks,
Soheil

> This reproducer is implemented as TEST(epoll65) in
> tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
>
> Fix it by skipping ep_events_available(), just call ep_try_send_events()
> directly.
>
> epoll_sendevents() (io_uring) suffers the same problem, fix that as well.
>
> There is still ep_busy_loop() who uses ep_events_available() without lock=
,
> but it is probably okay (?) for busy-polling.
>
> Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait=
()")
> Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock for zero timeout"=
)
> Fixes: ae3a4f1fdc2c ("eventpoll: add epoll_sendevents() helper")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  fs/eventpoll.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 0fbf5dfedb24..541481eafc20 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2022,7 +2022,7 @@ static int ep_schedule_timeout(ktime_t *to)
>  static int ep_poll(struct eventpoll *ep, struct epoll_event __user *even=
ts,
>                    int maxevents, struct timespec64 *timeout)
>  {
> -       int res, eavail, timed_out =3D 0;
> +       int res, eavail =3D 1, timed_out =3D 0;
>         u64 slack =3D 0;
>         wait_queue_entry_t wait;
>         ktime_t expires, *to =3D NULL;
> @@ -2041,16 +2041,6 @@ static int ep_poll(struct eventpoll *ep, struct ep=
oll_event __user *events,
>                 timed_out =3D 1;
>         }
>
> -       /*
> -        * This call is racy: We may or may not see events that are being=
 added
> -        * to the ready list under the lock (e.g., in IRQ callbacks). For=
 cases
> -        * with a non-zero timeout, this thread will check the ready list=
 under
> -        * lock and will add to the wait queue.  For cases with a zero
> -        * timeout, the user by definition should not care and will have =
to
> -        * recheck again.
> -        */
> -       eavail =3D ep_events_available(ep);
> -
>         while (1) {
>                 if (eavail) {
>                         res =3D ep_try_send_events(ep, events, maxevents)=
;
> @@ -2496,9 +2486,7 @@ int epoll_sendevents(struct file *file, struct epol=
l_event __user *events,
>          * Racy call, but that's ok - it should get retried based on
>          * poll readiness anyway.
>          */
> -       if (ep_events_available(ep))
> -               return ep_try_send_events(ep, events, maxevents);
> -       return 0;
> +       return ep_try_send_events(ep, events, maxevents);
>  }
>
>  /*
> --
> 2.39.5
>

