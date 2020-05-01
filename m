Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D741C185C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgEAOqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 10:46:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729175AbgEAOqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 10:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588344405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PAxMC2an+HuO6fwK0pHvsF8vFETkIJOxS2BSrwZIug=;
        b=Opqu5KGsejFH5haU727QzqNyIMruqX6ti3zOD09bBYpuW6V2dJ3tfuVOvI9CxC69wWj1wo
        J37bCkOswQec8zqstI1FUb3kzy6LT/OYYkHG9vRmXmSCedROqCVBTXoYC2xzKwJvS0kf8N
        jn8mbbenKiDVpHH/U435rPG/bs3hXss=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-hm8mRyCuM2WLfWe0aWMFRw-1; Fri, 01 May 2020 10:46:28 -0400
X-MC-Unique: hm8mRyCuM2WLfWe0aWMFRw-1
Received: by mail-oo1-f70.google.com with SMTP id t23so2320277oor.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PAxMC2an+HuO6fwK0pHvsF8vFETkIJOxS2BSrwZIug=;
        b=b+5ro3kZYK9keqFJanP49243n+JGIj7RHjQcpCSGY54cElrOcfFQETT8OHbBPFZaoK
         WfdqltDy61dc/ewqXz4z5jPG86Dq8RfygcAQ8pfoXH5HdYx+JfZ3p3vGwvE03pRxgjzB
         TEs90V+vnJYLIko3+iHbsBrcnUZseC3ztfskEBZgW1BTI/7aJWRBGmUD5R8CDV3a0HlZ
         nyJ7/ki8Ry0MIPzCxlBeEGwXn3XVZ1rEGfVAWW5czd5p84w/1QXXhnmmfbB5mxXz1UR5
         axKQumHQMcBGQ060Z7Ppuc6I9tvL5sxtAJ8HSetToqv1AmWHva+iWf7KsQAxv+XMbDRi
         Styg==
X-Gm-Message-State: AGi0PuYCgvehc2fqyUaHCqpOcA4+pQQtUae8WXvqvfDo4SXPGwc27PbA
        tv4TF6tLhUeq35PKyoC3gXesHZJ1fX6d+nohAJZk9ncCLlGUKO3VJPnyx/e9OMu3MwEFDQsP82R
        z80PK4SkYSHIwKR1whXojWpMFrZ3OeSDYcIg39VbMsg==
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr3916391otq.66.1588344387508;
        Fri, 01 May 2020 07:46:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKDh3hGCI49P8v9DIB0pf8SQidMuRu0a5PX4JiBQLS3y/qnX6pw1k5XjASmHpGzODx7mlwPtfE2sRdsrcygTXg=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr3916376otq.66.1588344387215;
 Fri, 01 May 2020 07:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
In-Reply-To: <20200501073127.GB13131@miu.piliscsaba.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 May 2020 16:46:16 +0200
Message-ID: <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 9:31 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Whiteouts, unlike real device node should not require privileges to create.
> > >
> > > The general concern with device nodes is that opening them can have side
> > > effects.  The kernel already avoids zero major (see
> > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > explicitly forbids registering a char device with 0/0 number (see
> > > cdev_add()).
> > >
> > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > i.e. it won't have any side effect.
> >
> > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > >  {
> > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > >     int error = may_create(dir, dentry);
> > >
> > >     if (error)
> > >             return error;
> > >
> > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > +       !is_whiteout)
> > >             return -EPERM;
> >
> > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > end up with regressions for overlayfs on sufficiently weird setups?
>
> You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> distros/admins can.
>
> Can we just try this, and revert to calling ->mknod directly from overlayfs if
> it turns out to be a problem that people can't fix easily?
>
> I guess we could add a new ->whiteout security hook as well, but I'm not sure
> it's worth it.  Cc: LMS mailing list; patch re-added for context.
>
> Thanks,
> Miklos
>
> ---
>  fs/char_dev.c                 |    3 +++
>  fs/namei.c                    |   17 ++++-------------
>  include/linux/device_cgroup.h |    3 +++
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev,
>         p->dev = dev;
>         p->count = count;
>
> +       if (WARN_ON(dev == WHITEOUT_DEV))
> +               return -EBUSY;
> +
>         error = kobj_map(cdev_map, dev, count, NULL,
>                          exact_match, exact_lock, p);
>         if (error)
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
>
>  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> +       bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
>         int error = may_create(dir, dentry);
>
>         if (error)
>                 return error;
>
> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> +           !is_whiteout)

Sorry for sidetracking, but !capable(CAP_MKNOD) needs to be last in
the chain, otherwise you could get a bogus audit report of CAP_MKNOD
being denied in case is_whiteout is true.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

