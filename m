Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238B587AA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406889AbfHIM4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 08:56:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43691 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406881AbfHIM4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:56:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so67450333ljk.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2019 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GYDHBnu2owhBbOJJpop+V5q1WYVszbrimN26QGfiMo=;
        b=dyc5sUichRyst3ZCHhgOGHvOmsRTdfn9Tt4iomf8s+IX5vZlxgcXqRBkgQMJYFbtlU
         HCW9p8yciAV1HI8uqfPZ9Xqhj5mFIhaNlZvpcxVZbPuPJlJ7elZMPI40dzZci7gvgRPh
         H52DkEazRiT8jNDJMJP2WUHlCipC9mJE//tpdEpY7z1IWrS3dkzJJFRbt2s2DYgKD2uS
         YNRksOumEll9RkqliWOe6ISlAmEfyZvZTqUNgfkyxX0RicGnX2jS+K5LJ+ol3aaGE8iD
         Q+wPF25HJnIAfwJJaWFCTEtQ0+oQIUPpZdRq/dzLP+tbMchmx7tITcxeSAPKLFLnIsdJ
         08Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GYDHBnu2owhBbOJJpop+V5q1WYVszbrimN26QGfiMo=;
        b=Umbs/kOtga99kiiIV3hbCvC4xQ3DZZJ6mOef8pKRTpQkFyFax1qX99pMFVdzm1BrfF
         GGDwngoEcapY/xkaUjqKIb+80C8ZPF7c6EEEE328VHi7jRuZYQWWNaoo8xj+pZs1Fu4i
         PH3FlwUik/5jQC1V5jAukIYYH/fqeQzoybuQXN+IwkDyih32zCw6nTH9rP0Ph53s6oIi
         OlLtNYMiLtoHMlibbKt1hci9/6sIbJJgAwHGdBlTxtNzeO72gUUXMBl/N1ZKi39Y2K5U
         +2gB2kvKApLb3p9Jgzi2Z8JpZG0hm/GeRCyQUmPQnmz/wz5XQsubx6y3BPBfPUJzATPB
         VTsQ==
X-Gm-Message-State: APjAAAWvp13IQXSdsKwgh7ftXol1MHNaCYSNg/0UHteIjRDbAhHMD5RO
        +SMzLI98LERz23j2YmyRzA1VISYz5SHLRFmPor7s
X-Google-Smtp-Source: APXvYqzGrCnMF8pN1zPKQv9mU3c03EWmJQDGf543U3rR+j33Fr8g7LHtCKLWHEN7nUTieqSoYM7R4ZcVjqgH1caEpqA=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr11249146lja.85.1565355368966;
 Fri, 09 Aug 2019 05:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Aug 2019 08:55:57 -0400
Message-ID: <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
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

