Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDA868D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfHHSdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 14:33:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46648 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHSdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:33:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so89974968ljg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZOoSZyEfhp85smjgbjbz/Bcoz3DO2zVeVj/Isq7NAQ=;
        b=hmKxGC2aZ9A+2PQcV8ETsrKHT6LW2bKxwchme3M1Ne+eCF5omvi5o7vyOjPz6J3qsd
         vTQjYsnIiezXGDBNnhuHyKZvKNWIOyYftU+PHZvDTOJErPFB56rv4p7CbbHio+qAFNwv
         5ZwIFgH8A9ycYlkj8oRuo/QxckemUT8kh7hd/xM9AWWMk1/Hr3jibyapP0ev0dA1/T6O
         sRjigtdBpspt2LUpTg+3A2I9FzqDUsP3RI8KF+3qmbpdFERnGepTK3AjihZenTw6IzWU
         5e7vz9qaTrcZmsCajBsnJ1ZMDt2mrg4buPRB3S7efm/cDkFhPFAxRAW2As/IkLoiq4QG
         7BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZOoSZyEfhp85smjgbjbz/Bcoz3DO2zVeVj/Isq7NAQ=;
        b=fdOJZPK9sgEgt1NE52SYiWd800r2w80CJ3bIiXSdynSZhVmFiw0Onlh+DUI7calysU
         wS731cEQZpAr2xLrTMlqItGb5esxlVFd6aQlajb2pwPVuCdPCWhKF1AQN9XgvJg+taBZ
         gD3VKfg8w7D3CTfgW21zXZbnH1g4GgSvfOvsm7RgWTDB+984X8ITVPTse1AYZNW7BcvA
         wozs1Df0H0m1DvIdMjWopYppOi95lWDIKe6UXRBcUF5sZEAm+nvC9A6E+WPJJoVR1gcm
         zQvpDTljfS3WNTmWMyTHkmea5aKTpojaweIxW9YvS7KnddbKAQBrnwtbOpG7pkXo28mD
         Rn1A==
X-Gm-Message-State: APjAAAUjvEOqheb+joJh/7KCE5vQw9idAE6HBYz9eW92hqXPvxf0U0qE
        UEwSaQPBBlAVVoMFCtdfo3o3i9h/G09y0iI6S30q
X-Google-Smtp-Source: APXvYqxFQYeGdTDig3tiQkxKeDdIISuRgd+xuwBgnXMfT5dL751nfArcOtPwWAx8nEibdgQNyUIb3fRztEfbycQAS4E=
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr9381121ljj.129.1565289216299;
 Thu, 08 Aug 2019 11:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Aug 2019 14:33:24 -0400
