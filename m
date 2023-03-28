Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A36CCB85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC1Ue2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC1UeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6171BF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680035608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aa9scwbUdPQfJ4Vy6HAv4zO2gR2nzcP99eoEK/YIKSk=;
        b=NxTG2Ugfs3ncoQd9KO61WfAUFHKIMFOZpz2RtuG7OPWNcKcWRCGqXk3tluDt6wu2ammekO
        NklO/Xeh8pe/qwh6QVfQgIzW0q2AAHqwQjhOEIK+2m642VPvTJWRc1jRCCxEBu2ghIJimq
        vSGPe9DizDxPQ5I4NJBowYHKfMiNsPU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-2W8TVxQcOGunL-1I_c0NPA-1; Tue, 28 Mar 2023 16:33:26 -0400
X-MC-Unique: 2W8TVxQcOGunL-1I_c0NPA-1
Received: by mail-qt1-f199.google.com with SMTP id a19-20020a05622a02d300b003e4ecb5f613so3524086qtx.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa9scwbUdPQfJ4Vy6HAv4zO2gR2nzcP99eoEK/YIKSk=;
        b=x0qXmNl/e3cTjKgmG6gLOtQuxF05KmjiQO/augbG+dtCP/lCLCXhYqJbWE3lfvJvbI
         TITaSPmhNZ7HrcyZFaoc9qkgskijkpbX781r8vawslem6VhumGramCLLRHDf0S7/0Vsm
         Krxto06TC/z8zEYWT9yPsfZXNhcxQpCUYacLxz7YIrdiXUXfHyr4ZJCuN7TeirYkLflt
         5EqrERI5FE4HVZmOesLj7lgwvyUsd/T+/Lc4FuITymlPzM4oJ69+V8kW8VXJzu/h2Vju
         deOemM1MYFk3rV532Jlk3WbachehGGNXusoaa0CHVrnKa8dA0a5ugdEqWch3/MUc25vO
         2psg==
X-Gm-Message-State: AO0yUKXb+7iJdR4A9lq/LE0m/yxBdPWvQbX9/TFupyRJWC5Gaq/8SMjZ
        1Lgt/KaRZdJRhb+gM4qQRarK4cacRXsQ2byuHaIe3/QIaOQK20bQKjIpo/fzEHav/DVSk9PjFUL
        YRvkykTZyVrcNFWsQ7XNrr3WtyA==
X-Received: by 2002:a05:622a:1819:b0:3bf:c458:5bac with SMTP id t25-20020a05622a181900b003bfc4585bacmr31350003qtc.0.1680035606143;
        Tue, 28 Mar 2023 13:33:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set9P3hCEhTpDAuhvN/whwxCNRdwbgwRwpnPqueGCfo9qLGoM1Pu7yJ26PdVZUKLkLkPU0IzjCg==
X-Received: by 2002:a05:622a:1819:b0:3bf:c458:5bac with SMTP id t25-20020a05622a181900b003bfc4585bacmr31349965qtc.0.1680035605770;
        Tue, 28 Mar 2023 13:33:25 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b0074269db4699sm11139636qkp.46.2023.03.28.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:33:25 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:33:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
Message-ID: <ZCNPFDK0vmzyGIHb@x1n>
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n>
 <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n>
 <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:01:26PM -0700, Axel Rasmussen wrote:
