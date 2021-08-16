Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219CC3ED79F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhHPNjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbhHPNjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:39:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55791C028BB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 06:16:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n12so26363505edx.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBWsE8OUq3pZiES4Oc+8eLP4jjxqFMZQxYyUbzEHLHw=;
        b=OHHKb2En4ha89k8GshptTOZhuSXO3vthRQHnftNKk5t0FgMtHHLaysO9q1HRbl0A4Y
         a/Vkqvj2s4vq+MTS0brQ4KIKRAhxEG9XD4J3TL4YwlxgLX6RdNp8E1x5pUBHDwYvS//1
         KLPuSSmz6Zet04F7LfiWdiOnr9YHw4hk0N1WWV0IFLUAAeqwQdP1gDITR9aBHaLQkgu6
         thAsTsss3PcP2wxoJEvUa78NvhUvOzqtWR4VKQyMwPo8y6A8QWKw29ltzYUNYook0iOc
         VoNvs19ohmDHCXlAEoFkfxbuHkXBBiuk8xjEIN1XGVwm4sQB91vD6ovDEcf+nOcarAML
         pVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBWsE8OUq3pZiES4Oc+8eLP4jjxqFMZQxYyUbzEHLHw=;
        b=OsfDOzdxw9KFHG8m6zZ8uIawfkSz0N6q2HfvHEgDGJ4NuH/Mpx2OsFo4IGjwH4r/ac
         N1+MOVDSWp+Fr8DbWbxmK4OrgTIig4NukSXn2BFHI5w06CMQmCQ7CtVopJgSpGBj0aCe
         cuw2nPxMlujE9XV7SKHV4SDwbbZN2qZ8QVXrLbqcxq0Qf8rvyVFytKYATcScUQjTElhJ
         /iYxOCu+eEdn/xSnxpnob5Ug/6GqbKRZhzSJ4cYUBkb5O+CRITCS59HvOaGmy9BiWmLY
         oS3f6HxI7/WrmZXI+lYa9jXthSxUnpzlJlZIODSbRhYBU3zrrOnoJt3kg3oDiFB61Hl/
         Rfcg==
X-Gm-Message-State: AOAM530oFJ4ZPZQ5pcdKhdLT2R1yJfUsOETLHQcGjBhEk9+9jkJbD/5U
        EaiApR/0Lms68V5+E7qr7x9+gFzZzSlBz6RSBRNo
X-Google-Smtp-Source: ABdhPJwN/Zc6ik49Y0qK+GijaXfbI6PWXZwaG2jeBq2tMxtAIczU4hnEuS6s+n0OBemSYQVFaz+glByoT4Aw690ff5s=
X-Received: by 2002:a05:6402:8cf:: with SMTP id d15mr19835243edz.118.1629119803997;
 Mon, 16 Aug 2021 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210813093155.45-1-xieyongji@bytedance.com> <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
In-Reply-To: <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 16 Aug 2021 21:16:33 +0800
Message-ID: <CACycT3tweteRLWjE68WXg4ePAFCAneXOTJap5MjpitTqzVs0-Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 8:39 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Aug 13, 2021 at 05:31:55PM +0800, Xie Yongji wrote:
> > The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> > set in fuse_finish_open(), which can lead to deadlock in
> > fuse_launder_page().
> >
> > To fix it, this tries to delay calling invalidate_inode_pages2()
> > until FUSE_NOWRITE is removed.
>
> Thanks for the report and the patch.  I think it doesn't make sense to delay the
> invalidate_inode_pages2() call since the inode has been truncated in this case,
> there's no data worth writing out.
>

Right.

> This patch replaces the invalidate_inode_pages2() with a truncate_pagecache()
> call.  This makes sense regardless of FOPEN_KEEP_CACHE or fc->writeback cache,
> so do it unconditionally.
>
> Can you please check out the following patch?
>
> Thanks,
> Miklos
>
> ---
>  fs/fuse/file.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -198,12 +198,11 @@ void fuse_finish_open(struct inode *inod
>         struct fuse_file *ff = file->private_data;
>         struct fuse_conn *fc = get_fuse_conn(inode);
>
> -       if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> -               invalidate_inode_pages2(inode->i_mapping);
>         if (ff->open_flags & FOPEN_STREAM)
>                 stream_open(inode, file);
>         else if (ff->open_flags & FOPEN_NONSEEKABLE)
>                 nonseekable_open(inode, file);
> +
>         if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
> @@ -211,10 +210,14 @@ void fuse_finish_open(struct inode *inod
>                 fi->attr_version = atomic64_inc_return(&fc->attr_version);
>                 i_size_write(inode, 0);
>                 spin_unlock(&fi->lock);
> +               truncate_pagecache(inode, 0);
>                 fuse_invalidate_attr(inode);
>                 if (fc->writeback_cache)
>                         file_update_time(file);
> +       } else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
> +               invalidate_inode_pages2(inode->i_mapping);
>         }
> +
>         if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
>                 fuse_link_write_file(file);
>  }

It looks good to me!

Thanks,
Yongji
