Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70D462EDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhK3Ivj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 03:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhK3Ive (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:51:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB48C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 00:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9C6FCE181F
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 08:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE5DC53FC1;
        Tue, 30 Nov 2021 08:48:10 +0000 (UTC)
Date:   Tue, 30 Nov 2021 09:48:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/10] fs: add is_mapped_mnt() helper
Message-ID: <20211130084807.jebnzt37b5ourva4@wittgenstein>
References: <20211123114227.3124056-1-brauner@kernel.org>
 <20211123114227.3124056-2-brauner@kernel.org>
 <CAOQ4uxj-iyqbcpNaNr3s7Eb2u12MHQmc3cDZQh9UZOFDQyxCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj-iyqbcpNaNr3s7Eb2u12MHQmc3cDZQh9UZOFDQyxCeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:25:40AM +0200, Amir Goldstein wrote:
> On Tue, Nov 23, 2021 at 2:18 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Multiple places open-code the same check to determine whether a given
> > mount is idmapped. Introduce a simple helper function that can be used
> > instead. This allows us to get rid of the fragile open-coding. We will
> > later change the check that is used to determine whether a given mount
> > is idmapped. Introducing a helper allows us to do this in a single
> > place instead of doing it for multiple places.
> >
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  fs/cachefiles/bind.c |  2 +-
> >  fs/ecryptfs/main.c   |  2 +-
> >  fs/namespace.c       |  2 +-
> >  fs/nfsd/export.c     |  2 +-
> >  fs/overlayfs/super.c |  2 +-
> >  fs/proc_namespace.c  |  2 +-
> >  include/linux/fs.h   | 14 ++++++++++++++
> >  7 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> > index d463d89f5db8..8130142d89c2 100644
> > --- a/fs/cachefiles/bind.c
> > +++ b/fs/cachefiles/bind.c
> > @@ -117,7 +117,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
> >         root = path.dentry;
> >
> >         ret = -EINVAL;
> > -       if (mnt_user_ns(path.mnt) != &init_user_ns) {
> > +       if (is_mapped_mnt(path.mnt)) {
> >                 pr_warn("File cache on idmapped mounts not supported");
> >                 goto error_unsupported;
> >         }
> > diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> > index d66bbd2df191..331ac3a59515 100644
> > --- a/fs/ecryptfs/main.c
> > +++ b/fs/ecryptfs/main.c
> > @@ -537,7 +537,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
> >                 goto out_free;
> >         }
> >
> > -       if (mnt_user_ns(path.mnt) != &init_user_ns) {
> > +       if (is_mapped_mnt(path.mnt)) {
> >                 rc = -EINVAL;
> >                 printk(KERN_ERR "Mounting on idmapped mounts currently disallowed\n");
> >                 goto out_free;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 659a8f39c61a..7d7b80b375a4 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3936,7 +3936,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
> >          * mapping. It makes things simpler and callers can just create
> >          * another bind-mount they can idmap if they want to.
> >          */
> > -       if (mnt_user_ns(m) != &init_user_ns)
> > +       if (is_mapped_mnt(m))
> >                 return -EPERM;
> >
> >         /* The underlying filesystem doesn't support idmapped mounts yet. */
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 9421dae22737..292bde9e1eb3 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -427,7 +427,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
> >                 return -EINVAL;
> >         }
> >
> > -       if (mnt_user_ns(path->mnt) != &init_user_ns) {
> > +       if (is_mapped_mnt(path->mnt)) {
> >                 dprintk("exp_export: export of idmapped mounts not yet supported.\n");
> >                 return -EINVAL;
> >         }
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 265181c110ae..113575fc6155 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -873,7 +873,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
> >                 pr_err("filesystem on '%s' not supported\n", name);
> >                 goto out_put;
> >         }
> > -       if (mnt_user_ns(path->mnt) != &init_user_ns) {
> > +       if (is_mapped_mnt(path->mnt)) {
> >                 pr_err("idmapped layers are currently not supported\n");
> >                 goto out_put;
> >         }
> > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > index 392ef5162655..788c687bb052 100644
> > --- a/fs/proc_namespace.c
> > +++ b/fs/proc_namespace.c
> > @@ -80,7 +80,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
> >                         seq_puts(m, fs_infop->str);
> >         }
> >
> > -       if (mnt_user_ns(mnt) != &init_user_ns)
> > +       if (is_mapped_mnt(mnt))
> >                 seq_puts(m, ",idmapped");
> >  }
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 1cb616fc1105..192242476b2b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2725,6 +2725,20 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
> >  {
> >         return mnt_user_ns(file->f_path.mnt);
> >  }
> > +
> > +/**
> > + * is_mapped_mnt - check whether a mount is mapped
> > + * @mnt: the mount to check
> > + *
> > + * If @mnt has an idmapping attached to it @mnt is mapped.
> > + *
> > + * Return: true if mount is mapped, false if not.
> > + */
> > +static inline bool is_mapped_mnt(const struct vfsmount *mnt)
> > +{
> > +       return mnt_user_ns(mnt) != &init_user_ns;
> > +}
> > +
> 
> Maybe is_idmapped_mnt?

Fine by me!
