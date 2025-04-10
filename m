Return-Path: <linux-fsdevel+bounces-46154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D91A83619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA027AE011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7D1E32A2;
	Thu, 10 Apr 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/4PN9sb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E391ADC90;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249794; cv=none; b=MqpYhuC1RS6BNMv4pBhT3RjsKUsaVS0KedraqkM0vWc6/NR4/b5sAXC4NYzx+duhEKGF3YhRGU7/0TfCH4UI6tHjvT/zekLU1R4/cHbrqAoRooDBUBfw2znY+xhHHDjsK9haHxtlWHvE2Hz6xJTzAUx64zfYC9e7bjtK8ZY6VcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249794; c=relaxed/simple;
	bh=ThRGS12HG1C9teSRCGWbQ8jkrJD1nLkUQAc86uUErSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/iV/RpXr5VlO/bIeLkzRYvV7QxuHkjPctfqzpGtm7B52Dvc/1PBfRefYbLK+EbFkaJLpMSByNnquCC8hUSnWjvzLV6Ix38CmexdjhpbctGCqJnVDinq6myeaczhZO+HG8Oxeu6Q6E1mWgUBlIsS0n1hOA8yYNRFsmuIF3CvYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a/4PN9sb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=CL+6HEhZASTZTm0n+Z7z4M5wQOhYNXjmk5hIzXt/heo=; b=a/4PN9sb92D7cFqc3K7oeSik7t
	Q+3oQ2p8GkMhEL/NDp8lQAFxC6bkdTJSMpF0WP0WvzM/+GP/1hKhavztS3KblNtKFvUEjpenwScBe
	Hb1qNVm1TJLT2GecaI6PPeM3SapBsIbUuujrA5qaDs3R2iDv3LFpejYBEfCufwqRvCef1Swk0S2Es
	9c6zatte5dgYw84XvL/jwERxw2Ed9nxrnGkYKolyC2QiGz2KtP2MaTvuitMv2Zhcenq9L8mRvVW3r
	Dbndqjo6JIIUg+j8oo6JD/6d323P3UgBAGgDtmY9129Mgvr9vMfEMQHJt7s+73+P1QI3VfZVZDpCt
	sK63AXDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h35-00000008yv5-3Gk9;
	Thu, 10 Apr 2025 01:49:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
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
	mcgrof@kernel.org,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on migration
Date: Wed,  9 Apr 2025 18:49:38 -0700
Message-ID: <20250410014945.2140781-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Filesystems which use buffer-heads where it cannot guarantees that there
are no other references to the folio, for example with a folio
lock, must use buffer_migrate_folio_norefs() for the address space
mapping migrate_folio() callback. There are only 3 filesystems which use
this callback:

  1) the block device cache
  2) ext4 for its ext4_journalled_aops, ie, jbd2
  3) nilfs2

jbd2's use of this however callback however is very race prone, consider
folio migration while reviewing jbd2_journal_write_metadata_buffer()
and the fact that jbd2:

  - does not hold the folio lock
  - does not have have page writeback bit set
  - does not lock the buffer

And so, it can race with folio_set_bh() on folio migration. The commit
ebdf4de5642fb6 ("mm: migrate: fix reference  check race between
__find_get_block() and migration") added a spin lock to prevent races
with page migration which ext4 users were reporting through the SUSE
bugzilla (bnc#1137609 [0]). Although we don't have exact traces of the
original filesystem corruption we can can reproduce fs corruption on
ext4 by just removing the spinlock and stress testing the filesystem
with generic/750, we eventually end up after 3 hours of testing with
kdevops using libvirt on the ext4 profiles ext4-4k and ext4-2k. It
turns out that the spin lock doesn't in the end protect against
corruption, it *helps* reduce the possibility, but ext4 filesystem
corruption can still happen even with the spin lock held. A test was
done using vanilla Linux and adding a udelay(2000) right before we
spin_lock(&bd_mapping->i_private_lock) on __find_get_block_slow() and
we can reproduce the same exact filesystem corruption issues as observed
without the spinlock with generic/750 [1].

We now have a slew of traces collected for the ext4 corruptions possible
without the current spin lock held [2] [3] [4] but the general pattern
is as follows, as summarized by ChatGPT from all traces:

do_writepages() # write back -->
   ext4_map_block() # performs logical to physical block mapping -->
     ext4_ext_insert_extent() # updates extent tree -->
       jbd2_journal_dirty_metadata()  # marks metadata as dirty for
                                      # journaling. This can lead
                                      # to any of the following hints
                                      # as to what happened from
                                      # ext4 / jbd2

         - Directory and extent metadata corruption splats or

         - Filure to handle out-of-space conditions gracefully, with
           cascading metadata errors and eventual filesystem shutdown
           to prevent further damage.

         - Failure to journal new extent metadata during extent tree
           growth, triggered under memory pressure or heavy writeback.
           Commonly results in ENOSPC, journal abort, and read-only
           fallback. **

         - Journal metadata failure during extent tree growth causes
           read-only fallback. Seen repeatedly on small-block (2k)
           filesystems under stress (e.g. fsstress). Triggers errors in
           bitmap and inode updates, and persists in journal replay logs.
           "Error count since last fsck" shows long-term corruption
           footprint.

** Reproduced on vanilla Linux with udelay(2000) **

Call trace (ENOSPC journal failure):
  do_writepages()
    → ext4_do_writepages()
      → ext4_map_blocks()
        → ext4_ext_map_blocks()
          → ext4_ext_insert_extent()
            → __ext4_handle_dirty_metadata()
              → jbd2_journal_dirty_metadata() → ERROR -28 (ENOSPC)

And so jbd2 still needs more work to avoid races with folio migration.
So replace the current spin lock solution by just skipping jbd buffers
on folio migration. We identify jbd buffers as its the only user of
set_buffer_meta() on __ext4_handle_dirty_metadata(). By checking for
buffer_meta() and bailing on migration we fix the existing racy ext4
corruption while also removing the spin lock to be held while sleeping
complaints originally reported by 0-day [5], and paves the way for
buffer-heads for more users of large folios other than the block
device cache.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1137609 # [0]
Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20250408-ext4-jbd-force-corruption # [1]
Link: https://lkml.kernel.org/r/Z-ZwToVfJbdTVRtG@bombadil.infradead.org # [2]
Link: https://lore.kernel.org/all/Z-rzyrS0Jr7t984Y@bombadil.infradead.org/ # [3]
Link: https://lore.kernel.org/all/Z_AA9SHZdRGq6tb4@bombadil.infradead.org/ # [4]
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com # [5]
Fixes: ebdf4de5642fb6 ("mm: migrate: fix reference  check race between __find_get_block() and migration")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..32fa72ba10b4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -841,6 +841,9 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
+	if (buffer_meta(head))
+		return -EAGAIN;
+
 	if (!buffer_migrate_lock_buffers(head, mode))
 		return -EAGAIN;
 
@@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
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
@@ -880,10 +883,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		folio_set_bh(bh, dst, bh_offset(bh));
 		bh = bh->b_this_page;
 	} while (bh != head);
-
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.47.2


