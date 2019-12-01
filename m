Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD610E0F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 08:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfLAHET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 02:04:19 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38587 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLAHET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 02:04:19 -0500
Received: by mail-yb1-f196.google.com with SMTP id l129so4942395ybf.5;
        Sat, 30 Nov 2019 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TctkMlPAVLSjzuawMAd1EQqIa06301VLE5mTWaDVXjY=;
        b=G/NjmXxeOWiyc4NjVZFUa8tvZXn/K7tGuznlSGfWNK42dtxqbGP8sDd3pyu5e05D2+
         8iCCFFQNFVs95BcySfXzkP/EuQBcQEhuWzLw7NXDKLHAGArVUh9hQK7+bU24L5aSa153
         ZQaB6UgnX0K0qMLzcwHm/hvmgN9nIrky1AdKQJC/XeK4FRi8jDI5VK4ou/svXR9z1rc6
         iL9gsE9ZoenxwoeahsfDT4sEHmV7OaegPcHy5TNizAycMQMxWIFIIqE6nCKBrKvjDg/w
         qUlgqPHHmgJqnImo9W3GC3D8MxQAUdxzU5+xgebKqoxMj9wTnvpGaDPli/k7igMt/tW5
         455A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TctkMlPAVLSjzuawMAd1EQqIa06301VLE5mTWaDVXjY=;
        b=qUMzPo9TZqvKP+D4PrmXhGz0a0Lbv+RtK8BiO9RXMpHAwgG8+yQU3uFVUYLRSk1tCX
         +6qtw/wXpnxuEnt4NQfq/0zscda7k1nbolsSvvEQzDTwhf75LoDR0RHfXVmbULWr2dCD
         FzVa0ggp+hHmZ9myMy/3mO+4UOlxrkQUUc+XE3Ko2+0rmNLva3t6bghfVZQyEpZCNKT0
         49ma/KbJzBSVN2qa+NiwOuqzCiE+VKeMfT23b1J1E0fLCH/qpQp6ijb1BWbeRuFNOjVP
         2wYJr+ngmINHj3I/wIgfq5e459+xLFjn3Hyt5/ALsDvfJMOd+FXAX7icB0gnvkmZnqkV
         /eWw==
X-Gm-Message-State: APjAAAW+vYXs3NwbFh3jH8Aoo77Gi3p9sSO0mMulbiioq3/yok32Izpx
        4dXPzBsW8uZ2r49X1fwmG0ixeo97dfLH7dW5NPcgJCiR
X-Google-Smtp-Source: APXvYqzGZgnkzJ/8c0H5BbxHYUnNw++7wlztC7Xws3VVV420R+a5g/emDTweTHxVTF3l8Yy8HA35FS+pYLV9565zFtM=
X-Received: by 2002:a25:212:: with SMTP id 18mr45953804ybc.439.1575183857401;
 Sat, 30 Nov 2019 23:04:17 -0800 (PST)
MIME-Version: 1.0
References: <1575148763.5563.28.camel@HansenPartnership.com> <1575148868.5563.30.camel@HansenPartnership.com>
In-Reply-To: <1575148868.5563.30.camel@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 1 Dec 2019 09:04:05 +0200
Message-ID: <CAOQ4uxggMt77HHD4GOk4Rth8KAVz17f5CcZdgAfiMpTuQLz3PA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: rethread notify_change to take a path instead of
 a dentry
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi James!

On Sat, Nov 30, 2019 at 11:21 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> In order to prepare for implementing shiftfs as a property changing
> bind mount, the path (which contains the vfsmount) must be threaded
> through everywhere we are going to do either a permission check or an

I am curious how bind/shift mount is expected to handle inode_permission().

Otherwise, I am fine with the change, short of some style comments
below...

> attribute get/set so that we can arrange for the credentials for the
> operation to be based on the bind mount properties rather than those
> of current.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/base/devtmpfs.c   |  8 +++++--
>  fs/attr.c                 |  4 +++-
>  fs/cachefiles/interface.c |  6 +++--
>  fs/coredump.c             |  4 ++--
>  fs/ecryptfs/inode.c       |  9 ++++---
>  fs/inode.c                |  7 +++---
>  fs/namei.c                |  2 +-
>  fs/nfsd/vfs.c             |  9 +++++--
>  fs/open.c                 | 19 ++++++++-------
>  fs/overlayfs/copy_up.c    | 60 +++++++++++++++++++++++++++--------------------
>  fs/overlayfs/dir.c        | 16 ++++++++++---
>  fs/overlayfs/inode.c      |  6 +++--
>  fs/overlayfs/overlayfs.h  |  2 +-
>  fs/overlayfs/super.c      |  3 ++-
>  fs/utimes.c               |  2 +-
>  include/linux/fs.h        |  6 ++---
>  16 files changed, 102 insertions(+), 61 deletions(-)
>
[...]

