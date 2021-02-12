Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6E319AEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 08:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBLHzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 02:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhBLHzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:55:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893EDC061574;
        Thu, 11 Feb 2021 23:54:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id o7so7483364ils.2;
        Thu, 11 Feb 2021 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCB2kbjBkQLemu9AHDY3kY6Hrb0Y/ddhumLKsf8HK40=;
        b=AQHFe16peo/zMkKT6qW9oOtLqrF2QChVprrQv6bT9qGcRvkOyb6adrJY86wDonZXSZ
         m01kMmDBZQeH+CkR8UI9MixXdig8VO/utnTME9PXfaSY7mToHLjuXvvXU8bzQvkoh8gG
         QXPPRmk6gQx8nQaeV1cb4Kl9Emw0Q0ma5vJLfG5GQDzvgDYEvPZUEBd9bsGEyNSAH1y9
         mOst1FNP/ffrCcEnxathNX9Qjdx6BtGRFL+uXZneWCBIqDsaPwA1xA6AGcTwiqf5Lrw2
         BmQH5IJA4F7+P4XLbm6pocL/PD2M/C/Gedj3Z9zBhWgbLj2F+Sh1pAEYbxq6d1F1Vh6/
         bZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCB2kbjBkQLemu9AHDY3kY6Hrb0Y/ddhumLKsf8HK40=;
        b=raTrSIbCKaM3Nd1VhZKEUNRwcIitFZWZzzGbcEQ90DAEKbFw7tJKp+RNFqCgxRUMZz
         p4EYmIzfWBFVxaXmztMAAbAjlMMGVTlBF/p0IjI1OsS1JnX8H2gD/ZkQ+yc1mV+aM1rG
         +Od4uu8P+D0Vx1oI4F0sg17cn4FhuhYQ+IXyAblHEXijVSeY3ciaR1oReYWfX848vyS1
         vcL1TC69IJsSMJNGuHMl934kU5uvWnpwjHhNm598QT/yMtwYQPPy50ds1rCMhWeyP0Jh
         RFwA9lx5E74wNLls0UP381EVdKvYonU9qH/7lnG7/3UqxdjVkcBYxkiCwqibIepddcOu
         zviA==
X-Gm-Message-State: AOAM533cFon2oaALILqzMaO/GjxfSKdPqvjN8uysMf4Dg0F+1+TXvqGs
        9Uf4bi13SsAeWzc65kqFU3of5hhCtMdGVuBELjU=
X-Google-Smtp-Source: ABdhPJxhYwi9JJC0QKyh13UP9yvDNwo060FN2nV1suiSZvrYZCG7gYUtaF2PT76gxNiZRHEEYcxawPg9o3GHoMNjD/0=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr1528152ilp.275.1613116475030;
 Thu, 11 Feb 2021 23:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org> <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
In-Reply-To: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Feb 2021 09:54:23 +0200
Message-ID: <CAOQ4uxgZzbDV3REOBbq42u9VR8byLpwn7zBuyrePxY+1cJwM3w@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:47 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Filesystems such as procfs and sysfs generate their content at
> runtime. This implies the file sizes do not usually match the
> amount of data that can be read from the file, and that seeking
> may not work as intended.
>
> This will be useful to disallow copy_file_range with input files
> from such filesystems.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> I first thought of adding a new field to struct file_operations,
> but that doesn't quite scale as every single file creation
> operation would need to be modified.
>
>  include/linux/fs.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3482146b11b0..5bd58b928e94 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2335,6 +2335,7 @@ struct file_system_type {
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_THP_SUPPORT         8192    /* Remove once all fs converted */
>  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during rename() internally. */
> +#define FS_GENERATED_CONTENT   65536   /* FS contains generated content */

Can you please make the flag name a little less arbitrary.

Either something that conveys the facts as they are (e.g. "zero size
but readable")
or anything that you think describes best the special behavior that follows from
observing this flag.

The alternative is for the flag name to express what you want
(e.g. "don't copy file range") like FS_DISALLOW_NOTIFY_PERM.

Also, I wonder. A great deal of the files you target are opened with seq_open()
(I didn't audit all of them). Maybe it's worth setting an FMODE flag
in seq_open()
and some of it's relatives to express the quality of the file instead
of flagging
the filesystem? Maybe we can do both to cover more cases.

Thanks,
Amir.
