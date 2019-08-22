Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235649A24F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393161AbfHVVn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 17:43:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44233 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391202AbfHVVn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:43:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id y21so3123746ybi.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUm6yXYTlbTXopviUp4rylkFQbLJR/m96Sizb+UK2Sk=;
        b=H31YN4ZNsUnU299kwk54yLpzwRjkKDvY2XEOe7J+nAsMhciLQ8pxdS2tbnNaGjgiID
         A03OpSrudtbbeZUOHGHlPfuGOH8T4sflQ7jd9/Pmt7+CuIiUVLXEoDcp8t02bTzkXM88
         FTWlKUQgTADJV3eWyOD/cvwdi9xAyXZUN18OSIBFgAlSaNns4xeMN6ccXtANOpwknQUJ
         /I9yMuEBn7nIS0yu8302B4kf0H2NF1Q6F2CP4IfW/h30ysAAzaQZBqhIJ2PXtfCUBgUe
         NTnG2KYoiHG+ZDkXih1IaR5Lx3OTOodsRcIwis4Bd9Ec5I2Shs+IELs+aGbeQK/9owR0
         DkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUm6yXYTlbTXopviUp4rylkFQbLJR/m96Sizb+UK2Sk=;
        b=SMg1cJ/ZT9SmgTU18a6nEHRZJVyrlm6kmuttPhY92pATu6BTaBn6GrOPMuVHNdsOFf
         egP4qt5V3q3QQJYXADimBVec0ejZWjS+VE4wgXcEKdOk18uOTNnZn2dXNNBipNNhe7wd
         kPTfpCrX9Ai+NaK2t+9n0HR2MeUb1sZkHmU97z+pCI3inYs4tVyBFe+5O3zvdLTENlr4
         cFA5wT/xjXykSrfzj0bPzveGnttWIsMyPZeODIrMBwNmdjIkYAe1uEa1uvx9P5O+jVjJ
         GyfuIHX7t4V20GMAgCgWcA2psSme5ai6SyI4rfhacijFg4LgAB/uIo9SfK+Dc2QQsPFt
         t1HQ==
X-Gm-Message-State: APjAAAVxjRPr38AfMSVvSuMfxsC8hQvnyiCxGLeNwhMyoMEBwhJ33BeT
        H0IWM67lo6BsYlizLyC350pTe9eHPED4uwof50ufrg==
X-Google-Smtp-Source: APXvYqxIFPR6FxUBY8A2LZP4EkBf4qhKlZgJC9O/95dzHUIJ5rZshrEUMo/6nlfJN7uIyc5vW0YNUzbrYPJCT2g48H0=
X-Received: by 2002:a25:e6c9:: with SMTP id d192mr828435ybh.467.1566510207880;
 Thu, 22 Aug 2019 14:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com> <20190822200030.141272-3-khazhy@google.com>
In-Reply-To: <20190822200030.141272-3-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Aug 2019 14:43:17 -0700
Message-ID: <CALvZod4E7Cd08zUWQxKztUJWuCm=WyDRGGzyjvGFMTSPMqNK4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: kmemcg account fs data
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:00 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> account per-file, dentry, and inode data
>
> accounts the per-file reserved request, adding new
> fuse_request_alloc_account()
>
> blockdev/superblock and temporary per-request data was left alone, as
> this usually isn't accounted
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  fs/fuse/dir.c   | 3 ++-
>  fs/fuse/file.c  | 4 ++--
>  fs/fuse/inode.c | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f9c59a296568..2013e1222de7 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -258,7 +258,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  #if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
> -       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
> +       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
> +                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>
>         return dentry->d_fsdata ? 0 : -ENOMEM;
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 572d8347ebcb..ae8c8016bb8e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -45,12 +45,12 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
>  {
>         struct fuse_file *ff;
>
> -       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
> +       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff))
>                 return NULL;
>
>         ff->fc = fc;
> -       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
> +       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff->reserved_req)) {
>                 kfree(ff);
>                 return NULL;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 5afd1872b8b1..ad92e93eaddd 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -76,7 +76,8 @@ struct fuse_mount_data {
>
>  struct fuse_forget_link *fuse_alloc_forget(void)
>  {
> -       return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
> +       return kzalloc(sizeof(struct fuse_forget_link),
> +                      GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>  }
>
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
> --
> 2.23.0.187.g17f5b7556c-goog
>
