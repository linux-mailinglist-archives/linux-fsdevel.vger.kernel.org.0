Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E9A9899
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfIECxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 22:53:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46977 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbfIECxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:53:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so626413lfc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4pG+i9j2p51cVON3JW4RUDWmF2sUOHK1BnuKjKHSsc=;
        b=AdJ6n3A9BTY/Vwdlf6UnyLBGTgbxsTWzhmwv4EtaeRKn4KVkmdThN4NTESZAueFeOG
         ZUXs0YOvuzSULqsrQMeECyf39F0cZwCkUSD45y5Yhot9DbMlHKR0FO9Odh9tTNK8vrcM
         lLdyRUht7s1X+UAhCsUNbmIUnrSCfcRtdnSJOj9HuNCdln3FOXWOK25eczarK5uxfaVr
         xsH52o260Q0/lURl+QrOb7E1LdxaVUH8kCa+pJzSFtpPI2Ll4o4sH9kMjgnyT/LUGxJH
         6JLVl9zqHZxrSiXDUYEaSCakojEefnFTVpvZLcROW8V2y6PlAKBLsdJySwb48xtVujTn
         /YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4pG+i9j2p51cVON3JW4RUDWmF2sUOHK1BnuKjKHSsc=;
        b=R3/if0BMgqkSLL5miA6entzaOYaFGttm8COwoIBpVoOF4uHsVINaG0vAep+Ha4Dk4b
         6eRmXj124/FyKIgR8tY/Np2kcIOcscHiHMxnJ56282GnZF8RAQZCOw6nwMFuHnYkzK6u
         l2lwLR9tCnVChO53v1Kc+lcWY6XboVYyclLKn2/64FR1Tld2lKLmjCAsfsqY/FLC1QlG
         kify9ypi+TS84TzZaAkpdhGZRjKHKr+trH9IjVRFM+oTbNkir45ExPuRuJNdvMgoTFBR
         cOQ7CBqVoD7nxfe9ObcAgNpyrOS7JFeYPG1PweckaOQNuW8DvYBmlTgYviUimdCnU5qt
         sFGA==
X-Gm-Message-State: APjAAAUWJNpWNXXJM8hO6iVWplrIsKnMuQUPWIQUk9uKwqWd71VSR8cZ
        u+gLm2AwxuryHTYewqFw4xuhgcDBGJ+HHc7MxZURrLlowhuYiKl7
X-Google-Smtp-Source: APXvYqxHS6/0yeN7+erjQV+tln/fP4Xy3vY0MMZ/6FF+JX5WLtof4FW+SuZ4jdhHs0WwzmrqLHqexzfuwAr3I/aXOoE=
X-Received: by 2002:a19:7715:: with SMTP id s21mr685568lfc.98.1567652030503;
 Wed, 04 Sep 2019 19:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190902052034.16423-1-r@hev.cc> <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
 <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com> <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
 <341df9eb-7e8e-98c8-5183-402bdfff7d59@akamai.com> <CAHirt9hra2tA_OPNSow+CgD_CF2Z11ZqGG=1P45noqtdMtWuJw@mail.gmail.com>
In-Reply-To: <CAHirt9hra2tA_OPNSow+CgD_CF2Z11ZqGG=1P45noqtdMtWuJw@mail.gmail.com>
From:   Heiher <r@hev.cc>
Date:   Thu, 5 Sep 2019 10:53:11 +0800
Message-ID: <CAHirt9j+DSR+uP-SBLHn0ika86uixSOPLXft+vVj5G5Ge0xr5w@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested epoll
To:     Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        Roman Penyaev <rpenyaev@suse.de>
Cc:     Eric Wong <e@80x24.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I created an epoll wakeup test project, listed some possible cases,
and any other corner cases needs to be added?

https://github.com/heiher/epoll-wakeup/blob/master/README.md

