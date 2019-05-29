Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE22E56D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE2TfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:35:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37754 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2TfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:35:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id l66so1234269ybf.4;
        Wed, 29 May 2019 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tw/in4/0sPsFRAIVvFcpom08CNRPJsSaR96xe+JZPYg=;
        b=blwqqvIRbfuZTPTkrA3m0cr6Agq3a/vrtFTz1ERWN1amDZwfaEgVfuj4iedPvbA42v
         hXY7I17xk9dGtECbCcLE+DRtUj98OE8VIXOWZZJ89n7uGvl02UTsYXhE2Tlm+z4mA66t
         Qr8znFizytl1gVs3YRpa4IGe55fBifJAx+P7MdcJf/FGRT796nzUKFAVXwbanSwqeSBc
         k8eWIS4U+QS7zlkIgMHYRcUm7bM748E8rXkTWsnuTssYg8or9leX64thXDG7KyMg157w
         Tp8+JrbDJVw6KEYEkcylxraqQi9OpwjfexR0pUjNuzF8ZougS4wBHcQiN5ZQrG1pxq1K
         5gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tw/in4/0sPsFRAIVvFcpom08CNRPJsSaR96xe+JZPYg=;
        b=AtIQoNtUdTm6uy2G0z6dOm1OvcFt62eqBwgTbYzsExMsEPSFl6xh8QNtkFXNAAlZbe
         Z+E8b9shO+zmrwrIiFIg4r/UbQ/wAjfWpTuYoagS/MdRcTPoqq6spplbu4LBEnH77AFD
         06IKk4Iae3DOBJLeARc5+RSYhzhdFcOB3qFEOHDAWdEcfy6B2OUMQGaTRlsznycV7BkY
         pyQtj0qAumETcRIUPhTnOUs8FVI1ynBpTBDqDbLXAuDbMHHNPweOslzwpaRLeD+y/TvD
         K7S7v9GCYCH5Ol/i3fdkzZ/IgxGuB6eFsqZ8Mjvqt63iXy7TSrHZ9okxy7Ir1B9LrwjA
         g2Xw==
X-Gm-Message-State: APjAAAVf8UmA7DZgaWYUH23TqyFN/QwqpT1aSwkna561ug7cNbyQrbGX
        IE0uexBsmGUoLhRxauXNS6FCSTt1J1S+foi+1eI=
X-Google-Smtp-Source: APXvYqzDG065k4a6H1IhjpBR3X395x+Om89FnS31oSjmModtDcEA7x7uaPzMucpSI+MEJvCbOm6lpOYCuxvv13R2nzw=
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr318648ybs.144.1559158509227;
 Wed, 29 May 2019 12:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-13-amir73il@gmail.com>
In-Reply-To: <20190529174318.22424-13-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:34:58 +0300
Message-ID: <CAOQ4uxgYM_eM==uqGQuKiGb+f08qs53=E+DONMMzW=N-Ab5YZA@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] nfs: copy_file_range needs to strip setuid bits
 and update timestamps
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Olga,Anna,Trond

Could we get an ACK on this patch.
It is a prerequisite for merging the cross-device copy_file_range work.

It depends on a new helper introduced here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a

Thanks,
Amir,

On Wed, May 29, 2019 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Like ->write_iter(), we update mtime and strip setuid of dst file before
> copy and like ->read_iter(), we update atime of src file after copy.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfs/nfs42proc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 5196bfa7894d..c37a8e5116c6 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -345,10 +345,13 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
>
>         do {
>                 inode_lock(file_inode(dst));
> -               err = _nfs42_proc_copy(src, src_lock,
> -                               dst, dst_lock,
> -                               &args, &res);
> +               err = file_modified(dst);
> +               if (!err)
> +                       err = _nfs42_proc_copy(src, src_lock,
> +                                              dst, dst_lock,
> +                                              &args, &res);
>                 inode_unlock(file_inode(dst));
> +               file_accessed(src);
>
>                 if (err >= 0)
>                         break;
> --
> 2.17.1
>
