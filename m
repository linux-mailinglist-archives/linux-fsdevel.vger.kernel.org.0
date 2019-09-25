Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A054CBD637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633687AbfIYBzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 21:55:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38584 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfIYBzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 21:55:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so3880151ljj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 18:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnrH0v0z3ukmxZZZVDlP/AkPyborUYw1x3C+Oh0uyjY=;
        b=1r+7wj1h669ZQZ1Q36CDW0ti2s5mpg8ivKNi4O4P17FWWogctXLC8Ajf43UHZOLxsy
         oRIZO0foOlIzl75l0DToQdd6xzLOjT3liWLNo1F/2afK3LeewO+4D3ybWbBaEbHLHf0z
         pT9DPHZnT8Pls4zYBwXUZx1edeOsk08KqC2i+xvVM4dljvcot8VadAp0L5l/WTaCtf84
         t1HGtax9Cn1CZ0nzmpIFO827C4ZaVxc+yMeLDhLcbQok9PXA89q+QfMkvCv7yct5ujRV
         nc/i7155TaKaIAPIdLnigGHakXOFtBOsbEyVlp5wLEH1WWJpSupZLEgxbS5iJPu7UhtG
         qahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnrH0v0z3ukmxZZZVDlP/AkPyborUYw1x3C+Oh0uyjY=;
        b=ftwbknUnI42FukGzZg4llGugcWUhMujlmjwiDaWl3JaNShEhnU2gevvA8qZHggGT5d
         MGcPk5fu+ylIZAyJcFZeCLj7O/jVGuIOYgtWL3JMGXgaHf38iBKmKGm1L2fgPmUtDsP0
         ISgW0lbJYP+Zrf+FAOChmHYSAc3zSwwXdAWpXfNlrdfBwsSGdKmRqTNjfeLnB+gH9llQ
         N4LungZJETtmk7iGuOWaRXHUcztuCNdgtBA8Jt6gUCF0o4pep4rTBZyjpRhzabMc/BzZ
         1bloKtXvbGYv1IJyaILmVE3qHyF+eXvVz5F7rOJyQ4A6CvBUT1JrdJxdLbwLRGkgPFe9
         EetA==
X-Gm-Message-State: APjAAAVwWAlzOcIV9n3mRtD6QVWg7dGboeIMv4UI2+ZVRpQc2py8A97O
        a+PBvnmGe+ks+LVBxogffkb0QdOVyYO1KkJY7Vroig==
X-Google-Smtp-Source: APXvYqy2lLyxOuORM4qSVmKT+DJUortZxQMuCZxvRWRcXMz8NIqrkwRinHHcP3McR8h8J4YY3peQbTQhrkMAefMC81A=
X-Received: by 2002:a2e:3201:: with SMTP id y1mr4059819ljy.5.1569376551089;
 Tue, 24 Sep 2019 18:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190919092413.11141-1-r@hev.cc> <4379abe0-9f81-21b6-11ae-6eb3db79eeff@akamai.com>
 <5042e1e0-f49a-74c8-61f8-6903288110ac@akamai.com> <CAHirt9i42K37J9n8smaudJyigRAiiDhzZBuW+gbyLXHVq98yqQ@mail.gmail.com>
 <92a54917-0cdf-89ce-1fb1-f913156a1e0d@akamai.com>
In-Reply-To: <92a54917-0cdf-89ce-1fb1-f913156a1e0d@akamai.com>
From:   Heiher <r@hev.cc>
Date:   Wed, 25 Sep 2019 09:55:34 +0800
Message-ID: <CAHirt9hQ1PkdDtidfHjbND-ABeRMj54yTWd2QDzOV4dbDEvdcg@mail.gmail.com>
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