> On Tue, Mar 28, 2023 at 12:45 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 12:28:59PM -0700, Axel Rasmussen wrote:
> > > On Mon, Mar 27, 2023 at 2:01 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > I think I overlooked this patch..
> > > >
> > > > Axel, could you explain why this patch is correct?  Comments inline.
> > > >
> > > > On Fri, Jul 22, 2022 at 01:15:13PM -0700, Axel Rasmussen wrote:
> > > > > The basic interaction for setting up a userfaultfd is, userspace issues
> > > > > a UFFDIO_API ioctl, and passes in a set of zero or more feature flags,
> > > > > indicating the features they would prefer to use.
> > > > >
> > > > > Of course, different kernels may support different sets of features
> > > > > (depending on kernel version, kconfig options, architecture, etc).
> > > > > Userspace's expectations may also not match: perhaps it was built
> > > > > against newer kernel headers, which defined some features the kernel
> > > > > it's running on doesn't support.
> > > > >
> > > > > Currently, if userspace passes in a flag we don't recognize, the
> > > > > initialization fails and we return -EINVAL. This isn't great, though.
> > > >
> > > > Why?  IIUC that's the major way for user app to detect any misconfig of
> > > > feature list so it can bail out early.
> > > >
> > > > Quoting from man page (ioctl_userfaultfd(2)):
> > > >
> > > > UFFDIO_API
> > > >        (Since Linux 4.3.)  Enable operation of the userfaultfd and perform API handshake.
> > > >
> > > >        ...
> > > >
> > > >            struct uffdio_api {
> > > >                __u64 api;        /* Requested API version (input) */
> > > >                __u64 features;   /* Requested features (input/output) */
> > > >                __u64 ioctls;     /* Available ioctl() operations (output) */
> > > >            };
> > > >
> > > >        ...
> > > >
> > > >        For Linux kernel versions before 4.11, the features field must be
> > > >        initialized to zero before the call to UFFDIO_API, and zero (i.e.,
> > > >        no feature bits) is placed in the features field by the kernel upon
> > > >        return from ioctl(2).
> > > >
> > > >        ...
> > > >
> > > >        To enable userfaultfd features the application should set a bit
> > > >        corresponding to each feature it wants to enable in the features
> > > >        field.  If the kernel supports all the requested features it will
> > > >        enable them.  Otherwise it will zero out the returned uffdio_api
> > > >        structure and return EINVAL.
> > > >
> > > > IIUC the right way to use this API is first probe with features==0, then
> > > > the kernel will return all the supported features, then the user app should
> > > > enable only a subset (or all, but not a superset) of supported ones in the
> > > > next UFFDIO_API with a new uffd.
> > >
> > > Hmm, I think doing a two-step handshake just overcomplicates things.
> > >
> > > Isn't it simpler to just have userspace ask for the features it wants
> > > up front, and then the kernel responds with the subset of features it
> > > actually supports? In the common case (all features were supported),
> > > there is nothing more to do. Userspace is free to detect the uncommon
> > > case where some features it asked for are missing, and handle that
> > > however it likes.
> > >
> > > I think this patch is backwards compatible with the two-step approach, too.
> > >
> > > I do agree the man page could use some work. I don't think it
> > > describes the two-step handshake process correctly, either. It just
> > > says, "ask for the features you want, and the kernel will either give
> > > them to you or fail". If we really did want to keep the two-step
> > > process, it should describe it (set features == 0 first, then ask only
> > > for the ones you want which are supported), and the example program
> > > should demonstrate it.
> > >
> > > But, I think it's simpler to just have the kernel do what the man page
> > > describes. Userspace asks for the features up front, kernel responds
> > > with the subset that are actually supported. No need to return EINVAL
> > > if unsupported features were requested.
> >
> > The uffdio_api.features passed into the ioctl(UFFDIO_API) should be such
> > request to enable features specified in the kernel.  If the kernel doesn't
> > support any of the features in the list, IMHO it's very natural to fail it
> > as described in the man page.  That's also most of the kernel apis do
> > afaik, by failing any enablement of features if not supported.
> >
> > >
> > > >
> > > > > Userspace doesn't have an obvious way to react to this; sure, one of the
> > > > > features I asked for was unavailable, but which one? The only option it
> > > > > has is to turn off things "at random" and hope something works.
> > > > >
> > > > > Instead, modify UFFDIO_API to just ignore any unrecognized feature
> > > > > flags. The interaction is now that the initialization will succeed, and
> > > > > as always we return the *subset* of feature flags that can actually be
> > > > > used back to userspace.
> > > > >
> > > > > Now userspace has an obvious way to react: it checks if any flags it
> > > > > asked for are missing. If so, it can conclude this kernel doesn't
> > > > > support those, and it can either resign itself to not using them, or
> > > > > fail with an error on its own, or whatever else.
> > > > >
> > > > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > > > ---
> > > > >  fs/userfaultfd.c | 6 ++----
> > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index e943370107d0..4974da1f620c 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
> > > > >       ret = -EFAULT;
> > > > >       if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
> > > > >               goto out;
> > > > > -     features = uffdio_api.features;
> > > > > -     ret = -EINVAL;
> > > > > -     if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
> > > > > -             goto err_out;
> > > >
> > > > What's worse is that I think you removed the only UFFD_API check.  Although
> > > > I'm not sure whether it'll be extended in the future or not at all (very
> > > > possible we keep using 0xaa forever..), but removing this means we won't be
> > > > able to extend it to a new api version in the future, and misconfig of
> > > > uffdio_api will wrongly succeed I think:
> > > >
> > > >         /* Test wrong UFFD_API */
> > > >         uffdio_api.api = 0xab;
> > > >         uffdio_api.features = 0;
> > > >         if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0)
> > > >                 err("UFFDIO_API should fail but didn't");
> > >
> > > Agreed, we should add back the UFFD_API check - I am happy to send a
> > > patch for this.
> >
> > Do you plan to just revert the patch?  If so, please go ahead.  IMHO we
> > should just follow the man page.
> >
> > What I agree here is the api isn't that perfect, in that we need to create
> > a separate userfault file descriptor just to probe.  Currently the features
> > will be returned in the initial test with features=0 passed in, but it also
> > initializes the uffd handle even if it'll never be used but for probe only.
> 
> Oh, I thought you could UFFDIO_API the same FD twice. Having to create
> a whole separate FD just to probe features makes me dislike that
> design even more.
> 
> >
> > However since that existed in the 1st day I guess we'd better keep it
> > as-is.  And it's not so bad either: user app does open/close one more time,
> > but only once for each app's lifecycle.
> 
> I don't think just reverting would be enough. We'd also need to update
> the man page to describe the two-step initialization, and we'd need to
> update the man page's example program to demonstrate it. Our own
> selftest also doesn't use that approach, so it would need to be
> updated as well.

