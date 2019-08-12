Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC78AA20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 00:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHLWEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 18:04:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35910 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfHLWEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:04:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so21301963lfp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0Z17ppWLL4n1GB6wiiHS5duSRi0ZG/2i5oK1/nFtDI=;
        b=JpXZDChc8Io1Ofe98GO2vIXYGFHSdLztgOlANhWXT2ZPC/wTqEY+9Sm3jSgwteJe3k
         4ztNbBgKLqSNduRmg3AZrTJ0fVoNoPn/ct6mr/0LysEdFz29fSbLbGCIc9g2suCECKGF
         bPz4iBJsm4GXG7aW2hNSDXGzbMJ8fo7OsWOhbEutgkMB5HGdJvcRErop+0q5srrewsG5
         GNArPd0eMhQAvXKAEOUatnTfkqapawdEQmWMobL0DUG1gbwFyVdUd9N//QnOJIpZRN8p
         zLJNLOifwMDERbToNFUQ+usXLlvU0ZIFlUxqXiTVNQD0GJhDsTqs+VW13lNw7PrIuCpC
         T3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0Z17ppWLL4n1GB6wiiHS5duSRi0ZG/2i5oK1/nFtDI=;
        b=rLwZvnz+L0htxYzMMLjo4DD/Wb+DnpqLX6fC5hGPAz5NoCy3/vK9IApOQcJNNRgyc0
         zGDGjNALU0EPNmDp6sor0luoV+NOk+GuXTJJsjmC4Pby/Ac7OZJH77JuoDqcxnjozR8t
         eaoPW+aZWhBN6pti3nph++dXlHkrvywqjKQRuHfTkuE7urEJ1FyzTOW7OB45iHImGurE
         UTvaYVBOyZ4qWmjUAnamG/sJet5krYckf5Lbe47mnE/bfUMR5bykOKIyxsjiaGTXN9yL
         KmfHrWJ4bAbY/5LI/G77rU7hlUfk2HQ898h+KXnzIFf2PxUw/Tg4ALYYParkysVWh25N
         WmlA==
X-Gm-Message-State: APjAAAVIrCUVk1Romojim4HN2RJ1EHgyWk0LUCPiyImphEdO34D4jFgc
        S3nqj2qJqgbM4YdSqyQvUMbmbibhxF9QA8xPO1RJ
X-Google-Smtp-Source: APXvYqzHVFIpiZj5TDqXqB7VtO7B7a8OmuD6etx3tF9XL3ZH+sKwKCEGSlcK8SadZOQ62zlbUoaZAmo18jcs2qXMh7U=
X-Received: by 2002:a19:5e10:: with SMTP id s16mr20448721lfb.13.1565647490303;
 Mon, 12 Aug 2019 15:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190812152000.18050-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190812152000.18050-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 18:04:39 -0400
Message-ID: <CAHC9VhRTBiDNCCDOkqHxyfoNskiCNrJBJGr767Ur0yuEaBjKbg@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:20 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
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
> Acked-by: Jan Kara <jack@suse.cz>
> ---
> v3:
>   - fixed comment style in security hook
>
> v2:
>   - move initialization of obj_type up to remove duplicate work
>   - convert inotify and fanotify flags to common FS_* flags
> ---
>  fs/notify/dnotify/dnotify.c         | 15 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 19 ++++++++++--
>  fs/notify/inotify/inotify_user.c    | 14 +++++++--
>  include/linux/lsm_hooks.h           |  9 +++++-
>  include/linux/security.h            | 10 ++++--
>  security/security.c                 |  6 ++++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 113 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks everyone!

-- 
paul moore
www.paul-moore.com
