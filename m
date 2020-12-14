Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0239F2D92F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 06:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389547AbgLNFuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 00:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390077AbgLNFuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:50:37 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A57EC0613CF;
        Sun, 13 Dec 2020 21:49:57 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id y5so15758153iow.5;
        Sun, 13 Dec 2020 21:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzSj9ml19X1fpvFM+ibRGRWOesLE9X7twr2UcjQK6RM=;
        b=Sj+btmu338yVzZf9IJdItaTlpCa9OvRugFyIo43i1GTNr2KYCS0DPEhzn4O9iCrVr+
         zp3vQ/BceQD+Bha48E8zOrKmt3gAos9yHXxaUXkHNv3N3aPKZ2zVyDhMzDbkNnwE191n
         ri3rGSjQqbNHHCFovIokFrJwBssQv/BByMDI6bPWMeJOC2MDG04i6v7aeOrtnt7BT6Jy
         wQRuyXVzALlMPRXn9uUvq+L6r5Hu3Vqxh3HPRX7x6hOAuGwFIILYKvB4TD8NR0lwDi+5
         /lnelvPaPz4iXG8pxaYNf4qrpDP6HkZY0u0DL+B7XmH9RyH5lJ/jYcDm0m5lo1yeriTG
         +fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzSj9ml19X1fpvFM+ibRGRWOesLE9X7twr2UcjQK6RM=;
        b=DCvvoCTqiNq1JhRmtyWAbvRox97nwSn+JwLAcJOm0Z4kRJCdIAo5e6ugk7Pv6qv5qr
         dbP3fXCi4nmMB+RGHwGS0Jc1Q4wGMhOLYiG7FjjygeSkkSIxrax5PZIcKHskIsvd4KS4
         7ZFzbargG9Gvs92ppB/pQ7epSXvh7F3tcaGO2IDn6kNI4507DMG3soM4mTVvgOaarxd2
         GxMRovc/R3e4N8aIY/8hUCpH5s8UmIQybRzDAD8ykLbu292HSQlgAgtpWGIA3i9ng+P+
         m6ku/IKJM5b6N1VPIkHUsmhHpvQThRkEXzcPS3PwmALcfPHvPfKFXvGp0fDmRoo8IgFh
         ha/w==
X-Gm-Message-State: AOAM5316ETMpbx1/OZuJHQOFkg04TQhmvJ6bGiLQPT7j1JAVXGcdD7EM
        LqkENbf8H5s1vDymhdwgsAXnU3VTz3Mg1a61Sc4=
X-Google-Smtp-Source: ABdhPJw01VcC/8JoePKk0J/yxnUTJBSNAx9/YJr8eMEw8jQcyo+jtql3VToOVEUl3j6AXoWcnNf5WeFY1gbJJpWwy7Q=
X-Received: by 2002:a02:cc89:: with SMTP id s9mr30784713jap.81.1607924996345;
 Sun, 13 Dec 2020 21:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-9-mszeredi@redhat.com>
 <CAOQ4uxgy23chB-NQcXJ+P3hO0_M3iAkgi_wyhbpfT3wkaU+E7w@mail.gmail.com> <CAJfpegvpEkB2HL5THcUsmBVvcru1-DkSTo_DmA4pWNU_TV7ODg@mail.gmail.com>
In-Reply-To: <CAJfpegvpEkB2HL5THcUsmBVvcru1-DkSTo_DmA4pWNU_TV7ODg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Dec 2020 07:49:45 +0200
Message-ID: <CAOQ4uxi2Gn2-nZajpqMd+u487eT7y=EZNafEeyd72178biKZ4w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 4:44 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Dec 8, 2020 at 12:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > In case the file cannot be opened with O_NOATIME because of lack of
> > > capabilities, then clear O_NOATIME instead of failing.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  fs/overlayfs/file.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > index dc767034d37b..d6ac7ac66410 100644
> > > --- a/fs/overlayfs/file.c
> > > +++ b/fs/overlayfs/file.c
> > > @@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
> > >         err = inode_permission(realinode, MAY_OPEN | acc_mode);
> > >         if (err) {
> > >                 realfile = ERR_PTR(err);
> > > -       } else if (!inode_owner_or_capable(realinode)) {
> > > -               realfile = ERR_PTR(-EPERM);
> > >         } else {
> > > +               if (!inode_owner_or_capable(realinode))
> > > +                       flags &= ~O_NOATIME;
> > > +
> >
> > Isn't that going to break:
> >
> >         flags |= OVL_OPEN_FLAGS;
> >
> >         /* If some flag changed that cannot be changed then something's amiss */
> >         if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
> >
> > IOW setting a flag that is allowed to change will fail because of
> > missing O_ATIME in file->f_flags.
>
> Well spotted.  I just removed those lines as a fix.   The check never
> triggered since its introduction in 4.19, so I guess it isn't worth
> adding more complexity for.
>
> >
> > I guess we need test coverage for SETFL.
>
> There might be some in ltp, haven't checked.  Would be nice if the fs
> related ltp tests could be integrated into xfstests.
>

There is some test coverage for SETFL in xfstests.

The t_immutable tests for one, but those would not run if the mounter
has no CAP_LINUX_IMMUTABLE, so would not have been useful to
detect the problem above.

fsstress also seems to have support for SETFL ops, but I am not sure
in how many tests it is exercises and perhaps the relevant problem
would have been covered by some stress test that is not in the 'quick'
tests group.

Thanks,
Amir.
