Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFA3ECCAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHPCf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:35:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C938C061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 19:35:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so25162618pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BG1jpF7K7ycQj0szNGgHmXjOsN8iFLcn1IX7qfG96Y=;
        b=cfseYDmellPtFEmUVBGI2iD3WPvWIfmepXi1pujDwhgirfGiRF+vin6DbM2nhm5JYJ
         hMOkYvRi29GrX496sMn27c/pIwpbkBdTw7/hQTbasvAlV85bmqRH5Cb3c1GikXXlpIUc
         AwR7/Ynpa3YSEysdNclME10FB7o0fOW+jXlmm8jw/3EZbRZgQZh0ni7EAsOQPPChdWOW
         /YGY4nHHd3ybwaVVHhYHiIgTfBRsSmW9EKjtQNUmmE+IZUryAHNXBUu3tViYzMnxgrV1
         UwQNMMgYm6O2TNc9npEAUWzUqJnvYJfnYHYmROaKrw7LYLTyErYOxcHu5OqtPwnYYmyS
         buzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BG1jpF7K7ycQj0szNGgHmXjOsN8iFLcn1IX7qfG96Y=;
        b=JwQBaoJtPBfEeVd1X3is1zNNLo0ZzGbiAX+wRvyCmY/vn59eDb9pYvkMcF6lr85fvf
         Y1bOOF5+twcsFlDSwj/ejF3kEVAuu3b/CBmvVhUl7r6z7ginsFEjYtYXFe3JG6nXbvS9
         sRoIa9pbT8dZTxR87+4uhpcDemPLSN062xC2fiUNs9eDjSci0KgXj4jf6HEhnUvnY170
         QdtuX6oYo9YiBmvhGmmafzB9ntMrdmEfFLg13m1oruteNzUu5ZnmSNakieOahCP6JjA1
         G9X+0nyHvl+xLNfteYzYUQrl2oUbHmJzMQt9SpOsndXmXhDFs18srW6FRLRovhV1Rmi9
         ncqQ==
X-Gm-Message-State: AOAM5328XtANYf6pRdpoaysP4DWKXftED9JCQ6elfuZI9c2AGU3Nm9E7
        k7ZrZKZ4xRP0esKHZjQ7k0wmnjD7BMCSOAdyIYI=
X-Google-Smtp-Source: ABdhPJwXVRBRTmJ20Spxd4NjKYTLMA7qrUO2HMYtgTrMSNRPg3HTTdfXSRgP/J0r76SXzkVQSfSVLl60A0kAMyGngM0=
X-Received: by 2002:a17:90b:392:: with SMTP id ga18mr14966218pjb.156.1629081326642;
 Sun, 15 Aug 2021 19:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210813093155.45-1-xieyongji@bytedance.com>
In-Reply-To: <20210813093155.45-1-xieyongji@bytedance.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Mon, 16 Aug 2021 10:35:15 +0800
Message-ID: <CA+a=Yy674ff4r-cVQ_QLyt0D1vh_6OdSeGXCPgNGHQ303mRV0Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 5:57 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> set in fuse_finish_open(), which can lead to deadlock in
> fuse_launder_page().
>
> To fix it, this tries to delay calling invalidate_inode_pages2()
> until FUSE_NOWRITE is removed.
>
> Fixes: e4648309b85a ("fuse: truncate pending writes on O_TRUNC")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/file.c   | 19 +++++++++++++++----
>  fs/fuse/fuse_i.h |  2 +-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index eade6f965b2e..d919c3e89cb0 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -548,7 +548,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>                 fuse_sync_release(fi, ff, flags);
>         } else {
>                 file->private_data = ff;
> -               fuse_finish_open(inode, file);
> +               fuse_finish_open(inode, file, false);
>         }
>         return err;
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 97f860cfc195..035af9c88eaf 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -193,12 +193,12 @@ static void fuse_link_write_file(struct file *file)
>         spin_unlock(&fi->lock);
>  }
>
> -void fuse_finish_open(struct inode *inode, struct file *file)
> +void fuse_finish_open(struct inode *inode, struct file *file, bool no_write)
>  {
>         struct fuse_file *ff = file->private_data;
>         struct fuse_conn *fc = get_fuse_conn(inode);
>
> -       if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> +       if (!(ff->open_flags & FOPEN_KEEP_CACHE) && !no_write)
>                 invalidate_inode_pages2(inode->i_mapping);
It would break !FOPEN_KEEP_CACHE semantics, right? Fuse server asks
the kernel not to keep cache across open but kernel still keeps it?

Cheers,
Tao
-- 
Into Sth. Rich & Strange
