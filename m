Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EDD7501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfJOLbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 07:31:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32890 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOLbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:31:32 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so45133835ior.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+0aOq5/KJqa5A5mabjoe4CtVEBeOSUgcAKPvywC0uM=;
        b=ixWxCYesyTSYCZ/PQSKwn9t/GvD0u42wkLjnvIdCzC3DLvoyvcBWZkznCqEVez+oeR
         Gf9tPSuymQ43Vq52spUP9suh7jM0KVvrHx9HtTB+xvLxq8beOB6iYupuBmlRxIOXYSJJ
         81uJhrqjBYAGxAsb80v6PWW3xhel9l3+Eq+zxqTJwosmUyLvuvI5NrYhyn8UJQvcLKPg
         jpAVHtqK+MMCi5fLoPXf2hQxV3D4RTQRBK/8q0gsORArqiipEsvfppppsUNwPhWIKTcu
         /MbNNYlMtTy0DCL24KVt7kyfPKV7InXPHRaENlwM0Arr4vLkZhwZvkl0ZtatuIP+g6GD
         FLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+0aOq5/KJqa5A5mabjoe4CtVEBeOSUgcAKPvywC0uM=;
        b=DWTSa4jX94w+APzOE8Ogpzfl3oYVdJ6lTdqqYDVdxOGi6WppeSB9B/50QkhUJ4Ex+H
         fqpCdvHo+8md48Yda76/MDLPbbpfEUN1aDwdJj+2Met1F3QpY6QjI7LarXlUMShTL0Wh
         tdaXHcmVi3vwEo9shG7TQDmUwpelKKgP8czgAdApRp9DGRwXuXkil4Se8KssiEMcjW+i
         tRr/t7L6T0SclvEXE/bPmovuL2oce+lEYkspubQAlcluxINqO3Eur+hgN/Oeze62BKrI
         YNbVO81WSxIuSFc+nkh5v12Uxx5DYpQ56yKSHPOu7pjVx0j28hmamOt8erRSQq7tcNCy
         HE9A==
X-Gm-Message-State: APjAAAVrZmjZB1lJRK3znQJUlWJvnFw31fHnJYFOgLtWVj73A55CWllV
        uoQ+wSkQngGRxSeprCrgtuSytF3sPPc9DWUbqGg=
X-Google-Smtp-Source: APXvYqwpYGWlbFlfC5cc8hHmgOoAVvTHr+PV5XeIvGBklofpRDo+DDbgTwLrdTFd3TydNsMKnDtVvCi/4Up/5015hJs=
X-Received: by 2002:a02:40c6:: with SMTP id n189mr42419103jaa.52.1571139091812;
 Tue, 15 Oct 2019 04:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191014220940.GF13098@magnolia>
In-Reply-To: <20191014220940.GF13098@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 15 Oct 2019 13:31:20 +0200
Message-ID: <CAHpGcMJB+ZaJ+dFDZ-VEuih8nGJXxGWUFEtjCX3mTWpb6Tfhew@mail.gmail.com>
Subject: Re: [PATCH v3] splice: only read in as much information as there is
 pipe buffer space
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Am Di., 15. Okt. 2019 um 07:33 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> Andreas Gr=C3=BCnbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
>
> Months ago we fixed splice_direct_to_actor to clamp the length of the
> read request to the size of the splice pipe.  Do the same to do_splice.
>
> Fixes: 17614445576b6 ("splice: don't read more than available pipe space"=
)
> Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com
> Reported-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

I've done some minimal testing on top of 5.4-rc3. This patch fixes the
splice issue and also passes the syzbot reproducer. I'll add it to the
set of patches I regularly run fstests on now, but we already know
fstests doesn't cover splice in the greatest depth possible, so that's
unlikely to reveal anything new.

Thanks,
Andreas

> ---
>  fs/splice.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 98412721f056..e509239d7e06 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, str=
uct splice_desc *sd,
>         WARN_ON_ONCE(pipe->nrbufs !=3D 0);
>
>         while (len) {
> +               unsigned int pipe_pages;
>                 size_t read_len;
>                 loff_t pos =3D sd->pos, prev_pos =3D pos;
>
>                 /* Don't try to read more the pipe has space for. */
> -               read_len =3D min_t(size_t, len,
> -                                (pipe->buffers - pipe->nrbufs) << PAGE_S=
HIFT);
> +               pipe_pages =3D pipe->buffers - pipe->nrbufs;
> +               read_len =3D min(len, (size_t)pipe_pages << PAGE_SHIFT);
>                 ret =3D do_splice_to(in, &pos, pipe, read_len, flags);
>                 if (unlikely(ret <=3D 0))
>                         goto out_release;
> @@ -1180,8 +1181,15 @@ static long do_splice(struct file *in, loff_t __us=
er *off_in,
>
>                 pipe_lock(opipe);
>                 ret =3D wait_for_space(opipe, flags);
> -               if (!ret)
> +               if (!ret) {
> +                       unsigned int pipe_pages;
> +
> +                       /* Don't try to read more the pipe has space for.=
 */
> +                       pipe_pages =3D opipe->buffers - opipe->nrbufs;
> +                       len =3D min(len, (size_t)pipe_pages << PAGE_SHIFT=
);
> +
>                         ret =3D do_splice_to(in, &offset, opipe, len, fla=
gs);
> +               }
>                 pipe_unlock(opipe);
>                 if (ret > 0)
>                         wakeup_pipe_readers(opipe);