No worry on that, I'm recently cleaning up the selftest (majorly, split
userfaultfd.c into two tests).  This is also on my radar, and yes it was
broken.  I do plan to make sure the selftests can run on all old/new
kernels after the cleanup.  It's getting a bit chaos by having so much
global variables and I found it becomes harder to maintain.

For this I blame myself on being lazy starting from the uffd-wp selftests,
though..  It can do better.

> 
> It also seems not unlikely that there exists some userspace code which
> simply copied the example program from the man page, and as such
> doesn't do the two-step handshake today. Hard to know for certain.

The example has no feature enabled, in which case is fine.  Definitely good
if there's another one illustrates the features!=0 case.

> 
> Once we've dealt with that, what we'll have accomplished is just
> making the API harder to use. I don't see any downside from the
> current state of things, it allows a much simpler way of configuring
> userfaultfds, and it's backwards compatible with the more complicated
> way.
> 
> I think we can set things right by just adding in the UFFD_API version
> check by itself, and then updating the man page to describe the
> current state of things?

I still don't understand why you would consider it's right only by having
the kernel succeed the ioctl even if some specified features are not
supported.  What's the benefit?

An user app will need to check the returned feature list and bit-check with
what was requested which is even more awkward to me than a straightforward
failure, isn't it?

QEMU definitely uses it with a proper probing:

https://gitlab.com/qemu-project/qemu/-/blob/master/migration/postcopy-ram.c#L222

Meanwhile anyone can try to enable FEATURE_NEVER_EXISTED and ioctl will
return 0.  It just doesn't sound right to me in any case..

-- 
Peter Xu

