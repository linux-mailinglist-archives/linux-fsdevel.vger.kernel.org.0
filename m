Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06778C397F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfJAPuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 11:50:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44746 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfJAPuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:50:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so22204792qth.11;
        Tue, 01 Oct 2019 08:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0o++jJaVMAjjHeJdMlrBP61n3JOH5eAFGBT8AaVnQtI=;
        b=JImTDk9BFabrTYzGsZxRhQkAtC56salUjl1NvtNgWWrgVw+NT5o0PQw46fdG2g7zjW
         AFRYG81Ifya4Di0EkhsSLn0plgPKO22kHtiNkxtkZUkRgMicjD39vqlfHfEmqX3EJ8Bo
         rYglfnraCWr1aDD0dhYT5YSFemGtVAmWWQOkkON4rSQBsjdexZNJDGAJI10ptQoghATa
         9ZUHS7hTdgUjyeN5un7dcLjAsDS0/6A7wcE/i6d6kfVLZIh+HgAjjjhg5bB3Gq5JNTDT
         Vr/OScTMira8w/URINPg/xiqUhunWvP2o7zzuGcY4E8Vk5v240kCtQN+W9yT31iJyORV
         hhNw==
X-Gm-Message-State: APjAAAV/mVjOskGg4hddojn/b/7RObuaAovuX9wwhl0a4YbdkTy+X3sW
        KdTRd/oqyzsF52rxx2RThARoqC8HIb28e6Kc5gc=
X-Google-Smtp-Source: APXvYqypsS82qtB6iytpnzukSbXyBszcU5NeOymfFRAU5FNK8ULw8UBOaqSfO8Az8u+dnJ3bihbzP6GMsMCzBI/xQzY=
X-Received: by 2002:aed:2842:: with SMTP id r60mr30909299qtd.142.1569944999630;
 Tue, 01 Oct 2019 08:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190930202055.1748710-1-arnd@arndb.de> <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
 <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
In-Reply-To: <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 17:49:43 +0200
Message-ID: <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Jens Axboe <axboe@kernel.dk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=C3=BChler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/1/19 8:09 AM, Jens Axboe wrote:
> > On 9/30/19 2:20 PM, Arnd Bergmann wrote:
> >> All system calls use struct __kernel_timespec instead of the old struct
> >> timespec, but this one was just added with the old-style ABI. Change it
> >> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
> >> the need for compat handlers on 32-bit architectures.
> >>
> >> Any user space caller will have to use __kernel_timespec now, but this
> >> is unambiguous and works for any C library regardless of the time_t
> >> definition. A nicer way to specify the timeout would have been a less
> >> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
> >> change that as this would impact both 32-bit and 64-bit users.
> >
> > Thanks for catching that, Arnd. Applied.
>
> On second thought - since there appears to be no good 64-bit timespec
> available to userspace, the alternative here is including on in liburing.

What's wrong with using __kernel_timespec? Just the name?
I suppose liburing could add a macro to give it a different name
for its users.

> That seems kinda crappy in terms of API, so why not just use a 64-bit nsec
> value as you suggest? There's on released kernel with this feature yet, so
> there's nothing stopping us from just changing the API to be based on
> a single 64-bit nanosecond timeout.

Certainly fine with me.

> +       timeout = READ_ONCE(sqe->addr);
>         hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         req->timeout.timer.function = io_timeout_fn;
> -       hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
> +       hrtimer_start(&req->timeout.timer, ns_to_ktime(timeout),

It seems a little odd to use the 'addr' field as something that's not
an address,
and I'm not sure I understand the logic behind when you use a READ_ONCE()
as opposed to simply accessing the sqe the way it is done a few lines
earlier.

The time handling definitely looks good to me.

       Arnd
