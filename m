Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F896308EBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhA2UtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 15:49:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:45294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhA2UrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:47:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CAD9BAC41;
        Fri, 29 Jan 2021 20:46:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52FEDDA7C3; Fri, 29 Jan 2021 21:44:42 +0100 (CET)
Date:   Fri, 29 Jan 2021 21:44:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v14 00/42] btrfs: zoned block device support
Message-ID: <20210129204442.GN1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <SN4PR0401MB3598F3B150177BD74CB966459BB99@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598F3B150177BD74CB966459BB99@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 07:56:14AM +0000, Johannes Thumshirn wrote:
> On 26/01/2021 20:31, Naohiro Aota wrote:
> > This series adds zoned block device support to btrfs. Some of the patches
> > in the previous series are already merged as preparation patches.
> > 
> > This series is also available on github.
> > Kernel   https://github.com/naota/linux/tree/btrfs-zoned-v14
> > Userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned
> > xfstests https://github.com/naota/fstests/tree/btrfs-zoned
> > 
> > Userland tool depends on patched util-linux (libblkid and wipefs) to handle
> > log-structured superblock. To ease the testing, pre-compiled static linked
> > userland tools are available here:
> > https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp
> > 
> > v11 restructured the series so that it starts with the minimum patches to
> > run emulated zoned mode on regular devices (chunk/extent allocator,
> > allocation pointer handling, pinning of freed extents (re-dirtying released
> > extent)).
> > 
> > This series still leaves the following issues left for later fix.
> > - Bio submission path & splitting an ordered extent
> > - Redirtying freed tree blocks
> >   - Switch to keeping it dirty
> >     - Not working correctly for now
> > - Dedicated tree-log block group
> >   - We need tree-log for zoned device
> >     - Dbench (32 clients) is 85% slower with "-o notreelog"
> >   - Need to separate tree-log block group from other metadata space_info
> > - Relocation
> >   - Use normal write command for relocation
> >   - Relocated device extents must be reset
> >     - It should be discarded on regular btrfs too though
> > - Support for zone capacity
> 
> 
> Hi David,
> 
> I know we're late for 5.12, but the series has next to no potential for regressions
> on normal btrfs is there any chance we get get it staged?

Yes it's on the radar for 5.12 because of the low risk and relatively
isolated changes, I don't want to let it slip to the next cycle. I'll
add it to for-next for testing coverage, merge will happen probably
early next week.
