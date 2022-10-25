Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFA60D3B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiJYSlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiJYSlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:41:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9C5D731
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:41:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so23765544lfb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xic7gGyYK1bMYi722XUjEgw/ooiCzr+pIbqoSO8NDRo=;
        b=aZgHxvMfwJ1olBwV8cAMVsKtPPAzzxy3eA4ChXpE/VRlo0EuGEJTMzdmytz8/t08Vm
         r4GJ+AVphs7+/SKbtLWCgaYjzQN+j/aL1TCn4OoY8aUZ5Sg+tGYnd2O/QLdsTzfL9Id2
         Pgeu4W2hsTZXwSKo/hKoSbuxEzF6MYzdzDIvWWsm4T7hQDGHMo0uuMnd0MCx6nZyx9++
         MfBvYRzGXnY0lz97nYV/JOmorutODOVYsvocqjZ8xqderGYs0WBekp5em0fEkbXePaU5
         /Jf8/uC49gfqNGAlGGqNvVRZe8FQMGoq+h436UXtvfMtYjE2a1QLl5DDJbMaiJ/cH2ty
         T3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xic7gGyYK1bMYi722XUjEgw/ooiCzr+pIbqoSO8NDRo=;
        b=sMyB7EYFo3D+iBkJ8XqdI8wkg0fzH8Te5UocnS+0JHJxyhnIuzSBTVOijWjUJUba/H
         DepOhdK4NJFFcCgmCZrZcGvy9TNKEfh5BTvZ9zO+yNdR6ASSMJ8uC3xdl5Pi2u4C8QhW
         EuDo6xIjKaxvv8f4DhdcnnLlckMcL2mHkxR3b+eNOLFpRIDO1yTee+qjTN7xCoeYOcXz
         0WpH6BZqdtPbZwAF6nAKVyW8JvmOGBkbxSU2exlzky6nkd/YbpFApv8XecgQh9RuHJpb
         52rQF7w/7ds28ym8tNL/VptnHvjQ/SaKUhIN4ZL+GW+s5DsNhVE7DOOj4ysXeTWH4QZW
         V1hw==
X-Gm-Message-State: ACrzQf0orf4/AU7DjeyCHmlOo3j7svdDpc0Ae5n4c8TrSx7anknTakfp
        STqRLcE6xmVgi8hUzmJOxtuJ0Ybk1ZqtkMyd0jASoQ==
X-Google-Smtp-Source: AMsMyM4g/Ie1qYCF9xqy2RpPbNdsVkSl3vxYZm8sW0PZrvZb6zgnsYCduUnUPDC8FVr50wVwKk10/O7YW/HU+eSaSVM=
X-Received: by 2002:a05:6512:3d9f:b0:4a2:4986:281 with SMTP id
 k31-20020a0565123d9f00b004a249860281mr13774047lfv.123.1666723276036; Tue, 25
 Oct 2022 11:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221025182149.3076870-1-axelrasmussen@google.com> <Y1gsKdfXdIzkidpN@x1n>
In-Reply-To: <Y1gsKdfXdIzkidpN@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 25 Oct 2022 11:40:39 -0700
Message-ID: <CAJHvVcg5yr_OhV238vurf4PksSGPSvV_pTpeVWAKcumv-U3VcQ@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: wake on unregister for minor faults as well
 as missing
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Tue, Oct 25, 2022 at 11:34 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 25, 2022 at 11:21:49AM -0700, Axel Rasmussen wrote:
> > This was an overlooked edge case when minor faults were added. In
> > general, minor faults have the same rough edge here as missing faults:
> > if we unregister while there are waiting threads, they will just remain
> > waiting forever, as there is no way for userspace to wake them after
> > unregistration. To work around this, userspace needs to carefully wake
> > everything before unregistering.
> >
> > So, wake for minor faults just like we already do for missing faults as
> > part of the unregistration process.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
> > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 07c81ab3fd4d..7daee4b9481c 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >                       start = vma->vm_start;
> >               vma_end = min(end, vma->vm_end);
> >
> > -             if (userfaultfd_missing(vma)) {
> > +             if (userfaultfd_missing(vma) || userfaultfd_minor(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >                        * we unregister, so they will not hang
> > --
> > 2.38.0.135.g90850a2211-goog
>
> Thanks, Axel.  Is wr-protect mode also prone to this?  Would a test case
> help too?

I'm not quite as familiar with uffd-wp, but I think so? At minimum, it
seems like waking can't *hurt*, and it would simplify the check
slightly -- if (userfaultfd_armed(vma)) {}

It would also mean if we add yet another registration mode in the
future, we wouldn't forget to update this.

I'll send a v2 to address both points.

>
> --
> Peter Xu
>
