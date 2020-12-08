Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1592D29C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgLHLaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 06:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHLaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:30:13 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06FC0613D6;
        Tue,  8 Dec 2020 03:29:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n14so16537737iom.10;
        Tue, 08 Dec 2020 03:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCKE3v4StapcnBytvUH2x7YoiT2YJZyXA/vHPFP6zjg=;
        b=EKydU3sDv4zhDZO0fVLxDyK+QsgTl8t92XN97u4ouLgmQnRb70RQ3OZ+9xI8thcrGE
         WCh91CKZK8aE0MZSOryQDsAiiBfHWrBUxY6QUYoSVajAzLxQrmz8mKk7uKZLXeSCv+q5
         nYsGHKvlycxJB6EcoYAviVKABFefQRLhuYGBiOIoMtecI6QVWtIYzWF0yLg8wiWuj7vI
         smH2/1M7GfpABVD7JEv9vdQ2jrCUo3wzKRjHdw1G+W1VuvVAj/NI6vV8X3GJaJM93fBO
         WU2aAqOce+TFmhJYyNRDzNRTBAi/BUyqR1Nzo1L2n+EAJb+KFd/B7Dcoy7CruJE8REA2
         dtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCKE3v4StapcnBytvUH2x7YoiT2YJZyXA/vHPFP6zjg=;
        b=GrVp1VbXRzg00sUhZ3Jf1GVXPk0fF8KsHmO28nIcH8eQdLNljLOGr+Y5kaxy4bjLFv
         qxu5o/0U5dMQhCoPdSeTcMkYhbzbzcLutpj0cLOv9yKz3eLP3RfdAGWHDYyJV0SSTkZH
         /0lavyQXmE7pX7DyOH+913yXAjAVskFSY7WmW+5GIS3Pui/VBS36Gs8EFG59fI4v5LwU
         ZaDGTZ4NByl7IMEg2MQeOgKtfYwF5/h/Duz7DJnp1ywCiVaWYnRAmYCt4olqLLopYK3h
         RzdA2G1+m2iNxoMeNaA9UtP7KFb6+H+eE3Guy2Iyzf44Z7vfHK61JsSoN2n9cWTJ7OOZ
         0a8g==
X-Gm-Message-State: AOAM531QP4hbafEEgErScJBK+wr77OXCkmjqG8Ik1Ddj1ZLCwGHChfnV
        ENq7UoWSwiar0vhHDykBRHTiiumN67ciXfMMrxoz6ffsLK4=
X-Google-Smtp-Source: ABdhPJyEbLGY9Bju7JNgzGZC3R/yh1i+ZBxhj2UnXXNS6zSznBtr75WyI1Cs/+ZOt4IyjwGK+8U5fpJjSoJXhnuZtnk=
X-Received: by 2002:a02:b607:: with SMTP id h7mr26517600jam.120.1607426972817;
 Tue, 08 Dec 2020 03:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-9-mszeredi@redhat.com>
In-Reply-To: <20201207163255.564116-9-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Dec 2020 13:29:21 +0200
Message-ID: <CAOQ4uxgy23chB-NQcXJ+P3hO0_M3iAkgi_wyhbpfT3wkaU+E7w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> In case the file cannot be opened with O_NOATIME because of lack of
> capabilities, then clear O_NOATIME instead of failing.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index dc767034d37b..d6ac7ac66410 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
>         err = inode_permission(realinode, MAY_OPEN | acc_mode);
>         if (err) {
>                 realfile = ERR_PTR(err);
> -       } else if (!inode_owner_or_capable(realinode)) {
> -               realfile = ERR_PTR(-EPERM);
>         } else {
> +               if (!inode_owner_or_capable(realinode))
> +                       flags &= ~O_NOATIME;
> +

Isn't that going to break:

        flags |= OVL_OPEN_FLAGS;

        /* If some flag changed that cannot be changed then something's amiss */
        if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))

IOW setting a flag that is allowed to change will fail because of
missing O_ATIME in file->f_flags.

I guess we need test coverage for SETFL.

Thanks,
Amir.
