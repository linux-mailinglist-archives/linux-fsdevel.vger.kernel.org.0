Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B22425B13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbhJGSpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243545AbhJGSpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:45:33 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178DFC061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:43:39 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id i15so758665uap.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XM+aoTP+lFbICkxTuoQyaeaVXtWWuUoeMP/C/f0Vvkc=;
        b=YvZDPpoS19oCaPvlFDJaVVZXyiDS8eAE/PtMejLFzRTa46q7dZjgMwO752wqeUVLu+
         sCLOmUv3bMmlSEFmiFH0fGiZZ7ZEBb9m4DLzl4Kl2mFMooAxBqumNOscqCuqco4/dlop
         Ai3ls3XRxvUPmOjHxcJwD1RZ8zY5xQmn5QpRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XM+aoTP+lFbICkxTuoQyaeaVXtWWuUoeMP/C/f0Vvkc=;
        b=zWwo/5xPvHZqSXRjfhMVckTU1hc9C9eFKyStiNwCE+B10kXi7+QDKNdp5MYwlsAjZE
         3MV2r/XRAtYhp4hA/ajh2tj/53sfnCvrL/nJDI4B207RCMcnH8eFMM4tgZOf5kI2w5bg
         WY6MtAcy3Yr61EoHgbKKp59yPFCo1J02bEW9Y57VasSXnrz703jGR+aw9lwWdb3Ozpw/
         gnnHQcXJ2LyD4fc0U3L7d+O51Z+Oh8r9mpzSs59mKoeF/d48oi34aFxbELIw8daG/eYs
         kRpZzbzByRa2Nyp5UWWdGzl/+5nB898X/1IXe34ICX6LRZm1IDZYKConT4BReUBgjFmH
         fAjw==
X-Gm-Message-State: AOAM5318fcaNJ3fYpUkh5UXTfR8xnq/9V5XNwdQicq2mw0swQz8TpiRg
        6t84RJwlC2qpN6J3oKb+BENqfjMOdcCXpf3U2Wudcw==
X-Google-Smtp-Source: ABdhPJyErj0X46uH4LfmAOUeJ7nEvuX6FesTQpX4Hfr3/iZpAUPHCFhnnCLvLxdE5YOMdiOt2IazDjLDYiYnSwUf2Xo=
X-Received: by 2002:ab0:3b12:: with SMTP id n18mr6709142uaw.9.1633632218203;
 Thu, 07 Oct 2021 11:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-5-cgxu519@mykernel.net>
In-Reply-To: <20210923130814.140814-5-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 20:43:27 +0200
Message-ID: <CAJfpegsRTdEOT6fHg9n8GR3JRQbKUt9N_HvQDD9U6PbCVzygRw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 04/10] ovl: mark overlayfs' inode dirty on modification
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Mark overlayfs' inode dirty on modification so that
> we can recognize and collect target inodes for syncfs.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/inode.c     |  1 +
>  fs/overlayfs/overlayfs.h |  4 ++++
>  fs/overlayfs/util.c      | 21 +++++++++++++++++++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index d854e59a3710..4a03aceaeedc 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -478,6 +478,7 @@ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
>                 if (upperpath.dentry) {
>                         touch_atime(&upperpath);
>                         inode->i_atime = d_inode(upperpath.dentry)->i_atime;
> +                       ovl_mark_inode_dirty(inode);
>                 }
>         }
>         return 0;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 3894f3347955..5a016baa06dd 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -276,6 +276,7 @@ static inline bool ovl_allow_offline_changes(struct ovl_fs *ofs)
>
>
>  /* util.c */
> +void ovl_mark_inode_dirty(struct inode *inode);
>  int ovl_want_write(struct dentry *dentry);
>  void ovl_drop_write(struct dentry *dentry);
>  struct dentry *ovl_workdir(struct dentry *dentry);
> @@ -529,6 +530,9 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
>         to->i_mtime = from->i_mtime;
>         to->i_ctime = from->i_ctime;
>         i_size_write(to, i_size_read(from));
> +
> +       if (ovl_inode_upper(to) && from->i_state & I_DIRTY_ALL)
> +               ovl_mark_inode_dirty(to);

I'd be more comfortable with calling ovl_mark_inode_dirty() unconditionally.

Checking if there's an upper seems to make no sense, since we should
only be copying the attributes if something was changed, and then it
is an upper inode.

Checking dirty flags on upper inode actually makes this racy:

  - upper inode dirtied through overlayfs
  - inode writeback starts (e.g. background writeback) on upper inode
  - dirty flags are cleared
  - check for dirty flags in upper inode above indicates not dirty,
ovl inode not dirtied
  - syncfs called, misses this inode
  - inode writeback completed after syncfs

>  }
>
>  /* vfs inode flags copied from real to ovl inode */
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f48284a2a896..5441eae2e345 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -25,7 +25,14 @@ int ovl_want_write(struct dentry *dentry)
>  void ovl_drop_write(struct dentry *dentry)
>  {
>         struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
> +       struct dentry *upper;
> +
>         mnt_drop_write(ovl_upper_mnt(ofs));
> +       if (d_inode(dentry)) {
> +               upper = ovl_dentry_upper(dentry);
> +               if (upper && d_inode(upper) && d_inode(upper)->i_state & I_DIRTY_ALL)
> +                       ovl_mark_inode_dirty(d_inode(dentry));

ovl_want_write/ovl_drop_write means modification of the upper
filesystem.  It may or may not be the given dentry, so this is not the
right place to clall ovl_mark_inode_dirty IMO.  Better check all
instances of these and see if there are cases where ovl_copyattr()
doesn't handle inode dirtying, and do it explicitly there.


> +       }
>  }
>
>  struct dentry *ovl_workdir(struct dentry *dentry)
> @@ -1060,3 +1067,17 @@ int ovl_sync_status(struct ovl_fs *ofs)
>
>         return errseq_check(&mnt->mnt_sb->s_wb_err, ofs->errseq);
>  }
> +
> +/*
> + * We intentionally add I_DIRTY_SYNC flag regardless dirty flag
> + * of upper inode so that we have chance to invoke ->write_inode
> + * to re-dirty overlayfs' inode during writeback process.
> + */
> +void ovl_mark_inode_dirty(struct inode *inode)
> +{
> +       struct inode *upper = ovl_inode_upper(inode);
> +       unsigned long iflag = I_DIRTY_SYNC;
> +
> +       iflag |= upper->i_state & I_DIRTY_ALL;
> +       __mark_inode_dirty(inode, iflag);
> +}

I think ovl_mark_inode_dirty()  can just call mark_inode_dirty().
And so that can go in "overlayfs.h" file as static inline.

Thanks,
Miklos
