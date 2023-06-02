Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673D71F7C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjFBBYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjFBBYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9FCE67;
        Thu,  1 Jun 2023 18:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA25964B69;
        Fri,  2 Jun 2023 01:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD69C433EF;
        Fri,  2 Jun 2023 01:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685669016;
        bh=FhatHvXAFzq7IabW/vy+phK/Hn6nL+f7jEuRo1fr/T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9UDEAXGtziC/P5+a+klwjMLKfC6rL0mdFbuCTHnpgbcegY4i6XJUoZoZ5bkkVEQV
         D1LOT4gq0H9MQldbQOpjpb219eEIHW6gm2PAfgsXGyW1L7d61x+4h5P1j7TMTpsYGc
         0gHH43SknXmEHVoYXiUCtogfFM418bQSaVHMXIgHVHsQyE7Uw/DZenCSS0yh+Ot9HZ
         n6dtXQyeIMu/+wbMBs2f6aDQOM/E7EoZ+iU2wsOC8UObAIVKobCpgC08nnNDxaZGh4
         fypA0JGIo8TNx+kjBsFAvhN89we9X5yohKiNxZQeZH4INxsV75LkOeKKtJq6MNkWwG
         Xi/LMmqkShqYA==
Date:   Thu, 1 Jun 2023 18:23:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602012335.GB16848@frogsfrogsfrogs>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522-unsensibel-backblech-7be4e920ba87@brauner>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Someone ought to cc Ted since I asked him about this topic this morning
and he said he hadn't noticed it going by...

On Mon, May 22, 2023 at 12:50:19PM +0200, Christian Brauner wrote:
> On Mon, May 22, 2023 at 08:49:50AM +1000, Dave Chinner wrote:
> > On Sat, May 20, 2023 at 11:17:35AM +0200, Christian Brauner wrote:
> > > On Fri, May 19, 2023 at 03:42:38PM -0400, Mimi Zohar wrote:
> > > > On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > > vfs_getattr_nosec() change:
> > > > > 
> > > > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > > > >     is in line what we do with all other inode attributes. IOW, the
> > > > >     overlayfs inode's i_version counter should aim to mirror the
> > > > >     relevant layer's i_version counter. I wouldn't know why that
> > > > >     shouldn't be the case. Asking the other way around there doesn't
> > > > >     seem to be any use for overlayfs inodes to have an i_version that
> > > > >     isn't just mirroring the relevant layer's i_version.
> > > > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > > > >     Currently, ima assumes that it will get the correct i_version from
> > > > >     an inode but that just doesn't hold for stacking filesystem.
> > > > > 
> > > > > While (1) would likely just fix the immediate bug (2) is correct and
> > > > > _robust_. If we change how attributes are handled vfs_*() helpers will
> > > > > get updated and ima with it. Poking at raw inodes without using
> > > > > appropriate helpers is much more likely to get ima into trouble.
> > > > 
> > > > In addition to properly setting the i_version for IMA, EVM has a
> > > > similar issue with i_generation and s_uuid. Adding them to
> > > > ovl_copyattr() seems to resolve it.   Does that make sense?
> > > > 
> > > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > > index 923d66d131c1..cd0aeb828868 100644
> > > > --- a/fs/overlayfs/util.c
> > > > +++ b/fs/overlayfs/util.c
> > > > @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
> > > >  	inode->i_atime = realinode->i_atime;
> > > >  	inode->i_mtime = realinode->i_mtime;
> > > >  	inode->i_ctime = realinode->i_ctime;
> > > > +	inode->i_generation = realinode->i_generation;
> > > > +	if (inode->i_sb)
> > > > +		uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> > > 
> > > Overlayfs can consist of multiple lower layers and each of those lower
> > > layers may have a different uuid. So everytime you trigger a
> > > ovl_copyattr() on a different layer this patch would alter the uuid of
> > > the overlayfs superblock.
> > > 
> > > In addition the uuid should be set when the filesystem is mounted.
> > > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > > change the uuid.
> > 
> > IMO, that ext4 functionality is a landmine waiting to be stepped on.
> > 
> > We should not be changing the sb->s_uuid of filesysetms dynamically.
> 
> Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> ioctl then this is fine though.

Now that Dave's brought up all kinds of questions about other parts of
the kernel using s_uuid for things, I'm starting to think that even ext4
shouldn't be changing its own uuid on the fly.

Unless, of course, someone writes a way to record when s_uuid has been
accessed by something (e.g. pnfs, ima, etc) to lock out changes to the
value...

> Thanks for bringing this up. I had some thoughts on this (mostly at the
> end of this mail) but haven't had the time to express them.
> 
> > The VFS does not guarantee in any way that it is safe to change the
> > sb->s_uuid (i.e. no locking, no change notifications, no udev
> > events, etc). Various subsystems - both in the kernel and in
> > userspace - use the sb->s_uuid as a canonical and/or persistent
> > filesystem/device identifier and are unprepared to have it change
> > while the filesystem is mounted and active.

