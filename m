Return-Path: <linux-fsdevel+bounces-45287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87299A758C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85462188D27E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53216F858;
	Sun, 30 Mar 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBxP2tPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B07139CE3;
	Sun, 30 Mar 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743317267; cv=none; b=Gtjezmmvef9VNtSP3PcN/PmgE4vyugxWZ76CV6k5cwQYVsAoH6tb2AoF5C6wpK5Rz3EFeMR4/52F6qmzcLSxnz6UeL5llMbx/6N6c+9wqcV+q65p3E2iEYNj06QWNecC1qsRWCyfuX8N3fTUs97q4SQSwGld7ETZQVjIM2MN4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743317267; c=relaxed/simple;
	bh=hretjSWQI7P2S01UFhs23PCifJqwZ4IhtqvxLasC3K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT1tu5BrIrcwALKEqmg1J4mav//iZhqKFgXw04Z2O+i4Yk913td8vf9K1ahDHsk5yFR5WWIo1mVQGRrvPncm/aQiA3euMhxgfz2/JuCGL2i2zcpMWVonBnDPR8kr74dJmxnMuupALgmrW5RBWNTFq7xVj0QwMGCEs1Ms58e2zOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lBxP2tPR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WvkQNL4UoSpr5M5OPz09tyQKaqGswnC535CSvTx1frY=; b=lBxP2tPRv807B6pteDVfoVeW5l
	t4xF5y51y4CUe/vc1YBpuGNECtVgw+G170yWqRio9Mv/QAem9zmMb4zZvbOBXaxM1MG+ViVD4JKwD
	ycA7sYi9LNkc3nzxgkPZyrgdzBa/BiTBP/R2rLjcNDAVfLBh95kcWnxkNdd4ErC3PkJQJQf67q1JL
	9vZfG2UEQIPeOYARpuJm9XjpKWeyv8K0wfXS7ER2bATXEymH3woDQXvYRFhT9NVto9IAW1T5y/r2E
	/X/t2mnrOzTvAxzj5vBvz3ZvsnNAcUmLWNilcgb33fYF8dnFYD8C3Ljl4FbaoPmIJqSQN94PK5PJF
	h90GRUWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tymSJ-0000000FreC-2FwG;
	Sun, 30 Mar 2025 06:47:39 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	dave@stgolabs.net,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 2/3] fs/buffer: avoid races with folio migrations on __find_get_block_slow()
Date: Sat, 29 Mar 2025 23:47:31 -0700
Message-ID: <20250330064732.3781046-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330064732.3781046-1-mcgrof@kernel.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Filesystems which use buffer-heads where it cannot guarantees that the
there are no other references to the folio, for example with a folio
lock, must use buffer_migrate_folio_norefs() for the address space
mapping migrate_folio() callback. There are only 3 filesystems which use
this callback:

  1) the block device cache
  2) ext4 for its ext4_journalled_aops
  3) nilfs2

The commit ebdf4de5642fb6 ("mm: migrate: fix reference  check race
between __find_get_block() and migration") added a spin lock to
prevent races with page migration which ext4 users were reporting
through the SUSE bugzilla (bnc#1137609 [0]). Although implicit,
the spinlock is only held for users of buffer_migrate_folio_norefs()
which was added by commit 89cb0888ca148 ("mm: migrate: provide
buffer_migrate_page_norefs()") to support page migration on block
device folios. Later commit dae999602eeb ("ext4: stop providing
.writepage hook") made ext4_journalled_aops use the same callback.
It is worth elaborating on why ext4 journalled aops uses this:

    so that buffers cannot be modified under jdb2's hands as that can
    cause data corruption. For example when commit code does writeout
    of transaction buffers in jbd2_journal_write_metadata_buffer(), we
    don't hold page lock or have page writeback bit set or have the
    buffer locked. So page migration code would go and happily migrate
    the page elsewhere while the copy is running thus corrupting data.

Although we don't have exact traces of the filesystem corruption we
can can reproduce fs corruption one ext4 by just removing the spinlock
and stress testing the filesystem with generic/750, we eventually end
up after 3 hours of testing with kdevops using libvirt on the ext4
profile ext4-4k. Things like the below as reported recently [1]:

Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
<-- etc -->
Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
Mar 28 06:04:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 06:42:05 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)

The block device cache is a user of buffer_migrate_folio_norefs()
and it supports large folios, in that case we can sleep on
folio_mc_copy() on page migration on a cond_resched(). So we want
to avoid requiring a spin lock even on the buffer_migrate_folio_norefs()
case so to enable large folios on buffer-head folio migration.
To address this we must avoid races with folio migration in a
different way.

This provides an alternative by avoiding giving away a folio in
__find_get_block_slow() on folio migration candidates so to enable us
to let us later rip out the spin_lock() held on the folio migration
buffer_migrate_folio_norefs() path. We limit the scope of this sanity
check only for filesystems which cannot provide any guarantees that
there are no references to the folio, so only users of the folio
migration callback buffer_migrate_folio_norefs().

Although we have no direct clear semantics to check if a folio is
being evaluated for folio migration we know that folio migration
happens LRU folios [2]. Since folio migration must not be called
with folio_test_writeback() folios we can skip these folios as well.
The other corner case we can be concerned is for a drive implement
mops, but the docs indicate VM seems to use lru for that too.
A real concern to have here is if the check is starving readers or
writers who  want to read a block into the page cache and it
is part of the LRU. The path __getblk_slow() will first try
__find_get_block() which uses __filemap_get_folio() without FGP_CREAT,
and if it fails it will call grow_buffers() which calls again
__filemap_get_folio() but with with FGP_CREAT now, but
__filemap_get_folio() won't create a folio for us if it already exists.
So  if the folio was in LRU __getblk_slow()  will essentially end up
checking again for the folio until its gone from the page cache or
migration ended, effectively preventing a race with folio migration
which is what we want.

This commit and the subsequent one prove to be an alternative to fix
the filesystem corruption noted above.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1137609 # [0]
Link: https://lkml.kernel.org/r/Z-ZwToVfJbdTVRtG@bombadil.infradead.org # [1]
Link: https://docs.kernel.org/mm/page_migration.html # [2]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..a4e4455a6ce2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -208,6 +208,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
+
+	if (folio->mapping->a_ops->migrate_folio &&
+	    folio->mapping->a_ops->migrate_folio == buffer_migrate_folio_norefs) {
+		if (folio_test_lru(folio) &&
+		    folio_test_locked(folio) &&
+		    !folio_test_writeback(folio))
+			goto out_unlock;
+	}
+
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
-- 
2.47.2


