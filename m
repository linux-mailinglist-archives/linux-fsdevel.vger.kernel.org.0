Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126A93F14E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhHSIMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhHSIMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:12:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C41C061756;
        Thu, 19 Aug 2021 01:01:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h29so5088395ila.2;
        Thu, 19 Aug 2021 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IN0x5iXYABQqCMHt+Nn8KkV49otQhc88Nzl1ZF5H8xg=;
        b=mLswoyqw9ob+OuFlNXU8eZvLATUYoM7nI44L1MJqQp+ZaSLxO0oA+XxvV1njKbMdWW
         TA6rRrg5lNpiz9ZIaT75O6ci/kAHkGmyiMkvOoav2l2P/lU6BC9e39NdjVq1cRXODNTp
         mjufyJ3vGIXgB0LPC7nrY49BvbK0C7nGkh4qOq1mPbH5FVKVfIeYdhvuVUi6CnSfq5Ni
         1r/FumdhHq0BEeF9QDcylrq3gH1hjSxuEekI0huscOBJHqQ8XZfpI403JrMHvNJyPFc4
         0/TVrfJTCDJItApseS9gqDOcc49xiCzdKR5krGAgqi/47LxPmW4jfPPgNNmJvzfqO5yH
         2smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IN0x5iXYABQqCMHt+Nn8KkV49otQhc88Nzl1ZF5H8xg=;
        b=d7kwh8QpRieUMnUtb7GpY5Lv7xq7atsN2qZrWDo8bNPJc3OtBnrs95HSf7Drndpetc
         IOZbXD6ssImVWqH5au1QsEZtXFrafFo73DARw5TBbBMrRC4PFRrhnC2WPLg8WgMfYU3p
         +lPeDkmI/AYgJpJVehDDu7cIqWFmMcF35EwmQb6P2+nT9gGHY02AXxl3WwtlXQLQk+4L
         6w4adn8A8UaHfDr74CfQbQk19tFL59of/eC5nZp5KPrAi1FDv+bBpamiUhb3P/gL6CSP
         L71WvxS4NcHC8HFJFw5uNGbEK6bio0Kh2MMsP71zrBM68YBJnRS4MdI0DUM6xJzUc1rF
         ac1w==
X-Gm-Message-State: AOAM533fs0kfp0uNSrZovrEf17ZkDfmGeSzZT1Po1+7RUU91Of7F8V4p
        V1gfztWCuvp3LIpeiBgKEXiC1B03VCq5bsMUewU=
X-Google-Smtp-Source: ABdhPJzFzm9SyC4CH5KGlm52Jk3sfaAfKHKIOm8vAD69W4xJpldNwNhi9JeeohtotpJs4dtHomw/pJj60XSdolwvDbg=
X-Received: by 2002:a92:8702:: with SMTP id m2mr9393019ild.250.1629360107809;
 Thu, 19 Aug 2021 01:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it> <20210816003505.7b3e9861@natsu>
 <162906585094.1695.15815972140753474778@noble.neil.brown.name>
