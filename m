Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B63471EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhCXGx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhCXGxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:53:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B0C061763;
        Tue, 23 Mar 2021 23:53:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e8so20419116iok.5;
        Tue, 23 Mar 2021 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20bml85JF0OkcEn1NvYahfMctvKrc4VvU40uU0VybaE=;
        b=hVj3GVfdz8goOZ+sIewDQ53a8pEDZQmJm6onrZ5jKaY+v7jLhJeTqh0jPa2rAp3iE/
         4MOTD//EvfH23PWh+4v5NsYVYLC1chLyAsNZYPN/7jUmCcgzuwCuyG/pQKRplO756ZGl
         VIKjSTtNrWS2bgedw2FGCeo9rjfkVz4AO7AcPN6ikSqUPZ3IMW7lLXUdbbSmm5fVXFpe
         4w42IAKHpXGD+cTBG5BbWbBiq2BbBIT3gutybmtk5erGMgljdciEP/bqDr98zLS3g2aE
         DOqEq7rg3RQrUeGCw5aYdoxWoET26oFk+g38Yw6o2KypdMPta909xdqblkILauWrmB4b
         IJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20bml85JF0OkcEn1NvYahfMctvKrc4VvU40uU0VybaE=;
        b=nC40GeYYQoWXjOrjpvjnl6FWyT8xxOEdjHEZSwco4bpz7PxJMDQV2KnfMW6Gu9kEhi
         rPMq6Y+wRtp5xCJYLDQE3xQvErv+kKIT8u6vAecP/0WWWtbCFEVILePDdrS2VPKrAjaB
         LpmkTRfEZ8ynb+kbZvXlSbwPc/lXG/Y8wANWrIN3eq2dtciddgMB8EMt2xz4jwpbbEXA
         JxoVbjFKWySB5iH+2XLwiJY+RPQ9X284Drp3Aqn672nnIqIKUgzCeYLYB6TP8jGtLPfb
         q8uVrUfdkFoIXQgq1oCEF4XLn2YSoXMymv7uUm5r6lPEo3N0u51zZY6utAZtCAJ5+FOT
         hxjA==
X-Gm-Message-State: AOAM533dHCta2rxm4TWlcg3QzJh5dIdEx8jQ19KzzCNthsRi4Qnt0nDf
        aZlBYePPn/MYOQeN7WfEIda1H90vPDks3QlKrhHByK6bKO0=
X-Google-Smtp-Source: ABdhPJwbdIigQs2LMrkDlwkVFFWEr3vgY8RcyIsKatnC+4CfU3d3+TlcE8bxP9Fi8sKIHgrEEriUy+1DduCJuYOYAu8=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr1363026iot.186.1616568816211;
 Tue, 23 Mar 2021 23:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area> <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area>
In-Reply-To: <20210324005421.GK63242@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 08:53:25 +0200
Message-ID: <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
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

On Wed, Mar 24, 2021 at 2:54 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 23, 2021 at 11:35:46AM +0200, Amir Goldstein wrote:
> > On Tue, Mar 23, 2021 at 9:26 AM Dave Chinner <david@fromorbit.com> wrote:
> > > On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> > > > On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > For most use cases, getting a unique fsid that is not "persistent"
> > would be fine. Many use case will probably be watching a single
> > filesystem and then the value of fsid in the event doesn't matter at all.
> >
> > If, however, at some point in the future, someone were to write
> > a listener that stores events in a persistent queue for later processing
> > it would be more "convenient" if fsid values were "persistent".
>
> Ok, that is what I suspected - that you want to write filehandles to
> a userspace database of some sort for later processing and so you
> need to also store the filesystem that the filehandle belongs to.
>
> FWIW, that's something XFS started doing a couple of decades ago for
> DMAPI based prioprietary HSM implementations. They were build around
> a massive userspace database that indexed the contents of the
> fileystem via file handles and were kept up to date via
> notifications through the DMAPI interface.
>

History repeats itself, but with different storage tearing layers ;-)

