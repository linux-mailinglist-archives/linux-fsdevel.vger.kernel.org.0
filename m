Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3491FAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 11:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfHSJJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 05:09:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36892 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHSJJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:09:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so1103615qto.4;
        Mon, 19 Aug 2019 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rczbmYNDQXzrrKbji3E8GHKh4iXow7Hl/uO3TZ6Tc+k=;
        b=S4cGx3Qxbua2gFHW5ATNxAKue9yt2cd2tRpzLC8nvMZDokwCJmzJzRbnM09oMdFMv8
         3TO6M61tnxh67AofxzidC9nhw09+o/fHfwjDvgWVI91ptZl4Oi6MGW4QvyPiurEnkTKH
         NqNYPuWybbTGa1TIlBQb3EyDThcullC2PkT5TWXyoScH0ls+TWrI8FqtjAB64GJkzjiG
         duVyOm20ZXDfc+xOYGEBfXeEll7jb6rP7NdnKgmJlJg8oJY/vdIBrFHzHHXEN62PM79T
         7QrQGlibS97dO8TSaZTsdtjcij/CkK/AhU7qvDJRgqQc0jDysaq36qjMjrzU+o4WA8oI
         XKIQ==
X-Gm-Message-State: APjAAAVBBSb7P9MlDZ0qzISjWD14A2Q/N/gpi1HlEaXE4ZIFe4Cg7eqv
        Z4d+lLIgZixkrne3zxnk5yksRq4aGt+lOAJUITU=
X-Google-Smtp-Source: APXvYqzVXYNfh7BL03PgbmX2PaeKvfUoSaxXiKUu5Yi3ewEtq9YKOS5Vp8fOpVAr65J8GcHJZdmWGo8kYp4Xu1Bou1E=
X-Received: by 2002:ad4:45c7:: with SMTP id v7mr9673895qvt.63.1566205767031;
 Mon, 19 Aug 2019 02:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
 <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
 <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com> <CAHpGcMJ2EScNiPapyugC_fz+AEhdpKmx3VmYjTH_2me8WLxB2A@mail.gmail.com>
In-Reply-To: <CAHpGcMJ2EScNiPapyugC_fz+AEhdpKmx3VmYjTH_2me8WLxB2A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Aug 2019 11:09:11 +0200
Message-ID: <CAK8P3a3iOnsW43qt9yjD8Tyv800svBZF8ZEnqvk-F56vv5yqtw@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 10:17 PM Andreas Grünbacher
<andreas.gruenbacher@gmail.com> wrote:
> Am So., 18. Aug. 2019 um 21:32 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
> > On Fri, Aug 16, 2019 at 7:32 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +       /* These are just misnamed, they actually get/put from/to user an int */
> > > > +       switch(cmd) {
> > > > +       case FS_IOC32_GETFLAGS:
> > > > +               cmd = FS_IOC_GETFLAGS;
> > > > +               break;
> > > > +       case FS_IOC32_SETFLAGS:
> > > > +               cmd = FS_IOC_SETFLAGS;
> > > > +               break;
> > >
> > > I'd like the code to be more explicit here:
> > >
> > >         case FITRIM:
> > >         case FS_IOC_GETFSLABEL:
> > >               break;
> > >         default:
> > >               return -ENOIOCTLCMD;
> >
> > I've looked at it again: if we do this, the function actually becomes
> > longer than the native gfs2_ioctl(). Should we just make a full copy then?
>
> I don't think the length of gfs2_compat_ioctl is really an issue as
> long as the function is that simple.

True. The most important goal should just be to make it easy to
add the correct handler the next time another command is added
to the ioctl function.

Just let me know which version you want for that:

1. my original patch
2. the version from your reply
3. my version below with compat_ptr() added
4. ...

> > static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd,
> > unsigned long arg)
> > {
> >         switch(cmd) {
> >         case FS_IOC32_GETFLAGS:
> >                 return gfs2_get_flags(filp, (u32 __user *)arg);
> >         case FS_IOC32_SETFLAGS:
> >                 return gfs2_set_flags(filp, (u32 __user *)arg);
> >         case FITRIM:
> >                 return gfs2_fitrim(filp, (void __user *)arg);
> >         case FS_IOC_GETFSLABEL:
> >                 return gfs2_getlabel(filp, (char __user *)arg);
> >         }
> >
> >         return -ENOTTY;
> > }
>
> Don't we still need the compat_ptr conversion? That seems to be the
> main point of having a compat_ioctl operation.

Right, of course. Fixed now in my tree.

         Arnd
