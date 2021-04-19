Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526BE364829
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhDSQZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 12:25:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhDSQZf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:25:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61751AFF8;
        Mon, 19 Apr 2021 16:25:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 274FB1F2B68; Mon, 19 Apr 2021 18:25:04 +0200 (CEST)
Date:   Mon, 19 Apr 2021 18:25:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Message-ID: <20210419162504.GI8706@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210419152008.GD2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419152008.GD2531743@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 16:20:08, Matthew Wilcox wrote:
> On Tue, Apr 13, 2021 at 01:28:44PM +0200, Jan Kara wrote:
> > Also when writing the documentation I came across one question: Do we mandate
> > i_mapping_sem for truncate + hole punch for all filesystems or just for
> > filesystems that support hole punching (or other complex fallocate operations)?
> > I wrote the documentation so that we require every filesystem to use
> > i_mapping_sem. This makes locking rules simpler, we can also add asserts when
> > all filesystems are converted. The downside is that simple filesystems now pay
> > the overhead of the locking unnecessary for them. The overhead is small
> > (uncontended rwsem acquisition for truncate) so I don't think we care and the
> > simplicity is worth it but I wanted to spell this out.
> 
> What do we actually get in return for supporting these complex fallocate
> operations?  Someone added them for a reason, but does that reason
> actually benefit me?  Other than running xfstests, how many times has
> holepunch been called on your laptop in the last week?  I don't want to
> incur even one extra instruction per I/O operation to support something
> that happens twice a week; that's a bad tradeoff.

I agree hole punch is relatively rare compared to normal operations but
when it is used, it is used rather frequently - e.g. by VMs to manage their
filesystem images. So if we regress holepunch either by not freeing blocks
or by slowing it down significantly, I'm pretty sure some people will
complain. That being said I fully understand your reluctance to add lock to
the read path but note that it is taken only when we need to fill data from
the storage and it should be taken once per readahead request so I actually
doubt the extra acquisition will be visible in the profiles. But I can
profile it to be sure.

> Can we implement holepunch as a NOP?  Or return -ENOTTY?  Those both
> seem like better solutions than adding an extra rwsem to every inode.

We already have that rwsem there today for most major filesystems. This
work just lifts it from fs-private inode area into the VFS inode. So in
terms of memory usage we are not loosing that much.

> Failing that, is there a bigger hammer we can use on the holepunch side
> (eg preventing all concurrent accesses while the holepunch is happening)
> to reduce the overhead on the read side?

I'm open to other solutions but frankly this was the best I could come up
with. Holepunch already uses a pretty much big hammer approach - take all
the locks there are on the inode in exclusive mode, block DIO, unmap
everything and then do its dirty deeds... I don't think we want hole punch
to block anything on fs-wide basis (that's a DoS recipe) and besides that
I don't see how the hammer could be bigger ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
