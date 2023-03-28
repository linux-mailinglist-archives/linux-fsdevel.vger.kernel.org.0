Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5F6CCA9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjC1T3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1T3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:29:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1D26B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:29:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c29so17235798lfv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sze0hZQs4AzNTu34VgpoyYMvtZyrr4yHRgV/mYMoCA0=;
        b=TucsBd+N/AQxtwaL0+o5NkcY9MSe4BBeB7YoVEYpkQV8wnCSGXj8+ipQbmuXWEzW2A
         GM8O3lhwnn4JcP6ON75Pevuhje9cNtUFHOjcmISo50lT1G41d+14fgUUHDcPconVy0fS
         5PyjuLBTZNnd8kgM55m7WRtrqA2p/Dke0lm/uMTLsExLNM2SVAfj8g2kHorU2izEeIs7
         JT0edO0vY6WohLcj+qnliJeULIVv2uKBg3zZMuw3hiFBAvgOPLrcRvcvRUfnSQrjuCqm
         8SMJTfWqtJaEUmUpAZoIkvXoKJ2nWCFOyhRwp9XoL7vyAyRpajv034xLjjtBT8WlcCJn
         nKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sze0hZQs4AzNTu34VgpoyYMvtZyrr4yHRgV/mYMoCA0=;
        b=Bs1hpLHf3EjQPdgFguwXL8nny31e3FTIQjDKEkewrHzrDIxqNMm5urUHXEG9WdyVzP
         xMqlGNlgR6MY6sPtceNMUcO0rxK/K0h+39ztxVJ+Y+Tn+3IIszN/Lms4B23Ta80ll118
         EtBo/k3n6UoAjxJd/RDZgZ8uRS9NwTtp+JJMywKX2iN2aPfBM9gBAFlqn2A5bg9NN7TR
         Q4qbITP3NrLmnv5+U/YzXY2obyGsT0YKgatPYh/eQzbJra5M4W7uLhM+iq3f099IRGDl
         qi5b0aYXa7EWZxRSOHmgBvaJY47hVnCz/oss36o/mqTZKcRwTAEAqbVjz8WLxWRm0vYP
         +GtA==
X-Gm-Message-State: AAQBX9dVj8li9KcPnZfZurXbUybYZO72uLKkIpPpVX8dPpKfGJd2f4XA
        Si8qDjtksD8ma+75fPlWGVmzUufmuC+nde0IhZh/vw==
X-Google-Smtp-Source: AKy350YFSKMXJnqTblo/+gcV15ljJSRH6Afdq3y71v4w821k/pohARkBmE7hu6p9kVh0UhqyN06tpfTIQVNOXx2mkYI=
X-Received: by 2002:a05:6512:4ca:b0:4d5:ca32:6ed5 with SMTP id
 w10-20020a05651204ca00b004d5ca326ed5mr5233121lfq.3.1680031775704; Tue, 28 Mar
 2023 12:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220722201513.1624158-1-axelrasmussen@google.com> <ZCIEGblnsWHKF8RD@x1n>
