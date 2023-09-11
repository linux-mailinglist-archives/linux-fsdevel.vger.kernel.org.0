Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6299879B90C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbjIKU5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbjIKNYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:24:10 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099A193
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:24:03 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a29ef55d5fso1622008241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438642; x=1695043442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsMsgqrmqdgi/6CAHFaZl/61qcxgfSC3HP0lUh5XVzM=;
        b=EKRrqpV81ipI+IJvnQ4GqhoaOMAVRh15ttTByQxW2ULi65U/edXr3lXugmHPJf4QEf
         1uCpvmFmRZbmGhNzVvcb0XGQ9h8EjfIM24y3l58gXtm61k/iL9nAptnGYSnQBuc2KIJ+
         DeePSHeOFCKdL4AyBfiqe8HIU1EYVDVgUo4ZKeS1OZezqZXp2qBgsYh35DgZSDTMmxLb
         gsC3EV4PcvJIF4WcQQ+f4qIUy6xQ74je+cgtxKY8WUxxX3E0qVtkYlDhrGlEcLvuja3P
         lgMQFgoWTMWwFSWOzT1/87xwB44p8E3zwmOj3PsVQJL4xfBkg+Yo/U21ngpyL10RTcuP
         TfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438642; x=1695043442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsMsgqrmqdgi/6CAHFaZl/61qcxgfSC3HP0lUh5XVzM=;
        b=elEp9j6zz2NzwE5v/ddV3uCKBDJ/LAuK6b9x5DMrlyQeD37tBflTvx9y8xbFVIbecD
         O5KXc+9JXQQJUHxaA58732U8uMGPo5psaGnLVbRFOKNSsQL4vrxWAHcmALkDPYUCSkrc
         qrm1dE53u85BHSEJbXZIxqmpkPxm5nU3Ax1fTYjW9iZ2wvVSYIj302bKG4DX3U98ozej
         XXlTBV5JNoi+FCY2SYzVwMjlmASYY5KE542LzLqTePUazfTK4hGjIHB3Mxz0L30JHSaj
         DM/Ho16Z9Aan74wCZOFFYDSmtJwiih/a1ihmUiPXCZBbzjsXjHRk+GBIh1Gd5aizpVWi
         6QAQ==
X-Gm-Message-State: AOJu0YzEczPumRkdt+eZlBeIurFEk/reL8tjtw3xWTFzTJgXsyUOcuvK
        XOBYg+U/muQ23VoTM4vKHOaMzcCWrDWPzNocqSw=
X-Google-Smtp-Source: AGHT+IFTS+6212FoIePvPupBxqCbjHHpMJHdCQMpGmKNTl4JOSfzrqrQ8+V9vlNuJXcbAXeXgGpkUz+flTYrHC9EjgI=
X-Received: by 2002:a67:f594:0:b0:44d:40b1:9273 with SMTP id
 i20-20020a67f594000000b0044d40b19273mr6932738vso.4.1694438642662; Mon, 11 Sep
 2023 06:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230911114713.25625-1-reubenhwk@gmail.com>
In-Reply-To: <20230911114713.25625-1-reubenhwk@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Sep 2023 16:23:51 +0300
Message-ID: <CAOQ4uxizQDAMUX--tJkGG8CF38adj3QRqHcsXo6yU20yREBABQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:49=E2=80=AFPM Reuben Hawkins <reubenhwk@gmail.com=
> wrote:
>
> Readahead was factored to call generic_fadvise.  That refactor added an
> S_ISREG restriction which broke readahead on block devices.
>
> This change removes the S_ISREG restriction to fix block device readahead=
.
> The change also means that readahead will return -ESPIPE on FIFO files
> instead of -EINVAL.
>
> Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNE=
ED")
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Christian,

I suggest adding the link to the original bug report on commit:
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhE8En64rr3mx1UAOqqzb3A=
-GoeR7cx2D+V73ytr6YLjw@mail.gmail.com/

Thanks,
Amir.

>  mm/readahead.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index e815c114de21..ef3b23a41973 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -734,8 +734,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t =
count)
>          * on this file, then we must return -EINVAL.
>          */
>         ret =3D -EINVAL;
> -       if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> -           !S_ISREG(file_inode(f.file)->i_mode))
> +       if (!f.file->f_mapping || !f.file->f_mapping->a_ops)
>                 goto out;
>
>         ret =3D vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
> --
> 2.34.1
>
