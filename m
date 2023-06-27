Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1529673F42C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjF0GCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjF0GCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:02:25 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F841BEC;
        Mon, 26 Jun 2023 23:02:24 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-47dcb8a5e89so236773e0c.0;
        Mon, 26 Jun 2023 23:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687845743; x=1690437743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5dvk1R75OBQO1y2Ih8lBMCAI5bqmNywon30Fjv9uYI=;
        b=pvDisVWqvpE6QGxAqe7G+xS35NrUJRtekEDynHd+zwxkHvvaG3haCALNkeXe7Rx14M
         XzsP3b7ycN76JwUR27FRwxETKaYOcpTWYNK10je1fCQ/6DSc6gjGSDID2mBsYjZIAeGL
         pzHlQFtbR3Gyt43BXf5ZFxhx3KUTD0zgQ0tI049lodo+5HSBT23KsN6gYIY+WOUcT8Y5
         3ufZGHtO1xygayIylzcuS2KvSrJgKqMECf/Ydb3L9tGflivIHf4E+8px81U0XHwTfMMO
         sK7hb4fAOSBVErAZOpnCpZLikFYk0MbkevqIP8flH9W3Phr7SbECoYy6dh+C3zX8JsGG
         cN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687845743; x=1690437743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5dvk1R75OBQO1y2Ih8lBMCAI5bqmNywon30Fjv9uYI=;
        b=bqjgvpfRpvGbFUHfdU9BlRMfsYptuh9mLTAGMysxSZwg5dixi/y6NFQGTlCZIW6LcN
         ikqIrSeoGi9lMK1FDZzol4n60FnZ5XAmyOISR2//8flbA2E6btCrIapV8oF0DOSyXLJ3
         qjpnvxdUF9CsKIv3Eyn97xKBD8ENKBVDpGVWdslqj1PHaKr9G8haqhzts9/sWr2WbTxl
         4Nm/rj1+XcxV+/MFAa7cWy9VbT0Gt3PfDfltpBgdc3rPYmGdw08h4GwzgkMy8S6bhOWM
         WiasaLQcMSsOtPy4CqNLRuMJcxTQl9wWvKZ2VafHB4o/RZ7hXIVx/9VDiP3erys4u/N0
         UzYQ==
X-Gm-Message-State: AC+VfDz7dqZWf4kXuB7yiDwOzPCwKmiDzms2Fyoiz+BJw0+K0+fNWHby
        wJNxPHFau2BpCVIEWV51qR/TNHlbTXj8bCl+X44=
X-Google-Smtp-Source: ACHHUZ7S23OxBIzYQoAJe3MeOSJiJWbRlWpQ17Gjn+tztPcB62kDqlAA0Nxb9ma2BtQdBV9Lwa/REo0ftLU5qbYkQ4M=
X-Received: by 2002:a1f:2917:0:b0:46e:96f3:20e6 with SMTP id
 p23-20020a1f2917000000b0046e96f320e6mr7216115vkp.7.1687845743195; Mon, 26 Jun
 2023 23:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
 <al4pxc2uftonry5vyunx5qblllbaakjsehrc74fbbk7pxddyv7@gn3k55eldmmp>
In-Reply-To: <al4pxc2uftonry5vyunx5qblllbaakjsehrc74fbbk7pxddyv7@gn3k55eldmmp>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 09:02:12 +0300
Message-ID: <CAOQ4uxjis1CbC+ZMXrr3ez4b=X4PRSWE6NVN=vFgukJOjuGPqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 2:09=E2=80=AFAM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> The current behaviour caused an asymmetry where some write APIs
> (write, sendfile) would notify the written-to/read-from objects,
> but splice wouldn't.
>
> This affected userspace which used inotify, like coreutils tail -f.
>

typo: uses?

But this comment is not very clear IMO.
Please imagine that the reader is a distro maintainer or coreutils maintain=
er
How are they supposed to react to this comment?
Is this an important fix for them to backport??
How does this change actually affect tail -f?
Does it fix a bug in tail -f?
As far as I understand from our last conversation, the answer is
that it does not fix a bug in tail -f and it won't affect tail -f at all -
it would *allow* tail -f to be changed in a way that could improve
some use cases. Right? improve in what way exactly.

The simplest way to explain this fix perhaps would be to link to
a patch to tail and explain how the kernel+tail fixes improve a
use case.


> Fixes: 983652c69199 ("splice: report related fsnotify events")
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> No changes since v1 (except in the message).
>
>  fs/splice.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 3e06611d19ae..94fae24f9d54 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1154,7 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
>                 if ((in->f_flags | out->f_flags) & O_NONBLOCK)
>                         flags |=3D SPLICE_F_NONBLOCK;
>
> -               return splice_pipe_to_pipe(ipipe, opipe, len, flags);
> +               ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
> +               goto notify;
>         }
>
>         if (ipipe) {
> @@ -1182,15 +1183,12 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>                 ret =3D do_splice_from(ipipe, out, &offset, len, flags);
>                 file_end_write(out);
>
> -               if (ret > 0)
> -                       fsnotify_modify(out);
> -
>                 if (!off_out)
>                         out->f_pos =3D offset;
>                 else
>                         *off_out =3D offset;
>
> -               return ret;
> +               goto notify;
>         }
>
>         if (opipe) {
> @@ -1209,18 +1207,23 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>
>                 ret =3D splice_file_to_pipe(in, opipe, &offset, len, flag=
s);
>
> -               if (ret > 0)
> -                       fsnotify_access(in);
> -
>                 if (!off_in)
>                         in->f_pos =3D offset;
>                 else
>                         *off_in =3D offset;
>
> -               return ret;
> +               goto notify;
>         }
>
>         return -EINVAL;
> +
> +notify:
> +       if (ret > 0) {
> +               fsnotify_access(in);
> +               fsnotify_modify(out);
> +       }
> +
> +       return ret;
>  }
>

Sorry I haven't noticed this in the first review, but goto is not really ne=
eded.
We make the three cases if{}else if{}else if{}
and return -EINVAL in the else case.

It's not really that important, just a bit nicer IMO, so as you wish.

Thanks,
Amir.
