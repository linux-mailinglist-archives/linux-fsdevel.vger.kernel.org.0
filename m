Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5E648B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfGJOzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 10:55:24 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44660 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGJOzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:55:24 -0400
Received: by mail-yb1-f196.google.com with SMTP id a14so835731ybm.11;
        Wed, 10 Jul 2019 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCiTMtxWZLPJb5y6myKW6/LqRAFmEt/hmzQDDMTW8VI=;
        b=lEAScme2mzOQ+tU9R4si7PoXLwO6ANudoejGNvbvXY7MTia3jsDqXVK2sT7T4ezaA8
         ZC4iXV3mp74Kk/A5sykoJYHMeB7eC9DYwai4hnX303CgGyj/Et2Ard1470VsuyZmEq/Q
         Zrsjy/wNgl+wh/8Qa6Bvo92PqPEBBv4YzpXEHI+PRSQIT67cEGiWBA9o5HCZHpOPoKt0
         GSIWFuXGblzSC+AcGxl/L1itQekXjckZxhNhibF3a6SHfKqVX96KeE3BwGm9mos3w+Gg
         MtgEQDmPLzOv9/H64lLCIm/8VGZDhLyQzhq4IZ5azGRZUwNd6yPl+Vxnms0+Hd8bOeLt
         WjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCiTMtxWZLPJb5y6myKW6/LqRAFmEt/hmzQDDMTW8VI=;
        b=MmAazY1m+v3Yh2ZliV8OeyZ5FvlJ5kwQcQyj9Tz2kmHLf7PyK1OSi+4Za0+BTFN3aY
         GCKwAQ2q8mYbNrpyFWFIkaPt52h9ZLECQs71SoAQ+aKE2gSgoPIxdrsGfoLvrDJp766v
         sKYgBIiUKbIDxoi21akkwXR/ZYQ/UyPrNwoJpLfH6Hox3VMtNlUEWRfZJZEMinJ0x6ZH
         c9dUCWZy/o5SViXU3Ln97q5OvwhX3htWGWe4D1PbAHSx9QczIboXE0YXCZxswzsDyDYk
         tx7m99WbkWoYSVhOpYtPFaXlu+gHrFumM6ajJiN9PYjYDRNSOhGKWvGZTIfOtB/CBaMf
         fxVg==
X-Gm-Message-State: APjAAAUXzfrFCN5lpkMkO5D3nnwGQPH0DgbhnEVOOICblEQLbmrie2ZV
        Q5/HhzIDmAlP8dX06Oq8TS6mME1HntziRPhS8YhsCA==
X-Google-Smtp-Source: APXvYqy2ZYzPT4Hl6P3dw3H30HQZL3QHerrdT5q0XUMb6fhSaBXk0zgxuJcflF5qEH5p0TTt0jJmcKFd2E8H1UmCPlI=
X-Received: by 2002:a25:aaea:: with SMTP id t97mr16794751ybi.126.1562770522978;
 Wed, 10 Jul 2019 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190710133403.855-1-acgoide@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 10 Jul 2019 17:55:11 +0300
Message-ID: <CAOQ4uxhKP9AUHqYN24ELP5OcyaJQcpS9hdzuZOm5uJpokFAXvg@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
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

On Wed, Jul 10, 2019 at 4:34 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>
> As of now, setting watches on filesystem objects has, at most, applied a
> check for read access to the inode, and in the case of fanotify, requires
> CAP_SYS_ADMIN. No specific security hook or permission check has been
> provided to control the setting of watches. Using any of inotify, dnotify,
> or fanotify, it is possible to observe, not only write-like operations, but
> even read access to a file. Modeling the watch as being merely a read from
> the file is insufficient. Furthermore, fanotify watches grant more power to
> an application in the form of permission events. While notification events
> are solely, unidirectional (i.e. they only pass information to the
> receiving application), permission events are blocking. Permission events
> make a request to the receiving application which will then reply with a
> decision as to whether or not that action may be completed.
>
> In order to solve these issues, a new LSM hook is implemented and has been
> placed within the system calls for marking filesystem objects with inotify,
> fanotify, and dnotify watches. These calls to the hook are placed at the
> point at which the target inode has been resolved and are provided with
> both the inode and the mask of requested notification events. The mask has
> already been translated into common FS_* values shared by the entirety of
> the fs notification infrastructure.
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
> Fanotify further has the issue that it returns a file descriptor with the
> file mode specified during fanotify_init() to the watching process on
> event. This is already covered by the LSM security_file_open hook if the
> security module implements checking of the requested file mode there.
>
> The selinux_inode_notify hook implementation works by adding three new
> file permissions: watch, watch_reads, and watch_with_perm (descriptions
> about which will follow). The hook then decides which subset of these
> permissions must be held by the requesting application based on the
> contents of the provided mask. The selinux_file_open hook already checks
> the requested file mode and therefore ensures that a watching process
> cannot escalate its access through fanotify.
>
> The watch permission is the baseline permission for setting a watch on an
> object and is a requirement for any watch to be set whatsoever. It should
> be noted that having either of the other two permissions (watch_reads and
> watch_with_perm) does not imply the watch permission, though this could be
> changed if need be.
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
>  fs/notify/dnotify/dnotify.c         | 14 +++++++++++---
>  fs/notify/fanotify/fanotify_user.c  | 11 +++++++++--
>  fs/notify/inotify/inotify_user.c    | 12 ++++++++++--
>  include/linux/lsm_hooks.h           |  2 ++
>  include/linux/security.h            |  7 +++++++
>  security/security.c                 |  5 +++++
>  security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  8 files changed, 67 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..e91ce092efb1 100644
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
> +       error = security_inode_notify(inode, mask);
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
> index a90bb19dcfa2..c0d9fa998377 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops = {
>  };
>
>  static int fanotify_find_path(int dfd, const char __user *filename,
> -                             struct path *path, unsigned int flags)
> +                             struct path *path, unsigned int flags, __u64 mask)
>  {
>         int ret;
>
> @@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>
>         /* you can only watch an inode if you have read permissions on it */
>         ret = inode_permission(path->dentry->d_inode, MAY_READ);
> +       if (ret) {
> +               path_put(path);
> +               goto out;
> +       }
> +
> +       ret = security_inode_notify(path->dentry->d_inode, mask);
>         if (ret)
>                 path_put(path);
> +
>  out:
>         return ret;
>  }
> @@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 goto fput_and_out;
>         }
>
> -       ret = fanotify_find_path(dfd, pathname, &path, flags);
> +       ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>         if (ret)
>                 goto fput_and_out;
>

So the mark_type doesn't matter to SELinux?
You have no need for mount_noitify and sb_notify hooks?
A watch permission on the mount/sb root inode implies permission
(as CAP_SYS_ADMIN) to watch all events in mount/sb?

[...]

> +static int selinux_inode_notify(struct inode *inode, u64 mask)
> +{
> +       u32 perm = FILE__WATCH; // basic permission, can a watch be set?
> +
> +       struct common_audit_data ad;
> +
> +       ad.type = LSM_AUDIT_DATA_INODE;
> +       ad.u.inode = inode;
> +
> +       // check if the mask is requesting ability to set a blocking watch
> +       if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS_ACCESS_PERM))

Better ALL_FSNOTIFY_PERM_EVENTS

Thanks,
Amir.
