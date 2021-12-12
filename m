Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DE471937
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhLLIHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 03:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLIHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:07:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43AC061714
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 00:07:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so41884681edb.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jgxXFCg8o6FmTCfH8ziDqYyXNzOfy9cCmD86MxLgyqE=;
        b=z1dOkB4CiDacYDWOkNzAgWfPT8Ov73bd2jqA0j6im6E+SHJHtGs+b3FWk+/fa/7AQa
         3rgNikErNOLN4ChWS/KpEg8f8cbw5xnTfObZ+epjMIazEpd2BTd8wR8tEmPCiL2cmid/
         Aec4jMUWQ9CS4PPST21inkY8vl71az/SrKSYKQdX14ffXAoB6uR1kcb5z9pE/RRrBeyJ
         1b3B+P6UG97bGfHNVthK1eN1DI90X6xFCuDEVWU9uOiQGyBX0K1rar7zHjp+ATocWbb/
         og94MYiR2q5ilqOjf/1D2c6oQYQdJ5M1uRBAfPy12l2pdLtKl4oEMSkFEN3jlCHCnYUf
         SkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgxXFCg8o6FmTCfH8ziDqYyXNzOfy9cCmD86MxLgyqE=;
        b=KIyAO1Y3o924HJnu6t4qTX7qp/wOcKRYq1kbPPpM0V4zSKYQjCu0hOdqLOseQZ+AqO
         k9DujpcwZu1e6256X3dMYXpZl0WunFeY05qYn7wMSUssoG7KdgJvo3ZvMAIDquqLXSCg
         Vi1NlTndJCw+xIZH467GIcOUqdZ4C4lU8e5C7aaJN1VSIflk/GcDWfnewyzfaAgPuxW8
         u/C1UeGPF7uqIBqvo0p0cUPPu4bmRyH7J/iicxRwHgmyuPIaaBJf4V3/PeYTvv1OPJOy
         BGwsClmS4x3kmxx6XsQCD9eRAgLxO+XBickBJ/A3Os3VCUgYu2nUQRUn7DF9cZERBDLN
         9qKw==
X-Gm-Message-State: AOAM532VCPrG4dK0kfi5fED7ADXszVZArBa1OT2dniV2fUQ1DIwa7Btt
        noJE0iGrwt+hEomxnKdBqDDSZOWmls6uJHinHcgq7ZuX3A==
X-Google-Smtp-Source: ABdhPJxRa2k6IWJ815KzICfS67nw7HOIiqy5WJ3wICGPZvO6tTdyijax7nA+509fQUzj79ziBIK9MaTFEnKLG8bpHmE=
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr36577783ejc.424.1639296429851;
 Sun, 12 Dec 2021 00:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20210913111928.98-1-xieyongji@bytedance.com> <Ya/vW/eGXCzbmvAC@sol.localdomain>
 <YbOiO7xlOL0kkuYF@sol.localdomain>
In-Reply-To: <YbOiO7xlOL0kkuYF@sol.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 12 Dec 2021 16:07:01 +0800
Message-ID: <CACycT3sQHP+QgVitE6848Pxio+DC00dzpg-MAPwf191GXJYwsw@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     bcrl@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 2:53 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 03:33:47PM -0800, Eric Biggers wrote:
> > On Mon, Sep 13, 2021 at 07:19:28PM +0800, Xie Yongji wrote:
> > > We should defer eventfd_signal() to the workqueue when
> > > eventfd_signal_allowed() return false rather than return
> > > true.
> > >
> > > Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a tas=
k bit")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  fs/aio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/aio.c b/fs/aio.c
> > > index 51b08ab01dff..8822e3ed4566 100644
> > > --- a/fs/aio.c
> > > +++ b/fs/aio.c
> > > @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entr=
y *wait, unsigned mode, int sync,
> > >             list_del(&iocb->ki_list);
> > >             iocb->ki_res.res =3D mangle_poll(mask);
> > >             req->done =3D true;
> > > -           if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > > +           if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
> > >                     iocb =3D NULL;
> > >                     INIT_WORK(&req->work, aio_poll_put_work);
> > >                     schedule_work(&req->work);
> > > --
> > > 2.11.0
> > >
> >
> > Since I was just working with this file...:
> >
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> >
> > I don't know who is taking aio fixes these days, but whoever does so pr=
obably
> > should take this one at the same time as mine
> > (https://lore.kernel.org/linux-fsdevel/20211207095726.169766-1-ebiggers=
@kernel.org).
>
> Apparently no one is, so I've included this patch in the pull request I'v=
e sent
> (https://lore.kernel.org/r/YbOdV8CPbyPAF234@sol.localdomain).
>

Thank you!

Thanks=EF=BC=8C
Yongji
