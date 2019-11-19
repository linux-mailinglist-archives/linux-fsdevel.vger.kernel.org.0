Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5B1020D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKSJih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:38:37 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37030 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSJig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:38:36 -0500
Received: by mail-yb1-f195.google.com with SMTP id q7so8519048ybk.4;
        Tue, 19 Nov 2019 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XV9TdHCwAgTh1DSZeE90GauN9czOwgzQKxUvB4bE7ZI=;
        b=PMLXdH0fLbYsnkIW4DZdeTpD9/zeNmJgjcFFZN+jLkiAG49aKD1VA+HmTP4HAfpZSg
         elX70sjUZdyRRlX9TUPLrmZLhnrr/swR9tPpSx0LL1ICGpWdMt6w3vSmSYqZddzJoxku
         P5Bz5D/UrQLp1XmrjtbCRWPafSxIsfzt23tbeugj17TRGxwsAyts801mkHo64/V2LCeh
         udky5arWbl4/QfJ7XKWqaPRjRs0PPpMNLKl/T4RBjVwZNGoM/BMYd5eX2xisZaQIHFjM
         0IpEoIGKVSYLUSpF+yYI9ixw7mlDOcKx9QjZ6EQTzFlnCLE0CVtvCt20G7+HBkiZeXdG
         +gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XV9TdHCwAgTh1DSZeE90GauN9czOwgzQKxUvB4bE7ZI=;
        b=HBUhpYyzyO+iz3VRInSpblVziZ5h9P3iIlhI99nx8kjOSkl0in8ICmlagXjcU3Dal2
         7f9JvL8QR0Gv7IwEkGRDuZlZkPw10kHTDI9Th5PKoMO3erDrE1ajRWnd4vntNaLIlHtd
         fsTc3zcTZ1vr0duGAt42OFbMamYMxJ+ADe+BXV9ybcp2Ek9hWB17bVDOPmVFTJ1HO0qj
         swh9eom7yZySodH/gjuHD5L8L9Oi8J9aEdeuZUSsXxNzNz5WLcS9bI3pC5mOASwsZ9FD
         FfMiQ++Ip2hySh4E5Hgb9WZUtXk8QIqyEEvZ9LL3h70dFEgvsQvH0OWQhxtngV1F69To
         JSHA==
X-Gm-Message-State: APjAAAUyzbMn6W+AF6vtIUnjKGX61aSgCjfJOAdsa4GzoDcX3mtQy30k
        ktHVv7LzmJc85NPYVM2ycAi1PL5fPTQo6pc7r7qKcSNh
X-Google-Smtp-Source: APXvYqycetVdYBKXH9dAFp9riCP5n+JBr2OnqHm1agKt7VVk9T07vV61kzYK7hore5LntcoUX42e4BcH5QFjm8CNi6I=
X-Received: by 2002:a25:212:: with SMTP id 18mr27185502ybc.439.1574156315282;
 Tue, 19 Nov 2019 01:38:35 -0800 (PST)
MIME-Version: 1.0
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <1574129643-14664-3-git-send-email-jiufei.xue@linux.alibaba.com>
 <CAOQ4uxhU0NGqX-P4XTJ+kf6sXNCnUCBxgp1u2-aDV5p15Jh+tg@mail.gmail.com> <142a7524-2587-7b1c-c5e0-3eb2d42b2762@linux.alibaba.com>
