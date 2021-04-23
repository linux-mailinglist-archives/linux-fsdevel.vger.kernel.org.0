Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8145E369C70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 00:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhDWWIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 18:08:40 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:47987 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231218AbhDWWIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:08:38 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id E1D4310BE4E;
        Sat, 24 Apr 2021 08:07:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1la3xn-004YOq-PH; Sat, 24 Apr 2021 08:07:51 +1000
Date:   Sat, 24 Apr 2021 08:07:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Ted Tso <tytso@mit.edu>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 0/12 v4] fs: Hole punch vs page cache filling races
Message-ID: <20210423220751.GB63242@dread.disaster.area>
References: <20210423171010.12-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423171010.12-1-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=i0EeH86SAAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
        a=FP58Ms26AAAA:8 a=37rDS-QxAAAA:8 a=hGzw-44bAAAA:8 a=7-415B0cAAAA:8
        a=Aae5kKz94hHt9Mq2e2cA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=xVlTc564ipvMDusKsbsT:22 a=k1Nq6YrhK2t884LQW06G:22
        a=HvKuF1_PTVFglORKqfwH:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

In future, can you please use the same cc-list for the entire
patchset?

The stuff that has hit the XFS list (where I'm replying from)
doesn't give me any context as to what the core changes are that
allow XFS to be changed, so I can't review them in isolation.

I've got to spend time now reconstructing the patchset into a single
series because the delivery has been spread across three different
mailing lists and so hit 3 different procmail filters.  I'll comment
on the patches once I've reconstructed the series and read through
it as a whole...

/me considers the way people use "cc" tags in git commits for
including mailing lists on individual patches actively harmful.
Unless the recipient is subscribed to all the mailing lists the
patchset was CC'd to, they can't easily find the bits of the
patchset that didn't arrive in their mail box. Individual mailing
lists should receive entire patchsets for review, not random,
individual, context free patches. 

And, FWIW, cc'ing the cover letter to all the mailing lists is not
good enough. Being able to see the code change as a whole is what
matters for review, not the cover letter...

Cheers,

Dave.

On Fri, Apr 23, 2021 at 07:29:29PM +0200, Jan Kara wrote:
> Hello,
> 
> here is another version of my patches to address races between hole punching
> and page cache filling functions for ext4 and other filesystems. I think
> we are coming close to a complete solution so I've removed the RFC tag from
> the subject. I went through all filesystems supporting hole punching and
> converted them from their private locks to a generic one (usually fixing the
> race ext4 had as a side effect). I also found out ceph & cifs didn't have
> any protection from the hole punch vs page fault race either so I've added
> appropriate protections there. Open are still GFS2 and OCFS2 filesystems.
> GFS2 actually avoids the race but is prone to deadlocks (acquires the same lock
> both above and below mmap_sem), OCFS2 locking seems kind of hosed and some
> read, write, and hole punch paths are not properly serialized possibly leading
> to fs corruption. Both issues are non-trivial so respective fs maintainers
> have to deal with those (I've informed them and problems were generally
> confirmed). Anyway, for all the other filesystem this kind of race should
> be closed.
> 
> As a next step, I'd like to actually make sure all calls to
> truncate_inode_pages() happen under mapping->invalidate_lock, add the assert
> and then we can also get rid of i_size checks in some places (truncate can
> use the same serialization scheme as hole punch). But that step is mostly
> a cleanup so I'd like to get these functional fixes in first.
> 
> Changes since v3:
> * Renamed and moved lock to struct address_space
> * Added conversions of tmpfs, ceph, cifs, fuse, f2fs
> * Fixed error handling path in filemap_read()
> * Removed .page_mkwrite() cleanup from the series for now
> 
> Changes since v2:
> * Added documentation and comments regarding lock ordering and how the lock is
>   supposed to be used
> * Added conversions of ext2, xfs, zonefs
> * Added patch removing i_mapping_sem protection from .page_mkwrite handlers
> 
> Changes since v1:
> * Moved to using inode->i_mapping_sem instead of aops handler to acquire
>   appropriate lock
> 
> ---
> Motivation:
> 
> Amir has reported [1] a that ext4 has a potential issues when reads can race
> with hole punching possibly exposing stale data from freed blocks or even
> corrupting filesystem when stale mapping data gets used for writeout. The
> problem is that during hole punching, new page cache pages can get instantiated
> and block mapping from the looked up in a punched range after
> truncate_inode_pages() has run but before the filesystem removes blocks from
> the file. In principle any filesystem implementing hole punching thus needs to
> implement a mechanism to block instantiating page cache pages during hole
> punching to avoid this race. This is further complicated by the fact that there
> are multiple places that can instantiate pages in page cache.  We can have
> regular read(2) or page fault doing this but fadvise(2) or madvise(2) can also
> result in reading in page cache pages through force_page_cache_readahead().
> 
> There are couple of ways how to fix this. First way (currently implemented by
> XFS) is to protect read(2) and *advise(2) calls with i_rwsem so that they are
> serialized with hole punching. This is easy to do but as a result all reads
> would then be serialized with writes and thus mixed read-write workloads suffer
> heavily on ext4. Thus this series introduces inode->i_mapping_sem and uses it
> when creating new pages in the page cache and looking up their corresponding
> block mapping. We also replace EXT4_I(inode)->i_mmap_sem with this new rwsem
> which provides necessary serialization with hole punching for ext4.
> 
> 								Honza
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
> 
> Previous versions:
> Link: https://lore.kernel.org/linux-fsdevel/20210208163918.7871-1-jack@suse.cz/
> Link: http://lore.kernel.org/r/20210413105205.3093-1-jack@suse.cz
> 
> CC: ceph-devel@vger.kernel.org
> CC: Chao Yu <yuchao0@huawei.com>
> CC: Damien Le Moal <damien.lemoal@wdc.com>
> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> CC: Hugh Dickins <hughd@google.com>
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Johannes Thumshirn <jth@kernel.org>
> CC: linux-cifs@vger.kernel.org
> CC: <linux-ext4@vger.kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> CC: <linux-fsdevel@vger.kernel.org>
> CC: <linux-mm@kvack.org>
> CC: <linux-xfs@vger.kernel.org>
> CC: Miklos Szeredi <miklos@szeredi.hu>
> CC: Steve French <sfrench@samba.org>
> CC: Ted Tso <tytso@mit.edu>
> 

-- 
Dave Chinner
david@fromorbit.com
