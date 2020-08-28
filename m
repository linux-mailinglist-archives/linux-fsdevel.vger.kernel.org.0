Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F832255604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgH1IKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 04:10:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgH1IKX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:10:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2732AF0E;
        Fri, 28 Aug 2020 08:10:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EEE501E12C0; Fri, 28 Aug 2020 10:10:20 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:10:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200828081020.GA5098@quack2.suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825145056.GC32298@quack2.suse.cz>
 <20200827071603.GA25305@infradead.org>
 <20200827213900.GG1236603@ZenIV.linux.org.uk>
 <20200828000705.GC12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828000705.GC12096@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-08-20 10:07:05, Dave Chinner wrote:
> On Thu, Aug 27, 2020 at 10:39:00PM +0100, Al Viro wrote:
> > On Thu, Aug 27, 2020 at 08:16:03AM +0100, Christoph Hellwig wrote:
> > > On Tue, Aug 25, 2020 at 04:50:56PM +0200, Jan Kara wrote:
> > > > Do you mean that address_space filesystem uses to access its metadata on
> > > > /dev/sda will be different from the address_space you will see when reading
> > > > say /dev/sda?  Thus these will be completely separate (and incoherent)
> > > > caches?
> > > 
> > > Yes.
> > > 
> > > > Although this would be simple it will break userspace I'm afraid.
> > > > There are situations where tools read e.g. superblock of a mounted
> > > > filesystem from the block device and rely on the data to be reasonably
> > > > recent. Even worse e.g. tune2fs or e2fsck can *modify* superblock of a
> > > > mounted filesystem through the block device (e.g. to set 'fsck after X
> > > > mounts' fields and similar).
> > > 
> > > We've not had any problems when XFS stopped using the block device
> > > address space 9.5 years ago.
> > 
> > How much writes from fsck use does xfs see, again?
> 
> All of them, because xfs_repair uses direct IO and caches what it
> needs in userspace.

But that's the difference. e2fsprogs (which means e2fsck, tune2fs, or
generally libext2fs which is linked against quite a few external programs
as well) use buffered IO so they rely on cache coherency between what the
kernel filesystem driver sees and what userspace sees when opening the
block device. That's why I'm concerned that loosing this coherency is going
to break some ext4 user... I'll talk to Ted what he thinks about this but
so far I don't see how to separate kernel's view of the bdev from userspace
view without breakage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
