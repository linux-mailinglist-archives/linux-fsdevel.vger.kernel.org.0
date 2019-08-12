Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58748A1F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfHLPGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 11:06:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38344 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfHLPGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:06:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so74390444lfj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Js+VA7F9tvJG5+BevlMW9BFXe0iGndk5HT03D5ecuXA=;
        b=zelB1XPT4ic3ClpjtoMKpqoAdRcpSTyK1zTD+k6Ol67rjX9SMkk/V6j4Gafr7QmrtG
         U9jr8xZ4MyCaZfSDvesSE4btKzIJSmGTZrFAQ93iiHvDiIn/q0Aa3cHShKPB02iU78Px
         ldhR7emuMQzsbLN/Gre6kuQU8HRJDQhxF8MzSFxJA/V67xB8gAKEgcv78ac/+ZIiqL3x
         QHBBQ1wy8GvLCp6/bjRdBClu7YN2r2ElQb/XjNDVzBklc/HR2bbyK419gui3+zkLCg5y
         8Pt1A9SfABaW/ZzOaAk95SjrKZKWsNTbRvhH3CZb5Gd+DtGVd5ZjZet0E7fw/nKlE9lO
         jf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Js+VA7F9tvJG5+BevlMW9BFXe0iGndk5HT03D5ecuXA=;
        b=MzoM+hmh59c7s9LpLl0XAUtInM6qnpDSUVSlDB+pjJ4v8rmKh/GXW/VRKtos+IPQoK
         QY1CGq8A2DIWlVL+lukkf610Op2re5YFH6DtZwlXp+kD1rxQI3zGWf40oxubQ8/LJh/5
         gcf83oXynHXrPCyc8Fgj+C62d7+edT5R+D+bSiCm1ij5yvgulOOwa5WHeQUu1BEo8Twf
         vSGclmsID+43Cw6aKXxlAmVha9q1PSMtfijkoqr3QizScYplTtaE6cE/PRXSDRLida3E
         AeRhdngafga0h2lAXapMaiPBrOhRkVtBDBB3rfMsrOyREeVHD8bb8KHfRScYg4HYbKT6
         c5PA==
X-Gm-Message-State: APjAAAWDXeRL63KL9E/2RXgMkk7gCsI7wC5YBvJevmjAPTdWia79+IuT
        F++N/IeDTdZN7h8q8ZbYE/Lr6xXkIT9v07dD0uk/
X-Google-Smtp-Source: APXvYqw8wiIUmNCJfabwfJYW5JsUtTuihAsGpOSEYQcYjdD8elsuK+NKNesqdZ2r/V1C+2u2RvR27W8EZqU9nvh1KNo=
X-Received: by 2002:a19:c511:: with SMTP id w17mr9150075lfe.31.1565622392374;
 Mon, 12 Aug 2019 08:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190809181401.7086-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190809181401.7086-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 11:06:21 -0400
Message-ID: <CAHC9VhTXjvUHQsZT9Fd6m=yzdBTDAzf1SpfMxQ_qwjy6zbJZLg@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 9, 2019 at 2:14 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
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
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> v2:
>   - move initialization of obj_type up to remove duplicate work
>   - convert inotify and fanotify flags to common FS_* flags
>  fs/notify/dnotify/dnotify.c         | 15 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 19 ++++++++++--
>  fs/notify/inotify/inotify_user.c    | 14 +++++++--
>  include/linux/lsm_hooks.h           |  9 +++++-
>  include/linux/security.h            | 10 ++++--
>  security/security.c                 |  6 ++++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 113 insertions(+), 12 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f77b314d0575..a47376d1c924 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
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

Sigh.

Remember when I said "Don't respin the patch just for this, but if you
have to do it for some other reason please fix the C++ style
comments."?  In this particular case it is a small thing, but a
failure to incorporate all the feedback is one of the things that
really annoys me (mostly because it makes me worry about other things
that may have been missed).  It isn't as bad as submitting code which
doesn't compile, but it's a close second.

At this point I'm going to ask you to respin the patch to get rid of
those C++ style comments.  I'm also going to get a bit more nitpicky
about those comments too (more comments below).

> +       // check if the mask is requesting ability to set a blocking watch
> +       if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
> +               perm |= FILE__WATCH_WITH_PERM; // if so, check that permission

What is the point of that trailing comment "if so, check that
permission"?  Given the code, and the comment two lines above this
seems obvious, does it not?  If you want to keep it, that's fine with
me, but let's combine the two comments so they read a bit better, for
example:

  /* blocking watches require the file:watch_with_perm permission */
  if (...)
    perm |= FILE__WATCH_WITH_PERM;

> +       // is the mask asking to watch file reads?
> +       if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
> +               perm |= FILE__WATCH_READS; // check that permission as well

Here the "check that permission as well" adds no additional useful
information, it's just noise in the code, drop it from the patch.

I am a believer in the old advice that good comments explain *why* the
code is doing something, where bad comments explain *what* the code is
doing.  I would kindly ask that you keep that in mind when submitting
future SELinux patches.

-- 
paul moore
www.paul-moore.com