On Wed, Sep 4, 2019 at 10:02 PM Heiher <r@hev.cc> wrote:
>
> Hi,
>
> On Wed, Sep 4, 2019 at 8:02 PM Jason Baron <jbaron@akamai.com> wrote:
> >
> >
> >
> > On 9/4/19 5:57 AM, Roman Penyaev wrote:
> > > On 2019-09-03 23:08, Jason Baron wrote:
> > >> On 9/2/19 11:36 AM, Roman Penyaev wrote:
> > >>> Hi,
> > >>>
> > >>> This is indeed a bug. (quick side note: could you please remove efd[1]
> > >>> from your test, because it is not related to the reproduction of a
> > >>> current bug).
> > >>>
> > >>> Your patch lacks a good description, what exactly you've fixed.  Let
> > >>> me speak out loud and please correct me if I'm wrong, my understanding
> > >>> of epoll internals has become a bit rusty: when epoll fds are nested
> > >>> an attempt to harvest events (ep_scan_ready_list() call) produces a
> > >>> second (repeated) event from an internal fd up to an external fd:
> > >>>
> > >>>      epoll_wait(efd[0], ...):
> > >>>        ep_send_events():
> > >>>           ep_scan_ready_list(depth=0):
> > >>>             ep_send_events_proc():
> > >>>                 ep_item_poll():
> > >>>                   ep_scan_ready_list(depth=1):
> > >>>                     ep_poll_safewake():
> > >>>                       ep_poll_callback()
> > >>>                         list_add_tail(&epi, &epi->rdllist);
> > >>>                         ^^^^^^
> > >>>                         repeated event
> > >>>
> > >>>
> > >>> In your patch you forbid wakeup for the cases, where depth != 0, i.e.
> > >>> for all nested cases. That seems clear.  But what if we can go further
> > >>> and remove the whole chunk, which seems excessive:
> > >>>
> > >>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
> > >>> eventpoll *ep,
> > >>>
> > >>> -
> > >>> -       if (!list_empty(&ep->rdllist)) {
> > >>> -               /*
> > >>> -                * Wake up (if active) both the eventpoll wait list and
> > >>> -                * the ->poll() wait list (delayed after we release the
> > >>> lock).
> > >>> -                */
> > >>> -               if (waitqueue_active(&ep->wq))
> > >>> -                       wake_up(&ep->wq);
> > >>> -               if (waitqueue_active(&ep->poll_wait))
> > >>> -                       pwake++;
> > >>> -       }
> > >>>         write_unlock_irq(&ep->lock);
> > >>>
> > >>>         if (!ep_locked)
> > >>>                 mutex_unlock(&ep->mtx);
> > >>>
> > >>> -       /* We have to call this outside the lock */
> > >>> -       if (pwake)
> > >>> -               ep_poll_safewake(&ep->poll_wait);
> > >>>
> > >>>
> > >>> I reason like that: by the time we've reached the point of scanning events
> > >>> for readiness all wakeups from ep_poll_callback have been already fired and
> > >>> new events have been already accounted in ready list (ep_poll_callback()
> > >>> calls
> > >>> the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and probably
> > >>> missing some corner cases.
> > >>>
> > >>> Thoughts?
> > >>
> > >> So the: 'wake_up(&ep->wq);' part, I think is about waking up other
> > >> threads that may be in waiting in epoll_wait(). For example, there may
> > >> be multiple threads doing epoll_wait() on the same epoll fd, and the
> > >> logic above seems to say thread 1 may have processed say N events and
> > >> now its going to to go off to work those, so let's wake up thread 2 now
> > >> to handle the next chunk.
> > >
> > > Not quite. Thread which calls ep_scan_ready_list() processes all the
> > > events, and while processing those, removes them one by one from the
> > > ready list.  But if event mask is !0 and event belongs to
> > > Level Triggered Mode descriptor (let's say default mode) it tails event
> > > again back to the list (because we are in level mode, so event should
> > > be there).  So at the end of this traversing loop ready list is likely
> > > not empty, and if so, wake up again is called for nested epoll fds.
> > > But, those nested epoll fds should get already all the notifications
> > > from the main event callback ep_poll_callback(), regardless any thread
> > > which traverses events.
> > >
> > > I suppose this logic exists for decades, when Davide (the author) was
> > > reshuffling the code here and there.
> > >
> > > But I do not feel confidence to state that this extra wakeup is bogus,
> > > I just have a gut feeling that it looks excessive.
> >
> > Note that I was talking about the wakeup done on ep->wq not ep->poll_wait.
> > The path that I'm concerned about is let's say that there are N events
> > queued on the ready list. A thread that was woken up in epoll_wait may
> > decide to only process say N/2 of then. Then it will call wakeup on ep->wq
> > and this will wakeup another thread to process the remaining N/2. Without
> > the wakeup, the original thread isn't going to process the events until
> > it finishes with the original N/2 and gets back to epoll_wait(). So I'm not
> > sure how important that path is but I wanted to at least note the change
> > here would impact that behavior.
> >
> > Thanks,
> >
> > -Jason
> >
> >
> > >
> > >> So I think removing all that even for the
> > >> depth 0 case is going to change some behavior here. So perhaps, it
> > >> should be removed for all depths except for 0? And if so, it may be
> > >> better to make 2 patches here to separate these changes.
> > >>
> > >> For the nested wakeups, I agree that the extra wakeups seem unnecessary
> > >> and it may make sense to remove them for all depths. I don't think the
> > >> nested epoll semantics are particularly well spelled out, and afaict,
> > >> nested epoll() has behaved this way for quite some time. And the current
> > >> behavior is not bad in the way that a missing wakeup or false negative
> > >> would be.
> > >
> > > That's 100% true! For edge mode extra wake up is not a bug, not optimal
> > > for userspace - yes, but that can't lead to any lost wakeups.
> > >
> > > --
> > > Roman
> > >
>
> I tried to remove the whole chunk of code that Roman said, and it
> seems that there
> are no obvious problems with the two test programs below:
>
> Test case 1:
>            t0
>             |
>            e0
>             |
>            e1 (et)
>             |
>            s0 (lt)
>
> When s0 is readable, the thread 0 can only read once event from e0.
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/epoll.h>
> #include <sys/socket.h>
>
> int main(int argc, char *argv[])
> {
>     int sfd[2];
>     int efd[2];
>     int nfds;
>     struct epoll_event e;
>
>     if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
>         goto out;
>
>     efd[0] = epoll_create(1);
>     if (efd[0] < 0)
>         goto out;
>
>     efd[1] = epoll_create(1);
>     if (efd[1] < 0)
>         goto out;
>
>     e.events = EPOLLIN;
>     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>         goto out;
>
>     e.events = EPOLLIN | EPOLLET;
>     if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>         goto out;
>
>     if (write(sfd[1], "w", 1) != 1)
>         goto out;
>
>     nfds = epoll_wait(efd[0], &e, 1, 0);
>     if (nfds != 1)
>         goto out;
>
>     nfds = epoll_wait(efd[0], &e, 1, 0);
>     if (nfds != 0)
>         goto out;
>
>     nfds = epoll_wait(efd[1], &e, 1, 0);
>     if (nfds != 1)
>         goto out;
>
>     nfds = epoll_wait(efd[1], &e, 1, 0);
>     if (nfds != 1)
>         goto out;
>
>     close(efd[1]);
>     close(efd[0]);
>     close(sfd[0]);
>     close(sfd[1]);
>
>     printf("PASS\n");
>     return 0;
>
> out:
>     printf("FAIL\n");
>     return -1;
> }
>
> Test case 2:
>            t0  t1
>             \   /
>              e0
>             /   \
>     (et) e1   e2 (et)
>            |      |
>      (lt) s0    s2 (lt)
>
> When s0 and s2 are readable, both thread 0 and thread 1 can read an
> event from e0.
>
> #include <stdio.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <sys/epoll.h>
> #include <sys/socket.h>
>
> static int efd[3];
> static int sfd[4];
> static int count;
>
> static void *
> thread_handler(void *data)
> {
>     struct epoll_event e;
>
>     if (epoll_wait(efd[0], &e, 1, -1) == 1)
>         count++;
>
>     return NULL;
> }
>
> static void *
> emit_handler(void *data)
> {
>     usleep (100000);
>
>     write(sfd[1], "w", 1);
>     write(sfd[3], "w", 1);
>
>     return NULL;
> }
>
> int main(int argc, char *argv[])
> {
>     struct epoll_event e;
>     pthread_t tw, te;
>
>     if (socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]) < 0)
>         goto out;
>
>     if (socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]) < 0)
>         goto out;
>
>     efd[0] = epoll_create(1);
>     if (efd[0] < 0)
>         goto out;
>
>     efd[1] = epoll_create(1);
>     if (efd[1] < 0)
>         goto out;
>
>     efd[2] = epoll_create(1);
>     if (efd[2] < 0)
>         goto out;
>
>     e.events = EPOLLIN;
>     if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
>         goto out;
>
>     e.events = EPOLLIN;
>     if (epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[2], &e) < 0)
>         goto out;
>
>     e.events = EPOLLIN | EPOLLET;
>     if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>         goto out;
>
>     e.events = EPOLLIN | EPOLLET;
>     if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], &e) < 0)
>         goto out;
>
>     if (pthread_create(&tw, NULL, thread_handler, NULL) < 0)
>         goto out;
>
>     if (pthread_create(&te, NULL, emit_handler, NULL) < 0)
>         goto out;
>
>     if (epoll_wait(efd[0], &e, 1, -1) == 1)
>         count++;
>
>     if (pthread_join(tw, NULL) < 0)
>         goto out;
>
>     if (count != 2)
>         goto out;
>
>     close(efd[0]);
>     close(efd[1]);
>     close(efd[2]);
>     close(sfd[0]);
>     close(sfd[1]);
>     close(sfd[2]);
>     close(sfd[3]);
>
>     printf ("PASS\n");
>     return 0;
>
> out:
>     printf("FAIL\n");
>     return -1;
> }
>
> t0: thread0
> t1: thread1
> e0: epoll0 (efd[0])
> e1: epoll1 (efd[1])
> e2: epoll2 (efd[2])
> s0: socket0 (sfd[0])
> s2: socket2 (sfd[2])
>
> Is it possible to prove that this modification is correct, or any
> other corner cases are missing?
>
> --
> Best regards!
> Hev
> https://hev.cc



-- 
Best regards!
Hev
https://hev.cc
