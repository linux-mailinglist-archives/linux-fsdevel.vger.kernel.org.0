Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9B6F4CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjEBWde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBWdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 18:33:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532810E7
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 15:33:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so584121b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683066807; x=1685658807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1tGVYJdcDq1KV/mIdW+L+kw4PI1nRxJXqu6Hseo+co=;
        b=2phzcj3cve6WJkSMKkLJOGddRfpNgHmjBPgAzLpODf81Bf548O5OukehPjn+PD7K+3
         C7R6LNELxzmw94OvRce/hryCvlk0PoShnnG0sMkjR2Hk8BsgKXgpd/MS1jIj+fwJEKqG
         dRGHpgwkHWMATKjr9JRzjVNKXoITl2nc1C0vknqfyPHmbCY4pwnVh9fe/tPQu7h74ceh
         bwssdEwC6Z7WUA82b6y/sllUX8Gyxq001OQfNliPvOela1qFFnoiC3ObEo5ZFTg4wIu8
         Xsby+2jy4GLBMbUY9wevlP543fmfc905M/biGTxG3NND0lUL3q8DaNQ9Ko2zErHFugHF
         TwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066807; x=1685658807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1tGVYJdcDq1KV/mIdW+L+kw4PI1nRxJXqu6Hseo+co=;
        b=EGK78fpjNwixDL8A1w56lF7lqQhmqQujKlraXiK/ZheuVRK2fKdGDuOAOzTAzuLPFe
         MaQAvbV4mofGXcAwlDk84CbMwFIQ/uwvHYNlbZ4Kqv10adDnnzqShaszFJ7zJW/Gaa7U
         t1ueQMIARZMk/IrCUZcJcOZ2o/5LNjcUyyzwP+t9andpn9C8MDZvAnPp2HujdjDsScvw
         sjdBj9oV3rl9+6NlruME9lgklip9SOxoiHB2pshq3SGKAFk/DlGpfM98HEcZK7freFmm
         nDkHhiutuovhPOFrkJF3lfWz0Xx7MwdU0mKOg+85yPFPSWIvhp3wfPzOSPgGxo+1/WJS
         hGOg==
X-Gm-Message-State: AC+VfDwu44YA6yePJaTm0Bj6Mm4kgJ5LSzA64mJjH86/1DrSSChh0ozp
        lV39J5zWhoJg1tb8CXLXv8VV1w==
X-Google-Smtp-Source: ACHHUZ5K/3EFskWIHbdFTJm8kHdpDMqqv+mcTDFzyH/fTs7vVF7w1b7xVv4loGrQv7D9jJ66cibRuw==
X-Received: by 2002:a05:6a00:1592:b0:635:d9e1:8e1e with SMTP id u18-20020a056a00159200b00635d9e18e1emr160642pfk.11.1683066806884;
        Tue, 02 May 2023 15:33:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b0063b6cccd5dfsm22370647pfh.195.2023.05.02.15.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:33:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ptyYl-00AcgW-JV; Wed, 03 May 2023 08:33:23 +1000
Date:   Wed, 3 May 2023 08:33:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <20230502223323.GI2155823@dread.disaster.area>
References: <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <20230429044038.GA7561@lst.de>
 <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
 <20230501044744.GA20056@lst.de>
 <ZFBf/CXN2ktVYL/N@ovpn-8-16.pek2.redhat.com>
 <20230502013557.GH2155823@dread.disaster.area>
 <20230502153516.GA15376@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502153516.GA15376@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 08:35:16AM -0700, Darrick J. Wong wrote:
