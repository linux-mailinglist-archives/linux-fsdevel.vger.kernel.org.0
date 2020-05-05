Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3F1C53AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgEEKvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728732AbgEEKvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:51:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C7C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 03:51:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rh22so1258646ejb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiAYBMxYI8NU7mtb1mzz5f5Sdoka6Yab/wWBtaaJ4fk=;
        b=ihDJpaR9AYed4rtVB7Ykde5Q9tGgQkZvAm/Ie9ITAzbq6xK+wY+bP1MoqSzbWFfgfN
         kuUdHcddqD/XD0IRIybJX6+whUJHcQ2nF9RX6En/DBHOuqjVjJYjQAI5IikvYY6MTXYj
         Z4eH2tJZ2wKF3WBp3fNKSlOFt2CvbA+SH4nas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiAYBMxYI8NU7mtb1mzz5f5Sdoka6Yab/wWBtaaJ4fk=;
        b=b/vGjUFprIeCIOWfYvXSTCpRRo9p9E0ePAKMaRoRRXhNc2MtXxZs+RsEtDMDqHWRtC
         0MMyxkpe97YfM2glPvaksMMZTIGUMy9UCoevymgJAqUVkvQsoi1RF+BhOr3IkrHjSnvo
         HKTkXclU0AT7/vlsIWI2UKfdzwa/WkzQ6JQzPu8IJkiUJVSRkyl6m6tXREx13Wukn6u8
         GwFhqSlyZJosFct1FiTveM0SpqRGmXpJPZOca6t7xEZhx3f+asGcU1xpqaaN4baEHCZE
         z2cCtgc4DYaXGrF+/YbsN3G8jUmaKvLnqidyu6Dh8TcYD0WGfl2UoVK2OXlGm6EMWHkA
         6JXg==
X-Gm-Message-State: AGi0PuYsmxtXeGQogYRogg5YwaYiuKO/IwZrubqQKFWRjUNo1eBYl7xE
        P8xkTTRQ7yX2xfzNKA3cA36/l6+FTSG86sa+zS064A==
X-Google-Smtp-Source: APiQypJSWUulzPC8TpwSFWx/zlrCFqpXOvahPn5HlH1fRKqJeL3GYoJvvbIC2tPJ+8vi7DfOknnxH2Doam1p2WQwXC8=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr1979896ejy.145.1588675868324;
 Tue, 05 May 2020 03:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
 <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
In-Reply-To: <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 5 May 2020 12:50:56 +0200
Message-ID: <CAJfpegs3QbWa3gDGNv1atmanP_SE1KE3RhehQ7A+n_cNOa3Bsg@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 4:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 1, 2020 at 9:31 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
> >
> >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> >  {
> > +       bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> >         int error = may_create(dir, dentry);
> >
> >         if (error)
> >                 return error;
> >
> > -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > +           !is_whiteout)
>
> Sorry for sidetracking, but !capable(CAP_MKNOD) needs to be last in
> the chain, otherwise you could get a bogus audit report of CAP_MKNOD
> being denied in case is_whiteout is true.

Thanks, fixed in the latest revision.

Miklos
