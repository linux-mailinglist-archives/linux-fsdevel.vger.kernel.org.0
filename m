Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA234E2537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 12:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbiCUL1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiCUL1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:27:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2768CCD7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 04:25:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b24so17391704edu.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYElWt28OV4l4Pg/zIOMJ8LQZ2S7IKGmpM9ISCKQBDE=;
        b=npwWzu5N48vknY6NHB2C7E6/+OFdUg3W1HDsAdrkUfdP158PeCwhT1Ozq/9abPseT3
         NRFKApmGvHtfi5YlKBfRytE2oBE43iCM4HGC/Obj1VCn5pqBqehkBzu7VoKVUwqoHKEq
         nO9zBB6+7qgYt9XWHTA3t1JMBddciGsvhW0jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYElWt28OV4l4Pg/zIOMJ8LQZ2S7IKGmpM9ISCKQBDE=;
        b=B8Qcgkx4lWkRyY4T63cvVLN2okPwKP8qnYuUk6GHRHfdFwToR63Iu/ND0eCUd65Im3
         y/S6kL/r/RMgi3fRzFE+RP3pS+x3mcC3ew0nn98McSz1fcpbLALrDsDhohha/hnQSkI4
         njqrPHzbec+DIUrrawGGugXDMKAG9e4Sm9FkLgBsY5GFgn6qnjZoU068USGKSJqXiU3N
         zddUD9gZ7w5oZWQ2FfOyKUOY5itVa0Pa1jp3DwZdd1u7XfeeLWA3JZ1Cba+dLn8DNXKc
         2z0lLoxm6AmP2/I2WgFlFCvD10IOI+uKZc6F9Dt8FmXT2r+h6Epppji1gBk5jiXRrDhK
         cn0Q==
X-Gm-Message-State: AOAM532VhYr11dahsmMSshGPOSXchfCxQlQeGHSXoLHVINn2pamyP9dC
        8fYw74n5BP79OK9D9JBOr80vdqfXP5vGC/ehh0fjFw==
X-Google-Smtp-Source: ABdhPJy98AU0wSJYSzNqjv1GKD7tN1dJ/RH/tWyYV5gZdnzm8wsXgjUEsCGQqsx9x0p0oF9rfPo156RJglU6pDqfwrY=
X-Received: by 2002:aa7:df99:0:b0:419:2823:4c23 with SMTP id
 b25-20020aa7df99000000b0041928234c23mr9210600edy.341.1647861939043; Mon, 21
 Mar 2022 04:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com> <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com> <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
 <Yjg8TVQZ6TeTSQxj@kroah.com> <CAJfpegsj94__xdBe8aH+VFdY5fJg515vG0XY-Qu0RXwEAUhM3A@mail.gmail.com>
 <YjhM9UMKs+1H8eIe@kroah.com>
In-Reply-To: <YjhM9UMKs+1H8eIe@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Mar 2022 12:25:27 +0100
Message-ID: <CAJfpegtpHLjL3fEu+CciBdkOptk23jV2qKCMc4AwEjgmASgbBA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Mar 2022 at 11:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 21, 2022 at 10:36:20AM +0100, Miklos Szeredi wrote:
> > On Mon, 21 Mar 2022 at 09:50, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 09:40:56AM +0100, Miklos Szeredi wrote:
> > > > On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
> > > > >
> > > > > On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > > > > > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > > > > > >
> > > > > > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > > > > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > > > > > all the definitions in this header to use the correct type. Previous
> > > > > > > discussion of this topic can be found here:
> > > > > > >
> > > > > > >   https://lkml.org/lkml/2019/6/5/18
> > > > > >
> > > > > > This is effectively a revert of these two commits:
> > > > > >
> > > > > > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > > > > > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> > > > > >
> > > > > > And so we've gone full circle and back to having to modify the header
> > > > > > to be usable in the cross platform library...
> > > > > >
> > > > > > And also made lots of churn for what reason exactly?
> > > > >
> > > > > There are currently only two uapi headers making use of C99 types and
> > > > > one is <linux/fuse.h>. This approach results in different typedefs being
> > > > > selected when compiling for userspace vs the kernel.
> > > >
> > > > Why is this a problem if the size of the resulting types is the same?
> > >
> > > uint* are not "valid" variable types to cross the user/kernel boundary.
> > > They are part of the userspace variable type namespace, not the kernel
> > > variable type namespace.  Linus wrong a long post about this somewhere
> > > in the past, I'm sure someone can dig it up...
> >
> > Looking forward to the details.  I cannot imagine why this would matter...
>
> Here's the huge thread on the issue:
>         https://lore.kernel.org/all/19865.1101395592@redhat.com/
> and specifically here's Linus's answer:
>         https://lore.kernel.org/all/Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org/
>
> The whole thread is actually relevant for this .h file as well.  Some
> things never change :)

"- the kernel should not depend on, or pollute user-space naming.
  YOU MUST NOT USE "uint32_t" when that may not be defined, and
  user-space rules for when it is defined are arcane and totally
  arbitrary."

The "pollutes user space naming" argument is bogus for fuse, since
application are using the library interface, which doesn't pull in the
kernel headers but redefines everything that needs to be shared.   BTW
this seems to be the pattern for libc interfaces as well, though I
haven't looked closely.

On the other hand, if we change the types back to __u32 etc, then that
will mess with the history.  I think the disadvantages outweigh the
advantages, so unless some stronger argument comes up  it's NACK from
me.

Thanks,
Miklos
