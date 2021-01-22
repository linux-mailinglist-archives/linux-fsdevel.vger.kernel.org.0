Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0292FFD7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 08:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAVHhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 02:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbhAVHhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:37:10 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747BC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 23:36:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z22so9271039ioh.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 23:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLsGT4brb0PqvhXsw1DiFU6oDUSAl7YmVMQwPwl/304=;
        b=eWI2TAevO8EFj2wiJTJ6qY4xBQ45HFKVPhCOIKkKy3m8h2/a5pqbOEd3gcOx6N62YE
         IuSRk3vT2W/RzzyzO1QHusPZnI4P6l0Lqd8DQEWFt9pi03jvgYDDSKteqvBvA8ZZs5pg
         IeuRELsw250mcPHhDh6CWLFqrhToVHpSLVs44Fe58XPUYzRYflYdjU6CQxR2XBki7v7f
         UBBhWxM5g9pDisRlzifeCwZeBAqrQ/TNe9d5qOUQixW/JF7cbz9fFMy+bMHRH3RK1wyO
         WGXV1FWETg8TWgSxwXHFdS/sluiNBPTCaShJnLc1bPxIS+nOMjv9+LIN++z5va9w38iE
         TS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLsGT4brb0PqvhXsw1DiFU6oDUSAl7YmVMQwPwl/304=;
        b=hMN6T6FmzrpZNzm5gg8I00l82z0kD3zLKphNj9BXYIwl3MFjFutcY+f3kWDrSzy5Bh
         lcjR48ACqMxfoB9jTRpJiQZoiC1C/CfB5pgVRJr54gAG0vUFAvhbIZdwkocEVjY+9dwZ
         ndF877GE2NlF4Ca+1IgK9zkwN5F8y5MF0E27CxJKGQO5edYeu79W3yX7QIhoB9zIROY5
         wr9CCT130oQF1ePWXMopWuRVq3LwH8S8JEApjGIUUKYME/RPV0sj6MdK+rITTgGBqIWZ
         RHBt1bD//RlvYrLm48h2TWsPcD/YoGWbuEpdifP4YBXAjiduNvnzWGmHzNWPB2W8QCmw
         y2/g==
X-Gm-Message-State: AOAM5308TaAqcVPwJijtkNPAHby9Z/cqvWOKNjvV874UU/LdSSccJWRR
        gyRZrDXqyKeckT3RQKiWzoXvdYmGpPsq4zq02PE=
X-Google-Smtp-Source: ABdhPJy3nYNZYp1tNp9fD0Ns3xnBBSQoO0Wj0vfkliqQGCxkHpDg2kuJwvI7ALDMt13fmDlL7Xw0+fTqYHOzJklPzEk=
X-Received: by 2002:a92:5b8e:: with SMTP id c14mr2957190ilg.275.1611300989785;
 Thu, 21 Jan 2021 23:36:29 -0800 (PST)
MIME-Version: 1.0
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu> <87pn1xdclo.fsf@collabora.com>
In-Reply-To: <87pn1xdclo.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Jan 2021 09:36:18 +0200
Message-ID: <CAOQ4uxjmUbyrghB+QHaoPEwk3sKrQY0Uy1DDTYvSw=O4UbW1LA@mail.gmail.com>
Subject: Re: [RFC] Filesystem error notifications proposal
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, khazhy@google.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >>   - Visibility of objects.  A bind mount of a subtree shouldn't receive
> >>     notifications of objects outside of that bind mount.
> >
> > So this is scope creep beyond the original goals of the project.  I
> > understand that there is a desire by folks in the community to support
> > various containerization use cases where only only a portion of file
> > system is visible in a container due to a bind mount.
> >
> > However, we need to recall that ext4_error messages can originate in
> > fairly deep inside the ext4 file system.  They indicate major problems
> > with the file system --- the kind that might require drastic system
> > administration reaction.  As such, at the point where we discover a
> > problem with an inode, that part of the ext4 code might not have
> > access to the pathname that was used to originally access the inode.
> >
> > We might be inside a workqueue handler, for example, so we might not
> > even running in the same process that had been containerized.  We
> > might be holding various file system mutexes or even in some cases a
> > spinlock.
>
> I see.  But the visibility is of a watcher who can see an object, not
> the application that caused the error.  The fact that the error happened
> outside the context of the containerized process should not be a problem
> here, right?  As long as the watcher is watching a mountpoint that can
> reach the failed inode, that inode should be accessible to the watcher
> and it should receive a notification. No?
>

No, because the mount/path is usually not available in file system
internal context. Even in vfs, many operations have no mnt context,
which is the reason that some fanotify event types are available for
FAN_MARK_FILESYSTEM and not for FAN_MARK_MOUNT.

> > What follows from that is that it's not really going to be possible to
> > filter notifications to a subtree.  Furthermore, if fanotify requires
> > memory allocation, that's going to be problematic, we may not be in a
> > context where memory allocation is possible.  So for that reason, it's
> > not clear to me that fanotify is going to be a good match for this use
> > case.
>
> I see.  Do you think we would be able to refactor the error handling
> code, such that we can drop spinlocks and do some non-reclaiming
> allocations at least?  I noticed Google's code seems to survive doing
> some allocations with GFP_ATOMIC in their internal-to-Google netlink
> notification system, and even GFP_KERNEL on some other scenarios.  I
> might not be seeing the full picture though.
>
> I think changing fanotify to avoid allocations in the submission path
> might be just intrusive enough for the patch to be rejected by Jan. If
> we cannot do allocations at all, I would suggest I move this feature out
> of fanotify, but stick with fsnotify, for its ability to link
> inodes/mntpoints/superblock.
>

Gabriel,

I understand the use case of monitoring a fleet of machines to know
when some machine in the fleet has a corruption.
I don't understand why the monitoring messages need to carry all the
debugging info of that corruption.

For corruption detection use case, it seems more logical to configure
machines in the fleet to errors=remount-ro and then you'd only ever
need to signal that a corruption was detected on a filesystem and the
monitoring agent can access that machine to get more debugging
info from dmesg or from filesystem recorded first/last error.

You may be able to avoid allocation in fanotify if a group keeps
a pre-allocated "emergency" event, but you won't be able to
avoid taking locks in fanotify. Even fsnotify takes srcu_read_lock
and spin_lock in some cases, so you'd have to be carefull with the
context you call fsnotify from.

If you agree with my observation that filesystem can abort itself
on corruption and keep the details internally, then the notification
of a corrupted state can always be made from a safe context
sometime after the corruption was detected, regardless of the
context in which ext4_error() was called.

IOW, if the real world use cases you have are reporting
writeback errors and signalling that the filesystem entered a corrupted
state, then fanotify might be the right tool for the job and you should
have no need for variable size detailed event info.
If you want a netoops equivalent reporting infrastructure, then
you should probably use a different tool.

Thanks,
Amir.