On Tue, Sep 24, 2019 at 11:19 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 9/24/19 10:06 AM, Heiher wrote:
> > Hi,
> >
> > On Mon, Sep 23, 2019 at 11:34 PM Jason Baron <jbaron@akamai.com> wrote:
> >>
> >>
> >>
> >> On 9/20/19 12:00 PM, Jason Baron wrote:
> >>> On 9/19/19 5:24 AM, hev wrote:
> >>>> From: Heiher <r@hev.cc>
> >>>>
> >>>> Take the case where we have:
> >>>>
> >>>>         t0
> >>>>          | (ew)
> >>>>         e0
> >>>>          | (et)
> >>>>         e1
> >>>>          | (lt)
> >>>>         s0
> >>>>
> >>>> t0: thread 0
> >>>> e0: epoll fd 0
> >>>> e1: epoll fd 1
> >>>> s0: socket fd 0
> >>>> ew: epoll_wait
> >>>> et: edge-trigger
> >>>> lt: level-trigger
> >>>>
> >>>> When s0 fires an event, e1 catches the event, and then e0 catches an event from
> >>>> e1. After this, There is a thread t0 do epoll_wait() many times on e0, it should
> >>>> only get one event in total, because e1 is a dded to e0 in edge-triggered mode.
> >>>>
> >>>> This patch only allows the wakeup(&ep->poll_wait) in ep_scan_ready_list under
> >>>> two conditions:
> >>>>
> >>>>  1. depth == 0.
>
>
> What is the point of this condition again? I was thinking we only need
> to do #2.
>
> >>>>  2. There have event is added to ep->ovflist during processing.
> >>>>
> >>>> Test code:
> >>>>  #include <unistd.h>
> >>>>  #include <sys/epoll.h>
> >>>>  #include <sys/socket.h>
> >>>>
> >>>>  int main(int argc, char *argv[])
> >>>>  {
> >>>>      int sfd[2];
> >>>>      int efd[2];
> >>>>      struct epoll_event e;
> >>>>
> >>>>      if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
> >>>>              goto out;
> >>>>
> >>>>      efd[0] = epoll_create(1);
> >>>>      if (efd[0] < 0)
> >>>>              goto out;
> >>>>
> >>>>      efd[1] = epoll_create(1);
> >>>>      if (efd[1] < 0)
> >>>>              goto out;
> >>>>
> >>>>      e.events = EPOLLIN;
> >>>>      if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
> >>>>              goto out;
> >>>>
> >>>>      e.events = EPOLLIN | EPOLLET;
> >>>>      if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
> >>>>              goto out;
> >>>>
> >>>>      if (write(sfd[1], "w", 1) != 1)
> >>>>              goto out;
> >>>>
> >>>>      if (epoll_wait(efd[0], &e, 1, 0) != 1)
> >>>>              goto out;
> >>>>
> >>>>      if (epoll_wait(efd[0], &e, 1, 0) != 0)
> >>>>              goto out;
> >>>>
> >>>>      close(efd[0]);
> >>>>      close(efd[1]);
> >>>>      close(sfd[0]);
> >>>>      close(sfd[1]);
> >>>>
> >>>>      return 0;
> >>>>
> >>>>  out:
> >>>>      return -1;
> >>>>  }
> >>>>
> >>>> More tests:
> >>>>  https://github.com/heiher/epoll-wakeup
> >>>>
> >>>> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> >>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>> Cc: Davide Libenzi <davidel@xmailserver.org>
> >>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
> >>>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> >>>> Cc: Eric Wong <e@80x24.org>
> >>>> Cc: Jason Baron <jbaron@akamai.com>
> >>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Cc: Roman Penyaev <rpenyaev@suse.de>
> >>>> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Cc: linux-fsdevel@vger.kernel.org
> >>>> Signed-off-by: hev <r@hev.cc>
> >>>> ---
> >>>>  fs/eventpoll.c | 5 ++++-
> >>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> >>>> index c4159bcc05d9..fa71468dbd51 100644
> >>>> --- a/fs/eventpoll.c
> >>>> +++ b/fs/eventpoll.c
> >>>> @@ -685,6 +685,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
> >>>>      if (!ep_locked)
> >>>>              mutex_lock_nested(&ep->mtx, depth);
> >>>>
> >>>> +    if (!depth || list_empty_careful(&ep->rdllist))
> >>>> +            pwake++;
> >>>> +
>
> This is the check I'm wondering why it's needed?

You are right. This is not needed. Initially, I want to keep the
original behavior of depth 0 for direct poll() in multi-threads.

>
> Thanks,
>
>
> -Jason
>


-- 
Best regards!
Hev
https://hev.cc