...just like Dave just said.  Heh. :(

--D

> Yes, it is not a VFS concept for sure.
> 
> > 
> > I commented on this from an XFS perspective here when it was
> > proposed to copy this ext4 mis-feature in XFS:
> > 
> > https://lore.kernel.org/linux-xfs/20230314062847.GQ360264@dread.disaster.area/
> 
> So I read the thread back then and I agree with you specifically about:
> 
> * changing uuid dynamically isn't a well-defined concept
> * hoisting the ext4 specific ioctl that allows changing the uuid
>   dynamically into a generic vfs ioctl is premature and gives the
>   impression that this is a well-defined concept when it isn't.
> * the chosen data structure with a flexible array member would probably
>   work but is suboptimal
> 
> > 
> > Further to this, I also suspect that changing uuids online will
> > cause issues with userspace caching of fs uuids (e.g. libblkid and
> > anything that uses it) and information that uses uuids to identify
> > the filesystem that are set up at mount time (/dev/disk/by-uuid/
> > links, etc) by kernel events sent to userspace helpers...
> 
> Yeah, that's a valid concern as it's common practice to put uuids into
> /etc/fstab so if they were allowed to change while the filesystem is
> mounted/superblock is active the minimum thing needed is for userspace
> get a uevent so the /dev/disk/by-uuid/$uuid symlink can be updated by
> udev. But I digress.
> 
> > 
> > IMO, we shouldn't even be considering dynamic sb->s_uuid changes
> > without first working through the full system impacts of having
> > persistent userspace-visible filesystem identifiers change
> > dynamically...
> 
> Yes.
> 
> ---
> 
> The thing that I think we could do is have all filesystems that can
> reasonably support it set a uuid. We currently don't do that. If we
> would start doing that then all filesystems that currently don't
> implement a separate f_fsid based on e.g., the disk's device number can
> just generate the f_fsid based on the uuid. This will make all these
> filesystems available to be used with fanotify - which requires f_fsid
> to be set for its most useful features.
> 
> This is often the most useful for filesystems such as tmpfs which gained
> support for uuids quite recently. For such pseudo filesystems the
> lifetime of the uuid would be the lifetime of the superblock in contrast
> to filesystems like xfs that persist the uuid to disk. IOW, if you
> mount -t tmpfs tmpfs /mnt; umount /mnt; mount -t tmpfs tmpfs /mnt then
> you get a new uuid but the uuid stays fixed for the lifetime of the
> superblock and can't be changed.
> 
> So the patchset that you objected had one part that made sense to me
> which was to hoist the ioctl that _gets_ the uuid from a filesystems
> into a generic ioctl. But I agree that the structure wasn't chosen
> nicely. I would prefer if this was a fixed size but extensible structure
> which is a concept we've had for a long time. So say we were to chose
> the following structure layout for the generic ioctl:
> 
> struct fsuuid {
>         __u32       fsu_len;
>         __u32       fsu_flags;
>         __u8        fsu_uuid[16]; // 8 * 16 = 128 = 64 * 2
> };
> 
> then this would be compatible with ext4. It would also be extensible if
> we wanted to add additional fields in the future or switch to a new uuid
> format or whatever.
> 
> A while back we did work for extensible struct in system calls but these
> extensible structs also work with ioctls.
> 
> For example, see what we did for kernel/seccomp.c:
> 
>         /* Extensible Argument ioctls */
>         #define EA_IOCTL(cmd)   ((cmd) & ~(IOC_INOUT | IOCSIZE_MASK))
> 
>         switch (EA_IOCTL(cmd)) {
>         case EA_IOCTL(SECCOMP_IOCTL_NOTIF_ADDFD):
>                 return seccomp_notify_addfd(filter, buf, _IOC_SIZE(cmd));
>         default:
>                 return -EINVAL;
>         }
> 
> and then
> 
>         static long seccomp_notify_addfd(struct seccomp_filter *filter,
>                                          struct seccomp_notif_addfd __user *uaddfd,
>                                          unsigned int size)
>         {
>                 [...]
>         
>                 BUILD_BUG_ON(sizeof(addfd) < SECCOMP_NOTIFY_ADDFD_SIZE_VER0);
>                 BUILD_BUG_ON(sizeof(addfd) != SECCOMP_NOTIFY_ADDFD_SIZE_LATEST);
>         
>                 if (size < SECCOMP_NOTIFY_ADDFD_SIZE_VER0 || size >= PAGE_SIZE)
>                         return -EINVAL;
>         
>                 ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
>                 if (ret)
>                         return ret;
>         
>                 [...]
>         }
> 
> So the struct is versioned by size the same as for system calls. The
> difference for the ioctl is that the size is already encoded in the
> ioctl when it is defined. So even with a fixed size struct it is
> trivially possible to extend the struct later as long as the extension
> is 64bit aligned.
