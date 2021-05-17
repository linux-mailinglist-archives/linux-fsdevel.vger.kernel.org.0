Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEC382ACE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhEQLWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 07:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236528AbhEQLWd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 07:22:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7294AED7;
        Mon, 17 May 2021 11:21:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 56F6D1F2CA4; Mon, 17 May 2021 13:21:15 +0200 (CEST)
Date:   Mon, 17 May 2021 13:21:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210517112115.GC31755@quack2.suse.cz>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <20210512152345.GE8606@magnolia>
 <20210513174459.GH2734@quack2.suse.cz>
 <20210513185252.GB9675@magnolia>
 <20210513231945.GD2893@dread.disaster.area>
 <20210514161730.GL9675@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514161730.GL9675@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-05-21 09:17:30, Darrick J. Wong wrote:
> On Fri, May 14, 2021 at 09:19:45AM +1000, Dave Chinner wrote:
> > We've been down this path before more than a decade ago when the
> > powers that be decreed that inode locking order is to be "by
> > structure address" rather than inode number, because "inode number
> > is not unique across multiple superblocks".
> > 
> > I'm not sure that there is anywhere that locks multiple inodes
> > across different superblocks, but here we are again....
> 
> Hm.  Are there situations where one would want to lock multiple
> /mappings/ across different superblocks?  The remapping code doesn't
> allow cross-super operations, so ... pipes and splice, maybe?  I don't
> remember that code well enough to say for sure.

Splice and friends work one file at a time. I.e., first they fill a pipe
from the file with ->read_iter, then they flush the pipe to the target file
with ->write_iter. So file locking doesn't get coupled there.

> I've been operating under the assumption that as long as one takes all
> the same class of lock at the same time (e.g. all the IOLOCKs, then all
> the MMAPLOCKs, then all the ILOCKs, like reflink does) that the
> incongruency in locking order rules within a class shouldn't be a
> problem.

That's my understanding as well.

> > > It might simply be time to convert all
> > > three XFS inode locks to use the same ordering rules.
> > 
> > Careful, there lie dragons along that path because of things like
> > how the inode cluster buffer operations work - they all assume
> > ascending inode number traversal within and across inode cluster
> > buffers and hence we do have locking order constraints based on
> > inode number...
> 
> Fair enough, I'll leave the ILOCK alone. :)

OK, so should I change the order for invalidate_lock or shall we just leave
that alone as it is not a practical problem AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
