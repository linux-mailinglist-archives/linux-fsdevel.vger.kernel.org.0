Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED571FA28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 08:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjFBGfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 02:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjFBGfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:35:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1919B
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 23:35:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a3f2668bdso1475864b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685687703; x=1688279703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evv0p0jC9oWWE82j0Pi+vATS1PKj6ZNQklO5GUBE0bQ=;
        b=iiXnWri5a9H6k8MusPs25woba4yt8acCAmjG9gGDd1Z3PrhPJrwf6og8R4hYRBH0eI
         iPSrij4qdB7ZsrR0j0IhR+e6jN3cwua0IdTW3r/8iURI66DvUridbPfN0hRGDYTHaToG
         VXiw+uaNDNVWlbI8p0pFqljCi/YxNVlNehXUhP4yiJnPT8de6uV1tnl1M5dEEgOJeMM+
         g5pkiUbPbeYdaDyESPPTFrDCbxaldGtsemtIowXd0ydVsVQve14YrTk9+mw4Twr5TAfz
         IU1/B2BkvqS4pnWIRfp+l3/rMvxsb4e8pC+GtE/bbuHy6pghbtDIpMauWpV59kMzunhB
         YR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685687703; x=1688279703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evv0p0jC9oWWE82j0Pi+vATS1PKj6ZNQklO5GUBE0bQ=;
        b=d5ZvikiZVenBQwp8dcwmz7fuDi+jXMGmbuytxt+FXEUHue5l5ZYi3PENF1cc6KEa9m
         Zyn8cNegukuGCcxcct95oH6pQq7r1IW6WzI7DWwq7d36pwuMQamMqkZqgP0MjFkwdxP/
         CGr+M9GjL/E5cVSl1xqlez1kWWaGq4I/opUxLPlQmeixpONCYplOTfr43LYbHa+a+kRc
         Uiqpgit1/+UTipRg6jzbk2qA4YRstpI5nC7O0Ee0QTQ6BD3ZY7/O/NWE54e2hIBEdjak
         SGgjE7q9q1kUuzKpQsIULmETxvv12J6TqeGkPQiZJOXfV0j05m0c2P6+9M9YIkW2KeQX
         PGAQ==
X-Gm-Message-State: AC+VfDzz6QVi0vy9qK16ezqrvy8TCgc52HintavE+4Vw3OopuR86s9GL
        7mfVwrf99WrGN/8mtKBlFu7rZg==
X-Google-Smtp-Source: ACHHUZ7dZEAxZ89U7y2em5IvNF7j4SacnZfso27jZ1sEutC0UYXa0vN78sezwFFYW1aWz022UzE0eA==
X-Received: by 2002:a05:6808:c4:b0:399:de83:96f2 with SMTP id t4-20020a05680800c400b00399de8396f2mr1674539oic.8.1685687702894;
        Thu, 01 Jun 2023 23:35:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b001a95c7742bbsm514138plb.9.2023.06.01.23.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:35:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4yNG-006o3F-2y;
        Fri, 02 Jun 2023 16:34:58 +1000
Date:   Fri, 2 Jun 2023 16:34:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <ZHmNksPcA9tudSVQ@dread.disaster.area>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602042714.GE1128744@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:27:14AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> > Someone ought to cc Ted since I asked him about this topic this morning
> > and he said he hadn't noticed it going by...
> > 
> > > > > In addition the uuid should be set when the filesystem is mounted.
> > > > > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > > > > change the uuid.
> > > > 
> > > > IMO, that ext4 functionality is a landmine waiting to be stepped on.
> > > > 
> > > > We should not be changing the sb->s_uuid of filesysetms dynamically.
> > > 
> > > Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> > > ioctl then this is fine though.
> > 
> > Now that Dave's brought up all kinds of questions about other parts of
> > the kernel using s_uuid for things, I'm starting to think that even ext4
> > shouldn't be changing its own uuid on the fly.
> 
> So let's set some context here.  The tune2fs program in e2fsprogs has
> supported changing the UUID for a *very* long time.  Specifically,
> since September 7, 1996 (e2fsprogs version 1.05, when we first added
> the UUID field in the ext2 superblock).

Yup, and XFS has supported offline changing of the UUID a couple of
years before that.

> This feature was added from
> the very beginning since in Large Installation System Administration
> (LISA) systems, a very common thing to do is to image boot disks from
> a "golden master", and then afterwards, you want to make sure the file
> systems on each boot disk have a unique UUID; and this is done via
> "tune2fs -U random /dev/sdXX".  Since I was working at MIT Project
> Athena at the time, we regularly did this when installing Athena
> client workstations, and when I added UUID support to ext2, I made
> sure this feature was well-supported.

See xfs_copy(8). This was a tool originally written, IIRC, in early
1995 for physically cloning sparse golden images in the SGI factory
production line. It was multi-threaded and could write up to 16 scsi
disks at once with a single ascending LBA order pass. The last thing
it does is change the UUID of each clone to make them unique.