[...]
> > When the program is requested to watch multiple filesystems, it starts by
> > querying their fsid. In case of an fsid collision, the program knows that it
> > will not be able to tell which filesystem the event originated in, so the
> > program can print a descriptive error to the user.
>
> Ok, so it can handle collisions, but it cannot detect things like
> two filesystems swapping fsids because device ordering changed at
> boot time. i.e. there no way to determine the difference between
> f_fsid change vs the same filesystems with stable f_fsid being
> mounted in different locations....
>

Correct.

[...]

> > Leaving fanotify out of the picture, the question that the prospect user is
> > trying answer is:
> > "Is the object at $PATH or at $FD the same object that was observed at
> >  'an earlier time'?"
> >
> > With XFS, that question can be answered (< 100% certainty)
> > using the XFS_IOC_PATH_TO_FSHANDLE interface.
>
> Actually, there's a bit more to it than that. See below.
>
> > name_to_handle_at(2) + statfs(2) is a generic interface that provides
> > this answer with less certainty, but it could provide the answer
> > with the same certainty for XFS.
>
> Let me see if I get this straight....
>
> Because the VFS filehandle interface does not cater for this by
> giving you a fshandle that is persistent, you have to know what path
> the filehandle was derived from to be able to open a mountfd for
> open_by_handle_at() on the file handle you have stored in userspace.

That is what NFS and DMAPI need, but this is not what I asked for.
I specifically asked for the ability to answer the question:
"Is the object at $PATH or at $FD the same object that was observed at
 'an earlier time'?"

Note that as opposed to open_by_handle_at(), which requires
capabilities, checking the identity of the object does not require any
capabilities beyond search/read access permissions to the object.

Furthermore, with name_to_handle_at(fd, ..., AT_EMPTY_PATH)
and fstatfs() there are none of the races you mention below and
fanotify obviously captures a valid {fsid,fhandle} tuple.

> And that open_by_handle_at() returns an ephemeral mount ID, so the
> kernel does not provide what you need to use open_by_handle_at()
> immediately.
>
> To turn this ephemeral mount ID into a stable identifier you have to
> look up /proc/self/mounts to find the mount point, then statvfs()
> the mount point to get the f_fsid.
>
> To use the handle, you then need to open the path to the stored
> mount point, check that f_fsid still matches what you originally
> looked up, then you can run open_by_handle_at() on the file handle.
> If you have an open fd on the filesystem and f_fsid matches, you
> have the filesystem pinned until you close the mount fd, and so you
> can just sort your queued filehandles by f_fsid and process them all
> while you have the mount fd open....
>
> Is that right?

It's not wrong, but it's irrelevant to the requirement, which was to
*identify* the object, not to *access* the object.
See more below...

>
> But that still leaves a problem in that the VFS filehandle does not
> contain a filesystem identifier itself, so you can never actually
> verify that the filehandle belongs to the mount that you opened for
> that f_fsid. i.e. The file handle is built by exportfs_encode_fh(),
> which filesystems use to encode inode/gen/parent information.
> Nothing else is placed in the VFS handle, so the file handle cannot
> be used to identify what filesystem it came from.
>
> These seem like a fundamental problems for storing VFS handles
> across reboots: identifying the filesystem is not atomic with the
> file handle generation and it that identification is not encoded
> into the file handle for later verification.
>
> IOWs, if you get the fsid translation wrong, the filehandle will end
> up being used on the wrong filesystem and userspace has no way of
> knowing that this occurred - it will get ESTALE or data that isn't
> what it expected. Either way, it'll look like data corruption to the
> application(s). Using f_fsid for this seems fragile to me and has
> potential to break in unexpected ways in highly dynamic
> environments.
>

The potential damage sounds bad when you put it this way, but in fact
it really depends on the use case. For the use case of NFS client it's true
you MUST NOT get the wrong object when resolving file handles.

With fanotify, this is not the case.
When a listener gets an event with an object identifier, the listener cannot
infer the path of that object.

If the listener has several objects open (e.g. tail -f A B C) then when getting
an event, the identifier can be used to match the open file with certainty
(having verified no collisions of identifiers after opening the files).

If the listener is watching multiple directories (e.g. inotifywatch --recursive)
then the listener has two options:
1. Keep open fds for all watches dirs - this is what inotify_add_watch()
    does internally (not fds per-se but keeping an elevated i_count)
