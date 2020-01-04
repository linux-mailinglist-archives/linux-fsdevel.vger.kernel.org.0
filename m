Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E991303F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgADTJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 14:09:33 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33713 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADTJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 14:09:32 -0500
Received: by mail-il1-f196.google.com with SMTP id v15so39278251iln.0;
        Sat, 04 Jan 2020 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFEXNOMKAzSNhSrJjWqlZa8udA4NNM3xeAKljDmm5RM=;
        b=QG/h/lQnJXJJBu8QCNJrn2ezR23I2Fp1wFfPNEvee9hKnoifMgxP0rMU2ro6tMaI28
         mi2GzrbEJqrIpTe/s2OpwsT9x1w1r1Zd32gs1KOs2lX8rKbl3NRjzTRGXtjRPRk4FADg
         bRStZ1h53bzZ3ikFmZhvJh7sF/Tx3ayd0zxdEBPCMoWdEKalWXgMnvm6fp43LkRUSKmP
         WmT1zCFjWPWOovRyOt55ZgXjLbqlGqOK6T+pcVNQSwduOygBf1PSUOi9PnbwbfXSYUQl
         mehl/xqNRrNuQ58ywAcbZ6tx08os+y1yKgfjyHYY/F5XcUk0ulIHxVGr9RJTScagJXuj
         Mx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFEXNOMKAzSNhSrJjWqlZa8udA4NNM3xeAKljDmm5RM=;
        b=LRQrJeX8u+5utH2sUEBoDSTl4LHop+DEsHR8lTGL4VFLf7NwMEnbkbLz18aRlyd/jY
         3YyHZUZwGAc4tPw384MDgXRCIWuxNA+mNjUR6pJ2TEttPvaKL1BNnSUrK88HL2AEF/XV
         EJzTggIMAanusOiK3g9zTN7yA6hXgBZxPyqR1voHke1rkah2GsJAQU+yEYqysuS6uwpi
         l27DCeSTO4Mau0crUnn1nX3Je+R+sk7gszmwwiTd24xfXmBmpPpRMCrnbhwGa/X6fOrK
         IKtQWxkv2M/lJ2nE5Nv8RS7UAlbBZpwvG3UnmpupsgqqaXsVcSXW8+3uVOFb9A9ulTw6
         p43A==
X-Gm-Message-State: APjAAAWtwyu5iHGrfSffqhOSZSQJF88oMLZ7rGjqI44ICGT++QEi6b8n
        qYxkw1iSXjsJSxTyRgYW4sqMkk4UnmJFWH0pZlQ=
X-Google-Smtp-Source: APXvYqyW1em6W7xlXG2UyGMG+FdvOIalowJ0t1Um4YeUYamaAZabpkASnAAlPisrD96XGIEEpRCwq5iFHIZ4+CYm1Q8=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr84723155ilh.9.1578164971526;
 Sat, 04 Jan 2020 11:09:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578072481.git.chris@chrisdown.name> <19ff8eddfe9cbafc87e55949189704f31d123172.1578072481.git.chris@chrisdown.name>
In-Reply-To: <19ff8eddfe9cbafc87e55949189704f31d123172.1578072481.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 4 Jan 2020 21:09:20 +0200
Message-ID: <CAOQ4uxjZUYNjBZKU85TMCjtBf9ear7s4yxYSZcBX6rTZoYK-Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tmpfs: Add per-superblock i_ino support
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 3, 2020 at 7:30 PM Chris Down <chris@chrisdown.name> wrote:
>
> get_next_ino has a number of problems:
>
> - It uses and returns a uint, which is susceptible to become overflowed
>   if a lot of volatile inodes that use get_next_ino are created.
> - It's global, with no specificity per-sb or even per-filesystem. This
>   means it's not that difficult to cause inode number wraparounds on a
>   single device, which can result in having multiple distinct inodes
>   with the same inode number.
>
> This patch adds a per-superblock counter that mitigates the second case.
> This design also allows us to later have a specific i_ino size
> per-device, for example, allowing users to choose whether to use 32- or
> 64-bit inodes for each tmpfs mount. This is implemented in the next
> commit.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> ---

Some nits. When fixed you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


>  include/linux/shmem_fs.h |  1 +
>  mm/shmem.c               | 33 ++++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index de8e4b71e3ba..7fac91f490dc 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -35,6 +35,7 @@ struct shmem_sb_info {
>         unsigned char huge;         /* Whether to try for hugepages */
>         kuid_t uid;                 /* Mount uid for root directory */
>         kgid_t gid;                 /* Mount gid for root directory */
> +       ino_t next_ino;             /* The next per-sb inode number to use */
>         struct mempolicy *mpol;     /* default memory policy for mappings */
>         spinlock_t shrinklist_lock;   /* Protects shrinklist */
>         struct list_head shrinklist;  /* List of shinkable inodes */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8793e8cc1a48..638b1e30625f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2236,6 +2236,15 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +/*
> + * shmem_get_inode - reserve, allocate, and initialise a new inode
> + *
> + * If SB_KERNMOUNT, we use the per-sb inode allocator to avoid wraparound.
> + * Otherwise, we use get_next_ino, which is global.

Its the other way around.

> + *
> + * If max_inodes is greater than 0 (ie. non-SB_KERNMOUNT), we may have to grab
> + * the per-sb stat_lock.

It's not a "may" it's for sure, but I don't see what this comment adds
in this context.
The comment about stat_lock below seems enough to me.

> + */
>  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
>                                      umode_t mode, dev_t dev, unsigned long flags)
>  {
> @@ -2248,7 +2257,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>
>         inode = new_inode(sb);
>         if (inode) {
> -               inode->i_ino = get_next_ino();
> +               if (sb->s_flags & SB_KERNMOUNT) {
> +                       /*
> +                        * __shmem_file_setup, one of our callers, is lock-free:
> +                        * it doesn't hold stat_lock in shmem_reserve_inode
> +                        * since max_inodes is always 0, and is called from
> +                        * potentially unknown contexts. As such, use the global
> +                        * allocator which doesn't require the per-sb
.
> +                        */
> +                       inode->i_ino = get_next_ino();
> +               } else {
> +                       spin_lock(&sbinfo->stat_lock);
> +                       if (unlikely(sbinfo->next_ino > UINT_MAX)) {
> +                               /*
> +                                * Emulate get_next_ino uint wraparound for
> +                                * compatibility
> +                                */
> +                               sbinfo->next_ino = 1;
> +                       }
> +                       inode->i_ino = sbinfo->next_ino++;
> +                       spin_unlock(&sbinfo->stat_lock);
> +               }
> +
>                 inode_init_owner(inode, dir, mode);
>                 inode->i_blocks = 0;
>                 inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> @@ -3662,6 +3692,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #else
>         sb->s_flags |= SB_NOUSER;
>  #endif
> +       sbinfo->next_ino = 1;
>         sbinfo->max_blocks = ctx->blocks;
>         sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
>         sbinfo->uid = ctx->uid;
> --
> 2.24.1
>
