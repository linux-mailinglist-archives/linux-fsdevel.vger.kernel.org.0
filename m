Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CE73456FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 05:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCWEvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 00:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCWEu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 00:50:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CBC061574;
        Mon, 22 Mar 2021 21:50:55 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d10so10217240ils.5;
        Mon, 22 Mar 2021 21:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bZy/09bVtTe50yphuLd9VM5OVNCJtBTaXJNW821aO8=;
        b=jhe4eWgYYa6pPg1tWfJqkkw8+JAcI3zlpU/8Uc4zvu1pi+Pp4xulBAEq+lmTsaFIw0
         +tMNHHFQjyvktv/5A1SS7j5crAckhZthbdjxsBpSknfG9pOPjP6vDSX3VQx2nrU5suDr
         Cu8eLPbParOQxhdb00c7wuefkRPaz1MXgVG4f8oJbnSFGsLMOf9jqck20X5NCzZ7Bxcn
         VJreJYQDSc7BWafLE1uWNkXGRr3/oanbtsVh0ZrYAM1I5qVyQVu41LO00Ns+Zzo0wPu1
         bZ+w0n+MU7qWnGT6Yu0GpRoNUxSMEueh6YPV23BF+4yvJWh+sMVXlaJq3cglqc3jRS6d
         MUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bZy/09bVtTe50yphuLd9VM5OVNCJtBTaXJNW821aO8=;
        b=TqrsHKpN5bnezj5l2E3nLwtY7jqoseX7mFaMZ8bky0u/f9Y6SAdtB6uf7w9BgzJ0hx
         kcFQZG4houSeLND3PPtLDzfAs16049bS8RrJNUMsfgCXoVeT4SUjDy81iiuS0IcuQ0cW
         YUjlZdsk1MW4JpThBbyYqBCX8xiqL7xEko5PY62RR+ktY5w5cbenn5zTMa0TGQvT6JkY
         6svmaQPDumXMuQ2cQIGFvS/Kf9hgg9bIKH3niDjnbxMEcQdH6D4PLew/w3cCHCBpO2iR
         l4WfBZwNa7rXC5n3r7lMqNEFdcHzJaaKZBbGB0vVvD5iC/0HlE57ynZbEKQlVtHbtO7w
         N4qg==
X-Gm-Message-State: AOAM531l+aYVlgXTZfodW3F4elBylD+Iid8fw9Yg+CjLdUxJjsEKO+X0
        nmXkCD2qhdKT9pccxeCiHaw7lVmXFeQZC7k6ZLh/EcMl57Y=
X-Google-Smtp-Source: ABdhPJxNYq8xk+VFFJuzprgcg8V1aewJHiJGEuBZddllEAumilMNCQTHq4qSjUTEqfi4aZrMMdhtz7fkyXH/y9LPH2Y=
X-Received: by 2002:a05:6e02:b2a:: with SMTP id e10mr3263029ilu.9.1616475055194;
 Mon, 22 Mar 2021 21:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
In-Reply-To: <20210322230352.GW63242@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Mar 2021 06:50:44 +0200
Message-ID: <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Mar 22, 2021 at 07:11:18PM +0200, Amir Goldstein wrote:
> > Some filesystems on persistent storage backend use a digest of the
> > filesystem's persistent uuid as the value for f_fsid returned by
> > statfs(2).
> >
> > xfs, as many other filesystem provide the non-persistent block device
> > number as the value of f_fsid.
> >
> > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > for identifying objects using file_handle and f_fsid in events.
>
> The filesystem id is encoded into the VFS filehandle - it does not
> need some special external identifier to identify the filesystem it
> belongs to....
>

Let's take it from the start.
There is no requirement for fanotify to get a persistent fs id, we just need
a unique fs id that is known to userspace, so the statfs API is good enough
for our needs.

See quote from fanotify.7:

" The fields of the fanotify_event_info_fid structure are as follows:
...
       fsid   This  is  a  unique identifier of the filesystem
containing the object associated with the event.  It is a structure of
type __kernel_fsid_t and contains the same value as f_fsid when
              calling statfs(2).

       file_handle
              This is a variable length structure of type struct
file_handle.  It is an opaque handle that corresponds to a specified
object on a filesystem as returned by name_to_handle_at(2).  It
              can  be  used  to uniquely identify a file on a
filesystem and can be passed as an argument to open_by_handle_at(2).
..."

So the main objective is to "uniquely identify an object" which was observed
before (i.e. at the time of setting a watch) and a secondary objective is to
resolve a path from the identifier, which requires extra privileges.

This definition does not specify the lifetime of the identifier and
indeed, in most
cases, uniqueness in the system while filesystem is mounted should suffice
as that is also the lifetime of the fanotify mark.

But the fanotify group can outlive the mounted filesystem and it can be used
to watch multiple filesystems. It's not really a problem per-se that
xfs filesystems
can change and reuse f_fsid, it is just less friendly that's all.

