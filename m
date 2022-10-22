Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F66608387
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJVCLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJVCLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880442AB129;
        Fri, 21 Oct 2022 19:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA8D61FBC;
        Sat, 22 Oct 2022 02:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A758C433D6;
        Sat, 22 Oct 2022 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666404663;
        bh=kAg1fg7TzQzkGJYwN8HIno7adi7NzNuFbHUvbeeM2XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5msp0DmLfcuFUYhSVTGUgEJofpEwo+du0+qWvCqHLePP9eQY//XlkyQwDmtoy4ft
         fCsXg45HtWGKz4JjcrS9lqqoZfgir14k2vo8ZTu8Y2zMKNKndEge9uSBfSBjB+2mxL
         ujCoyTqKbvauVAAceqz9Y1UElipiCAFsqfOjyBmt66YMC061iESprBVKtwhTAtQgMZ
         8AtgubuqmBSgcMJXNsqOc2QNvfao07r6YwVzSkU5+mguQy1hO106Ihybibz+FFbWOz
         XxmOzZAT2LTcYtCyLkhV+gOYY+oQFIzmNZksJ/5wFNDge61N+5FawMupIxyiytQQH6
         gzCmXRsinREFw==
Date:   Fri, 21 Oct 2022 19:11:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Cc:     =?utf-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>, Brian Foster <bfoster@redhat.com>,
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
Message-ID: <Y1NRNtToQTjs0Dbd@magnolia>
References: <YyHKUhOgHdTKPQXL@bfoster>
 <YyIBMJzmbZsUBHpy@magnolia>
 <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> On 2022/10/5 2:26, Darrick J. Wong wrote:
