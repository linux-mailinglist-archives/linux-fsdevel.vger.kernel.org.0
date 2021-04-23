Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E66369879
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbhDWRbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 13:31:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243443AbhDWRbA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:31:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 957ABB1E0;
        Fri, 23 Apr 2021 17:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D09B1E37A2; Fri, 23 Apr 2021 19:30:18 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
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
Subject: [PATCH 0/12 v4] fs: Hole punch vs page cache filling races
Date:   Fri, 23 Apr 2021 19:29:29 +0200
Message-Id: <20210423171010.12-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is another version of my patches to address races between hole punching
and page cache filling functions for ext4 and other filesystems. I think
we are coming close to a complete solution so I've removed the RFC tag from
the subject. I went through all filesystems supporting hole punching and
converted them from their private locks to a generic one (usually fixing the
race ext4 had as a side effect). I also found out ceph & cifs didn't have
any protection from the hole punch vs page fault race either so I've added
appropriate protections there. Open are still GFS2 and OCFS2 filesystems.
GFS2 actually avoids the race but is prone to deadlocks (acquires the same lock
both above and below mmap_sem), OCFS2 locking seems kind of hosed and some
read, write, and hole punch paths are not properly serialized possibly leading
to fs corruption. Both issues are non-trivial so respective fs maintainers
have to deal with those (I've informed them and problems were generally
confirmed). Anyway, for all the other filesystem this kind of race should
be closed.

As a next step, I'd like to actually make sure all calls to
truncate_inode_pages() happen under mapping->invalidate_lock, add the assert
and then we can also get rid of i_size checks in some places (truncate can
use the same serialization scheme as hole punch). But that step is mostly
a cleanup so I'd like to get these functional fixes in first.

Changes since v3:
* Renamed and moved lock to struct address_space
* Added conversions of tmpfs, ceph, cifs, fuse, f2fs
* Fixed error handling path in filemap_read()
* Removed .page_mkwrite() cleanup from the series for now

Changes since v2:
* Added documentation and comments regarding lock ordering and how the lock is
  supposed to be used
* Added conversions of ext2, xfs, zonefs
* Added patch removing i_mapping_sem protection from .page_mkwrite handlers

Changes since v1:
* Moved to using inode->i_mapping_sem instead of aops handler to acquire
  appropriate lock

---
Motivation:

Amir has reported [1] a that ext4 has a potential issues when reads can race
with hole punching possibly exposing stale data from freed blocks or even
corrupting filesystem when stale mapping data gets used for writeout. The
problem is that during hole punching, new page cache pages can get instantiated
and block mapping from the looked up in a punched range after
truncate_inode_pages() has run but before the filesystem removes blocks from
the file. In principle any filesystem implementing hole punching thus needs to
implement a mechanism to block instantiating page cache pages during hole
punching to avoid this race. This is further complicated by the fact that there
are multiple places that can instantiate pages in page cache.  We can have
regular read(2) or page fault doing this but fadvise(2) or madvise(2) can also
result in reading in page cache pages through force_page_cache_readahead().

There are couple of ways how to fix this. First way (currently implemented by
XFS) is to protect read(2) and *advise(2) calls with i_rwsem so that they are
serialized with hole punching. This is easy to do but as a result all reads
would then be serialized with writes and thus mixed read-write workloads suffer
heavily on ext4. Thus this series introduces inode->i_mapping_sem and uses it
when creating new pages in the page cache and looking up their corresponding
block mapping. We also replace EXT4_I(inode)->i_mmap_sem with this new rwsem
which provides necessary serialization with hole punching for ext4.

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/

Previous versions:
Link: https://lore.kernel.org/linux-fsdevel/20210208163918.7871-1-jack@suse.cz/
Link: http://lore.kernel.org/r/20210413105205.3093-1-jack@suse.cz

CC: ceph-devel@vger.kernel.org
CC: Chao Yu <yuchao0@huawei.com>
CC: Damien Le Moal <damien.lemoal@wdc.com>
CC: "Darrick J. Wong" <darrick.wong@oracle.com>
CC: Hugh Dickins <hughd@google.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>
CC: linux-cifs@vger.kernel.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: <linux-fsdevel@vger.kernel.org>
CC: <linux-mm@kvack.org>
CC: <linux-xfs@vger.kernel.org>
CC: Miklos Szeredi <miklos@szeredi.hu>
CC: Steve French <sfrench@samba.org>
CC: Ted Tso <tytso@mit.edu>
