Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608672F266
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbjFNCER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 22:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNCEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213F173C;
        Tue, 13 Jun 2023 19:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5465A63CCD;
        Wed, 14 Jun 2023 02:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9905C433C8;
        Wed, 14 Jun 2023 02:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686708252;
        bh=ZuYjOOMYcIapf1xTzMaH8bllN8MN9sV5m2s612yPNPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tp8o8AXugCF/9U+D/4c/3Z5pRrIPqUguRtwn3FlBaG4OOf3P8mKQNAfyGKdzL2bkr
         X6aTKujlYWbWhpolSfZ0neNy1I3MXY+UbyvwG0CqHv00+Kq6ICp+RBHQjwVORNPgbW
         N/1cEwZi2a1IUr9Q317NEaQYdfCwRMjCJ3dFbVxbJ4cw74boS7a5Q8DwHOB4gkel3H
         +7LIAgGak27XpL0TlYOVaJmU/rObgt+tQtek/hB6LvxUQDNwWiiocqU/Qh45GQBgIC
         7lY125sMXe3cqAV9gBKePwDP0dEbc6G4FGsM2UwmDX7pds+X83QSn/Rz1n6lnXBtBm
         t/im0oviKIAzw==
Date:   Tue, 13 Jun 2023 19:04:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614020412.GB11423@frogsfrogsfrogs>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:49:38AM +0200, Dmitry Vyukov wrote:
> On Mon, 12 Jun 2023 at 18:16, Jan Kara <jack@suse.cz> wrote:
> >
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add config option to disallow writing to mounted (exclusively
> > open) block devices. Syzbot can use this option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this config option for hardening.
> 
> +syzkaller, Kees, Alexander, Eric
> 
> We can enable this on syzbot, however I have the same concerns as with
> disabling of XFS_SUPPORT_V4:
> https://github.com/google/syzkaller/issues/3918#issuecomment-1560624278
> 
> It's useful to know the actual situation with respect to
> bugs/vulnerabilities and one of the goals of syzbot is surfacing this
> situation.
> For some areas there is mismatch between upstream kernel and
> downstream distros. Upstream says "this is buggy and deprecated",
> which is fine in itself if not the other part: downstream distros
> simply ignore that (maybe not even aware) and keep things enabled for
> as long as possible. Stopping testing this is moving more in this
> direction: silencing warnings and pretending that everything is fine,
> when it's not.
> 
> I wonder if there is a way to at least somehow bridge this gap.
> 
> There is CONFIG_BROKEN, but not sure if it's the right thing here.
> Maybe we add something like CONFIG_INSECURE. And such insecure config
> settings (not setting BLK_DEV_WRITE_HARDENING, setting XFS_SUPPORT_V4)
> will say:
> 
> depends on INSECURE
> 
> So that distros will need to at least acknowledge this to users by saying:
> 
> CONFIG_INSECURE=y
> 
> They are then motivated to work on actually removing dependencies on
> these deprecated things.
> 
> CONFIG_INSECURE description can say something along the lines of "this
> kernel includes subsystems with known bugs that may cause security and
> data integrity issues". When a subsystem adds "depends on INSECURE",
> the commit should list some of the known issues.
> 
> Then I see how trading disabling things on syzbot in exchange for
> "depends on INSECURE" becomes reasonable and satisfies all parties to
> some degree.

Well in that case, post a patchset adding "depends on INSECURE" for
every subsystem that syzbot files bugs against, if the maintainers do
not immediately drop what they're doing to resolve the bug.

Google extracts a bunch more unpaid labor from society to make its
owners richer, and everyone else on the planet suffers for it, just like
you all have done for the past 25 years.  That's the definition of
Googley!!

--D

