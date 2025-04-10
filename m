Return-Path: <linux-fsdevel+bounces-46149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38868A8360E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E08A64CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442B1DB55C;
	Thu, 10 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phLch9jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AC78F34;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249792; cv=none; b=iwmqhEWDxAm/Pw8tgq3NWdCi5mcESvgeKd0dSV6impt1cqvCR5PiMmgdqCH44vef6+++t56rStXme/UE/B1ArH+2hn9vLH47HQWKN5AsYfBwhC4Si+KQiba2Wry3dkGgh3CM9pTeDG8YEASXIYPhR0viqx+PmwDDckUVjMnkUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249792; c=relaxed/simple;
	bh=g87H8JA2OOq9l6nYFs8Rw8WPVhcwUIpwnUsZZOyLVYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKEcp8ENB1hWf9hdRu8P71cy06pqZZBB9nKYwKUit5k4kTeuO5pR3uGoCIWVBxSGoEVXMX4r9ewVP62J9PPfkySOZ9tBbdDvqmKSrH1gulP/x5Mu2p4YBA4rQbQES8LFv+YLKfi+2WTc44HChVep7cMrKp78nCkalEL/4eandR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=phLch9jc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xzMVQnlSZLVrjFGORLU1U+D4R5k/13V//cM2BeZORKg=; b=phLch9jcit+F/148sP3LkjXCiZ
	/KwpKJXZqxT7edP+btyTcTvrMUZl1GQP0pguCo6GmdzIW16Yke7+tI3/Wv2kifqdyRUdpjwxHY8Kf
	Ag9kTDteSqT75mrwU89HyrAHr2oWdnrq6YGjXQqjR6tzKiaa+EX7F+L3uusKkSxmIW1G+d8jQ3CvE
	kZ9BVRX8/Yk/up+pVzR+ZGHbejP+a2cJTT/5JSWQ92WS4LMV88u1PCvKXGJu9GX5xl8lAp9vQeQ0d
	kmZIn8BP+CjXxaDUH4zaTbywssOP/ELkdlO3d4/pE4du3xn+AQ9Fmx98q8lH2ZKnk7/5TPZjsMIB5
	VXkVN5wg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h36-00000008yvS-0MvB;
	Thu, 10 Apr 2025 01:49:48 +0000
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
	mcgrof@kernel.org
Subject: [PATCH v2 7/8] mm/migrate: enable noref migration for jbd2
Date: Wed,  9 Apr 2025 18:49:44 -0700
Message-ID: <20250410014945.2140781-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Davidlohr Bueso <dave@stgolabs.net>

Add semantics to enable future optimizations for buffer head noref jbd2
migration. This adds a new BH_Migrate flag which ensures we can bail
on the lookup path. This should enable jbd2 to get semantics of when
a buffer head is under folio migration, and should yield to it and to
eventually remove the buffer_meta() check skipping current jbd2 folio
migration.

Suggested-by: Jan Kara <jack@suse.cz>
Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c                 | 12 +++++++++++-
 fs/ext4/ialloc.c            |  3 ++-
 include/linux/buffer_head.h |  1 +
 mm/migrate.c                |  4 ++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 07ec57ec100e..753fc45667da 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -211,6 +211,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
+	/*
+	 * Upon a noref migration, the folio lock serializes here;
+	 * otherwise bail.
+	 */
+	if (test_bit_acquire(BH_Migrate, &head->b_state)) {
+		WARN_ON(folio_locked);
+		goto out_unlock;
+	}
+
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
@@ -1393,7 +1402,8 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 /*
  * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
  * it in the LRU and mark it as accessed.  If it is not present then return
- * NULL
+ * NULL. Atomic context callers may also return NULL if the buffer is being
+ * migrated; similarly the page is not marked accessed either.
  */
 static struct buffer_head *
 find_get_block_common(struct block_device *bdev, sector_t block,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 38bc8d74f4cc..e7ecc7c8a729 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -691,7 +691,8 @@ static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
 	if (!bh || !buffer_uptodate(bh))
 		/*
 		 * If the block is not in the buffer cache, then it
-		 * must have been written out.
+		 * must have been written out, or, most unlikely, is
+		 * being migrated - false failure should be OK here.
 		 */
 		goto out;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8db10ca288fc..5559b906b1de 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -34,6 +34,7 @@ enum bh_state_bits {
 	BH_Meta,	/* Buffer contains metadata */
 	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
 	BH_Defer_Completion, /* Defer AIO completion to workqueue */
+	BH_Migrate,     /* Buffer is being migrated (norefs) */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
diff --git a/mm/migrate.c b/mm/migrate.c
index 32fa72ba10b4..8fed2655f2e8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -851,6 +851,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		bool busy;
 		bool invalidated = false;
 
+		VM_WARN_ON_ONCE(test_and_set_bit_lock(BH_Migrate,
+						      &head->b_state));
 recheck_buffers:
 		busy = false;
 		spin_lock(&mapping->i_private_lock);
@@ -884,6 +886,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		bh = bh->b_this_page;
 	} while (bh != head);
 unlock_buffers:
+	if (check_refs)
+		clear_bit_unlock(BH_Migrate, &head->b_state);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.47.2


