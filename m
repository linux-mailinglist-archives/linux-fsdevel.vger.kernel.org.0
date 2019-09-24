Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4692EBC9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfIXOGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 10:06:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34637 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfIXOGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:06:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so2041990lja.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX5WmxWuYSr8VxjzZegQNHZ2LJD3f554QY+Bp7zkDPE=;
        b=Hx0p2HYidAd2vAhjqYOsgnLCNoABmYq3zDKpK7dKXKLEqPJMX0RvqiuAr9lmd4ju/b
         R/S0i74w2SouChlmtlBdK6yln1NWZYZNf/H57APKwf2ktK/F1fA6cxRXKQCwYgURxkCD
         wBXKLq1pAxWwOdTw7sGDkgyK4MPxXbjj82JjTohTICgCFu14T9dyoOzjKC824h6FrwDA
         k0zjfqFtJtDpyAl7EFwK1BEprsxQpNVJPxeZp+NHwf5XO9/3aOJj42xzn0B9gkL/n3tH
         c36VcIcRD4yNoH/X2nOhWUorg3wdG2MrgpdIlE70NBNcXByLi7+YR8X2E0EF9PeIydaO
         +vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX5WmxWuYSr8VxjzZegQNHZ2LJD3f554QY+Bp7zkDPE=;
        b=ZwX3wqjIpFQdI4chpGgR/0vfqNiz6OezH9YB8k+mw1x3y2uAY4R15lEf9XROYDA7QG
         LXYjMpJgxhqXhuLwJq0UNd64+7BWIhsDZfz9uvZaGWuo0aBQhpaqtBqlc94k9PZeZPa5
         dR3LECVJp41Vsr+Mlqm0ksphNScmmAMv8g8w5mHjbGKQ5vBICNqZJlJ77egnIzz9YIKe
         xf2CmbxkypbOFS1TORPeaxBuM8sEw1ZUthmBPH7GpeAiaXkapccxA6P9o+14HVuxLV9I
         BRhYWimDYIv07Pd8ybeKhduCzJPPOIdx/n8taLqHrZ0bX0T0nNrLo1hhkR/07JvvWZ3F
         fFoQ==
X-Gm-Message-State: APjAAAXceIrjhuCqqigrh2J3KnAUfWD22VNNZKSQCgyOtToJZLLyNpWa
        d9PeSB5wqaQ07ck2uL3DVAmYUlAx1JSkQWZQeKBZn++j6EYimu2w
X-Google-Smtp-Source: APXvYqxE7+vhGhLmlVWrIdPnXCmun+j/ZX4HxoKuexkjddXTCzriCinXX+Ut1bU999e68LrKw00XZzat/96dHKwDOMY=
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr2106230ljg.164.1569334003454;
 Tue, 24 Sep 2019 07:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190919092413.11141-1-r@hev.cc> <4379abe0-9f81-21b6-11ae-6eb3db79eeff@akamai.com>
 <5042e1e0-f49a-74c8-61f8-6903288110ac@akamai.com>
