Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352C2AA919
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 05:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKHEqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 23:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKHEqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:46:08 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFCC0613D2
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2020 20:46:08 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so5316101wrp.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2020 20:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCWk0yHeS1wjwiAqSGVF8CAmBgVxMNWcAcpfrZJFKXQ=;
        b=bncIfLMEhIhf7p3qNlJMaJXxZYBlNlPppMIDwC6qBcFouu+QSlXhlHPXizLJ8hBtL/
         WCKm0wwjy/KKNfw0C5gWf5AdPC2aw/xoqlXLEpVFY4avKUqXGNqfKyEoqvRc0hEG1D0d
         /VkeAxkla5uARM5zc3oNHzKD0yDoNPDeEFjxKsXB3FcaBxqKmIiuIBUyRqj9IATGMp1p
         lVkZZ3krJ6Q3I9PhjRBuM9axpeBRboqsx4LHAVvfCg4egVKyNBcX75zphnU+NjN+EJdy
         As6LViIJrqUDRQy+Yhp27CfU+Ykm5/VbG3tqY5sCSZZz5DppbYctf8Ntw2ItvqjYa1pt
         xpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCWk0yHeS1wjwiAqSGVF8CAmBgVxMNWcAcpfrZJFKXQ=;
        b=Q9HkRZGrTjJVDD5Gf9hXUdIHF/IHlRHphDHsnQizkLWGW2MUBYRN8qP5Pfc446VBXK
         +pKy19SfDR3rdnpEHv/lzpSMMHSTarS1eDBSaFGmqPjsnOOipMb0TBEAxLFylGbc/dXz
         thOFfI6rh1R9Wy+m6tdnA5rudYt2ckvtF81wtWwnbqZXbSZa7ISpWhbd3gvkwPm/zvVI
         wQmiLBTcKkCYw0HfnIuANRrf6wQD8+S6OggUJqEivSWZ1XaeHakPuZoPZnk/IcWr0Kfj
         vUgeN4oXp3o97MfOOgvtxbRA8bkdZTz/UxBW4ZnLBvvLxcUJoqdQFctAw+hbEe/aJXk8
         FQJQ==
X-Gm-Message-State: AOAM532P+DgbPPUNDtEl80w7QajkqRgci/SExlWZYzrpn9F5wEOKJYDn
        qOutdEXuzHvUlEHRG66CcXPwP9a51t7efaH8s1Q4TA==
X-Google-Smtp-Source: ABdhPJy7hMgby+PNhVLfJkV0Tf8Yl675dF+Zz3FUcuMm9+MPNQJ7rQokxwra5JiuygyPfG19CIbrlUSd+ZVqtf0xkH0=
X-Received: by 2002:adf:ed04:: with SMTP id a4mr11526384wro.172.1604810766379;
 Sat, 07 Nov 2020 20:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20201106231635.3528496-1-soheil.kdev@gmail.com> <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
In-Reply-To: <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Sat, 7 Nov 2020 23:45:30 -0500
Message-ID: <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 7, 2020 at 8:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  6 Nov 2020 18:16:27 -0500 Soheil Hassas Yeganeh <soheil.kdev@gmail.com> wrote:
>
> > From: Soheil Hassas Yeganeh <soheil@google.com>
> >
> > This patch series is a follow up based on the suggestions and feedback by Linus:
> > https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com
>
> Al Viro has been playing in here as well - see the below, from
> linux-next.
>
> I think I'll leave it to you folks to sort this out, please.

Thank you Andrew for pointing that out!  Sorry that I didn't notice Al
Viro's nice clean ups.

The changes are all orthogonal and apply cleanly except "epoll: pull
fatal signal checks into ep_send_events()".   The conflict is trivial
and the following patch should cleanly apply to linux-next/master (I
didn't move the initialization of `res = 0` after the new branch to
keep it simple).

FWIW, I also stress-tested the patch series applied on top of
linux-next/master for a couple of hours.

Could you please let me know whether I should send a V2 of the patch
series for linux-next? Thanks!

Subject: [PATCH linux-next] epoll: pull fatal signal checks into
ep_send_events()

To simplify the code, pull in checking the fatal signals into
ep_send_events().  ep_send_events() is called only from ep_poll().

