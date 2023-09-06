Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADB79414F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbjIFQTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbjIFQTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C567199B;
        Wed,  6 Sep 2023 09:19:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C8EC433C8;
        Wed,  6 Sep 2023 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694017146;
        bh=SyvLhDIG0MoJ6FBzjIUjYOBH06hsZVQwkCnIi9FHiDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eseHbEVmMhrY9PaGwIkO64mOynH5pr1vjbpR/LNqjoBmhA0anmhRcZ/d1ScCLVh6U
         3pxXPNziMa8Z7a+mltB417gs6kryPvq/9YrgSiNsQijV9OnvmRxdY41irUtYXX3mDr
         /crCfW2KNLRK58L83A9XPQaRGf40jp86BE5K1mZ7ac021a5IVjA5GiMEOu9iTGVJvi
         hS44yxEWq9WGikt/WA9LsmmeMsDm8M8r1sSyLotBcbsIDbicv8pbM8NWj6cuZQQe0y
         fVk41sFaPa2ZSFkTspZSpE8z9N3EM6JmN39yxQyw0a2cl8oHUWkQupnHWYq5EpqXKL
         c4oq+BE+2NdFg==
Date:   Wed, 6 Sep 2023 18:19:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 06:01:06PM +0200, Mikulas Patocka wrote:
> 
> 
> On Wed, 6 Sep 2023, Christian Brauner wrote:
> 
> > > > IOW, you'd also hang on any umount of a bind-mount. IOW, every
> > > > single container making use of this filesystems via bind-mounts would
> > > > hang on umount and shutdown.
> > > 
> > > bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
> > > in this case. I tried unmounting bind-mounts and there was no deadlock.
> > 
> > With your patch what happens if you do the following?
> > 
> > #!/bin/sh -ex
> > modprobe brd rd_size=4194304
> > vgcreate vg /dev/ram0
> > lvcreate -L 16M -n lv vg
> > mkfs.ext4 /dev/vg/lv
> > 
> > mount -t ext4 /dev/vg/lv /mnt/test
> > mount --bind /mnt/test /opt
> > mount --make-private /opt
> > 
> > dmsetup suspend /dev/vg/lv
> > (sleep 1; dmsetup resume /dev/vg/lv) &
> > 
> > umount /opt # I'd expect this to hang
> > 
> > md5sum /dev/vg/lv
> > md5sum /dev/vg/lv
> > dmsetup remove_all
> > rmmod brd
> 
> "umount /opt" doesn't hang. It waits one second (until dmsetup resume is 
> called) and then proceeds.

So unless I'm really misreading the code - entirely possible - the
umount of the bind-mount now waits until the filesystem is resumed with
your patch. And if that's the case that's a bug.

If at all, then only the last umount, the one that destroys the
superblock, should wait for the filesystem to become unfrozen.

A bind-mount shouldn't as there are still active mounts of the
filesystem (e.g., /mnt/test).

So you should see this with (unless I really misread things):

#!/bin/sh -ex
modprobe brd rd_size=4194304
vgcreate vg /dev/ram0
lvcreate -L 16M -n lv vg
mkfs.ext4 /dev/vg/lv

mount -t ext4 /dev/vg/lv /mnt/test
mount --bind /mnt/test /opt
mount --make-private /opt

dmsetup suspend /dev/vg/lv

umount /opt # This will hang with your patch?

> 
> Then, it fails with "rmmod: ERROR: Module brd is in use" because the 
> script didn't unmount /mnt/test.
> 
> > > BTW. what do you think that unmount of a frozen filesystem should properly 
> > > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> > > something else?
> > 
> > In my opinion we should refuse to unmount frozen filesystems and log an
> > error that the filesystem is frozen. Waiting forever isn't a good idea
> > in my opinion.
> 
> But lvm may freeze filesystems anytime - so we'd get randomly returned 
> errors then.

So? Or you might hang at anytime.

> 
> > But this is a significant uapi change afaict so this would need to be
> > hidden behind a config option, a sysctl, or it would have to be a new
> > flag to umount2() MNT_UNFROZEN which would allow an administrator to use
> > this flag to not unmount a frozen filesystems.
> 
> The kernel currently distinguishes between kernel-initiated freeze (that 
> is used by the XFS scrub) and userspace-initiated freeze (that is used by 
> the FIFREEZE ioctl and by device-mapper initiated freeze through 
> freeze_bdev).

Yes, I'm aware.

> 
> Perhaps we could distinguish between FIFREEZE-initiated freezes and 
> device-mapper initiated freezes as well. And we could change the logic to 
> return -EBUSY if the freeze was initiated by FIFREEZE and to wait for 
> unfreeze if it was initiated by the device-mapper.

For device mapper initiated freezes you can unfreeze independent of any
filesystem mountpoint via dm ioctls.
