Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013D42CBDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfE1Q0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:26:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46829 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1Q0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:26:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id x144so3998567ywd.13;
        Tue, 28 May 2019 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXrQhQSKBGBXXu3HqhQogZyJNi6xwWNSbgVndIeH0EQ=;
        b=Otsl2PVmKD/IZkrTQfgtMYiifauv5hN2UEog/BjGxyq3w1KDMYEgbFyAHaA3vCdR0Y
         nTBhY/lOriJbasPm6nXFdCoa7IAhD03lSBb3k6OCy0Xihx96vKq9ExcoMMVXvAvQADTE
         F4oQB6YO6lZIyUNePkQWw7cyNDwgJGU53md8fcbWTjcY1ANrwWfm4AxXDO45Xgg4X3cs
         U20oBZIeK0Kx0JuDy3CBO4TYpkfVgfjuBmV+LaYdtMjVrakymAUh8F01hhZ2trDgx5IH
         4Mb9OOqZKkj5PRP7J8vBcAOR/Gvex/Oros2pBFa3WrlDHPJ+FW0FEmsfSyABhLmLJRjc
         TMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXrQhQSKBGBXXu3HqhQogZyJNi6xwWNSbgVndIeH0EQ=;
        b=A2v7YHp+aaIZtKHH3SdVdsiJt3yvZ6pLgTELd9hjY5J43Zh8zuGknapUb1GeUcUgsf
         8KQSzWCZeKuUivEy7R91/MLpS1n3XA0iJn005aVU0VsFDrzJmTPgDVFVSKVLg0XauzdF
         G/JbwRYgYJkzBM+vnYzzttkX3xNIWVXYCTspQBwo45VvSkIV96xthTVUOd6Kbu373pHg
         YtXqM+5P08RfWrD+xUwZtX6Bul48COEiMBynQsIogiXvITGKkzKk9owjdaDtJSeY3UG7
         ylVj8il9FgMpwhp9vvuFCUgyPk2tUowJnWXCdOdyhMOq8AJ8hnFtdF9oBLPwfUC/kTXu
         TbJA==
X-Gm-Message-State: APjAAAX3Ky6lUf2avLUYXr6FpukG3jyekAX9NKv024O3YTTd7OmYuPoy
        eueGJHko9ja9+IJTGGzKgtCvlFUiSwfo0t/1XcU=
X-Google-Smtp-Source: APXvYqwj/Not1k5uURdPLQG/wJlULoixT6ERPDltqUopiPC84OheX9LIduuwBH8ZXVS2tVWelGeeK9R2Dtz7W/SkXgA=
X-Received: by 2002:a0d:d5c1:: with SMTP id x184mr34607930ywd.88.1559060801268;
 Tue, 28 May 2019 09:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190526061100.21761-1-amir73il@gmail.com> <20190526061100.21761-5-amir73il@gmail.com>
 <20190528161829.GD5221@magnolia>
In-Reply-To: <20190528161829.GD5221@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 May 2019 19:26:29 +0300
Message-ID: <CAOQ4uxjRJmiwM4L9ZFHi8rfjX87-xJ=+9HSeTgUyRyTUnkF6PA@mail.gmail.com>
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

On Tue, May 28, 2019 at 7:18 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sun, May 26, 2019 at 09:10:55AM +0300, Amir Goldstein wrote:
> > Like the clone and dedupe interfaces we've recently fixed, the
> > copy_file_range() implementation is missing basic sanity, limits and
> > boundary condition tests on the parameters that are passed to it
> > from userspace. Create a new "generic_copy_file_checks()" function
> > modelled on the generic_remap_checks() function to provide this
> > missing functionality.
> >
> > [Amir] Shorten copy length instead of checking pos_in limits
> > because input file size already abides by the limits.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/read_write.c    |  3 ++-
> >  include/linux/fs.h |  3 +++
> >  mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index f1900bdb3127..b0fb1176b628 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> >       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> >               return -EXDEV;
> >
> > -     ret = generic_file_rw_checks(file_in, file_out);
> > +     ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> > +                                    flags);
> >       if (unlikely(ret))
> >               return ret;
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 89b9b73eb581..e4d382c4342a 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >                               struct file *file_out, loff_t pos_out,
> >                               loff_t *count, unsigned int remap_flags);
> >  extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
> > +extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > +                                 struct file *file_out, loff_t pos_out,
> > +                                 size_t *count, unsigned int flags);
> >  extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
> >  extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
> >  extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 798aac92cd76..1852fbf08eeb 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3064,6 +3064,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
> >       return 0;
> >  }
> >
> > +/*
> > + * Performs necessary checks before doing a file copy
> > + *
> > + * Can adjust amount of bytes to copy
>
> That's the @req_count parameter, correct?

Correct. Same as generic_remap_checks()

>
> > + * Returns appropriate error code that caller should return or
> > + * zero in case the copy should be allowed.
> > + */
> > +int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > +                          struct file *file_out, loff_t pos_out,
> > +                          size_t *req_count, unsigned int flags)
> > +{
> > +     struct inode *inode_in = file_inode(file_in);
> > +     struct inode *inode_out = file_inode(file_out);
> > +     uint64_t count = *req_count;
> > +     loff_t size_in;
> > +     int ret;
> > +
> > +     ret = generic_file_rw_checks(file_in, file_out);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Don't touch certain kinds of inodes */
> > +     if (IS_IMMUTABLE(inode_out))
> > +             return -EPERM;
> > +
> > +     if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
> > +             return -ETXTBSY;
> > +
> > +     /* Ensure offsets don't wrap. */
> > +     if (pos_in + count < pos_in || pos_out + count < pos_out)
> > +             return -EOVERFLOW;
> > +
> > +     /* Shorten the copy to EOF */
> > +     size_in = i_size_read(inode_in);
> > +     if (pos_in >= size_in)
> > +             count = 0;
> > +     else
> > +             count = min(count, size_in - (uint64_t)pos_in);
>
> Do we need a call to generic_access_check_limits(file_in...) here to
> prevent copies from ranges that the page cache doesn't support?

No. Because i_size cannot be of an illegal size and we cap
the read to i_size.
I also removed generic_access_check_limits() from generic_remap_checks()
for a similar reason in patch #8.

Thanks,
Amir.
