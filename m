Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8469A141FE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgASUJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 15:09:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgASUJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:09:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so27490019wrq.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 12:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAyxBTnWsKqAvSZWiD7JEH46AsnmBofsRNOeahGOvCk=;
        b=H1MVUTXxLwFtPlmiCi4F0Tj3F10ZwdvNOTxF6j/kUzDRqrKNgwSGvBGASK5SQpHvIh
         EjHhiQAW2WkitN39LtSNjzG6mFMzdVoDMKTUJxx86TxS/cA7bbmJYH0vT7gXowhcUAqj
         vAx9v5rh8+H87JnvwSOgzcJy71KP91/svM1PdyeLdQcUmVM2WUXev/DB38GkKMZJYp1R
         l8MpgvmLApHbsbwuxGlU5VqAuDu4hLXLCa7Xh3JkWvG3DkZoUQQaQGH5L3KZa81YuUox
         1ih6hoqzUtYEhlvkkNKcQ5MmCzlm9vsn5YllsyOzkKFYQfIn6d6Mha2kkL/4TH6d3KpR
         82tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAyxBTnWsKqAvSZWiD7JEH46AsnmBofsRNOeahGOvCk=;
        b=CSQebhaQXltpcHjllCEM70Fo6GvgKG+MKSUhD8QCy2GapCPdHRad1e2KpQCXo4QAqG
         NI42Fcr6iKMGz7wTQu3ihjOkg6qHXlAdSOvnoEweQ77juoLcUzzx2TB43yGeAcXy5kJQ
         9PknBg4gd+jjoa5hu7fVqVolHLb256ZZG4gXw9nsv4iE+yZ/KWAJxd7B/jKOGGZfKbkt
         Q6u7a9OvMnB4OIrq94+1v2uKzEZa+x/eB7i+0QTyZItit1Lox3H4hpibk0JAubke0ldY
         UMfa4uSsbpATRfEOyNk5lByhi/6kx6KPEzXR5tKYA6V4/DJN1OGk/CevaWAz3UWgcOXE
         Rpkg==
X-Gm-Message-State: APjAAAX3CNyTZvqRrj2Hb1XCN0y+RYgx3NEUmGv2Y/xiGx22jL9d6iXd
        7IJklLZscXC2zdIv19VTD3u+mr4nFcMgxx6EQYiE1w==
X-Google-Smtp-Source: APXvYqzIDtXvbwXzUODAXRt8ASK8O/ir6OVfxwgJC9dXzUekqwiMTCQxUHPS+V27BQ2vANSiQXga1jWdGZud4eBPMp4=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr14386284wrs.184.1579464561146;
 Sun, 19 Jan 2020 12:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20191106091537.32480-1-s.hauer@pengutronix.de> <20191106091537.32480-6-s.hauer@pengutronix.de>