> > Notice this line in generic/470:
> > 
> > $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
> > 	-c "log_writes -d $LOGWRITES_NAME -m preunmap" \
> > 	-f $SCRATCH_MNT/test
> > 
> > The second xfs_io command creates a MAP_SYNC mmap of the
> > SCRATCH_MNT/test file, and the third command memcpy's bytes to the
> > mapping to invoke the write page fault handler.
> > 
> > The fourth command tells the dm-logwrites driver for $LOGWRITES_NAME
> > (aka the block device containing the mounted XFS filesystem) to create a
> > mark called "preunmap".  This mark captures the exact state of the block
> > device immediately after the write faults complete, so that we can come
> > back to it later.  There are a few things to note here:
> > 
> >    (1) We did not tell the fs to persist anything;
> >    (2) We can't use dm-snapshot here, because dm-snapshot will flush the
> >        fs (I think?); and
> >    (3) The fs is still mounted, so the state of the block device at the
> >        mark reflects a dirty XFS with a log that must be replayed.
> > 
> > The next thing the test does is unmount the fs, remove the dm-logwrites
> > driver to stop recording, and check the fs:
> > 
> > _log_writes_unmount
> > _log_writes_remove
> > _dmthin_check_fs
> > 
> > This ensures that the post-umount fs is consistent.  Now we want to roll
> > back to the place we marked to see if the mwrite data made it to pmem.
> > It*should*  have, since we asked for a MAP_SYNC mapping on a fsdax
> > filesystem recorded on a pmem device:
> > 
> > # check pre-unmap state
> > _log_writes_replay_log preunmap $DMTHIN_VOL_DEV
> > _dmthin_mount
> > 
> > dm-logwrites can't actually roll backwards in time to a mark, since it
> > only records new disk contents.  It/can/  however roll forward from
> > whatever point it began recording writes to the mark, so that's what it
> > does.
> > 
> > However -- remember note (3) from earlier.  When we _dmthin_mount after
> > replaying the log to the "preunmap" mark, XFS will see the dirty XFS log
> > and try to recover the XFS log.  This is where the replay problems crop
> > up.  The XFS log records a monotonically increasing sequence number
> > (LSN) with every log update, and when updates are written into the
> > filesystem, that LSN is also written into the filesystem block.  Log
> > recovery also replays updates into the filesystem, but with the added
> > behavior that it skips a block replay if the block's LSN is higher than
> > the transaction being replayed.  IOWs, we never replay older block
> > contents over newer block contents.
> > 
> > For dm-logwrites this is a major problem, because there could be more
> > filesystem updates written to the XFS log after the mark is made.  LSNs
> > will then be handed out like this:
> > 
> > mkfs_lsn                 preunmap_lsn             umount_lsn
> >    |                           |                      |
> >    |--------------------------||----------|-----------|
> >                               |           |
> >                           xxx_lsn     yyy_lsn
> > 
> > Let's say that a new metadata block "BBB" was created in update "xxx"
> > immediately before the preunmap mark was made.  Per (1), we didn't flush
> > the filesystem before taking the mark, which means that the new block's
> > contents exist only in the log at this point.
> > 
> > Let us further say that the new block was again changed in update "yyy",
> > where preunmap_lsn < yyy_lsn <= umount_lsn.  Clearly, yyy_lsn > xxx_lsn.
> > yyy_lsn is written to the block at unmount, because unmounting flushes
> > the log clean before it completes.  This is the first time that BBB ever
> > gets written.
> > 
> > _log_writes_replay_log begins replaying the block device from mkfs_lsn
> > towards preunmap_lsn.  When it's done, it will have a log that reflects
> > all the changes up to preunmap_lsn.  Recall however that BBB isn't
> > written until after the preunmap mark, which means that dm-logwrites has
> > no record of BBB before preunmap_lsn, so dm-logwrites replay won't touch
> > BBB.  At this point, the block header for BBB has a UUID that matches
> > the filesystem, but a LSN (yyy_lsn) that is beyond preunmap_lsn.
> > 
> > XFS log recovery starts up, and finds transaction xxx.  It will read BBB
> > from disk, but then it will see that it has an LSN of yyy_lsn.  This is
> > larger than xxx_lsn, so it concludes that BBB is newer than the log and
> > moves on to the next log item.  No other log items touch BBB, so
> > recovery finishes, and now we have a filesystem containing one metadata
> > block (BBB) from the future.  This is an inconsistent filesystem, and
> > has caused failures in the tests that use logwrites.
> > 
> > To work around this problem, all we really need to do is reinitialize
> > the entire block device to known contents at mkfs time.  This can be
> > done expensively by writing zeroes to the entire block device, or it can
> > be done cheaply by (a) issuing DISCARD to the whole the block device at
> > the start of the test and (b) ensuring that reads after a discard always
> > produce zeroes.  mkfs.xfs already does (a), so the test merely has to
> > ensure (b).
> > 
> > dm-thinp is the only software solution that provides (b), so that's why
> > this test layers dm-logwrites on top of dm-thinp on top of $SCRATCH_DEV.
> > This combination used to work, but with the pending pmem/blockdev
> > divorce, this strategy is no longer feasible.
> 
> Hi Darrick,
> 
> Thanks a lot for your detailed explanation.
> 
> Could you tell me if my understanding is correct. I think the issue is that
> log-writes log and XFS log may save the different state of block device. It
> is possible for XFS log to save the more updates than log-writes log does.

Yes.

> In this case, we can recovery the block device by log-writes log's replay
> but we will get the inconsistent filesystem when mounting the block device
> because the mount operation will try to recovery more updates for XFS on the
> block deivce by XFS log.

Sort of...

> We need to fix the issue by discarding XFS log on the block device.
> mkfs.xfs will try to discard the blocks including XFS log by calling
> ioctl(BLKDISCARD)  but it will ignore error silently when the block
> device doesn't support ioctl(BLKDISCARD).

...but I think here's where I think your understanding isn't correct.
It might help to show how the nested logging creates its own problems.

First, let's say there's a block B that contains some stale garbage
AAAA.

XFS writes a block into the XFS log (call the block L) with the
instructions "allocate block B and write CCCC to block B".  dm-logwrites
doesn't know or care about the contents of the blocks that it is told to
write; it only knows that XFS told it to write some data (the
instructions) to block L.  So it remembers the fact that some data got
written to L, but it doesn't know about B at all.

