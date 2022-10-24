Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9006099D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJXFbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXFbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:31:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F98631C6
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 22:31:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so7806783pgb.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwxG912r7qQdhMvwHpOUVaZKCV3QA/HupUI/48WJuP8=;
        b=P5LkBGTHK3qZ3uv1Ax1dDOjSV1pjKe8ivXnvEjbopX3MBMbD4JcTmrIkWo+7TSmrie
         dPdsPjz5vm6pEtKx055YZ/sS2KE5jtGEodmKIOgEPDz/P6BMLLWURm7UIveY9mp6faQS
         7NCWZQsjZkthgASTjLHSZNS4Up5sb4kGa+nkF3aqhuBLfiPzG/9V92egJOllfUqQ8100
         bkB2aoGVIXrnwpA7hLCk/I7sYOU/sdzjW2DF8kCXDRdMayTkNSlOp1xz5szQyC4ryABS
         HiCjc84hp3yUagfkN2O1eOzs9wmZ89N2b2JXg/zfw98K8ls0ngoVHN48vyxx0UTcM0vv
         /tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwxG912r7qQdhMvwHpOUVaZKCV3QA/HupUI/48WJuP8=;
        b=zHOZPyGbBxJUWXFq0EVHv4BNjMJLKLdmFDeK3MsU0+FPoKWohgI96+atfZEiaHjL+E
         D2Hkb/8EsK4DXmNG6fDP7Jrr4SE2/NuJHf3pNeC7E/NuNcGBL371dLPYvIGgrDZdXn/W
         ZTOO5ZkLAOUOGjs/BNgSfy34Yg9/JYKRNw5Kaq/X5wFnARUL/y4UcAxGUW06962BEZAt
         ucAH57QXk7BbT1glP48DIQhC3JBGZfjuiKYXhEYfkNrtiWj8P8/8L4uGHKfUlX1mdbo0
         nznaIIsQT3agDNKf5iUVaSHm8+sTesZJNyt3muhpDQnRh+rnXIP9Wir1F26oTpw8E6zb
         gb4A==
X-Gm-Message-State: ACrzQf0S0A76yO1dfH3fvoT7IlzF7OCVf+JUeYYxgNvAJ04egb477sa9
        HRao7kj5huYU5+QVs3EcZc8nwQ==
X-Google-Smtp-Source: AMsMyM4qhjcVIs2TqmkRHCehYHsec5mzcEa4l4kRVjUQnd/NKoMzbiyGEQhn2aw2YDuvdTnCFJPVvA==
X-Received: by 2002:a63:1317:0:b0:42a:e7a5:ef5a with SMTP id i23-20020a631317000000b0042ae7a5ef5amr27152779pgl.392.1666589473004;
        Sun, 23 Oct 2022 22:31:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f78a00b0017a018221e2sm18680427pln.70.2022.10.23.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 22:31:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1omq3J-005iEA-4a; Mon, 24 Oct 2022 16:31:09 +1100
Date:   Mon, 24 Oct 2022 16:31:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <20221024053109.GY3600936@dread.disaster.area>
References: <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:17:52AM +0000, ruansy.fnst@fujitsu.com wrote:
> 在 2022/10/24 6:00, Dave Chinner 写道:
> > On Fri, Oct 21, 2022 at 07:11:02PM -0700, Darrick J. Wong wrote:
> >> On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> >>> In addition, I don't like your idea about the test change because it will
> >>> make generic/470 become the special test for XFS. Do you know if we can fix
> >>> the issue by changing the test in another way? blkdiscard -z can fix the
> >>> issue because it does zero-fill rather than discard on the block device.
> >>> However, blkdiscard -z will take a lot of time when the block device is
> >>> large.
> >>
> >> Well we /could/ just do that too, but that will suck if you have 2TB of
> >> pmem. ;)
> >>
> >> Maybe as an alternative path we could just create a very small
> >> filesystem on the pmem and then blkdiscard -z it?
> >>
> >> That said -- does persistent memory actually have a future?  Intel
> >> scuttled the entire Optane product, cxl.mem sounds like expansion
> >> chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
> >> asserts everywhere) and 6.1 (every time I run fstests now I see massive
> >> data corruption).
> >
> > Yup, I see the same thing. fsdax was a train wreck in 6.0 - broken
> > on both ext4 and XFS. Now that I run a quick check on 6.1-rc1, I
> > don't think that has changed at all - I still see lots of kernel
> > warnings, data corruption and "XFS_IOC_CLONE_RANGE: Invalid
> > argument" errors.
> 
> Firstly, I think the "XFS_IOC_CLONE_RANGE: Invalid argument" error is
> caused by the restrictions which prevent reflink work together with DAX:
> 
> a. fs/xfs/xfs_ioctl.c:1141
> /* Don't allow us to set DAX mode for a reflinked file for now. */
> if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
>         return -EINVAL;
> 
> b. fs/xfs/xfs_iops.c:1174
> /* Only supported on non-reflinked files. */
> if (xfs_is_reflink_inode(ip))
>         return false;
> 
> These restrictions were removed in "drop experimental warning" patch[1].
>   I think they should be separated from that patch.
> 
> [1]
> https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/
> 
> 
> Secondly, how the data corruption happened?

No idea - i"m just reporting that lots of fsx tests failed with data
corruptions. I haven't had time to look at why, I'm still trying to
sort out the fix for a different data corruption...

> Or which case failed?

*lots* of them failed with kernel warnings with reflink turned off:

SECTION       -- xfs_dax_noreflink
=========================
Failures: generic/051 generic/068 generic/075 generic/083
generic/112 generic/127 generic/198 generic/231 generic/247
generic/269 generic/270 generic/340 generic/344 generic/388
generic/461 generic/471 generic/476 generic/519 generic/561 xfs/011
xfs/013 xfs/073 xfs/297 xfs/305 xfs/517 xfs/538
Failed 26 of 1079 tests

All of those except xfs/073 and generic/471 are failures due to
warnings found in dmesg.

With reflink enabled, I terminated the run after g/075, g/091, g/112
and generic/127 reported fsx data corruptions and g/051, g/068,
g/075 and g/083 had reported kernel warnings in dmesg.

> Could
> you give me more info (such as mkfs options, xfstests configs)?

They are exactly the same as last time I reported these problems.

For the "no reflink" test issues:

mkfs options are "-m reflink=0,rmapbt=1", mount options "-o
dax=always" for both filesytems.  Config output at start of test
run:

SECTION       -- xfs_dax_noreflink
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test3 6.1.0-rc1-dgc+ #1615 SMP PREEMPT_DYNAMIC Wed Oct 19 12:24:16 AEDT 2022
MKFS_OPTIONS  -- -f -m reflink=0,rmapbt=1 /dev/pmem1
MOUNT_OPTIONS -- -o dax=always -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch

pmem devices are a pair of fake 8GB pmem regions set up by kernel
CLI via "memmap=8G!15G,8G!24G". I don't have anything special set up
- the kernel config is kept minimal for these VMs - and the only
kernel debug option I have turned on for these specific test runs is
CONFIG_XFS_DEBUG=y.

THe only difference between the noreflink and reflink runs is that I
drop the "-m reflink=0" mkfs parameter. Otherwise they are identical
and the errors I reported are from back-to-back fstests runs without
rebooting the VM....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
