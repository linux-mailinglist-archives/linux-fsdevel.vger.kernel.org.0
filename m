Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1892C3457EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 07:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCWGpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCWGot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:44:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF8EC061574;
        Mon, 22 Mar 2021 23:44:48 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c17so17190023ilj.7;
        Mon, 22 Mar 2021 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGJpq5DIESOrz5VgAc4RwOm2dSS4UQKJ9VSaMqtykXU=;
        b=Z3OeJ0Li/khXg6Ob9OXwdl6Wt1u4zgUffuh9i9aTqjmyDd0SqPz/0RVWy+STQ+dTyz
         v4a4EoEwCvU3fKtNmMr1f7cFZm5oVAs476QQLsB5nIpO9v/drOWNwRshPLXHIiHKwTFx
         EoedErQVTIvTeAk1tJMU1LOl+xiXJcEAq0jCPNS0fiTonO00Dq6LqK6WGHNgnJKzgowR
         mFB25VJFhEjrf6ljrfqECskBqnf61VMNRBiSap7jaJpZ5jgtkfNFYVu6nH/0kOz87ya3
         KuTYyoJhl087LrYs81Ew+z/p0xxJBrwYYad6g9mRGVCerRsPPZU7pU8AjZSvpSvs9bJp
         dXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGJpq5DIESOrz5VgAc4RwOm2dSS4UQKJ9VSaMqtykXU=;
        b=ixbLr4+EHQFWYGYv2rMbv2fzkFoArD5zIWt4Ds6JkGkR/W8Owv1dWyOiOicq41Z0Kd
         D8kHrXmSg+KnXbCb6TnpTYQ294eAreRqioEBVwtQ5gRUMLiv5kJXDpiKrkRBpGBYGrSx
         dKVpcTOmzIL7rXjHOIRFsM8bfJJfd3l90DsUiJfG+GHGqv/dRzcM6UqSQ+E+CT5A0F9S
         Ef1QqEFOiXqRoCE/cntWLoDdWMF5Uo3mnv5Xp3gtfvr1vxKjd53mwzCSZMquY/paF5DD
         UUmK0oxwozGoBomatVR1Kt6JeT56fka+ZUaKGhkgnhhgCxiDyCRbt0qgduJA5XfWq5Th
         pqZA==
X-Gm-Message-State: AOAM532O3eGpAX8e1DDMxQElnHGpBQhER7CcUmtKsA1+kcM02DwJPTtK
        eFfLoP/uLdtEV1xkm9e29RbkRgeBPEJ5YxIrNCA=
X-Google-Smtp-Source: ABdhPJzARFYumAsWnQw0xWxVnBZAoK1OQkhtwDoBuERQFxkGGaqTPD0VeoIrvBqIvxWcSuMufMbrLP87kFNHytErdk8=
X-Received: by 2002:a92:da90:: with SMTP id u16mr3530849iln.275.1616481887821;
 Mon, 22 Mar 2021 23:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com> <20210323063509.GJ22100@magnolia>
In-Reply-To: <20210323063509.GJ22100@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Mar 2021 08:44:36 +0200
Message-ID: <CAOQ4uxjfXZdt++_yUepkEzW6kbDmXwBNBWS75KYX686hXqT2nQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
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

On Tue, Mar 23, 2021 at 8:35 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> > On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Mar 22, 2021 at 07:11:18PM +0200, Amir Goldstein wrote:
> > > > Some filesystems on persistent storage backend use a digest of the
> > > > filesystem's persistent uuid as the value for f_fsid returned by
> > > > statfs(2).
> > > >
> > > > xfs, as many other filesystem provide the non-persistent block device
> > > > number as the value of f_fsid.
> > > >
> > > > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > > > for identifying objects using file_handle and f_fsid in events.
> > >
> > > The filesystem id is encoded into the VFS filehandle - it does not
> > > need some special external identifier to identify the filesystem it
> > > belongs to....
> > >
> >
> > Let's take it from the start.
> > There is no requirement for fanotify to get a persistent fs id, we just need
> > a unique fs id that is known to userspace, so the statfs API is good enough
> > for our needs.
> >
> > See quote from fanotify.7:
> >
> > " The fields of the fanotify_event_info_fid structure are as follows:
> > ...
> >        fsid   This  is  a  unique identifier of the filesystem
> > containing the object associated with the event.  It is a structure of
> > type __kernel_fsid_t and contains the same value as f_fsid when
> >               calling statfs(2).
> >
> >        file_handle
> >               This is a variable length structure of type struct
> > file_handle.  It is an opaque handle that corresponds to a specified
> > object on a filesystem as returned by name_to_handle_at(2).  It
> >               can  be  used  to uniquely identify a file on a
> > filesystem and can be passed as an argument to open_by_handle_at(2).
>
> Hmmmm.... so I guess you'd /like/ a file handle that will survive across
> unmount/mount cycles, and possibly even a reboot?
>
> I looked at the first commit, and I guess you use name_to_handle_at,
> which returns a mount_id that is .... that weird number in the leftmost
> column of /proc/mountinfo, which increments monotonically for each mount
> and definitely doesn't survive a remount cycle, let alone a reboot?
>
> Hence wanting to use something less volatile than mnt_id_ida...?
>
> My natural inclination is "just use whatever NFS does", but ... then I
> saw fh_compose and realized that the fsid part of an NFS handle depends
> on the export options and probably isn't all that easy for someone who
> isn't an nfs client to extract.
>
> Was that how you arrived at using the statfs fsid field?

Yes. Exactly.

>
> ...except XFS doesn't guarantee that fsid is particularly unique or
> stable, since a reboot can enumerate blockdevs in a different order and
> hence the dev_t will change.  UUIDs also aren't a great idea because you
> can snapshot an fs and mount it with nouuid, and now a "unique" file
> handle can map ambiguously to two different files.
>

As I explained in my reply to Dave, that's not a big issue.
If program want to listen on events from multiple filesystems,
the program will sample f_fsid of both filesystems before setting up the
filesystem watches. If there is a collision, there are other ways to handle
this case (i.e. run two separate listener programs).

Also, as I wrote to Dave, I can easily handle the special case of "-o nouuid"
by leaving the bdev number for f_fsid in that case.

> Urgh, I'm gonna have to think about this one, all the options suck.
> fanotify might be smart enough to handle ambiguous file handles but now

Actually, fanotify is copletely dumb about this, it's the user of fanotify that
needs to be able to do something useful with this information.

There is a demo I wrote based on inotifywatch that demonstrates that [1].

Thanks,
Amir.

[1] https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
