Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676C312EAC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABUIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 15:08:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38591 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgABUHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:07:35 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so34961940ilq.5;
        Thu, 02 Jan 2020 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADZxyOtE04aQqYDD+Q60cU+52HbEnfx++KXEuxm9YY0=;
        b=vRksguKnFNoonBawKavYiGpaOs5Jsr+n80M7GveOvxo5FNvYklAWqxvDZIZtj+l00+
         h35BZ1c3v9m6bzVPS6n65lXHDwZz4x2JdiWsH3x4kAFlonDiMjG4n5IKOQ+LCDVufGDf
         hV9DHk3oddsWNH1QaK/mZDdWK8huEFqdNB1TSi+wnFemWX3JJYExt0RMusYEuWSdWAvB
         4j2Sogq1jMp74TbhXMsJtx7iKKk42XsmFA6qHqu1j68FzVqfor08akgVTtmoCRy1Ti+P
         ISi8JkZYnHAaMgdDXqtKB/KqQFUU3TG+HarMnLIt1RtcUW4r+iwqxJD4jfstj0OAXQAE
         VnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADZxyOtE04aQqYDD+Q60cU+52HbEnfx++KXEuxm9YY0=;
        b=DsjBG9WboVjfB9aUYzucQDqPRcLr4wBEoCMe4QK7VP4qd33KZC4UFcIk65HbFSRJ99
         UOxzfqMvySg1wPBNHJBwCezGJQsq86tDG6YHNOoTHEmZwWrc6+S8k8foXk73n8rV0cJ2
         D8aUQ9ekvV/c3CMTrrthfGpfwJ89NfVjpnmVJQ2F3zf/CxYW9oUuSRN9KSg4rfQDlf0F
         rg84naRY/Tat9X+Y5Q/0qsU7E/h2u9NhjKgyIwpwNU/MsI61bDV5r1avtrTFtzk19uPv
         p9YBN9bts0cUeLqtcUuhopPBiQ+yLl5P3vb/K+SBSazfzYRDYU5eJTKolbX7ae0l/hmo
         wiHw==
X-Gm-Message-State: APjAAAUGsg9/DCNqNG5eGPUQWbcXx2fDgknIKrUY2wjWTKLamJtWnq8i
        +dcWhZizo8aGqDlrDY9mmOAFlsmQLNnQoVplt0E=
X-Google-Smtp-Source: APXvYqziKGXTxpi7nBGtrv/gcm462mJvgeqROnCvSOBMDHFPAjEpGiJaRW7atHMxqSaaHOY2F+jEjNOPxENjK4u5wKA=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr75863589ilh.9.1577995654468;
 Thu, 02 Jan 2020 12:07:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577990599.git.chris@chrisdown.name> <34a170550a77c77ad7b6fdca86847ae7fd35d761.1577990599.git.chris@chrisdown.name>
In-Reply-To: <34a170550a77c77ad7b6fdca86847ae7fd35d761.1577990599.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Jan 2020 22:07:23 +0200
Message-ID: <CAOQ4uxg_V_TCPrOZdF2gkGgmnqeWaamABSyVp8Prx6Y+=WdLBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tmpfs: Support 64-bit inums per-sb
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