> diff --git a/fs/attr.c b/fs/attr.c
> index df28035aa23e..370b18807f05 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -226,8 +226,10 @@ EXPORT_SYMBOL(setattr_copy);
>   * the file open for write, as there can be no conflicting delegation in
>   * that case.
>   */
> -int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **delegated_inode)
> +int notify_change(const struct path *path, struct iattr * attr,
> +                 struct inode **delegated_inode)
>  {
> +       struct dentry *dentry = path->dentry;

I suppose passing path down to all security/ima hooks is the next step?

>         struct inode *inode = dentry->d_inode;
>         umode_t mode = inode->i_mode;
>         int error;
> diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> index 4cea5fbf695e..aa82d95890fa 100644
> --- a/fs/cachefiles/interface.c
> +++ b/fs/cachefiles/interface.c
> @@ -436,6 +436,7 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
>         uint64_t ni_size;
>         loff_t oi_size;
>         int ret;
> +       struct path *path;
>
>         ni_size = _object->store_limit_l;
>
> @@ -466,18 +467,19 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
>         /* if there's an extension to a partial page at the end of the backing
>          * file, we need to discard the partial page so that we pick up new
>          * data after it */
> +       path = &(struct path) { .mnt = cache->mnt, .dentry = object->backer };

This style is weird for me. Is it just me?
If you just need the struct once, I rather you define it inside function args.
Otherwise, I'd rather the local path var wasn't a pointer, but the
actual struct.


[...]

> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d9a79f..72c45b9419d0 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -852,10 +852,11 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
>
>         rc = truncate_upper(dentry, &ia, &lower_ia);
>         if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
> -               struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
> +               struct path *path = ecryptfs_dentry_to_lower_path(dentry);
> +               struct dentry *lower_dentry = path->dentry;
>

Use lower_path for conformity.


[...]

> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1810,7 +1810,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
>         return mask;
>  }
>
> -static int __remove_privs(struct dentry *dentry, int kill)
> +static int __remove_privs(struct path *path, int kill)
>  {
>         struct iattr newattrs;
>
> @@ -1819,7 +1819,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
>          * Note we call this on write, so notify_change will not
>          * encounter any conflicting delegations:
>          */
> -       return notify_change(dentry, &newattrs, NULL);
> +       return notify_change(path, &newattrs, NULL);
>  }
>
>  /*
> @@ -1828,6 +1828,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
>   */
>  int file_remove_privs(struct file *file)
>  {
> +       struct path *path = &file->f_path;
>         struct dentry *dentry = file_dentry(file);
>         struct inode *inode = file_inode(file);
>         int kill;
> @@ -1846,7 +1847,7 @@ int file_remove_privs(struct file *file)

I suppose next step is to pass path down to
dentry_needs_remove_privs() => security_inode_need_killpriv()
or rather a new security_path_need_killpriv()?

[...]

> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bd0a385df3fc..5e758749cbc4 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -362,6 +362,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
>  {
>         struct dentry   *dentry;
>         struct inode    *inode;
> +       const struct path *path;
>         int             accmode = NFSD_MAY_SATTR;
>         umode_t         ftype = 0;
>         __be32          err;
> @@ -402,6 +403,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
>
>         dentry = fhp->fh_dentry;
>         inode = d_inode(dentry);
> +       path = &(struct path){
> +               .mnt = fhp->fh_export->ex_path.mnt,
> +               .dentry = dentry,
> +       };
>

There is no longer use for local var dentry.
Use local var path and assign fhp->fh_dentry directly to path.dentry.


[...]

> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b801c6353100..52bfca5016fe 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -177,17 +177,17 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>         return error;
>  }
>
> -static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
> +static int ovl_set_size(struct path *upperpath, struct kstat *stat)
>  {
>         struct iattr attr = {
>                 .ia_valid = ATTR_SIZE,
>                 .ia_size = stat->size,
>         };
>
> -       return notify_change(upperdentry, &attr, NULL);
> +       return notify_change(upperpath, &attr, NULL);
>  }
>
> -static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
> +static int ovl_set_timestamps(struct path *upperpath, struct kstat *stat)
>  {
>         struct iattr attr = {
>                 .ia_valid =
> @@ -196,10 +196,10 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
>                 .ia_mtime = stat->mtime,
>         };
>
> -       return notify_change(upperdentry, &attr, NULL);
> +       return notify_change(upperpath, &attr, NULL);
>  }
>
> -int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
> +int ovl_set_attr(struct path *upperpath, struct kstat *stat)
>  {
>         int err = 0;
>
> @@ -208,7 +208,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
>                         .ia_valid = ATTR_MODE,
>                         .ia_mode = stat->mode,
>                 };
> -               err = notify_change(upperdentry, &attr, NULL);
> +               err = notify_change(upperpath, &attr, NULL);
>         }
>         if (!err) {
>                 struct iattr attr = {
> @@ -216,10 +216,10 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
>                         .ia_uid = stat->uid,
>                         .ia_gid = stat->gid,
>                 };
> -               err = notify_change(upperdentry, &attr, NULL);
> +               err = notify_change(upperpath, &attr, NULL);
>         }
>         if (!err)
> -               ovl_set_timestamps(upperdentry, stat);
> +               ovl_set_timestamps(upperpath, stat);
>
>         return err;
>  }
> @@ -389,7 +389,7 @@ struct ovl_copy_up_ctx {
>         struct kstat stat;
>         struct kstat pstat;
>         const char *link;
> -       struct dentry *destdir;
> +       struct path *destpath;

It seems like you caused a lot of churn for that change and you only
use c->destpath in one place for ovl_set_timestamps(), so it might be
easier to compose destpath from c->destdir just in that one call site.

>         struct qstr destname;
>         struct dentry *workdir;
>         bool origin;
> @@ -403,6 +403,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>         struct dentry *upper;
>         struct dentry *upperdir = ovl_dentry_upper(c->parent);
>         struct inode *udir = d_inode(upperdir);
> +       struct path upperpath;
> +
> +       ovl_path_upper(c->parent, &upperpath);
>
>         /* Mark parent "impure" because it may now contain non-pure upper */
>         err = ovl_set_impure(c->parent, upperdir);
> @@ -423,7 +426,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>
>                 if (!err) {
>                         /* Restore timestamps on parent (best effort) */
> -                       ovl_set_timestamps(upperdir, &c->pstat);
> +                       ovl_set_timestamps(&upperpath, &c->pstat);
>                         ovl_dentry_set_upper_alias(c->dentry);
>                 }
>         }
> @@ -439,7 +442,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>  static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
>  {
>         int err;
> +       struct path upperpath, *path;
struct path temppath please.

... skipping a lot of unneeded churn...

> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 702aa63f6774..d694c5740bdb 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -334,7 +334,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
>         struct inode *wdir = workdir->d_inode;
>         struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
>         struct inode *udir = upperdir->d_inode;
> -       struct path upperpath;
> +       struct path upperpath, *opaquepath;
>         struct dentry *upper;
>         struct dentry *opaquedir;
>         struct kstat stat;
> @@ -373,8 +373,13 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
>         if (err)
>                 goto out_cleanup;
>
> +       opaquepath = &(struct path){
> +               .mnt = upperpath.mnt,
> +               .dentry = opaquedir
> +       };
> +

Please skip the local opaquepath pointer and use directly in function args.

>         inode_lock(opaquedir->d_inode);
> -       err = ovl_set_attr(opaquedir, &stat);
> +       err = ovl_set_attr(opaquepath, &stat);
>         inode_unlock(opaquedir->d_inode);
>         if (err)
>                 goto out_cleanup;
> @@ -435,10 +440,13 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
>         struct inode *udir = upperdir->d_inode;
>         struct dentry *upper;
>         struct dentry *newdentry;
> +       struct path path;

upperpath or newpath please.

>         int err;
>         struct posix_acl *acl, *default_acl;
>         bool hardlink = !!cattr->hardlink;
>
> +       ovl_path_upper(dentry, &path);
> +
>         if (WARN_ON(!workdir))
>                 return -EROFS;
>
> @@ -478,8 +486,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
>                         .ia_valid = ATTR_MODE,
>                         .ia_mode = cattr->mode,
>                 };
> +
> +               path.dentry = newdentry;
>                 inode_lock(newdentry->d_inode);
> -               err = notify_change(newdentry, &attr, NULL);
> +               err = notify_change(&path, &attr, NULL);
>                 inode_unlock(newdentry->d_inode);
>                 if (err)
>                         goto out_cleanup;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index bc14781886bf..218540003872 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -45,8 +45,10 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
>                 err = ovl_copy_up_with_data(dentry);
>         if (!err) {
>                 struct inode *winode = NULL;
> +               struct path path;

upperpath please. Otherwise it gets harder to tell between overlay path
and underlying path when reading the code.

>
> -               upperdentry = ovl_dentry_upper(dentry);
> +               ovl_path_upper(dentry, &path);
> +               upperdentry = path.dentry;
>
>                 if (attr->ia_valid & ATTR_SIZE) {
>                         winode = d_inode(upperdentry);
> @@ -60,7 +62,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
>
>                 inode_lock(upperdentry->d_inode);
>                 old_cred = ovl_override_creds(dentry->d_sb);
> -               err = notify_change(upperdentry, attr, NULL);
> +               err = notify_change(&path, attr, NULL);
>                 revert_creds(old_cred);
>                 if (!err)
>                         ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6934bcf030f0..dc50b97a5e68 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -423,7 +423,7 @@ int ovl_copy_up_with_data(struct dentry *dentry);
>  int ovl_copy_up_flags(struct dentry *dentry, int flags);
>  int ovl_maybe_copy_up(struct dentry *dentry, int flags);
>  int ovl_copy_xattr(struct dentry *old, struct dentry *new);
> -int ovl_set_attr(struct dentry *upper, struct kstat *stat);
> +int ovl_set_attr(struct path *upper, struct kstat *stat);

upperpath please, otherwise local var names for upper dentry/inode
can get messy.

Thanks,
Amir.