Message-ID: <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, jack@suse.cz, amir73il@gmail.com,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:35 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> As of now, setting watches on filesystem objects has, at most, applied a
> check for read access to the inode, and in the case of fanotify, requires
> CAP_SYS_ADMIN. No specific security hook or permission check has been
> provided to control the setting of watches. Using any of inotify, dnotify,
> or fanotify, it is possible to observe, not only write-like operations, but
> even read access to a file. Modeling the watch as being merely a read from
> the file is insufficient for the needs of SELinux. This is due to the fact
> that read access should not necessarily imply access to information about
> when another process reads from a file. Furthermore, fanotify watches grant
> more power to an application in the form of permission events. While
> notification events are solely, unidirectional (i.e. they only pass
> information to the receiving application), permission events are blocking.
> Permission events make a request to the receiving application which will
> then reply with a decision as to whether or not that action may be
> completed. This causes the issue of the watching application having the
> ability to exercise control over the triggering process. Without drawing a
> distinction within the permission check, the ability to read would imply
> the greater ability to control an application. Additionally, mount and
> superblock watches apply to all files within the same mount or superblock.
> Read access to one file should not necessarily imply the ability to watch
> all files accessed within a given mount or superblock.
>
> In order to solve these issues, a new LSM hook is implemented and has been
> placed within the system calls for marking filesystem objects with inotify,
> fanotify, and dnotify watches. These calls to the hook are placed at the
> point at which the target path has been resolved and are provided with the
> path struct, the mask of requested notification events, and the type of
> object on which the mark is being set (inode, superblock, or mount). The
> mask and obj_type have already been translated into common FS_* values
> shared by the entirety of the fs notification infrastructure. The path
> struct is passed rather than just the inode so that the mount is available,
> particularly for mount watches. This also allows for use of the hook by
> pathname-based security modules. However, since the hook is intended for
> use even by inode based security modules, it is not placed under the
> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
> modules would need to enable all of the path hooks, even though they do not
> use any of them.
>
> This only provides a hook at the point of setting a watch, and presumes
> that permission to set a particular watch implies the ability to receive
> all notification about that object which match the mask. This is all that
> is required for SELinux. If other security modules require additional hooks
> or infrastructure to control delivery of notification, these can be added
> by them. It does not make sense for us to propose hooks for which we have
> no implementation. The understanding that all notifications received by the
> requesting application are all strictly of a type for which the application
> has been granted permission shows that this implementation is sufficient in
> its coverage.
>
> Security modules wishing to provide complete control over fanotify must
> also implement a security_file_open hook that validates that the access
> requested by the watching application is authorized. Fanotify has the issue
> that it returns a file descriptor with the file mode specified during
> fanotify_init() to the watching process on event. This is already covered
> by the LSM security_file_open hook if the security module implements
> checking of the requested file mode there. Otherwise, a watching process
> can obtain escalated access to a file for which it has not been authorized.
>
> The selinux_path_notify hook implementation works by adding five new file
> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> (descriptions about which will follow), and one new filesystem permission:
> watch (which is applied to superblock checks). The hook then decides which
> subset of these permissions must be held by the requesting application
> based on the contents of the provided mask and the obj_type. The
> selinux_file_open hook already checks the requested file mode and therefore
> ensures that a watching process cannot escalate its access through
> fanotify.
>
> The watch, watch_mount, and watch_sb permissions are the baseline
> permissions for setting a watch on an object and each are a requirement for
> any watch to be set on a file, mount, or superblock respectively. It should
> be noted that having either of the other two permissions (watch_reads and
> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> permission. Superblock watches further require the filesystem watch
> permission to the superblock. As there is no labeled object in view for
> mounts, there is no specific check for mount watches beyond watch_mount to
> the inode. Such a check could be added in the future, if a suitable labeled
> object existed representing the mount.
>
> The watch_reads permission is required to receive notifications from
> read-exclusive events on filesystem objects. These events include accessing
> a file for the purpose of reading and closing a file which has been opened
> read-only. This distinction has been drawn in order to provide a direct
> indication in the policy for this otherwise not obvious capability. Read
> access to a file should not necessarily imply the ability to observe read
> events on a file.
>
> Finally, watch_with_perm only applies to fanotify masks since it is the
> only way to set a mask which allows for the blocking, permission event.
> This permission is needed for any watch which is of this type. Though
> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
> trust to root, which we do not do, and does not support least privilege.
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
>  fs/notify/dnotify/dnotify.c         | 15 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>  fs/notify/inotify/inotify_user.c    | 13 ++++++--
>  include/linux/lsm_hooks.h           |  9 +++++-
>  include/linux/security.h            | 10 ++++--
>  security/security.c                 |  6 ++++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 120 insertions(+), 12 deletions(-)

Other than Casey's comments, and ACK, I'm not seeing much commentary
on this patch so FS and LSM folks consider this your last chance - if
I don't hear any objections by the end of this week I'll plan on
merging this into selinux/next next week.

> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..87a7f61bc91c 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/dnotify.h>
>  #include <linux/init.h>
> +#include <linux/security.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/fdtable.h>
> @@ -288,6 +289,17 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>                 goto out_err;
>         }
>
> +       /*
> +        * convert the userspace DN_* "arg" to the internal FS_*
> +        * defined in fsnotify
> +        */
> +       mask = convert_arg(arg);
> +
> +       error = security_path_notify(&filp->f_path, mask,
> +                       FSNOTIFY_OBJ_TYPE_INODE);
> +       if (error)
> +               goto out_err;
> +
>         /* expect most fcntl to add new rather than augment old */
>         dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>         if (!dn) {
> @@ -302,9 +314,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>                 goto out_err;
>         }
>
> -       /* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
> -       mask = convert_arg(arg);
> -
>         /* set up the new_fsn_mark and new_dn_mark */
>         new_fsn_mark = &new_dn_mark->fsn_mark;
>         fsnotify_init_mark(new_fsn_mark, dnotify_group);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a90bb19dcfa2..b83f27021f54 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
>  };
>
>  static int fanotify_find_path(int dfd, const char __user *filename,
> -                             struct path *path, unsigned int flags)
> +                             struct path *path, unsigned int flags, __u64 mask)
>  {
>         int ret;
> +       unsigned int obj_type;
>
>         pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
>                  dfd, filename, flags);
> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>
>         /* you can only watch an inode if you have read permissions on it */
>         ret = inode_permission(path->dentry->d_inode, MAY_READ);
> +       if (ret) {
> +               path_put(path);
> +               goto out;
> +       }
> +
> +       switch (flags & FANOTIFY_MARK_TYPE_BITS) {
> +       case FAN_MARK_MOUNT:
> +               obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> +               break;
> +       case FAN_MARK_FILESYSTEM:
> +               obj_type = FSNOTIFY_OBJ_TYPE_SB;
> +               break;
> +       case FAN_MARK_INODE:
> +               obj_type = FSNOTIFY_OBJ_TYPE_INODE;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       ret = security_path_notify(path, mask, obj_type);
>         if (ret)
>                 path_put(path);
> +
>  out:
>         return ret;
>  }
> @@ -1014,7 +1037,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 goto fput_and_out;
>         }
>
> -       ret = fanotify_find_path(dfd, pathname, &path, flags);
> +       ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>         if (ret)
>                 goto fput_and_out;
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 7b53598c8804..e0d593c2d437 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -39,6 +39,7 @@
>  #include <linux/poll.h>
>  #include <linux/wait.h>
>  #include <linux/memcontrol.h>
> +#include <linux/security.h>
>
>  #include "inotify.h"
>  #include "../fdinfo.h"
> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops = {
>  /*
>   * find_inode - resolve a user-given path to a specific inode
>   */
> -static int inotify_find_inode(const char __user *dirname, struct path *path, unsigned flags)
> +static int inotify_find_inode(const char __user *dirname, struct path *path,
> +                                               unsigned int flags, __u64 mask)
>  {
>         int error;
>
> @@ -351,8 +353,15 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
>                 return error;
>         /* you can only watch an inode if you have read permissions on it */
>         error = inode_permission(path->dentry->d_inode, MAY_READ);
> +       if (error) {
> +               path_put(path);
> +               return error;
> +       }
> +       error = security_path_notify(path, mask,
> +                               FSNOTIFY_OBJ_TYPE_INODE);
>         if (error)
>                 path_put(path);
> +
>         return error;
>  }
>
> @@ -744,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>         if (mask & IN_ONLYDIR)
>                 flags |= LOOKUP_DIRECTORY;
>
> -       ret = inotify_find_inode(pathname, &path, flags);
> +       ret = inotify_find_inode(pathname, &path, flags, mask);
>         if (ret)
>                 goto fput_and_out;
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 47f58cfb6a19..ead98af9c602 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -339,6 +339,9 @@
>   *     Check for permission to change root directory.
>   *     @path contains the path structure.
>   *     Return 0 if permission is granted.
> + * @path_notify:
> + *     Check permissions before setting a watch on events as defined by @mask,
> + *     on an object at @path, whose type is defined by @obj_type.
>   * @inode_readlink:
>   *     Check the permission to read the symbolic link.
>   *     @dentry contains the dentry structure for the file link.
> @@ -1535,7 +1538,9 @@ union security_list_options {
>         int (*path_chown)(const struct path *path, kuid_t uid, kgid_t gid);
>         int (*path_chroot)(const struct path *path);
>  #endif
> -
> +       /* Needed for inode based security check */
> +       int (*path_notify)(const struct path *path, u64 mask,
> +                               unsigned int obj_type);
>         int (*inode_alloc_security)(struct inode *inode);
>         void (*inode_free_security)(struct inode *inode);
>         int (*inode_init_security)(struct inode *inode, struct inode *dir,
> @@ -1860,6 +1865,8 @@ struct security_hook_heads {
>         struct hlist_head path_chown;
>         struct hlist_head path_chroot;
>  #endif
> +       /* Needed for inode based modules as well */
> +       struct hlist_head path_notify;
>         struct hlist_head inode_alloc_security;
>         struct hlist_head inode_free_security;
>         struct hlist_head inode_init_security;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..7d9c1da1f659 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -259,7 +259,8 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
>                                         struct qstr *name,
>                                         const struct cred *old,
>                                         struct cred *new);
> -
> +int security_path_notify(const struct path *path, u64 mask,
> +                                       unsigned int obj_type);
>  int security_inode_alloc(struct inode *inode);
>  void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
> @@ -387,7 +388,6 @@ int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
>  void security_release_secctx(char *secdata, u32 seclen);
> -
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> @@ -621,6 +621,12 @@ static inline int security_move_mount(const struct path *from_path,
>         return 0;
>  }
>
> +static inline int security_path_notify(const struct path *path, u64 mask,
> +                               unsigned int obj_type)
> +{
> +       return 0;
> +}
> +
>  static inline int security_inode_alloc(struct inode *inode)
>  {
>         return 0;
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..30687e1366b7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -871,6 +871,12 @@ int security_move_mount(const struct path *from_path, const struct path *to_path
>         return call_int_hook(move_mount, 0, from_path, to_path);
>  }
>
> +int security_path_notify(const struct path *path, u64 mask,
> +                               unsigned int obj_type)
> +{
> +       return call_int_hook(path_notify, 0, path, mask, obj_type);
> +}
> +
>  int security_inode_alloc(struct inode *inode)
>  {
>         int rc = lsm_inode_alloc(inode);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..a1aaf79421df 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,8 @@
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>  /* for hashlen_string() */
>  #include <uapi/linux/mount.h>
> +#include <linux/fsnotify.h>
> +#include <linux/fanotify.h>
>
>  #include "avc.h"
>  #include "objsec.h"
> @@ -3261,6 +3263,50 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>         return -EACCES;
>  }
>
> +static int selinux_path_notify(const struct path *path, u64 mask,
> +                                               unsigned int obj_type)
> +{
> +       int ret;
> +       u32 perm;
> +
> +       struct common_audit_data ad;
> +
> +       ad.type = LSM_AUDIT_DATA_PATH;
> +       ad.u.path = *path;
> +
> +       /*
> +        * Set permission needed based on the type of mark being set.
> +        * Performs an additional check for sb watches.
> +        */
> +       switch (obj_type) {
> +       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +               perm = FILE__WATCH_MOUNT;
> +               break;
> +       case FSNOTIFY_OBJ_TYPE_SB:
> +               perm = FILE__WATCH_SB;
> +               ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
> +                                               FILESYSTEM__WATCH, &ad);
> +               if (ret)
> +                       return ret;
> +               break;
> +       case FSNOTIFY_OBJ_TYPE_INODE:
> +               perm = FILE__WATCH;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       // check if the mask is requesting ability to set a blocking watch
> +       if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
> +               perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
> +
> +       // is the mask asking to watch file reads?
> +       if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
> +               perm |= FILE__WATCH_READS; // check that permission as well
> +
> +       return path_has_perm(current_cred(), path, perm);
> +}
> +
>  /*
>   * Copy the inode security context value to the user.
>   *
> @@ -6797,6 +6843,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
>         LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
>         LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
> +       LSM_HOOK_INIT(path_notify, selinux_path_notify),
>
>         LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
>
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 201f7e588a29..32e9b03be3dd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -7,7 +7,8 @@
>
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \
> -    "open", "execmod"
> +       "open", "execmod", "watch", "watch_mount", "watch_sb", \
> +       "watch_with_perm", "watch_reads"
>
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> @@ -60,7 +61,7 @@ struct security_class_mapping secclass_map[] = {
>         { "filesystem",
>           { "mount", "remount", "unmount", "getattr",
>             "relabelfrom", "relabelto", "associate", "quotamod",
> -           "quotaget", NULL } },
> +           "quotaget", "watch", NULL } },
>         { "file",
>           { COMMON_FILE_PERMS,
>             "execute_no_trans", "entrypoint", NULL } },
> --
> 2.21.0
>

-- 
paul moore
www.paul-moore.com
