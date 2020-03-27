Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AC195CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgC0R0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:26:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgC0R0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:26:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id o26so4872219pgc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2020 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8ps1N/pYBA7KlC6SJyDXK1HkCeJUluIuEnwRO89GEU=;
        b=hmBCjbTgMqFJZImRqjN4cWi+1oiD8+HAEmEByq7V4Xj+pZ40AbphunjFgtdfMF2Y5E
         aiAZ5kx5UWMqooP0//e5S8mGaI8Ns8HwOdDgx7LqV3ixxxKvsuEm2O643LkB5cvQwDNs
         DdPViDg7+o6QLCWbOcgeV5do6umR9em7CJt/8/ncZqGRxQ4GfFy4VTfIRpnRiN0WL3MI
         1LKO95FrPge2Dn8K07Pn/PuHLqlM1eb7ATRyMzvf6cj6cqpbFw8fcGumYtlQRXfSx33h
         G3sfCxaRgBHOnZjHw7bj37vBur+WP4wkmVKnUdPEnQ1j9TvHSPLXH+WUDWzuUQp5s5SP
         JniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8ps1N/pYBA7KlC6SJyDXK1HkCeJUluIuEnwRO89GEU=;
        b=Y3kULJpVBnAh1SE/J1Kz+sTCUYSPZMBOImMpmSTtCR7Kjm+m7/33sJLJCvcwLhHZmc
         9wC3oZZlTRWicYyz53Nch4LsgCnVYk3YqfApq+0fCnfy0AATqK7VW28obKN3xX95h8BC
         u7pgZVCR7+ZOn89f14hA+kht0CYvpAr8wWaFbcG/8gkl9dRv04uSqEHdgORxpgUZgakw
         rM6Yny1ilqef3JCbCFjamsUQb1vatrg0k4yUg8J6s+29BNrc6drV9HAjQWbAF/X6xB3p
         AVCA7pyEi8dSUgUR2xuadds4o+nu1sR9cvjpbG2tZ0keeOfzTn+IBEb0zlWGFgU2KZMW
         cbFQ==
X-Gm-Message-State: ANhLgQ2GKSDe5kHk2AEF+TszIItFgPMVtHs9HeKSKNPRkDS/yHldt28r
        hNhTtLSBLxdFgp3LGFLb8Nk8KDPRN1s2MXJPPIT7AeZn
X-Google-Smtp-Source: ADFU+vskNw4rx9J8k/JB6zNGDuE+XATYo7xfLE+NCQ/VTYSZNrt8mav9Wo2CNYj9Y/bYulHHAACI97tU0sg7i+3mX0I=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr335809pgb.263.1585330005540;
 Fri, 27 Mar 2020 10:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200327171030.30625-1-natechancellor@gmail.com>
In-Reply-To: <20200327171030.30625-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Mar 2020 10:26:34 -0700
Message-ID: <CAKwvOdkHSRZy_BjyWx2sdZ89CwmMaHAJrNf_xmiGQDphrqjEiA@mail.gmail.com>
Subject: Re: [PATCH -next] fanotify: Fix the checks in fanotify_fsid_equal
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:10 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> fs/notify/fanotify/fanotify.c:28:23: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                              ^
> fs/notify/fanotify/fanotify.c:28:57: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                                                                ^
> 2 warnings generated.
>
> The intention was clearly to compare val[0] and val[1] in the two
> different fsid structs. Fix it otherwise this function always returns
> true.
>
> Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
> Link: https://github.com/ClangBuiltLinux/linux/issues/952
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch. Subtle bugs that are off by one character have
always been hard for me to spot!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 7a889da1ee12..cb54ecdb3fb9 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -25,7 +25,7 @@ static bool fanotify_path_equal(struct path *p1, struct path *p2)
>  static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
>                                        __kernel_fsid_t *fsid2)
>  {
> -       return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
> +       return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
>  }
>
>  static bool fanotify_fh_equal(struct fanotify_fh *fh1,
> --

-- 
Thanks,
~Nick Desaulniers
