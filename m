Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BC3F85C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbhHZKpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhHZKpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:45:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B398C061757;
        Thu, 26 Aug 2021 03:45:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g9so3065749ioq.11;
        Thu, 26 Aug 2021 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtLOFPzOghHcrNhMJ5t9QBSZRabZGwdTrUsmXVKi/aQ=;
        b=mgZWH+/NU+blPH67GdRxV+ADZQmsbGSu8as7mWEH8b1Z0dfZscbwGMG/OjyKW5/VWF
         eiVZdNqHhYP/PN1ShHCW72vNiRQypX7/bB2aNwx1qZwazISVMIUelsx3EEwHnixXilTg
         gmrIpj/7qpVMz2fQuYLfV7pNDWjPm5yFoOgbFveesQbiQKKHJzctKLemBvlbUx5lcVRm
         2wLVonQ8TRVhY/bCDSP+yNuWukgFWhak1F/fmD3mM2tp0qdZdZkWS/TlCd0CCtJG6DiJ
         lmqnsyGtEW26WV7yZMuyapPdwos8nf3BWgMhgHlQeURR55b8qsOeBok94I/TO/XBh3T+
         PLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtLOFPzOghHcrNhMJ5t9QBSZRabZGwdTrUsmXVKi/aQ=;
        b=m6y820fRl7rUxIQsj3a3PZT/rUrq5DmMjmb8UTd2xtnSpxPlAuHZtLAUlvbqa0PZef
         5UgE5CNa8yQqA48bNRzetXqdcjKjr0rM1a/oRh10TyKGsSYwh/5CcuOVCNFdvY1/EgNX
         y98W1NHCACbA1FzO74t4PGE3nKQmA6V0AOUnXY3ftkR/jE5h7Wc1kqRrGh+BxTxUUIaq
         dh8q5TrDLwxaEMLx5Vh/YK7BbuA5VJPg2o4rx5/2tR7e4SH3zEbyD9MEWoTXkXqGAQh1
         G7Fi5azwMhBZmtem8fyZe1ABvwt0vemgleC/LsKOSG6w2N85HDMe/Ki/cDm3XAk2rpWJ
         C1Ag==
X-Gm-Message-State: AOAM5309YHjN5kLzFn0MGhXEYhmCwM8FDc5NTclRiYp0x4CTfnQZnBwp
        3QoPpYwfBOnRQvDwAs0kKq51zXVsJ/z3gprDBLN/jGpDISo=
X-Google-Smtp-Source: ABdhPJwaQtOZ2tDRmLn6gvFoHDSC5IFv7PNZLoC1Kdy7kxBHxCDPw/5FZMf0QUQ/qiwxXh85IZVLY53UjylWwVVTcE0=
X-Received: by 2002:a6b:8b54:: with SMTP id n81mr2451815iod.5.1629974701651;
 Thu, 26 Aug 2021 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-10-krisman@collabora.com> <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
 <87tujdz7u7.fsf@collabora.com> <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
 <87mtp5yz0q.fsf@collabora.com>
