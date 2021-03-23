Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F29345AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCWJgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCWJf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:35:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4895C061574;
        Tue, 23 Mar 2021 02:35:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v26so16971148iox.11;
        Tue, 23 Mar 2021 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoDdTen+zAMFl0GxVVB1fBQf5ZNoQIln2EjTkcX0tpI=;
        b=YabPS6T8H6l7aQjAk9L9gRN1XRKlDpWjzxvAwi8Tx3kwKPu97ZMaujmVLFx24+3w81
         ojnMwtvcozRQCkgmUP7Nn84OX3bUxbnY16fWwZynUUHaZMvLgd+mP7T24aW25BqB7Yrf
         FgYdzqdc8FvZU/sBUzobJzpVQlA0lyxeOZdEqrcTH1Fmx/ksEHzU4PtNLOUFK3EljI/x
         npqTUGYLVHRAcfK+ms64f52z7kba7CgXAf3Xde/avCTayAw1jE7Wl+w9zx1HAXw8GGJj
         PteaVJUsF96X7XuUWNKab3NPplZJj53+fF8kEnLBW44cRihORfc9wP7FZgdsTiyII7ql
         4DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoDdTen+zAMFl0GxVVB1fBQf5ZNoQIln2EjTkcX0tpI=;
        b=k9N5qkI9aMZdaLTzh1OOIhOP5ZwR1T0qR+kJyt9VqsqqrfUkmJgMX1ufHE6am17ieC
         9GrBduubYemOliFKFmzxua/kFaFRJP8VDEghwocglJc2eXVkM2erm9HJ3JvyFjf2BORU
         VHy5hSbqcztLD+U0zqTj+4bFdlfnbUkWw9GHQFk6MgsSXKNtrgLs95lqKup5Hz4YHvW+
         j3Sg3NeS4EUJ+PVee2coeEk6YJ8YDq+6OjJnD6+rqo6VJZJkjy2/1P8l5slbQpt2u5me
         wNJFeFVYgNFpY3A0Fuj2S+CSabSTLCd/oD2l/W4QuhPc9HHKkwyygz+fc7Uy8iejyc8B
         TW6w==
X-Gm-Message-State: AOAM531LR63QW8fMny2Qxznlj5jixxoYHcyCn0dfGDERLJaAW1B7P06c
        6Yd6iqgmVvHDPVh9fDLYgn2mDPfeggC5O7F0nWc=
X-Google-Smtp-Source: ABdhPJyZTfpQ8jYtMKY79OrGOGao+4oxhbywW0VQDx6GovzdhkwiU9ahZBONec3TPMItwXQto1I2d87e7lytDgcst50=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr3527869ioj.72.1616492158239;
 Tue, 23 Mar 2021 02:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com> <20210323072607.GF63242@dread.disaster.area>
In-Reply-To: <20210323072607.GF63242@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Mar 2021 11:35:46 +0200
Message-ID: <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
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

On Tue, Mar 23, 2021 at 9:26 AM Dave Chinner <david@fromorbit.com> wrote:
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
>
> So why change the code then? If it ain't broke, don't fix it...
>

Fair enough. I am asking a "nice to have" change.
I will try to explain why.

[...]

> > I am trying to understand your objection to making this "friendly" change.
>
> "friendly" isn't a useful way to describe whether a change is
> desirable of whether code works correctly or not. If it's broken or
> not fit for purpose, it doesn't matter how "friendly" it might be -
> it's still broken...
>
> I'm asking why using a device encoding is a problem, because
> it will not change across mount/unmount cycles as the backing device
> doesn't change. It *may* change across reboots, but then what does
> fanotify care about in that case? Something has to re-establish all
> watches from scratch at that point, so who cares if the fsid has
> changed?
>

This is correct.
First of all, we need to acknowledge that the fanotify FAN_REPORT_FID
interface was introduced in kernel v5.1 and I don't know of any specific
users and how future users will be using it.

> So what problem is "persistence" across reboots solving?  You say
> it's "friendly" but that has no technical definition I know of....
>

For most use cases, getting a unique fsid that is not "persistent"
would be fine. Many use case will probably be watching a single
filesystem and then the value of fsid in the event doesn't matter at all.

If, however, at some point in the future, someone were to write
a listener that stores events in a persistent queue for later processing
it would be more "convenient" if fsid values were "persistent".

I'm sorry, but it's hard for me to describe a property of fsid that is
nice-to-have without using "convenient" and "friendly" terminology.

Technically, there is a way for userland to get the same outcome
without making this change in XFS, but I suspect it's not going to
be important enough for anyone to care and the end result would
be that the end users will suffer unpredicted behavior.

> > > i.e. it's use is entirely isolated to
> > > the file handle interface for identifying the filesystem the handle
> > > belongs to. This is messy, but XFS inherited this "fixed fsid"
> > > interface from Irix filehandles and was needed to port
> > > xfsdump/xfsrestore to Linux.  Realistically, it is not functionality
> > > that should be duplicated/exposed more widely on Linux...
> >
> > Other filesystems expose a uuid digest as f_fsid: ext4, btrfs, ocfs2
> > and many more. XFS is really the exception among the big local fs.
> > This is not exposing anything new at all.
>
> I'm not suggesting that it is. I'm asking you to explain what the
> problem it solves is so I have the context necessary to evaluate the
> impact of making such a userspace visible change might be....
>

