Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC62F746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 07:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE3FuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 01:50:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46935 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3FuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 01:50:04 -0400
Received: by mail-yb1-f194.google.com with SMTP id p8so1712502ybo.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMHz6/NV3TXzmw/zAXxEDIRdlAbXhZsHnbbqJgV5ujw=;
        b=q9XsQJVW/cLdVQi6ZnXr+v6lVYFLOYn4WIebOXWp2pXcLR+KZD9ECKgSX6WXq+EnlB
         p0iwsVwuywutCewPhT+04eYIuQBf5HE21eNLzAMdQ+W4voMuGoOANCYem/CQfnYf819I
         pe3lmgeu3zE1QsdDBM7LYCRWXPF/OR8/K3kKZRA+PDQplRF/ET/KM7tySlFyxnkiI3q4
         fD1mHzNV5P65FBSmsRfrJ+05u1DHDNcpZIWZ+d9Edtg+NwwsOxItoq7QVGdmFY00KTxC
         7de9rzM5BDEktPWE16z3s+1SNiJGQZ0v9U0aUItmK7/5kc0YcDt9GjK1zY5XNIr6Qz6t
         Ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMHz6/NV3TXzmw/zAXxEDIRdlAbXhZsHnbbqJgV5ujw=;
        b=s72N/Y3KX/nusrFJ8hmVOTHR1JiQgYOdntqr3OW/jS20wq45lZb1mx1+S9NcZIvqR9
         8+0BWsHO/i1Ng3bL7r1vIslxxJcvgMBLjc8hmmcgttwiu6sPQFfqrf4AYhMgcLWgWLlv
         YTr36E8HsewzoILxqaDa7Kj4iQHiH2tf5FfrrVVZ8nvJBJ96nOZHzRM1FpOvNv+mXJdq
         yndgNUJVI+nqZ7yyYk7NZHoLdNS0m41RN7nscBL0tM8xx65FPjQOEpq+2U2Wh4woEwJl
         WqN6k0OjEh1YRz0QXQQg1mQJZ86mzgRqcqBh6jL6Y1S8GHvGMDp0U9NepYExL7qdfi+o
         QJKw==
X-Gm-Message-State: APjAAAW7tM5u8//OOtof8G4fNKto1yoWovzXK2unMj6umGXG3qfOX2XN
        qUjpJDibujCiMy2P5/J2iheTwI9wiDZLiQ42U1I=
X-Google-Smtp-Source: APXvYqy0TLmX5q9lwsl/sV08s2+FEOVWNQV2G/uvP6Nhc9ioepMkb+C4G0vXH2UFqGO6/+yvVFNDm+FRaT+E8jMjGGA=
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr701385ybs.144.1559195403920;
 Wed, 29 May 2019 22:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-7-amir73il@gmail.com>
In-Reply-To: <20190526143411.11244-7-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 08:49:52 +0300
Message-ID: <CAOQ4uxjr50juBR=48c8BqnRhZv0yBri4k_zF9ap2Rsypd36EoA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] debugfs: simplify __debugfs_remove_file()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Move simple_unlink()+d_delete() from __debugfs_remove_file() into
> caller __debugfs_remove() and rename helper for post remove file to
> __debugfs_file_removed().
>
> This will simplify adding fsnotify_unlink() hook.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

Will be you be able to provide an ACK on this debugfs patch and the next one.

Thanks,
Amir.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/debugfs/inode.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index acef14ad53db..d89874da9791 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
>
> -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> +static void __debugfs_file_removed(struct dentry *dentry)
>  {
>         struct debugfs_fsdata *fsd;
>
> -       simple_unlink(d_inode(parent), dentry);
> -       d_delete(dentry);
> -
>         /*
>          * Paired with the closing smp_mb() implied by a successful
>          * cmpxchg() in debugfs_file_get(): either
> @@ -644,16 +641,15 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
>
>         if (simple_positive(dentry)) {
>                 dget(dentry);
> -               if (!d_is_reg(dentry)) {
> -                       if (d_is_dir(dentry))
> -                               ret = simple_rmdir(d_inode(parent), dentry);
> -                       else
> -                               simple_unlink(d_inode(parent), dentry);
> -                       if (!ret)
> -                               d_delete(dentry);
> +               if (d_is_dir(dentry)) {
> +                       ret = simple_rmdir(d_inode(parent), dentry);
>                 } else {
> -                       __debugfs_remove_file(dentry, parent);
> +                       simple_unlink(d_inode(parent), dentry);
>                 }
> +               if (!ret)
> +                       d_delete(dentry);
> +               if (d_is_reg(dentry))
> +                       __debugfs_file_removed(dentry);
>                 dput(dentry);
>         }
>         return ret;
> --
> 2.17.1
>