There's nothing new here - this is all 30 years ago, and we've had
tools changing filesystems UUIDs for all this time.

> The tune2fs program allows the UUID to be changed via the file system
> is mounted (with some caveats), which it did by directly modifying the
> on-disk superblock.  Obviously, when it did that, it wouldn't change
> sb->s_uuid "dynamically", although the next time the file system was
> mounted, sb->s_uuid would get the new UUID.

Yes, which means for userspace and most of the kernel it's no
different to "unmount, change UUID, mount". It's effectively an
offline change, even if the on-disk superblock is changed while the
filesystem is mounted.

> If overlayfs and IMA are
> expecting that a file system's UUID would stay consant and persistent
> --- well, that's not true, and it has always been that way, since
> there are tools that make it trivially easy for a system administrator
> to adjust the UUID.

Yes, but that's not the point I've been making. My point is that the
*online change of sb->s_uuid* that was being proposed for the
XFS/generic variant of the ext4 online UUID change ioctl is
completely new, and that's where all the problems start....

> In addition to the LISA context, this feature is also commonly used in
> various cloud deployments, since when you create a new VM, it
> typically gets a new root file system, which is copied from a fixed,
> read-only image.  So on a particular hyperscale cloud system, if we
> didn't do anything special, there could be hundreds of thousands VM's
> whose root file system would all have the same UUID, which would mean
> that the UUID... isn't terribly unique.

Again, nothing new here - we've been using snapshots/clones/reflinks
for efficient VM storage provisioning for well over 15 years now.

.....

> This is the reason why we added the ext4 ioctl; it was intended for
> the express use of "tune2fs -U", and like tune2fs -U, it doesn't
> actually change sb->s_uuid; it only changes the on-disk superblock's
> UUID.  This was mostly because we forgot about sb->s_uuid, to be
> honest, but it means that regardless of whether "tune2fs -U" directly
> modifies the block device, or uses the ext4 ioctl, the behaviour with
> respect to sb->s_uuid is the same; it's not modified when the on-disk
> uuid is changed.

IOWs, not only was the ext4 functionality was poorly thought out, it
was *poorly implemented*.

So, let's take a step back here - we've done the use case thing to
death now - and consider what is it we actually need here?

All we need for the hyperscale/VM provisioning use case is for the
the UUID to be changed at first boot/mount time before anything else
happens.

So why do we need userspace to be involved in that? Indeed,
all the problems stem from needing to have userspace change the
UUID.

There's an obvious solution: a newly provisioned filesystem needs to
change the uuid at first mount. The only issue is the
kernel/filesystem doesn't know when the first mount is.

Darrick suggested "mount -o setuuid=xxxx" on #xfs earlier, but that
requires changing userspace init stuff and, well, I hate single use
case mount options like this.

However, we have a golden image that every client image is cloned
from. Say we set a special feature bit in that golden image that
means "need UUID regeneration". Then on the first mount of the
cloned image after provisioning, the filesystem sees the bit and
automatically regenerates the UUID with needing any help from
userspace at all.

Problem solved, yes? We don't need userspace to change the uuid on
first boot of the newly provisioned VM - the filesystem just makes
it happen.

If the "first run" init scripts are set up to run blkid to grab the
new uuid after mount and update whatever needs to be updated with
the new root filesystem UUID, then we've moved the entire problem
out of the VM boot path and back into the provisioning system where
it should be.

And then we don't need an ioctl to change UUIDs online, nor do we
require the VFS, kernel subsystems, userspace infrastructure and
applications to be capable of handling the UUID of a mounted
filesystem changing without warning....

> > > > The VFS does not guarantee in any way that it is safe to change the
> > > > sb->s_uuid (i.e. no locking, no change notifications, no udev
> > > > events, etc). Various subsystems - both in the kernel and in
> > > > userspace - use the sb->s_uuid as a canonical and/or persistent
> > > > filesystem/device identifier and are unprepared to have it change
> > > > while the filesystem is mounted and active.
> 
> Note that the last sentence is a bit ambiguous.

Well, yes, because while the UUID is normally persistent, if the
administrator chooses to modify the UUID while the filesystem is
unmounted, it will change between mounts.  In that case.....

> There is the question
> of whether sb->s_uuid won't change while the file system is mounted,
> and then there is the question of whether s_uuid is **persistent**
> ---- which is to say, that it won't change across mounts or reboots.
>
> If there are subsystems like IMA, overlayfs, pnfs, et.al, which expect
> that, I'm sorry, but sysadmin tools to make it trivially easy to
> change the file system UUID long-predate these other subsystems, and
> there *are* system adminsitrators --- particularly in the LISA or
> Cloud context --- which have used "tune2fs -U" for good and proper
> reasons.

.... it's on the sysadmins to understand they need to regenerate
anything that is reliant on the old filesystem UUIDs before mounting
the filesystem again to avoid these issues...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
