Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCF2AB741
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgKILhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 06:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKILhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:37:38 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F616C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 03:37:38 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id b129so4760119vsb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGuQZ0oAyn5sihEjMy1ezIi07w1gtoGznFGC5Fz6RPs=;
        b=lRDVjIxDkPdBfw2frL6FN5fKnE7UzGE9NSZfR4e/4ckKwXto9GdZm7we1HTJzZrfId
         uKHVolG73IhymeZvb6CFCn7qDhkptVdeaIlTbsriPIb5l268GX4e7xlMCzcDO8lXpexo
         +y7x7GKiWpOr5KNe8MmzMb7ymBiirSXARXqEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGuQZ0oAyn5sihEjMy1ezIi07w1gtoGznFGC5Fz6RPs=;
        b=X1euNEG7JDm7nFZNhYRKZi2yYmjFVV3Hh+LAleVirI+SiQGcoPGCl4yuPW9t8lemoD
         BTETERMaCEO5apjjPSyL2u2I41RdtoHQXZgYjTHBf1f2V8WaQ5vepupsKv3JORdX5nFX
         2v026ItAF2RJQoXuC/RgqPEoP5QSyKSrFDukFtmS5T79u4yvBKnGhapq7HqfIzggNFLj
         ERldveemsNmtTaTrpzyimIRRqusDPXjD0xQKo4wybFBZ/yMKq9jkTDO8MqK6rnxStN8K
         Sh2e92Q9C7LlzIwzNdS4z/3I87Jd9NWsICzZFpVZmnxEtqcIVl5Z7EGSlzmhHKVeDmxY
         gCKw==
X-Gm-Message-State: AOAM533TpNN6FyMmY1YgEuxXZ0yKFj0742DNdX5whuRyU6V+PUfNy5JV
        JPdjGw93CRQFwU31crzz5aUXWIVm7flBASZefhYN+A==
X-Google-Smtp-Source: ABdhPJxS5tqSANQwu+j9I6gyY/c+7M7FLWqov6efEMBOAzlgfkIBmYqwqmJIYz8tTkCBGuS40fDT5riORZo7XmE4vbI=
X-Received: by 2002:a05:6102:3203:: with SMTP id r3mr6910793vsf.21.1604921857716;
 Mon, 09 Nov 2020 03:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org> <20201109100343.3958378-3-chirantan@chromium.org>
In-Reply-To: <20201109100343.3958378-3-chirantan@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Nov 2020 12:37:26 +0100
Message-ID: <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 11:04 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Implement support for O_TMPFILE by re-using the existing infrastructure
> for mkdir, symlink, mknod, etc. The server should reply to the tmpfile
> request by sending a fuse_entry_out describing the newly created
> tmpfile.
>
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  fs/fuse/dir.c  | 21 +++++++++++++++++++++
>  fs/fuse/file.c |  3 ++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ff7dbeb16f88d..1ab52e7ec1625 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -751,6 +751,26 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
>         return create_new_entry(fm, &args, dir, entry, S_IFDIR);
>  }
>
> +static int fuse_tmpfile(struct inode *dir, struct dentry *entry, umode_t mode)
> +{
> +       struct fuse_tmpfile_in inarg;
> +       struct fuse_mount *fm = get_fuse_mount(dir);
> +       FUSE_ARGS(args);
> +
> +       if (!fm->fc->dont_mask)
> +               mode &= ~current_umask();
> +
> +       memset(&inarg, 0, sizeof(inarg));
> +       inarg.mode = mode;
> +       inarg.umask = current_umask();
> +       args.opcode = FUSE_TMPFILE;
> +       args.in_numargs = 1;
> +       args.in_args[0].size = sizeof(inarg);
> +       args.in_args[0].value = &inarg;
> +
> +       return create_new_entry(fm, &args, dir, entry, S_IFREG);
> +}
> +
>  static int fuse_symlink(struct inode *dir, struct dentry *entry,
>                         const char *link)
>  {
> @@ -1818,6 +1838,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
>         .listxattr      = fuse_listxattr,
>         .get_acl        = fuse_get_acl,
>         .set_acl        = fuse_set_acl,
> +       .tmpfile        = fuse_tmpfile,
>  };
>
>  static const struct file_operations fuse_dir_operations = {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c03034e8c1529..8ecf85699a014 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -39,7 +39,8 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
>         FUSE_ARGS(args);
>
>         memset(&inarg, 0, sizeof(inarg));
> -       inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +       inarg.flags =
> +               file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TMPFILE);

Why did you add this?   At this stage O_TMPFILE should not be in the
flags, since that case was handled via the ->tmpfile() path.

Thanks,
Miklos
