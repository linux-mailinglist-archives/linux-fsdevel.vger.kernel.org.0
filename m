Return-Path: <linux-fsdevel+bounces-45285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58621A7585F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 04:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DD016CE40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 02:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041E1CAA4;
	Sun, 30 Mar 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOiMSvi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD52594;
	Sun, 30 Mar 2025 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743301611; cv=none; b=IVhHts/29ERnpOmgoiDgAB/1vcDBTFHavKcrtwGS3DfQAXlkyVkYg/UYSy8mOsto/DkFJSdxykJlOHCWQwN1rBIlRtK5/Vt9zHo7Qrumiokq2yoFhSVUVu13bCUoaZTTD7anfwvE/q5WOyILDLYAnxs5DnNqjNZCkGaoUxJKh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743301611; c=relaxed/simple;
	bh=EFobD5AQ1yUCFJ+RHlw7PYLKARE2ZRGPrzJ7RLpc0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXWWwcSwmJSjr+u1Z9lJP1Y6N/UzhDzbwlo0k3nlGiAaa+6ngKlpaCSAJ1JhzMhVbQljUW8q/5PojP/zPVfmxENnhzGLGm8P8UPj2QoXTGo8M2/7aM3A1j9MXpoLgSrSlkvHd7PZqTfLOredLHsm7fHRrbh3lMD2+QwsIghF7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOiMSvi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D3CC4CEE2;
	Sun, 30 Mar 2025 02:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743301610;
	bh=EFobD5AQ1yUCFJ+RHlw7PYLKARE2ZRGPrzJ7RLpc0KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOiMSvi8RqBbdaEcFst7gXjhCDHp0dZ3ssdDdXDP61AHYBwoxuw370cALCMlk3gA8
	 66vikcOG4dmiAsnhTVeoAsGdKAZtxotnKQqwV/2XqjjgV51ByytlLeQMqwzhZTWKeN
	 jhT9xUH2rRXfTMmuTVExDh6oMkerkWOC7d8nzJvoCeBxkposE75EoICZQcFNtiIiYL
	 H7ztJKinctawb9bXu5/9jBU413ZrM7lPnbzfPiVN/OqVaO5d2LG+YqKCXIw+fbpgqk
	 l0awQDvxn49N4VjKTa1zsfMMKSUnGTCl/x2jW7S9t04zjJl4qejUiJCdkPSS1ERCP2
	 gN9GFmYnvmP1w==
Date: Sat, 29 Mar 2025 19:26:49 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: syzbot <syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com>,
	Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	brauner@kernel.org, hare@suse.de, joel.granados@kernel.org,
	john.g.garry@oracle.com, kees@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	willy@infradead.org
Subject: Re: [syzbot] [mm?] [fs?] BUG: sleeping function called from invalid
 context in folio_mc_copy
Message-ID: <Z-ir6bEgsl2xHfo6@bombadil.infradead.org>
References: <67e57c41.050a0220.2f068f.0033.GAE@google.com>
 <Z-XGWGKJJThjtsXM@bombadil.infradead.org>
 <2ccb9f828ea392eb22f8deb7d9644a4575fa9ee5.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ccb9f828ea392eb22f8deb7d9644a4575fa9ee5.camel@surriel.com>

On Sat, Mar 29, 2025 at 10:05:34PM -0400, Rik van Riel wrote:
> On Thu, 2025-03-27 at 14:42 -0700, Luis Chamberlain wrote:
> > On Thu, Mar 27, 2025 at 09:26:41AM -0700, syzbot wrote:
> > > Hello,
> > 
> > Thanks, this is a known issue and we're having a hard time
> > reproducing [0].
> > 
> > > C reproducer:  
> > > https://syzkaller.appspot.com/x/repro.c?x=152d4de4580000
> > 
> > Thanks! Sadly this has not yet been able to let me reprodouce the
> > issue,
> > and so we're trying to come up with other ways to test the imminent
> > spin
> > lock + sleep on buffer_migrate_folio_norefs() path different ways
> > now,
> > including a new fstests [1] but no luck yet.
> 
> The backtrace in the report seems to make the cause
> of the bug fairly clear, though.
> 
> The function folio_mc_copy() can sleep.
> 
> The function __buffer_migrate_folio() calls
> filemap_migrate_folio() with a spinlock held.
> 
> That function eventually calls folio_mc_copy():
> 
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:8764
>  folio_mc_copy+0x13c/0x1d0 mm/util.c:742
>  __migrate_folio mm/migrate.c:758 [inline]
>  filemap_migrate_folio+0xb4/0x4c0 mm/migrate.c:943
>  __buffer_migrate_folio+0x3ec/0x5d0 mm/migrate.c:874
>  move_to_new_folio+0x2ac/0xc20 mm/migrate.c:1050
>  migrate_folio_move mm/migrate.c:1358 [inline]
>  migrate_folios_move mm/migrate.c:1710 [inline]
> 
> The big question is how to safely release the
> spinlock in __buffer_migrate_folio() before calling
> filemap_migrate_folio()

