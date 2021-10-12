Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8742AD2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhJLTYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhJLTYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:24:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1ABC061570;
        Tue, 12 Oct 2021 12:22:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so1365109lfu.5;
        Tue, 12 Oct 2021 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4cY9GcvIfvBxAnJRpUfdJ3XchXgtnRELeuFUTiwt9A=;
        b=WMK7LLPkn9Z0uxjW072psLU24ynN1P3Bl2LphoDOOKMJkEqbkAF+uQphON7Y7eaj/h
         a5n5boQ/8Srkj9356hs/bUWY96stk6UHby4viQXaQAPpVcyxjGx7bIhmBrkmf1Xfmawq
         sbtXF2ntjgYbtov39Hc1xYbu9Ui1sAfIRRrCPFDDPNMAbUos+FDiUl/hBr6Qzp3Ksw44
         WYmOIuHxs0NmXwA75zyzREsiQQ90nVSN0atj+E61ZNtiXBZ3jUAXvTurj0haKC6buQ82
         pXaVykwdZIDr640bZV5SVfjuS8iUz9SVBed+cj6HPmTCY/IhorEfF6N3XEUAGTzMFxwP
         rqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4cY9GcvIfvBxAnJRpUfdJ3XchXgtnRELeuFUTiwt9A=;
        b=ilUxC8Liv5ral4K2L6VadPo/IxMXmhcWKuXJUpYcpxmex09LU9t24cZxAiKCwX/Fff
         q24kfxWq6RBKOzyvfJavgDmUCyzuXmlpm9qK/+R5X1eZAv/IQ4Ez57EANthT9E9WAZ9A
         5HHLt6AFwmGkVlPr327NnqGUinMKqp+wRkydsxF2GkMGG12gtYMvi7q3SsnUeHUthcMU
         nGRQC4k/WmlH33cwqymCkJmB2xEj7DSHuvipCLeRXQg7fdrmqytW72251zV6QUnjQUak
         yMF/JiiXscjoOD+rD1yNowLOlu125x0ffCmgSJTf22wFR1J2xsEvQs2dR2G0T5R9XOY3
         aCQg==
X-Gm-Message-State: AOAM533dXNlCLUFeTTPHDnT3ld0ud1ovSSlao2cJ8cA+5MGgW5VUnjto
        Gp7TSSjB8mwqrLNOvcpu8czRN1LQM0EUTRfEkYI=
X-Google-Smtp-Source: ABdhPJzkwugGjoeCSR2zja5bXDk9neyN9MelG2qK80Ryk0tjJRB8N3r5NH8iG/3YQha0tAMK47iXp4X5O8oFpCLHOEI=
X-Received: by 2002:ac2:4f92:: with SMTP id z18mr35966059lfs.354.1634066520017;
 Tue, 12 Oct 2021 12:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210517134201.29271-1-omosnace@redhat.com> <20210517134201.29271-2-omosnace@redhat.com>
 <CAN-5tyF8J2+kpVtHHmwc9rASmn=EJmei8RB47cQAgYC6P1=GSw@mail.gmail.com>