In-Reply-To: <142a7524-2587-7b1c-c5e0-3eb2d42b2762@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Nov 2019 11:38:24 +0200
Message-ID: <CAOQ4uxgR3KO9kXGdqif0A-QBrVLn9id2eFANMDprCz62jSAmaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: implement async IO routines
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:37 AM Jiufei Xue
<jiufei.xue@linux.alibaba.com> wrote:
>
> Hi Amir,
>
> On 2019/11/19 =E4=B8=8B=E5=8D=8812:22, Amir Goldstein wrote:
> > On Tue, Nov 19, 2019 at 4:14 AM Jiufei Xue <jiufei.xue@linux.alibaba.co=
m> wrote:
> >>
> >> A performance regression is observed since linux v4.19 when we do aio
> >> test using fio with iodepth 128 on overlayfs. And we found that queue
> >> depth of the device is always 1 which is unexpected.
> >>
> >> After investigation, it is found that commit 16914e6fc7
> >> (=E2=80=9Covl: add ovl_read_iter()=E2=80=9D) and commit 2a92e07edc
> >> (=E2=80=9Covl: add ovl_write_iter()=E2=80=9D) use do_iter_readv_writev=
() to submit
> >> requests to real filesystem. Async IOs are converted to sync IOs here
> >> and cause performance regression.
> >>
> >> So implement async IO for stacked reading and writing.
> >>
> >> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> >> ---
> >>  fs/overlayfs/file.c      | 97 +++++++++++++++++++++++++++++++++++++++=
++-------
> >>  fs/overlayfs/overlayfs.h |  2 +
> >>  fs/overlayfs/super.c     | 12 +++++-
> >>  3 files changed, 95 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >> index e235a63..07d94e7 100644
> >> --- a/fs/overlayfs/file.c
> >> +++ b/fs/overlayfs/file.c
> >> @@ -11,6 +11,14 @@
> >>  #include <linux/uaccess.h>
> >>  #include "overlayfs.h"
> >>
> >> +struct ovl_aio_req {
> >> +       struct kiocb iocb;
> >> +       struct kiocb *orig_iocb;
> >> +       struct fd fd;
> >> +};
> >> +
> >> +static struct kmem_cache *ovl_aio_request_cachep;
> >> +
> >>  static char ovl_whatisit(struct inode *inode, struct inode *realinode=
)
> >>  {
> >>         if (realinode !=3D ovl_inode_upper(inode))
> >> @@ -225,6 +233,21 @@ static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
> >>         return flags;
> >>  }
> >>
> >> +static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long re=
s2)
> >> +{
> >> +       struct ovl_aio_req *aio_req =3D container_of(iocb, struct ovl_=
aio_req, iocb);
> >> +       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> >> +
> >> +       if (iocb->ki_flags & IOCB_WRITE)
> >> +               file_end_write(iocb->ki_filp);
> >> +
> >> +       orig_iocb->ki_pos =3D iocb->ki_pos;
> >> +       orig_iocb->ki_complete(orig_iocb, res, res2);
> >> +
> >> +       fdput(aio_req->fd);
> >> +       kmem_cache_free(ovl_aio_request_cachep, aio_req);
> >> +}
> >> +
> >>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *ite=
r)
> >>  {
> >>         struct file *file =3D iocb->ki_filp;
> >> @@ -240,14 +263,28 @@ static ssize_t ovl_read_iter(struct kiocb *iocb,=
 struct iov_iter *iter)
> >>                 return ret;
> >>
> >>         old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> >> -       ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos,
> >> -                           ovl_iocb_to_rwf(iocb));
> >> +       if (is_sync_kiocb(iocb)) {
> >> +               ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos,
> >> +                                   ovl_iocb_to_rwf(iocb));
> >> +               ovl_file_accessed(file);
> >> +               fdput(real);
> >> +       } else {
> >> +               struct ovl_aio_req *aio_req =3D kmem_cache_alloc(ovl_a=
io_request_cachep,
> >> +                                                              GFP_NOF=
S);
> >> +               aio_req->fd =3D real;
> >> +               aio_req->orig_iocb =3D iocb;
> >> +               kiocb_clone(&aio_req->iocb, iocb, real.file);
> >> +               aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> >> +               ret =3D vfs_iocb_iter_read(real.file, &aio_req->iocb, =
iter);
> >> +               ovl_file_accessed(file);
> >
> > That should be done in completion/error
> >
>
> Refer to function generic_file_read_iter(), in direct IO path,
> file_accessed() is done before IO submission, so I think ovl_file_accesse=
d()
> should be done here no matter completion/error or IO is queued.

Mmm, it doesn't matter much if atime is updated before or after,
but ovl_file_accessed() does not only update atime, it also copies
ctime which could have been modified as a result of the io, so
I think it is safer to put it in the cleanup hook.

Thanks,
Amir.
