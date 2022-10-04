Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB25F4940
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJDS0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJDS0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270415AA0F;
        Tue,  4 Oct 2022 11:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C879614F8;
        Tue,  4 Oct 2022 18:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B470EC433D6;
        Tue,  4 Oct 2022 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664908003;
        bh=oOOixuLKdO7T3peG5VpU1afyn8twx99hV9hT8wyH/MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnIrh7v/CUw1AVF/+VFeSsXvTWcmu7o0PZgYDfhzW+23cdLgAD3eOla+HcCdidC/z
         izXZrfnFJ9azS4hx4bevKP1YGEtyPOfFFiKBM43eBKLt6aBPzUE33VEzWBwXzdSThi
         ATKPzFmwMqJ4mRn0EbH/x0a7+z6xolAS5LHfBH32OxjYsyhtRC7EauKDloHQwgpOiT
         YVEnhyWLc6wWTVfgh0KRToWeDVCBypPvM94pNln7eW0IbZGVR23yRDziKA73WU0Zc+
         r1MUi2rbbpCpcq2Lhram0ad74G5HlXtu6F3UeMXwYlAMBdp/nmnb9rDkd1/Qca2Lnk
         mTvW687anHNgQ==
Date:   Tue, 4 Oct 2022 11:26:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?utf-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>
Cc:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>, zwisler@kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, dm-devel@redhat.com,
        toshi.kani@hpe.com
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <Yzx64zGt2kTiDYaP@magnolia>
References: <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
 <76ea04b4-bad7-8cb3-d2c6-4ad49def4e05@fujitsu.com>
 <YyHKUhOgHdTKPQXL@bfoster>
 <YyIBMJzmbZsUBHpy@magnolia>
 <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:12:46PM -0700, Gotou, Yasunori/五島 康文 wrote:
> On 2022/10/03 17:12, Darrick J. Wong wrote:
> > On Fri, Sep 30, 2022 at 09:56:41AM +0900, Gotou, Yasunori/五島 康文 wrote:
> > > Hello everyone,
> > > 
> > > On 2022/09/20 11:38, Yang, Xiao/杨 晓 wrote:
> > > > Hi Darrick, Brian and Christoph
> > > > 
> > > > Ping. I hope to get your feedback.
> > > > 
> > > > 1) I have confirmed that the following patch set did not change the test
> > > > result of generic/470 with thin-volume. Besides, I didn't see any
> > > > failure when running generic/470 based on normal PMEM device instaed of
> > > > thin-volume.
> > > > https://lore.kernel.org/linux-xfs/20211129102203.2243509-1-hch@lst.de/
> > > > 
> > > > 2) I can reproduce the failure of generic/482 without thin-volume.
> > > > 
> > > > 3) Is it necessary to make thin-volume support DAX. Is there any use
> > > > case for the requirement?
> > > 
> > > 
> > > Though I asked other place(*), I really want to know the usecase of
> > > dm-thin-volume with DAX and reflink.
> > > 
> > > 
> > > In my understanding, dm-thin-volume seems to provide similar feature like
> > > reflink of xfs. Both feature provide COW update to reduce usage of
> > > its region, and snapshot feature, right?
> > > 
> > > I found that docker seems to select one of them (or other feature which
> > > supports COW). Then user don't need to use thin-volume and reflink at same
> > > time.
> > > 
> > > Database which uses FS-DAX may want to use snapshot for its data of FS-DAX,
> > > its user seems to be satisfied with reflink or thin-volume.
> > > 
> > > So I could not find on what use-case user would like to use dm-thin-volume
> > > and reflink at same time.
> > > 
> > > The only possibility is that the user has mistakenly configured dm-thinpool
> > > and reflink to be used at the same time, but if that is the case, it seems
> > > to be better for the user to disable one or the other.
> > > 
> > > I really wander why dm-thin-volume must be used with reflik and FS-DAX.
> > 
> > There isn't a hard requirement between fsdax and dm-thinp.  The /test/
> > needs dm-logwrites to check that write page faults on a MAP_SYNC
> > mmapping are persisted directly to disk.  dm-logwrites requires a fast
> > way to zero an entire device for correct operation of the replay step,
> > and thinp is the only way to guarantee that.
> 
> Thank you for your answer. But I still feel something is strange.
> Though dm-thinp may be good way to execute the test correctly,

Yep.

> I suppose it seems to be likely a kind of workaround to pass the test,
> it may not be really required for actual users.

Exactly correct.  Real users should /never/ set up this kind of (test
scaffolding|insanity) to use fsdax.

> Could you tell me why passing test by workaround is so necessary?

Notice this line in generic/470:

$XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
	-c "log_writes -d $LOGWRITES_NAME -m preunmap" \
	-f $SCRATCH_MNT/test

The second xfs_io command creates a MAP_SYNC mmap of the
SCRATCH_MNT/test file, and the third command memcpy's bytes to the
mapping to invoke the write page fault handler.