On Thu, Jan 2, 2020 at 8:50 PM Chris Down <chris@chrisdown.name> wrote:
>
> The default is still set to inode32 for backwards compatibility, but
> system administrators can opt in to the new 64-bit inode numbers by
> either:
>
> 1. Passing inode64 on the command line when mounting, or
> 2. Configuring the kernel with CONFIG_TMPFS_INODE64=y
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
>  Documentation/filesystems/tmpfs.txt | 11 ++++++
>  fs/Kconfig                          | 18 +++++++++
>  include/linux/shmem_fs.h            |  1 +
>  mm/shmem.c                          | 57 ++++++++++++++++++++++++++++-
>  4 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/tmpfs.txt b/Documentation/filesystems/tmpfs.txt
> index 5ecbc03e6b2f..203e12a684c9 100644
> --- a/Documentation/filesystems/tmpfs.txt
> +++ b/Documentation/filesystems/tmpfs.txt
> @@ -136,6 +136,15 @@ These options do not have any effect on remount. You can change these
>  parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
>
>
> +tmpfs has a mount option to select whether it will wrap at 32- or 64-bit inode
> +numbers:
> +
> +inode64   Use 64-bit inode numbers
> +inode32   Use 32-bit inode numbers
> +
> +On 64-bit, the default is set by CONFIG_TMPFS_INODE64. On 32-bit, inode64 is
> +not legal and will produce an error at mount time.
> +
>  So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
> @@ -147,3 +156,5 @@ Updated:
>     Hugh Dickins, 4 June 2007
>  Updated:
>     KOSAKI Motohiro, 16 Mar 2010
> +Updated:
> +   Chris Down, 2 Jan 2020
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7b623e9fc1b0..af2048ae71eb 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -199,6 +199,24 @@ config TMPFS_XATTR
>
>           If unsure, say N.
>
> +config TMPFS_INODE64
> +       bool "Use 64-bit ino_t by default in tmpfs"
> +       depends on TMPFS && 64BIT
> +       default n
> +       help
> +         tmpfs has historically used only inode numbers as wide as an unsigned
> +         int. In some cases this can cause wraparound, potentially resulting in
> +         multiple files with the same inode number on a single device. This option
> +         makes tmpfs use the full width of ino_t by default, similarly to the
> +         inode64 mount option.
> +
> +         tmpfs mounts that are used privately by the kernel and are not visible to
> +         users are unaffected.

Admins won't know what the line above means and they shouldn't care.
It adds no information, so better remove it.

