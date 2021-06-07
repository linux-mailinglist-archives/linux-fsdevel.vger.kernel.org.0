Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA339DF95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFGOyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51518 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGOya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 838B71FD30;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dXoAu7GQXVTWLNML0ZDCTisk4K7XoHyJObObTC90fms=;
        b=n5y6GFisMEh+A5JM36h5vwzI9AfE+bbNmsI1jJQIjg63Kl2XZCkUOnazg1stcBSt1g2F/B
        kGORzGj2jqJqLUAjF53Dragxk4kjM8pCR0frezM0yBkPCoB6WesCJE6r/B9rygmxDaO0vR
        +URUuqHP6cHorDGg2yg7KECsXmr+X+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dXoAu7GQXVTWLNML0ZDCTisk4K7XoHyJObObTC90fms=;
        b=mYFsNfNlCAlPVk9uoaYY4HANzUKLEdfBnU/GFntY7jVg1ZQFkotYD6gILk8kz0Wk/TZ9Gf
        AxSAYgNMGjWXlCAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B48B3A3B88;
        Mon,  7 Jun 2021 14:52:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FFA81F2CAC; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/14 v7] fs: Hole punch vs page cache filling races
Date:   Mon,  7 Jun 2021 16:52:10 +0200
Message-Id: <20210607144631.8717-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4536; h=from:subject:message-id; bh=P0xjoHEljjWrXlT5jhnGa40YEfdwjktVMbfSRuehRng=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKWdgDiE/fLVFkWEAkIZkFmQCkqJGxyJZ4ENpOy pv3oapKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4ylgAKCRCcnaoHP2RA2aboB/ sFYL2MHuSq4OG683y+6SRm+HLM9QjIwDQ1mhPrW5rdgFESv6HtB0RLh5l3h9f+oIYyyXM3oFKpTph9 pVTRYbSCjRcrn6WyyqmYousdw2V5l7BgNv92EKKH21ci4zh3ILXKLRhFn07A8MxRdtqNFzQuWhixkc okci90yaAc+nM+whGNX6L3rDA2tCheAsL5Wgrfm95V+SWYP+Co0VG32hpiTIistXxbzJF8CuiSgITE 9P8uLujr6fmaRlblzZRhL132+zFHxO1p319kllneBn3/+NbEZCbgFsVoJrtqCCgWA1lJBF1J84uWhE jnGow/3y6AE3EIzGCNUoZmj/Tcy7pd
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is another version of my patches to address races between hole punching
and page cache filling functions for ext4 and other filesystems. The biggest
change since the last time is providing function to lock two mappings and using
it from XFS. Other changes were pretty minor.

Out of all filesystem supporting hole punching, only GFS2 and OCFS2 remain
unresolved. GFS2 people are working on their own solution (cluster locking is
involved), OCFS2 has even bigger issues (maintainers informed, looking into
it).

As a next step, I'd like to actually make sure all calls to
truncate_inode_pages() happen under mapping->invalidate_lock, add the assert
and then we can also get rid of i_size checks in some places (truncate can
use the same serialization scheme as hole punch). But that step is mostly
a cleanup so I'd like to get these functional fixes in first.

Note that the first patch of the series is already in mm tree but I'm
submitting it here so that the series applies to Linus' tree cleanly.

Changes since v6:
* Added some reviewed-by tags
* Added wrapper for taking invalidate_lock similar to inode_lock
* Renamed wrappers for taking invalidate_lock for two inodes
* Added xfs patch to make xfs_isilocked() work better even without lockdep
* Some minor documentation fixes

Changes since v5:
* Added some reviewed-by tags
* Added functions for locking two mappings and using them from XFS where needed
* Some minor code style & comment fixes

Changes since v4:
* Rebased onto 5.13-rc1
* Removed shmfs conversion patches
* Fixed up zonefs changelog
* Fixed up XFS comments
* Added patch fixing up definition of file_operations in Documentation/vfs/
* Updated documentation and comments to explain invalidate_lock is used also
  to prevent changes through memory mappings to existing pages for some VFS
  operations.

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
Link: https://lore.kernel.org/r/20210413105205.3093-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210423171010.12-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210512101639.22278-1-jack@suse.cz
Link: http://lore.kernel.org/r/20210525125652.20457-1-jack@suse.cz
