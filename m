Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB0485AF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiAEVra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 16:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbiAEVrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:47:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF1C061245;
        Wed,  5 Jan 2022 13:47:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so396921pji.3;
        Wed, 05 Jan 2022 13:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXiynHfff1QyF0kCg/WK+39NSHycE0ztcW8/CVkTVZM=;
        b=mfMSLyIf3L2aI8kNRaikm3oksBjAqBiunrJwRV35L5TRuqDs3ccaJmDyXqjYpauqRU
         thnDTlMs+sbaPVD6JOsnbnMi0dss2rugbgpoHKzQ90E82kv+6X9sphMneP4cxTz/dGak
         zbB9mykmpixaCb0ecoemKNWcOR/e0dOf8wH4FxTVzRDzTsbVFfiIs/0E9mppEl2I9J/L
         h/bG+MPa4+yFqHK3Ak1wcBEMS11CCT3+g9UhXE8wyQtKGNO5FcYGbxIZ7GKhwdDb6dCG
         d4dmL6BY6TgP1ZwKKbUh+spoS7py6f+qCFtEM4wgkAfKMviCG7pF48XMs0YR49wegJ+S
         gTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXiynHfff1QyF0kCg/WK+39NSHycE0ztcW8/CVkTVZM=;
        b=sChHUjHGhKHLaVRAlK/UXYIa1STi20cHQ/5w8fZR0Iy/JsNPXnajMLoohtLAbPN0uN
         kGiEvo7SIvk9eZL0kPFGRAiFau7Jw1c4BDtZtx3pOi5vaWJoKfgdwf9B+c8sEiGZmunk
         Xc2VnHEVzbUFXqMfecwL/t7yDVpqwQJfpatSyRuxZRRG0VQVqVRiZd0IMeUoUpHdJFXu
         qnNQVja8RH4C6xqMvPdVnzjI+nmMrmmFrEU2SdZxsYhpUmoo/qC4ionwGuY0nKNsCWmC
         gxhv71KGCVeswoqBs54tYLYF/js+w7t5abI/RFoDV9R6AuKNCgMfemY/qo6J9cTkZvTY
         iNzA==
X-Gm-Message-State: AOAM5322TUxZRXN5lzNHsqRTykFTloi2Ia5mR7hkWLvP8tJWZvlA1z/W
        yMS2Vvi1zY0Q2BJl992CYyzqApPQe1KhuEqJqL4=
X-Google-Smtp-Source: ABdhPJwHFuUGSbUZ7sqlq6GcSKsSc1ildEHYHDGdnIxlCiTdfDDxMW2u4hnH2n62y7jrKV0l6Q3PVNBj41QAoVuUcuE=
X-Received: by 2002:a17:902:e149:b0:149:9b8e:1057 with SMTP id
 d9-20020a170902e14900b001499b8e1057mr33484968pla.144.1641419238758; Wed, 05
 Jan 2022 13:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20220104171058.22580-1-avagin@gmail.com> <77862a7a-3fd2-ff2b-8136-93482f98ed3c@gmail.com>
In-Reply-To: <77862a7a-3fd2-ff2b-8136-93482f98ed3c@gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 5 Jan 2022 13:47:08 -0800
Message-ID: <CANaxB-zM1EhPR1f4tubCQTMEMAuRAtAWYZsWFTVhfeqYMHhKdg@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 4, 2022 at 10:54 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> On 1/4/22 17:10, Andrei Vagin wrote:
> > Right now, kcalloc is used to allocate a pipe_buffer array.  The size of
> > the pipe_buffer struct is 40 bytes. kcalloc allows allocating reliably
> > chunks with sizes less or equal to PAGE_ALLOC_COSTLY_ORDER (3). It means
> > that the maximum pipe size is 3.2MB in this case.
> >
> > In CRIU, we use pipes to dump processes memory. CRIU freezes a target
> > process, injects a parasite code into it and then this code splices
> > memory into pipes. If a maximum pipe size is small, we need to
> > do many iterations or create many pipes.
> >
> > kvcalloc attempt to allocate physically contiguous memory, but upon
> > failure, fall back to non-contiguous (vmalloc) allocation and so it
> > isn't limited by PAGE_ALLOC_COSTLY_ORDER.
> >
> > The maximum pipe size for non-root users is limited by
> > the /proc/sys/fs/pipe-max-size sysctl that is 1MB by default, so only
> > the root user will be able to trigger vmalloc allocations.
> >
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
>
> Good idea!
>
> I wonder if you need to apply this on the top:
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 45565773ec33..b4ccafffa350 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -605,7 +605,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned
> long arg)
>  {
>         struct pipe_inode_info *pipe = filp->private_data;
> -       int count, head, tail, mask;
> +       unsigned int count, head, tail, mask;
>
>         switch (cmd) {
>         case FIONREAD:
> @@ -827,7 +827,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
>
>  void free_pipe_info(struct pipe_inode_info *pipe)
>  {
> -       int i;
> +       unsigned int i;
>
>  #ifdef CONFIG_WATCH_QUEUE
>         if (pipe->watch_queue) {
> --->8---
>
> Otherwise this loop in free_pipe_info() may become lockup on some ugly
> platforms with INTMAX allocation reachable, I think. I may be wrong :-)

This change looks reasonable, it makes types of local variables consistent
with proper fields of pipe_inode_info. But right now, the maximum pipe size
is limited by (1<<31) (look at round_pipe_size) and so we don't have a real
issue here.

Thanks,
Andrei