In-Reply-To: <ZCIEGblnsWHKF8RD@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 28 Mar 2023 12:28:59 -0700
Message-ID: <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 2:01=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> I think I overlooked this patch..
>
> Axel, could you explain why this patch is correct?  Comments inline.
>
> On Fri, Jul 22, 2022 at 01:15:13PM -0700, Axel Rasmussen wrote:
> > The basic interaction for setting up a userfaultfd is, userspace issues
> > a UFFDIO_API ioctl, and passes in a set of zero or more feature flags,
> > indicating the features they would prefer to use.
> >
> > Of course, different kernels may support different sets of features
> > (depending on kernel version, kconfig options, architecture, etc).
> > Userspace's expectations may also not match: perhaps it was built
> > against newer kernel headers, which defined some features the kernel
> > it's running on doesn't support.
> >
> > Currently, if userspace passes in a flag we don't recognize, the
> > initialization fails and we return -EINVAL. This isn't great, though.
>
> Why?  IIUC that's the major way for user app to detect any misconfig of
> feature list so it can bail out early.
>
> Quoting from man page (ioctl_userfaultfd(2)):
>
> UFFDIO_API
>        (Since Linux 4.3.)  Enable operation of the userfaultfd and perfor=
m API handshake.
>
>        ...
>
>            struct uffdio_api {
>                __u64 api;        /* Requested API version (input) */
>                __u64 features;   /* Requested features (input/output) */
>                __u64 ioctls;     /* Available ioctl() operations (output)=
 */
>            };
>
>        ...
>
>        For Linux kernel versions before 4.11, the features field must be
>        initialized to zero before the call to UFFDIO_API, and zero (i.e.,
>        no feature bits) is placed in the features field by the kernel upo=
n
>        return from ioctl(2).
>
>        ...
>
>        To enable userfaultfd features the application should set a bit
>        corresponding to each feature it wants to enable in the features
>        field.  If the kernel supports all the requested features it will
>        enable them.  Otherwise it will zero out the returned uffdio_api
>        structure and return EINVAL.
>
> IIUC the right way to use this API is first probe with features=3D=3D0, t=
hen
> the kernel will return all the supported features, then the user app shou=
ld
> enable only a subset (or all, but not a superset) of supported ones in th=
e
> next UFFDIO_API with a new uffd.

Hmm, I think doing a two-step handshake just overcomplicates things.

Isn't it simpler to just have userspace ask for the features it wants
up front, and then the kernel responds with the subset of features it
actually supports? In the common case (all features were supported),
there is nothing more to do. Userspace is free to detect the uncommon
case where some features it asked for are missing, and handle that
however it likes.

I think this patch is backwards compatible with the two-step approach, too.

I do agree the man page could use some work. I don't think it
describes the two-step handshake process correctly, either. It just
says, "ask for the features you want, and the kernel will either give
them to you or fail". If we really did want to keep the two-step
process, it should describe it (set features =3D=3D 0 first, then ask only
for the ones you want which are supported), and the example program
should demonstrate it.

But, I think it's simpler to just have the kernel do what the man page
describes. Userspace asks for the features up front, kernel responds
with the subset that are actually supported. No need to return EINVAL
if unsupported features were requested.

>
> > Userspace doesn't have an obvious way to react to this; sure, one of th=
e
> > features I asked for was unavailable, but which one? The only option it
> > has is to turn off things "at random" and hope something works.
> >
> > Instead, modify UFFDIO_API to just ignore any unrecognized feature
> > flags. The interaction is now that the initialization will succeed, and
> > as always we return the *subset* of feature flags that can actually be
> > used back to userspace.
> >
> > Now userspace has an obvious way to react: it checks if any flags it
> > asked for are missing. If so, it can conclude this kernel doesn't
> > support those, and it can either resign itself to not using them, or
> > fail with an error on its own, or whatever else.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index e943370107d0..4974da1f620c 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfaultfd_ct=
x *ctx,
> >       ret =3D -EFAULT;
> >       if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
> >               goto out;
> > -     features =3D uffdio_api.features;
> > -     ret =3D -EINVAL;
> > -     if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURE=
S))
> > -             goto err_out;
>
> What's worse is that I think you removed the only UFFD_API check.  Althou=
gh
> I'm not sure whether it'll be extended in the future or not at all (very
> possible we keep using 0xaa forever..), but removing this means we won't =
be
> able to extend it to a new api version in the future, and misconfig of
> uffdio_api will wrongly succeed I think:
>
>         /* Test wrong UFFD_API */
>         uffdio_api.api =3D 0xab;
>         uffdio_api.features =3D 0;
>         if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0)
>                 err("UFFDIO_API should fail but didn't");

Agreed, we should add back the UFFD_API check - I am happy to send a
patch for this.

>
> > +     /* Ignore unsupported features (userspace built against newer ker=
nel) */
> > +     features =3D uffdio_api.features & UFFD_API_FEATURES;
> >       ret =3D -EPERM;
> >       if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRA=
CE))
> >               goto err_out;
> > --
> > 2.37.1.359.gd136c6c3e2-goog
> >
>
> --
> Peter Xu
>
