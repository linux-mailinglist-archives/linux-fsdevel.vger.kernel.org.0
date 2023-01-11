Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F26664AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 21:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjAKUQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 15:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjAKUQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:16:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182EF9FCA
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 12:16:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b4so4487381edf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0s7NL4TKaIi7w5aidX/B8AlJEfhOE5GT6g2KKEIusiQ=;
        b=FLIry7/6rG5x7cD3DYe7jdBkSStNP+8Na3dvj/OvlhhvXJx0Oq5Xh/qrEofMd2d+I5
         EUjtvDJ2k3KdCI5hnlkwhQAUFrUeFN5RHHdK/J2MSMseZVbx3jJQ1ijYrQmRATTfcK9x
         0zGNeiHkWB6S0ixXsDfgqvHmtlmttzD4X8qvXrregII4wtfL5Aa3TTjfRGpkbJoTaigc
         Nhq78q72WguqenGX8MP0sZHJY3AwLwilKeME+CaylrxOElFqAaYeLrxY4zeTESwxUgtm
         XIPE7CG3IzMrUTpCf7cKgdPVrSpfH43islA661d/YlBAVGsUjiA1dihK2GS1VDyvrI9G
         xU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s7NL4TKaIi7w5aidX/B8AlJEfhOE5GT6g2KKEIusiQ=;
        b=augdRQ0WFZMwGpmA6G+lkPtXuuTOfnmUcIswiePAf1TGRyyCTAD/UjHS2rEGI3xny5
         HvRbc5gZ+hdiYg2dsvt5aOke7NPFMt+vhcR1H6pooGGmoDXXotpS9kaDLiB7sG0LMtXa
         aJ9Y4fRTPgC9ooB9m76e/5j6WpS4j9NESTlBx2UzzACB5Z90MRvw4HtV9av+A2i1Etna
         CZI8DnHzC8zqtOvJtuZ3JxUYR6hVvqwOmc+p97biLDPSlUJg/gfZ3tvLBNsafML0AYum
         pZMR+iCm4JrcHLCAHJImfiYMonavrqOAKJB2XWfP+2Ypa7tSKm3mq2AAzLYrwE+Kg1Mp
         e5HQ==
X-Gm-Message-State: AFqh2kosip0RDGFxQ0Db6oXQ8XOnGmoqa6augKfde1WlY5v+69X3FCgx
        4867d2u5k5zpFWvN55nd6ISw05r2WQjBbt8lBoYs3w==
X-Google-Smtp-Source: AMrXdXta5+OHjZj4CT01QDGcQ7Upnn9OjpR4qdZBEeSHD3FhaBc69XEpNuBXrI7p1TGki6ZwuWUu1qZ1HFO/sIV6450=
X-Received: by 2002:aa7:cd8c:0:b0:483:a754:8788 with SMTP id
 x12-20020aa7cd8c000000b00483a7548788mr7413946edv.218.1673468210511; Wed, 11
 Jan 2023 12:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20221104212519.538108-1-sethjenkins@google.com> <x49tu0wlv0c.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49tu0wlv0c.fsf@segfault.boston.devel.redhat.com>
From:   Seth Jenkins <sethjenkins@google.com>
Date:   Wed, 11 Jan 2023 15:16:38 -0500
Message-ID: <CALxfFW5d05H-nFuDdUDS4xVDKMgkV1vvEBAmw10h3-jMVb-PZw@mail.gmail.com>
Subject: Re: [PATCH] aio: fix mremap after fork null-deref
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pavel Emelyanov <xemul@parallels.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I wonder if it would be better to not copy the ring mapping on fork.
> Something like the below?  I think that would be more in line with
> expectations (the ring isn't available in the child process).

I like this idea a lot, but would this be viewed as subtly changing
the userland to kernel interface?

If we're okay with this change though, I think it makes sense.


On Wed, Jan 11, 2023 at 2:37 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Seth,
>
> Seth Jenkins <sethjenkins@google.com> writes:
>
> > Commit e4a0d3e720e7 ("aio: Make it possible to remap aio ring") introduced
> > a null-deref if mremap is called on an old aio mapping after fork as
> > mm->ioctx_table will be set to NULL.
> >
> > Fixes: e4a0d3e720e7 ("aio: Make it possible to remap aio ring")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Seth Jenkins <sethjenkins@google.com>
> > ---
> >  fs/aio.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 5b2ff20ad322..74eae7de7323 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -361,16 +361,18 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
> >       spin_lock(&mm->ioctx_lock);
> >       rcu_read_lock();
> >       table = rcu_dereference(mm->ioctx_table);
> > -     for (i = 0; i < table->nr; i++) {
> > -             struct kioctx *ctx;
> > -
> > -             ctx = rcu_dereference(table->table[i]);
> > -             if (ctx && ctx->aio_ring_file == file) {
> > -                     if (!atomic_read(&ctx->dead)) {
> > -                             ctx->user_id = ctx->mmap_base = vma->vm_start;
> > -                             res = 0;
> > +     if (table) {
> > +             for (i = 0; i < table->nr; i++) {
> > +                     struct kioctx *ctx;
> > +
> > +                     ctx = rcu_dereference(table->table[i]);
> > +                     if (ctx && ctx->aio_ring_file == file) {
> > +                             if (!atomic_read(&ctx->dead)) {
> > +                                     ctx->user_id = ctx->mmap_base = vma->vm_start;
> > +                                     res = 0;
> > +                             }
> > +                             break;
> >                       }
> > -                     break;
> >               }
> >       }
>
> I wonder if it would be better to not copy the ring mapping on fork.
> Something like the below?  I think that would be more in line with
> expectations (the ring isn't available in the child process).
>
> -Jeff
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 562916d85cba..dbf3b0749cb4 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -390,7 +390,7 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
>
>  static int aio_ring_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -       vma->vm_flags |= VM_DONTEXPAND;
> +       vma->vm_flags |= VM_DONTEXPAND|VM_DONTCOPY;
>         vma->vm_ops = &aio_ring_vm_ops;
>         return 0;
>  }
>
