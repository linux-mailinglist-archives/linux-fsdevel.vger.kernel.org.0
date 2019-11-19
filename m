Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21570101269
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 05:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKSEWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 23:22:21 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39738 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfKSEWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:22:21 -0500
Received: by mail-yw1-f66.google.com with SMTP id d80so6824588ywa.6;
        Mon, 18 Nov 2019 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXyO0LU93cPoCWtcH+7wjsJBed5XkIqLv/Cj0PpC+xg=;
        b=SoNKJx3Mdp82cLyJXPpcs+72byPuipRgPuwRw94+i/9SmmWgyqW13K/7uoO6RZQiXT
         AXBVCaNADwLtM27MtV4oUY4xiFaeFxaoQJkOWpP/cosy+nHEVMmiddAB/GsaLxoNx3m3
         RZJxnKv+CJTXcootKvkxbNf0SyW8h3E7B87bwTdq1kJhjFWTNKNZ79QwdetHtUsSQPag
         k+IX4CX/xku47HmpAKKYeHSNQIrvWGel4d6H9oun4K/qetycLvK3DsqgjdO8RiUTMY8r
         XzuDFO5tZhJEyBI6TC7duniDkKjupE2FQ8QotJ4ggISMlv/Bbo4ViphcpOP+BCDrN8+j
         Bjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXyO0LU93cPoCWtcH+7wjsJBed5XkIqLv/Cj0PpC+xg=;
        b=oBx1mfXO6JfkIl3XzJ9l1kTJzGrm5IvezjYhcAep/mH5KdB9SulQ+zuYVcEH14yBvm
         y9Pxy3MRdtj6xfHGJbj3k6372U6ChrwcDF2orG+4TkIzHW7qD7tUuznXEdnk3YNghkAs
         qbUJgr8vNFmMq+b9A95qrKLX4br/5Y6/5Tkhy+w3uZNqyXxKi4xxaKOUufmSb0s3uCEz
         Odojmj5NyxmP89ewIg4Wid50WusKkZslexPvlWMIPu/aWpMsxCu/bnP51S9AxKDqRHd4
         a43YojMIJoMDsqqhlX4oy86g/KYic5cTRZPUMpnyzEI1O0SIs0ECqL9EFBq9fpSnwUfl
         SIUQ==
X-Gm-Message-State: APjAAAVug+gQReqnyiDnu2Ls1usjZDldU7WchPqdr99CB4TWlHu0bjuC
        mRRoDIgv2OFLNG7LzWQUT7G8BIN9DFj/s6ydy0FR+xsk
X-Google-Smtp-Source: APXvYqxK9xhwxv0LzY2NWPXAyU0IR5xyFo0cbvHSown+miOReqt4pPezGIynLbsY6CTMO+rvxnR/zaqlzKgefsMGVDg=
X-Received: by 2002:a81:3187:: with SMTP id x129mr23682808ywx.294.1574137340128;
 Mon, 18 Nov 2019 20:22:20 -0800 (PST)
MIME-Version: 1.0
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com> <1574129643-14664-3-git-send-email-jiufei.xue@linux.alibaba.com>
In-Reply-To: <1574129643-14664-3-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Nov 2019 06:22:09 +0200
Message-ID: <CAOQ4uxhU0NGqX-P4XTJ+kf6sXNCnUCBxgp1u2-aDV5p15Jh+tg@mail.gmail.com>
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

