Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559835A059
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDINvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhDINvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:51:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507AC061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 06:51:37 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u29so2940066vsi.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17gAB4/Xt1EcJ6duLXHgiCVFdSPwnzL/vuA8S86w0nY=;
        b=nMoosH4hAMExjqx73VwI6ccfuBMeqOOlug3s2ahPExh1d7czDmhVMSGWoyRJFWu9yw
         w/D4H+GN/48/WgLwgaPwAlgprTRjNFcMkcd8bBKhjsaI1iGtkngb6asqgGovqTvTUnp/
         gqwtCIkQ4jdzVftGhpNvjKHSEKyD8HpnHf89Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17gAB4/Xt1EcJ6duLXHgiCVFdSPwnzL/vuA8S86w0nY=;
        b=g6TsCGg8WJYUHb44UAnbYnY/8oBNaFO5znPMTF9CDI4XHeqigq6guHvnaMfs8IGK0x
         CMcum4wgiK4dFnsw/ifU2hhHEu0BdNQ4o82qw2rAYjaDGimcKXJG9gdT21J3D7qC4NnO
         xgt03nonoFfiHORGhifwiIZKnIRgqfA4k0xRquadOt2OhwdIuDXTEdqDqtOtUIagw7a5
         OLYZsZN2bpHbxifpC25BjkIc5shtqRfH8pzjO954v4N/hsH2dXdx3NoJzyMw2A+g9ngR
         +EB0AaNTWFvIuqeW32g0jTq3+3xFTkApCSpmTlzg/dtGbpOX0/sdP5Cu7LwHgwuC0eal
         cEGA==
X-Gm-Message-State: AOAM530XTCzr5Oia/bI36Wtn+C1PnMAqZbE1cPn6oaCADN5ZHb3muw3C
        BM7nuV5J4FXvFayD1DO1pXNtCzHr6gFzVBH7rj9b6B7DaU81EQ==
X-Google-Smtp-Source: ABdhPJxhsn0VhTmPepqwZIxdPE/jJRKz40lPlfAjtAlHk6AKV+A1Dipj6Ahx1cPdaWfVBS0oSfKjHovl4UqmJo8jOQ4=
X-Received: by 2002:a67:e056:: with SMTP id n22mr11332309vsl.0.1617976296786;
 Fri, 09 Apr 2021 06:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-10-cgxu519@mykernel.net>
In-Reply-To: <20201113065555.147276-10-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Apr 2021 15:51:26 +0200
Message-ID: <CAJfpegsoDL7maNtU7P=OwFy_XPgcyiBOGFzaKRbGnhfwz-HyYw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] ovl: implement containerized syncfs for overlayfs
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Now overlayfs can only sync dirty inode during syncfs,
> so remove unnecessary sync_filesystem() on upper file
> system.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/super.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 982b3954b47c..58507f1cd583 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -15,6 +15,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/exportfs.h>
> +#include <linux/blkdev.h>
> +#include <linux/writeback.h>
>  #include "overlayfs.h"
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -270,8 +272,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>          * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>          * All the super blocks will be iterated, including upper_sb.
>          *
> -        * If this is a syncfs(2) call, then we do need to call
> -        * sync_filesystem() on upper_sb, but enough if we do it when being
> +        * if this is a syncfs(2) call, it will be enough we do it when being
>          * called with wait == 1.
>          */
>         if (!wait)
> @@ -280,7 +281,11 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>         upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
>
>         down_read(&upper_sb->s_umount);
> -       ret = sync_filesystem(upper_sb);
> +       wait_sb_inodes(upper_sb);
> +       if (upper_sb->s_op->sync_fs)
> +               ret = upper_sb->s_op->sync_fs(upper_sb, wait);
> +       if (!ret)
> +               ret = sync_blockdev(upper_sb->s_bdev);

Should this instead be __sync_blockdev(..., wait)?

Thanks,
Miklos
