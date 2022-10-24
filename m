Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F01609E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJXJnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJXJnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:43:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8E63F11;
        Mon, 24 Oct 2022 02:43:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v27so6740854eda.1;
        Mon, 24 Oct 2022 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lvTCug/WGu2tB0i/Ce81Igi5v0dyO+fR3fhU50OBOLc=;
        b=HGY9o0eP+6q5QlQ/V5gHWdcwzG3/+7IiLYRbIZDG8ivyto0icbJB/L4llkm6/u6dB5
         pEzNIXI1F6ZmyEsuxDbZeaUQfQ3wEst6h/JTGhWspJIIEHX/b4M39E6GhwiNmJNi9RPS
         DNO1X32e92qFIYV4fJEQZWASm02uJ2ZVq06R/hiIJVtAR8t0ousahUtFgZ4V+9rkV/d4
         SdS8V/YzuBKge9lJbeRIaGl9r9WljxHNNWmvmsMfMny2sX8dwfrsD6kJSjn22kK9oh/r
         hIbNpvUPkVDrO5WrKLirQUnYUrteNuOxyNe77ul5jiMNM5w3jPQMZnqGJHArevh85g2e
         pBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvTCug/WGu2tB0i/Ce81Igi5v0dyO+fR3fhU50OBOLc=;
        b=Kx3SD/MDcIIWc9r61bKYDOBq+pn/GLtCbZ94WZYFvos8c2We7yPoe1w3sZwDtU2Cqc
         iGBXmpN2hHSpeXQ2GDvLaMAADcAxOnjSIiiqtdsyY1JskWn6JOkcmp3ewwhqHySlW6Xp
         se0iwyKQA9EiBsO12gauO9kT+W489sdZ+5xYDfD4cOWDTuzbWJLmmbtnUAuK8HvktTB7
         Qd3J5y1a8cXrmiYBgWPE7EpHBgPRrDK+O+PT8B77t4jj0+029yYr9q+/y6pCYVZxpqER
         PrTNyypV/rAzi+l6UbXAUDZOP3kUjRzdJUYpOpUc4LUn/3jFV1G1Q5esXblNETGsUlsD
         gdFQ==
X-Gm-Message-State: ACrzQf3YQpuWetIdh2I2zt2XB2bm5USJf6BBEfTiPtAdLJytXO6v6RZq
        LpO643REjJtNPZm3nWQIzfJUPOUDU9tPx9l/0z0=
X-Google-Smtp-Source: AMsMyM6YCPqmGHU4Yv+WgY3/mBRU+k1PehOBWkGLUn/NSsQx0nMbwe7NvuaZO7bNuImAmiKOzxyNnT5+8WgQudOE70k=
X-Received: by 2002:a05:6402:2949:b0:451:fabf:d88a with SMTP id
 ed9-20020a056402294900b00451fabfd88amr29383306edb.324.1666604583226; Mon, 24
 Oct 2022 02:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221023163945.39920-1-yin31149@gmail.com> <20221023163945.39920-5-yin31149@gmail.com>
In-Reply-To: <20221023163945.39920-5-yin31149@gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 24 Oct 2022 11:42:49 +0200
Message-ID: <CAHpGcMK0C6uxuNwhOouHLz7fyCcu=JH63COX_0J72koZk_CS7w@mail.gmail.com>
Subject: Re: [PATCH -next 4/5] gfs2: fix possible null-ptr-deref when parsing param
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>, 18801353760@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com,
        cluster-devel@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am So., 23. Okt. 2022 um 18:46 Uhr schrieb Hawkins Jiawei <yin31149@gmail.com>:
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string()
> if fs string has zero length.
>
> Yet the problem is that, gfs2_parse_param() will dereferences the
> param->string, without checking whether it is a null pointer, which may
> trigger a null-ptr-deref bug.
>
> This patch solves it by adding sanity check on param->string
> in gfs2_parse_param().

Yes, but then it dereferences param->string in the error message. That
won't help.

> Reported-by: syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com
> Tested-by: syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com
> Cc: agruenba@redhat.com
> Cc: cluster-devel@redhat.com
> Cc: linux-kernel@vger.kernel.org
> Cc: rpeterso@redhat.com
> Cc: syzkaller-bugs@googlegroups.com
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index c0cf1d2d0ef5..934746f18c25 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1446,12 +1446,18 @@ static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>
>         switch (o) {
>         case Opt_lockproto:
> +               if (!param->string)
> +                       goto bad_val;
>                 strscpy(args->ar_lockproto, param->string, GFS2_LOCKNAME_LEN);
>                 break;
>         case Opt_locktable:
> +               if (!param->string)
> +                       goto bad_val;
>                 strscpy(args->ar_locktable, param->string, GFS2_LOCKNAME_LEN);
>                 break;
>         case Opt_hostdata:
> +               if (!param->string)
> +                       goto bad_val;
>                 strscpy(args->ar_hostdata, param->string, GFS2_LOCKNAME_LEN);
>                 break;
>         case Opt_spectator:
> @@ -1535,6 +1541,10 @@ static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>                 return invalfc(fc, "invalid mount option: %s", param->key);
>         }
>         return 0;
> +
> +bad_val:
> +       return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
> +                      param->string, param->key);
>  }
>
>  static int gfs2_reconfigure(struct fs_context *fc)
> --
> 2.25.1
>

Thanks,
Andreas
