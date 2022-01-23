Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E665649720B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiAWOXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiAWOXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:23:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7CC06173B;
        Sun, 23 Jan 2022 06:23:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so14119635ejx.2;
        Sun, 23 Jan 2022 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJS00ni3OCNaB136EeYoLr1/HomgMMjbmkb3mzujdFI=;
        b=B61OapB5UZguf7gdBVTOXGVfRurY6/aprVOpZgepOUOQT8EnXr76HGI0Why2qxcqKJ
         oCOiGurjpU8NUzXQwYoV88WwJrqhRQkHXuNW1dlxDJYS5m54Xm1BkOceTuHpvaomD3Y/
         HkQsr+vM75sFW6MRDguXal15uStlR7+Rsq2UXRSNelef7bzwoiTStn1i+wMgznfpQZ2o
         WIV8yloscvS/x2ziGiTp+LNQ8hAhqDro1haTjeMWCOALJ1uK0oxFjGRsAyvo3Qu3Dk1C
         ESDthpbeUR8Tpti56xFfcdT8mJkbzXFkjHFcw2Bl7lqj/YXH+rh1OGtE1kzSH2hGA6Sy
         CydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJS00ni3OCNaB136EeYoLr1/HomgMMjbmkb3mzujdFI=;
        b=G6O3zleNsQYKvm3B9HfWPQPldGO7OE/m+4Pp+8Yn/31DH/9kpdd52fvUhj2R0by17i
         dnaNF/oj2zryPyyovjHeCc52DLQXMXmXfw3NRUzj7V2ALX4pMf7nYYQrnkCU63EfZ/Sc
         Sr4Wo+6AfJkNujZr/8hSyQuKo07FJDBPucv7u00On7KXoBqff2eYmL51IK94U8Y3UTE+
         UHXfa1UFpbyKN6fNGHLwhOSxYvPyx6OpJcYNI43FiIAiJqdHRp/vj6uQqEOnKLnCFtHE
         329Up6jo3Yq1M4Xj/RC0HWD1FxfApHiU6O+/85I5G3o2kq95TubKXY2aRPUzT1fBRuEO
         9OLg==
X-Gm-Message-State: AOAM533MTWAFqYoJt69HgjdtPRcBYcaokxX8xsFEwXIS8ChuB/kEb7hQ
        peokaAhU6nnWj8+fwxNM8AYHDENgI/vajQ4UvQNl+TbiVIY=
X-Google-Smtp-Source: ABdhPJy0yRz9TeDE7ej229TmAXOSE+OGs81DzmLRI9Kxqvp4URIGPzpuu4xt6AAm4lkDuyqfFPTK7Ltn+9eLEFP4Iow=
X-Received: by 2002:a17:907:6d94:: with SMTP id sb20mr679658ejc.139.1642947825525;
 Sun, 23 Jan 2022 06:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20220123100837.GA1491@haolee.io> <Ye1eZ5rl2E/jy8Tk@localhost.localdomain>
 <Ye1fCxyZZ0I5lgOL@localhost.localdomain>
In-Reply-To: <Ye1fCxyZZ0I5lgOL@localhost.localdomain>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Sun, 23 Jan 2022 22:23:33 +0800
Message-ID: <CA+PpKPn3tVsJnijvATXBwfbd_SwcmRps-A-dCJTqi5WYx1Smfg@mail.gmail.com>
Subject: Re: [PATCH v2] proc: alloc PATH_MAX bytes for /proc/${pid}/fd/ symlinks
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com, Kees Cook <keescook@chromium.org>,
        jamorris@linux.microsoft.com, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 9:58 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> From: Hao Lee <haolee.swjtu@gmail.com>
>
> It's not a standard approach that use __get_free_page() to alloc path
> buffer directly. We'd better use kmalloc and PATH_MAX.
>
>         PAGE_SIZE is different on different archs.

This is indeed a worthy addition. Thanks.

Regards,
Hao Lee

> An unlinked file
>         with very long canonical pathname will readlink differently
>         because "(deleted)" eats into a buffer. --adobriyan
>
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  fs/proc/base.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1764,25 +1764,25 @@ static const char *proc_pid_get_link(struct dentry *dentry,
>
>  static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
>  {
> -       char *tmp = (char *)__get_free_page(GFP_KERNEL);
> +       char *tmp = (char *)kmalloc(PATH_MAX, GFP_KERNEL);
>         char *pathname;
>         int len;
>
>         if (!tmp)
>                 return -ENOMEM;
>
> -       pathname = d_path(path, tmp, PAGE_SIZE);
> +       pathname = d_path(path, tmp, PATH_MAX);
>         len = PTR_ERR(pathname);
>         if (IS_ERR(pathname))
>                 goto out;
> -       len = tmp + PAGE_SIZE - 1 - pathname;
> +       len = tmp + PATH_MAX - 1 - pathname;
>
>         if (len > buflen)
>                 len = buflen;
>         if (copy_to_user(buffer, pathname, len))
>                 len = -EFAULT;
>   out:
> -       free_page((unsigned long)tmp);
> +       kfree(tmp);
>         return len;
>  }
>
