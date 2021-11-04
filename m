Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105E44516F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhKDKOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhKDKOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:14:42 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16814C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 03:12:05 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id i6so9782708uae.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npUL6ogiVQVWa9iv8H83xLSjxFJa7Ti+n/AUJ/ncmwQ=;
        b=nAFUTQuuf07bWbDb6ogWSd8rETGHuUk455hsAzvUkcwIL15LHNEvtq0HghFbsvuyEr
         FLKwhEFAmgEw5CYOjSk/5kiVu/w8V0J50Sk2oZoj5F2iEaojsdXVuF2Td/Z/m90j4Hz/
         W+zP5voc/KWVdvBgcqJ1f9Nan8Y3cRwyBBJ8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npUL6ogiVQVWa9iv8H83xLSjxFJa7Ti+n/AUJ/ncmwQ=;
        b=0+AS19Nswe+5FLyjQiP1db+HSIgomrlrJZcKXb1B+XYAJ20qic8jOFJb02VGKc32+U
         ME5ibf7E7bdF8ZdkW8scaedm3QKGgb8fXmvlJc+dCmaXhAEf83tYjoEfXXLYU90YrVR9
         SJv6E4IYzop5joHJ7pWfJCHgyGAmwBBwTMom0fmsH/tm3wW3w/qhUZXWtwKJiCboxhl3
         wOKtTGZ0C83mLJ34YetAfxPIpVZ8zyIQrJ0km7PIcPVxUEgEfvGAPSvOBOANl0tJ5X8M
         pSZI7EkOWYxW4wweuGrAbCKpKn40eavCD03vyvdh8BTFS+R7WzOzI1rT5zAwq0zij5nN
         vKrg==
X-Gm-Message-State: AOAM5323pvTAHJujE6aUdmJrPrtTByG2LVizMa46EbphUDzC6MA4lydM
        Oa1dy+JxXIDcnH90PY/sYg549bMoSDkdK58ZjpYH9w6eqjp/EA==
X-Google-Smtp-Source: ABdhPJwoU6jwUiUHT5+LzBju9GUI1nkXrbqfE9n32Cis0lgG63r+14hs59V+bnx/c7wx3u6mKdadbytRpXcxPeuKdtw=
X-Received: by 2002:ab0:25da:: with SMTP id y26mr30021364uan.72.1636020724251;
 Thu, 04 Nov 2021 03:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211104042037.GA7088@ubuntu-PC>
In-Reply-To: <20211104042037.GA7088@ubuntu-PC>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Nov 2021 11:11:53 +0100
Message-ID: <CAJfpegvP8B9YEXXxEk=6vHpfsuAhoM0jHf8oqZXXB4cUmVRXyA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add tracepoints for request
To:     Lianjun Huang <hljhnu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 4 Nov 2021 at 05:20, Lianjun Huang <hljhnu@gmail.com> wrote:
>
> Change-Id: I361d582f30a04040969f1774064d5d1a4b646389
> Signed-off-by: Lianjun Huang <hljhnu@gmail.com>
> ---
>  fs/fuse/dev.c               |  4 ++++
>  include/trace/events/fuse.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 include/trace/events/fuse.h
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9d2d321bd60b..83f20799683d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -23,6 +23,8 @@
>  #include <linux/splice.h>
>  #include <linux/sched.h>
>  #include <linux/freezer.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/fuse.h>
>
>  MODULE_ALIAS_MISCDEV(FUSE_MINOR);
>  MODULE_ALIAS("devname:fuse");
> @@ -323,6 +325,7 @@ static u64 fuse_get_unique(struct fuse_iqueue *fiq)
>
>  static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
>  {
> +       trace_fuse_info(req->in.h.opcode, req->in.h.unique, req->in.h.nodeid, "queue request");

I'm very much reluctant to add tracepoints to fuse at all.

Fuse protocol is traceable on the syscall interface (with strace) so I
don't see how this adds any value.

Can you please explain why you need this and why is tracing on the
userspace ABI not sufficient?

Thanks,
Miklos
