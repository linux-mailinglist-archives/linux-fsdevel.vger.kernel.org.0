Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AB3473E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 09:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhCXIp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 04:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhCXIpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:45:16 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A3C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 01:45:14 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id o85so5267813vko.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhT7lfu6P/3gT6Gg14tRPHhEqpMNGcVm3EE4u5owq+s=;
        b=peHbnBR3pIePzrAZMjcifsEkQBojGOrwDnuQWDhUWpzj4w85Z7ehJuErLNCWzjLYQH
         b5ohTRkn6WdZdl4P61CnWhHcE2bgUka8SuMwEhR9hBISYOu100MQGgF8e9+Io1/l4IHD
         PsYJDjwxYA5b+eP/Z7mWPJ78Ld4UfsNSpqep4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhT7lfu6P/3gT6Gg14tRPHhEqpMNGcVm3EE4u5owq+s=;
        b=HaFLlDtYxshRcG3FbM+3T8fp9udiWPGwHNGlzj/QWdQGcp3KuFd9MVnxAGkjiyeHQU
         UZrssY+ueK9UKAoHvA+fWIk6PrhMNN19Vid6ydTcU4Ztp81RyoGp5w0n92ngADrUv8E8
         55uV28tMdfFAaYKppAsYOYV23E9DEQAMff9Fbv7MKAblsA/zXjOfsRXa0hYGT+nCnsDg
         JggVIq0kRTVgwxvOR3TAyoa/nv35NsonhFvut0Au1QEJOCxnPVr7/2mERhRoeJr2pVkd
         sjQr3840pp+vcmj2tfgCh2fJwRsGjNlxDGOrm1CBmlxeVoaE3+bUPPyxn0BJ9n/UdCfM
         X7JQ==
X-Gm-Message-State: AOAM531tnSdWcQ9XDa+XyIh7b+5JqChb37Nxd02x6xlU+ZHTFPxLObT1
        hfa7XIDDlRRXaqtVR7NhIj5pDYTQtTKaZofylqlk+Q==
X-Google-Smtp-Source: ABdhPJw6t3EbCij0cw/geB+IbiuwBERrBfJj3cGhUAeY6YqrDieR4WsbBp4SmyjICHzK0TzFHPudfmL9nLSjnapAOUo=
X-Received: by 2002:a1f:a047:: with SMTP id j68mr825333vke.14.1616575513624;
 Wed, 24 Mar 2021 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210322144916.137245-1-mszeredi@redhat.com> <20210322144916.137245-2-mszeredi@redhat.com>
 <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
In-Reply-To: <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 09:45:02 +0100
Message-ID: <CAJfpegvy-bSoorAnPVRUxGjR5s10sJp3qRS0K-O91PcDvLSEPg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 6:03 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:
>
> minor nit: copy_fsxattr_{to,from}_user() might be better.
>
> > +int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
> > +{
> > +     struct fsxattr fa = {
> > +             .fsx_xflags     = ma->fsx_xflags,
> > +             .fsx_extsize    = ma->fsx_extsize,
> > +             .fsx_nextents   = ma->fsx_nextents,
> > +             .fsx_projid     = ma->fsx_projid,
> > +             .fsx_cowextsize = ma->fsx_cowextsize,
> > +     };
>
> That wants a comment along the lines of "guaranteed to be gap-free",
> since otherwise you'd need memset() to avoid an infoleak.

Isn't structure initialization supposed to zero everything not
explicitly initialized?

>
> > +static int ioctl_getflags(struct file *file, void __user *argp)
> > +{
> > +     struct miscattr ma = { .flags_valid = true }; /* hint only */
> > +     unsigned int flags;
> > +     int err;
> > +
> > +     err = vfs_miscattr_get(file_dentry(file), &ma);
>
> Umm...  Just to clarify - do we plan to have that ever called via
> ovl_real_ioctl()?  IOW, is file_dentry() anything other than a way
> to spell ->f_path.dentry here?

Indeed, file_dentry() only makes sense when called from a layer inside
overlayfs.

The one in io_uring() seems wrong also, as a beast needing
file_dentry() should never get out of overlayfs and into io_uring:

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9297,7 +9297,7 @@ static void __io_uring_show_fdinfo(struct
io_ring_ctx *ctx, struct seq_file *m)
                struct file *f = *io_fixed_file_slot(ctx->file_data, i);

                if (f)
-                       seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
+                       seq_printf(m, "%5u: %pD\n", i, f);
                else
                        seq_printf(m, "%5u: <none>\n", i);
        }


Thanks,
Miklos