I am trying to understand your objection to making this "friendly" change.

> > The xfs specific ioctl XFS_IOC_PATH_TO_FSHANDLE similarly attaches an
> > fsid to exported file handles, but it is not the same fsid exported
> > via statfs(2) - it is a persistent fsid based on the filesystem's uuid.
>
> To actually use that {fshandle,fhandle} tuple for anything
> requires CAP_SYS_ADMIN. A user can read the fshandle, but it can't
> use it for anything useful.

It is a unique identifier and that is a useful thing - see demo code:
* Index watches by fanotify fid:
  https://github.com/amir73il/inotify-tools/commit/ed82098b54b847e3c2d46b32d35b2aa537a9ba94
* Handle global watches on several filesystems:
  https://github.com/amir73il/inotify-tools/commit/1188ef00dc84964de58afb32c91e19930ad1e2e8

> i.e. it's use is entirely isolated to
> the file handle interface for identifying the filesystem the handle
> belongs to. This is messy, but XFS inherited this "fixed fsid"
> interface from Irix filehandles and was needed to port
> xfsdump/xfsrestore to Linux.  Realistically, it is not functionality
> that should be duplicated/exposed more widely on Linux...
>

Other filesystems expose a uuid digest as f_fsid: ext4, btrfs, ocfs2
and many more. XFS is really the exception among the big local fs.
This is not exposing anything new at all.
I would say it is more similar to the way that the generation part of
the file handle has improved over the years in different filesystems
to provide better uniqueness guarantees.

> IMO, if fanotify needs a persistent filesystem ID on Linux, it

It does not *need* that. It's just nicer for f_fsid to use a persistent
fs identifier if one is anyway available.

> should be using something common across all filesystems from the
> linux superblock, not deep dark internal filesystem magic. The
> export interfaces that generate VFS (and NFS) filehandles already
> have a persistent fsid associated with them, which may in fact be
> the filesystem UUID in it's entirety.
>

Yes, nfsd is using dark internal and AFAIK undocumnetd magic to
pick that identifier (Bruce, am I wrong?).

> The export-derived "filesystem ID" is what should be exported to
> userspace in combination with the file handle to identify the fs the
> handle belongs to because then you have consistent behaviour and a
> change that invalidates the filehandle will also invalidate the
> fshandle....
>

nfsd has a much stronger persistent file handles requirement than
fanotify. There is no need to make things more complicated than
they need to be.

> > Use the same persistent value for f_fsid, so object identifiers in
> > fanotify events will describe the objects more uniquely.
>
> It's not persistent as in "will never change". The moment a user
> changes the XFS filesystem uuid, the f_fsid changes.
>

Yes. I know. But it's still much better than the bdev number IMO.

> However, changing the uuid on XFS is an offline (unmounted)
> operation, so there will be no fanotify marks present when it is
> changed. Hence when it is remounted, there will be a new f_fsid
> returned in statvfs(), just like what happens now, and all
> applications dependent on "persistent" fsids (and persistent
> filehandles for that matter) will now get ESTALE errors...
>
> And, worse, mp->m_fixed_fsid (and XFS superblock UUIDs in general)
> are not unique if you've got snapshots and they've been mounted via
> "-o nouuid" to avoid XFS's duplicate uuid checking. This is one of
> the reasons that the duplicate checking exists - so that fshandles
> are unique and resolve to a single filesystem....
>

Both of the caveats of uuid you mentioned are not a big concern for
fanotify because the nature of f_fsid can be understood by the event
listener before setting the multi-fs watch (i.e. in case of fsid collision).

> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Guys,
> >
> > This change would be useful for fanotify users.
> > Do you see any problems with that minor change of uapi?
>
> Yes.
>
> IMO, we shouldn't be making a syscall interface rely on the
> undefined, filesystem specific behaviour a value some other syscall
> exposes to userspace. This means the fsid has no defined or
> standardised behaviour applications can rely on and can't be
> guaranteed unique and unchanging by fanotify. This seems like a
> lose-lose situation for everyone...
>

The fanotify uapi guarantee is to provide the same value of f_fsid
observed by statfs() uapi. The statfs() uapi guarantee about f_fsid is
a bit vague, but it's good enough for our needs:

"...The  general idea is that f_fsid contains some random stuff such that the
 pair (f_fsid,ino) uniquely determines a file.  Some operating systems use
 (a variation on) the device number, or the device number combined with the
 filesystem type..."

Regardless of the fanotify uapi and whether it's good or bad, do you insist
that the value of f_fsid exposed by xfs needs to be the bdev number and
not derived from uuid?

One thing we could do is in the "-o nouuid" case that you mentioned
we continue to use the bdev number for f_fsid.
Would you like me to make that change?

Thanks,
Amir.
