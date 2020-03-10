Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6589B17F2AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 10:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCJJEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 05:04:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33392 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCJJEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:04:51 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so6112240ilg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xzr8UYzdvftZ6ltdGQbjJdh9bUR9GLrhRRIuy8ArwB4=;
        b=RDyHe6m5+q+Scf2Ni55JlRKzEtOHifAsDgt15eT2pTD2VUKeCE+KYgQtdZAmwFkarQ
         VKizaqkSXZl/ApSAqJqKTuW8HtJtha4X5WiTaSB8lHdNasnkHa7vIw1Pck0qfsUm0f9K
         0TdOkgNWcVzOzIOjdNwjtzWumRcBSZHCrjOJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xzr8UYzdvftZ6ltdGQbjJdh9bUR9GLrhRRIuy8ArwB4=;
        b=lopNKUAE0On4qnCVXDaeDkebep/lpDFpYf+hkLqPq9ac3zd+DcTwakU5gqqOvE42Nd
         /g25aze9nM8MO5JioTw6cvUKjhgHREVE8iuI2PsU2yRHyb9h5aUYibpz8p8IWhEp41jc
         oZt30PtFQ1YMAuMTWTRyAfsrKQW5Gt9kLrMS/PGPQ0CqoJ+f/28aeTdfpLnyA6ygapvc
         nqn0XX/9nJcCOSFjunV9DzST3ELCtSLyJZwM0r5MtKMl4cndsI7gKIbg+NU4MGi0d5La
         5kleJCV/ca8PwSTbjT1V3yvDSUimTLf3tX3BD89T9LqabNINx/hyWogLkZ0KRWIOKZsB
         93BQ==
X-Gm-Message-State: ANhLgQ3huiOr9IogWFPCFapFn0AGvqYuiDRjqHGzFEjZ0uR+816E3I1a
        vaVTZzVrLeEjKxpARsfsMpyGnkmM6KhaceJ9H6wLoQ==
X-Google-Smtp-Source: ADFU+vvq8i3JMm5o0X3/1MqtmAel5jkKS2wcrPJRHAwLVOCTl1K0j3m/i1LMC83XO9ToGr4MeFAzuPBc8Q6td2fS6RY=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr19302685ilj.174.1583831088115;
 Tue, 10 Mar 2020 02:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376251286.344135.12815432977346939752.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376251286.344135.12815432977346939752.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 10:04:36 +0100
