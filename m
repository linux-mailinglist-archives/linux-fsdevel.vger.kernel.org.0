Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC1720644
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjFBPe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjFBPeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E08818D;
        Fri,  2 Jun 2023 08:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9F46176B;
        Fri,  2 Jun 2023 15:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F94C433EF;
        Fri,  2 Jun 2023 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685720062;
        bh=GMAXWhUtWZYqSwvxZZhgRN+BhNtQO7FUSE/tbmymCbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6geL/fTEH8z9TyfMjGmhcf0RwxRmchaTHsURljpqSObVsOkV3ShNO7YsvWsAHVZP
         RissC8tRgym/IpG3qfBUB4AjbWmWUqYBtZvG2W45qxH+QFvKrhzNY6KCx9VzradVwW
         LKEMV6CxiRXiQ4PrhONYygzyVoyX8vUC6Y9ekNZbyxVM8miLzzjnfvAc8OgSclwA6W
         bplEFKFk9NHNldReJ/l004PXXDquMaDo/hSyau9YAv57Xe9hFxT0OZ72b+90SCwR3Q
         TVKu8VH1Tn4QHYBopyimIQqtYtrKKOJYpejqSFKG+LLD2iNkjUKPuF3mqCwYUmOWx6
         kFHtigDU3chCQ==
Date:   Fri, 2 Jun 2023 17:34:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602-freischaffend-sorgenfrei-adb9fae43a84@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
 <20230602-dividende-model-62b2bdc073cf@brauner>
 <20230602142329.GC16848@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602142329.GC16848@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:23:29AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 02, 2023 at 03:52:16PM +0200, Christian Brauner wrote:
> > On Fri, Jun 02, 2023 at 04:34:58PM +1000, Dave Chinner wrote:
> > > On Fri, Jun 02, 2023 at 12:27:14AM -0400, Theodore Ts'o wrote:
> > > > On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> > > > > Someone ought to cc Ted since I asked him about this topic this morning
> > > > > and he said he hadn't noticed it going by...
> > > > > 
> > > > > > > > In addition the uuid should be set when the filesystem is mounted.
> > > > > > > > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > > > > > > > change the uuid.
> > > > > > > 
> > > > > > > IMO, that ext4 functionality is a landmine waiting to be stepped on.
> > > > > > > 
> > > > > > > We should not be changing the sb->s_uuid of filesysetms dynamically.
> > > > > > 
> > > > > > Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> > > > > > ioctl then this is fine though.
> > > > > 
> > > > > Now that Dave's brought up all kinds of questions about other parts of
> > > > > the kernel using s_uuid for things, I'm starting to think that even ext4
> > > > > shouldn't be changing its own uuid on the fly.
> > > > 
> > > > So let's set some context here.  The tune2fs program in e2fsprogs has
> > > > supported changing the UUID for a *very* long time.  Specifically,
> > > > since September 7, 1996 (e2fsprogs version 1.05, when we first added
> > > > the UUID field in the ext2 superblock).
> > > 
> > > Yup, and XFS has supported offline changing of the UUID a couple of
> > > years before that.
> > > 
> > > > This feature was added from
> > > > the very beginning since in Large Installation System Administration
> > > > (LISA) systems, a very common thing to do is to image boot disks from
> > > > a "golden master", and then afterwards, you want to make sure the file
> > > > systems on each boot disk have a unique UUID; and this is done via
> > > > "tune2fs -U random /dev/sdXX".  Since I was working at MIT Project
> > > > Athena at the time, we regularly did this when installing Athena
> > > > client workstations, and when I added UUID support to ext2, I made
> > > > sure this feature was well-supported.
> > > 
> > > See xfs_copy(8). This was a tool originally written, IIRC, in early
> > > 1995 for physically cloning sparse golden images in the SGI factory
> > > production line. It was multi-threaded and could write up to 16 scsi
> > > disks at once with a single ascending LBA order pass. The last thing
> > > it does is change the UUID of each clone to make them unique.
> > > 
> > > There's nothing new here - this is all 30 years ago, and we've had
> > > tools changing filesystems UUIDs for all this time.
> > > 
> > > > The tune2fs program allows the UUID to be changed via the file system
> > > > is mounted (with some caveats), which it did by directly modifying the
> > > > on-disk superblock.  Obviously, when it did that, it wouldn't change
> > > > sb->s_uuid "dynamically", although the next time the file system was
> > > > mounted, sb->s_uuid would get the new UUID.
> > > 
> > > Yes, which means for userspace and most of the kernel it's no
> > > different to "unmount, change UUID, mount". It's effectively an
> > > offline change, even if the on-disk superblock is changed while the
> > > filesystem is mounted.
> > > 
> > > > If overlayfs and IMA are
> > > > expecting that a file system's UUID would stay consant and persistent
> > > > --- well, that's not true, and it has always been that way, since
> > > > there are tools that make it trivially easy for a system administrator
> > > > to adjust the UUID.
> > > 
> > > Yes, but that's not the point I've been making. My point is that the
> > > *online change of sb->s_uuid* that was being proposed for the
> > > XFS/generic variant of the ext4 online UUID change ioctl is
> > > completely new, and that's where all the problems start....
> > > 
> > > > In addition to the LISA context, this feature is also commonly used in
> > > > various cloud deployments, since when you create a new VM, it
> > > > typically gets a new root file system, which is copied from a fixed,
> > > > read-only image.  So on a particular hyperscale cloud system, if we
> > > > didn't do anything special, there could be hundreds of thousands VM's
> > > > whose root file system would all have the same UUID, which would mean
> > > > that the UUID... isn't terribly unique.
> > > 
> > > Again, nothing new here - we've been using snapshots/clones/reflinks
> > > for efficient VM storage provisioning for well over 15 years now.
> > > 
> > > .....
> > > 
> > > > This is the reason why we added the ext4 ioctl; it was intended for
> > > > the express use of "tune2fs -U", and like tune2fs -U, it doesn't
> > > > actually change sb->s_uuid; it only changes the on-disk superblock's
> > > > UUID.  This was mostly because we forgot about sb->s_uuid, to be
> > > > honest, but it means that regardless of whether "tune2fs -U" directly
> > > > modifies the block device, or uses the ext4 ioctl, the behaviour with
> > > > respect to sb->s_uuid is the same; it's not modified when the on-disk
> > > > uuid is changed.
> 
> ...which means that anyone writing out non-ext4 ondisk metadata will now
> be doing it with a stale fsuuid.  Er... that might just be an ext*
> quirk that everyone will have to live with.
> 
> > > IOWs, not only was the ext4 functionality was poorly thought out, it
> > > was *poorly implemented*.
> > > 
> > > So, let's take a step back here - we've done the use case thing to
> > > death now - and consider what is it we actually need here?
> > > 
> > > All we need for the hyperscale/VM provisioning use case is for the
> > > the UUID to be changed at first boot/mount time before anything else
> > > happens.
> > > 
> > > So why do we need userspace to be involved in that? Indeed,
> > > all the problems stem from needing to have userspace change the
> > > UUID.
> > > 
> > > There's an obvious solution: a newly provisioned filesystem needs to
> > > change the uuid at first mount. The only issue is the
> > > kernel/filesystem doesn't know when the first mount is.
> > > 
> > > Darrick suggested "mount -o setuuid=xxxx" on #xfs earlier, but that
> > > requires changing userspace init stuff and, well, I hate single use
> > > case mount options like this.
> > > 
> > > However, we have a golden image that every client image is cloned
> > > from. Say we set a special feature bit in that golden image that
> > > means "need UUID regeneration". Then on the first mount of the
> > > cloned image after provisioning, the filesystem sees the bit and
> > > automatically regenerates the UUID with needing any help from
> > > userspace at all.
> > > 
> > > Problem solved, yes? We don't need userspace to change the uuid on
> > > first boot of the newly provisioned VM - the filesystem just makes
> > > it happen.
> > 
> > systemd-repart implements the following logic currently: If the GPT
> > *partition* and *disk* UUIDs are 0 then it will generate new UUIDs
> > before the first mount.
> > 
> > So for the *filesystem* UUID I think the golden image should either have
> > the UUID set to zero as well or to a special UUID. Either way, it would
> > mean the filesystem needs to generate a new UUID when it is mounted the
> > first time.
> > 
> > If we do this then all filesystems that support this should use the same
> > value to indicate "generate new UUID".
> 
> Curiously, I noticed that blkid doesn't report the xfs uuid if it's all
> zeroes:
> 
> # mkfs.xfs -f /dev/loop0 -m uuid=00000000-0000-0000-0000-000000000000
> 
> # blkid /dev/loop0
> /dev/loop0: BLOCK_SIZE="512" TYPE="xfs"

