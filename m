Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AC5E5A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 06:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIVEf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 00:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVEfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:35:55 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E93857E7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 21:35:53 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o123so9044147vsc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 21:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eZFY8zDJyQ/N0GMmKvR5W6boaIlcLWUvSQMoij4X4ME=;
        b=JyEtdnCcHngeMRjjA8ww/Qgd6cKW72m2nqS83KV7NQpQ1+Vvt/wDIAvX/lx2A44rZA
         NlqBOpuGTYUuZN+vtXtHdKmaUjChxPWmcjQ0kI0M9R95Jddv1K9ywx7WuWyJTHyYaMsp
         e6BmZrdKTl1xxN25gGdr4d86b2WAnTs5zK9gm5Z9zCkVEMPdgu26MtS5Ezg1qeSwdsV/
         7aovNV/7tOZTwwKvVpyI9JPHxbzPqVP8CU5r2K+8L1/j62Y2qskBAGMPVcWgEPJ8P9Di
         wBwivvqfLaowrCTmGUsA7wRoyEo+7RpViVg9F9PYhNi2pkZSTUEAJROekunQ6l7SW8OB
         fNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eZFY8zDJyQ/N0GMmKvR5W6boaIlcLWUvSQMoij4X4ME=;
        b=xd68C7Y/Clc6siwWwU/gPowLjzv4jgfqyaO2W3rQwNKWbEJm2Hv+JdHi/5J8sNiwkE
         zeguIMLoTcHGaMsCbqDN7/De04/5voE75/fwotHtg6nZOgbPN6mq1u4a2m1JsRneXg/7
         E+BQZ/C7fIOtunA1kZ7fxdBrH6LAnqjF6B/QuvjD273nqHrpFy1T7vxVzLwsL0n0mNfP
         UAKNkHrLkUZnu3ctFSrucXTcez88Xo99ynzk1U4L56syef4CbzJ7S4IDHn6yFN1qrYLw
         0ouuHOk61pq7bykFFkuiXVGC+hSkDv4GomCMT4n/XVvAelNterPPuGMQyMDf8AQNaYSm
         7dlg==
X-Gm-Message-State: ACrzQf1IPXGT28cqsnc1MER+anbrXkPMRHE/tmNYJgsYgjdqc0z8dWPE
        aFq2/Ag7DFjVHB5Tg5wmJ7B6hUjn4mnfSWZprBM=
X-Google-Smtp-Source: AMsMyM635l9+whFxgUlS2ZtNlyJVGUI+8UmaP31zCm9x9Fe2KZr1TtoJhYMUi70Jra34feP8owwUmJS4m7ijfGo5D5g=
X-Received: by 2002:a67:a247:0:b0:39a:c318:3484 with SMTP id
 t7-20020a67a247000000b0039ac3183484mr545560vsh.2.1663821351944; Wed, 21 Sep
 2022 21:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220921232729.GE3144495@dread.disaster.area>
In-Reply-To: <20220921232729.GE3144495@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Sep 2022 07:35:39 +0300
Message-ID: <CAOQ4uxgip1Hfvtjf=XvXSbGpBoJrN0Zc7JD_z9QqtW5U7mSN5Q@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Sep 11, 2022 at 09:12:06PM +0300, Amir Goldstein wrote:
> > Hi Jan,
> >
> > I wanted to consult with you about preliminary design thoughts
> > for implementing a hierarchical storage manager (HSM)
> > with fanotify.
> >
> > I have been in contact with some developers in the past
> > who were interested in using fanotify to implement HSM
> > (to replace old DMAPI implementation).
> >
> > Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> > should be enough to implement a basic HSM, but it is not
> > sufficient for implementing more advanced HSM features.
>
> Ah, I wondered where the people with that DMAPI application went all
> those years ago after I told them they should look into using
> fanotify to replace the dependency they had on the DMAPI patched
> XFS that SGI maintained for years for SLES kernels...
>

Indeed. Robert has told that the fanotify HSM code would be uploaded
to github in the near future:

https://deepspacestorage.com/resources/#downloads

> > Some of the HSM feature that I would like are:
> > - blocking hook before access to file range and fill that range
> > - blocking hook before lookup of child and optionally create child
>
> Ok, so these are to replace the DMAPI hooks that provided a blocking
> userspace upcall to the HSM to allow it fetch data from offline
> teirs that wasn't currently in the filesystem itself. i.e. the inode
> currently has a hole over that range of data, but before the read
> can proceed the HSM needs to retreive the data from the remote
> storage and write it into the local filesystem.
>
> I think that you've missed a bunch of blocking notifications that
> are needed, though. e.g. truncate needs to block while the HSM
> records the file ranges it is storing offline are now freed.
> fallocate() needs to block while it waits for the HSM to tell it the
> ranges of the file that actually contain data and so should need to
> be taken into account. (e.g. ZERO_RANGE needs to wait for offline
> data to be invalidated, COLLAPSE_RANGE needs offline data to be
> recalled just like a read() operation, etc).
>
> IOWs, any operation that manipulates the extent map or the data in
> the file needs a blocking upcall to the HSM so that it can restore
> and invalidate the offline data across the range of the operation
> that is about to be performed....

