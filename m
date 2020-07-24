Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6064122BB4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 03:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGXBS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGXBS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:18:59 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86058C0619D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 18:18:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t131so8280724iod.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4tLdnF+nBG/JIRwbbMC17CHFTg4xvQAaU1fP2FrCHpE=;
        b=n/gbC659c6eUnQn8G8iS+qnG4cflpiNJiR2ot9saLGwUhrNStIXQt2izQutDuJ4s5m
         +m1jwsesTNPIMMDs3EOL4K++R20gXwIPqv2STGcSgooatEjcIeLrUxESUX2wURC0zIvW
         tCmp7ZSJXzQAWz0sEcJLj4MRSEvoTl0Al7F8gxJXUIEtbWZNdOEcDu1ufeRXvJoBJAQl
         sd8SazZDzkKI7JtDJyJGI6zFGXmWLcj3pIixzAyH9UuXXgo4HM6BKbSAb1R5qDk1Wy32
         3hFzHwXQ1Vnz/c1RR3bAt8R8Bp/bArJDDY5AtMJGBRjO5/b3IgjQfaBO4cWIf/pz4bZU
         wSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4tLdnF+nBG/JIRwbbMC17CHFTg4xvQAaU1fP2FrCHpE=;
        b=LsY6z6PrXne/KpZ3Nx2OaIh1FzQov0NIOJvfNlnRGxGFW1VxG9iHVNKPZ/36nuxdNv
         cgu97A7ampXqbAHDxyM+oitFxNEaWqgF0VhFgqLRSIVaLbirC21zj0OLVwJT8qzGKM9Z
         MQd2kP1Mrw+GqK4mHIloqvvO0gN0/j013+9s0QV1Lk+xGpUfW27HRALDHFSq9As4TaZv
         kd+swnOY2HjHntx9iBu44asS+4dZxcVBS5tEoTdv13hgFDgNVmQX87LgYR89y0GrqWgy
         kFEmJVlh8DsB0MV/FK7TjAxbAZEaWaCoaqk3surYCUV2gwP4YiP6k3i1rL9FeSMmxf4Q
         pmtg==
X-Gm-Message-State: AOAM532UQhWyCWBKRKvGGwjgTUgVDidMHyxkix36tmFSPFxZ8EY06MdJ
        bUDjo5q8seRpVlIgquU6NrOQCHjRmjuKILZMeCI=
X-Google-Smtp-Source: ABdhPJyJ2V7Sn4uUGHVcByIHwRIWXUN5depIyNSrtSNGDlkOGP56cAGWTxHuxUr3T6wvmh0X9SSrSBxGRSFPwsbIKMM=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr7765477iom.135.1595553539006;
 Thu, 23 Jul 2020 18:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200723185921.1847880-1-tytso@mit.edu>
In-Reply-To: <20200723185921.1847880-1-tytso@mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 24 Jul 2020 03:18:47 +0200
Message-ID: <CA+icZUU7Dqoc3-HeM5W4EMXzmZSetD+=WkavDgeGqAi4St6t3g@mail.gmail.com>
Subject: Re: [PATCH] fs: prevent out-of-bounds array speculation when closing
 a file descriptor
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     viro@zeniv.linux.org.uk,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 9:02 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Google-Bug-Id: 114199369
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc6+

- Sedat -

> ---
>  fs/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/file.c b/fs/file.c
> index abb8b7081d7a..73189eaad1df 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -632,6 +632,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
>         fdt = files_fdtable(files);
>         if (fd >= fdt->max_fds)
>                 goto out_unlock;
> +       fd = array_index_nospec(fd, fdt->max_fds);
>         file = fdt->fd[fd];
>         if (!file)
>                 goto out_unlock;
> --
> 2.24.1
>