You should use blkid -p btw because without -p blkid checks a cache
which is problematic.

> 
> Nor does udev create symlinks:
> 
> # ls /dev/disk/by-uuid/0*
> ls: cannot access '/dev/disk/by-uuid/0*': No such file or directory

Yeah, it can't because there's no uuid and zero is treated as "not set".

> 
> Nor does mounting by uuid work:
> 
> # mount UUID=00000000-0000-0000-0000-000000000000 /tmp/x
> mount: /tmp/x: can't find UUID=00000000-0000-0000-0000-000000000000.
> 
> So I wonder if xfs even really needs a new superblock bit at all --
> mounting via uuid doesn't work in the zeroed-uuid case, and the kernel
> could indeed generate a new one at mount time before it populates
> s_uuid, etc.  Then the initscripts can re-run blkid (or xfs_info) to
> extract the new uuid and update config files as needed.

Yeah, that's my proposal and it's closely mirrored on what we did for
systemd-repart:

6. Similarly, all existing partitions for which configuration files
   exist and which currently have an all-zero identifying UUID will be
   assigned a new UUID. This UUID is cryptographically hashed from a
   common seed value together with the partition type UUID (and a
   counter in case multiple partitions of the same type are defined),
   see below. The same is done for all partitions that are created anew.
   These assignments are done in memory only, too, the disk is not
   updated yet.

7. Similarly, if the disk's volume UUID is all zeroes it is also
   initialized, also cryptographically hashed from the same common seed
   value. This is done in memory only too.

[...]

9. The new partition table is finally written to disk. The kernel is
   asked to reread the partition table.

https://www.freedesktop.org/software/systemd/man/systemd-repart.service.html

> 
> Though, the first-mount uuid would still break anything recorded in the
> non-xfs metadata by the image creating system (such as evm attributes).
> But at least that's on the image creator people to know that.

Sure, but that's a generic userspace problem for any identifier relying
on or derived from the filesystem uuid. IOW, that's not really our
concern imho.
