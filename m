Return-Path: <linux-fsdevel+bounces-46524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B230A8AC3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5867D165466
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA3F2D1F5A;
	Tue, 15 Apr 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pdkeFYN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3928F532;
	Tue, 15 Apr 2025 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759975; cv=pass; b=S/iqtaNK7881H1CcOD4Pg9bKhSAwv7kA4Up3GA+ijHBTfdp/EqBU+f34hPj6QK3eEf5NJe0+xR9N4RIp6sk6jvXmB1BD5FzQ085+6AN0LRmJNZ3U0G3/e2NwXFUZO0cl2GD33pWoTFklCxUR3x2boZEgmxiuCFH2ptmn+cibHPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759975; c=relaxed/simple;
	bh=dShK0AUJCpQQ7rzwY5YV2P4tffllkNK38aHi61tgYB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4LPCfy3XgjVHdE8cp2T05pZK8Kd34jleXoDf2J4+RUosV2qsUm1D4V5vamGRqFP7+OI/wMzxLxsXKVrQuexVToON5SEtWA7UtxqBxZDCgQQyRy57SnUO+chz/nhzyqeachjrDf73Em62/36ONjcMzQ3hLF549nQXApw2+fXNQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pdkeFYN+; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D86C844C70;
	Tue, 15 Apr 2025 23:16:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.110.51.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 145DA844C93;
	Tue, 15 Apr 2025 23:16:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759009; a=rsa-sha256;
	cv=none;
	b=BhEJiJtFvkCwq8VAse19aBQiUxhkx3I+5R6HPsmqZf4e7aKwSiPPW986q2HE3kFNsRKNN+
	CdfsNyJflEjavG33gCOm3aagchhCTRZDQsmsYDhQrVrS3YDc3D83CH8qXnfSqlJSWEFCwQ
	BAuiAebIKU36eG4L/2+jS4bFiSL6ap7/RY0lfPzATrkk+gG//gk2eCRvwHz/bvKAeUwy2O
	LztYFVMd88BfEaCPwhNC4l8tpMfN6HArgsnllkMyrgGuyaavWLatDR/edgfuhVMiictH0v
	HeefL/cKCyEyHtfkDDuAXLn2s6+YQU6DIBe1TIvPlvL9ViasagE8gE5uCYkpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cZxBayk/19ttKico+tYOcz6z5i5bd/KpteFdnFTioS4=;
	b=pwDyEFNKwZLvyNhomSgsA6Ch2JWc8J52qbKwVcFPj0Y6P7DTPH4++Hmj2H6BB/PL6KlNkN
	LzWPKmCveLupB2BZIPV6pfrWXrL1r3bW8ZJw43YHHLOtUCKKcGZLakiXg7C0B1fxMErIzW
	ifiBIjuHPfQIKiYdMcclddyU+UxOfndgfY4ZyGCOKUoIF9F+5GA7Y0Yv7uAeFGzt3tjPXl
	jCSz4lr6R8Y8Oqn6eNJOzJZXVa7GtBVpqV9vSxeCe6IotUVyiK/okDPirc1haqWpudz+F6
	uqr1nVUCThwP4SDd+8+zflSksqc9IalFfqyCUMIN6j9NXJje2i7q2LNAV7x+0A==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-qrpj4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Madly: 0f7b40494fe41933_1744759009477_58974177
X-MC-Loop-Signature: 1744759009477:425026726
X-MC-Ingress-Time: 1744759009477
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.173 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:49 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5r0xWMz6g;
	Tue, 15 Apr 2025 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759008;
	bh=cZxBayk/19ttKico+tYOcz6z5i5bd/KpteFdnFTioS4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pdkeFYN+hvN6eTdJcNTCB0qKBgYHTg9M+wgnCHctw021Kq4TJBluwwznOkT4fiuae
	 GioaEn1QRUFTyxxL9XY3Zj0XBm3PRV1Pm7rA+ilF/HBh6CP6lPiBPzOUkxXS1lA5iQ
	 XCJgOHetlIP/kzdCjG5saON6RQClPMhB2BtsKBTwB6lsVAsqwhOq8297Sqc+kcQqwX
	 VMNC4PQ2Eu+LJmiD//KZvW4/343ykgSTNa6QsEr0HI/YfOm5HitgLPdjITEbRGYsPE
	 /aHt8eiK7FnTF0eOS6rGtlz2tQXeHNp0v3wVfnnolphExHswtWkYeQUEP+SG/puId5
	 60/AllAEwQfww==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	kernel test robot <oliver.sang@intel.com>,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: [PATCH 7/7] mm/migrate: fix sleep in atomic for large folios and buffer heads
Date: Tue, 15 Apr 2025 16:16:35 -0700
Message-Id: <20250415231635.83960-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The large folio + buffer head noref migration scenarios are
being naughty and blocking while holding a spinlock.

As a consequence of the pagecache lookup path taking the
folio lock this serializes against migration paths, so
they can wait for each other. For the private_lock
atomic case, a new BH_Migrate flag is introduced which
enables the lookup to bail.

This allows the critical region of the private_lock on
the migration path to be reduced to the way it was before
ebdf4de5642fb6 ("mm: migrate: fix reference  check race
between __find_get_block() and migration"), that is covering
the count checks.

The scope is always noref migration.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
Fixes: 3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c                 | 12 +++++++++++-
 fs/ext4/ialloc.c            |  3 ++-
 include/linux/buffer_head.h |  1 +
 mm/migrate.c                |  8 +++++---
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f8e63885604b..b8e1e6e325cd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -207,6 +207,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
+	/*
+	 * Upon a noref migration, the folio lock serializes here;
+	 * otherwise bail.
+	 */
+	if (test_bit_acquire(BH_Migrate, &head->b_state)) {
+		WARN_ON(!atomic);
+		goto out_unlock;
+	}
+
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
@@ -1390,7 +1399,8 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
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
index c791aa9a08da..0029ff880e27 100644
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
index 6e2488e5dbe4..c80591514e66 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -845,9 +845,11 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		return -EAGAIN;
 
 	if (check_refs) {
-		bool busy;
+		bool busy, migrating;
 		bool invalidated = false;
 
+		migrating = test_and_set_bit_lock(BH_Migrate, &head->b_state);
+		VM_WARN_ON_ONCE(migrating);
 recheck_buffers:
 		busy = false;
 		spin_lock(&mapping->i_private_lock);
@@ -859,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
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
@@ -883,8 +885,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 
 unlock_buffers:
 	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
+		clear_bit_unlock(BH_Migrate, &head->b_state);
 	bh = head;
 	do {
 		unlock_buffer(bh);
--
2.39.5