> +
> +         To override this default, use the inode32 or inode64 mount options.
> +
> +         If unsure, say N.
> +
>  config HUGETLBFS
>         bool "HugeTLB file system support"
>         depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index dec4353cf3b7..0e645ecd6451 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -35,6 +35,7 @@ struct shmem_sb_info {
>         unsigned char huge;         /* Whether to try for hugepages */
>         kuid_t uid;                 /* Mount uid for root directory */
>         kgid_t gid;                 /* Mount gid for root directory */
> +       bool full_inums;            /* If i_ino should be uint or ino_t */
>         ino_t last_ino;             /* The last used per-sb inode number */
>         struct mempolicy *mpol;     /* default memory policy for mappings */
>         spinlock_t shrinklist_lock;   /* Protects shrinklist */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8af9fb922a96..fd2542e5ada9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -115,11 +115,13 @@ struct shmem_options {
>         kuid_t uid;
>         kgid_t gid;
>         umode_t mode;
> +       bool full_inums;
>         int huge;
>         int seen;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> +#define SHMEM_SEEN_INUMS 8
>  };
>
>  #ifdef CONFIG_TMPFS
> @@ -2260,7 +2262,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>                 if (use_sb_ino) {
>                         spin_lock(&sbinfo->stat_lock);
>                         inode->i_ino = sbinfo->last_ino++;
> -                       if (unlikely(inode->i_ino >= UINT_MAX)) {
> +                       if (unlikely(!sbinfo->full_inums &&
> +                                    inode->i_ino >= UINT_MAX)) {
>                                 /*
>                                  * Emulate get_next_ino uint wraparound for
>                                  * compatibility
> @@ -2277,6 +2280,12 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>                          * since max_inodes is always 0, and is called from
>                          * potentially unknown contexts. As such, use the global
>                          * allocator which doesn't require the per-sb stat_lock.
> +                        *
> +                        * No special behaviour is needed for
> +                        * sbinfo->full_inums, because it's not possible to
> +                        * manually set on callers of this type, and
> +                        * CONFIG_TMPFS_INODE64 only applies to user-visible
> +                        * mounts.
>                          */
>                         inode->i_ino = get_next_ino();
>                 }
> @@ -3450,6 +3459,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>         unsigned long long size;
>         char *rest;
>         int opt;
> +       const char *err;
>
>         opt = fs_parse(fc, &shmem_fs_parameters, param, &result);
>         if (opt < 0)
> @@ -3511,6 +3521,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>                         break;
>                 }
>                 goto unsupported_parameter;
> +       case Opt_inode32:
> +               ctx->full_inums = false;
> +               ctx->seen |= SHMEM_SEEN_INUMS;
> +               break;
> +       case Opt_inode64:
> +               if (sizeof(ino_t) < 8) {
> +                       err = "Cannot use inode64 with <64bit inums in kernel";
> +                       goto err_msg;
> +               }
> +               ctx->full_inums = true;
> +               ctx->seen |= SHMEM_SEEN_INUMS;
> +               break;
>         }
>         return 0;
>
> @@ -3518,6 +3540,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>         return invalf(fc, "tmpfs: Unsupported parameter '%s'", param->key);
>  bad_value:
>         return invalf(fc, "tmpfs: Bad value for '%s'", param->key);
> +err_msg:
> +       return invalf(fc, "tmpfs: %s", err);
>  }
>
>  static int shmem_parse_options(struct fs_context *fc, void *data)
> @@ -3602,6 +3626,12 @@ static int shmem_reconfigure(struct fs_context *fc)
>                 }
>         }
>
> +       if ((ctx->seen & SHMEM_SEEN_INUMS) && !ctx->full_inums &&
> +           sbinfo->last_ino > UINT_MAX) {
> +               err = "Current inum too high to switch to 32-bit inums";
> +               goto out;
> +       }
> +
>         if (ctx->seen & SHMEM_SEEN_HUGE)
>                 sbinfo->huge = ctx->huge;
>         if (ctx->seen & SHMEM_SEEN_BLOCKS)
> @@ -3643,6 +3673,29 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>         if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
>                 seq_printf(seq, ",gid=%u",
>                                 from_kgid_munged(&init_user_ns, sbinfo->gid));
> +
> +       /*
> +        * Showing inode{64,32} might be useful even if it's the system default,
> +        * since then people don't have to resort to checking both here and
> +        * /proc/config.gz to confirm 64-bit inums were successfully applied
> +        * (which may not even exist if IKCONFIG_PROC isn't enabled).
> +        *
> +        * We hide it when inode64 isn't the default and we are using 32-bit
> +        * inodes, since that probably just means the feature isn't even under
> +        * consideration.
> +        *
> +        * As such:
> +        *
> +        *                     +-----------------+-----------------+
> +        *                     | TMPFS_INODE64=y | TMPFS_INODE64=n |
> +        *  +------------------+-----------------+-----------------+
> +        *  | full_inums=true  | show            | show            |
> +        *  | full_inums=false | show            | hide            |
> +        *  +------------------+-----------------+-----------------+
> +        *
> +        */
> +       if (IS_ENABLED(CONFIG_TMPFS_INODE64) || !sbinfo->full_inums)

Condition does not match comment - should be || sbinfo->full_inums)

> +               seq_printf(seq, ",inode%d", (sbinfo->full_inums ? 64 : 32));
>  #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
>         /* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
>         if (sbinfo->huge)
> @@ -3702,6 +3755,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>         sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
>         sbinfo->uid = ctx->uid;
>         sbinfo->gid = ctx->gid;
> +       sbinfo->full_inums = ctx->full_inums;
>         sbinfo->mode = ctx->mode;
>         sbinfo->huge = ctx->huge;
>         sbinfo->mpol = ctx->mpol;
> @@ -3915,6 +3969,7 @@ int shmem_init_fs_context(struct fs_context *fc)
>         ctx->mode = 0777 | S_ISVTX;
>         ctx->uid = current_fsuid();
>         ctx->gid = current_fsgid();
> +       ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
>

This is the wrong place for this - it is also being set for the kern_mount.
Follow the lead of shmem_default_max_inodes.

Thanks,
Amir.
