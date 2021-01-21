Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D582FEBDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbhAUNaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbhAUN2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:28:45 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B214C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 05:28:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q2so3817881iow.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEylzHCWykZxYhkPgeYYd5AoW/CXeAarLg/k3p8mb9o=;
        b=gaY1BK6WSJrL7XIywMQ1W0PtmMmWsVWcKzAV9Lf8ZEEFgMmRUYxNlk7MFeYorVj6A8
         C5HyMwQJ1RPJMEwPKZTH2VYzK1EHLzumV/vzJMvnfZdhVXQlMgrflyN9Np57g4L0z5ke
         N+Lz+rGrbT+yjoxzRnPi9vLlFmJW5aHyrq1paNLmfvMM5tJ1d5lDee40M2fzGuYfCmqg
         Is9jL6/CcFgUEh81QN0NvQtMO9GAoKi/A5ozHQmQ7jHMO9hXXEbJh1dDB6GoS+xvBgIw
         OMNqu21UHK9Wt0PGGASdEpwQJCfZv5ulAdGyzobpCuc2VbH8cGsdVfqalWyV/zilJqLp
         iegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEylzHCWykZxYhkPgeYYd5AoW/CXeAarLg/k3p8mb9o=;
        b=axWA6lUlI4Q8Jhp6dKY4+XU0QNAG86pzn5pn+8bhmS2uJ6LTOVeeDlG34wBeGYLJxK
         a/BdT0wnbD3sHGzQ+x8SpbciNYfCSTl47DSsLtG5bvbc0Y1IW7wVfyYifXgL3iH/fPjX
         Do6OzjcmxsVHa6H4hLvpeI/xqtj5hD7kBaDrEbyQsXIEiNSoR8rbxV36SCv+3tAOLrQl
         Eq2u9pnT87g34OWQF5C+ia0VSETDb3jMY7KVpjMjTfA//eMIxFUU5ZZmYwa3rwmsAwD6
         Pum4N7IaBGxaduZ3C1fpjhPWFxQuW3ERcfI5+HljbieifsUJs+VpT76PXUoifgohNPfu
         pVag==
X-Gm-Message-State: AOAM532BZcVYrhLPDpAnGwLdoThKvMXEkfwUtwjwq2v3tHeal9J/NQHE
        PcOKMJZVrnAW0LKUbHr+Xsd2EdcHpCC6dX9/hTb53P4dXn4=
X-Google-Smtp-Source: ABdhPJzFISQUyHw1yR4us0urhfUA7ERXFUbUdL1nuEIo8rUSTQaWFSfAMuKAT8J1Gf6deVixIYVyED5g0+a/CrRQ5bk=
X-Received: by 2002:a02:d45:: with SMTP id 66mr12215322jax.120.1611235683645;
 Thu, 21 Jan 2021 05:28:03 -0800 (PST)
MIME-Version: 1.0
References: <87lfcne59g.fsf@collabora.com> <20210121114453.GD24063@quack2.suse.cz>
In-Reply-To: <20210121114453.GD24063@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Jan 2021 15:27:52 +0200
Message-ID: <CAOQ4uxj2JSrCjBVzQVg8y6KLf-JoVB+D0w61-eeUGOMvfb9CXA@mail.gmail.com>
Subject: Re: [RFC] Filesystem error notifications proposal
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, khazhy@google.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel@collabora.com, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:44 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Gabriel,
>
> On Wed 20-01-21 17:13:15, Gabriel Krisman Bertazi wrote:
> > 1 Summary
> > =========
> >
> >   I'm looking for a filesystem-agnostic mechanism to report filesystem
> >   errors to a monitoring tool in userspace.  I experimented first with
> >   the watch_queue API but decided to move to fanotify for a few reasons.
> >
> >
> > 2 Background
> > ============
> >
> >   I submitted a first set of patches, based on David Howells' original
> >   superblock notifications patchset, that I expanded into error
> >   reporting and had an example implementation for ext4.  Upstream review
> >   has revealed a few design problems:
> >
> >   - Including the "function:line" tuple in the notification allows the
> >     uniquely identification of the error origin but it also ties the
> >     decodification of the error to the source code, i.e. <function:line>
> >     is expected to change between releases.
> >
> >   - Useful debug data (inode number, block group) have formats specific
> >     to the filesystems, and my design wouldn't be expansible to
> >     filesystems other than ext4.
> >
> >   - The implementation allowed an error string description (equivalent
> >     to what would be thrown in dmesg) that is too short, as it needs to
> >     fit in a single notification.
> >
> >   - How the user sees the filesystem.  The original patch points to a
> >     mountpoint but uses the term superblock.  This is to differentiate
> >     from another mechanism in development to watch mounting operations.
> >
> >   - Visibility of objects.  A bind mount of a subtree shouldn't receive
> >     notifications of objects outside of that bind mount.
> >
> >
> > 2.1 Other constraints of the watch_queue API
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >   watch_queue is a fairly new framework, which has one upstream user in
> >   the keyring subsystem.  watch_queue is designed to submit very short
> >   (max of 128 bytes) atomic notifications to userspace in a fast manner
> >   through a ring buffer.  There is no current mechanism to link
> >   notifications that require more than one slot and such mechanism
> >   wouldn't be trivial to implement, since buffer overruns could
> >   overwrite the beginning/end of a multi part notification.  In
> >   addition, watch_queue requires an out-of-band overflow notification
> >   mechanism, which would need to be implemented aside from the system
> >   call, in a separate API.
> >
> >
> > 2.2 fanotify vs watch_queue
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >   watch_queue is designed for efficiency and fast submission of a large
> >   number of notifications.  It doesn't require memory allocation in the
> >   submission path, but with a flexibility cost, such as limited
> >   notification size.  fanotify is more flexible, allows for larger
> >   notifications and better filtering, but requires allocations on the
> >   submission path.
> >
> >   On the other hand, fanotify already has support for the visibility
> >   semantics we are looking for. fsnotify allows an inode to notify only
> >   its subtree, mountpoints, or the entire filesystem, depending on the
> >   watcher flags, while an equivalent support would need to be written
> >   from scratch for watch_queue.  fanotify also has in-band overflow
> >   handling, already implemented.  Finally, since fanotify supports much
> >   larger notifications, there is no need to link separate notifications,
> >   preventing buffer overruns from erasing parts of a notification chain.
> >
> >   fanotify is based on fsnotify, and the infrastructure for the
> >   visibility semantics is mostly implemented by fsnotify itself.  It
> >   would be possible to make error notifications a new mechanism on top
> >   of fsnotify, without modifying fanotify, but that would require
> >   exposing a very similar interface to userspace, new system calls, and
> >   that doesn't seem justifiable since we can extend fanotify syscalls
> >   without ABI breakage.
>
> I agree fanotify could be used for propagating the error information from
> kernel to userspace. But before we go to design how exactly the events
> should look like, I'd like to hear a usecase (or usecases) for this
> feature. Because the intended use very much determines which information we
> need to propagate to userspace and what flexibility we need there.
>

