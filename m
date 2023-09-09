Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1E79969E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbjIIGga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbjIIGg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:36:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577631BC1
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 23:36:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c09f1f9df2so2115922a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694241381; x=1694846181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpPG1AIlkj+OP5IsOXVnvmOuKq1QJKw8PNldc54UdKs=;
        b=lpj1/IJvG14xizkj0u6lmsbZ44kuARC+cODFzgLlFQ2E9E2BlGGz3w6zY3LthBLbWy
         2ndmQlR67pdDRcILrv4C5yRkcYVs2/58zqQetWMzyU1nEfl5PeygtoYzLcJiystUVA83
         zQPILCnyHAnAg1tfKvrleYiASOGDxqyq9PYT+QWl2Uk2Lv+guO+sDh/NTT2cHvHlk/Jv
         Lxt+vVUGqh9udbP+2edtgR2Xi43blX0CcK8HWExhYEAbj7YN/WBTy8BeRzz3vFTIbIgV
         xm97X/3pjxqqgq1GK6P3mXMY7aIvR1NAjWZaCY5g7In2N4ccUkyyJ4Usu21Jyrvem6RC
         1FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694241381; x=1694846181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpPG1AIlkj+OP5IsOXVnvmOuKq1QJKw8PNldc54UdKs=;
        b=jgFKI+hHYP8OTO1U/0IP6LXB+8jaWZOpaDf7cUYinofNDNAHUqQ0Gz3uKZhW4oG3M9
         L1GFzUc3PC+HHWWm0L3ngPTMpcrZGHo7SKTW3GD6navnZX76oPxJi4lzM3oL01uplaZs
         Re1EfB0ArdbHtRqRn5KfhW+CQjz5NKbwZIOmUyavnvrLQ6PgFr7uMuBhTgWpY2lxr2zt
         p4kom9O+lGb2Hc8ffqrUbzNBD+ooaewNiZHrC+BtcnahGE0wYZOUAeR+QsF7gLfcig2o
         wKLDs2cnuJ+4tZ4nEmwhkJiWSnkA33N5J1QVL0gHweswrpyl3g6mGYYYb5Bbz2TulYHG
         RluA==
X-Gm-Message-State: AOJu0YxI+mfaFL6xv+DR+LC/3qtLuH1eFvINIPJ7VHs4FrjKLZ7XxtQA
        fWMY+jlWnXCNPnbWTDioesybYQ6Q3zdIVXUWdnc=
X-Google-Smtp-Source: AGHT+IF9F5uZmzUtP9nzyPqzGbEDfwmSjEXx9ogXc1BPWI2H8ObY5gNwh21jKImRHFuyjcGavO1obhYUXpXULrIsuoY=
X-Received: by 2002:a05:6358:c0c:b0:13c:c84b:88b5 with SMTP id
 f12-20020a0563580c0c00b0013cc84b88b5mr5163043rwj.27.1694241381559; Fri, 08
 Sep 2023 23:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
In-Reply-To: <20230909043806.3539-1-reubenhwk@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 9 Sep 2023 09:36:10 +0300
Message-ID: <CAOQ4uxiEmJjWQV=cbrmwXF0N1vyRi8sej9ZqbieUUct4_uWuEw@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
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

On Sat, Sep 9, 2023 at 7:39=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.com>=
 wrote:
>
> Readahead was factored to call generic_fadvise.  That refactor broke
> readahead on block devices.

More accurately: That refactor added a S_ISREG restriction to the syscall
that broke readahead on block devices.

>
> The fix is to check F_ISFIFO rather than F_ISREG.  It would also work to
> not check and let generic_fadvise to do the checking, but then the
> generic_fadvise return value would have to be checked and changed from
> -ESPIPE to -EINVAL to comply with the readahead(2) man-pages.
>

We do not treat the man-pages as a holy script :)

It is quite likely that the code needs to change and the man-page will
also be changed to reflect the fact that ESPIPE is a possible return value.
In fact, see what the man page says about posix_fadvise(2):

       ESPIPE The specified file descriptor refers to a pipe or FIFO.
(ESPIPE is the error specified by POSIX, but before kernel version
2.6.16, Linux returned EINVAL in this case.)

My opinion is that we should drop the ISREG/ISFIFO altogether,
let the error code change to ESPIPE, and send a patch to man-pages
to reflect that change (after it was merged and released),
but I would like to hear what other people think.

> Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNE=
ED")
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
> ---
>  mm/readahead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..877ddcb61c76 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -749,7 +749,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t =
count)
>          */
>         ret =3D -EINVAL;
>         if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> -           !S_ISREG(file_inode(f.file)->i_mode))
> +           S_ISFIFO(file_inode(f.file)->i_mode))

If this remains, it needs to be explained in the comment above
not only in the commit message, so developers reading the code
can understand the non obvious purpose.

Nice job with your first kernel patch Reuben :)

The process now is to wait for other developers to weigh in
on the question at hand.

When there is consensus, you may send a v2 patch
(git format-patch -v2) with review comments addressed.
Before sending the patch you may add notes below the
"---" line that are relevant to the context of the review but
not for git log, most notably, it is useful to list in v2 the
Changes since v1.

Thanks,
Amir.