I understand.
As I tried to explain, this change does not solve any clear and immediate
problem. I hope I was able to explain why it might be beneficial.

[...]

> > > However, changing the uuid on XFS is an offline (unmounted)
> > > operation, so there will be no fanotify marks present when it is
> > > changed. Hence when it is remounted, there will be a new f_fsid
> > > returned in statvfs(), just like what happens now, and all
> > > applications dependent on "persistent" fsids (and persistent
> > > filehandles for that matter) will now get ESTALE errors...
> > >
> > > And, worse, mp->m_fixed_fsid (and XFS superblock UUIDs in general)
> > > are not unique if you've got snapshots and they've been mounted via
> > > "-o nouuid" to avoid XFS's duplicate uuid checking. This is one of
> > > the reasons that the duplicate checking exists - so that fshandles
> > > are unique and resolve to a single filesystem....
> >
> > Both of the caveats of uuid you mentioned are not a big concern for
> > fanotify because the nature of f_fsid can be understood by the event
> > listener before setting the multi-fs watch (i.e. in case of fsid collision).
>
> Sorry, I don't understand what "the nature of f_fsid can be
> understood" means. What meaning are you trying to infer from 8 bytes
> of opaque data in f_fsid?
>

When the program is requested to watch multiple filesystems, it starts by
querying their fsid. In case of an fsid collision, the program knows that it
will not be able to tell which filesystem the event originated in, so the
program can print a descriptive error to the user.

[...]

> > The fanotify uapi guarantee is to provide the same value of f_fsid
> > observed by statfs() uapi. The statfs() uapi guarantee about f_fsid is
> > a bit vague, but it's good enough for our needs:
> >
> > "...The  general idea is that f_fsid contains some random stuff such that the
> >  pair (f_fsid,ino) uniquely determines a file.  Some operating systems use
> >  (a variation on) the device number, or the device number combined with the
> >  filesystem type..."
>
> Mixed messaging!
>
> You start by saying "f_fsid needs persistence", then say "it doesn't
> need persistence, then say "device number based f_fsid is
> sub-optimal", then saying "the statfs() defined f_fsid is good
> enough" despite the fact is says "(a variation on) the device
> number" is a documented way of implementing it and you've said that
> is sub-optimal.
>
> I''ve got no clue what fanotify wants or needs from f_fsid now.
>

fanotify has two requirements for f_fsid and they are both met for XFS.
From fanotify_mark.2:
"      ENODEV The  filesystem object indicated by pathname is not
              associated with a filesystem that supports fsid (e.g., tmpfs(5)).
...
       EXDEV  The  filesystem  object  indicated by pathname resides
              within a filesystem subvolume (e.g., btrfs(5)) which
uses a different
              fsid than its root superblock.
"

The reason I am proposing this change in XFS is not for the needs of
fanotify itself for the needs of its future downstream users.
We could defer the decision of making this change to that future time
when and if users start complaining.
XFS is certainly not the only filesystem that might need this sort of change
to f_fsid.

> > Regardless of the fanotify uapi and whether it's good or bad, do you insist
> > that the value of f_fsid exposed by xfs needs to be the bdev number and
> > not derived from uuid?
>
> I'm not insisting that it needs to be the bdev number. I'm trying to
> understand why it needs to be changed, what the impact of that
> change is and whether there are other alternatives before I form an
> opinion on whether we should make this user visible filesystem
> identifier change or not...
>
> > One thing we could do is in the "-o nouuid" case that you mentioned
> > we continue to use the bdev number for f_fsid.
> > Would you like me to make that change?
>
> No, I need to you stop rushing around in a hurry to change code and
> assuming that everyone knows every little detail of fanotify and the
> problems that need to be solved. Slow down and explain clearly and
> concisely why f_fsid needs to be persistent, how it gets used to
> optimise <something> when it is persistent, and what the impact of
> it not being persistent is.
>

Fair enough.
I'm in a position of disadvantage having no real users to request this change.
XFS is certainly "not broken", so the argument for "not fixing" it is valid.

Nevertheless bdev can change on modern systems even without reboot
for example for loop mounted images, so please consider investing the time
in forming an opinion about making this change for the sake of making f_fsid
more meaningful for any caller of statfs(2) not only for fanotify listeners.

Leaving fanotify out of the picture, the question that the prospect user is
trying answer is:
"Is the object at $PATH or at $FD the same object that was observed at
 'an earlier time'?"

With XFS, that question can be answered (< 100% certainty)
using the XFS_IOC_PATH_TO_FSHANDLE interface.

name_to_handle_at(2) + statfs(2) is a generic interface that provides
this answer with less certainty, but it could provide the answer
with the same certainty for XFS.

Thanks,
Amir.