> 
> Btw, if we do this it can make sense to invert this config (enable
> concurrent writes), default to 'y' and recommend 'n'.
> 
> Does it make any sense? Any other suggestions?
> 
> P.S. Alex, if this lands this may be a candidate for addition to:
> https://github.com/a13xp0p0v/kconfig-hardened-check
> (and XFS_SUPPORT_V4 as well).
> 
> 
> > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/Kconfig             | 12 ++++++++++++
> >  block/bdev.c              | 10 ++++++++++
> >  include/linux/blk_types.h |  3 +++
> >  3 files changed, 25 insertions(+)
> >
> > FWIW I've tested this and my test VM with ext4 root fs boots fine and fstests
> > on ext4 seem to be also running fine with BLK_DEV_WRITE_HARDENING enabled.
> > OTOH my old VM setup which is not using initrd fails to boot with
> > BLK_DEV_WRITE_HARDENING enabled because fsck cannot open the root device
> > because the root is already mounted (read-only). Anyway this should be useful
> > for syzbot (Dmitry indicated interest in this option in the past) and maybe
> > other well controlled setups.
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 86122e459fe0..c44e2238e18d 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -77,6 +77,18 @@ config BLK_DEV_INTEGRITY_T10
> >         select CRC_T10DIF
> >         select CRC64_ROCKSOFT
> >
> > +config BLK_DEV_WRITE_HARDENING
> > +       bool "Do not allow writing to mounted devices"
> > +       help
> > +       When a block device is mounted, writing to its buffer cache very likely
> > +       going to cause filesystem corruption. It is also rather easy to crash
> > +       the kernel in this way since the filesystem has no practical way of
> > +       detecting these writes to buffer cache and verifying its metadata
> > +       integrity. Select this option to disallow writing to mounted devices.
> > +       This should be mostly fine but some filesystems (e.g. ext4) rely on
> > +       the ability of filesystem tools to write to mounted filesystems to
> > +       set e.g. UUID or run fsck on the root filesystem in some setups.
> > +
> >  config BLK_DEV_ZONED
> >         bool "Zoned block device support"
> >         select MQ_IOSCHED_DEADLINE
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 21c63bfef323..ad01f0a6af0d 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -602,6 +602,12 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
> >         struct gendisk *disk = bdev->bd_disk;
> >         int ret;
> >
> > +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING)) {
> > +               if (mode & FMODE_EXCL && atomic_read(&bdev->bd_writers) > 0)
> > +                       return -EBUSY;
> > +               if (mode & FMODE_WRITE && bdev->bd_holders > 0)
> > +                       return -EBUSY;
> > +       }
> >         if (disk->fops->open) {
> >                 ret = disk->fops->open(bdev, mode);
> >                 if (ret) {
> > @@ -617,6 +623,8 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
> >                 set_init_blocksize(bdev);
> >         if (test_bit(GD_NEED_PART_SCAN, &disk->state))
> >                 bdev_disk_changed(disk, false);
> > +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
> > +               atomic_inc(&bdev->bd_writers);
> >         atomic_inc(&bdev->bd_openers);
> >         return 0;
> >  }
> > @@ -625,6 +633,8 @@ static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
> >  {
> >         if (atomic_dec_and_test(&bdev->bd_openers))
> >                 blkdev_flush_mapping(bdev);
> > +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
> > +               atomic_dec(&bdev->bd_writers);
> >         if (bdev->bd_disk->fops->release)
> >                 bdev->bd_disk->fops->release(bdev->bd_disk, mode);
> >  }
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 740afe80f297..25af3340f316 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -67,6 +67,9 @@ struct block_device {
> >         struct partition_meta_info *bd_meta_info;
> >  #ifdef CONFIG_FAIL_MAKE_REQUEST
> >         bool                    bd_make_it_fail;
> > +#endif
> > +#ifdef CONFIG_BLK_DEV_WRITE_HARDENING
> > +       atomic_t                bd_writers;
> >  #endif
> >         /*
> >          * keep this out-of-line as it's both big and not needed in the fast
> > --
> > 2.35.3
> >
