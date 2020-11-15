Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0812D2B34F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKOMb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 07:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgKOMb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:31:58 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72005C0613D1;
        Sun, 15 Nov 2020 04:31:58 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n12so14465617ioc.2;
        Sun, 15 Nov 2020 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qDI0bmxiNxNkq7U7tJeRtk0Ri4L2mKhFoKA+8ciLW8=;
        b=bS3fUxrph1gqu5Tqe7uPZH4nAtVVS9v6TuWySbS2DpYpmV92jIUlSFZtNBqXHHqCjJ
         Ev/kYwQuQNxkj2XdNbxHmyDy9Mp7K+XpJ7j8aJVyOFEyGgsjSYT4FYxxAZbMLYgDpOJh
         A+NKSOjdNrWs2RzshGXgB4onRQg9J9KUrHWe7Fm90GdRHYydRzBmPuZiLiwajTB/Lgr9
         myvNDwPaB5nvitc5L3X7bniz5fhE/QTMvT6VxCGpDob5Kw/wct7k00voEsxinnN8oVMH
         V81AaxqR/GECMF5Tnzr42ET8GYWb6MVHgegRWCAXi9+SlXu5XHVUHfq8syWzXjRMBUKy
         k7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qDI0bmxiNxNkq7U7tJeRtk0Ri4L2mKhFoKA+8ciLW8=;
        b=LqPQ8W0ZOjfZILP6ia3I2dKlDy/ajDGJia8o4We60yheXxBWF5wey7bgnHeQR/CqmK
         nhCcC25zHr8OkRZBPaz5kWkLiSNOcUMzvZlHPhIVQLx1veOVPwWWXm/2Q2jK8D9B9rzN
         dnezDNIXgnCjuSJu8tT+PJ2r/XjYz1CYUYEwOgA55xFHMKMLEqS9vqYA7cUqBYpmUnWG
         QgUrfPjvYh+7K3mvldicXilRHCjFGs5B4tJGgNx6156vPR9COPGvsbENQ/aM/K4pMTOM
         evue2PGy6otefQt9DJrx7RoAzSACO4KA3sjDFFarBAZpRgGfRy829NgmCZWCE8yL4LLR
         p9bQ==
X-Gm-Message-State: AOAM530uk0rBkgntPHtUevB+xwJEcf4L1ftPYVtf7+RdvWVOdbth/TLs
        H5i8BwmkJyx+DJd7TF31PwhFu7fdvLmRgH2SnnTY9R40UQg=
X-Google-Smtp-Source: ABdhPJwMtXpbBB+JrEnxxXogyFA26Fv5J9jLbWiDifyt5sXxMDS0gbVeHV8fz9VFCXEVJzq2b/qFXKjujkmZPbB7nYg=
X-Received: by 2002:a5d:964a:: with SMTP id d10mr890846ios.5.1605443517686;
 Sun, 15 Nov 2020 04:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com> <20201115103718.298186-37-christian.brauner@ubuntu.com>
In-Reply-To: <20201115103718.298186-37-christian.brauner@ubuntu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 15 Nov 2020 14:31:46 +0200
Message-ID: <CAOQ4uxi3OpvT5P7jQyPqGGK9tnhk_fni10G6+a3KC=-60udkTQ@mail.gmail.com>
Subject: Re: [PATCH v2 36/39] overlayfs: do not mount on top of idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 12:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Prevent overlayfs from being mounted on top of idmapped mounts until we
> have ported it to handle this case and added proper testing for it.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> patch introduced
> ---
>  fs/overlayfs/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 0d4f2baf6836..3cacc3d3fb65 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1708,6 +1708,12 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>                 if (err)
>                         goto out_err;
>
> +               if (mnt_idmapped(stack[i].mnt)) {
> +                       err = -EINVAL;
> +                       pr_err("idmapped lower layers are currently unsupported\n");
> +                       goto out_err;
> +               }
> +
>                 lower = strchr(lower, '\0') + 1;
>         }
>
> @@ -1939,6 +1945,12 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>                 if (err)
>                         goto out_err;
>
> +               if (mnt_idmapped(upperpath.mnt)) {
> +                       err = -EINVAL;
> +                       pr_err("idmapped lower layers are currently unsupported\n");
> +                       goto out_err;
> +               }
> +

Both checks should be replaced with one check in ovl_mount_dir_noesc()
right next to ovl_dentry_weird() check and FWIW the error above about
"lower layers" when referring to upperpath.mnt is confusing.
"idmapped layers..." should be fine.

Thanks,
Amir.
