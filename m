Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBB2A04CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 12:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3LxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 07:53:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39570 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ3LxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:53:12 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kYSxm-0005pG-1z; Fri, 30 Oct 2020 11:52:58 +0000
Date:   Fri, 30 Oct 2020 12:52:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 32/34] overlayfs: handle idmapped lower directories
Message-ID: <20201030115257.j6ekfrlexxijxkte@wittgenstein>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-33-christian.brauner@ubuntu.com>
 <CAOQ4uxjC5bZk7+DcKLym4VNsR=FJMmC3VtCLAB7PzVL1BqKttg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjC5bZk7+DcKLym4VNsR=FJMmC3VtCLAB7PzVL1BqKttg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 01:10:52PM +0200, Amir Goldstein wrote:
> [reducing CC list for overlayfs specific comments]
> 
> On Thu, Oct 29, 2020 at 2:41 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > As an overlay filesystem overlayfs can be mounted on top of other filesystems
> > and bind-mounts. This means it can also be bind-mounted on top of one or
> > multiple idmapped lower directories and/or an idmapped upper directory.
> > In previous patches we've enabled the vfs to handle idmapped mounts and so we
> > should have all of the helpers available to let overlayfs handle idmapped
> > mounts. To handle such scenarios correctly overlayfs needs to be switched from
> > non-idmapped mount aware vfs helpers to idmapped mount aware vfs helpers.
> > In order to have overlayfs correctly support idmapped mounts as lower and upper
> > directories we need to pass down the mount's user namespace associated with the
> > lower and upper directories whenver we perform idmapped mount aware operations.
> >
> > Luckily, when overlayfs is mounted it creates private mounts of the lower and
> > upper directories via clone_private_mount() which calls clone_mnt() internally.
> > If any of the lower or upper directories are on an idmapped mount then
> > clone_mnt() called in clone_private_mount() will also pin the user namespace
> > the vfsmount has been marked with. Overlayfs stashes the information about the
> > lower and upper directories and the mounts that they are on so that this
> > information can be retrieved when needed. This makes it possible to support
> > idmapped mounts as lower and upper directories. Support for idmapped merged
> > mounts will be added in a follow-up patch.
> >
> > Whenever we perform idmap mount aware operations we need to pass down the
> > mount's user namespace to the vfs helpers we've introduced in earlier patches.
> > Permission checks on the lower and upper directories are performed by switching
> > from the inode_permission() and inode_owner_or_capable() helpers to the new
> > mapped_inode_permission() and mapped_inode_owner_or_capable() helpers.
> > Similarly we switch from non-idmapped mount aware lookup helpers to
> > idmapped-mount aware lookup helpers. In all cases where we need to check
> > permissions in the lower or upper directories we pass down the mount associated
> > with the lower and upper directory at the time of creating the overlayfs mount.
> > This nicely lines up with the permission model outlined in the overlayfs
> > documentation (Special thanks to Amir for pointing me to this document!).
> >
> > Thank to Amir for pointing me to the overlayfs permission model documentation!
> >
> > A very special thank you to my friend Seth Forshee who has given invaluable
> > advice when coming up with these patches!
> >
> > As an example let's create overlayfs mount in the initial user namespace with
> > an idmapped lower and upper mount:
> >
> >  # This is a directory where all file ownership starts with uid and gid 10000.
> >  root@f2-vm:/# ls -al /var/lib/lxc/f1/rootfs
> >  total 108
> >  drwxr-xr-x  20 10000 10000  4096 Oct 28 11:13 .
> >  drwxrwx---   4 10000 10000  4096 Oct 28 11:17 ..
> >  -rw-r--r--   1 10000 10000  7197 Oct 24 09:45 asdf
> >  drwxr-xr-x   2 10000 10000  4096 Oct 16 19:07 ASDF
> >  lrwxrwxrwx   1 10000 10000     7 Sep 24 07:43 bin -> usr/bin
> >  drwxr-xr-x   2 10000 10000  4096 Apr 15  2020 boot
> >  -rw-r--r--   1 10000 10000 13059 Oct  8 12:38 ccc
> >  drwxr-xr-x   2 11000 11000  4096 Oct 23 17:10 ddd
> >  drwxr-xr-x   3 10000 10000  4096 Sep 25 08:04 dev
> >  drwxr-xr-x  61 10000 10000  4096 Sep 25 08:04 etc
> >
> >  # Create an idmapped mount on the host such that all files owned by uid and
> >  # gid 10000 show up as being owned by uid 0 and gid 0.
> >  /mount2 --idmap both:10000:0:10000 /var/lib/lxc/f1/rootfs/ /lower1/
> >
> >  # Verify that the files show up as uid and gid 0 under the idmapped mount at /lower1
> >  root@f2-vm:/# ls -al /lower1/
> >  total 108
> >  drwxr-xr-x  20 root   root    4096 Oct 28 11:13 .
> >  drwxr-xr-x  29 root   root    4096 Oct 28 11:57 ..
> >  -rw-r--r--   1 root   root    7197 Oct 24 09:45 asdf
> >  drwxr-xr-x   2 root   root    4096 Oct 16 19:07 ASDF
> >  lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
> >  drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
> >  -rw-r--r--   1 root   root   13059 Oct  8 12:38 ccc
> >  drwxr-xr-x   2 ubuntu ubuntu  4096 Oct 23 17:10 ddd
> >  drwxr-xr-x   3 root   root    4096 Sep 25 08:04 dev
> >  drwxr-xr-x  61 root   root    4096 Sep 25 08:04 etc
> >
> >  # Create an idmapped upper mount at /upper. Now, files created as id 0 will
> >  # show up as id 10000 in /upper and files created as id 1000 will show up as
> >  # id 11000 under /upper.
> >  /mount2 --idmap both:10000:0:10000 /upper /upper
> >  mkdir /upper/upper
> >  mkdir /upper/work
> >
> >  # Create an overlayfs mount.
> >  mount -t overlay overlay -o lowerdir=/lower1/,upperdir=/upper/upper/,workdir=/upper/work/ /merged/
> >
> >  root@f2-vm:/# ls -al /merged/
> >  total 124
> >  drwxr-xr-x   1 root   root    4096 Oct 25 23:04 .
> >  drwxr-xr-x  29 root   root    4096 Oct 28 12:07 ..
> >  -rw-r--r--   1 root   root    7197 Oct 24 09:45 asdf
> >  drwxr-xr-x   2 root   root    4096 Oct 16 19:07 ASDF
> >  lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
> >  drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
> >  -rw-r--r--   1 root   root   13059 Oct  8 12:38 ccc
> >  drwxr-xr-x   2 ubuntu ubuntu  4096 Oct 23 17:10 ddd
> >  drwxr-xr-x   3 root   root    4096 Sep 25 08:04 dev
> >  drwxr-xr-x  61 root   root    4096 Sep 25 08:04 etc
> >
> >  # Create a file as as root
> >  root@f2-vm:/merged# touch /merged/A-FILE
> >
> >  root@f2-vm:/merged# ls -al /merged/A-FILE
> >  -rw-r--r-- 1 root root 0 Oct 28 12:16 /merged/A-FILE
> >
> >  # Chown the file to a simple user
> >  root@f2-vm:/merged# chown 1000:1000 /merged/A-FILE
> >
> >  root@f2-vm:/merged# ls -al /merged/A-FILE
> >  -rw-r--r-- 1 ubuntu ubuntu 0 Oct 28 12:16 /merged/A-FILE
> >
> >  # Create a directory and delegate to simple user
> >  root@f2-vm:/merged# mkdir /merged/A-DIR
> >
> >  root@f2-vm:/merged# chown 1000:1000 /merged/A-DIR/
> >
> >  # Login as user
> >  root@f2-vm:/merged# sudo -u ubuntu -- bash -i
> >
> >  # Create a file as simpel user
> >  ubuntu@f2-vm:/merged$ touch /merged/A-DIR/A-USER-FILE
> >
> >  ubuntu@f2-vm:/merged$ ls -al /merged/A-DIR/A-USER-FILE
> >  -rw-rw-r-- 1 ubuntu ubuntu 0 Oct 28 12:18 /merged/A-DIR/A-USER-FILE
> >
> >  # Let's look at these files in our idmapped upper directory
> >  ubuntu@f2-vm:/$ ls -alR /upper/upper/
> >  /upper/upper/:
> >  total 12
> >  drwxr-xr-x 3 root   root   4096 Oct 28 12:23 .
> >  drwxr-xr-x 4 root   root   4096 Oct 21 13:48 ..
> >  drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 12:18 A-DIR
> >  -rw-r--r-- 1 ubuntu ubuntu    0 Oct 28 12:16 A-FILE
> >
> >  /upper/upper/A-DIR:
> >  total 8
> >  drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 12:18 .
> >  drwxr-xr-x 3 root   root   4096 Oct 28 12:23 ..
> >  -rw-rw-r-- 1 ubuntu ubuntu    0 Oct 28 12:18 A-USER-FILE
> >
> >  # Let's remove the idmapped /upper mount (overlayfs will have it's own private mount anyway)
> >  umount /upper
> >
> >  # Let's look at these files in our upper directory with the idmapped mount removed
> >  ubuntu@f2-vm:/$ ls -alR /upper/upper/
> >  /upper/upper/:
> >  total 12
> >  drwxr-xr-x 3 10000 10000 4096 Oct 28 12:23 .
> >  drwxr-xr-x 4 10000 10000 4096 Oct 21 13:48 ..
> >  drwxr-xr-x 2 11000 11000 4096 Oct 28 12:18 A-DIR
> >  -rw-r--r-- 1 11000 11000    0 Oct 28 12:16 A-FILE
> >
> >  /upper/upper/A-DIR:
> >  total 8
> >  drwxr-xr-x 2 11000 11000 4096 Oct 28 12:18 .
> >  drwxr-xr-x 3 10000 10000 4096 Oct 28 12:23 ..
> >  -rw-rw-r-- 1 11000 11000    0 Oct 28 12:18 A-USER-FILE
> >
> >  # Let's create a few acls from the /merged directory  on an already existing file
> >  # triggering a copy-up operation
> >   root@f2-vm:/merged# setfacl -m u:1000:rwx /merged/asdf
> >   root@f2-vm:/merged# getfacl /merged/asdf
> >   getfacl: Removing leading '/' from absolute path names
> >   # file: merged/asdf
> >   # owner: root
> >   # group: root
> >   user::rw-
> >   user:ubuntu:rwx
> >   group::r--
> >   mask::rwx
> >   other::r--
> >
> >   # Let's look at this file from our upper directory
> >   root@f2-vm:/merged# getfacl /upper/upper/asdf
> >   getfacl: Removing leading '/' from absolute path names
> >   # file: upper/upper/asdf
> >   # owner: 10000
> >   # group: 10000
> >   user::rw-
> >   user:11000:rwx
> >   group::r--
> >   mask::rwx
> >   other::r--
> >
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  fs/overlayfs/copy_up.c   | 100 +++++++++++++++-----------
> >  fs/overlayfs/dir.c       | 151 ++++++++++++++++++++++-----------------
> >  fs/overlayfs/export.c    |   3 +-
> >  fs/overlayfs/file.c      |  23 +++---
> >  fs/overlayfs/inode.c     |  89 ++++++++++++++++++-----
> >  fs/overlayfs/namei.c     |  64 ++++++++++-------
> >  fs/overlayfs/overlayfs.h | 149 ++++++++++++++++++++++++++------------
> >  fs/overlayfs/ovl_entry.h |   1 +
> >  fs/overlayfs/readdir.c   |  34 +++++----
> >  fs/overlayfs/super.c     | 106 ++++++++++++++++++++-------
> >  fs/overlayfs/util.c      |  38 +++++-----
> >  11 files changed, 494 insertions(+), 264 deletions(-)
> >
> 
> Christian,
> 
> I think the vfs patches raised some eyebrows, but I can understand why
> you started
> with the explicit opt-in approach.
> If for nothing else, this posting is very educating about all the
> places that idmapping
> affects.
> 
> WRT this overlayfs patch. It takes the same approach as the vfs patched, passing
> user_ns all over the place, but there is usually no need for that,
> because in most
> cases, there is a much less intrusive way to get to the mnt.
> 
> Some examples below.
> 
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 955ecd4030f0..1b8721796fd4 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -43,7 +43,8 @@ static bool ovl_must_copy_xattr(const char *name)
> >                !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
> >  }
> >
> > -int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
> > +int ovl_copy_xattr(struct super_block *sb, struct user_namespace *old_user_ns,
> > +                  struct dentry *old, struct user_namespace *new_user_ns,
> >                    struct dentry *new)
> 
> 
> In this helper both callers already have the old path, so can pass it
> into the helper.
> new is always upper (because we never modify lower), so if you pass
> ovl_fs to the helper (we are slowly passing it down to all helpers) you
> will have the upper mnt.
> 
> >  {
> >         ssize_t list_size, size, value_size = 0;
> > @@ -85,9 +86,9 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
> >                 if (ovl_is_private_xattr(sb, name))
> >                         continue;
> >  retry:
> > -               size = vfs_getxattr(old, name, value, value_size);
> > +               size = vfs_mapped_getxattr(old_user_ns, old, name, value, value_size);
> >                 if (size == -ERANGE)
> > -                       size = vfs_getxattr(old, name, NULL, 0);
> > +                       size = vfs_mapped_getxattr(old_user_ns, old, name, NULL, 0);
> >
> >                 if (size < 0) {
> >                         error = size;
> > @@ -114,7 +115,7 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
> >                         error = 0;
> >                         continue; /* Discard */
> >                 }
> > -               error = vfs_setxattr(new, name, value, size, 0);
> > +               error = vfs_mapped_setxattr(new_user_ns, new, name, value, size, 0);
> >                 if (error) {
> >                         if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
> >                                 break;
> > @@ -228,17 +229,19 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
> >         return error;
> >  }
> >
> > -static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
> > +static int ovl_set_size(struct user_namespace *user_ns,
> > +                       struct dentry *upperdentry, struct kstat *stat)
> >  {
> >         struct iattr attr = {
> >                 .ia_valid = ATTR_SIZE,
> >                 .ia_size = stat->size,
> >         };
> >
> > -       return notify_change(upperdentry, &attr, NULL);
> > +       return notify_mapped_change(user_ns, upperdentry, &attr, NULL);
> >  }
> >
> > -static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
> > +static int ovl_set_timestamps(struct user_namespace *user_ns,
> > +                             struct dentry *upperdentry, struct kstat *stat)
> >  {
> >         struct iattr attr = {
> >                 .ia_valid =
> > @@ -247,10 +250,11 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
> >                 .ia_mtime = stat->mtime,
> >         };
> >
> > -       return notify_change(upperdentry, &attr, NULL);
> > +       return notify_mapped_change(user_ns, upperdentry, &attr, NULL);
> >  }
> >
> > -int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
> > +int ovl_set_attr(struct user_namespace *user_ns, struct dentry *upperdentry,
> > +                struct kstat *stat)
> >  {
> >         int err = 0;
> >
> > @@ -259,7 +263,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
> >                         .ia_valid = ATTR_MODE,
> >                         .ia_mode = stat->mode,
> >                 };
> > -               err = notify_change(upperdentry, &attr, NULL);
> > +               err = notify_mapped_change(user_ns, upperdentry, &attr, NULL);
> >         }
> >         if (!err) {
> >                 struct iattr attr = {
> > @@ -267,10 +271,10 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
> >                         .ia_uid = stat->uid,
> >                         .ia_gid = stat->gid,
> >                 };
> > -               err = notify_change(upperdentry, &attr, NULL);
> > +               err = notify_mapped_change(user_ns, upperdentry, &attr, NULL);
> >         }
> >         if (!err)
> > -               ovl_set_timestamps(upperdentry, stat);
> > +               ovl_set_timestamps(user_ns, upperdentry, stat);
> >
> >         return err;
> >  }
> 
> Same to all those helpers that get upperdentry, you can pass ovl_fs.
> 
> > @@ -356,8 +360,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
> >  }
> >
> >  /* Store file handle of @upper dir in @index dir entry */
> > -static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
> > -                           struct dentry *index)
> > +static int ovl_set_upper_fh(struct ovl_fs *ofs, struct user_namespace *user_ns,
> > +                           struct dentry *upper, struct dentry *index)
> >  {
> 
> And here you already have ovl_fs.
> 
> >         const struct ovl_fh *fh;
> >         int err;
> > @@ -377,7 +381,8 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
> >   *
> >   * Caller must hold i_mutex on indexdir.
> >   */
> > -static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
> > +static int ovl_create_index(struct user_namespace *user_ns,
> > +                           struct dentry *dentry, struct dentry *origin,
> >                             struct dentry *upper)
> >  {
> >         struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
> > @@ -406,25 +411,25 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
> >         if (err)
> >                 return err;
> >
> > -       temp = ovl_create_temp(indexdir, OVL_CATTR(S_IFDIR | 0));
> > +       temp = ovl_create_temp(user_ns, indexdir, OVL_CATTR(S_IFDIR | 0));
> >         err = PTR_ERR(temp);
> >         if (IS_ERR(temp))
> >                 goto free_name;
> >
> > -       err = ovl_set_upper_fh(OVL_FS(dentry->d_sb), upper, temp);
> > +       err = ovl_set_upper_fh(OVL_FS(dentry->d_sb), user_ns, upper, temp);
> >         if (err)
> >                 goto out;
> >
> > -       index = lookup_one_len(name.name, indexdir, name.len);
> > +       index = lookup_one_len_mapped(name.name, indexdir, name.len, user_ns);
> >         if (IS_ERR(index)) {
> >                 err = PTR_ERR(index);
> >         } else {
> > -               err = ovl_do_rename(dir, temp, dir, index, 0);
> > +               err = ovl_do_rename(dir, user_ns, temp, dir, user_ns, index, 0);
> >                 dput(index);
> >         }
> >  out:
> >         if (err)
> > -               ovl_cleanup(dir, temp);
> > +               ovl_cleanup(user_ns, dir, temp);
> >         dput(temp);
> >  free_name:
> >         kfree(name.name);
> > @@ -441,6 +446,7 @@ struct ovl_copy_up_ctx {
> >         struct dentry *destdir;
> >         struct qstr destname;
> >         struct dentry *workdir;
> > +       struct user_namespace *user_ns;
> >         bool origin;
> >         bool indexed;
> >         bool metacopy;
> > @@ -463,16 +469,17 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
> >                 return err;
> >
> >         inode_lock_nested(udir, I_MUTEX_PARENT);
> > -       upper = lookup_one_len(c->dentry->d_name.name, upperdir,
> > -                              c->dentry->d_name.len);
> > +       upper = lookup_one_len_mapped(c->dentry->d_name.name, upperdir,
> > +                                 c->dentry->d_name.len,
> > +                                 c->user_ns);
> >         err = PTR_ERR(upper);
> >         if (!IS_ERR(upper)) {
> > -               err = ovl_do_link(ovl_dentry_upper(c->dentry), udir, upper);
> > +               err = ovl_do_link(c->user_ns, ovl_dentry_upper(c->dentry), udir, upper);
> >                 dput(upper);
> >
> >                 if (!err) {
> >                         /* Restore timestamps on parent (best effort) */
> > -                       ovl_set_timestamps(upperdir, &c->pstat);
> > +                       ovl_set_timestamps(c->user_ns, upperdir, &c->pstat);
> >                         ovl_dentry_set_upper_alias(c->dentry);
> >                 }
> >         }
> > @@ -509,7 +516,8 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
> >                         return err;
> >         }
> >
> > -       err = ovl_copy_xattr(c->dentry->d_sb, c->lowerpath.dentry, temp);
> > +       err = ovl_copy_xattr(c->dentry->d_sb, mnt_user_ns(c->lowerpath.mnt),
> > +                            c->lowerpath.dentry, c->user_ns, temp);
> >         if (err)
> >                 return err;
> >
> > @@ -535,9 +543,9 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
> >
> >         inode_lock(temp->d_inode);
> >         if (S_ISREG(c->stat.mode))
> > -               err = ovl_set_size(temp, &c->stat);
> > +               err = ovl_set_size(c->user_ns, temp, &c->stat);
> >         if (!err)
> > -               err = ovl_set_attr(temp, &c->stat);
> > +               err = ovl_set_attr(c->user_ns, temp, &c->stat);
> >         inode_unlock(temp->d_inode);
> >
> >         return err;
> > @@ -598,7 +606,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
> >         if (err)
> >                 goto unlock;
> >
> > -       temp = ovl_create_temp(c->workdir, &cattr);
> > +       temp = ovl_create_temp(c->user_ns, c->workdir, &cattr);
> >         ovl_revert_cu_creds(&cc);
> >
> >         err = PTR_ERR(temp);
> > @@ -610,17 +618,18 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
> >                 goto cleanup;
> >
> >         if (S_ISDIR(c->stat.mode) && c->indexed) {
> > -               err = ovl_create_index(c->dentry, c->lowerpath.dentry, temp);
> > +               err = ovl_create_index(c->user_ns, c->dentry, c->lowerpath.dentry, temp);
> >                 if (err)
> >                         goto cleanup;
> >         }
> >
> > -       upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
> > +       upper = lookup_one_len_mapped(c->destname.name, c->destdir, c->destname.len,
> > +                                 c->user_ns);
> >         err = PTR_ERR(upper);
> >         if (IS_ERR(upper))
> >                 goto cleanup;
> >
> > -       err = ovl_do_rename(wdir, temp, udir, upper, 0);
> > +       err = ovl_do_rename(wdir, c->user_ns, temp, udir, c->user_ns, upper, 0);
> >         dput(upper);
> >         if (err)
> >                 goto cleanup;
> > @@ -637,7 +646,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
> >         return err;
> >
> >  cleanup:
> > -       ovl_cleanup(wdir, temp);
> > +       ovl_cleanup(c->user_ns, wdir, temp);
> >         dput(temp);
> >         goto unlock;
> >  }
> > @@ -654,7 +663,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
> >         if (err)
> >                 return err;
> >
> > -       temp = ovl_do_tmpfile(c->workdir, c->stat.mode);
> > +       temp = ovl_do_tmpfile(c->user_ns, c->workdir, c->stat.mode);
> >         ovl_revert_cu_creds(&cc);
> >
> >         if (IS_ERR(temp))
> > @@ -666,10 +675,11 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
> >
> >         inode_lock_nested(udir, I_MUTEX_PARENT);
> >
> > -       upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
> > +       upper = lookup_one_len_mapped(c->destname.name, c->destdir, c->destname.len,
> > +                                 c->user_ns);
> >         err = PTR_ERR(upper);
> >         if (!IS_ERR(upper)) {
> > -               err = ovl_do_link(temp, udir, upper);
> > +               err = ovl_do_link(c->user_ns, temp, udir, upper);
> >                 dput(upper);
> >         }
> >         inode_unlock(udir);
> > @@ -757,7 +767,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
> >
> >                 /* Restore timestamps on parent (best effort) */
> >                 inode_lock(udir);
> > -               ovl_set_timestamps(c->destdir, &c->pstat);
> > +               ovl_set_timestamps(c->user_ns, c->destdir, &c->pstat);
> >                 inode_unlock(udir);
> >
> >                 ovl_dentry_set_upper_alias(c->dentry);
> > @@ -786,12 +796,13 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
> >         return true;
> >  }
> >
> > -static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
> > +static ssize_t ovl_getxattr(struct user_namespace *user_ns,
> > +                           struct dentry *dentry, char *name, char **value)
> >  {
> >         ssize_t res;
> >         char *buf;
> >
> > -       res = vfs_getxattr(dentry, name, NULL, 0);
> > +       res = vfs_mapped_getxattr(user_ns, dentry, name, NULL, 0);
> >         if (res == -ENODATA || res == -EOPNOTSUPP)
> >                 res = 0;
> >
> > @@ -800,7 +811,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
> >                 if (!buf)
> >                         return -ENOMEM;
> >
> > -               res = vfs_getxattr(dentry, name, buf, res);
> > +               res = vfs_mapped_getxattr(user_ns, dentry, name, buf, res);
> >                 if (res < 0)
> >                         kfree(buf);
> >                 else
> > @@ -814,6 +825,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
> >  {
> >         struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
> >         struct path upperpath, datapath;
> > +       struct user_namespace *user_ns;
> >         int err;
> >         char *capability = NULL;
> >         ssize_t cap_size;
> > @@ -827,8 +839,8 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
> >                 return -EIO;
> >
> >         if (c->stat.size) {
> > -               err = cap_size = ovl_getxattr(upperpath.dentry, XATTR_NAME_CAPS,
> > -                                             &capability);
> > +               err = cap_size = ovl_getxattr(c->user_ns, upperpath.dentry,
> > +                                             XATTR_NAME_CAPS, &capability);
> >                 if (cap_size < 0)
> >                         goto out;
> >         }
> > @@ -841,9 +853,10 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
> >          * Writing to upper file will clear security.capability xattr. We
> >          * don't want that to happen for normal copy-up operation.
> >          */
> > +       user_ns = mnt_user_ns(upperpath.mnt);
> >         if (capability) {
> > -               err = vfs_setxattr(upperpath.dentry, XATTR_NAME_CAPS,
> > -                                  capability, cap_size, 0);
> > +               err = vfs_mapped_setxattr(user_ns, upperpath.dentry,
> > +                                     XATTR_NAME_CAPS, capability, cap_size, 0);
> >                 if (err)
> >                         goto out_free;
> >         }
> > @@ -887,6 +900,7 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
> >                 ovl_path_upper(parent, &parentpath);
> >                 ctx.destdir = parentpath.dentry;
> >                 ctx.destname = dentry->d_name;
> > +               ctx.user_ns = mnt_user_ns(parentpath.mnt);
> >
> >                 err = vfs_getattr(&parentpath, &ctx.pstat,
> >                                   STATX_ATIME | STATX_MTIME,
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 28a075b5f5b2..23d09de00957 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -23,15 +23,16 @@ MODULE_PARM_DESC(redirect_max,
> >
> >  static int ovl_set_redirect(struct dentry *dentry, bool samedir);
> >
> > -int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
> > +int ovl_cleanup(struct user_namespace *user_ns, struct inode *wdir,
> > +               struct dentry *wdentry)
> 
> I think this one and lookup_temp should also pass ovl_fs, but
> need to be careful when they are called from ovl_fill_super()
> that upper_mnt is already assigned (should be).
> 
> >  {
> >         int err;
> >
> >         dget(wdentry);
> >         if (d_is_dir(wdentry))
> > -               err = ovl_do_rmdir(wdir, wdentry);
> > +               err = ovl_do_rmdir(user_ns, wdir, wdentry);
> >         else
> > -               err = ovl_do_unlink(wdir, wdentry);
> > +               err = ovl_do_unlink(user_ns, wdir, wdentry);
> >         dput(wdentry);
> >
> >         if (err) {
> > @@ -42,7 +43,8 @@ int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
> >         return err;
> >  }
> >
> > -struct dentry *ovl_lookup_temp(struct dentry *workdir)
> > +struct dentry *ovl_lookup_temp(struct user_namespace *user_ns,
> > +                              struct dentry *workdir)
> >  {
> >         struct dentry *temp;
> >         char name[20];
> > @@ -51,7 +53,7 @@ struct dentry *ovl_lookup_temp(struct dentry *workdir)
> >         /* counter is allowed to wrap, since temp dentries are ephemeral */
> >         snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
> >
> > -       temp = lookup_one_len(name, workdir, strlen(name));
> > +       temp = lookup_one_len_mapped(name, workdir, strlen(name), user_ns);
> >         if (!IS_ERR(temp) && temp->d_inode) {
> >                 pr_err("workdir/%s already exists\n", name);
> >                 dput(temp);
> > @@ -68,13 +70,14 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >         struct dentry *whiteout;
> >         struct dentry *workdir = ofs->workdir;
> >         struct inode *wdir = workdir->d_inode;
> > +       struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
> >
> >         if (!ofs->whiteout) {
> > -               whiteout = ovl_lookup_temp(workdir);
> > +               whiteout = ovl_lookup_temp(user_ns, workdir);
> >                 if (IS_ERR(whiteout))
> >                         goto out;
> >
> > -               err = ovl_do_whiteout(wdir, whiteout);
> > +               err = ovl_do_whiteout(user_ns, wdir, whiteout);
> >                 if (err) {
> >                         dput(whiteout);
> >                         whiteout = ERR_PTR(err);
> > @@ -84,11 +87,11 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >         }
> >
> >         if (ofs->share_whiteout) {
> > -               whiteout = ovl_lookup_temp(workdir);
> > +               whiteout = ovl_lookup_temp(user_ns, workdir);
> >                 if (IS_ERR(whiteout))
> >                         goto out;
> >
> > -               err = ovl_do_link(ofs->whiteout, wdir, whiteout);
> > +               err = ovl_do_link(user_ns, ofs->whiteout, wdir, whiteout);
> >                 if (!err)
> >                         goto out;
> >
> > @@ -110,6 +113,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> >                              struct dentry *dentry)
> >  {
> >         struct inode *wdir = ofs->workdir->d_inode;
> > +       struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
> >         struct dentry *whiteout;
> >         int err;
> >         int flags = 0;
> > @@ -122,28 +126,28 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> >         if (d_is_dir(dentry))
> >                 flags = RENAME_EXCHANGE;
> >
> > -       err = ovl_do_rename(wdir, whiteout, dir, dentry, flags);
> > +       err = ovl_do_rename(wdir, user_ns, whiteout, dir, user_ns, dentry, flags);
> >         if (err)
> >                 goto kill_whiteout;
> >         if (flags)
> > -               ovl_cleanup(wdir, dentry);
> > +               ovl_cleanup(user_ns, wdir, dentry);
> >
> >  out:
> >         dput(whiteout);
> >         return err;
> >
> >  kill_whiteout:
> > -       ovl_cleanup(wdir, whiteout);
> > +       ovl_cleanup(user_ns, wdir, whiteout);
> >         goto out;
> >  }
> >
> > -static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
> > -                         umode_t mode)
> > +static int ovl_mkdir_real(struct user_namespace *user_ns, struct inode *dir,
> > +                         struct dentry **newdentry, umode_t mode)
> >  {
> >         int err;
> >         struct dentry *d, *dentry = *newdentry;
> >
> > -       err = ovl_do_mkdir(dir, dentry, mode);
> > +       err = ovl_do_mkdir(user_ns, dir, dentry, mode);
> >         if (err)
> >                 return err;
> >
> > @@ -155,8 +159,8 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
> >          * to it unhashed and negative. If that happens, try to
> >          * lookup a new hashed and positive dentry.
> >          */
> > -       d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
> > -                          dentry->d_name.len);
> > +       d = lookup_one_len_mapped(dentry->d_name.name, dentry->d_parent,
> > +                             dentry->d_name.len, user_ns);
> >         if (IS_ERR(d)) {
> >                 pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
> >                         dentry, err);
> > @@ -168,7 +172,8 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
> >         return 0;
> >  }
> >
> > -struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
> > +struct dentry *ovl_create_real(struct user_namespace *user_ns,
> > +                              struct inode *dir, struct dentry *newdentry,
> >                                struct ovl_cattr *attr)
> >  {
> >         int err;
> > @@ -181,28 +186,28 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
> >                 goto out;
> >
> >         if (attr->hardlink) {
> > -               err = ovl_do_link(attr->hardlink, dir, newdentry);
> > +               err = ovl_do_link(user_ns, attr->hardlink, dir, newdentry);
> >         } else {
> >                 switch (attr->mode & S_IFMT) {
> >                 case S_IFREG:
> > -                       err = ovl_do_create(dir, newdentry, attr->mode);
> > +                       err = ovl_do_create(user_ns, dir, newdentry, attr->mode);
> >                         break;
> >
> >                 case S_IFDIR:
> >                         /* mkdir is special... */
> > -                       err =  ovl_mkdir_real(dir, &newdentry, attr->mode);
> > +                       err =  ovl_mkdir_real(user_ns, dir, &newdentry, attr->mode);
> >                         break;
> >
> >                 case S_IFCHR:
> >                 case S_IFBLK:
> >                 case S_IFIFO:
> >                 case S_IFSOCK:
> > -                       err = ovl_do_mknod(dir, newdentry, attr->mode,
> > +                       err = ovl_do_mknod(user_ns, dir, newdentry, attr->mode,
> >                                            attr->rdev);
> >                         break;
> >
> >                 case S_IFLNK:
> > -                       err = ovl_do_symlink(dir, newdentry, attr->link);
> > +                       err = ovl_do_symlink(user_ns, dir, newdentry, attr->link);
> >                         break;
> >
> >                 default:
> > @@ -224,10 +229,11 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
> >         return newdentry;
> >  }
> >
> 
> ovl_fs to all those create helpers
> 
> > -struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr)
> > +struct dentry *ovl_create_temp(struct user_namespace *user_ns, struct dentry *workdir,
> > +                              struct ovl_cattr *attr)
> 
> Not only should this get ovl_fs, but workdir could be later taken from
> ofs->workdir.
> It's subtle because there is one caller ovl_create_index() that needs special
> care so leave that cleanup to me.
> 
> Anyway, I think you get the idea, but I am jumping ahead of myself.
> Let's wait and see how the vfs patches play out.
> 
> One naive question:
> 
> If we want to avoid all the vfs API churn we can store the mnt_user_ns
> in current cred.
> Overlayfs can prepare at mount time one cred copy per layer and in
> ovl_override_creds()
> we can pass the ovl_layer id.
> In some functions, such as ovl_looup() that access several layers, we
> will need to take
> care of overriding different creds per layer.
> 
> The concerns raised about storing userns in current wrt io_uring are
> not relevant
> for overlayfs access to underlying layers.
> 
> I know you and others have listed some use cases that are not
> involving overlayfs,
> but perhaps as a first step, this approach will be a much easier sell
> and can cover
> some of the use cases?

The vfs approach was always going to raise eye-brows. That doesn't mean
it's not the correct way to do it. Any larger change to the vfs would
have and did have the same effect.
I think that we should go for a proper generic solution instead of just
for one filesystem. Overlayfs is a use-case that we're keen to handle as
part of the large approach to this.

Christian