> On Tue, May 02, 2023 at 11:35:57AM +1000, Dave Chinner wrote:
> > On Tue, May 02, 2023 at 08:57:32AM +0800, Ming Lei wrote:
> > > On Mon, May 01, 2023 at 06:47:44AM +0200, Christoph Hellwig wrote:
> > > > On Sat, Apr 29, 2023 at 01:10:49PM +0800, Ming Lei wrote:
> > > > > Not sure if it is needed for non s_bdev
> > > > 
> > > > So you don't want to work this at all for btrfs?  Or the XFS log device,
> > > > or ..
> > > 
> > > Basically FS can provide one generic API of shutdown_filesystem() which
> > > shutdown FS generically, meantime calls each fs's ->shutdown() for
> > > dealing with fs specific shutdown.
> > > 
> > > If there isn't superblock attached for one bdev, can you explain a bit what
> > > filesystem code can do? Same with block layer bdev.
> > > 
> > > The current bio->bi_status together disk_live()(maybe bdev_live() is
> > > needed) should be enough for FS code to handle non s_bdev.
> > 
> > maybe necessary for btrfs, but not for XFS....
> > > 
> > > > 
> > > > > , because FS is over stackable device
> > > > > directly. Stackable device has its own logic for handling underlying disks dead
> > > > > or deleted, then decide if its own disk needs to be deleted, such as, it is
> > > > > fine for raid1 to work from user viewpoint if one underlying disk is deleted.
> > > > 
> > > > We still need to propagate the even that device has been removed upwards.
> > > > Right now some file systems (especially XFS) are good at just propagating
> > > > it from an I/O error.  And explicity call would be much better.
> > > 
> > > It depends on the above question about how FS code handle non s_bdev
> > > deletion/dead.
> > 
> > as XFS doesn't treat the individual devices differently. A
> > failure on an external log device is just as fatal as a failure on
> > a single device filesystem with an internal log. ext4 is 
> > going to consider external journal device removal as fatal, too.
> > 
> > As for removal of realtime devices on XFS, all the user data has
> > gone away, so the filesystem will largely be useless for users and
> > applications.  At this point, we'll probably want to shut down the
> > filesystem because we've had an unknown amount of user data loss and
> > so silently continuing on as if nothing happened is not the right
> > thing to do.
> > 
> > So as long as we can attach the superblock to each block device that
> > the filesystem opens (regardless of where sb->s_bdev points), device
> > removal calling sb_force_shutdown(sb, SB_SHUTDOWN_DEVICE_DEAD) will
> > do what we need. If we need anything different in future, then we
> > can worry about how to do that in the future.
> 
> Shiyang spent a lot of time hooking up pmem failure notifications so
> that xfs can kill processes that have pmem in their mapping.  I wonder
> if we could reuse some of that infrastructure here? 

ISTR that the generic mechanism for "device failure ranges" (I think
I called the mechanism ->corrupt_range()) that we came up with in
the first instance for this functionality got shouted down by some
block layer devs because they saw it as unnecessary complexity to
push device range failure notifications through block devices up
to the filesystem.

The whole point of starting from that point was so that any type of
block device could report a failure to the filesystem and have the
filesystem deal with it appropriately:

This is where we started:

https://lore.kernel.org/linux-xfs/20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com/

".....
The call trace is like this:
memory_failure()
 pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
  gendisk->fops->corrupted_range() => - pmem_corrupted_range()
                                      - md_blk_corrupted_range()
   sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
    xfs_rmap_query_range()
     xfs_currupt_helper()
      * corrupted on metadata
          try to recover data, call xfs_force_shutdown()
      * corrupted on file data 
          try to recover data, call mf_dax_mapping_kill_procs()
...."

> That MF_MEM_REMOVE
> patchset he's been trying to get us to merge would be a good starting
> point for building something similar for block devices.  AFAICT it does
> the right thing if you hand it a subrange of the dax device or if you
> pass it the customary (0, -1ULL) to mean "the entire device".

*nod*

That was exactly how I originally envisiaged that whole "bad device
range" stack being used.

> The block device version of that could be a lot simpler-- imagine if
> "echo 0 > /sys/block/fd0/device/delete" resulted in the block layer
> first sending us a notification that the device is about to be removed.
> We could then flush the fs and try to freeze it.  After the device
> actually goes away, the blocy layer would send us a second notification
> about DEVICE_DEAD and we could shut down the incore filesystem objects.

*nod*

But seeing this mechanism has already been shot down by the block
layer devs, let's be a little less ambitious and just start with
a simple, pre-existing "kill the filesystem" mechanism. Once we've
got that in place and working, we can then expand on the error
handling mechanism to perform notification of on more fine-grained
storage  errors...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