On Tue, Nov 19, 2019 at 4:14 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> w=
rote:
>
> A performance regression is observed since linux v4.19 when we do aio
> test using fio with iodepth 128 on overlayfs. And we found that queue
> depth of the device is always 1 which is unexpected.
>
> After investigation, it is found that commit 16914e6fc7
> (=E2=80=9Covl: add ovl_read_iter()=E2=80=9D) and commit 2a92e07edc
> (=E2=80=9Covl: add ovl_write_iter()=E2=80=9D) use do_iter_readv_writev() =
to submit
> requests to real filesystem. Async IOs are converted to sync IOs here
> and cause performance regression.
>
> So implement async IO for stacked reading and writing.
>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  fs/overlayfs/file.c      | 97 +++++++++++++++++++++++++++++++++++++++++-=
------
>  fs/overlayfs/overlayfs.h |  2 +
>  fs/overlayfs/super.c     | 12 +++++-
>  3 files changed, 95 insertions(+), 16 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index e235a63..07d94e7 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -11,6 +11,14 @@
>  #include <linux/uaccess.h>
>  #include "overlayfs.h"
>
> +struct ovl_aio_req {
> +       struct kiocb iocb;
> +       struct kiocb *orig_iocb;
> +       struct fd fd;
> +};
> +
> +static struct kmem_cache *ovl_aio_request_cachep;
> +
>  static char ovl_whatisit(struct inode *inode, struct inode *realinode)
>  {
>         if (realinode !=3D ovl_inode_upper(inode))
> @@ -225,6 +233,21 @@ static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
>         return flags;
>  }
>
> +static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
> +{
> +       struct ovl_aio_req *aio_req =3D container_of(iocb, struct ovl_aio=
_req, iocb);
> +       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> +
> +       if (iocb->ki_flags & IOCB_WRITE)
> +               file_end_write(iocb->ki_filp);
> +
> +       orig_iocb->ki_pos =3D iocb->ki_pos;
> +       orig_iocb->ki_complete(orig_iocb, res, res2);
> +
> +       fdput(aio_req->fd);
> +       kmem_cache_free(ovl_aio_request_cachep, aio_req);
> +}
> +
>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -240,14 +263,28 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, st=
ruct iov_iter *iter)
>                 return ret;
>
>         old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> -       ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos,
> -                           ovl_iocb_to_rwf(iocb));
> +       if (is_sync_kiocb(iocb)) {
> +               ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos,
> +                                   ovl_iocb_to_rwf(iocb));
> +               ovl_file_accessed(file);
> +               fdput(real);
> +       } else {
> +               struct ovl_aio_req *aio_req =3D kmem_cache_alloc(ovl_aio_=
request_cachep,
> +                                                              GFP_NOFS);
> +               aio_req->fd =3D real;
> +               aio_req->orig_iocb =3D iocb;
> +               kiocb_clone(&aio_req->iocb, iocb, real.file);
> +               aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> +               ret =3D vfs_iocb_iter_read(real.file, &aio_req->iocb, ite=
r);
> +               ovl_file_accessed(file);

That should be done in completion/error

> +               if (ret !=3D -EIOCBQUEUED) {
> +                       iocb->ki_pos =3D aio_req->iocb.ki_pos;
> +                       fdput(real);
> +                       kmem_cache_free(ovl_aio_request_cachep, aio_req);
> +               }

Suggest cleanup helper for completion/error


> +       }
>         revert_creds(old_cred);
>
> -       ovl_file_accessed(file);
> -
> -       fdput(real);
> -
>         return ret;
>  }
>
> @@ -275,16 +312,32 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, s=
truct iov_iter *iter)
>
>         old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
>         file_start_write(real.file);
> -       ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
> -                            ovl_iocb_to_rwf(iocb));
> -       file_end_write(real.file);
> +       if (is_sync_kiocb(iocb)) {
> +               ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
> +                                    ovl_iocb_to_rwf(iocb));
> +               file_end_write(real.file);
> +               /* Update size */
> +               ovl_copyattr(ovl_inode_real(inode), inode);
> +               fdput(real);
> +       } else {
> +               struct ovl_aio_req *aio_req =3D kmem_cache_alloc(ovl_aio_=
request_cachep,
> +                                                              GFP_NOFS);
> +               aio_req->fd =3D real;
> +               aio_req->orig_iocb =3D iocb;
> +               kiocb_clone(&aio_req->iocb, iocb, real.file);
> +               aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> +               ret =3D vfs_iocb_iter_write(real.file, &aio_req->iocb, it=
er);
> +               /* Update size */
> +               ovl_copyattr(ovl_inode_real(inode), inode);

That should be in completion/error

Thanks,
Amir.
