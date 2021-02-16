Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A671F31CECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBPRQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:16:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbhBPRQv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:16:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0869FB7A8;
        Tue, 16 Feb 2021 17:16:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD3541F2AA7; Tue, 16 Feb 2021 18:16:09 +0100 (CET)
Date:   Tue, 16 Feb 2021 18:16:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Message-ID: <20210216171609.GH21108@quack2.suse.cz>
References: <20210216133849.8244-1-jack@suse.cz>
 <20210216163606.GA4063489@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216163606.GA4063489@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 16:36:06, Christoph Hellwig wrote:
> On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:
> > Apparently there are several userspace programs that depend on being
> > able to call BLKDISCARD ioctl without the ability to grab bdev
> > exclusively - namely FUSE filesystems have the device open without
> > O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks
> > fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and
> > discards ranges released from LV but that PV may be already open
> > exclusively by someone else (see bugzilla link below for more details).
> > 
> > This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.
> 
> I think that is a bad idea. We fixed the problem for a reason.
> I think the right fix is to just do nothing if the device hasn't been
> opened with O_EXCL and can't be reopened with it, just don't do anything
> but also don't return an error.  After all discard and thus
> BLKDISCARD is purely advisory.

Yeah, certainly we'd have to fix the original problem in some other way.
Just silently ignoring BLKDISCARD if we cannot claim the device exclusively
is certainly an option to stop complaints from userspace. But note that
fstrim with fuse-based filesystem would still stay silent NOP which is
suboptimal. It could be fixed on FUSE side as I talked to Miklos but it
is not trivial. Similarly for the LVM regression...

I was wondering whether we could do something like:
	use truncate_inode_pages() if we can claim bdev exclusively
	use invalidate_inode_pages2_range() if we cannot claim bdev
          exclusively, possibly do nothing if that returns EBUSY?

The downside is that cases where we cannot claim bdev exclusively would
unnecessarily write dirty buffer cache before discard.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
