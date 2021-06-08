Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F739F5B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFHL4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38940 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhFHL4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B5101FD33;
        Tue,  8 Jun 2021 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623153283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXCe1g+SmTbuHQMlMaRoFzHtIWv6tHR0ZrrXgche280=;
        b=F7Sd00J10ROqvn6h0IRHeVi7Vq/iVSFODD3NI704FMIx3v429RnrW5b1Ial0UyvnKfSx/Y
        h2y3ZPa5mqhR5hbHisnXXjfg/9vOaN5amNBqdL8sZfE07OUGULN3H0ds66CrlzyQN6HCaZ
        yZuwYWUMbyGFDYApJ3Am6L68B2Jhp9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623153283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXCe1g+SmTbuHQMlMaRoFzHtIWv6tHR0ZrrXgche280=;
        b=L5Pt4oxyijI/8MZG/Kv2aq7i85N+IHx3Hrnddk+qXs11bKzzIcCTcsPNEiJlg/yQVe8CBw
        XuDpar5KKQdt0TCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E236CA3B84;
        Tue,  8 Jun 2021 11:54:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0C201F2C94; Tue,  8 Jun 2021 13:54:42 +0200 (CEST)
Date:   Tue, 8 Jun 2021 13:54:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/14 v7] fs: Hole punch vs page cache filling races
Message-ID: <20210608115442.GE5562@quack2.suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I wanted to add one more thing: The series has gathered decent amount of
review so it seems to be mostly ready to go. But I'd still like some review
from FUSE side (Miklos?) and then someone from pagecache / mm side checking
mainly patch 3/14. Since most of the changes are in fs, I guess it makes
most sense to merge this through some fs tree - either XFS, ext4, or VFS.

								Honza

On Mon 07-06-21 16:52:10, Jan Kara wrote:
> Hello,
> 
> here is another version of my patches to address races between hole punching
> and page cache filling functions for ext4 and other filesystems. The biggest
> change since the last time is providing function to lock two mappings and using
> it from XFS. Other changes were pretty minor.
> 
> Out of all filesystem supporting hole punching, only GFS2 and OCFS2 remain
> unresolved. GFS2 people are working on their own solution (cluster locking is
> involved), OCFS2 has even bigger issues (maintainers informed, looking into
> it).
> 
> As a next step, I'd like to actually make sure all calls to
> truncate_inode_pages() happen under mapping->invalidate_lock, add the assert
> and then we can also get rid of i_size checks in some places (truncate can
> use the same serialization scheme as hole punch). But that step is mostly
> a cleanup so I'd like to get these functional fixes in first.
> 
> Note that the first patch of the series is already in mm tree but I'm
> submitting it here so that the series applies to Linus' tree cleanly.
> 
> Changes since v6:
> * Added some reviewed-by tags
> * Added wrapper for taking invalidate_lock similar to inode_lock
> * Renamed wrappers for taking invalidate_lock for two inodes
> * Added xfs patch to make xfs_isilocked() work better even without lockdep
> * Some minor documentation fixes
> 
> Changes since v5:
> * Added some reviewed-by tags
> * Added functions for locking two mappings and using them from XFS where needed
> * Some minor code style & comment fixes
> 
> Changes since v4:
> * Rebased onto 5.13-rc1
> * Removed shmfs conversion patches
> * Fixed up zonefs changelog
> * Fixed up XFS comments
> * Added patch fixing up definition of file_operations in Documentation/vfs/
> * Updated documentation and comments to explain invalidate_lock is used also
>   to prevent changes through memory mappings to existing pages for some VFS
>   operations.
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
> Link: https://lore.kernel.org/r/20210413105205.3093-1-jack@suse.cz
> Link: https://lore.kernel.org/r/20210423171010.12-1-jack@suse.cz
> Link: https://lore.kernel.org/r/20210512101639.22278-1-jack@suse.cz
> Link: http://lore.kernel.org/r/20210525125652.20457-1-jack@suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