In-Reply-To: <CAN-5tyF8J2+kpVtHHmwc9rASmn=EJmei8RB47cQAgYC6P1=GSw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 12 Oct 2021 15:21:48 -0400
Message-ID: <CAEjxPJ6TuqEf31z9bjyK7Nkhxw=b06xkLh1263Fz2xmNn-KUnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 1:08 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Mon, May 17, 2021 at 9:42 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Add a new FS_HANDLES_LSM_OPTS filesystem flag to singal to VFS that the
> > filesystem does LSM option setting for the given mount on its own, so
> > the security_sb_set_mnt_opts() call in vfs_get_tree() can be skipped.
> >
> > This allows the following simplifications:
> > 1. Removal of explicit LSM option handling from BTRFS.
> >
> >    This exists only because of the double-layer mount that BTRFS is
> >    doing for its subvolume support. Setting FS_HANDLES_LSM_OPTS on the
> >    inner layer (btrfs_root_fs_type) and unsetting FS_BINARY_MOUNTDATA
> >    from both layers allows us to leave the LSM option handling entirely
> >    on VFS as part of the outer vfs_get_tree() call.
> >
> > 2. Removal of FS_BINARY_MOUNTDATA flags from BTRFS's fs_types.
> >
> >    After applying (1.), we can let VFS eat away LSM opts at the outer
> >    mount layer and then do selinux_set_mnt_opts() with these opts, so
> >    setting the flag is no longer needed neither for preserving the LSM
> >    opts, nor for the SELinux double-set_mnt_opts exception.
> >
> > 3. Removal of the ugly FS_BINARY_MOUNTDATA special case from
> >    selinux_set_mnt_opts().
> >
> >    Applying (1.) and also setting FS_HANDLES_LSM_OPTS on NFS fs_types
> >    (which needs to unavoidably do the LSM options handling on its own
> >    due to the SECURITY_LSM_NATIVE_LABELS flag usage) gets us to the
> >    state where there is an exactly one security_sb_set_mnt_opts() or
> >    security_sb_clone_mnt_opts() call for each superblock, so the rather
> >    hacky FS_BINARY_MOUNTDATA special case can be finally removed from
> >    security_sb_set_mnt_opts().
> >
> > The only other filesystem that sets FS_BINARY_MOUNTDATA is coda, which
> > is also the only one that has binary mount data && doesn't do its own
> > LSM options handling. So for coda we leave FS_HANDLES_LSM_OPTS unset and
> > the behavior remains unchanged - with fsconfig(2) it (probably) won't
> > even mount and with mount(2) it still won't support LSM options (and the
> > security_sb_set_mnt_opts() will be always performed with empty LSM
> > options as before).
> >
> > AFAICT, this shouldn't negatively affect the other LSMs. In fact, I
> > think AppArmor will now gain the ability to do its DFA matching on BTRFS
> > mount options, which was prevented before due to FS_BINARY_MOUNTDATA
> > being set on both its fs_types.
>
> Tested-by: Olga Kornievskaia <kolga@netapp.com> (both patches).

Is this stalled on getting an Ack from vfs maintainers?

