Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6252CC38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE1QjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:39:22 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38766 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfE1QjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:39:22 -0400
Received: by mail-yw1-f65.google.com with SMTP id b74so8150721ywe.5;
        Tue, 28 May 2019 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kml4jUoEmHUUXVU1c7AViVp4FPM02sigk8d9DK0mLzY=;
        b=DM21Whm2L3cVgyx84wQDA/8HkSa3vmE2RxWxa5lp22AbmIh2SpsoPqlgSRhCAdo+1Y
         GSQKZy3B9olrPkd5nzl/C9vPni8uIlJ40X918/v46kgdqtCNBSS5pnQhRusLxSDgqgdJ
         Vz9xt9/xpSuhTF+1KPioCUJcj/3eYoaNwR1a1cbIkjekkhqdmefpIXUUoPY+Ua+XoSba
         b4hbU81lTdQWnjhTUPyvPW5yeErG2zuI2lQfUn3rk7x1j7m0bUuyJYyZcM2WSNX8cLnF
         fns0Q0rjh8OUnnU6Rf6M7mAenmCWWYHHwO53c40vof3mdC9ACND2uFlU+QjrPgY+9WAr
         BsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kml4jUoEmHUUXVU1c7AViVp4FPM02sigk8d9DK0mLzY=;
        b=lqP4bF5V1bpXT950u7LnImQSOl7H2vrrCLbCLyISRCfILIqftTHeqnqvSty11/6hSp
         sMsJM/jyniY16OdiHzpzenn18pupbPqnihvNYSPbPZJuwEEOA9yIO2znCUxO/n9NK6Ly
         OWURA4LXCXTAoyRYdOLF3VIcDSWNC1zy4nF8zoe6tUsAKECBVZKgUpFsMVkfBNXJeIYa
         WoZoQPPU/r3TuF7mWt9fTlmn8vlm8m1HIvgH6Vbm+f+PsLou5ugR9xSaTxfAe4Pfpuh/
         zNykLYZN7ixwLwJhDM9CNI+kqVRKjTErPt5SCN8iycpZ5w9lB3pGKEuVIHZWJCDZZD37
         HSrg==
X-Gm-Message-State: APjAAAUBYHS0XoI4n/YEhy1aHlCuhlhE5R3ZiWBBAqzWJ2TvdHPcgATp
        T3VOT3ahVbcWYMWFXXsWjrDTTQXb6bdRQpooy1Q8GA==
X-Google-Smtp-Source: APXvYqzlubAJ/K4Y7oaRG7mSHMdyNuXaFC7wQy8zL7nH/3Jiqu85o1NpFnI0umEUqiUpBhKMxrjWEotS0Soa3Ydrm4k=
X-Received: by 2002:a81:1186:: with SMTP id 128mr50033634ywr.181.1559061561339;
 Tue, 28 May 2019 09:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190526061100.21761-1-amir73il@gmail.com> <20190526061100.21761-5-amir73il@gmail.com>
 <20190528161829.GD5221@magnolia> <CAOQ4uxjRJmiwM4L9ZFHi8rfjX87-xJ=+9HSeTgUyRyTUnkF6PA@mail.gmail.com>
 <20190528163110.GG5221@magnolia>
In-Reply-To: <20190528163110.GG5221@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 May 2019 19:39:10 +0300
Message-ID: <CAOQ4uxg4JEyzKCd-OGiox-mLth2At7hFM-WDGfqdVc2WTBr3cA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] vfs: add missing checks to copy_file_range
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 7:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, May 28, 2019 at 07:26:29PM +0300, Amir Goldstein wrote:
> > On Tue, May 28, 2019 at 7:18 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Sun, May 26, 2019 at 09:10:55AM +0300, Amir Goldstein wrote:
> > > > Like the clone and dedupe interfaces we've recently fixed, the
> > > > copy_file_range() implementation is missing basic sanity, limits and
> > > > boundary condition tests on the parameters that are passed to it
> > > > from userspace. Create a new "generic_copy_file_checks()" function
> > > > modelled on the generic_remap_checks() function to provide this
> > > > missing functionality.
> > > >
> > > > [Amir] Shorten copy length instead of checking pos_in limits
> > > > because input file size already abides by the limits.
> > > >
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/read_write.c    |  3 ++-
> > > >  include/linux/fs.h |  3 +++
> > > >  mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 58 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > > index f1900bdb3127..b0fb1176b628 100644
> > > > --- a/fs/read_write.c
> > > > +++ b/fs/read_write.c
> > > > @@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > >               return -EXDEV;
> > > >
> > > > -     ret = generic_file_rw_checks(file_in, file_out);
> > > > +     ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> > > > +                                    flags);
> > > >       if (unlikely(ret))
> > > >               return ret;
> > > >
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 89b9b73eb581..e4d382c4342a 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> > > >                               struct file *file_out, loff_t pos_out,
> > > >                               loff_t *count, unsigned int remap_flags);
> > > >  extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
> > > > +extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > > > +                                 struct file *file_out, loff_t pos_out,
> > > > +                                 size_t *count, unsigned int flags);
> > > >  extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
> > > >  extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
> > > >  extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 798aac92cd76..1852fbf08eeb 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -3064,6 +3064,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
> > > >       return 0;
> > > >  }
> > > >
> > > > +/*
> > > > + * Performs necessary checks before doing a file copy
> > > > + *
> > > > + * Can adjust amount of bytes to copy
> > >
> > > That's the @req_count parameter, correct?
> >
> > Correct. Same as generic_remap_checks()
>
> Ok.  Would you mind updating the comment?
>
OK.

Thanks,
Amir.
