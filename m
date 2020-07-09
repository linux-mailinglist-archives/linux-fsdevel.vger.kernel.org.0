Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBB21A71A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGISdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGISdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:33:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DDC08C5CE;
        Thu,  9 Jul 2020 11:33:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so2868941ilt.8;
        Thu, 09 Jul 2020 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHEZyWE7VwCf1x1tRPrzetVIBWLuaxeFrzy7zZmV6S8=;
        b=Tw67hNk3iBv5nsp289saAKj/zOMf/f+lZo4rJRRTKWAdZ/r3kS/f7TRKJsYEW28qB0
         CmP3w1HmT/D0HlvNvb/eVhV4qv5ApP1Wr7IaGAdKl+FV8iEsVbWUCcEI3ccDkfeZ+6+b
         kKTaa19ygjl4jrr00ykok0kr/EuJaH8QMYT0clKWFVJroWKqvFI4rl1bl+t591Xv74SK
         j4LB18BimLvZYbjU27eIun4MA2aZbrK775qwdBVsqfCb7iJw3iSoyTBxesirN28AwNkc
         TUQaONLA+viqUNdz4WWLgWAu3UrUVWxO7LOuudPe2V+8UBBlfaR96OagOUBrMnd9LIGr
         rMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHEZyWE7VwCf1x1tRPrzetVIBWLuaxeFrzy7zZmV6S8=;
        b=C8VyRalvL1iOFctQz+/3e6ZiCgQhaYRnPvvtNouvxX0cefo3xcvanLFTHaTMg3HAtz
         gGLPr2xBoQ/VR6Nos4YJbOEKytmLs4R3Vc+AK2+iR7Cgkv5l39Ht9+T0Bd6YFFQ2m3hc
         zOXkv+BOXVriMk9LerUOB0NHhQ2AYiWwpkPMkXcZC+SDbleR7N0uKO1JINQhaiebgXMn
         k5trex2QPWEXgQgOrmdb4OfgazVjqdwU6sWZsuWWNJoUExAW7278grG9//Pc/bdHkrkM
         zAEJ0UG56jsQHz8EaS/XySbb3yh26/fi0zxhH9U0UbazcWsOIRaKW/jOjABMvkbIveLI
         qSkg==
X-Gm-Message-State: AOAM531yAMZ3okeNgkPYdF2rbN8ppmwKDbvQyiC+UmUcD6jFWMXEnfB3
        Pax6b6IJm09Ie864VrZXae/i/pjSzblgiN0PYA==
X-Google-Smtp-Source: ABdhPJz0aJ74OONV+o7uR3BAYqZ/VDd+XCOZ1VG8WQXzTnqCgDGW85ajQHSRfhairvaNgqj/qDjD+8Rap11ir1+SImg=
X-Received: by 2002:a92:10a:: with SMTP id 10mr46282742ilb.172.1594319584958;
 Thu, 09 Jul 2020 11:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de> <20200709151814.110422-17-hch@lst.de>
In-Reply-To: <20200709151814.110422-17-hch@lst.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 9 Jul 2020 14:32:54 -0400
Message-ID: <CAMzpN2gn_5bXt3RNOwvCSAo+79FevWgMYROxbdFAd1mzo9EOhQ@mail.gmail.com>
Subject: Re: [PATCH 16/17] init: open code setting up stdin/stdout/stderr
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 9, 2020 at 11:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work, but
> instead open a struct file for /dev/console and then install it as FD
> 0/1/2 manually.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/file.c                |  7 +------
>  include/linux/syscalls.h |  1 -
>  init/main.c              | 16 ++++++++++------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index abb8b7081d7a44..85b7993165dd2f 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -985,7 +985,7 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
>         return ksys_dup3(oldfd, newfd, 0);
>  }
>
> -int ksys_dup(unsigned int fildes)
> +SYSCALL_DEFINE1(dup, unsigned int, fildes)
>  {
>         int ret = -EBADF;
>         struct file *file = fget_raw(fildes);
> @@ -1000,11 +1000,6 @@ int ksys_dup(unsigned int fildes)
>         return ret;
>  }
>
> -SYSCALL_DEFINE1(dup, unsigned int, fildes)
> -{
> -       return ksys_dup(fildes);
> -}
> -

Please split the removal of the now unused ksys_*() functions into a
separate patch.

--
Brian Gerst
