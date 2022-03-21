Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C714E236C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 10:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbiCUJiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbiCUJh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:37:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4763BEE
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 02:36:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so28499024ejc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogrhRXR+AVdt3mfgPz8CUVBxI7B5+eAIXFaggH9T3eY=;
        b=JTdeK1AYQxPLk0QC4MPXc65N/+9KLmUz6bikgdSXHUYI1p9r2xyaAC87MAdfYFwnjX
         SBcIYVRVP+XrwcjVGS++LI/xdkXEGR/RfOz7lYc9NYGt5ThG2cWE7ZZrlTctS0fsSm4n
         iHHZnYjhB4CoSF55F68VVh93gpvkr+4GcL2jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogrhRXR+AVdt3mfgPz8CUVBxI7B5+eAIXFaggH9T3eY=;
        b=dIyHDDpJbH+dbivExdn5tmIheKdjc9Do/LZ9uPIoOkN+q5HgxLpcg2UHHzMiBiDJ/W
         R78+9hBKmZGtVHJ6IYknjn3kCH/b4lE5Dthj7LQ6BMsOIO7JsBts9rdjnOUmSkWkRLFo
         M3pCYKdUT2RNOE01iAHu212T0uGV76mogAOHIFrC89IUdHSr7wzk+zwwYbWw2pMt7fhI
         p0V+U0Fw0XZCjOqd1aKKphfxOtNbKBsJHZUm1Kb+6gxtawTlcJ0Ootv0krNIxgcwDft1
         nBD6jtUoujhp/d3dA9UPvoChmz1iar1v+iyhRDhNSxjmXLMOwe7UhlgXaQ7tNHhmYXmN
         fz2w==
X-Gm-Message-State: AOAM5304/diM89zBTYXZKBoPY9/ZAZXANJJqBoFFlHo13H3Q/0XeVG6t
        Ke9uCSuZo9hSpukpTLvbtSeyUYzGO7CgIGrd0gH+tg==
X-Google-Smtp-Source: ABdhPJw/xfXVim0fva3bC9a3lXSZs/6Jqd/qOjzzPhc6BW9eY8sIeleI+X0vFnNDwscOC3H/fugKA3B7QsQkWDW0q+M=
X-Received: by 2002:a17:906:c259:b0:6ce:a165:cd0d with SMTP id
 bl25-20020a170906c25900b006cea165cd0dmr19443119ejb.270.1647855392023; Mon, 21
 Mar 2022 02:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com> <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com> <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
 <Yjg8TVQZ6TeTSQxj@kroah.com>
In-Reply-To: <Yjg8TVQZ6TeTSQxj@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Mar 2022 10:36:20 +0100
Message-ID: <CAJfpegsj94__xdBe8aH+VFdY5fJg515vG0XY-Qu0RXwEAUhM3A@mail.gmail.com>
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

On Mon, 21 Mar 2022 at 09:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 21, 2022 at 09:40:56AM +0100, Miklos Szeredi wrote:
> > On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > > > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > > > >
> > > > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > > > all the definitions in this header to use the correct type. Previous
> > > > > discussion of this topic can be found here:
> > > > >
> > > > >   https://lkml.org/lkml/2019/6/5/18
> > > >
> > > > This is effectively a revert of these two commits:
> > > >
> > > > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > > > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> > > >
> > > > And so we've gone full circle and back to having to modify the header
> > > > to be usable in the cross platform library...
> > > >
> > > > And also made lots of churn for what reason exactly?
> > >
> > > There are currently only two uapi headers making use of C99 types and
> > > one is <linux/fuse.h>. This approach results in different typedefs being
> > > selected when compiling for userspace vs the kernel.
> >
> > Why is this a problem if the size of the resulting types is the same?
>
> uint* are not "valid" variable types to cross the user/kernel boundary.
> They are part of the userspace variable type namespace, not the kernel
> variable type namespace.  Linus wrong a long post about this somewhere
> in the past, I'm sure someone can dig it up...

Looking forward to the details.  I cannot imagine why this would matter...

Thanks,
Miklos
