Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4188D2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHJUhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 16:37:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJUhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:37:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so145884795oth.5;
        Sat, 10 Aug 2019 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jucnTNtmH8/DZ4WEOho6QZPjcUdP4+w0e+PDI8VoSe8=;
        b=sdfxzAMklg19nbBRvR7b/SyJ2lx3tBZc/bOKSlH4x1QeUPXaL8KC/Dcv6EuBdaTeVL
         x//XZTEPF72qqYRwHnK3/j6iVfEZno/YG5mOa7Uj9QzDlS6RcgQD5AXGatkdYK576KBr
         D2zWjvNLEz2T0ffgyRJmVNEcugLr6Nu/AhJ4HCPyddpRP6CxbDboQXtWzHlKydb9zRQL
         Riv6FDAgGgjVuYghsdiuUaLk0AlXVeakV4e7fmaERqQlJhnfcJoKx8z0MUw6C1lOoUvk
         wNjXa8UWzEjgrUqOm8wHuuo8OCh3pQvHUaBGizMHyj3tXQew2FD1lKSKzyT9bakopmfi
         3xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jucnTNtmH8/DZ4WEOho6QZPjcUdP4+w0e+PDI8VoSe8=;
        b=HyTmndnUQA1YkCY0HLEWQay1mnVjplJjTlFCJdYyoF/cjg7OUosGbBa2ktQVnjXOry
         osRcOY8bE8N71t6fAuRa+7S4+ddgmwrjYdqBN3h9tQ9HxQ9y1JZNBR2bGMuKnDepBl+X
         zHiOq8uFo9smN1kCQF6KNDaqlw9mhjlh69uVa2ZzPwB/yHPei7Wr1seZ6naJNTS/gpl2
         aixcBWH9tNKsKMnkoJ1pmxm4SxOZgaIGabDu+u7F/wfehrkwtRltzt9o0PQivix2H6Yq
         MQPGr93o0xYFLtSA+izaqG7BGf5q8Pyup2LrZCs2PU1vNryWyNBMwJ4FBii0a+QcrrTt
         C85Q==
X-Gm-Message-State: APjAAAWvxTKxqeYLQDqG/6vSsr7eYxHFA2Pi1ox/lNc8PSElCn6Jf5hh
        Ux/Qw0Xo0h23yXRIubknmMnhJADEe7zc/q4BJRtGU2Br
X-Google-Smtp-Source: APXvYqwVH7AZegtiTKp16y6T54m5AFpdAElZ8MiuT0cJGR+Z8AVZcQj55YDRuf8crr90KNtUvZLI5tQMzRQRy86jpZQ=
X-Received: by 2002:a5d:85c3:: with SMTP id e3mr27018354ios.265.1565469426677;
 Sat, 10 Aug 2019 13:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-6-deepa.kernel@gmail.com>
 <12c095e595836a7ff7f2c7b2a32cb5544dd29b55.camel@codethink.co.uk>
In-Reply-To: <12c095e595836a7ff7f2c7b2a32cb5544dd29b55.camel@codethink.co.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 10 Aug 2019 13:36:55 -0700
Message-ID: <CABeXuvriT7qhkKT0KMXrBsHqsj3b1BpRt6n-pfAnMVCHb=yBeg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 05/20] utimes: Clamp the timestamps before update
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:30 AM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
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
>
> This is testing the un-clamped value.
>
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
> Similarly here, for the minimum.
>
> I suggest testing for clamping like this:
>
>                         if (newattrs.ia_atime.tv_sec != times[0].tv_sec)
>                                 ...
>                         if (newattrs.ia_mtime.tv_sec != times[1].tv_sec)
>                                 ...
>
> Ben.
>
> > +                             newattrs.ia_mtime.tv_nsec = 0;
> > +                     else
> > +                             newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
> >                       newattrs.ia_valid |= ATTR_MTIME_SET;
> >               }

Darrick pointed out that maybe we could use timestamp_truncate() here to clamp.
I think it is ok to truncate to the right granularity also here.
setattr callbacks do it already. So the diff here looks like below:

-                       newattrs.ia_atime.tv_sec =
-                               clamp(times[0].tv_sec, sb->s_time_min,
sb->s_time_max);
-                       if (times[0].tv_sec == sb->s_time_max ||
times[0].tv_sec == sb->s_time_min)
-                               newattrs.ia_atime.tv_nsec = 0;
-                       else
-                               newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
+                       newattrs.ia_atime = timestamp_truncate(times[0], inode);

Thanks,
Deepa