Message-ID: <CAJfpegv202o=NmRF5rFpzdGyZSSC_MmVg9cOeFDrnjjQ2Fjk6Q@mail.gmail.com>
Subject: Re: [PATCH 07/14] fsinfo: Allow mount information to be queried [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:02 PM David Howells <dhowells@redhat.com> wrote:
>
> Allow mount information, including information about the topology tree to
> be queried with the fsinfo() system call.  Setting AT_FSINFO_QUERY_MOUNT
> allows overlapping mounts to be queried by indicating that the syscall
> should interpet the pathname as a number indicating the mount ID.
>
> To this end, a number of fsinfo() attributes are provided:
>
>  (1) FSINFO_ATTR_MOUNT_INFO.
>
>      This is a structure providing information about a mount, including:
>
>         - Mounted superblock ID (mount ID uniquifier).
>         - Mount ID (can be used with AT_FSINFO_QUERY_MOUNT).
>         - Parent mount ID.
>         - Mount attributes (eg. R/O, NOEXEC).
>         - Mount change/notification counter.
>
>      Note that the parent mount ID is overridden to the ID of the queried
>      mount if the parent lies outside of the chroot or dfd tree.
>
>  (2) FSINFO_ATTR_MOUNT_PATH.
>
>      This a string providing information about a bind mount relative the
>      the root that was bound off, though it may get overridden by the
>      filesystem (NFS unconditionally sets it to "/", for example).
>
>  (3) FSINFO_ATTR_MOUNT_POINT.
>
>      This is a string indicating the name of the mountpoint within the
>      parent mount, limited to the parent's mounted root and the chroot.
>
>  (4) FSINFO_ATTR_MOUNT_POINT_FULL.
>
>      This is a string indicating the full path of the mountpoint, limited to
>      the chroot.
>
>  (5) FSINFO_ATTR_MOUNT_CHILDREN.
>
>      This produces an array of structures, one for each child and capped
>      with one for the argument mount (checked after listing all the
>      children).  Each element contains the mount ID and the change counter
>      of the respective mount object.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/d_path.c                 |    2
>  fs/fsinfo.c                 |   14 +++
>  fs/internal.h               |   10 ++
>  fs/namespace.c              |  177 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsinfo.h |   36 +++++++++
>  samples/vfs/test-fsinfo.c   |   43 ++++++++++
>  6 files changed, 281 insertions(+), 1 deletion(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 0f1fc1743302..4c203f64e45e 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -229,7 +229,7 @@ static int prepend_unreachable(char **buffer, int *buflen)
>         return prepend(buffer, buflen, "(unreachable)", 13);
>  }
>
> -static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
> +void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
>  {
>         unsigned seq;
>
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index bafeb73feaf4..6d2bc03998e4 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -236,6 +236,14 @@ static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx
>                         ret = sb->s_op->show_options(&m, path->mnt->mnt_root);
>                 break;
>
> +       case FSINFO_ATTR_MOUNT_PATH:
> +               if (sb->s_op->show_path) {
> +                       ret = sb->s_op->show_path(&m, path->mnt->mnt_root);
> +               } else {
> +                       seq_dentry(&m, path->mnt->mnt_root, " \t\n\\");
> +               }
> +               break;
> +
>         case FSINFO_ATTR_FS_STATISTICS:
>                 if (sb->s_op->show_stats)
>                         ret = sb->s_op->show_stats(&m, path->mnt->mnt_root);
> @@ -270,6 +278,12 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
>
>         FSINFO_LIST     (FSINFO_ATTR_FSINFO_ATTRIBUTES, (void *)123UL),
>         FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
> +
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_MOUNT_INFO,        fsinfo_generic_mount_info),
> +       FSINFO_STRING   (FSINFO_ATTR_MOUNT_PATH,        fsinfo_generic_seq_read),
> +       FSINFO_STRING   (FSINFO_ATTR_MOUNT_POINT,       fsinfo_generic_mount_point),
> +       FSINFO_STRING   (FSINFO_ATTR_MOUNT_POINT_FULL,  fsinfo_generic_mount_point_full),
> +       FSINFO_LIST     (FSINFO_ATTR_MOUNT_CHILDREN,    fsinfo_generic_mount_children),
>         {}
>  };
>
> diff --git a/fs/internal.h b/fs/internal.h
> index abbd5299e7dc..1a318dc85f2f 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -15,6 +15,7 @@ struct mount;
>  struct shrink_control;
>  struct fs_context;
>  struct user_namespace;
> +struct fsinfo_context;
>
>  /*
>   * block_dev.c
> @@ -47,6 +48,11 @@ extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>   */
>  extern void __init chrdev_init(void);
>
> +/*
> + * d_path.c
> + */
> +extern void get_fs_root_rcu(struct fs_struct *fs, struct path *root);
> +
>  /*
>   * fs_context.c
>   */
> @@ -93,6 +99,10 @@ extern void __mnt_drop_write_file(struct file *);
>  extern void dissolve_on_fput(struct vfsmount *);
>  extern int lookup_mount_object(struct path *, int, struct path *);
>  extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
>
>  /*
>   * fs_struct.c
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 54e8eb93fdd6..a6cb8c6b004f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4149,4 +4149,181 @@ int lookup_mount_object(struct path *root, int mnt_id, struct path *_mntpt)
>         goto out_unlock;
>  }
>
> +/*
> + * Retrieve information about the nominated mount.
> + */
> +int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_mount_info *p = ctx->buffer;
> +       struct super_block *sb;
> +       struct mount *m;
> +       struct path root;
> +       unsigned int flags;
> +
> +       m = real_mount(path->mnt);
> +       sb = m->mnt.mnt_sb;
> +
> +       p->sb_unique_id         = sb->s_unique_id;
> +       p->mnt_unique_id        = m->mnt_unique_id;
> +       p->mnt_id               = m->mnt_id;
> +       p->parent_id            = m->mnt_parent->mnt_id;
> +
> +       get_fs_root(current->fs, &root);
> +       if (path->mnt == root.mnt) {
> +               p->parent_id = p->mnt_id;
> +       } else {
> +               rcu_read_lock();
> +               if (!are_paths_connected(&root, path))
> +                       p->parent_id = p->mnt_id;
> +               rcu_read_unlock();
> +       }
> +       if (IS_MNT_SHARED(m))
> +               p->group_id = m->mnt_group_id;
> +       if (IS_MNT_SLAVE(m)) {
> +               int master = m->mnt_master->mnt_group_id;
> +               int dom = get_dominating_id(m, &root);

This isn't safe without namespace_sem or mount_lock.

Thanks,
Miklos
