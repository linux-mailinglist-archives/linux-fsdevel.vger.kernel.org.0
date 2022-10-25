Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35760D2D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiJYR4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJYR4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF92FDDA0D;
        Tue, 25 Oct 2022 10:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8714861A5C;
        Tue, 25 Oct 2022 17:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31C0C433C1;
        Tue, 25 Oct 2022 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666720579;
        bh=yoY7iLCYU7bzt4GaDkXzEUixBCzZ8DqXBG0ytNBixsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGOxpfrqH3n+hxbHscT2hCJAweA45hU3XDOfbyng2Rw1RSuZVYXmDxaa61Zj3IGAA
         u+6lDQdpV+pqSJNTrTP2zasaT1c6kcJzv7idqf6tlIFZ4VFDBO8gzJ4OrGjGhTWXXQ
         PdtJt6i0GDl0EHg9PufvzxNIQpBVY7pbNKBemqw+x0Lmff5PKKKNNMSDd1q5cKocr8
         YvcMXrE+jVIrWppzspmVO3mD4uMbVlB496Wg36qDLu4dSRqaaBOHiEOwbS0H6GG8ro
         /OwTkx/eMJt/MvPVJ1rZIY8i5UOn+kWGfCtJkslDIsQsvqIeVOZZHfjfnCFZn3WikR
         c/wiJAuXKNzVA==
Date:   Tue, 25 Oct 2022 10:56:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <Y1gjQ4wNZr3ve2+K@magnolia>
References: <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20221024053109.GY3600936@dread.disaster.area>
 <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:26:50PM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> 