2. Keep fid->path map for all watches dirs and accept the fact that the
    cached path information may be stale

The 2nd option is valid for applications that use the events as hints
to take action. An indexer application, for example, doesn't care if
it will scan a directory where there were no changes as long as it will
get the correct hint eventually.

So if an indexer application were to act on FAN_MOVE events by
scanning the entire subtree under the parent dir where an entry was
renamed, the index will be eventually consistent, regardless of all
the events on objects with stale path cache that may have been
received after the rename.

> The XFS filehandle exposed by the ioctls, and the NFS filehandle for
> that matter, both include an identifier for the filesystem they
> belong to in the file handle. This identifier matches the stable
> filesystem identifier held by the filesystem (or the NFS export
> table), and hence the kernel could resolve whether the filehandle
> itself has been directed at the correct filesystem.
>
> The XFS ioctls do not do this fshandle checking - this is something
> performed by the libhandle library (part of xfsprogs).  libhandle
> knows the format of the XFS filehandles, so it peaks inside them to
> extract the fsid to determine where to direct them.
>
> Applications must first initialise filesystems that file handles can
> be used on by calling path_to_fshandle() to populate an open file
> cache.  Behind the scenes, this calls XFS_IOC_PATH_TO_FSHANDLE to
> associate a {fd, path, fshandle} tuple for that filesystem. The
> libhandle operations then match the fsid embedded in the file handle
> to the known open fshandles, and if they match it uses the
> associated fd to issue the ioctl to the correct filesystem.
>
> This fshandle fd is held open for as long as the application is
> running, so it pins the filesystem and so the fshandle obtained at
> init time is guaranteed to be valid until the application exits.
> Hence on startup an app simply needs to walk the paths it is
> interested in and call path_to_fshandle() on all of them, but
> otherwise it does not need to know what filesystem a filehandle
> belongs to - the libhandle implementation takes care of that
> entirely....
>
> IOWs, this whole "find the right filesystem for the file handle"
> implementation is largely abstracted away from userspace by
> libhandle. Hence just looking at what the the XFS ioctls do does not
> give the whole picture of how stable filehandles were actually used
> by applications...
>
> I suspect that the right thing to do here is extend the VFS
> filehandles to contain an 8 byte fsid prefix (supplied by a new an
> export op) and an AT_FSID flag for name_to_handle_at() to return
> just the 8 byte fsid that is used by handles on that filesystem.
> This provides the filesystems with a well defined API for providing
> a stable identifier instead of redefining what filesystems need to
> return in some other UAPI.
>
> This also means that userspace can be entirely filesystem agnostic
> and it doesn't need to rely on parsing proc files to translate
> ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
> stable enough that it doesn't get the destination wrong.  It also
> means that fanotify UAPI probably no longer needs to supply a
> f_fsid with the filehandle because it is built into the
> filehandle....
>

That is one option. Let's call it the "bullet proof" option.

Another option, let's call it the "pragmatic" options, is that you accept
that my patch shouldn't break anything and agree to apply it.

In that case, a future indexer (or whatever) application author can use
fanotify, name_to_handle_at() and fstats() as is and document that after
mount cycle, the indexer may get confused and miss changes in obscure
filesystems that nobody uses on desktops and servers.

The third option, let's call it the "sad" option, is that we do nothing
and said future indexer application author will need to find ways to
work around this deficiency or document that after mount cycle, the
indexer may get confused and miss changes in commonly used
desktop and server filesystems (i.e. XFS).

<side bar>
I think that what indexer author would really want is not "persistent fsid"
but rather a "persistent change journal" [1].
I have not abandoned this effort and I have a POC [2] for a new fsnotify
backend (not fanotify) based on inputs that also you provided in LSFMM.
In this POC, which is temporarily reusing the code of overlayfs index,
the persistent identifier of an object is {s_uuid,fhandle}.
</side bar>

Would you be willing to accept the "pragmatic" option?

Thanks,
Amir.

[1] https://lwn.net/Articles/755277/
[2] https://github.com/amir73il/linux/commits/ovl-watch
