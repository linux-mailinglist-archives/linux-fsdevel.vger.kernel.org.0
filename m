Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A696D1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGRQQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 12:16:48 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36961 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRQQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:16:48 -0400
Received: by mail-yb1-f194.google.com with SMTP id i1so4092766ybo.4;
        Thu, 18 Jul 2019 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nbGB0CS7rHU/Yrn4yydw9PUAf2OJmqGyHfl386Psog=;
        b=nH6c8/2h0037KctmqSNeJplo7NYPgr3pIDVt0m3ztg0v/B5YnUrW2Op4YGTRurfYEP
         yZWsRlOwo6BJoOSGo3XvR5guwOi2pacK15GhNkYyW3GZMZNzaRSrbvSuY8lXq+SEpnkL
         HCheaLm80lp27tx6v4ARJGXQIDqIupeZsATytBvgJ2AKNrpfaq0yOVM8yRzrtFjmUGWu
         t/teLDnhG85dWLQ3z78elc6R3Ye/1BSZ//qMgPSlAbsGyJxFwgwjY2x1n0mwPNKT7Het
         DY44rYPR0DyCFBGZV0cQ4E5E2ZIQpJ0nVWpXpE2bHu5Yu1T/CT+dzjc1dyZb6qb/5h1m
         +LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nbGB0CS7rHU/Yrn4yydw9PUAf2OJmqGyHfl386Psog=;
        b=jAiCGItR+UC7TMICKROh7IxNXcTh2cM43tsyzmYstldRhwbJNFxVlF9pSe38UA2wEa
         NuK+xKr66vIIYyzf8jE64OPmFDPBp0njCeK7Cb3LsdFlhaQXGH9dk2A4d2u34e4KMo9B
         Z3UmWf7CY3Wf2/TQ3+hQIG7sdgQ24iXM/eM3tBeO5p3J+Fs/JBbhb00ykXxMGlN5aune
         JNgyvIbyRpp6mvz2LX3ZmrMObYB2rKikaTAO4S3UGZdAAwusf7QRdEXBPmY6cru8w+t6
         MyGoqQpEcoNk8btJmgFPDbMYtSeErJ219S96KHlpJ3FAMLz/9qdxBWbNGtWqyHnm+TzL
         XKng==
X-Gm-Message-State: APjAAAXmGuVE4KagXLpkbj9/KALex6F1jAvR9rV3Z8qHOZpptHY7jHv5
        6ghPmoSqkvZ3yn7j4Zu6TQ5t8s7/mWFaz0WwMmc=
X-Google-Smtp-Source: APXvYqysdEX+yVxrGHfbsT4yZRAftkhvOpYg3c0XdXvemT0CISa3VHGt/FAt1LGbQGgUVw/5XTer3C4/lcb4VnZmeVc=
X-Received: by 2002:a25:c486:: with SMTP id u128mr29541180ybf.428.1563466606662;
 Thu, 18 Jul 2019 09:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Jul 2019 19:16:35 +0300
Message-ID: <CAOQ4uxjCR76nbV_Lmoegaq6NqovWZD-XWEVS-X3e=BtDdjKkXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 5:31 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>
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
> point at which the target inode has been resolved and are provided with the
> inode, the mask of requested notification events, and the type of object on
> which the mark is being set (inode, superblock, or mount). The mask and
> mark_type have already been translated into common FS_* values shared by
> the entirety of the fs notification infrastructure.
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
> The selinux_inode_notify hook implementation works by adding five new file
> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> (descriptions about which will follow), and one new filesystem permission:
> watch (which is applied to superblock checks). The hook then decides which
> subset of these permissions must be held by the requesting application
> based on the contents of the provided mask and the mark_type. The
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
> v2:
>   - Adds support for mark_type
>     - Adds watch_sb and watch_mount file permissions
>     - Adds watch as new filesystem permission
>     - LSM hook now recieves mark_type argument
>     - Changed LSM hook logic to implement checks for corresponding mark_types
>   - Adds missing hook description comment
>   - Fixes extrainous whitespace
>   - Updates patch description based on feedback
>
>  fs/notify/dnotify/dnotify.c         | 14 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>  fs/notify/inotify/inotify_user.c    | 13 ++++++--
>  include/linux/lsm_hooks.h           |  6 ++++
>  include/linux/security.h            |  9 +++++-
>  security/security.c                 |  5 +++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 116 insertions(+), 10 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..4690d8a66035 100644
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
> @@ -288,6 +289,16 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>                 goto out_err;
>         }
>
> +       /*
> +        * convert the userspace DN_* "arg" to the internal FS_*
> +        * defined in fsnotify
> +        */
> +       mask = convert_arg(arg);
> +
> +       error = security_inode_notify(inode, mask, FSNOTIFY_OBJ_TYPE_INODE);
> +       if (error)
> +               goto out_err;
> +
>         /* expect most fcntl to add new rather than augment old */
>         dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>         if (!dn) {
> @@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
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
> index a90bb19dcfa2..9e3137badb6b 100644
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
> +       unsigned int mark_type;
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
> +               mark_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> +               break;
> +       case FAN_MARK_FILESYSTEM:
> +               mark_type = FSNOTIFY_OBJ_TYPE_SB;
> +               break;
> +       case FAN_MARK_INODE:
> +               mark_type = FSNOTIFY_OBJ_TYPE_INODE;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       ret = security_inode_notify(path->dentry->d_inode, mask, mark_type);

If you prefer 3 hooks security_{inode,mount,sb}_notify()
please place them in fanotify_add_{inode,mount,sb}_mark().

If you prefer single hook with path argument, please pass path
down to fanotify_add_mark() and call security_path_notify() from there,
where you already have the object type argument.

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
> index 7b53598c8804..73b321a30bbc 100644
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
> +       error = security_inode_notify(path->dentry->d_inode, mask,
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
> index 47f58cfb6a19..9b3f5a5f3246 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -394,6 +394,9 @@
>   *     Check permission before removing the extended attribute
>   *     identified by @name for @dentry.
>   *     Return 0 if permission is granted.
> + * @inode_notify:
> + *     Check permissions before setting a watch on events as defined by @mask,
> + *     on an object @inode, whose type is defined by @mark_type.

This is misleading IMO.
First of all "mark_type" is already use to describe the FAN_MARK_XXX flag
value, so please choose another name. object_type if you wish.
Secondly, it does not make sense to pass an inode object when enforcing
a mount mark, because there is no reference from inode to mount.
You should either pass in @path argument to the hook or have different
hooks for different object types.

What about adding watches by kernel/audit_fsnotify.c?
Do LSMs police other LSMs???

Thanks,
Amir.
