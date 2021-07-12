Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2823C62E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhGLSt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhGLSt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:49:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB8C0613DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:46:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u13so5996760lfs.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxXQRushEcGK/228boQLTeFcixL6JKTeFr1JKo01BZI=;
        b=Tlry1eux2Hcx7MU+4zkcbNM31M5MIL6ev1CDwVobZ3dmqyxD3CRbq9n+R5zIeW+f5E
         /pUYGRPccuQmHytw6FAT+URWZgGdXjTk6awgcXP7GMrcm9GkHbXFoDXc3j+725y1Ro9c
         pyL0qYs9udnU+Sg+L7d/g+PVS2NZad3eOsddY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxXQRushEcGK/228boQLTeFcixL6JKTeFr1JKo01BZI=;
        b=J3l7ejHtGIvLvGInnOhOyRqX7mZqbqqsWqImEPzxtNMdjNrIJjDUXUHamQ8qsGDO9L
         97YjUrY1HRPJYE3xuMBROfnQQbhaerIa++QxQSXV4+YmgL5wszSfIwP/QIIJ9Fy4gK5r
         qPRyoSUEbsGelQcwHQjvq9dsIaQQF7jN3kjBPm2hl1oI1GMkky9l7Ddha9oiqyQr4GzK
         VGKxZWVNWGmUm3dnPwUo+vTmTb9B2O626+sIslHphdgUqHXwquOaLhBdMFouv8Z1jTwd
         9tNXxT4uXiN0pf5QEKdvT1LynlldXUUcemvPNKJ0NaSYBp2+nWSapcSl4Pkz34X7Toji
         aHjQ==
X-Gm-Message-State: AOAM531lNVZF6UJ9bfwuzyLz8BGWUNtAbkGtHejr1pG6q6MIdLMb6F/j
        b6csUgWPWe+v2rt0kE8JKUxEFXI2+/GeAUXP
X-Google-Smtp-Source: ABdhPJwRQUPZ1gU1pMx3O7d6uF63iTl9E6yEDY9l0uwxxZhYcZWzP27MtC+JV93FZRtau+YkuB/pfg==
X-Received: by 2002:a05:6512:3b0c:: with SMTP id f12mr159410lfv.22.1626115597177;
        Mon, 12 Jul 2021 11:46:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a15sm1648971ljn.26.2021.07.12.11.46.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:46:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e20so25828095ljn.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:46:36 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr515604ljg.48.1626115595994;
 Mon, 12 Jul 2021 11:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210712123649.1102392-1-dkadashev@gmail.com> <20210712123649.1102392-5-dkadashev@gmail.com>
In-Reply-To: <20210712123649.1102392-5-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 11:46:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFd0qn6asio=zg7zUTRmSty_TpAEhnwym1Qb=wFgCKzA@mail.gmail.com>
Message-ID: <CAHk-=wjFd0qn6asio=zg7zUTRmSty_TpAEhnwym1Qb=wFgCKzA@mail.gmail.com>
Subject: Re: [PATCH 4/7] namei: clean up do_mknodat retry logic
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 5:37 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Moving the main logic to a helper function makes the whole thing much
> easier to follow.

This patch works, but the conversion is not one-to-one.

> -static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> -               unsigned int dev)
> +static int mknodat_helper(int dfd, struct filename *name, umode_t mode,
> +                         unsigned int dev, unsigned int lookup_flags)
>  {
>         struct user_namespace *mnt_userns;
>         struct dentry *dentry;
>         struct path path;
>         int error;
> -       unsigned int lookup_flags = 0;
>
>         error = may_mknod(mode);
>         if (error)
> -               goto out1;
> -retry:

Note how "may_mknod()" was _outside_ the retry before, and now it's inside:

> +static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> +               unsigned int dev)
> +{
> +       int error;
> +
> +       error = mknodat_helper(dfd, name, mode, dev, 0);
> +       if (retry_estale(error, 0))
> +               error = mknodat_helper(dfd, name, mode, dev, LOOKUP_REVAL);
> +
>         putname(name);
>         return error;

which happens to not be fatal - doing the may_mknod() twice will not
break anything - but it doesn't match what it used to do.

A few options options:

 (a) a separate patch to move the "may_mknod()" to the two callers first

 (b) a separate patch to move the "may_mknod()" first into the repeat
loop, with the comment being that it's ok.

 (c) keep the logic the same, with the code something like

  static int do_mknodat(int dfd, struct filename *name, umode_t mode,
                unsigned int dev)
  {
        int error;

        error = may_mknod(mode);
        if (!error) {
                error = mknodat_helper(dfd, name, mode, dev, 0);
                if (retry_estale(error, 0))
                        error = mknodat_helper(dfd, name, mode, dev,
LOOKUP_REVAL);
        }

        putname(name);
        return error;
  }

or

 (d) keep the patch as-is, but with an added commit message note about
how it's not one-to-one and why it's ok.

Hmm?

So this patch could be fine, but it really wants to note how it
changes the logic and why that's fine. Or, the patch should be
modified.

                Linus