I agree with Jan both on using fanotify report fs errors and for not
overengineering the error details without specific use cases.

FWIW, here is a specific use case - reporting writeback errors.
Writeback errors are recorded for specific files (f_mapping->wb_err)
and on sb (sb->s_wb_err) they hold the specific error code only for the last
reported error. New error type overwrites an existing error type.
Being able to queue writeback errors in events queue could be useful
for that reason alone.

But notifications for writeback errors are useful for more reasons.
Currently, the only way for users to probe for writeback errors is by
issuing fsync() or syncfs() respectively, so polling for writeback errors
this way is out of the question even if polling would have been considered
sufficient for an application.

Of course we could add an API to poll for writeback errors without issuing
writeback, but a notification API is much better, because you can use it for
polling as well (poll the queue) and because fsnotify merges events in the
queue, so multiple writeback events are not likely to cause queue overflow.

> > 3 Proposal
> > ==========
> >
> >   The error notification framework is based on fanotify instead of
> >   watch_queue.  It is exposed through a new set of marks FAN_ERROR_*,
> >   exposed through the fanotify_mark(2) API.
> >
> >   fanotify (fsnotify-based) has the infrastructure in-place to link
> >   notifications happening at filesystem objects to mountpoints and to
> >   filesystems, and already exposes an interface with well defined
> >   semantics of how those are exposed to watchers in different
> >   mountpoints or different subtrees.
> >
> >   A new message format is exposed, if the user passed
> >   FAN_REPORT_DETAILED_ERROR fanotify_init(2) flag.  FAN_ERROR messages
> >   don't have FID/DFID records.
>
> So this depends on the use case. I can imagine that we could introduce new
> event type FAN_FS_ERROR (like we currently have FAN_MODIFY, FAN_ACCESS,
> FAN_CREATE, ...). This event type would be generated when error happens on
> fs object - we can generate it associated with struct file, struct dentry,
> or only superblock, depending on what information is available at the place
> where fs spots the error. Similarly to how we generate other fsnotify
> events. But here's the usecase question - is there really need for fine
> granularity of error reporting (i.e., someone watching errors only on a
> particular file, or directory)?
>

For writeback errors, marking a specific file for fs error events may
make sense.
A database application for example, may care about writeback errors to the
db file and not about writeback errors elsewhere in the system, given that
periodic fsync() is out of the question.

> FAN_FS_ERROR could be supported in all types of fanotify notification
> groups (although I'm not sure supporting normal fanotify mode really makes
> sense for errors since that requires opening the file where error occurs
> which is likely to fail anyway) and depending on other FAN_REPORT_ flags in
> the notification group we'd generate appropriate information the
> notification event (like FID, DFID, name, ...)
>
> Then we can have FAN_REPORT_DETAILED_ERROR which would add to event more
> information about the error like you write below - although identification
> of the inode / fsid is IMO redundant - you can get all that information
> (and more) from FID / DFID event info entries if you want it.
>

I second that.
Gabriel, may I also suggest that you take a look at XFS's corruption reporters
xfs_{buf,inode}_verifier_error().
The common information beyond error type and inode that is propagated
to reporters is  xfs_failaddr_t.
This is a much more compact way to report the line:function information.
WRT the security implications of reporting kernel addresses, as long as the
watcher is required to have CAP_SYS_ADMIN it is not an issue and function:line
resolving can happen in userspace.

Thanks,
Amir.