The event FAN_PRE_MODIFY mentioned below is destined to
take care of those cases.
It is destined to be called from
security_file_permission(MAY_WRITE) => fsnotify_perm()
which covers all the cases that you mentioned.

>
> > My thoughts on the UAPI were:
> > - Allow new combination of FAN_CLASS_PRE_CONTENT
> >   and FAN_REPORT_FID/DFID_NAME
> > - This combination does not allow any of the existing events
> >   in mask
> > - It Allows only new events such as FAN_PRE_ACCESS
> >   FAN_PRE_MODIFY and FAN_PRE_LOOKUP
> > - FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
> >   optional file range info
> > - All the FAN_PRE_ events are called outside vfs locks and
> >   specifically before sb_writers lock as in my fsnotify_pre_modify [1]
> >   POC
> >
> > That last part is important because the HSM daemon will
> > need to make modifications to the accessed file/directory
> > before allowing the operation to proceed.
>
> Yes, and that was the biggest problem with DMAPI - the locking
> involved. DMAPI operations have to block without holding any locks
> that the IO path, truncate, fallocate, etc might need, but once they
> are unblocked they need to regain those locks to allow the operation
> to proceed. This was by far the ugliest part of the DMAPI patches,
> and ultimately, the reason why it was never merged.
>

Part of the problem is that the DMAPI hooks were inside fs code.
My intention for fanotify blocking hooks to be in vfs before taking any
locks as much as possible.

I already have a poc project that added those pre-modify hooks
for the change tracking journal thing.

For most of the syscalls, security_file_permission(MAY_WRITE) is
called before taking vfs locks (sb_writers in particular), except for
dedupe and clone and that one is my fault - 031a072a0b8a
("vfs: call vfs_clone_file_range() under freeze protection"), so
I'll need to deal with it.

> > Naturally that opens the possibility for new userspace
> > deadlocks. Nothing that is not already possible with permission
> > event, but maybe deadlocks that are more inviting to trip over.
> >
> > I am not sure if we need to do anything about this, but we
> > could make it easier to ignore events from the HSM daemon
> > itself if we want to, to make the userspace implementation easier.
>
> XFS used "invisible IO" as the mechanism for avoiding sending DMAPI
> events for operations that we initiated by the HSM to move data into
> and out of the filesystem.
>
> No doubt you've heard us talk about invisible IO in the past -
> O_NOCMTIME is what that invisible IO has eventually turned into in a
> modern Linux kernel. We still use that for invisible IO - xfs_fsr
> uses it for moving data around during online defragmentation. The
> entire purpose of invisible IO was to provide a path for HSMs and
> userspace bulk data movers (e.g. HSM aware backup tools like
> xfsdump) to do IO without generating unnecessary or recursive DMAPI
> events....
>
> IOWs, if we want a DMAPI replacement, we will need to formalise a
> method of performing syscall based operations that will not trigger
> HSM notification events.
>

This concept already exists in fanotify.
This is what FMODE_NONOTIFY is for.
The event->fd handed in FAN_ACCESS_PERM event can be use to
read the file without triggering a recursive event.
This is how Anti-Malware products scan files.

I have extended that concept in my POC patch to avoid recursive
FAN_LOOKUP_PERM event when calling Xat() syscall with
a dirfd with FMODE_NONOTIFY:

https://github.com/amir73il/linux/commits/fanotify_pre_content

> The other thing that XFS had for DMAPI was persistent storage in the
> inode of the event mask that inode should report events for. See
> the di_dmevmask and di_dmstate fields defined in the on-disk inode
> format here:
>
> https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/tree/design/XFS_Filesystem_Structure/ondisk_inode.asciidoc
>
> There's no detail for them, but the event mask indicated what DMAPI
> events the inode should issue notifications for, and the state field
> held information about DMAPI operations in progress.
>
> The event field is the important one here - if the event field was
> empty, access to the inode never generated DMAPI events. When the
> HSM moved data offline, the "READ" event mask bit was set by the HSM
> and that triggered DMAPI events for any operation that needed to
> read data or manipulate the extent map. When the data was brought
> entirely back online, the event masks count be cleared.
>

HSM can and should manage this persistent bit, but it does not
have to be done using a special ioctl.
We already use xattr and/or fileattr flags in our HSM implementation.

I've mentioned this in my reply to Jan.
The way I intend to address this "persistent READ hook" in
fanotify side is by attaching an HSM specific BFP program to
an fanotify filesystem mark.

We could standartize a fileattr flag just the same as NODUMP
was for the use of backup applications (e.g. NODATA), but it
is not a prerequite, just a standard way for HSM to set the
persistent READ hook bit.

An HSM product could be configured to reappropriate NODUMP
for that matter or check for no READ bits in st_mode or xattr.

