Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0733232B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 06:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgG3Ed1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 00:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3Ed1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:33:27 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E1C061794;
        Wed, 29 Jul 2020 21:33:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so10605200ile.0;
        Wed, 29 Jul 2020 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/8RnS4x4W8m0YHiu5amCYbnx/T7Aru1VqlIWnTME70=;
        b=DWUKRxNk7x7CVf6W7KRRGPgYHyL4Fi+wLI43Pf4GXCsitNmR19V6LCsj3wSEeYmm04
         yOdGgWO7Vs30/d5rL2j/YCHSSGL/bdIuSibmPVrc/JKIj7ACup+d44DgJs8z9Ssp0h8r
         Fa5DpPibIatS4BAqJ20YbIMA15uvOVKJHGxnK/Lcn7ULIv8uAYwbBnY4yKcZ0EDW+oTO
         8+uwYB9KPaki9LAEswob9fGSs1PW5w+lh2VzeiLkJC8+bFNYYgG6i9TM3ii4fzpMC+bt
         3pDKiONEKLv1FlJeVQmER4mWFGLJAH8kjYIxsifedvKQLxtteyHxepu65gfszGJk30Ip
         6TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/8RnS4x4W8m0YHiu5amCYbnx/T7Aru1VqlIWnTME70=;
        b=hatdDkyVW9emapHQv9+mM8PVvebHoNI6miYOJWn9BF7z6+Zu2euSDbACM/cpPuN41u
         rjOdB6llQ+McafVWsAuSOYlI7Ahu6BDmWQKxvkn06eJbr1fHl2YmjBqueMP5dcbzS7Te
         ixrZTRY44zzO1Vm5LpO8k+iDKXWJSEdAOBVURWOA6niP2JaVoGjSaHgHWlMbGM8Xzif1
         2yIFBUmNfM9gxwCaxxXdxMc1F+rZBRLgbAR217q+FpDp9aPYFW+o2yULupOdETuRwMzX
         jTfKITzEuIXNQnbdADwVfp+v7as3auazYYkQncbzTRtegynzPsgjWIIwLWLe8hCmYGb7
         0adA==
X-Gm-Message-State: AOAM530gFdif35dTen3/cHc2syTTkN+ipO6s4WAu1XgCJXvfQ+aJ66Kd
        S59K272aBlIuZXhzPAhQ1dLItZQUogXX2mC+y6A=
X-Google-Smtp-Source: ABdhPJy/dmKUsQhl8cVEkWj79cLpTgDY5uGzmUwT/INw4PNci3ryYBF2MmFnSITitD5fVe1LdbZreYB99yu8k0/8bAo=
X-Received: by 2002:a92:4a09:: with SMTP id m9mr38727451ilf.79.1596083605662;
 Wed, 29 Jul 2020 21:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
In-Reply-To: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 30 Jul 2020 06:33:14 +0200
Message-ID: <CAM9Jb+hUk_e-Un3+9Jx8eKDtZ2A597bawQTJXQx77T0yG+PdnQ@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix wrong error-number passed into xas_set_err()
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The error-number passed into xas_set_err() should be negative. Otherwise,
> the xas_error() will return 0, and grab_mapping_entry() will return the
> found entry instead of a SIGBUS error when the entry is not a value.
> And then, the subsequent code path would be wrong.
>
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..acac675fe7a6 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -488,7 +488,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
>                 if (dax_is_conflict(entry))
>                         goto fallback;
>                 if (!xa_is_value(entry)) {
> -                       xas_set_err(xas, EIO);
> +                       xas_set_err(xas, -EIO);
>                         goto out_unlock;
>                 }
>
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.28.0
>
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
