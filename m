Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C788E7C6B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfGaPdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 11:33:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36533 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaPdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:33:50 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so33606864iom.3;
        Wed, 31 Jul 2019 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yI0JpspD1113sUBtAqLZbFVFbLJqu1gr4xDjLSMreiw=;
        b=LAz5/a69YdR7Pt36ZVsGmVGHpGp+4qFpAIYuoITCJqrz5Gd8B+Ylo1NbHJTTCjmxbX
         thvsIlzvZ0kbcB7WehCIGIUZnNEJiBxwjbVFOIrws/AU3swVmolYIDA1t8pzCjxFOUGN
         EVChaEPYrK2rJ2O2U9fyhgylfagpoyXUogqgoYlDIR5bh4KugnehZ6GcC14uaLXH9FKG
         2P50hqW7flLwOgVQ7DtjCOryeL83sgbY/es35/f4Sd3q9Wdp5Yykz8mXVnM5KXOBrocE
         2o7oC4kBDg6UFRswY3tLoC/0HxGKpyf4Xp/Xf4QRT1yUyixALFsf6XlbEDtSiK1YPVoP
         ry5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yI0JpspD1113sUBtAqLZbFVFbLJqu1gr4xDjLSMreiw=;
        b=hhtJJRtrp1gseDLplq8HAarBiv9Xgp2fQKvoxpLsK9lK/ImyNYEXWGdWcSRkAZ0AG/
         QJLADHImsSnswNndZvpikn+faIuJHigOllGqeVtOVSh1G2tSXSyaxHQWxizNQhXOFGnp
         59nxMgKdDGpgBGE8E/09XfYBZTvZtQT58wkmglms9bxdDzn2cboLuKRatL4iP92kTC59
         s5LYuKvv13YeT8xczwXhQuxcJQg6FYSw6DMKbyorzb50/tdCCpvSwiL5DezvOUIU8vrV
         8Tg3osuBi6W5AvkTABvjU4iu1NSsmpvxYowAQg2oJn52YmHOCUSN+U0Qq3pxj6ysA2Nw
         c/uA==
X-Gm-Message-State: APjAAAU1Pk5Tus7i5mA4OaNWOaZ5TsuKN7O0foze/4u4fhScQ/3pfhDk
        gmchb2g1WEt6tXS1xriUONADx+e+4L0eF9QPtTM=
X-Google-Smtp-Source: APXvYqyyEUfB7Inu5/gImzGyMyc1RdpNROfupfk2bU9j14soRxHbI/8kSJJb6tSun7W2m0osy6EPjpO+f2kqvHjEuc8=
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr1036752iog.153.1564587229296;
 Wed, 31 Jul 2019 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-6-deepa.kernel@gmail.com>
 <20190731151452.GA7077@magnolia>
In-Reply-To: <20190731151452.GA7077@magnolia>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 31 Jul 2019 08:33:37 -0700
Message-ID: <CABeXuvp0DsjY9Uz2UNcY+70dTfVvA9Vo+SGeK2KV2q8f4jXCCA@mail.gmail.com>
Subject: Re: [PATCH 05/20] utimes: Clamp the timestamps before update
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 8:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, Jul 29, 2019 at 06:49:09PM -0700, Deepa Dinamani wrote:
> > POSIX is ambiguous on the behavior of timestamps for
> > futimens, utimensat and utimes. Whether to return an
> > error or silently clamp a timestamp beyond the range
> > supported by the underlying filesystems is not clear.
> >
> > POSIX.1 section for futimens, utimensat and utimes says:
> > (http://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html)
> >
> > The file's relevant timestamp shall be set to the greatest
> > value supported by the file system that is not greater
> > than the specified time.
> >
> > If the tv_nsec field of a timespec structure has the special
> > value UTIME_NOW, the file's relevant timestamp shall be set
> > to the greatest value supported by the file system that is
> > not greater than the current time.
> >
> > [EINVAL]
> >     A new file timestamp would be a value whose tv_sec
> >     component is not a value supported by the file system.
> >
> > The patch chooses to clamp the timestamps according to the
> > filesystem timestamp ranges and does not return an error.
> > This is in line with the behavior of utime syscall also
> > since the POSIX page(http://pubs.opengroup.org/onlinepubs/009695399/functions/utime.html)
> > for utime does not mention returning an error or clamping like above.
> >
> > Same for utimes http://pubs.opengroup.org/onlinepubs/009695399/functions/utimes.html
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  fs/utimes.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/utimes.c b/fs/utimes.c
> > index 350c9c16ace1..4c1a2ce90bbc 100644
> > --- a/fs/utimes.c
> > +++ b/fs/utimes.c
> > @@ -21,6 +21,7 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
> >       int error;
> >       struct iattr newattrs;
> >       struct inode *inode = path->dentry->d_inode;
> > +     struct super_block *sb = inode->i_sb;
> >       struct inode *delegated_inode = NULL;
> >
> >       error = mnt_want_write(path->mnt);
> > @@ -36,16 +37,24 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
> >               if (times[0].tv_nsec == UTIME_OMIT)
> >                       newattrs.ia_valid &= ~ATTR_ATIME;
> >               else if (times[0].tv_nsec != UTIME_NOW) {
> > -                     newattrs.ia_atime.tv_sec = times[0].tv_sec;
> > -                     newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
> > +                     newattrs.ia_atime.tv_sec =
> > +                             clamp(times[0].tv_sec, sb->s_time_min, sb->s_time_max);
> > +                     if (times[0].tv_sec == sb->s_time_max || times[0].tv_sec == sb->s_time_min)
> > +                             newattrs.ia_atime.tv_nsec = 0;
> > +                     else
> > +                             newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
> >                       newattrs.ia_valid |= ATTR_ATIME_SET;
> >               }
> >
> >               if (times[1].tv_nsec == UTIME_OMIT)
> >                       newattrs.ia_valid &= ~ATTR_MTIME;
> >               else if (times[1].tv_nsec != UTIME_NOW) {
> > -                     newattrs.ia_mtime.tv_sec = times[1].tv_sec;
> > -                     newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
> > +                     newattrs.ia_mtime.tv_sec =
> > +                             clamp(times[1].tv_sec, sb->s_time_min, sb->s_time_max);
> > +                     if (times[1].tv_sec >= sb->s_time_max || times[1].tv_sec == sb->s_time_min)
>
> Line length.
>
> Also, didn't you just introduce a function to clamp tv_sec and fix
> granularity?  Why not just use it here?  I think this is the third time
> I've seen this open-coded logic.

Yes, we can use that now. Earlier we were not setting the tv_nsec to 0
in timestamp_truncate() which is why this was opencoded here.
I will make the change to include this.

Thanks,
Deepa