Note that, previously, we were always checking fatal events, but
it is checked only if eavail is true.  This should be fine because
the goal of that check is to quickly return from epoll_wait() when
there is a pending fatal signal.

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Change-Id: I68bbaf02db564e64815bcd8ed3c1cd272cfe832f
---
 fs/eventpoll.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 06fb0de4bcc7..42f6bfc5f24e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1625,6 +1625,14 @@ static int ep_send_events(struct eventpoll *ep,
        poll_table pt;
        int res = 0;

+       /*
+        * Always short-circuit for fatal signals to allow threads to make a
+        * timely exit without the chance of finding more events available and
+        * fetching repeatedly.
+        */
+       if (fatal_signal_pending(current))
+               return -EINTR;
+
        init_poll_funcptr(&pt, NULL);

        mutex_lock(&ep->mtx);
@@ -1846,15 +1854,6 @@ static int ep_poll(struct eventpoll *ep, struct
epoll_event __user *events,
        }

 send_events:
-       if (fatal_signal_pending(current)) {
-               /*
-                * Always short-circuit for fatal signals to allow
-                * threads to make a timely exit without the chance of
-                * finding more events available and fetching
-                * repeatedly.
-                */
-               return -EINTR;
-       }
        /*
         * Try to transfer events to user space. In case we get 0 events and
         * there's still timeout left over, we go trying again in search of

--
2.29.2.222.g5d2a92d10f8-goog




> commit 57804b1cc4616780c72a2d0930d1bd0d5bd3ed4c
> Author:     Al Viro <viro@zeniv.linux.org.uk>
> AuthorDate: Mon Aug 31 13:41:30 2020 -0400
> Commit:     Al Viro <viro@zeniv.linux.org.uk>
> CommitDate: Sun Oct 25 20:02:01 2020 -0400
>
>     lift locking/unlocking ep->mtx out of ep_{start,done}_scan()
>
>     get rid of depth/ep_locked arguments there and document
>     the kludge in ep_item_poll() that has lead to ep_locked existence in
>     the first place
>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index ac996b959e94..f9c567af1f5f 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -554,20 +554,13 @@ static inline void ep_pm_stay_awake_rcu(struct epitem *epi)
>         rcu_read_unlock();
>  }
>
> -static void ep_start_scan(struct eventpoll *ep,
> -                         int depth, bool ep_locked,
> -                         struct list_head *txlist)
> -{
> -       lockdep_assert_irqs_enabled();
> -
> -       /*
> -        * We need to lock this because we could be hit by
> -        * eventpoll_release_file() and epoll_ctl().
> -        */
> -
> -       if (!ep_locked)
> -               mutex_lock_nested(&ep->mtx, depth);
>
> +/*
> + * ep->mutex needs to be held because we could be hit by
> + * eventpoll_release_file() and epoll_ctl().
> + */
> +static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
> +{
>         /*
>          * Steal the ready list, and re-init the original one to the
>          * empty list. Also, set ep->ovflist to NULL so that events
> @@ -576,6 +569,7 @@ static void ep_start_scan(struct eventpoll *ep,
>          * because we want the "sproc" callback to be able to do it
>          * in a lockless way.
>          */
> +       lockdep_assert_irqs_enabled();
>         write_lock_irq(&ep->lock);
>         list_splice_init(&ep->rdllist, txlist);
>         WRITE_ONCE(ep->ovflist, NULL);
> @@ -583,7 +577,6 @@ static void ep_start_scan(struct eventpoll *ep,
>  }
>
>  static void ep_done_scan(struct eventpoll *ep,
> -                        int depth, bool ep_locked,
>                          struct list_head *txlist)
>  {
>         struct epitem *epi, *nepi;
> @@ -624,9 +617,6 @@ static void ep_done_scan(struct eventpoll *ep,
>         list_splice(txlist, &ep->rdllist);
>         __pm_relax(ep->ws);
>         write_unlock_irq(&ep->lock);
> -
> -       if (!ep_locked)
> -               mutex_unlock(&ep->mtx);
>  }
>
>  static void epi_rcu_free(struct rcu_head *head)
> @@ -763,11 +753,16 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
>
>         ep = epi->ffd.file->private_data;
>         poll_wait(epi->ffd.file, &ep->poll_wait, pt);
> -       locked = pt && (pt->_qproc == ep_ptable_queue_proc);
>
> -       ep_start_scan(ep, depth, locked, &txlist);
> +       // kludge: ep_insert() calls us with ep->mtx already locked
> +       locked = pt && (pt->_qproc == ep_ptable_queue_proc);
> +       if (!locked)
> +               mutex_lock_nested(&ep->mtx, depth);
> +       ep_start_scan(ep, &txlist);
>         res = ep_read_events_proc(ep, &txlist, depth + 1);
> -       ep_done_scan(ep, depth, locked, &txlist);
> +       ep_done_scan(ep, &txlist);
> +       if (!locked)
> +               mutex_unlock(&ep->mtx);
>         return res & epi->event.events;
>  }
>
> @@ -809,9 +804,11 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
>          * Proceed to find out if wanted events are really available inside
>          * the ready list.
>          */
> -       ep_start_scan(ep, 0, false, &txlist);
> +       mutex_lock(&ep->mtx);
> +       ep_start_scan(ep, &txlist);
>         res = ep_read_events_proc(ep, &txlist, 1);
> -       ep_done_scan(ep, 0, false, &txlist);
> +       ep_done_scan(ep, &txlist);
> +       mutex_unlock(&ep->mtx);
>         return res;
>  }
>
> @@ -1573,15 +1570,13 @@ static int ep_send_events(struct eventpoll *ep,
>
>         init_poll_funcptr(&pt, NULL);
>
> -       ep_start_scan(ep, 0, false, &txlist);
> +       mutex_lock(&ep->mtx);
> +       ep_start_scan(ep, &txlist);
>
>         /*
>          * We can loop without lock because we are passed a task private list.
> -        * Items cannot vanish during the loop because ep_scan_ready_list() is
> -        * holding "mtx" during this call.
> +        * Items cannot vanish during the loop we are holding ep->mtx.
>          */
> -       lockdep_assert_held(&ep->mtx);
> -
>         list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
>                 struct wakeup_source *ws;
>                 __poll_t revents;
> @@ -1609,9 +1604,8 @@ static int ep_send_events(struct eventpoll *ep,
>
>                 /*
>                  * If the event mask intersect the caller-requested one,
> -                * deliver the event to userspace. Again, ep_scan_ready_list()
> -                * is holding ep->mtx, so no operations coming from userspace
> -                * can change the item.
> +                * deliver the event to userspace. Again, we are holding ep->mtx,
> +                * so no operations coming from userspace can change the item.
>                  */
>                 revents = ep_item_poll(epi, &pt, 1);
>                 if (!revents)
> @@ -1645,7 +1639,8 @@ static int ep_send_events(struct eventpoll *ep,
>                         ep_pm_stay_awake(epi);
>                 }
>         }
> -       ep_done_scan(ep, 0, false, &txlist);
> +       ep_done_scan(ep, &txlist);
> +       mutex_unlock(&ep->mtx);
>
>         return res;
>  }
>
