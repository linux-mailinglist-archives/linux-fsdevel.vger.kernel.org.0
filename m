Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB9720443
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjFBOXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjFBOXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72619A;
        Fri,  2 Jun 2023 07:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3922660D33;
        Fri,  2 Jun 2023 14:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CBAC433D2;
        Fri,  2 Jun 2023 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685715810;
        bh=yVN40KIqF4/j7CPnGXqOfwZ0o1QXCfudfPa1LTJ9yzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyjbAM+TmwIQ89k1fO8L4srt/7N/q/ep8S++y85qCcmYDwK1M/7a9Oq8Fx1dhjbLR
         hurit+pYZ2bvSKBaKSPiu/+twUtpjNAqP2EYkjtd3Cgad4RiPI82x7yapQDNIAxZ/1
         UUDGF3aGNYVsjtEwato0FseXlGaROdNGhU/iH/8vomHtp71QiiGrr82iNd0QZFaFYB
         181F2KINK1TU63yyCyxl5apHaY5+cEjKRTnJ2xxJYXDLv59kOZgnbC9XG+Em+8vsMJ
         D4TbVF631Qj1TbemkOCOhR9rl9F86RapE+yDCrS3yAGnxLXQci2YeUMiisTiCtCD/Q
         3/V1cHHBGdpXQ==
Date:   Fri, 2 Jun 2023 07:23:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602142329.GC16848@frogsfrogsfrogs>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
 <20230602-dividende-model-62b2bdc073cf@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602-dividende-model-62b2bdc073cf@brauner>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:52:16PM +0200, Christian Brauner wrote:
> On Fri, Jun 02, 2023 at 04:34:58PM +1000, Dave Chinner wrote:
> > On Fri, Jun 02, 2023 at 12:27:14AM -0400, Theodore Ts'o wrote:
> > > On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> > > > Someone ought to cc Ted since I asked him about this topic this morning
> > > > and he said he hadn't noticed it going by...
> > > > 
> > > > > > > In addition the uuid should be set when the filesystem is mounted.
> > > > > > > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > > > > > > change the uuid.
> > > > > > 
> > > > > > IMO, that ext4 functionality is a landmine waiting to be stepped on.
> > > > > > 
> > > > > > We should not be changing the sb->s_uuid of filesysetms dynamically.
> > > > > 
> > > > > Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> > > > > ioctl then this is fine though.
> > > > 
> > > > Now that Dave's brought up all kinds of questions about other parts of
> > > > the kernel using s_uuid for things, I'm starting to think that even ext4
> > > > shouldn't be changing its own uuid on the fly.
> > > 
> > > So let's set some context here.  The tune2fs program in e2fsprogs has
> > > supported changing the UUID for a *very* long time.  Specifically,
> > > since September 7, 1996 (e2fsprogs version 1.05, when we first added
> > > the UUID field in the ext2 superblock).
> > 
> > Yup, and XFS has supported offline changing of the UUID a couple of
> > years before that.
> > 
> > > This feature was added from
> > > the very beginning since in Large Installation System Administration
> > > (LISA) systems, a very common thing to do is to image boot disks from
> > > a "golden master", and then afterwards, you want to make sure the file
> > > systems on each boot disk have a unique UUID; and this is done via
> > > "tune2fs -U random /dev/sdXX".  Since I was working at MIT Project
> > > Athena at the time, we regularly did this when installing Athena
> > > client workstations, and when I added UUID support to ext2, I made
> > > sure this feature was well-supported.
> > 
> > See xfs_copy(8). This was a tool originally written, IIRC, in early
> > 1995 for physically cloning sparse golden images in the SGI factory
> > production line. It was multi-threaded and could write up to 16 scsi
> > disks at once with a single ascending LBA order pass. The last thing
> > it does is change the UUID of each clone to make them unique.
> > 
> > There's nothing new here - this is all 30 years ago, and we've had
> > tools changing filesystems UUIDs for all this time.
> > 
> > > The tune2fs program allows the UUID to be changed via the file system
> > > is mounted (with some caveats), which it did by directly modifying the
> > > on-disk superblock.  Obviously, when it did that, it wouldn't change
> > > sb->s_uuid "dynamically", although the next time the file system was
> > > mounted, sb->s_uuid would get the new UUID.
> > 
> > Yes, which means for userspace and most of the kernel it's no
> > different to "unmount, change UUID, mount". It's effectively an
> > offline change, even if the on-disk superblock is changed while the
> > filesystem is mounted.
> > 
> > > If overlayfs and IMA are
> > > expecting that a file system's UUID would stay consant and persistent
> > > --- well, that's not true, and it has always been that way, since
> > > there are tools that make it trivially easy for a system administrator
> > > to adjust the UUID.
> > 
> > Yes, but that's not the point I've been making. My point is that the
> > *online change of sb->s_uuid* that was being proposed for the
> > XFS/generic variant of the ext4 online UUID change ioctl is
> > completely new, and that's where all the problems start....
> > 
> > > In addition to the LISA context, this feature is also commonly used in
> > > various cloud deployments, since when you create a new VM, it
> > > typically gets a new root file system, which is copied from a fixed,
> > > read-only image.  So on a particular hyperscale cloud system, if we
> > > didn't do anything special, there could be hundreds of thousands VM's
> > > whose root file system would all have the same UUID, which would mean
> > > that the UUID... isn't terribly unique.
> > 
> > Again, nothing new here - we've been using snapshots/clones/reflinks
> > for efficient VM storage provisioning for well over 15 years now.
> > 
> > .....
> > 
> > > This is the reason why we added the ext4 ioctl; it was intended for
> > > the express use of "tune2fs -U", and like tune2fs -U, it doesn't
> > > actually change sb->s_uuid; it only changes the on-disk superblock's
> > > UUID.  This was mostly because we forgot about sb->s_uuid, to be
> > > honest, but it means that regardless of whether "tune2fs -U" directly
> > > modifies the block device, or uses the ext4 ioctl, the behaviour with
> > > respect to sb->s_uuid is the same; it's not modified when the on-disk
> > > uuid is changed.

