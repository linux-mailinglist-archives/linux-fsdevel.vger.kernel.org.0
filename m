Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3235DDBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhDML31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 07:29:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhDML3V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:29:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 158ABB155;
        Tue, 13 Apr 2021 11:29:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C7B8B1E37A2; Tue, 13 Apr 2021 13:28:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Date:   Tue, 13 Apr 2021 13:28:44 +0200
Message-Id: <20210413105205.3093-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is another version of my patches to address races between hole punching
and page cache filling functions for ext4 and other filesystems. Since the last
posting I've added more documentation and comments regarding the lock ordering
of the new lock (i_mapping_sem) and how is the new lock supposed to be used.
I've also added conversions of ext2, xfs, zonefs so that there is better idea
how the conversion looks for most filesystems. Obviously, there are much more
filesystems to convert but I don't want to do that work unless we have a
concensus this is indeed the right approach. Also as a result of spelling out
locking rules more precisely, I have realized there's no need to use
i_mapping_sem in .page_mkwrite handlers so I've added a bonus patch removing
those - not sure we want to actually do that together with the rest of the
series (maybe we can do this cleanup later when the rest of the conversion has
settled down).

Also when writing the documentation I came across one question: Do we mandate
i_mapping_sem for truncate + hole punch for all filesystems or just for
filesystems that support hole punching (or other complex fallocate operations)?
I wrote the documentation so that we require every filesystem to use
i_mapping_sem. This makes locking rules simpler, we can also add asserts when
all filesystems are converted. The downside is that simple filesystems now pay
the overhead of the locking unnecessary for them. The overhead is small
(uncontended rwsem acquisition for truncate) so I don't think we care and the
simplicity is worth it but I wanted to spell this out.

What do people think about this?

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