In-Reply-To: <87mtp5yz0q.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Aug 2021 13:44:50 +0300
Message-ID: <CAOQ4uxjnb0JmKVpMuEfa_NgHmLRchLz_3=9t2nepdS4QXJ=QVg@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty inode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:50 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Wed, Aug 25, 2021 at 9:40 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Amir Goldstein <amir73il@gmail.com> writes:
> >>
> >> > On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> >> > <krisman@collabora.com> wrote:
> >> >>
> >> >> Some file system events (i.e. FS_ERROR) might not be associated with an
> >> >> inode.  For these, it makes sense to associate them directly with the
> >> >> super block of the file system they apply to.  This patch allows the
> >> >> event to be reported with a NULL inode, by recovering the superblock
> >> >> directly from the data field, if needed.
> >> >>
> >> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> >>
> >> >> --
> >> >> Changes since v5:
> >> >>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> >> >> ---
> >> >>  fs/notify/fsnotify.c | 16 +++++++++++++---
> >> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >> >>
> >> >> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> >> >> index 30d422b8c0fc..536db02cb26e 100644
> >> >> --- a/fs/notify/fsnotify.c
> >> >> +++ b/fs/notify/fsnotify.c
> >> >> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
> >> >>         fsnotify_clear_marks_by_sb(sb);
> >> >>  }
> >> >>
> >> >> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
> >> >> +{
> >> >> +       struct inode *inode = fsnotify_data_inode(data, data_type);
> >> >> +       struct super_block *sb = inode ? inode->i_sb : NULL;
> >> >> +
> >> >> +       return sb;
> >> >> +}
> >> >> +
> >> >>  /*
> >> >>   * Given an inode, first check if we care what happens to our children.  Inotify
> >> >>   * and dnotify both tell their parents about events.  If we care about any event
> >> >> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> >> >>   *             @file_name is relative to
> >> >>   * @file_name: optional file name associated with event
> >> >>   * @inode:     optional inode associated with event -
> >> >> - *             either @dir or @inode must be non-NULL.
> >> >> - *             if both are non-NULL event may be reported to both.
> >> >> + *             If @dir and @inode are NULL, @data must have a type that
> >> >> + *             allows retrieving the file system associated with this
> >> >
> >> > Irrelevant comment. sb must always be available from @data.
> >> >
> >> >> + *             event.  if both are non-NULL event may be reported to
> >> >> + *             both.
> >> >>   * @cookie:    inotify rename cookie
> >> >>   */
> >> >>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> >> >> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> >> >>                  */
> >> >>                 parent = dir;
> >> >>         }
> >> >> -       sb = inode->i_sb;
> >> >> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
> >> >
> >> >         const struct path *path = fsnotify_data_path(data, data_type);
> >> > +       const struct super_block *sb = fsnotify_data_sb(data, data_type);
> >> >
> >> > All the games with @data @inode and @dir args are irrelevant to this.
> >> > sb should always be available from @data and it does not matter
> >> > if fsnotify_data_inode() is the same as @inode, @dir or neither.
> >> > All those inodes are anyway on the same sb.
> >>
> >> Hi Amir,
> >>
> >> I think this is actually necessary.  I could identify at least one event
> >> (FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
> >> In that case, fsnotify_dirent is called with a negative dentry from
> >> vfs_mkdir().  I'm not sure why exactly the dentry is negative after the
> >
> > That doesn't sound right at all.
> > Are you sure about this?
> > Which filesystem was this mkdir called on?
>
> You should be able to reproduce it on top of mainline if you pick only this
> patch and do the change you suggested:
>
>  -       sb = inode->i_sb;
>  +       sb = fsnotify_data_sb(data, data_type);
>
> And then boot a Debian stable with systemd.  The notification happens on
> the cgroup pseudo-filesystem (/sys/fs/cgroup), which is being monitored
> by systemd itself.  The event that arrives with a NULL data is telling the
> directory /sys/fs/cgroup/*/ about the creation of directory
> `init.scope`.
>
> The change above triggers the following null dereference of struct
> super_block, since data is NULL.
>
> I will keep looking but you might be able to answer it immediately...

Yes, I see what is going on.

cgroupfs is a sort of kernfs and kernfs_iop_mkdir() does not instantiate
the negative dentry. Instead, kernfs_dop_revalidate() always invalidates
negative dentries to force re-lookup to find the inode.

Documentation/filesystems/vfs.rst says on create() and friends:
"...you will probably call d_instantiate() with the dentry and the
  newly created inode..."

So this behavior seems legit.
Meaning that we have made a wrong assumption in fsnotify_create()
and fsnotify_mkdir().
Please note the comment above fsnotify_link() which anticipates
negative dentries.

I've audited the fsnotify backends and it seems that the
WARN_ON(!inode) in kernel/audit_* is the only immediate implication
of negative dentry with FS_CREATE.
I am the one who added these WARN_ON(), so I will remove them.
I think that missing inode in an FS_CREATE event really breaks
audit on kernfs, but not sure if that is a valid use case (Paul?).

Anyway, regarding your patch, I still prefer the solution proposed by Jan,
but not with a different implementation of fsnotify_data_sb().

Please see branch fsnotify_data_sb[1] with the proposed fixes.
The fixes assert the statement that "sb should always be available
from @data", regardless of kernfs anomaly.

If this works for you, please prepend those patches to your next
submission.

Regarding the state of this patch set in general, I must admit that
I wasn't able to follow if a conclusion was reached about the lifetime
management of fsnotify_error_event and associated sb mark.
Jan is going out on vacation and I think there is little point in spinning
another patch set revision before this issue is settled with Jan.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify_data_sb