...which means that anyone writing out non-ext4 ondisk metadata will now
be doing it with a stale fsuuid.  Er... that might just be an ext*
quirk that everyone will have to live with.

> > IOWs, not only was the ext4 functionality was poorly thought out, it
> > was *poorly implemented*.
> > 
> > So, let's take a step back here - we've done the use case thing to
> > death now - and consider what is it we actually need here?
> > 
> > All we need for the hyperscale/VM provisioning use case is for the
> > the UUID to be changed at first boot/mount time before anything else
> > happens.
> > 
> > So why do we need userspace to be involved in that? Indeed,
> > all the problems stem from needing to have userspace change the
> > UUID.
> > 
> > There's an obvious solution: a newly provisioned filesystem needs to
> > change the uuid at first mount. The only issue is the
> > kernel/filesystem doesn't know when the first mount is.
> > 
> > Darrick suggested "mount -o setuuid=xxxx" on #xfs earlier, but that
> > requires changing userspace init stuff and, well, I hate single use
> > case mount options like this.
> > 
> > However, we have a golden image that every client image is cloned
> > from. Say we set a special feature bit in that golden image that
> > means "need UUID regeneration". Then on the first mount of the
> > cloned image after provisioning, the filesystem sees the bit and
> > automatically regenerates the UUID with needing any help from
> > userspace at all.
> > 
> > Problem solved, yes? We don't need userspace to change the uuid on
> > first boot of the newly provisioned VM - the filesystem just makes
> > it happen.
> 
> systemd-repart implements the following logic currently: If the GPT
> *partition* and *disk* UUIDs are 0 then it will generate new UUIDs
> before the first mount.
> 
> So for the *filesystem* UUID I think the golden image should either have
> the UUID set to zero as well or to a special UUID. Either way, it would
> mean the filesystem needs to generate a new UUID when it is mounted the
> first time.
> 
> If we do this then all filesystems that support this should use the same
> value to indicate "generate new UUID".

Curiously, I noticed that blkid doesn't report the xfs uuid if it's all
zeroes:

# mkfs.xfs -f /dev/loop0 -m uuid=00000000-0000-0000-0000-000000000000

# blkid /dev/loop0
/dev/loop0: BLOCK_SIZE="512" TYPE="xfs"

Nor does udev create symlinks:

# ls /dev/disk/by-uuid/0*
ls: cannot access '/dev/disk/by-uuid/0*': No such file or directory

Nor does mounting by uuid work:

# mount UUID=00000000-0000-0000-0000-000000000000 /tmp/x
mount: /tmp/x: can't find UUID=00000000-0000-0000-0000-000000000000.

So I wonder if xfs even really needs a new superblock bit at all --
mounting via uuid doesn't work in the zeroed-uuid case, and the kernel
could indeed generate a new one at mount time before it populates
s_uuid, etc.  Then the initscripts can re-run blkid (or xfs_info) to
extract the new uuid and update config files as needed.

Though, the first-mount uuid would still break anything recorded in the
non-xfs metadata by the image creating system (such as evm attributes).
But at least that's on the image creator people to know that.

> > 
> > If the "first run" init scripts are set up to run blkid to grab the
> > new uuid after mount and update whatever needs to be updated with
> > the new root filesystem UUID, then we've moved the entire problem
> > out of the VM boot path and back into the provisioning system where
> > it should be.
> > 
> > And then we don't need an ioctl to change UUIDs online, nor do we
> 
> It also doesn't really help that much. What userspace would need is a
> way to regenerate the filesystem UUID before the filesystem is mounted.
> It doesn't help that much if you have to mount it first to change it...

<shrug> Well it's the rootfs where we want to change the uuid at
first-run time, and all the config info that needs updating is inside
the rootfs anyway.  If someone needs mount-by-uuid for the rootfs during
the first run or they require a specific uuid, they can still run
xfs_admin from within the initramfs.

--D
