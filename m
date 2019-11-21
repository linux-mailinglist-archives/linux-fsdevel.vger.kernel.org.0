Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16F11058EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUR6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:58:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfKUR6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574359089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+HheVSg3KznfqidWZHNkJa/MlVGZTiAt2q5bZ2ZimA=;
        b=OourYep0Lh28YeitIMUBydPZlWLu7yIdKJpR5+iPeXfwPENj+MmgRvT9rNtWpvB40B0k9a
        HTi3OE+wwCL7DJQXDBEAYbMadiFuqyoNR+FBs/wkel53OXPVsyzTYqx1fJ/qVi18xPj7Eo
        5Gmxpuid1k9R5+RpelZ/sK+m2ZsBulU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-H0F0vvAlNViwL9zNxqjEvw-1; Thu, 21 Nov 2019 12:58:08 -0500
Received: by mail-ot1-f71.google.com with SMTP id g17so2160047otg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 09:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+HheVSg3KznfqidWZHNkJa/MlVGZTiAt2q5bZ2ZimA=;
        b=d8jo6oFYMkQEzk7We3gexsQbl94mXfJruhY/Cdjk2bKAbrCPkX+0rPMKvXpYGYHGKE
         07aZyKBJdNqy2ySO3+cpJogIB3kOThCy2xZTWpn5naNbBpkQP1mzglY9PEQ8qceFGZMy
         6HE2viR2Ynb3Zw2xbV4t9ZCambeq5RM4U9wSPLTIbTG+waFgBpgvBbaTFEa2G0jgmdaT
         Wn8XrcHWSUHRT1+7KZxpGr1jERWp1DiOjN6ITis5X4ANlypPv9++2/pNqgvCHhqJd/T0
         rLuQH3yTlbaqFF4vPxeO6ANTfbIvPjTc1tUzq6RV/me64CMf6Bt06eeFauoVrI1KNxov
         HrSA==
X-Gm-Message-State: APjAAAVMeuzosJR6bMpFbUkGhV9Xgouo0VAjM3O2be1saRRfJUvkJb1t
        AJPoaKiScJdf68NL8lkbXAQoEsRWhiEwUUdwPQWeDLS1Vj8sOLA27OfYdMcyT8dMHTGLpFjWdBr
        OLLaaCY/FzUslf4CAkmpdpcSBkdKIgwhQEQnxHB+AXw==
X-Received: by 2002:aca:d6d7:: with SMTP id n206mr8783341oig.147.1574359087157;
        Thu, 21 Nov 2019 09:58:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBgLpLbJAc2StJVUTr08ZPysVkE3pL9/oOaGG6fl4uWtM+M0lfH0fqCGvXPfvqurYbxApvjbE3EfzBTA0bXX8=
X-Received: by 2002:aca:d6d7:: with SMTP id n206mr8783328oig.147.1574359086921;
 Thu, 21 Nov 2019 09:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20191019161138.GA6726@magnolia>
In-Reply-To: <20191019161138.GA6726@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 21 Nov 2019 18:57:55 +0100
Message-ID: <CAHc6FU57p6p7FXoYCe1AQNz54Fg2BZ5UsEW3BBUnhLaGq2SmsQ@mail.gmail.com>
Subject: Re: [PATCH v4] splice: only read in as much information as there is
 pipe buffer space
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>, ebiggers@kernel.org,
        Dave Chinner <david@fromorbit.com>
X-MC-Unique: H0F0vvAlNViwL9zNxqjEvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 19, 2019 at 6:14 PM Darrick J. Wong <darrick.wong@oracle.com> w=
rote:
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
> Reported-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>

Reviewed-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>

> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v4: use size_t for pipe_pages
> ---
>  fs/splice.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 98412721f056..9b9b22d2215a 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, str=
uct splice_desc *sd,
>         WARN_ON_ONCE(pipe->nrbufs !=3D 0);
>
>         while (len) {
> +               size_t pipe_pages;
>                 size_t read_len;
>                 loff_t pos =3D sd->pos, prev_pos =3D pos;
>
>                 /* Don't try to read more the pipe has space for. */
> -               read_len =3D min_t(size_t, len,
> -                                (pipe->buffers - pipe->nrbufs) << PAGE_S=
HIFT);
> +               pipe_pages =3D pipe->buffers - pipe->nrbufs;
> +               read_len =3D min(len, pipe_pages << PAGE_SHIFT);
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
> +                       size_t pipe_pages;
> +
> +                       /* Don't try to read more the pipe has space for.=
 */
> +                       pipe_pages =3D opipe->buffers - opipe->nrbufs;
> +                       len =3D min(len, pipe_pages << PAGE_SHIFT);
> +
>                         ret =3D do_splice_to(in, &offset, opipe, len, fla=
gs);
> +               }
>                 pipe_unlock(opipe);
>                 if (ret > 0)
>                         wakeup_pipe_readers(opipe);

