Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51F6C43D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 08:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCVHIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCVHIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:08:20 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC832596E
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 00:08:19 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e12so7041417uaa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679468898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC6OZLr4cZwUV71ctMeJXDNArzScDIZCpc+TqVBiy4c=;
        b=IJ+7/SEyiDoi+ip7xcwpi38sKd1GAnyDoJwsjhXid0e3ToEM6te8WnPIldwIVcEErO
         MauSIALxFFrgi+69PNASPufkKXy9K9LA/EcBLd3MSREQoj2g3FIfGiWlJpGC5A/4LtTy
         xT4r/5bqRxN9Ern2O/ccMyw7+1qnaqXyuNSLVEfo3nbePgoEGoxNQwzMibk9PtPmcoEB
         ItIc7CguSI+uWvyp+4oPYFxYIjbdmTrOJkmxZLdR+7YuoaXp523WaX79oyBXqAftkOi3
         ulyiY9wUu+Vh74/N6oE7UQH5C/cJ5ekzFgMq0owpllTpgJCwAvPuMoWTmx3MENf1uRLJ
         lGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679468898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC6OZLr4cZwUV71ctMeJXDNArzScDIZCpc+TqVBiy4c=;
        b=hbpKKYS/pZtu+FsVlUpW9/S3JQbXXO6eKf2gTZtWxurCmnrckw4ZskhVhgb7Cyi5kQ
         LXNmYDcXVWHCj9UbBm7LGE/AyCrTtWzrfC4kkORILeg2b/+Ja6FYe2/pIzmJ/wdoUVoV
         XL/kff2nnx+ZxVgxGcY1D/ZU7LNl49KmWbfy6vDWkZdRe1EM8vf5bMJWuWOXIdJkllE0
         zgw055+M975hA6lNkcrF0CLVOT2eNv3gOB6NxmUvCqSjMuNCChalVPl4ldZBuD1MJfbr
         Xzr8GFyXp2dAxPpXkrpJ1COGAGV0XYszsoiqjGXrkdFdyq6u6pok/7jJBf8PxLEjCZcV
         ohbA==
X-Gm-Message-State: AO0yUKXLPEOoTzN8LtWARq8MXaZ8qyvD7togsvHaIPpybL+g3J/hBbvV
        bOQOsPzHCcF4A7tEPgRkI8Fye543GSZJQR7q2ew=
X-Google-Smtp-Source: AK7set8GFbpWRQKwbeKQKeRAZVZcMD7S66oKQ5y4++vifHdGDnrZgCWFeKGSALErcelDaf2GvyThZBMyg8doCyDaPC8=
X-Received: by 2002:ac5:c74f:0:b0:401:d1f4:bccf with SMTP id
 b15-20020ac5c74f000000b00401d1f4bccfmr945552vkn.0.1679468897697; Wed, 22 Mar
 2023 00:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230322062519.409752-1-cccheng@synology.com>
In-Reply-To: <20230322062519.409752-1-cccheng@synology.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Mar 2023 09:08:06 +0200
Message-ID: <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
Subject: Re: [PATCH] splice: report related fsnotify events
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 8:51=E2=80=AFAM Chung-Chiang Cheng <cccheng@synolog=
y.com> wrote:
>
> The fsnotify ACCESS and MODIFY event are missing when manipulating a file
> with splice(2).
>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Looks good.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/splice.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 5969b7a1d353..9cadcaf52a3e 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -30,6 +30,7 @@
>  #include <linux/export.h>
>  #include <linux/syscalls.h>
>  #include <linux/uio.h>
> +#include <linux/fsnotify.h>
>  #include <linux/security.h>
>  #include <linux/gfp.h>
>  #include <linux/socket.h>
> @@ -1074,6 +1075,9 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
>                 ret =3D do_splice_from(ipipe, out, &offset, len, flags);
>                 file_end_write(out);
>
> +               if (ret > 0)
> +                       fsnotify_modify(out);
> +
>                 if (!off_out)
>                         out->f_pos =3D offset;
>                 else
> @@ -1097,6 +1101,10 @@ long do_splice(struct file *in, loff_t *off_in, st=
ruct file *out,
>                         flags |=3D SPLICE_F_NONBLOCK;
>
>                 ret =3D splice_file_to_pipe(in, opipe, &offset, len, flag=
s);
> +
> +               if (ret > 0)
> +                       fsnotify_access(in);
> +
>                 if (!off_in)
>                         in->f_pos =3D offset;
>                 else
> --
> 2.34.1
>