> 在 2022/10/24 13:31, Dave Chinner 写道:
> > On Mon, Oct 24, 2022 at 03:17:52AM +0000, ruansy.fnst@fujitsu.com wrote:
> >> 在 2022/10/24 6:00, Dave Chinner 写道:
> >>> On Fri, Oct 21, 2022 at 07:11:02PM -0700, Darrick J. Wong wrote:
> >>>> On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> >>>>> In addition, I don't like your idea about the test change because it will
> >>>>> make generic/470 become the special test for XFS. Do you know if we can fix
> >>>>> the issue by changing the test in another way? blkdiscard -z can fix the
> >>>>> issue because it does zero-fill rather than discard on the block device.
> >>>>> However, blkdiscard -z will take a lot of time when the block device is
> >>>>> large.
> >>>>
> >>>> Well we /could/ just do that too, but that will suck if you have 2TB of
> >>>> pmem. ;)
> >>>>
> >>>> Maybe as an alternative path we could just create a very small
> >>>> filesystem on the pmem and then blkdiscard -z it?
> >>>>
> >>>> That said -- does persistent memory actually have a future?  Intel
> >>>> scuttled the entire Optane product, cxl.mem sounds like expansion
> >>>> chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
> >>>> asserts everywhere) and 6.1 (every time I run fstests now I see massive
> >>>> data corruption).
> >>>
> >>> Yup, I see the same thing. fsdax was a train wreck in 6.0 - broken
> >>> on both ext4 and XFS. Now that I run a quick check on 6.1-rc1, I
> >>> don't think that has changed at all - I still see lots of kernel
> >>> warnings, data corruption and "XFS_IOC_CLONE_RANGE: Invalid
> >>> argument" errors.
> >>
> >> Firstly, I think the "XFS_IOC_CLONE_RANGE: Invalid argument" error is
> >> caused by the restrictions which prevent reflink work together with DAX:
> >>
> >> a. fs/xfs/xfs_ioctl.c:1141
> >> /* Don't allow us to set DAX mode for a reflinked file for now. */
> >> if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
> >>          return -EINVAL;
> >>
> >> b. fs/xfs/xfs_iops.c:1174
> >> /* Only supported on non-reflinked files. */
> >> if (xfs_is_reflink_inode(ip))
> >>          return false;
> >>
> >> These restrictions were removed in "drop experimental warning" patch[1].
> >>    I think they should be separated from that patch.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/
> >>
> >>
> >> Secondly, how the data corruption happened?
> > 
> > No idea - i"m just reporting that lots of fsx tests failed with data
> > corruptions. I haven't had time to look at why, I'm still trying to
> > sort out the fix for a different data corruption...
> > 
> >> Or which case failed?
> > 
> > *lots* of them failed with kernel warnings with reflink turned off:
> > 
> > SECTION       -- xfs_dax_noreflink
> > =========================
> > Failures: generic/051 generic/068 generic/075 generic/083
> > generic/112 generic/127 generic/198 generic/231 generic/247
> > generic/269 generic/270 generic/340 generic/344 generic/388
> > generic/461 generic/471 generic/476 generic/519 generic/561 xfs/011
> > xfs/013 xfs/073 xfs/297 xfs/305 xfs/517 xfs/538
> > Failed 26 of 1079 tests
> > 
> > All of those except xfs/073 and generic/471 are failures due to
> > warnings found in dmesg.
> > 
> > With reflink enabled, I terminated the run after g/075, g/091, g/112
> > and generic/127 reported fsx data corruptions and g/051, g/068,
> > g/075 and g/083 had reported kernel warnings in dmesg.
> > 
> >> Could
> >> you give me more info (such as mkfs options, xfstests configs)?
> > 
> > They are exactly the same as last time I reported these problems.
> > 
> > For the "no reflink" test issues:
> > 
> > mkfs options are "-m reflink=0,rmapbt=1", mount options "-o
> > dax=always" for both filesytems.  Config output at start of test
> > run:
> > 
> > SECTION       -- xfs_dax_noreflink
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 test3 6.1.0-rc1-dgc+ #1615 SMP PREEMPT_DYNAMIC Wed Oct 19 12:24:16 AEDT 2022
> > MKFS_OPTIONS  -- -f -m reflink=0,rmapbt=1 /dev/pmem1
> > MOUNT_OPTIONS -- -o dax=always -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch
> > 
> > pmem devices are a pair of fake 8GB pmem regions set up by kernel
> > CLI via "memmap=8G!15G,8G!24G". I don't have anything special set up
> > - the kernel config is kept minimal for these VMs - and the only
> > kernel debug option I have turned on for these specific test runs is
> > CONFIG_XFS_DEBUG=y.
> 
> Thanks for the detailed info.  But, in my environment (and my 
> colleagues', and our real server with DCPMM) these failure cases (you 
> mentioned above, in dax+non_reflink mode, with same test options) cannot 
> reproduce.
> 
> Here's our test environment info:
>   - Ruan's env: fedora 36(v6.0-rc1) on kvm,pmem 2x4G:file backended
>   - Yang's env: fedora 35(v6.1-rc1) on kvm,pmem 2x1G:memmap=1G!1G,1G!2G
>   - Server's  : Ubuntu 20.04(v6.0-rc1) real machine,pmem 2x4G:real DCPMM
> 
> (To quickly confirm the difference, I just ran the failed 26 cases you 
> mentioned above.)  Except for generic/471 and generic/519, which failed 
> even when dax is off, the rest passed.
> 
> 
> We don't want fsdax to be truned off.  Right now, I think the most 
> important thing is solving the failed cases in dax+non_reflink mode. 
> So, firstly, I have to reproduce those failures.  Is there any thing 
> wrong with my test environments?  I konw you are using 'memmap=XXG!YYG' to 
> simulate pmem.  So, (to Darrick) could you show me your config of dev 
> environment and the 'testcloud'(I am guessing it's a server with real 
> nvdimm just like ours)?

Nope.  Since the announcement of pmem as a product, I have had 15
minutes of acces to one preproduction prototype server with actual
optane DIMMs in them.

I have /never/ had access to real hardware to test any of this, so it's
all configured via libvirt to simulate pmem in qemu:
https://lore.kernel.org/linux-xfs/YzXsavOWMSuwTBEC@magnolia/

/run/mtrdisk/[gh].mem are both regular files on a tmpfs filesystem:

$ grep mtrdisk /proc/mounts
none /run/mtrdisk tmpfs rw,relatime,size=82894848k,inode64 0 0

$ ls -la /run/mtrdisk/[gh].mem
-rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 18:09 /run/mtrdisk/g.mem
-rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 19:28 /run/mtrdisk/h.mem

--D

> 
> 
> (I just found I only tested on 4G and smaller pmem device.  I'll try the 
> test on 8G pmem)
> 
> > 
> > THe only difference between the noreflink and reflink runs is that I
> > drop the "-m reflink=0" mkfs parameter. Otherwise they are identical
> > and the errors I reported are from back-to-back fstests runs without
> > rebooting the VM....
> > 
> > -Dave.
> 
> 
> --
> Thanks,
> Ruan.
