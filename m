Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E63475F61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 08:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGZG5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 02:57:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33052 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGZG5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:57:45 -0400
Received: by mail-yb1-f195.google.com with SMTP id c202so17953682ybf.0;
        Thu, 25 Jul 2019 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ra3fpxWHFvLtRMMiUd9OFJua+AjFjAkm9k/vwnBYkKk=;
        b=VyohNN1DhYTQ0+iW4429cNqwM4zP8mMpsqJJWhXJxwiAHA1Kqu5KbFN4ZZqCAcq6f1
         HntDKKVZZcM/yjZfgudVx5jGIfpHL8Z2m8xAX/5iaNODDzLYALhHWuA5sOhAA3GF7E9q
         FlSEnsjrYDFbqc+9iu7OF7KUwYqHNyskA+z1eOPXRXOtJSLxv58ZAjm1jIIKwGNb1D3w
         gCZlZ7JiuCixjg5eaushQNBARWmGyT8N/rcvs/3/gnrlzeBLJs/xYPj+PXlP7jZlf2GO
         PnkQn9q1DLvAlH0Be0VdE5eW9pymaUOTYqDwAgm23RqtZBLtjih7jihc0SxPdgwAMdy9
         HgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ra3fpxWHFvLtRMMiUd9OFJua+AjFjAkm9k/vwnBYkKk=;
        b=pU3zdR5BWUy3BTmafY1HQ0JtaTFqQBOJP219JRYynYWNJGaEr1WnTN+CAUg7x614gh
         B7yXdQpaM0L+3iYr6YVeVJxtwFkHHr6gjWdOd12p9Fd268BMjlMTUgksuRmZcM8JhyUe
         8945qNBrJ9EGS1JrfOC+/xZioOXhGJSkOkhqFA72VjUxBWlD5adjFssl44nJ2YPoX9Vc
         6esddW2oPF/9K9/vVw7+zp9E0FIzjFowE3M3uYXnvib6DMmdq8luYhvsFuTALxH6MeZC
         +foSZ6EDilolwFBV+yVhPb2sZj5ZDoAmTlsLUxGKNOV+1EcZfXq1QYuj9r8EghmB4puV
         bpFQ==
X-Gm-Message-State: APjAAAVaj7phsbnJJlJVJi1SLxnZ1bq22FcHZLkDfY7teS2uLbTZpkDc
        leDG5sA0zf46FS7njeYWAipG3OpJfuCoMWwvZcCjDBSW
X-Google-Smtp-Source: APXvYqwbJ5BQE3yQlkGcySgvRgVFiEZb+YkhRLN8KUrLAeKhUhckEbkNXOsgbB4H0H+8Z068E7aBqNkYnf+SpcAoZj0=
X-Received: by 2002:a25:9a08:: with SMTP id x8mr55700016ybn.439.1564124264773;
 Thu, 25 Jul 2019 23:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190715133839.9878-1-amir73il@gmail.com> <20190715133839.9878-2-amir73il@gmail.com>
In-Reply-To: <20190715133839.9878-2-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jul 2019 09:57:33 +0300
Message-ID: <CAOQ4uxhRgL2sMok7xsAZN6cZXSfoPxx=O8ADE=72+Ta3hGoLbw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ovl: support [S|G]ETFLAGS ioctl for directories
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 4:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> [S|G]ETFLAGS and FS[S|G]ETXATTR ioctls are applicable to both files and
> directories, so add ioctl operations to dir as well.
>
> ifdef away compat ioctl implementation to conform to standard practice.
>
> With this change, xfstest generic/079 which tests these ioctls on files
> and directories passes.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/file.c      | 10 ++++++----
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/readdir.c   |  4 ++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index e235a635d9ec..c6426e4d3f1f 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -502,7 +502,7 @@ static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
>                                    ovl_fsxflags_to_iflags(fa.fsx_xflags));
>  }
>
> -static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         long ret;
>
> @@ -527,8 +527,8 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         return ret;
>  }
>
> -static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
> -                            unsigned long arg)
> +#ifdef CONFIG_COMPAT
> +long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         switch (cmd) {
>         case FS_IOC32_GETFLAGS:
> @@ -545,6 +545,7 @@ static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
>
>         return ovl_ioctl(file, cmd, arg);
>  }
> +#endif
>
>  enum ovl_copyop {
>         OVL_COPY,
> @@ -646,8 +647,9 @@ const struct file_operations ovl_file_operations = {
>         .fallocate      = ovl_fallocate,
>         .fadvise        = ovl_fadvise,
>         .unlocked_ioctl = ovl_ioctl,
> +#ifdef CONFIG_COMPAT
>         .compat_ioctl   = ovl_compat_ioctl,
> -
> +#endif
>         .copy_file_range        = ovl_copy_file_range,
>         .remap_file_range       = ovl_remap_file_range,
>  };
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6934bcf030f0..7c94cc3521cb 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -416,6 +416,8 @@ struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr);
>
>  /* file.c */
>  extern const struct file_operations ovl_file_operations;
> +long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>
>  /* copy_up.c */
>  int ovl_copy_up(struct dentry *dentry);
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 47a91c9733a5..eff8fbfccc7c 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -907,6 +907,10 @@ const struct file_operations ovl_dir_operations = {
>         .llseek         = ovl_dir_llseek,
>         .fsync          = ovl_dir_fsync,
>         .release        = ovl_dir_release,
> +       .unlocked_ioctl = ovl_ioctl,
> +#ifdef CONFIG_COMPAT
> +       .compat_ioctl   = ovl_compat_ioctl,
> +#endif
>  };
>

Big self NACK!!!

Cannot call ovl_ioctl => ovl_real_ioctl => ovl_real_fdget with a directory.
If we do this need to implement ovl_dir_ioctl and refactor the ioctl helpers.

Sorry,
Amir.