I suggested a way in the other 0-day reported bug report as that was
the thread that started this investigation [0]. That has survived
20 hours of ext4 with generic/750, and the newly proposed generic/764 [1]
while also using a block device with large folios and runnding dd
against it in a loop.

And so now I'm going to establish an ext4 baseline with kdevops on all
ext4 profiles on linux-next, and then check to see if there are any
regressions with it.

I've localized the new check for only those that need it too. 

[0] https://lkml.kernel.org/r/Z-dHqMtGneCVs3v5@bombadil.infradead.org>
[1] https://lkml.kernel.org/r/20250326185101.2237319-1-mcgrof@kernel.org

Anwyay, below is the latest changes:

From 831f6b15ba9df058a146e26dab757e1b3ed0b3cd Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:12:48 -0700
Subject: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()

When we do page migration of large folios folio_mc_copy() can
cond_resched() *iff* we are on a large folio. There's a hairy
bug reported by both 0-day [0] and  syzbot [1] where it has been
detected we can call folio_mc_copy() in atomic context. While,
technically speaking that should in theory be only possible today
from buffer-head filesystems using buffer_migrate_folio_norefs()
on page migration the only buffer-head large folio filesystem -- the
block device cache, and so with block devices with large block sizes.
However tracing shows that folio_mc_copy() *isn't* being called
as often as we'd expect from buffer_migrate_folio_norefs() path
as we're likely bailing early now thanks to the check added by commit
060913999d7a ("mm: migrate: support poisoned recover from migrate
folio").

*Most* folio_mc_copy() calls in turn end up *not* being in atomic
context, and so we won't hit a splat when using:

CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

But we *want* to help proactively find callers of __migrate_folio() in
atomic context, so make might_sleep() explicit to help us root out
large folio atomic callers of migrate_folio().

Link: https://lkml.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
Link: https://lkml.kernel.org/r/67e57c41.050a0220.2f068f.0033.GAE@google.com # [1]
Link: https://lkml.kernel.org/r/Z-c6BqCSmAnNxb57@bombadil.infradead.org # [2]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 97f0edf0c032..9d6f59cf77f8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -751,6 +751,8 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 {
 	int rc, expected_count = folio_expected_refs(mapping, src);
 
+	might_sleep();
+
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
-- 
2.47.2


From 9e0b9d1100bee47751828c34d0b8a37db1a13d93 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:44:10 -0700
Subject: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()

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
Link: https://lkml.kernel.org/r/Z-ZwToVfJbdTVRtG@bombadil.infradead.org # [1[
Link: https://docs.kernel.org/mm/page_migration.html # [2]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 194eacbefc95..83d5f888a858 100644
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


From 2b5a503593ab64f78936da3fce2f515544b39b0d Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:51:39 -0700
Subject: [PATCH 3/3] mm/migrate: avoid atomic context on
 buffer_migrate_folio_norefs() migration

The buffer_migrate_folio_norefs() should avoid holding the spin lock
held in order to ensure we can support large folios. The prior commit
"fs/buffer: avoid races with folio migrations on __find_get_block_slow()"
ripped out the only rationale for having the atomic context,  so we can
remove the spin lock call now.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9d6f59cf77f8..439aaa610104 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -861,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
-			spin_unlock(&mapping->i_private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -884,8 +884,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	} while (bh != head);
 
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.47.2


