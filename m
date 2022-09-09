Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A829F5B3F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIITHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIITHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:07:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0907135D73
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 12:07:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lz22so6201370ejb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Sep 2022 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ziomUJ8TI35yh7PdR/qXu8p5sGWmK9UoF6cvJadWBWM=;
        b=MghIFancLOtXf747iECRdKBzUXqylczjEZGOA1R7N6m/gpq/sCI7pYp7I4Jci7lxKJ
         t24/2Rb1/qORtBmzaWEnbdA5zSbozm0QzJIVqHSXXgLxdyJV8W8fAAKZQrZk/9dJtpTj
         cPdEI0DFeVQ0UKvDPBsgeQBJ3XQdTKqicXlBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ziomUJ8TI35yh7PdR/qXu8p5sGWmK9UoF6cvJadWBWM=;
        b=tLQEoTS2jdtCPCZc6wDg4L5LmucWT5kirX/8eUfVTFX4/ua/YJy0FZJWq5TnQ7aWYr
         gzSJ/EFx2W+fOuPsTpVeiTzzr1ltsh88mxRrsqk7+vyGwxjz0CaviN34fo9uxISUNMZt
         hnuhouF3dh/bUdjttsMSKDaU9Ecfkjk+oE4MEhQrtVAs7f0WhupTbdI3Oc8jrmqBi6hw
         RbSAVUAwrmKObSrEnMR0Hp+AG17t7sczWR1Ayo0p54yS4AAW+v8GBM/VYUL15bERUQoq
         HudpOT5DeMja+uZcH7c4PbkjG87GlCZwCrB2qfc6e4Gj9hF88fFiTqtrwOk2fb+FVYAe
         5Jxw==
X-Gm-Message-State: ACgBeo0Kw1bCf3V9S95L6OtDMcNSdQ8RrNz70E/APEbC3boRrNU+QfKO
        oIKe/W9+AzuPTUWXT0hVjVXzJUStH51wUphR1jP+xA==
X-Google-Smtp-Source: AA6agR72ua4PlvlShquFN7gQ7j8SbgHAY5/KRLp84F1m+JgTROGrfY286jrRS+xZ3vWVctXGYa54vDU/P9ZptiMXeGw=
X-Received: by 2002:a17:907:6d11:b0:730:a382:d5ba with SMTP id
 sa17-20020a1709076d1100b00730a382d5bamr10662487ejc.371.1662750468489; Fri, 09
 Sep 2022 12:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Sep 2022 21:07:37 +0200
Message-ID: <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
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

On Thu, 8 Sept 2022 at 17:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi Alessio and Miklos,
>
> Some time has passed.. and I was thinking of picking up these patches.
>
> On Mon, Mar 1, 2021 at 7:05 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > On Fri, Feb 19, 2021 at 09:40:21AM +0100, Miklos Szeredi wrote:
> > > On Fri, Feb 19, 2021 at 8:05 AM Peng Tao <bergwolf@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 17, 2021 at 9:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > > > What I think would be useful is to have an explicit
> > > > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
> > > > > once the fuse server no longer needs this ID.   If this turns out to
> > > > > be a performance problem, we could still add the auto-close behavior
> > > > > with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.
> > > > Hi Miklos,
> > > >
> > > > W/o auto closing, what happens if user space daemon forgets to call
> > > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE? Do we keep the ID alive somewhere?
> > >
> > > Kernel would keep the ID open until explicit close or fuse connection
> > > is released.
> > >
> > > There should be some limit on the max open files referenced through
> > > ID's, though.   E.g. inherit RLIMIT_NOFILE from mounting task.
> > >
> > > Thanks,
> > > Miklos
> >
> > I like the idea of FUSE_DEV_IOC_PASSTHROUGH_CLOSE to revoke the
> > passthrough access, that is something I was already working on. What I
> > had in mind was simply to break that 1:1 connection between fuse_file
> > and lower filp setting a specific fuse_file::passthrough::filp to NULL,
> > but this is slightly different from what you mentioned.
> >
>
> I don't like the idea of switching between passthrough and server mid-life
> of an open file.
>
> There are consequences related to syncing the attribute cache of the kernel
> and the server that I don't even want to think about.
>
> > AFAIU you are suggesting to allocate one ID for each lower fs file
> > opened with passthrough within a connection, and maybe using idr_find at
> > every read/write/mmap operation to check if passthrough is enabled on
> > that file. Something similar to fuse2_map_get().
> > This way the fuse server can pass the same ID to one or more
> > fuse_file(s).
> > FUSE_DEV_IOC_PASSTHROUGH_CLOSE would idr_remove the ID, so idr_find
> > would fail, preventing the use of passthrough on that ID. CMIIW.
> >
>
> I don't think that FUSE_DEV_IOC_PASSTHROUGH_CLOSE should remove the ID.
> We can use a refcount for the mapping and FUSE_DEV_IOC_PASSTHROUGH_CLOSE
> just drops the initial server's refcount.
>
> Implementing revoke for an existing mapping is something completely different.
> It can be done, not even so hard, but I don't think it should be part of this
> series and in any case revoke will not remove the ID.
>
> > After FUSE_DEV_IOC_PASSTHROUGH_CLOSE(ID) it may happen that if some
> > fuse_file(s) storing that ID are still open and the same ID is reclaimed
> > in a new idr_alloc, this would lead to mismatching lower fs filp being
> > used by our fuse_file(s).  So also the ID stored in the fuse_file(s)
> > must be invalidated to prevent future uses of deallocated IDs.
>
> Obtaining a refcount on FOPEN_PASSTHROUGH will solve that.
>
> >
> > Would it make sense to have a list of fuse_files using the same ID, that
> > must be traversed at FUSE_DEV_IOC_PASSTHROUGH_CLOSE time?
> > Negative values (maybe -ENOENT) might be used to mark IDs as invalid,
> > and tested before idr_find at read/write/mmap to avoid the idr_find
> > complexity in case passthrough is disabled for that file.
> >
> > What do you think?
> >
>
> As I wrote above, this sounds unnecessarily complicated.
>
> Miklos,
>
> Do you agree with my interpretation of
> FUSE_DEV_IOC_PASSTHROUGH_CLOSE?

We need to deal with the case of too many open files.   The server
could manage this, but then we do need to handle the case when a
cached mapping disappears, i.e:

 client opens file
 [time passes]
 cached passthrough fd gets evicted to make room for other passthrough I/O
 [time passes]
 new I/O request comes in
 need to reestablish passthrough fd before finishing I/O

The way I think of this is that a passthrough mapping is assigned at
open time, which is cached (which may have the lifetime longer than
the open file, but shorter as well).  When
FUSE_DEV_IOC_PASSTHROUGH_CLOSE and there are cached mapping referring
to this particular handle, then those mappings need to be purged.   On
a new I/O request, the mapping will need to be reestablished by
sending a FUSE_MAP request, which triggers
FUSE_DEV_IOC_PASSTHROUGH_OPEN.

One other question that's nagging me is how to "unhide" these pseudo-fds.

Could we create a kernel thread for each fuse sb which has normal
file-table for these?  This would would allow inspecting state through
/proc/$KTHREDID/fd, etc..

Thanks,
Miklos