In-Reply-To: <20191106091537.32480-6-s.hauer@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 21:09:10 +0100
Message-ID: <CAFLxGvwfjokR=O+=EiC-6SkEsVSnwaNfxPOS_=7SVdSqHX6A=A@mail.gmail.com>
Subject: Re: [PATCH 5/7] ubifs: Add support for project id
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:16 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> The project id is necessary for quota project id support. This adds
> support for the project id to UBIFS as well as support for the
> FS_PROJINHERIT_FL flag.
>
> This includes a change for the UBIFS on-disk format. struct
> ubifs_ino_node gains a project id number and a UBIFS_PROJINHERIT_FL
> flag.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/dir.c         | 23 +++++++++++++++++++++--
>  fs/ubifs/ioctl.c       | 34 ++++++++++++++++++++++++++++++++--
>  fs/ubifs/journal.c     |  2 +-
>  fs/ubifs/super.c       |  1 +
>  fs/ubifs/ubifs-media.h |  6 ++++--
>  fs/ubifs/ubifs.h       |  4 ++++
>  6 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index cfce5fee9262..db2456537e6d 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -56,7 +56,8 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
>                  */
>                 return 0;
>
> -       flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL);
> +       flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL |
> +                            UBIFS_PROJINHERIT_FL);
>         if (!S_ISDIR(mode))
>                 /* The "DIRSYNC" flag only applies to directories */
>                 flags &= ~UBIFS_DIRSYNC_FL;
> @@ -112,6 +113,11 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
>                          current_time(inode);
>         inode->i_mapping->nrpages = 0;
>
> +       if (ubifs_inode(dir)->flags & UBIFS_PROJINHERIT_FL)
> +               ui->projid = ubifs_inode(dir)->projid;
> +       else
> +               ui->projid = make_kprojid(&init_user_ns, UBIFS_DEF_PROJID);
> +
>         switch (mode & S_IFMT) {
>         case S_IFREG:
>                 inode->i_mapping->a_ops = &ubifs_file_address_operations;
> @@ -705,6 +711,9 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
>         ubifs_assert(c, inode_is_locked(dir));
>         ubifs_assert(c, inode_is_locked(inode));
>
> +       if (!projid_eq(dir_ui->projid, ui->projid))
> +                return -EXDEV;
> +
>         err = fscrypt_prepare_link(old_dentry, dir, dentry);
>         if (err)
>                 return err;
> @@ -1556,8 +1565,18 @@ static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
>         if (err)
>                 return err;
>
> -       if (flags & RENAME_EXCHANGE)
> +       if ((ubifs_inode(new_dir)->flags & UBIFS_PROJINHERIT_FL) &&
> +           (!projid_eq(ubifs_inode(new_dir)->projid,
> +                       ubifs_inode(old_dentry->d_inode)->projid)))
> +               return -EXDEV;
> +
> +       if (flags & RENAME_EXCHANGE) {
> +               if ((ubifs_inode(old_dir)->flags & UBIFS_PROJINHERIT_FL) &&
> +                  (!projid_eq(ubifs_inode(old_dir)->projid,
> +                       ubifs_inode(new_dentry->d_inode)->projid)))
> +                       return -EXDEV;

Can we please have a small helper function for these checks?

>                 return ubifs_xrename(old_dir, old_dentry, new_dir, new_dentry);
> +       }
>
>         return do_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
>  }
> diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
> index 533df56beab4..829e71d9c9ae 100644
> --- a/fs/ubifs/ioctl.c
> +++ b/fs/ubifs/ioctl.c
> @@ -19,7 +19,7 @@
>  /* Need to be kept consistent with checked flags in ioctl2ubifs() */
>  #define UBIFS_SUPPORTED_IOCTL_FLAGS \
>         (FS_COMPR_FL | FS_SYNC_FL | FS_APPEND_FL | \
> -        FS_IMMUTABLE_FL | FS_DIRSYNC_FL)
> +        FS_IMMUTABLE_FL | FS_DIRSYNC_FL | FS_PROJINHERIT_FL)
>
>  /**
>   * ubifs_set_inode_flags - set VFS inode flags.
> @@ -66,6 +66,8 @@ static int ioctl2ubifs(int ioctl_flags)
>                 ubifs_flags |= UBIFS_IMMUTABLE_FL;
>         if (ioctl_flags & FS_DIRSYNC_FL)
>                 ubifs_flags |= UBIFS_DIRSYNC_FL;
> +       if (ioctl_flags & FS_PROJINHERIT_FL)
> +               ubifs_flags |= UBIFS_PROJINHERIT_FL;
>
>         return ubifs_flags;
>  }
> @@ -91,6 +93,8 @@ static int ubifs2ioctl(int ubifs_flags)
>                 ioctl_flags |= FS_IMMUTABLE_FL;
>         if (ubifs_flags & UBIFS_DIRSYNC_FL)
>                 ioctl_flags |= FS_DIRSYNC_FL;
> +       if (ubifs_flags & UBIFS_PROJINHERIT_FL)
> +               ioctl_flags |= FS_PROJINHERIT_FL;
>
>         return ioctl_flags;
>  }
> @@ -106,6 +110,8 @@ static inline unsigned long ubifs_xflags_to_iflags(__u32 xflags)
>                 iflags |= UBIFS_IMMUTABLE_FL;
>         if (xflags & FS_XFLAG_APPEND)
>                 iflags |= UBIFS_APPEND_FL;
> +       if (xflags & FS_XFLAG_PROJINHERIT)
> +               iflags |= UBIFS_PROJINHERIT_FL;
>
>          return iflags;
>  }
> @@ -121,15 +127,34 @@ static inline __u32 ubifs_iflags_to_xflags(unsigned long flags)
>                 xflags |= FS_XFLAG_IMMUTABLE;
>         if (flags & UBIFS_APPEND_FL)
>                 xflags |= FS_XFLAG_APPEND;
> +       if (flags & UBIFS_PROJINHERIT_FL)
> +               xflags |= FS_XFLAG_PROJINHERIT;
>
>          return xflags;
>  }
>
> +static int ubifs_ioc_setproject(struct file *file, __u32 projid)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct ubifs_inode *ui = ubifs_inode(inode);
> +       kprojid_t kprojid;
> +
> +       kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
> +       if (projid_eq(kprojid, ui->projid))
> +               return 0;
> +
> +       ui->projid = kprojid;
> +
> +       return 0;
> +}

You return in every case 0, so this function cannot fail? If so,
please make it of type void.

>  static void ubifs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>  {
>         struct ubifs_inode *ui = ubifs_inode(inode);
>
>         simple_fill_fsxattr(fa, ubifs_iflags_to_xflags(ui->flags));
> +
> +       fa->fsx_projid = (__u32)from_kprojid(&init_user_ns, ui->projid);
>  }
>
>  static int setflags(struct file *file, int flags, struct fsxattr *fa)
> @@ -180,6 +205,10 @@ static int setflags(struct file *file, int flags, struct fsxattr *fa)
>                 err = vfs_ioc_fssetxattr_check(inode, &old_fa, fa);
>                 if (err)
>                         goto out_unlock;
> +
> +               err = ubifs_ioc_setproject(file, fa->fsx_projid);
> +               if (err)
> +                       goto out_unlock;
>         }
>
>         ui->flags = ubi_flags;
> @@ -223,7 +252,8 @@ static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
>
>  static int check_xflags(unsigned int flags)
>  {
> -       if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND))
> +       if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND |
> +                     FS_XFLAG_PROJINHERIT))
>                 return -EOPNOTSUPP;
>         return 0;
>  }
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 4fd9683b8245..d8961993f9dd 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -54,7 +54,6 @@
>   */
>  static inline void zero_ino_node_unused(struct ubifs_ino_node *ino)
>  {
> -       memset(ino->padding1, 0, 4);
>         memset(ino->padding2, 0, 26);
>  }
>
> @@ -469,6 +468,7 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
>         ino->xattr_cnt   = cpu_to_le32(ui->xattr_cnt);
>         ino->xattr_size  = cpu_to_le32(ui->xattr_size);
>         ino->xattr_names = cpu_to_le32(ui->xattr_names);
> +       ino->projid = cpu_to_le32(from_kprojid(&init_user_ns, ui->projid));
>         zero_ino_node_unused(ino);
>
>         /*
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 7d4547e5202d..281f34789e32 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -141,6 +141,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
>         ui->xattr_size  = le32_to_cpu(ino->xattr_size);
>         ui->xattr_names = le32_to_cpu(ino->xattr_names);
>         ui->synced_i_size = ui->ui_size = inode->i_size;
> +       ui->projid = make_kprojid(&init_user_ns, le32_to_cpu(ino->projid));
>
>         ui->xattr = (ui->flags & UBIFS_XATTR_FL) ? 1 : 0;
>
> diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
> index 3c9792cbb6ff..418f4eba1624 100644
> --- a/fs/ubifs/ubifs-media.h
> +++ b/fs/ubifs/ubifs-media.h
> @@ -316,6 +316,7 @@ enum {
>   * UBIFS_DIRSYNC_FL: I/O on this directory inode has to be synchronous
>   * UBIFS_XATTR_FL: this inode is the inode for an extended attribute value
>   * UBIFS_CRYPT_FL: use encryption for this inode
> + * UBIFS_PROJINHERIT_FL: Create with parents projid
>   *
>   * Note, these are on-flash flags which correspond to ioctl flags
>   * (@FS_COMPR_FL, etc). They have the same values now, but generally, do not
> @@ -329,6 +330,7 @@ enum {
>         UBIFS_DIRSYNC_FL   = 0x10,
>         UBIFS_XATTR_FL     = 0x20,
>         UBIFS_CRYPT_FL     = 0x40,
> +       UBIFS_PROJINHERIT_FL = 0x80,
>  };
>
>  /* Inode flag bits used by UBIFS */
> @@ -497,7 +499,7 @@ union ubifs_dev_desc {
>   * @data_len: inode data length
>   * @xattr_cnt: count of extended attributes this inode has
>   * @xattr_size: summarized size of all extended attributes in bytes
> - * @padding1: reserved for future, zeroes
> + * @projid: Quota project id
>   * @xattr_names: sum of lengths of all extended attribute names belonging to
>   *               this inode
>   * @compr_type: compression type used for this inode
> @@ -531,7 +533,7 @@ struct ubifs_ino_node {
>         __le32 data_len;
>         __le32 xattr_cnt;
>         __le32 xattr_size;
> -       __u8 padding1[4]; /* Watch 'zero_ino_node_unused()' if changing! */
> +       __le32 projid;

You claim a new field in struct ubifs_ino_inode and add a new inode flag.
I fear this requires a new feature flag.

>         __le32 xattr_names;
>         __le16 compr_type;
>         __u8 padding2[26]; /* Watch 'zero_ino_node_unused()' if changing! */
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index c55f212dcb75..3f8a33fca67b 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -155,6 +155,8 @@
>  #define UBIFS_HMAC_ARR_SZ 0
>  #endif
>
> +#define UBIFS_DEF_PROJID 0
> +
>  /*
>   * Lockdep classes for UBIFS inode @ui_mutex.
>   */
> @@ -362,6 +364,7 @@ struct ubifs_gced_idx_leb {
>   *                 inodes
>   * @ui_size: inode size used by UBIFS when writing to flash
>   * @flags: inode flags (@UBIFS_COMPR_FL, etc)
> + * @projid: The project id of this inode
>   * @compr_type: default compression type used for this inode
>   * @last_page_read: page number of last page read (for bulk read)
>   * @read_in_a_row: number of consecutive pages read in a row (for bulk read)
> @@ -413,6 +416,7 @@ struct ubifs_inode {
>         loff_t synced_i_size;
>         loff_t ui_size;
>         int flags;
> +       kprojid_t projid;
>         pgoff_t last_page_read;
>         pgoff_t read_in_a_row;
>         int data_len;
> --
> 2.24.0.rc1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Thanks,
//richard
