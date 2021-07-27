Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAC3D81ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 23:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhG0Vji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0Vjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:39:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264ECC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 14:39:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z2so11306lft.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=586qQ0VfqS2t1FgawENmqvW9B/cgMqgnCEiHKLyzI/E=;
        b=u1/MVJO4zcfaei7PD7eWb+709nz15VrWARci7ePDMDFolJNUERP2wsbjom+4NbVKF7
         ssCxzxA0a2UMxu67QqmKkzf8Ut6ydxeIlIqw2blw57FpMzpCZ3PC+AX7TZdUAx0tipyl
         G8luFgvQvburMncuoSBNoiciSrzOHj4b5hjw5HfttQCJX69lVCqpmjGkRnGShNJwduXw
         Zh8TM0wbJKBTwe0RiYKQ6DlcLgR+hq+p9L+JSK8/8r1bCXiy6mY+G/ZI55irmnQDLRxC
         ZeISUoXD1z4L5Wyc48m90u3UbQaFELITPkCenCYevX5lJ/OgtMDHFVm6vd5w9iw29W+4
         Bw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=586qQ0VfqS2t1FgawENmqvW9B/cgMqgnCEiHKLyzI/E=;
        b=ZspkPLxVQ/SKd93PRgwtshOhqSf3A1mP08127n4ir0ldQJbGGd+udfRHgpbzEdvPL0
         U8oVO9idA27y1TEFClAiZcLXPB9iMXzQt90FytWYYjIy99nrxDSHXB6d6OCY48efhjIx
         IJkZO1LdZ0JzNUSn/149eii2SSnfIH1cu8PVHXMMtqh1mXnl0b4xoTqcJUh5eqb7lcVC
         d/eUuIEB27GlV/QcPXS7XOuVbfGNnq4BWWHuZi+SIilOYPlLLQc9w/MzKej9AjLHcLAY
         wrk4kqIhFXAEoBytj6KnRAjVKSBigzUSvPMu9NVd8UFWLxJq/KrLR1AczTPUBOiUHff5
         SkBw==
X-Gm-Message-State: AOAM532sksWrEfmm6j0Ftj9zVFWsIQuBubZqq9CVM5ibGONXxJN8hZDe
        2KBvUBRX9WF5ac3jEEaymaN+8Xe4VYh20mdkdWwbOg==
X-Google-Smtp-Source: ABdhPJwwdSCswMAky7kROjCs9+RNQPi2B9KOACTRASBYz1YEPyZkM5BZYLuBNqCTFu4siT0t1TDHb1BYSgpDsRxP1UA=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr18055453lfc.117.1627421974281;
 Tue, 27 Jul 2021 14:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <56e31cb5-6e1e-bdba-d7ca-be64b9842363@virtuozzo.com>
In-Reply-To: <56e31cb5-6e1e-bdba-d7ca-be64b9842363@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:39:23 -0700
Message-ID: <CALvZod7e8pNhCU-o8-dFwn5v4aVoUrxxjGamfbaqK83d3UL1Mw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] memcg: enable accounting for pollfd and select
 bits arrays
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> User can call select/poll system calls with a large number of assigned
> file descriptors and force kernel to allocate up to several pages of memory
> till end of these sleeping system calls. We have here long-living
> unaccounted per-task allocations.
>
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/select.c b/fs/select.c
> index 945896d..e83e563 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -655,7 +655,7 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>                         goto out_nofds;
>
>                 alloc_size = 6 * size;
> -               bits = kvmalloc(alloc_size, GFP_KERNEL);
> +               bits = kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);

What about the similar allocation in compat_core_sys_select()? Also
what about the allocation in poll_get_entry()?

>                 if (!bits)
>                         goto out_nofds;
>         }
> @@ -1000,7 +1000,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>
>                 len = min(todo, POLLFD_PER_PAGE);
>                 walk = walk->next = kmalloc(struct_size(walk, entries, len),
> -                                           GFP_KERNEL);
> +                                           GFP_KERNEL_ACCOUNT);
>                 if (!walk) {
>                         err = -ENOMEM;
>                         goto out_fds;
> --
> 1.8.3.1
>
