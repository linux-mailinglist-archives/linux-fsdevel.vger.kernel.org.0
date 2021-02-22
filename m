Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE8320F3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 02:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhBVBta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 20:49:30 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52923 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhBVBt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:49:27 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D8CFF1040F47;
        Mon, 22 Feb 2021 12:48:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lE0L6-00FxiU-1W; Mon, 22 Feb 2021 12:48:44 +1100
Date:   Mon, 22 Feb 2021 12:48:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Erik Jensen <erikjensen@rkjnsn.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210222014844.GB4626@dread.disaster.area>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
 <20210219142201.GU2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219142201.GU2858050@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=VwQbUJbxAAAA:8 a=eJfxgxciAAAA:8
        a=7-415B0cAAAA:8 a=eMNfAaulUtgvWOZ4qZIA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=xM9caqqi1sUkTy8OJ5Uh:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:22:01PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 18, 2021 at 01:27:09PM -0800, Erik Jensen wrote:
> > On 2/18/21 4:15 AM, Matthew Wilcox wrote:
> > 
> > > On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
> > > > Recently we got a strange bug report that, one 32bit systems like armv6
> > > > or non-64bit x86, certain large btrfs can't be mounted.
> > > > 
> > > > It turns out that, since page->index is just unsigned long, and on 32bit
> > > > systemts, that can just be 32bit.
> > > > 
> > > > And when filesystems is utilizing any page offset over 4T, page->index
> > > > get truncated, causing various problems.
> > > 4TB?  I think you mean 16TB (4kB * 4GB)
> > > 
> > > Yes, this is a known limitation.  Some vendors have gone to the trouble
> > > of introducing a new page_index_t.  I'm not convinced this is a problem
> > > worth solving.  There are very few 32-bit systems with this much storage
> > > on a single partition (everything should work fine if you take a 20TB
> > > drive and partition it into two 10TB partitions).
> > For what it's worth, I'm the reporter of the original bug. My use case is a
> > custom NAS system. It runs on a 32-bit ARM processor, and has 5 8TB drives,
> > which I'd like to use as a single, unified storage array. I chose btrfs for
> > this project due to the filesystem-integrated snapshots and checksums.
> > Currently, I'm working around this issue by exporting the raw drives using
> > nbd and mounting them on a 64-bit system to access the filesystem, but this
> > is very inconvenient, only allows one machine to access the filesystem at a
> > time, and prevents running any tools that need access to the filesystem
> > (such as backup and file sync utilities) on the NAS itself.
> > 
> > It sounds like this limitation would also prevent me from trying to use a
> > different filesystem on top of software RAID, since in that case the logical
> > filesystem would still be over 16TB.
> > 
> > > As usual, the best solution is for people to stop buying 32-bit systems.
> > I purchased this device in 2018, so it's not exactly ancient. At the time,
> > it was the only SBC I could find that was low power, used ECC RAM, had a
> > crypto accelerator, and had multiple sata ports with port-multiplier
> > support.
> 
> I'm sorry you bought unsupported hardware.
> 
> This limitation has been known since at least 2009:
> https://lore.kernel.org/lkml/19041.4714.686158.130252@notabene.brown/

2004:

commit 839099eb5ea07aef093ae2c5674f5a16a268f8b6
Author: Eric Sandeen <sandeen@sgi.com>
Date:   Wed Jul 14 20:02:01 2004 +0000

    Add filesystem size limit even when XFS_BIG_BLKNOS is
    in effect; limited by page cache index size (16T on ia32)

This all popped up on XFS around 2003 when the the disk address
space was expanded from 32 bits to 64 bits on 32 bit systems
(CONFIG_LBD) and so XFS could define XFS_BIG_FILESYSTEMS on 32 bit
systems for the first time.

FWIW, from an early 1994 commit into xfs_types.h:

+/*
+ * Some types are conditional based on the selected configuration.
+ * Set XFS_BIG_FILES=1 or 0 and XFS_BIG_FILESYSTEMS=1 or 0 depending
+ * on the desired configuration.
+ * XFS_BIG_FILES needs pgno_t to be 64 bits.
+ * XFS_BIG_FILESYSTEMS needs daddr_t to be 64 bits.
+ *
+ * Expect these to be set from klocaldefs, or from the machine-type
+ * defs files for the normal case.
+ */

So limiting file and filesystem sizes on 32 bit systems is
something XFS has done right from the start...

> In the last decade, nobody's tried to fix it in mainline that I know of.
> As I said, some vendors have tried to fix it in their NAS products,
> but I don't know where to find that patch any more.

It's not suportable from a disaster recovery perspective. I recently
saw a 14TB filesystem with billions of hardlinks in it require 240GB
of RAM to run xfs_repair. We just can't support large filesystems
on 32 bit systems, and it has nothing to do with simple stuff like
page cache index sizes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
