Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA512FD4F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391199AbhATQID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:08:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:42844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391397AbhATQHB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:07:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB8D9AF31;
        Wed, 20 Jan 2021 16:06:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AA0E91E0802; Wed, 20 Jan 2021 17:06:18 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Date:   Wed, 20 Jan 2021 17:06:08 +0100
Message-Id: <20210120160611.26853-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Amir has reported [1] a that ext4 has a potential issues when reads can race
with hole punching possibly exposing stale data from freed blocks or even
corrupting filesystem when stale mapping data gets used for writeout. The
problem is that during hole punching, new page cache pages can get instantiated
in a punched range after truncate_inode_pages() has run but before the
filesystem removes blocks from the file.  In principle any filesystem
implementing hole punching thus needs to implement a mechanism to block
instantiating page cache pages during hole punching to avoid this race. This is
further complicated by the fact that there are multiple places that can
instantiate pages in page cache.  We can have regular read(2) or page fault
doing this but fadvise(2) or madvise(2) can also result in reading in page
cache pages through force_page_cache_readahead().

There are couple of ways how to fix this. First way (currently implemented by
XFS) is to protect read(2) and *advise(2) calls with i_rwsem so that they are
serialized with hole punching. This is easy to do but as a result all reads
would then be serialized with writes and thus mixed read-write workloads suffer
heavily on ext4. Thus for ext4 I want to use EXT4_I(inode)->i_mmap_sem for
serialization of reads and hole punching. The same serialization that is
already currently used in ext4 to close this race for page faults. This is
conceptually simple but lock ordering is troublesome - since
EXT4_I(inode)->i_mmap_sem is used in page fault path, it ranks below mmap_sem.
Thus we cannot simply grab EXT4_I(inode)->i_mmap_sem in ext4_file_read_iter()
as generic_file_buffered_read() copies data to userspace which may require
grabbing mmap_sem. Also grabbing EXT4_I(inode)->i_mmap_sem in ext4_readpages()
/ ext4_readpage() is problematic because at that point we already have locked
pages instantiated in the page cache. So EXT4_I(inode)->i_mmap_sem would
effectively rank below page lock which is too low in the locking hierarchy.  So
for ext4 (and other filesystems with similar locking constraints - F2FS, GFS2,
OCFS2, ...) we'd need another hook in the read path that can wrap around
insertion of pages into page cache but does not contain copying of data into
userspace.

This patch set implements one possibility of such hook - we essentially
abstract generic_file_buffered_read_get_pages() into a hook. I'm not completely
sold on the naming or the API, or even whether this is the best place for the
hook. But I wanted to send something out for further discussion. For example
another workable option for ext4 would be to have an aops hook for adding a
page into page cache (essentially abstract add_to_page_cache_lru()). There will
be slight downside that it would mean per-page acquisition of the lock instead
of a per-batch-of-pages, also if we ever transition to range locking the
mapping, per-batch locking would be more efficient.

What do people think about this?

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
