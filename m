Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA9583557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiG0Wcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiG0Wcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:32:41 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F9D558F5;
        Wed, 27 Jul 2022 15:32:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0562262CC03;
        Thu, 28 Jul 2022 08:32:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oGpZw-0065Ed-SD; Thu, 28 Jul 2022 08:32:32 +1000
Date:   Thu, 28 Jul 2022 08:32:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@fb.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <20220727223232.GV3600936@dread.disaster.area>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
 <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e1bd07
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=jTGfvSW0_HNO3Awiv3YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 09:04:25AM -0600, Keith Busch wrote:
> On Wed, Jul 27, 2022 at 03:04:56PM +0100, Al Viro wrote:
> > On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> > > On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > > > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > > > 
> > > > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > > > +		bdev = I_BDEV(file->f_mapping->host);
> > > > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > > > +		bdev = file->f_inode->i_sb->s_bdev;
> > > > 
> > > > *blink*
> > > > 
> > > > Just what's the intended use of the second case here?
> > > 
> > > ??
> > > 
> > > The use case is same as the first's: dma map the user addresses to the backing
> > > storage. There's two cases here because getting the block_device for a regular
> > > filesystem file is different than a raw block device.
> > 
> > Excuse me, but "file on some filesystem + block number on underlying device"
> > makes no sense as an API...
> 
> Sorry if I'm misunderstanding your concern here.
> 
> The API is a file descriptor + index range of registered buffers (which is a
> pre-existing io_uring API). The file descriptor can come from opening either a
> raw block device (ex: /dev/nvme0n1), or any regular file on a mounted
> filesystem using nvme as a backing store.

That's fundamentally flawed. Filesystems can have multiple block
devices backing them that the VFS doesn't actually know about (e.g.
btrfs, XFS, etc). Further, some of these filesystems can spread
indiivdual file data across mutliple block devices i.e. the backing
bdev changes as file offset changes....

Filesystems might not even have a block device (NFS, CIFS, etc) -
what happens if you call this function on a file belonging to such a
filesystem?

> You don't need to know about specific block numbers. You can use the result
> with any offset in the underlying block device.

Sure, but you how exactly do you know what block device the file
offset maps to?

We have entire layers like fs/iomap or bufferheads for this - their
entire purpose in life is to efficiently manage the translation
between {file, file_offset} and {dev, dev_offset} for the purposes
of IO and data access...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
