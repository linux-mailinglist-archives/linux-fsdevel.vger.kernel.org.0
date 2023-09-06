Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF032793EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbjIFO1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbjIFO1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:27:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0318210F8;
        Wed,  6 Sep 2023 07:27:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F3C433C8;
        Wed,  6 Sep 2023 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010453;
        bh=E2dEVMjCQREhmLTzdsKdjcRv3tuY2YPJjqOVBTRfaqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5VRCrPXYpZ9TK0KUE5LgWYQ5ba24HjnRdC/QV8fZKNJf2ZAcHqUKc5vEL/HiB0Og
         v/cLZayVLocDkFZAj4/6Vo7dB8i0UBRC8/jlxHolRAP6eI32xphCv8tMg6YeRJLEm4
         n8jjYR+qTY+JP/lS7agrONLuvP9yPMU0du5WxR0a+/2KHb9PdAw6wzOllMdk+vo81Z
         8hIcaeHMA3mQKiU87rINjo5JzaCo1pyOZklORG+jg3fWZjjZKxTfXKCSJSXxmC57AN
         MUJ01s4AXT+3enoVwZv118kQ2iTdaago31ubNWztm02E1hTrfPZ2ZTzR2hoP2KDeiI
         LF666CV/69TZw==
Date:   Wed, 6 Sep 2023 16:27:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906-launenhaft-kinder-118ea59706c8@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:26:21PM +0200, Mikulas Patocka wrote:
> lvm may suspend any logical volume anytime. If lvm suspend races with
> unmount, it may be possible that the kernel writes to the filesystem after
> unmount successfully returned. The problem can be demonstrated with this
> script:
> 
> #!/bin/sh -ex
> modprobe brd rd_size=4194304
> vgcreate vg /dev/ram0
> lvcreate -L 16M -n lv vg
> mkfs.ext4 /dev/vg/lv
> mount -t ext4 /dev/vg/lv /mnt/test
> dmsetup suspend /dev/vg/lv
> (sleep 1; dmsetup resume /dev/vg/lv) &
> umount /mnt/test
> md5sum /dev/vg/lv
> md5sum /dev/vg/lv
> dmsetup remove_all
> rmmod brd
> 
> The script unmounts the filesystem and runs md5sum twice, the result is
> that these two invocations return different hash.
> 
> What happens:
> * dmsetup suspend calls freeze_bdev, that goes to freeze_super and it
>   increments sb->s_active
> * then we unmount the filesystem, we go to cleanup_mnt, cleanup_mnt calls
>   deactivate_super, deactivate_super sees that sb->s_active is 2, so it
>   decreases it to 1 and does nothing - the umount syscall returns
>   successfully
> * now we have a mounted filesystem despite the fact that umount returned

That can happen for any number of reasons. Other codepaths might very
well still hold active references to the superblock. The same thing can
happen when you have your filesystem pinned in another mount namespace.

If you really want to be absolutely sure that the superblock is
destroyed you must use a mechanism like fanotify which allows you to get
notified on superblock destruction.

> @@ -1251,7 +1251,7 @@ static void cleanup_mnt(struct mount *mn
>  	}
>  	fsnotify_vfsmount_delete(&mnt->mnt);
>  	dput(mnt->mnt.mnt_root);
> -	deactivate_super(mnt->mnt.mnt_sb);
> +	wait_and_deactivate_super(mnt->mnt.mnt_sb);

Your patch means that we hang on any umount when the filesystem is
frozen. IOW, you'd also hang on any umount of a bind-mount. IOW, every
single container making use of this filesystems via bind-mounts would
hang on umount and shutdown.

You'd effectively build a deadlock trap for userspace when the
filesystem is frozen. And nothing can make progress until that thing is
thawed. Umount can't block if the block device is frozen.

>  	mnt_free_id(mnt);
>  	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
>  }
> Index: linux-2.6/fs/super.c
> ===================================================================
> --- linux-2.6.orig/fs/super.c	2023-09-05 21:09:16.000000000 +0200
> +++ linux-2.6/fs/super.c	2023-09-06 09:52:20.000000000 +0200
> @@ -36,6 +36,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/user_namespace.h>
>  #include <linux/fs_context.h>
> +#include <linux/delay.h>
>  #include <uapi/linux/mount.h>
>  #include "internal.h"
>  
> @@ -365,6 +366,25 @@ void deactivate_super(struct super_block
>  EXPORT_SYMBOL(deactivate_super);
>  
>  /**
> + *	wait_and_deactivate_super	-	wait for unfreeze and drop a reference
> + *	@s: superblock to deactivate
> + *
> + *	Variant of deactivate_super(), except that we wait if the filesystem is
> + *	frozen. This is required on unmount, to make sure that the filesystem is
> + *	really unmounted when this function returns.
> + */
> +void wait_and_deactivate_super(struct super_block *s)
> +{
> +	down_write(&s->s_umount);
> +	while (s->s_writers.frozen != SB_UNFROZEN) {
> +		up_write(&s->s_umount);
> +		msleep(1);
> +		down_write(&s->s_umount);
> +	}
> +	deactivate_locked_super(s);

That msleep(1) alone is a pretty nasty hack. We should definitely not
spin in code like this. That superblock could stay frozen for a long
time without s_umount held. So this is spinning.

Even if we wanted to do this it would need to use a similar wait
mechanism for the filesystem to be thawed like we do in
thaw_super_locked().