> However, DMAPI also supports dual state operation, where the
> data in the local filesystem is also duplicated in the offline
> storage (e.g. immediately after a recall operation). This state can
> persist until data or layout is changed in the local filesystem,
> and so there's a "WRITE" event mask as well that allows the
> filesystem to inform the HSM that data it may have in offline
> storage is being changed.
>
> The state field is there to tell the HSM that an operation was in
> progress when the system crashed. As part of recovery, the HSM needs
> to find all the inodes that had DM operations in progress and either
> complete them or revert them to bring everything back to a
> consistent state. THe SGI HSMs used the bulkstat interfaces to scan
> the fs and find inodes that had a non-zero DM state field. This is
> one of the reasons that having bulkstat scale out to scanning
> millions of inodes a second ends up being important - coherency
> checking between the ondisk filesystem state and the userspace
> offline data tracking databases is a very important admin
> operation..
>

Normally, HSM will be listening on a filesystem mark to async
FAN_MODIFY and FAN_CLOSE_WRITE events.

To cover the case of crash and missing fanotify events, we use
the persistent change tracking journal.
My current prototype is in overlayfs driver using pre-modify
fsnotify hooks, as we discussed back in LSFMM 2018:

https://github.com/amir73il/overlayfs/wiki/Overlayfs-watch

The idea is to export those pre-modify hooks via fanotify
and move this implementation from the overlayfs driver to
userspace HSM daemon.

Note that the name "Change Tracking Journal" may be confusing -
My implementation does not store a time sequence of events like
the NTFS Change Journal - it only stores a map of file handles of
directories containing new/changed/deleted files.
Iterating this "Changed dirs map" is way faster then itereating
bulkstat of all inodes and looking for the WRITE bit.

The responsibility of maintaining per file "dirty" state is on HSM
and it can be done using the change tracking journal and an
external database. Filesystem provided features such as ctime
and iversion can be used to optimize the management of "dirty"
state, but they are not a prerequisite and most of the time the
change journal is sufficient to be able to scale up, because it
can give you the answer to the question:
"In which of the multi million dirs, do I need to look for changes
 to be synced to secondary storage?".

> The XFS dmapi event and state mask control APIs are now deprecated.
> The XFS_IOC_FSSETDM ioctl could read and write the values, and the
> the XFS V1 bulkstat ioctl could read them. There were also flags for
> things like extent mapping ioctls (FIEMAP equivalent) that ensured
> looking at the extent map didn't trigger DMAPI events and data
> recall.
>
> I guess what I'm trying to say is that there's a lot more to an
> efficient implementation of a HSM event notification mechanism than
> just implementing a couple of blocking upcalls. IF we want something
> that will replace even simple DMAPI-based HSM use cases, we really
> need to think through how to support all the operations that a
> recall operation might needed for and hence have to block. ANd we
> really should think about how to efficiently filter out unnecessary
> events so that we don't drown the HSM in IO events it just doesn't
> need to know about....
>

Thinking about efficient HSM implementation and testing prototypes is
what I have been doing for the past 6 years in CTERA.

My thoughts and design for fanotify HSM can be backed up with several
successful prototypes that have been deployed on large scale
customer environments where both high performance and reliable
backups are a very hard requirements.

> > Another thing that might be good to do is provide an administrative
> > interface to iterate and abort pending fanotify permission/pre-content
> > events.
>
> That was generally something the DMAPI event consumer provided.
>
> > You must have noticed the overlap between my old persistent
> > change tracking journal and this design. The referenced branch
> > is from that old POC.
> >
> > I do believe that the use cases somewhat overlap and that the
> > same building blocks could be used to implement a persistent
> > change journal in userspace as you suggested back then.
>
> That's a very different use case and set of requirements to a HSM.
>
> A HSM tracks much, much larger amounts of data than a persistent
> change journal. We had [C]XFS-DMAPI based HSMs running SLES in
> production that tracked half a billion inodes and > 10PB of data 15
> years ago. These days I'd expect "exabyte" to be the unit of
> storage that large HSMs are storing.
>
> > Thoughts?
>
> I think that if the goal is to support HSMs with fanotify, we first
> need to think about how we efficiently support all the functionality
> HSMs require rather than just focus on a blocking fanotify read
> operation. We don't need to implement everything, but at least
> having a plan for things like handling the event filtering
> requirements without the HSM having to walk the entire filesystem
> and inject per-inode event filters after every mount would be a real
> good idea....
>

All of the above have been considered and I have mentioned
the proposed solution in the thread.

I may post some partial RFC patches to hash out some
implementation details along the way (e.g. for FAN_LOOKUP_PERM),
but when I send out the final proposal it will include all the fanotify
extensions required to implement a fully functional and performant HSM.

Given the number and lengths of Q&A in this thread I am probably
going to summarize this discussion in a wiki to send along with the
proposal for fanotify HSM API.

Thanks,
Amir.