In-Reply-To: <5042e1e0-f49a-74c8-61f8-6903288110ac@akamai.com>
From:   Heiher <r@hev.cc>
Date:   Tue, 24 Sep 2019 22:06:32 +0800
Message-ID: <CAHirt9i42K37J9n8smaudJyigRAiiDhzZBuW+gbyLXHVq98yqQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, Sep 23, 2019 at 11:34 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 9/20/19 12:00 PM, Jason Baron wrote:
> > On 9/19/19 5:24 AM, hev wrote:
> >> From: Heiher <r@hev.cc>
> >>
> >> Take the case where we have:
> >>
> >>         t0
> >>          | (ew)
> >>         e0
> >>          | (et)
> >>         e1
> >>          | (lt)
> >>         s0
> >>
> >> t0: thread 0
> >> e0: epoll fd 0
> >> e1: epoll fd 1
> >> s0: socket fd 0
> >> ew: epoll_wait
> >> et: edge-trigger
> >> lt: level-trigger
> >>
> >> When s0 fires an event, e1 catches the event, and then e0 catches an event from
> >> e1. After this, There is a thread t0 do epoll_wait() many times on e0, it should
> >> only get one event in total, because e1 is a dded to e0 in edge-triggered mode.
> >>
> >> This patch only allows the wakeup(&ep->poll_wait) in ep_scan_ready_list under
> >> two conditions:
> >>
> >>  1. depth == 0.
> >>  2. There have event is added to ep->ovflist during processing.
> >>
> >> Test code:
> >>  #include <unistd.h>
> >>  #include <sys/epoll.h>
> >>  #include <sys/socket.h>
> >>
> >>  int main(int argc, char *argv[])
> >>  {
> >>      int sfd[2];
> >>      int efd[2];
> >>      struct epoll_event e;
> >>
> >>      if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
> >>              goto out;
> >>
> >>      efd[0] = epoll_create(1);
> >>      if (efd[0] < 0)
> >>              goto out;
> >>
> >>      efd[1] = epoll_create(1);
> >>      if (efd[1] < 0)
> >>              goto out;
> >>
> >>      e.events = EPOLLIN;
> >>      if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
> >>              goto out;
> >>
> >>      e.events = EPOLLIN | EPOLLET;
> >>      if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
> >>              goto out;
> >>
> >>      if (write(sfd[1], "w", 1) != 1)
> >>              goto out;
> >>
> >>      if (epoll_wait(efd[0], &e, 1, 0) != 1)
> >>              goto out;
> >>
> >>      if (epoll_wait(efd[0], &e, 1, 0) != 0)
> >>              goto out;
> >>
> >>      close(efd[0]);
> >>      close(efd[1]);
> >>      close(sfd[0]);
> >>      close(sfd[1]);
> >>
> >>      return 0;
> >>
> >>  out:
> >>      return -1;
> >>  }
> >>
> >> More tests:
> >>  https://github.com/heiher/epoll-wakeup
> >>
> >> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Davide Libenzi <davidel@xmailserver.org>
> >> Cc: Davidlohr Bueso <dave@stgolabs.net>
> >> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> >> Cc: Eric Wong <e@80x24.org>
> >> Cc: Jason Baron <jbaron@akamai.com>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Cc: Roman Penyaev <rpenyaev@suse.de>
> >> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Signed-off-by: hev <r@hev.cc>
> >> ---
> >>  fs/eventpoll.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> >> index c4159bcc05d9..fa71468dbd51 100644
> >> --- a/fs/eventpoll.c
> >> +++ b/fs/eventpoll.c
> >> @@ -685,6 +685,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
> >>      if (!ep_locked)
> >>              mutex_lock_nested(&ep->mtx, depth);
> >>
> >> +    if (!depth || list_empty_careful(&ep->rdllist))
> >> +            pwake++;
> >> +
> >>      /*
> >>       * Steal the ready list, and re-init the original one to the
> >>       * empty list. Also, set ep->ovflist to NULL so that events
> >> @@ -755,7 +758,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
> >>              mutex_unlock(&ep->mtx);
> >>
> >>      /* We have to call this outside the lock */
> >> -    if (pwake)
> >> +    if (pwake == 2)
> >>              ep_poll_safewake(&ep->poll_wait);
> >>
> >>      return res;
> >>
> >
> >
> > Hi,
> >
> > I was thinking more like the following. I tried it using your test-suite
> > and it seems to work. What do you think?
> >
> > Thanks,
> >
> > -Jason
> >
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index d7f1f50..662136b 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -712,6 +712,15 @@ static __poll_t ep_scan_ready_list(struct eventpoll
> > *ep,
> >         for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
> >              nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
> >                 /*
> > +                * We only need to wakeup nested epoll fds if
> > +                * if something has been queued to the overflow list,
> > +                * since the ep_poll() traverses the rdllist during
> > +                * recursive poll and thus events on the overflow list
> > +                * may not be visible yet.
> > +                */
> > +               if (!pwake)
> > +                       pwake++;
> > +               /*
> >                  * We need to check if the item is already in the list.
> >                  * During the "sproc" callback execution time, items are
> >                  * queued into ->ovflist but the "txlist" might already
> > @@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
> >                 mutex_unlock(&ep->mtx);
> >
> >         /* We have to call this outside the lock */
> > -       if (pwake)
> > +       if (pwake == 2)
> >                 ep_poll_safewake(&ep->poll_wait);
> >
> >         return res;
> >
> >
>
>
> Also, probably better to not have that 'if' in the loop, so how about
> the following?

Hmm. I think this is more accurate.
Thank you.

>
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d7f1f50..ed0d8da 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -704,12 +704,21 @@ static __poll_t ep_scan_ready_list(struct
> eventpoll *ep,
>         res = (*sproc)(ep, &txlist, priv);
>
>         write_lock_irq(&ep->lock);
> +       nepi = READ_ONCE(ep->ovflist);
> +       /*
> +        * We only need to wakeup nested epoll fds if something has been
> queued
> +        * to the overflow list, since the ep_poll() traverses the rdllist
> +        * during recursive poll and thus events on the overflow list
> may not be
> +        * visible yet.
> +        */
> +       if (nepi != NULL)
> +               pwake++;
>         /*
>          * During the time we spent inside the "sproc" callback, some
>          * other events might have been queued by the poll callback.
>          * We re-insert them inside the main ready-list here.
>          */
> -       for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
> +       for (; (epi = nepi) != NULL;
>              nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
>                 /*
>                  * We need to check if the item is already in the list.
> @@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>                 mutex_unlock(&ep->mtx);
>
>         /* We have to call this outside the lock */
> -       if (pwake)
> +       if (pwake == 2)
>                 ep_poll_safewake(&ep->poll_wait);
>
>         return res;
>


-- 
Best regards!
Hev
https://hev.cc