In-Reply-To: <162906585094.1695.15815972140753474778@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 Aug 2021 11:01:36 +0300
Message-ID: <CAOQ4uxiry7HcRtqY3DehNi4_PTLjxN0uMrw-oYcX9TgehC6m6w@mail.gmail.com>
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Goffredo Baroncelli <kreijack@libero.it>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 1:21 AM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 16 Aug 2021, Roman Mamedov wrote:
> >
> > I wondered a bit myself, what are the downsides of just doing the
> > uniquefication inside Btrfs, not leaving that to NFSD?
> >
> > I mean not even adding the extra stat field, just return the inode itself with
> > that already applied. Surely cannot be any worse collision-wise, than
> > different subvolumes straight up having the same inode numbers as right now?
> >
> > Or is it a performance concern, always doing more work, for something which
> > only NFSD has needed so far.
>
> Any change in behaviour will have unexpected consequences.  I think the
> btrfs maintainers perspective is they they don't want to change
> behaviour if they don't have to (which is reasonable) and that currently
> they don't have to (which probably means that users aren't complaining
> loudly enough).
>
> NFS export of BTRFS is already demonstrably broken and users are
> complaining loudly enough that I can hear them ....  though I think it
> has been broken like this for 10 years, do I wonder that I didn't hear
> them before.
>
> If something is perceived as broken, then a behaviour change that
> appears to fix it is more easily accepted.
>
> However, having said that I now see that my latest patch is not ideal.
> It changes the inode numbers associated with filehandles of objects in
> the non-root subvolume.  This will cause the Linux NFS client to treat
> the object as 'stale' For most objects this is a transient annoyance.
> Reopen the file or restart the process and all should be well again.
> However if the inode number of the mount point changes, you will need to
> unmount and remount.  That is more somewhat more of an annoyance.
>
> There are a few ways to handle this more gracefully.
>
> 1/ We could get btrfs to hand out new filehandles as well as new inode
> numbers, but still accept the old filehandles.  Then we could make the
> inode number reported be based on the filehandle.  This would be nearly
> seamless but rather clumsy to code.  I'm not *very* keen on this idea,
> but it is worth keeping in mind.
>

So objects would change their inode number after nfs inode cache is
evicted and while nfs filesystem is mounted. That does not sound ideal.

But I am a bit confused about the problem.
If the export is of the btrfs root, then nfs client cannot access any
subvolumes (right?) - that was the bug report, so the value of inode
numbers in non-root subvolumes is not an issue.
If export is of non-root subvolume, then why bother changing anything
at all? Is there a need to traverse into sub-sub-volumes?

> 2/ We could add a btrfs mount option to control whether the uniquifier
> was set or not.  This would allow the sysadmin to choose when to manage
> any breakage.  I think this is my preference, but Josef has declared an
> aversion to mount options.
>
> 3/ We could add a module parameter to nfsd to control whether the
> uniquifier is merged in.  This again gives the sysadmin control, and it
> can be done despite any aversion from btrfs maintainers.  But I'd need
> to overcome any aversion from the nfsd maintainers, and I don't know how
> strong that would be yet. (A new export option isn't really appropriate.
> It is much more work to add an export option than the add a mount option).
>

That is too bad, because IMO from users POV, "fsid=btrfsroot" or "cross-subvol"
export option would have been a nice way to describe and opt-in to this new
functionality.

But let's consider for a moment the consequences of enabling this functionality
automatically whenever exporting a btrfs root volume without "crossmnt":

1. Objects inside a subvol that are inaccessible(?) with current
nfs/nfsd without
    "crossmnt" will become accessible after enabling the feature -
this will match
    the user experience of accessing btrfs on the host
2. The inode numbers of the newly accessible objects would not match the inode
    numbers on the host fs (no big deal?)
3. The inode numbers of objects in a snapshot would not match the inode
    numbers of the original (pre-snapshot) objects (acceptable tradeoff for
    being able to access the snapshot objects without bloating /proc/mounts?)
4. The inode numbers of objects in a subvol observed via this "cross-subvol"
    export would not match the inode numbers of the same objects observed
    via an individual subvol export
5. st_ino conflicts are possible when multiplexing subvol id and inode number.
    overlayfs resolved those conflicts by allocating an inode number from a
    reserved non-persistent inode range, which may cause objects to change
    their inode number during the lifetime on the filesystem (sensible
tradeoff?)

I think that #4 is a bit hard to swallow and #3 is borderline acceptable...
Both and quite hard to document and to set expectations as a non-opt-in
change of behavior when exporting btrfs root.

IMO, an nfsd module parameter will give some control and therefore is
a must, but it won't make life easier to document and set user expectations
when the semantics are not clearly stated in the exports table.

You claim that "A new export option isn't really appropriate."
but your only argument is that "It is much more work to add
an export option than the add a mount option".

With all due respect, for this particular challenge with all the
constraints involved, this sounds like a pretty weak argument.

Surely, adding an export option is easier than slowly changing all
userspace tools to understand subvolumes? a solution that you had
previously brought up.

Can you elaborate some more about your aversion to a new
export option.

Thanks,
Amir.
