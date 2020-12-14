Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB52D92E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 06:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgLNFpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 00:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388095AbgLNFpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:45:00 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F653C0613CF;
        Sun, 13 Dec 2020 21:44:20 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d9so15758065iob.6;
        Sun, 13 Dec 2020 21:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5f++uHyhUZvKFKGP/TJc/Zp2AjamNS1uB7GEg0mwmU=;
        b=XGeh74wKKUKXDIBL7DtmtnsFspiZcsB2HbFHhvWT3URQwBMDb/VHezqLflJVl5trV7
         qtT4mShOlrh1b8oL18nUnFy1UINXsn0YtME+/RjkWtTwPIhXBmlnCKGn+FuhKpO0sjGy
         8yBmO6gzYHHwnCVrKZPFCBxG7eEv7xE6IudZ5W+GCSd981aeSGTv2Ue6rXaZvknXxPCR
         5FIq8KR4WquFepn/94rk395I86EJH876clnO5m2PIqjY366EIWgOZxUX8tGrZH50r0MZ
         EOcQyZTrL4Elyl3DM9og/CiagCk4inAoCZjJtTe29brKjSoFg9au0XAgaIrBFGgBsAxL
         x6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5f++uHyhUZvKFKGP/TJc/Zp2AjamNS1uB7GEg0mwmU=;
        b=YjuQSAnyT8J9rvN0UnHW1sfiC/goeqqkXzmHdXjBgEMlsD6HKF2ghIZPIXf2tP3heD
         TT/PeCnnEH1P6k8jHsSdb2Gc4hBS/fju8+IaKEHHyIrOkDUMia1CQ01p/pmJELhCE4ys
         haz8lplt8EzlxQ16kgQMnjGJmbJSHNolr7blXW+zaRUg9SVZFZDrGMOg1Xnbf4fjJGkd
         orSzP0ECluAXMr1+Gk+0N4xkrVvSmyrzRuo6eLREz4ABAgnmFJWZSP2T8a1RUefU1jmI
         ibuG2QO7gnVvIS8V0h6MphktY9dlpomdkbE4c1xtgC/iPkxzSnb6DPelwFQoonxWQgnh
         vgsA==
X-Gm-Message-State: AOAM531v9S9X4oF2aafoVWJ7x+lBX6TIFan7WlPw9nn13rYyFZR3Ycad
        HagQpzEBQtLZd40MJypwwmJxYTwrAWq4/INqDKw=
X-Google-Smtp-Source: ABdhPJz2332Zttk7G//EGDjyxKRrLiqUIkl1A7lG5fSwcC7foUmA64/Jtyc31cj5X2zaw5yu69muoZJgipcPNjT4eFQ=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr31339973jal.30.1607924659764;
 Sun, 13 Dec 2020 21:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
 <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com> <CAJfpegsxku5D+08F6SUixQUfF6eDVm+o2pu6feLooq==ye0GDg@mail.gmail.com>
In-Reply-To: <CAJfpegsxku5D+08F6SUixQUfF6eDVm+o2pu6feLooq==ye0GDg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Dec 2020 07:44:08 +0200
Message-ID: <CAOQ4uxj6130FkTPQ0_83bBj2vJGaehdYk1dix6c8FgLStqN6qw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 5:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Dec 8, 2020 at 12:15 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 6:36 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > ovl_ioctl_set_flags() does a capability check using flags, but then the
> > > real ioctl double-fetches flags and uses potentially different value.
> > >
> > > The "Check the capability before cred override" comment misleading: user
> > > can skip this check by presenting benign flags first and then overwriting
> > > them to non-benign flags.
> > >
> > > Just remove the cred override for now, hoping this doesn't cause a
> > > regression.
> > >
> > > The proper solution is to create a new setxflags i_op (patches are in the
> > > works).
> > >
> > > Xfstests don't show a regression.
> > >
> > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >
> > Looks reasonable
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > > ---
> > >  fs/overlayfs/file.c | 75 ++-------------------------------------------
> > >  1 file changed, 3 insertions(+), 72 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > index efccb7c1f9bc..3cd1590f2030 100644
> > > --- a/fs/overlayfs/file.c
> > > +++ b/fs/overlayfs/file.c
> > > @@ -541,46 +541,26 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
> > >                            unsigned long arg)
> > >  {
> > >         struct fd real;
> > > -       const struct cred *old_cred;
> > >         long ret;
> > >
> > >         ret = ovl_real_fdget(file, &real);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       old_cred = ovl_override_creds(file_inode(file)->i_sb);
> > >         ret = security_file_ioctl(real.file, cmd, arg);
> > >         if (!ret)
> > >                 ret = vfs_ioctl(real.file, cmd, arg);
> > > -       revert_creds(old_cred);
> > >
> > >         fdput(real);
> > >
> > >         return ret;
> > >  }
> > >
> >
> >
> > I wonder if we shouldn't leave a comment behind to explain
> > that no override is intentional.
>
> Comment added.
>
> > I also wonder if "Permission model" sections shouldn't be saying
> > something about ioctl() (current task checks only)? or we just treat
> > this is a breakage of the permission model that needs to be fixed?
>
> This is a breakage of the permission model.  But I don't think this is
> a serious breakage, or one that actually matters.
>

Perhaps, but there is a much bigger issue with this change IMO.
Not because of dropping rule (b) of the permission model, but because
of relaxing rule (a).

Should overlayfs respect the conservative interpretation as it partly did
until this commit, a lower file must not lose IMMUTABLE/APPEND_ONLY
after copy up, but that is exactly what is going to happen if we first
copy up and then fail permission check on setting the flags.

It's true that before this change, file could still be copied up and system
crash would leave it without the flags, but after the change it is much
worse as the flags completely lose their meaning on lower files when
any unprivileged process can remove them.

So I suggest that you undo all the changes except for the no override.

And this calls for a fork of generic/545 to overlay test with lower files.

Thanks,
Amir.
