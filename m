Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5367852E540
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiETGsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiETGsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:48:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B114CDDD
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 23:48:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c12so9551829eds.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IRLSS+yD+N2OQmk+j2dQlPgGjeCMzah9eGnHbPoVew=;
        b=P9rXPpr8YcQ43jDq9rBOkqWZVhYHFEkLmLlfCUEZdMHEVF+c/t8Eb+lS3FqwSwHN/4
         qA2JBpzo0ovMPKq/1Ts6WeR1OufSaFBkoOpNbF+ZGqeFgDkuU7KZ0rHoO/aPQNJp0vHl
         2McZllU2iiyUWMgDbDiIpnFyeMNNusfSFAVuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IRLSS+yD+N2OQmk+j2dQlPgGjeCMzah9eGnHbPoVew=;
        b=I628/9R8e/yspAxwUOWqCKdeEu62/RjujjzLFc2euJZA+Edx3iJc0ewL/RipZOSiMs
         Ht/jvuL3xxLS49aWcSTXE0AAemIkjHpvrNpgBM8qKKRw5J+xCccazP71B7cgENTjg+Bo
         XUl+VJ3nvoiO+CUylNKFXXiSQkBDQa9uIp6+LzQRLTfez2qFq07yrPXfQtBBYnLg05Tv
         q2Q2Dmm2WRQoMaOoRYP7fidK/dIy+48Y2IdmuwrT4TTDUSO4PnGAM2HYiQPKPc9T4hJt
         5QsmLe0NY1R32ETOTl5TbXI23Ka7hLwrg8oDljJQehObgZfREDmmFl7vQHuS2ndjhqzT
         3TjQ==
X-Gm-Message-State: AOAM532zmC20sgmpkaAYVRFDHQ0quoYKCDe6ffvznFE0SxOHSkvu+XOX
        Rn+/6qvTmaFxxN7thVOdaP4Qp+mqBYEEySi+ZZwI1b6GKYeZTg==
X-Google-Smtp-Source: ABdhPJwffIcWEcMb96Hff5IaPaPK0eC/tQCnpE0kTQnKIm0N3zuW8/eWmRqIrhNd6F9bfZ4ZcZl71/DN758q1RlvlUs=
X-Received: by 2002:a05:6402:2949:b0:425:a52a:28c5 with SMTP id
 ed9-20020a056402294900b00425a52a28c5mr9050805edb.389.1653029308235; Thu, 19
 May 2022 23:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com> <Yoaj7jhLpp34K9+v@redhat.com>
In-Reply-To: <Yoaj7jhLpp34K9+v@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 20 May 2022 08:48:16 +0200
Message-ID: <CAJfpegtogo7sUJEVCza92+_K3peBXX5M0G-HoqK9U1AXQoTfhw@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 May 2022 at 22:09, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
> > Hi Al,
> >
> > Do you see anything bad with allowing ->atomic_open() to take a positive dentry
> > and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
> >
> > It looks wrong not to allow optimizing away the roundtrip associated with
> > revalidation when we do allow optimizing away the roundtrip for the initial
> > lookup in the same situation.
> >
> > Thanks,
> > Miklos
> >
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 509657fdf4f5..d35b5cbf7f64 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3267,7 +3267,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >               dput(dentry);
> >               dentry = NULL;
> >       }
> > -     if (dentry->d_inode) {
> > +     if (dentry->d_inode && !d_atomic_open(dentry)) {
> >               /* Cached positive dentry: will open in f_op->open */
> >               return dentry;
>
> Hi Miklos,
>
> I see that lookup_open() calls d_revalidate() first. So basically
> idea is that fuse ->.d_revalidate will skip LOOKUP needed to make sure
> dentry is still valid (Only if atomic lookup+open is implemented) and
> return 1 claiming dentry is valid.

Yes.

> And later in ->atomic_open(), it will either open the file or
> get an error and invalidate dentry. Hence will save one LOOKUP in
> success case. Do I understand the intent right?

It should not fail in the stale dentry case either, just merge the
revalidation into ->atomic_open().

Thanks,
Miklos