At the point where we create the dm-logwrites preunmap mark, it's only
tracking L.  It is not tracking B.   After the mark is taken, the XFS
AIL writes CCCC to B, and only then does dm-logwrites begin tracking B.
Hence B is not included in the preunmap mark.  The pre-unmount process
in XFS writes to the XFS log "write DDDD to block B" and the unmount
process checkpoints the log contents, so now block B contains contains
DDDD.

Now the test wants to roll to the preunmap mark.  Unfortunately,
dm-logwrites doesn't record former block contents, which means that the
log replay tools cannot roll backwards from "umount" to "preunmap" --
they can only roll forward from the beginning.  So there's no way to
undo writing DDDD or CCCC to B.  IOWs, there's no way to revert B's
state back to AAAA when doing dm-logwrites recovery.

Now XFS log recovery starts.  It sees "allocate block B and write CCCC
to block B".  However, it reads block B, sees that it contains DDDD, and
it skips writing CCCC.  Incorrectly.  The only way to avoid this is to
zero B before replaying the dm-logwrites.

So you could solve the problem via BLKDISCARD, or writing zeroes to the
entire block device, or scanning the metadata and writing zeroes to just
those blocks, or by adding undo buffer records to dm-logwrites and
teaching it to do a proper rollback.

> Discarding XFS log is what you said "reinitialize the entire block
> device", right?

No, I really meant the /entire/ block device.

> > 
> > I think the only way to fix this test is (a) revert all of Christoph's
> > changes so far and scuttle the divorce; or (b) change this test like so:
> 
> Sorry, I didn't know which Christoph's patches need to be reverted?
> Could you tell me the URL about Christoph's patches?

Eh, it's a whole long series of patches scuttling various parts where
pmem could talk to the block layer.  I doubt he'll accept you reverting
his removal code.

> >   1. Create a large sparse file on $TEST_DIR and losetup that sparse
> >      file.  The resulting loop device will not have dax capability.
> > 
> >   2. Set up the dmthin/dmlogwrites stack on top of this loop device.
> > 
> >   3. Call mkfs.xfs with the SCRATCH_DEV (which hopefully is a pmem
> >      device) as the realtime device, and set the daxinherit and rtinherit
> >      flags on the root directory.  The result is a filesystem with a data
> >      section that the kernel will treat as a regular block device, a
> >      realtime section backed by pmem, and the necessary flags to make
> >      sure that the test file will actually get fsdax mode.
> > 
> >   4. Acknowledge that we no longer have any way to test MAP_SYNC
> >      functionality on ext4, which means that generic/470 has to move to
> >      tests/xfs/.
> 
> Sorry, I didn't understand why the above test change can fix the issue.

XFS supports two-device filesystems -- the "realtime" section, and the
"data" section.  FS metadata and log all live in the "data" section.

So we change the test to set up some regular files, loop-mount the
files, set up the requisite dm-logwrites stuff atop the loop devices,
and format the XFS with the data section backed by the dm-logwrites
device, and make the realtime section backed by the pmem.

This way the log replay program can actually discard the data device
(because it's a regular file) and replay the log forward to the preunmap
mark.  The pmem device is not involved in the replay at all, since
changes to file data are never logged.  It now becomes irrelevant that
pmem no longer supports device mapper.

> Could you tell me which step can discard XFS log?

(None of the steps do that.)

> In addition, I don't like your idea about the test change because it will
> make generic/470 become the special test for XFS. Do you know if we can fix
> the issue by changing the test in another way? blkdiscard -z can fix the
> issue because it does zero-fill rather than discard on the block device.
> However, blkdiscard -z will take a lot of time when the block device is
> large.

Well we /could/ just do that too, but that will suck if you have 2TB of
pmem. ;)

Maybe as an alternative path we could just create a very small
filesystem on the pmem and then blkdiscard -z it?

That said -- does persistent memory actually have a future?  Intel
scuttled the entire Optane product, cxl.mem sounds like expansion
chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
asserts everywhere) and 6.1 (every time I run fstests now I see massive
data corruption).

Frankly at this point I'm tempted just to turn of fsdax support for XFS
for the 6.1 LTS because I don't have time to fix it.

--D

> 
> Best Regards,
> Xiao Yang
> 
> > 
> > --D
