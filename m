Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5CEE6A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfJ1A65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 20:58:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39175 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbfJ1A65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 20:58:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id 195so6473589lfj.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2019 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aMsAP2PxExyB/E1NoTV0dqnnfdxMUwdxPX5EmrFyzA=;
        b=O77cxxp0TiDbHCipSNxBDPQs6T3YuiXf2d6J838uRz/Yz+afk4zkR4cPIm4g3CsmLU
         +BQIeATLcLKQ3CnG6y/WT1V6Wder0rgPEQQOcvJLBXyqGsXF44D7R/iyUcHJZdJUnlQ5
         +FKKNxPCswaqseS4VUyoitrkxGU/Xg/Mg6Nu6OYsvG4oOjj7V/sH3Aa+VajjKaSI5flC
         5RfLygrqux7RvLJcNKY0PfyXkS0784Dgxwvw6BQAJQJgqUJGj4NUukHElgcB73eiWejp
         Ch8wzrgFhJkDlErFtU7bxaYsLF/DhvBa20f/1dphxEnP9jFGkBzHzVzXqvtA+jPR4iLu
         jC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aMsAP2PxExyB/E1NoTV0dqnnfdxMUwdxPX5EmrFyzA=;
        b=JOeds0mGVYgjwOpnn2SOzcRkUxAUmp2ffNa1wAaKeLIsAqihWqsKkeJr2rCoan6lu9
         knXlP61LxAjm+21lrUaKuj7nQznN1D+J3sjsEpshkOS5mgWFeRmG22xkLka80ej4g8uH
         aJuhA13ejA0rI70UkORXbWHRpOKiv+4EXVYck3r3F0Wot6rTndZPUtGz02RheeRszJ+R
         dnOU58e5vhKHV3Prg9xTTbYo3cKCATuI5Id803a1bF6w9KG+96Y2gJURWW06SjsyA2NT
         PB1xHfhHc9/mBQpqL+TsNlAOcKSWve9k5TAivsrFBdBUV2uM3E7fW5Jv4BcK1AGg/yZq
         hXLg==
X-Gm-Message-State: APjAAAUj6ZSO7vMXcFGkehV99rsr4PNI/pzJlwEkpvrPV0cfakzqhDGX
        YS3NqVAc+fyaXwKujZ+ZgWnnVOvWxLoa/RBasUV33Q==
X-Google-Smtp-Source: APXvYqxuFefFQRfxYLkJfVt6hHBd6Eyt1FmfLGZfeU+h+svNEOHgMHfQEyL/zqhvT47BmrFDaTpQdCnU0C81rSHyBto=
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr47893lfo.98.1572224332997;
 Sun, 27 Oct 2019 17:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191009060516.3577-1-r@hev.cc> <0911c1130bb79fd8c8e266bc7701b251@suse.de>
In-Reply-To: <0911c1130bb79fd8c8e266bc7701b251@suse.de>
From:   Heiher <r@hev.cc>
Date:   Mon, 28 Oct 2019 08:58:35 +0800
Message-ID: <CAHirt9iJhPA2BbHYFU81M3bcCwd9uk8T_Cvx9_3MRauwz-2+hg@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] fs/epoll: Remove unnecessary wakeups of nested epoll
To:     stable@vger.kernel.org
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 5:21 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> On 2019-10-09 08:05, hev wrote:
> > From: Heiher <r@hev.cc>
> >
> > Take the case where we have:
> >
> >         t0
> >          | (ew)
> >         e0
> >          | (et)
> >         e1
> >          | (lt)
> >         s0
> >
> > t0: thread 0
> > e0: epoll fd 0
> > e1: epoll fd 1
> > s0: socket fd 0
> > ew: epoll_wait
> > et: edge-trigger
> > lt: level-trigger
> >
> > We remove unnecessary wakeups to prevent the nested epoll that working
> > in edge-
> > triggered mode to waking up continuously.
> >
> > Test code:
> >  #include <unistd.h>
> >  #include <sys/epoll.h>
> >  #include <sys/socket.h>
> >
> >  int main(int argc, char *argv[])
> >  {
> >       int sfd[2];
> >       int efd[2];
> >       struct epoll_event e;
> >
> >       if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
> >               goto out;
> >
> >       efd[0] = epoll_create(1);
> >       if (efd[0] < 0)
> >               goto out;
> >
> >       efd[1] = epoll_create(1);
> >       if (efd[1] < 0)
> >               goto out;
> >
> >       e.events = EPOLLIN;
> >       if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
> >               goto out;
> >
> >       e.events = EPOLLIN | EPOLLET;
> >       if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
> >               goto out;
> >
> >       if (write(sfd[1], "w", 1) != 1)
> >               goto out;
> >
> >       if (epoll_wait(efd[0], &e, 1, 0) != 1)
> >               goto out;
> >
> >       if (epoll_wait(efd[0], &e, 1, 0) != 0)
> >               goto out;
> >
> >       close(efd[0]);
> >       close(efd[1]);
> >       close(sfd[0]);
> >       close(sfd[1]);
> >
> >       return 0;
> >
> >  out:
> >       return -1;
> >  }
> >
> > More tests:
> >  https://github.com/heiher/epoll-wakeup
> >
> > Cc: Al Viro <viro@ZenIV.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Davide Libenzi <davidel@xmailserver.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Eric Wong <e@80x24.org>
> > Cc: Jason Baron <jbaron@akamai.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Roman Penyaev <rpenyaev@suse.de>
> > Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: hev <r@hev.cc>
> > ---
> >  fs/eventpoll.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index c4159bcc05d9..75fccae100b5 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll
> > *ep,
> >                             void *priv, int depth, bool ep_locked)
> >  {
> >       __poll_t res;
> > -     int pwake = 0;
> >       struct epitem *epi, *nepi;
> >       LIST_HEAD(txlist);
> >
> > @@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct
> > eventpoll *ep,
> >        */
> >       list_splice(&txlist, &ep->rdllist);
> >       __pm_relax(ep->ws);
> > -
> > -     if (!list_empty(&ep->rdllist)) {
> > -             /*
> > -              * Wake up (if active) both the eventpoll wait list and
> > -              * the ->poll() wait list (delayed after we release the lock).
> > -              */
> > -             if (waitqueue_active(&ep->wq))
> > -                     wake_up(&ep->wq);
> > -             if (waitqueue_active(&ep->poll_wait))
> > -                     pwake++;
> > -     }
> >       write_unlock_irq(&ep->lock);
> >
> >       if (!ep_locked)
> >               mutex_unlock(&ep->mtx);
> >
> > -     /* We have to call this outside the lock */
> > -     if (pwake)
> > -             ep_poll_safewake(&ep->poll_wait);
> > -
> >       return res;
> >  }
>
> This looks good to me.  Heiher, mind to make kselftest out of your test
> suite?
>
> Reviewed-by: Roman Penyaev <rpenyaev@suse.de>
>
> --
> Roman
>
>
>

Need to back port this patch to stable branches?

-- 
Best regards!
Hev
https://hev.cc
