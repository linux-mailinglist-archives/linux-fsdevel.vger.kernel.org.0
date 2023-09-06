Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AA794087
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbjIFPjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjIFPjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83D171A;
        Wed,  6 Sep 2023 08:39:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52012C433C7;
        Wed,  6 Sep 2023 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694014739;
        bh=Kqr+Z6Usen0YuyinX27MigPB3AQNAtRpiHG98QWHWRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/l7ReB67ps3znnlhHWjMxGlt2zLaaDVNNwG6Xnnw5MfaM8cmNfpnEc7KVw7ALd7r
         O6IfwwwgeOoyNDodxUOSdgaXiqU8beChDDIf27Q5TfqWZWglT1oCdLIYqexJFdQCVI
         jgQRoxm12GpcVILIzZdAO/7n4pZREGkHG/+y3qU5TVLYrQp5St33FdOcuFriyPXXg6
         No/YcexIC3jO48t7UzMndU4Pp3xXxO4vxFd1hAtQtZJgz9tJDP62bKBgWB6/U/x9Q0
         T77OrivKCCMTP9rYbAEvsQrI8qvCLDjK2yn2AkHhK6m235CoPl/CCI+Og2sLzYaF9H
         TbHV4EmhJfxKw==
Date:   Wed, 6 Sep 2023 17:38:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906-alteingesessen-fussball-b480d6514411@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906152245.GD28160@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906152245.GD28160@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:22:45AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 06, 2023 at 03:26:21PM +0200, Mikulas Patocka wrote:
> > lvm may suspend any logical volume anytime. If lvm suspend races with
> > unmount, it may be possible that the kernel writes to the filesystem after
> > unmount successfully returned. The problem can be demonstrated with this
> > script:
> > 
> > #!/bin/sh -ex
> > modprobe brd rd_size=4194304
> > vgcreate vg /dev/ram0
> > lvcreate -L 16M -n lv vg
> > mkfs.ext4 /dev/vg/lv
> > mount -t ext4 /dev/vg/lv /mnt/test
> > dmsetup suspend /dev/vg/lv
> > (sleep 1; dmsetup resume /dev/vg/lv) &
> > umount /mnt/test
> > md5sum /dev/vg/lv
> > md5sum /dev/vg/lv
> > dmsetup remove_all
> > rmmod brd
> > 
> > The script unmounts the filesystem and runs md5sum twice, the result is
> > that these two invocations return different hash.
> > 
> > What happens:
> > * dmsetup suspend calls freeze_bdev, that goes to freeze_super and it
> >   increments sb->s_active
> > * then we unmount the filesystem, we go to cleanup_mnt, cleanup_mnt calls
> >   deactivate_super, deactivate_super sees that sb->s_active is 2, so it
> >   decreases it to 1 and does nothing - the umount syscall returns
> >   successfully
> > * now we have a mounted filesystem despite the fact that umount returned
> > * we call md5sum, this waits for the block device being unblocked
> > * dmsetup resume unblocks the block device and calls thaw_bdev, that calls
> >   thaw_super and thaw_super_locked
> > * thaw_super_locked calls deactivate_locked_super, this actually drops the
> >   refcount and performs the unmount. The unmount races with md5sum. md5sum
> >   wins the race and it returns the hash of the filesystem before it was
> >   unmounted
> > * the second md5sum returns the hash after the filesystem was unmounted
> > 
> > In order to fix this bug, this patch introduces a new function
> > wait_and_deactivate_super that will wait if the filesystem is frozen and
> > perform deactivate_locked_super only after that.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> >  fs/namespace.c     |    2 +-
> >  fs/super.c         |   20 ++++++++++++++++++++
> >  include/linux/fs.h |    1 +
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/fs/namespace.c
> > ===================================================================
> > --- linux-2.6.orig/fs/namespace.c	2023-09-06 09:45:54.000000000 +0200
> > +++ linux-2.6/fs/namespace.c	2023-09-06 09:47:15.000000000 +0200
> > @@ -1251,7 +1251,7 @@ static void cleanup_mnt(struct mount *mn
> >  	}
> >  	fsnotify_vfsmount_delete(&mnt->mnt);
> >  	dput(mnt->mnt.mnt_root);
> > -	deactivate_super(mnt->mnt.mnt_sb);
> > +	wait_and_deactivate_super(mnt->mnt.mnt_sb);
> >  	mnt_free_id(mnt);
> >  	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
> >  }
> > Index: linux-2.6/fs/super.c
> > ===================================================================
> > --- linux-2.6.orig/fs/super.c	2023-09-05 21:09:16.000000000 +0200
> > +++ linux-2.6/fs/super.c	2023-09-06 09:52:20.000000000 +0200
> > @@ -36,6 +36,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/user_namespace.h>
> >  #include <linux/fs_context.h>
> > +#include <linux/delay.h>
> >  #include <uapi/linux/mount.h>
> >  #include "internal.h"
> >  
> > @@ -365,6 +366,25 @@ void deactivate_super(struct super_block
> >  EXPORT_SYMBOL(deactivate_super);
> >  
> >  /**
> > + *	wait_and_deactivate_super	-	wait for unfreeze and drop a reference
> > + *	@s: superblock to deactivate
> > + *
> > + *	Variant of deactivate_super(), except that we wait if the filesystem is
> > + *	frozen. This is required on unmount, to make sure that the filesystem is
> > + *	really unmounted when this function returns.
> > + */
> > +void wait_and_deactivate_super(struct super_block *s)
> > +{
> > +	down_write(&s->s_umount);
> > +	while (s->s_writers.frozen != SB_UNFROZEN) {
> > +		up_write(&s->s_umount);
> > +		msleep(1);
> > +		down_write(&s->s_umount);
> > +	}
> 
> Instead of msleep, could you use wait_var_event_killable like
> wait_for_partially_frozen() does?

I said the same thing but I think that the patch in this way isn't a
good idea and technically also uapi breakage. Anyway, can you take a
look at my third response here?

https://lore.kernel.org/lkml/20230906-aufheben-hagel-9925501b7822@brauner

(I forgot you worked on freezing as well.
I'm currently moving the freezing bits to fs_holder_ops
https://gitlab.com/brauner/linux/-/commits/vfs.super.freeze)