The fourth command tells the dm-logwrites driver for $LOGWRITES_NAME
(aka the block device containing the mounted XFS filesystem) to create a
mark called "preunmap".  This mark captures the exact state of the block
device immediately after the write faults complete, so that we can come
back to it later.  There are a few things to note here:

  (1) We did not tell the fs to persist anything;
  (2) We can't use dm-snapshot here, because dm-snapshot will flush the
      fs (I think?); and
  (3) The fs is still mounted, so the state of the block device at the
      mark reflects a dirty XFS with a log that must be replayed.

The next thing the test does is unmount the fs, remove the dm-logwrites
driver to stop recording, and check the fs:

_log_writes_unmount
_log_writes_remove
_dmthin_check_fs

This ensures that the post-umount fs is consistent.  Now we want to roll
back to the place we marked to see if the mwrite data made it to pmem.
It *should* have, since we asked for a MAP_SYNC mapping on a fsdax
filesystem recorded on a pmem device:

# check pre-unmap state
_log_writes_replay_log preunmap $DMTHIN_VOL_DEV
_dmthin_mount

dm-logwrites can't actually roll backwards in time to a mark, since it
only records new disk contents.  It /can/ however roll forward from
whatever point it began recording writes to the mark, so that's what it
does.

However -- remember note (3) from earlier.  When we _dmthin_mount after
replaying the log to the "preunmap" mark, XFS will see the dirty XFS log
and try to recover the XFS log.  This is where the replay problems crop
up.  The XFS log records a monotonically increasing sequence number
(LSN) with every log update, and when updates are written into the
filesystem, that LSN is also written into the filesystem block.  Log
recovery also replays updates into the filesystem, but with the added
behavior that it skips a block replay if the block's LSN is higher than
the transaction being replayed.  IOWs, we never replay older block
contents over newer block contents.

For dm-logwrites this is a major problem, because there could be more
filesystem updates written to the XFS log after the mark is made.  LSNs
will then be handed out like this:

mkfs_lsn                 preunmap_lsn             umount_lsn
  |                           |                      |
  |--------------------------||----------|-----------|
                             |           |
                         xxx_lsn     yyy_lsn

Let's say that a new metadata block "BBB" was created in update "xxx"
immediately before the preunmap mark was made.  Per (1), we didn't flush
the filesystem before taking the mark, which means that the new block's
contents exist only in the log at this point.

Let us further say that the new block was again changed in update "yyy",
where preunmap_lsn < yyy_lsn <= umount_lsn.  Clearly, yyy_lsn > xxx_lsn.
yyy_lsn is written to the block at unmount, because unmounting flushes
the log clean before it completes.  This is the first time that BBB ever
gets written.

_log_writes_replay_log begins replaying the block device from mkfs_lsn
towards preunmap_lsn.  When it's done, it will have a log that reflects
all the changes up to preunmap_lsn.  Recall however that BBB isn't
written until after the preunmap mark, which means that dm-logwrites has
no record of BBB before preunmap_lsn, so dm-logwrites replay won't touch
BBB.  At this point, the block header for BBB has a UUID that matches
the filesystem, but a LSN (yyy_lsn) that is beyond preunmap_lsn.

XFS log recovery starts up, and finds transaction xxx.  It will read BBB
from disk, but then it will see that it has an LSN of yyy_lsn.  This is
larger than xxx_lsn, so it concludes that BBB is newer than the log and
moves on to the next log item.  No other log items touch BBB, so
recovery finishes, and now we have a filesystem containing one metadata
block (BBB) from the future.  This is an inconsistent filesystem, and
has caused failures in the tests that use logwrites.

To work around this problem, all we really need to do is reinitialize
the entire block device to known contents at mkfs time.  This can be
done expensively by writing zeroes to the entire block device, or it can
be done cheaply by (a) issuing DISCARD to the whole the block device at
the start of the test and (b) ensuring that reads after a discard always
produce zeroes.  mkfs.xfs already does (a), so the test merely has to
ensure (b).

dm-thinp is the only software solution that provides (b), so that's why
this test layers dm-logwrites on top of dm-thinp on top of $SCRATCH_DEV.
This combination used to work, but with the pending pmem/blockdev
divorce, this strategy is no longer feasible.

I think the only way to fix this test is (a) revert all of Christoph's
changes so far and scuttle the divorce; or (b) change this test like so:

 1. Create a large sparse file on $TEST_DIR and losetup that sparse
    file.  The resulting loop device will not have dax capability.

 2. Set up the dmthin/dmlogwrites stack on top of this loop device.

 3. Call mkfs.xfs with the SCRATCH_DEV (which hopefully is a pmem
    device) as the realtime device, and set the daxinherit and rtinherit
    flags on the root directory.  The result is a filesystem with a data
    section that the kernel will treat as a regular block device, a
    realtime section backed by pmem, and the necessary flags to make
    sure that the test file will actually get fsdax mode.

 4. Acknowledge that we no longer have any way to test MAP_SYNC
    functionality on ext4, which means that generic/470 has to move to
    tests/xfs/.

--D

> Thanks,
> 
> 
> > 
> > --D
> > 
> > > If my understanding is something wrong, please correct me.
> > > 
> > > (*)https://lore.kernel.org/all/TYWPR01MB1008258F474CA2295B4CD3D9B90549@TYWPR01MB10082.jpnprd01.prod.outlook.com/
