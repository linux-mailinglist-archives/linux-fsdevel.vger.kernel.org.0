Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8E2D2996
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLHLML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 06:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLHLML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:12:11 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57748C061749;
        Tue,  8 Dec 2020 03:11:31 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id r17so15106643ilo.11;
        Tue, 08 Dec 2020 03:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fthot3QpP4vDk7cAw8On/plq+0eEtaEDbWP9YivflwA=;
        b=e2I4TcXcIwAVJiCOHzGm3G4CERo9gOfYIA+K9xvwroNmhK0ZMCY8xbTs5kPKmms9se
         NrBBiP4fYKl3yG20XAGIemzw9Ym/GWMU1QgXUsI5qlmzsdA8CwJ9DNQhxYuSXvjaDCPl
         iW5GZlUCi2qcWOvS0BGiHRVyj3wWsEd9ZCB+syW2cttj/XIasb4W8KGv88W4oiFciLWG
         qXqLdnnlGh8UWfxwEA/8v/d9P5y3/EqEjDd/64k4UrqVl7dbZAm5TAY2IrIJ91QL+og0
         kjC/6vKiGF94smt+LGH+gq7BFm4cb3u8PBvdPHUhw1If4hPpRWZPwXurWnwf7Fkm2Hzm
         mvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fthot3QpP4vDk7cAw8On/plq+0eEtaEDbWP9YivflwA=;
        b=p+UQZPZb3kDBN+cJLrFTAd4HmVEAfIdyj0q0ptf25hgt54ixMMpm7KX1YJ46BvyGQg
         pgKO+BR0fMwzSZeoauIr1vVinlzOX29FgMVHyOhfTB+OYNYHGAD+VcnehqejsW7tt1ip
         qTb261kcoqoD4kPywZdoDmXSmGJLDNnE10foLF98jZ+ZVkrUIxQLADynp7G+DhtyG6Pm
         ofYdVpezTY2DgM0tBEhQAwKoEXW7Lr5OZRbZvdLgSdm3bmLBZL6ZwWDmrU0Tu4fBgnM9
         yaNEZWXpVRqH+zv/kUzvXeXbvR/f/hLYQHIfpLiYVR4x2Bdy02q1Jl+VL052gwRANN0Y
         5e5g==
X-Gm-Message-State: AOAM531kFeLY7U2avyhmJhxnwkJAU49b1pK9Agl6iuR25aTHPJjt0zO0
        hp4DpxPayMfKMU3FMnfDZEZoqu/V5YQ26UPd70Q=
X-Google-Smtp-Source: ABdhPJwDQj490uw74Q0jh+SypXe6aDcsRgJchcPn19NCPqBh+AMvE0Tm3eXh36HEO/suunSwUz4/AwXMNcqYXVQijLc=
X-Received: by 2002:a05:6e02:160b:: with SMTP id t11mr26756697ilu.275.1607425890676;
 Tue, 08 Dec 2020 03:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
In-Reply-To: <20201207163255.564116-5-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Dec 2020 13:11:19 +0200
Message-ID: <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 6:36 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> ovl_ioctl_set_flags() does a capability check using flags, but then the
> real ioctl double-fetches flags and uses potentially different value.
>
> The "Check the capability before cred override" comment misleading: user
> can skip this check by presenting benign flags first and then overwriting
> them to non-benign flags.
>
> Just remove the cred override for now, hoping this doesn't cause a
> regression.
>
> The proper solution is to create a new setxflags i_op (patches are in the
> works).
>
> Xfstests don't show a regression.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/file.c | 75 ++-------------------------------------------
>  1 file changed, 3 insertions(+), 72 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index efccb7c1f9bc..3cd1590f2030 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -541,46 +541,26 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
>                            unsigned long arg)
>  {
>         struct fd real;
> -       const struct cred *old_cred;
>         long ret;
>
>         ret = ovl_real_fdget(file, &real);
>         if (ret)
>                 return ret;
>
> -       old_cred = ovl_override_creds(file_inode(file)->i_sb);
>         ret = security_file_ioctl(real.file, cmd, arg);
>         if (!ret)
>                 ret = vfs_ioctl(real.file, cmd, arg);
> -       revert_creds(old_cred);
>
>         fdput(real);
>
>         return ret;
>  }
>


I wonder if we shouldn't leave a comment behind to explain
that no override is intentional.

I also wonder if "Permission model" sections shouldn't be saying
something about ioctl() (current task checks only)? or we just treat
this is a breakage of the permission model that needs to be fixed?

Thanks,
Amir.
