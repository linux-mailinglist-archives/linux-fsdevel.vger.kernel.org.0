Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953C22E50C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE2TI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:08:57 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40938 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2TI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:08:57 -0400
Received: by mail-yb1-f195.google.com with SMTP id g62so1198844ybg.7;
        Wed, 29 May 2019 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OGwXMfFFQztZM039mI0WMSn1MvrOmZGR4oYkysJC3w=;
        b=SDTngy90DbeR+MzZDVKcRdkaLP1+vir+e/4EefAKUMh01+y3AxKsaTOgp8UXv9u/kE
         egvD3XMOaKIO6mAc28kewQPQfnR83nClWMseWJaKp6CGzxyo/3PIg6zwwDWixnB/rYvH
         TcQ4nbmzhMoJhgDROtSC68zFbYomgFQ+GGp/aBW2MLFRaJHBiLgo2XwXk5Fy5cLJxctl
         MhVPs2nmEpM6VLxLWpNAmlhW6wThw4YTXdQlFp6qXiHtXlnA7i6fuL3Oljw97t2qYByJ
         q61wR5WFYO+WhuKLMDDSg2TCWuoFvAzc4R6x2qrUWUFk+LqKNw55xJcOPmUqSsmGDzot
         5dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OGwXMfFFQztZM039mI0WMSn1MvrOmZGR4oYkysJC3w=;
        b=tepq9LwD9Q65AtPHy2K92Beyy2IpUQkMCou9NP4F9Cen5KkIwN9j0c1ZTc4YGtKIUy
         bC6Wjj+hbq0tXmN6MT+rW0OmTAKf/yltwpGqiPF5s6nK5Zb4/Cy6dUWzQhys1Xy+/xdw
         uIzgqTSGMvZ7byukaRgM7cyqWEVcHpwvzYnLmiH8z7tC6uehLEYMy9QhLhx4ED8NdCwu
         ZYqLp5oa8gcBS9avMtk8f6CmIIJEViV4yV//k4PSjyDsNbl1gRfz/oL+1f5tHvMJEfdY
         peovjMeBBk3B1X4mKw/Q09jd37jc8MeXfjePLJQ/8H/pes4RLwv84STHQ3iwUdM/grGX
         F44g==
X-Gm-Message-State: APjAAAWNgHqyv9WAHhwOXBzfGxKbmjAnyL6+jNqXfbeA56iuXQk4tMUg
        gMhpDbCfOXYOu/SkXOpMWYmFsfSqlbSIoZsGtNQ=
X-Google-Smtp-Source: APXvYqzloFzwd2llHYpp5ChMwkSfcbQRwyvB23IwdGNr0fVkGV5pXryNtFvsN+98UPJjSgKSdR/vdNglJk06q9T/qDc=
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr247877ybs.144.1559156935937;
 Wed, 29 May 2019 12:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-7-amir73il@gmail.com>
 <20190529182748.GF5231@magnolia>
In-Reply-To: <20190529182748.GF5231@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:08:44 +0300
Message-ID: <CAOQ4uxgsMLTPtYaQwwNHo3NrzXz9u=YGc2v6Pg8TSo7-xFrqQQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] vfs: introduce file_modified() helper
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 9:27 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, May 29, 2019 at 08:43:10PM +0300, Amir Goldstein wrote:
> > The combination of file_remove_privs() and file_update_mtime() is
> > quite common in filesystem ->write_iter() methods.
> >
> > Modelled after the helper file_accessed(), introduce file_modified()
> > and use it from generic_remap_file_range_prep().
> >
> > Note that the order of calling file_remove_privs() before
> > file_update_mtime() in the helper was matched to the more common order by
> > filesystems and not the current order in generic_remap_file_range_prep().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/inode.c         | 20 ++++++++++++++++++++
> >  fs/read_write.c    | 21 +++------------------
> >  include/linux/fs.h |  2 ++
> >  3 files changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index df6542ec3b88..2885f2f2c7a5 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1899,6 +1899,26 @@ int file_update_time(struct file *file)
> >  }
> >  EXPORT_SYMBOL(file_update_time);
> >
> > +/* Caller must hold the file's inode lock */
> > +int file_modified(struct file *file)
> > +{
> > +     int err;
> > +
> > +     /*
> > +      * Clear the security bits if the process is not being run by root.
> > +      * This keeps people from modifying setuid and setgid binaries.
> > +      */
> > +     err = file_remove_privs(file);
> > +     if (err)
> > +             return err;
> > +
> > +     if (likely(file->f_mode & FMODE_NOCMTIME))
>
> I would not have thought NOCMTIME is likely?
>
> Maybe it is for io requests coming from overlayfs, but for regular uses
> I don't think that's true.

Nope that's a typo. Good spotting.
Overlayfs doesn't set FMODE_NOCMTIME (yet). Only xfs does from
XFS_IOC_OPEN_BY_HANDLE, but I think Dave said that is a deprecated
API. so should have been very_unlikely().

Thanks,
Amir.
