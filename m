Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F22CD345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgLCKRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLCKRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:17:21 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8FC061A4E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 02:16:41 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so2640279ejj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Vd4Hb/TndV5DzmZy3SbrxOWhXctHLB4WnGdapRV8BU=;
        b=Pn6etdlwD/T2EjXQWsXsw168LeDHPyreiwEV0TVtDviyZhULIiKfVCPeVs4CojpnNB
         ijAXbZKsqwbVH9Lj1zhMWC9QDcvQ/2k/HQ6LvE/3dzorb1T4MAmAoLc0op+xPmABnZHx
         9UzyszDdf1FoAxVxRzRaKxuMBw8DsGstxIytk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Vd4Hb/TndV5DzmZy3SbrxOWhXctHLB4WnGdapRV8BU=;
        b=chl4RZjdP/nTaO0U5NaMWT0izZlGmbURgqg44DZ9x5xCkFUsJXp7Zw+ZeWvIa9tvpY
         C+iliav3bit3P1re++rnfoY7QsgQKEQ+/THRVO7Tc1Nc7sGqS9n9aeYdzx6/pktj174+
         gknlZx0AkWbf64zoGblBMmkiGKvmRq/tmqfWpbyrJ/rLNW2n3KUPxQS+4swwuJRRgoq1
         A/I+z/pCaWAT8R69+6RbL8kfnKWm9Ib1nYyr9Ov71LdUXFuD26MKuJiHfN82eAIEORmX
         w43oJ5+KLJSK0rKDnGdCbhr946jCxw+HAaL9QKXuO7pTWbD2AdyeKPvw56WTVrMEut25
         pfwQ==
X-Gm-Message-State: AOAM530DBCGDpaBcGIJ55LCZXiSHscgqUH5bd8GbFoNvMBmyUP3HwDAI
        2HlnA/gtr/f5bZX5IHINkuaPvWTEI2wjpCjtFj8kLw==
X-Google-Smtp-Source: ABdhPJxlNTG8XKj15t0YRYFTePX7CW/ReHMhjCpyO61mVK+2pSJ+gGXQlOWHHy/gyv15rkqqASSEX4Wjrn6oflPHZN8=
X-Received: by 2002:a17:906:1450:: with SMTP id q16mr1871092ejc.524.1606990599597;
 Thu, 03 Dec 2020 02:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20201130030039.596801-1-sargun@sargun.me>
In-Reply-To: <20201130030039.596801-1-sargun@sargun.me>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 3 Dec 2020 02:16:03 -0800
Message-ID: <CAMp4zn-c6gOPTPBqqkPoQi3NVeZ0yW-WfVPFzpDiazj8PeUgBw@mail.gmail.com>
Subject: Re: [PATCH] overlay: Plumb through flush method
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 29, 2020 at 7:00 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> Filesystems can implement their own flush method that release
> resources, or manipulate caches. Currently if one of these
> filesystems is used with overlayfs, the flush method is not called.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index efccb7c1f9bc..802259f33c28 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -787,6 +787,16 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
>                             remap_flags, op);
>  }
>
> +static int ovl_flush(struct file *file, fl_owner_t id)
> +{
> +       struct file *realfile = file->private_data;
> +
> +       if (realfile->f_op->flush)
> +               return realfile->f_op->flush(realfile, id);
> +
> +       return 0;
> +}
> +
>  const struct file_operations ovl_file_operations = {
>         .open           = ovl_open,
>         .release        = ovl_release,
> @@ -798,6 +808,7 @@ const struct file_operations ovl_file_operations = {
>         .fallocate      = ovl_fallocate,
>         .fadvise        = ovl_fadvise,
>         .unlocked_ioctl = ovl_ioctl,
> +       .flush          = ovl_flush,
>  #ifdef CONFIG_COMPAT
>         .compat_ioctl   = ovl_compat_ioctl,
>  #endif
> --
> 2.25.1
>

Amir, Miklos,
Is this acceptable? I discovered this being a problem when we had the discussion
of whether the volatile fs should return an error on close on dirty files.

It seems like it would be useful if anyone uses NFS, or CIFS as an upperdir.