On Fri, Aug 9, 2019 at 5:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Aug 8, 2019 at 9:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jul 31, 2019 at 11:35 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> > > As of now, setting watches on filesystem objects has, at most, applied a
> > > check for read access to the inode, and in the case of fanotify, requires
> > > CAP_SYS_ADMIN. No specific security hook or permission check has been
> > > provided to control the setting of watches. Using any of inotify, dnotify,
> > > or fanotify, it is possible to observe, not only write-like operations, but
> > > even read access to a file. Modeling the watch as being merely a read from
> > > the file is insufficient for the needs of SELinux. This is due to the fact
> > > that read access should not necessarily imply access to information about
> > > when another process reads from a file. Furthermore, fanotify watches grant
> > > more power to an application in the form of permission events. While
> > > notification events are solely, unidirectional (i.e. they only pass
> > > information to the receiving application), permission events are blocking.
> > > Permission events make a request to the receiving application which will
> > > then reply with a decision as to whether or not that action may be
> > > completed. This causes the issue of the watching application having the
> > > ability to exercise control over the triggering process. Without drawing a
> > > distinction within the permission check, the ability to read would imply
> > > the greater ability to control an application. Additionally, mount and
> > > superblock watches apply to all files within the same mount or superblock.
> > > Read access to one file should not necessarily imply the ability to watch
> > > all files accessed within a given mount or superblock.
> > >
> > > In order to solve these issues, a new LSM hook is implemented and has been
> > > placed within the system calls for marking filesystem objects with inotify,
> > > fanotify, and dnotify watches. These calls to the hook are placed at the
> > > point at which the target path has been resolved and are provided with the
> > > path struct, the mask of requested notification events, and the type of
> > > object on which the mark is being set (inode, superblock, or mount). The
> > > mask and obj_type have already been translated into common FS_* values
> > > shared by the entirety of the fs notification infrastructure. The path
> > > struct is passed rather than just the inode so that the mount is available,
> > > particularly for mount watches. This also allows for use of the hook by
> > > pathname-based security modules. However, since the hook is intended for
> > > use even by inode based security modules, it is not placed under the
> > > CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
> > > modules would need to enable all of the path hooks, even though they do not
> > > use any of them.
> > >
> > > This only provides a hook at the point of setting a watch, and presumes
> > > that permission to set a particular watch implies the ability to receive
> > > all notification about that object which match the mask. This is all that
> > > is required for SELinux. If other security modules require additional hooks
> > > or infrastructure to control delivery of notification, these can be added
> > > by them. It does not make sense for us to propose hooks for which we have
> > > no implementation. The understanding that all notifications received by the
> > > requesting application are all strictly of a type for which the application
> > > has been granted permission shows that this implementation is sufficient in
> > > its coverage.
> > >
> > > Security modules wishing to provide complete control over fanotify must
> > > also implement a security_file_open hook that validates that the access
> > > requested by the watching application is authorized. Fanotify has the issue
> > > that it returns a file descriptor with the file mode specified during
> > > fanotify_init() to the watching process on event. This is already covered
> > > by the LSM security_file_open hook if the security module implements
> > > checking of the requested file mode there. Otherwise, a watching process
> > > can obtain escalated access to a file for which it has not been authorized.
> > >
> > > The selinux_path_notify hook implementation works by adding five new file
> > > permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> > > (descriptions about which will follow), and one new filesystem permission:
> > > watch (which is applied to superblock checks). The hook then decides which
> > > subset of these permissions must be held by the requesting application
> > > based on the contents of the provided mask and the obj_type. The
> > > selinux_file_open hook already checks the requested file mode and therefore
> > > ensures that a watching process cannot escalate its access through
> > > fanotify.
> > >
> > > The watch, watch_mount, and watch_sb permissions are the baseline
> > > permissions for setting a watch on an object and each are a requirement for
> > > any watch to be set on a file, mount, or superblock respectively. It should
> > > be noted that having either of the other two permissions (watch_reads and
> > > watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> > > permission. Superblock watches further require the filesystem watch
> > > permission to the superblock. As there is no labeled object in view for
> > > mounts, there is no specific check for mount watches beyond watch_mount to
> > > the inode. Such a check could be added in the future, if a suitable labeled
> > > object existed representing the mount.
> > >
> > > The watch_reads permission is required to receive notifications from
> > > read-exclusive events on filesystem objects. These events include accessing
> > > a file for the purpose of reading and closing a file which has been opened
> > > read-only. This distinction has been drawn in order to provide a direct
> > > indication in the policy for this otherwise not obvious capability. Read
> > > access to a file should not necessarily imply the ability to observe read
> > > events on a file.
> > >
> > > Finally, watch_with_perm only applies to fanotify masks since it is the
> > > only way to set a mask which allows for the blocking, permission event.
> > > This permission is needed for any watch which is of this type. Though
> > > fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
> > > trust to root, which we do not do, and does not support least privilege.
> > >
> > > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > > ---
> > >  fs/notify/dnotify/dnotify.c         | 15 +++++++--
> > >  fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
> > >  fs/notify/inotify/inotify_user.c    | 13 ++++++--
> > >  include/linux/lsm_hooks.h           |  9 +++++-
> > >  include/linux/security.h            | 10 ++++--
> > >  security/security.c                 |  6 ++++
> > >  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
> > >  security/selinux/include/classmap.h |  5 +--
> > >  8 files changed, 120 insertions(+), 12 deletions(-)
> >
> > Other than Casey's comments, and ACK, I'm not seeing much commentary
> > on this patch so FS and LSM folks consider this your last chance - if
> > I don't hear any objections by the end of this week I'll plan on
> > merging this into selinux/next next week.
>
> Please consider it is summer time so people may be on vacation like I was...

This is one of the reasons why I was speaking to the mailing list and
not a particular individual :)

> First a suggestion, take it or leave it.
> The name of the hook _notify() seems misleading to me.
> naming the hook security_path_watch() seems much more
> appropriate and matching the name of the constants FILE__WATCH
> used by selinux.

I guess I'm not too bothered by either name, Aaron?  FWIW, if I was
writing this hook, I would probably name it
security_fsnotify_path(...).

-- 
paul moore
www.paul-moore.com