>
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  fs/btrfs/super.c         | 34 +++++-----------------------------
> >  fs/nfs/fs_context.c      |  6 ++++--
> >  fs/super.c               | 10 ++++++----
> >  include/linux/fs.h       |  3 ++-
> >  security/selinux/hooks.c | 15 ---------------
> >  5 files changed, 17 insertions(+), 51 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 4a396c1147f1..80716ead1cde 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1666,19 +1666,12 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
> >         struct btrfs_device *device = NULL;
> >         struct btrfs_fs_devices *fs_devices = NULL;
> >         struct btrfs_fs_info *fs_info = NULL;
> > -       void *new_sec_opts = NULL;
> >         fmode_t mode = FMODE_READ;
> >         int error = 0;
> >
> >         if (!(flags & SB_RDONLY))
> >                 mode |= FMODE_WRITE;
> >
> > -       if (data) {
> > -               error = security_sb_eat_lsm_opts(data, &new_sec_opts);
> > -               if (error)
> > -                       return ERR_PTR(error);
> > -       }
> > -
> >         /*
> >          * Setup a dummy root and fs_info for test/set super.  This is because
> >          * we don't actually fill this stuff out until open_ctree, but we need
> > @@ -1688,10 +1681,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
> >          * superblock with our given fs_devices later on at sget() time.
> >          */
> >         fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
> > -       if (!fs_info) {
> > -               error = -ENOMEM;
> > -               goto error_sec_opts;
> > -       }
> > +       if (!fs_info)
> > +               return ERR_PTR(-ENOMEM);
> > +
> >         btrfs_init_fs_info(fs_info);
> >
> >         fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
> > @@ -1748,9 +1740,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
> >                         set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
> >                 error = btrfs_fill_super(s, fs_devices, data);
> >         }
> > -       if (!error)
> > -               error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
> > -       security_free_mnt_opts(&new_sec_opts);
> >         if (error) {
> >                 deactivate_locked_super(s);
> >                 return ERR_PTR(error);
> > @@ -1762,8 +1751,6 @@ error_close_devices:
> >         btrfs_close_devices(fs_devices);
> >  error_fs_info:
> >         btrfs_free_fs_info(fs_info);
> > -error_sec_opts:
> > -       security_free_mnt_opts(&new_sec_opts);
> >         return ERR_PTR(error);
> >  }
> >
> > @@ -1925,17 +1912,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >         sync_filesystem(sb);
> >         set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
> >
> > -       if (data) {
> > -               void *new_sec_opts = NULL;
> > -
> > -               ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
> > -               if (!ret)
> > -                       ret = security_sb_remount(sb, new_sec_opts);
> > -               security_free_mnt_opts(&new_sec_opts);
> > -               if (ret)
> > -                       goto restore;
> > -       }
> > -
> >         ret = btrfs_parse_options(fs_info, data, *flags);
> >         if (ret)
> >                 goto restore;
> > @@ -2385,7 +2361,7 @@ static struct file_system_type btrfs_fs_type = {
> >         .name           = "btrfs",
> >         .mount          = btrfs_mount,
> >         .kill_sb        = btrfs_kill_super,
> > -       .fs_flags       = FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
> > +       .fs_flags       = FS_REQUIRES_DEV,
> >  };
> >
> >  static struct file_system_type btrfs_root_fs_type = {
> > @@ -2393,7 +2369,7 @@ static struct file_system_type btrfs_root_fs_type = {
> >         .name           = "btrfs",
> >         .mount          = btrfs_mount_root,
> >         .kill_sb        = btrfs_kill_super,
> > -       .fs_flags       = FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
> > +       .fs_flags       = FS_REQUIRES_DEV | FS_HANDLES_LSM_OPTS,
> >  };
> >
> >  MODULE_ALIAS_FS("btrfs");
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index d95c9a39bc70..b5db4160e89b 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -1557,7 +1557,8 @@ struct file_system_type nfs_fs_type = {
> >         .init_fs_context        = nfs_init_fs_context,
> >         .parameters             = nfs_fs_parameters,
> >         .kill_sb                = nfs_kill_super,
> > -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > +       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > +                                 FS_HANDLES_LSM_OPTS,
> >  };
> >  MODULE_ALIAS_FS("nfs");
> >  EXPORT_SYMBOL_GPL(nfs_fs_type);
> > @@ -1569,7 +1570,8 @@ struct file_system_type nfs4_fs_type = {
> >         .init_fs_context        = nfs_init_fs_context,
> >         .parameters             = nfs_fs_parameters,
> >         .kill_sb                = nfs_kill_super,
> > -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > +       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > +                                 FS_HANDLES_LSM_OPTS,
> >  };
> >  MODULE_ALIAS_FS("nfs4");
> >  MODULE_ALIAS("nfs4");
> > diff --git a/fs/super.c b/fs/super.c
> > index 11b7e7213fd1..918c77b8c161 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1520,10 +1520,12 @@ int vfs_get_tree(struct fs_context *fc)
> >         smp_wmb();
> >         sb->s_flags |= SB_BORN;
> >
> > -       error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > -       if (unlikely(error)) {
> > -               fc_drop_locked(fc);
> > -               return error;
> > +       if (!(fc->fs_type->fs_flags & FS_HANDLES_LSM_OPTS)) {
> > +               error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > +               if (unlikely(error)) {
> > +                       fc_drop_locked(fc);
> > +                       return error;
> > +               }
> >         }
> >
> >         /*
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c3c88fdb9b2a..36f9cd37bc83 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2469,7 +2469,8 @@ struct file_system_type {
> >  #define FS_HAS_SUBTYPE         4
> >  #define FS_USERNS_MOUNT                8       /* Can be mounted by userns root */
> >  #define FS_DISALLOW_NOTIFY_PERM        16      /* Disable fanotify permission events */
> > -#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> > +#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> > +#define FS_HANDLES_LSM_OPTS    64      /* FS handles LSM opts on its own - skip it in VFS */
> >  #define FS_THP_SUPPORT         8192    /* Remove once all fs converted */
> >  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during rename() internally. */
> >         int (*init_fs_context)(struct fs_context *);
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index eaea837d89d1..041529cbf214 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -684,21 +684,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >                 goto out;
> >         }
> >
> > -       /*
> > -        * Binary mount data FS will come through this function twice.  Once
> > -        * from an explicit call and once from the generic calls from the vfs.
> > -        * Since the generic VFS calls will not contain any security mount data
> > -        * we need to skip the double mount verification.
> > -        *
> > -        * This does open a hole in which we will not notice if the first
> > -        * mount using this sb set explict options and a second mount using
> > -        * this sb does not set any security options.  (The first options
> > -        * will be used for both mounts)
> > -        */
> > -       if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
> > -           && !opts)
> > -               goto out;
> > -
> >         root_isec = backing_inode_security_novalidate(root);
> >
> >         /*
> > --
> > 2.31.1
> >
