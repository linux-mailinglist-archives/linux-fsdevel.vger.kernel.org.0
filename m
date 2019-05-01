Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9510E42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEAUs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 16:48:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56320 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEAUs1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 16:48:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E8A611F453;
        Wed,  1 May 2019 20:48:26 +0000 (UTC)
Date:   Wed, 1 May 2019 20:48:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190501204826.umekxc7oynslakes@dcvr>
References: <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr>
 <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr>
 <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr>
 <20190501073906.ekqr7xbw3qkfgv56@dcvr>
 <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> So here is my analysis:

<snip everything I agree with>

> So the 854a6ed56839a40f6 seems to be better than the original code in
> that it detects the signal.

OTOH, does matter to anybody that a signal is detected slightly
sooner than it would've been, otherwise?

> But, the problem is that it doesn't
> communicate it to the userspace.

Yup, that's a big problem :)
 
> So a patch like below solves the problem. This is incomplete. I'll
> verify and send you a proper fix you can test soon. This is just for
> the sake of discussion:
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4a0e98d87fcc..63a387329c3d 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2317,7 +2317,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
> epoll_event __user *, events,
>                 int, maxevents, int, timeout, const sigset_t __user *, sigmask,
>                 size_t, sigsetsize)
>  {
> -       int error;
> +       int error, signal_detected;
>         sigset_t ksigmask, sigsaved;
> 
>         /*
> @@ -2330,7 +2330,10 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
> epoll_event __user *, events,
> 
>         error = do_epoll_wait(epfd, events, maxevents, timeout);
> 
> -       restore_user_sigmask(sigmask, &sigsaved);
> +       signal_detected = restore_user_sigmask(sigmask, &sigsaved);
> +
> +       if (signal_detected && !error)
> +               return -EITNR;
> 
>         return error;

Looks like a reasonable API.

> @@ -2862,7 +2862,7 @@ void restore_user_sigmask(const void __user
> *usigmask, sigset_t *sigsaved)
>         if (signal_pending(current)) {
>                 current->saved_sigmask = *sigsaved;
>                 set_restore_sigmask();
> -               return;
> +               return 0;

Shouldn't that "return 1" if a signal is pending?
