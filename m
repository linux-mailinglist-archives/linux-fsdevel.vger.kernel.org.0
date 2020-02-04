Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC72151E13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBDQRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 11:17:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37633 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBDQRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:17:02 -0500
Received: by mail-il1-f194.google.com with SMTP id v13so16351586iln.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQIybpWInC8dEcn8TOu2S7Vc2bFJuw35GnXDoWrVrY4=;
        b=eWrdZfPA0Db+MUje3N/HuEmwZOyaeosBDx/f0G6IvvIE+WI0ke3Nvq0WGuPCXC2jDM
         qT1Wii7UrAukJ0hyQDpwpEYXBJyGhXGrp6aIam2xPXDego5v+DZE0xVC9N0BVCDZOBax
         jdDYTJ1ccytb+uFgyrQw6kC0am3SaqWLi1EtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQIybpWInC8dEcn8TOu2S7Vc2bFJuw35GnXDoWrVrY4=;
        b=D4xRt6p+BEi0Ok3XBZHtWonhAquXbx2fqahIjmS+q4ZeoVJkk64KBf2UGVRDeJ3AlU
         OLrjvDbXHABFBr9ohNMgj9+yYVBBUeKXu7raKx0bDExtk49yVHZdI1MwZuy+Vp2U5psa
         kVCgE/n988NRtyJQ1wX5creBc7SKoXqxoRN8iDX6IbjO3gbYQsJ1uBjKfwWeQId77TxI
         xI5e6a41aS0P4UM5xnt4w2yXeRp/FHvrSMoESfFET89/i2tyiL42PVlyW33CbSPbOvGA
         3/5krcPpXzSmF6fxEWR/543s13TyHWcEP9dNYDzDxoWaXA8OZPjT2CbezIhQXFG4LADw
         VCag==
X-Gm-Message-State: APjAAAUtT2aAsPOhQn02jwAABKv2slY/OFzan0U97vlhJx3+Hx+kMNDK
        d6UdQtsWJ+76a9Qof8UTi9ngYN9nNdXrkPdjgMuxevMO
X-Google-Smtp-Source: APXvYqznXnYS/019OrdL+SBRAMPJmsEF4vFpFj57JhVELxARgBS1YjfanJc9rODx0aru+fp0+hinOoX8Y9ebV7mvVJY=
X-Received: by 2002:a92:3c93:: with SMTP id j19mr19936750ilf.63.1580833020864;
 Tue, 04 Feb 2020 08:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com>
In-Reply-To: <20200204145951.GC11631@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Feb 2020 17:16:49 +0100
Message-ID: <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > No reason to prevent upper layer being a remote filesystem.  Do the
> > revalidation in that case, just as we already do for lower layers.
> >
> > This lets virtiofs be used as upper layer, which appears to be a real use
> > case.
>
> Hi Miklos,
>
> I have couple of very basic questions.
>
> - So with this change, we will allow NFS to be upper layer also?

I haven't tested, but I think it will fail on the d_type test.

> - What does revalidation on lower/upper mean? Does that mean that
>   lower/upper can now change underneath overlayfs and overlayfs will
>   cope with it.

No, that's a more complicated thing.  Especially with redirected
layers (i.e. revalidating a redirect actually means revalidating all
the path components of that redirect).

> If we still expect underlying layers not to change, then
>   what's the point of calling ->revalidate().

That's a good question; I guess because that's what the filesystem
expects.  OTOH, it's probably unnecessary in most cases, since the
path could come from an open file descriptor, in which case the vfs
will not do any revalidation on that path.

So this is basically done to be on the safe side, but it might not be necessary.

Thanks,
Miklos

> Thanks
> Vivek
>
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/namei.c | 3 +--
> >  fs/overlayfs/super.c | 8 ++++++--
> >  fs/overlayfs/util.c  | 2 ++
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index 76e61cc27822..0db23baf98e7 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -845,8 +845,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
> >               if (err)
> >                       goto out;
> >
> > -             if (upperdentry && (upperdentry->d_flags & DCACHE_OP_REAL ||
> > -                                 unlikely(ovl_dentry_remote(upperdentry)))) {
> > +             if (upperdentry && upperdentry->d_flags & DCACHE_OP_REAL) {
> >                       dput(upperdentry);
> >                       err = -EREMOTE;
> >                       goto out;
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 26d4153240a8..ed3a11db9039 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -135,9 +135,14 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
> >                                       unsigned int flags, bool weak)
> >  {
> >       struct ovl_entry *oe = dentry->d_fsdata;
> > +     struct dentry *upper;
> >       unsigned int i;
> >       int ret = 1;
> >
> > +     upper = ovl_dentry_upper(dentry);
> > +     if (upper)
> > +             ret = ovl_revalidate_real(upper, flags, weak);
> > +
> >       for (i = 0; ret > 0 && i < oe->numlower; i++) {
> >               ret = ovl_revalidate_real(oe->lowerstack[i].dentry, flags,
> >                                         weak);
> > @@ -747,8 +752,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
> >               ovl_unescape(tmp);
> >               err = ovl_mount_dir_noesc(tmp, path);
> >
> > -             if (!err && (ovl_dentry_remote(path->dentry) ||
> > -                          path->dentry->d_flags & DCACHE_OP_REAL)) {
> > +             if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> >                       pr_err("filesystem on '%s' not supported as upperdir\n",
> >                              tmp);
> >                       path_put_init(path);
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 3ad8fb291f7d..c793722739e1 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -96,6 +96,8 @@ void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
> >       struct ovl_entry *oe = OVL_E(dentry);
> >       unsigned int i, flags = 0;
> >
> > +     if (upperdentry)
> > +             flags |= upperdentry->d_flags;
> >       for (i = 0; i < oe->numlower; i++)
> >               flags |= oe->lowerstack[i].dentry->d_flags;
> >
> > --
> > 2.21.1
> >
>
