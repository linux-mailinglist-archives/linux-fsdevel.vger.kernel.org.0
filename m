Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF15B5731
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiILJaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILJaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:30:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C4E0B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 02:29:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so18760927ejy.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=46+jGyJPnqV30BHK03N0JMAGDfZXj5oRazAZMY1f87I=;
        b=bpJgBIuHFrzAEbfrmwF4W0uJscuQIM2ByEYMpDwrF6UUK2zPUBrMZFcxP59WlgU6vT
         m6e6wwgKHzbAvSlL7kFcpudvZZH1w4ju1zKrz/gaLPB+O2ep/aAaPa73AcPiVQi0sR9E
         QhPticcZO5tOAMNtHFbeOvNth6r0sb3sA+794=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=46+jGyJPnqV30BHK03N0JMAGDfZXj5oRazAZMY1f87I=;
        b=u/m5ndJvM4grJpqLDdH1PuOt58OS3btVQnErCF6bl5gyngyhXex8j4eKI4+moxeZ3n
         oRNtYqdxBkqYqbdFCGJREwyyg59XbOyr1Vy3785sYHNRDzrJfm7JjxfJ9B7G8OcEZ4zE
         gv2Q0gZMe4iqHEBKBBltpi+Duj9sy7A3GjAlwTaERg2a1gp6zKCeCJ3ApvcYs5PANmqv
         lCIaLhgB9yvqWpzPJ0cpk1HdJC3PrSPLrnTXzsbeUMMz67LQ8PJGWrkG6l16To7iQtJm
         jsz0tQ0hiLQV5yBptGTDVVUi1sXk7S1GR5nh69c2n1NfvVJCs9PCbB5aBrGonX3mD9sU
         VdEA==
X-Gm-Message-State: ACgBeo3M05DpZ8C+7ADEx33SB6f477pwNwSbdY/YstLXIdqNtyV9o6fB
        NSdHH8gh0YDrHnRoQiujMheqqt/8hRAkf5guS70rQA==
X-Google-Smtp-Source: AA6agR4csRvJsoipDTpL92jm117+j7gacvMXLZ1PwI3rgdZPZ4weDaNAYWJDMZe3FKniLKVOfIPBXHNvwHNnX0t3VU0=
X-Received: by 2002:a17:907:7f0b:b0:731:b81a:1912 with SMTP id
 qf11-20020a1709077f0b00b00731b81a1912mr18271357ejc.8.1662974992623; Mon, 12
 Sep 2022 02:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com> <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Sep 2022 11:29:41 +0200
Message-ID: <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrote:

> I think we should accept the fact that just as any current FUSE
> passthrough (in userspace) implementation is limited to max number of
> open files as the server's process limitation, kernel passthrough implementation
> will be limited by inheriting the mounter's process limitation.
>
> There is no reason that the server should need to keep more
> passthrough fd's open than client open fds.

Maybe you're right.

> If we only support FOPEN_PASSTHROUGH_AUTOCLOSE as v12
> patches implicitly do, then the memory overhead is not much different
> than the extra overlayfs pseudo realfiles.

How exactly would this work?

ioctl(F_D_I_P_OPEN) - create passthrough fd with ref 1
open/FOPEN_PASSTHOUGH -  inc refcount in passthrough fd
release - put refcount in passthrough fd
ioctl(F_D_I_P_CLOSE) - put ref in passthrough fd

Due to being refcounted the F_D_I_P_CLOSE can come at any point past
the finished open request.

Or did you have something else in mind?

> > One other question that's nagging me is how to "unhide" these pseudo-fds.
> >
> > Could we create a kernel thread for each fuse sb which has normal
> > file-table for these?  This would would allow inspecting state through
> > /proc/$KTHREDID/fd, etc..
> >
>
> Yeah that sounds like a good idea.
> As I mentioned elsewhere in the thread, io_uring also has a mechanism
> to register open files with the kernel to perform IO on them later.
> I assume those files are also visible via some /proc/$KTHREDID/fd,
> but I'll need to check.
>
> BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> coming Tuesday [1].

At first glance it looks like a filtered kernel-only passthrough +
fuse fallback, where filtering is provided by eBPF scripts and only
falls back to userspace access on more complex cases.  Maybe it's a
good direction, we'll see.  Apparently the passthrough case is
important enough for various use cases.

Miklos
