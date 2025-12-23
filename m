Return-Path: <linux-fsdevel+bounces-71997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA3CDAC22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3824130215B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8D310779;
	Tue, 23 Dec 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRQ24bOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500C2D9496;
	Tue, 23 Dec 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766529029; cv=none; b=DervO2ni2j93qeBgW9dMInbwZKXspM4EpJ0pPmD692CzSPlKU55xCNSnqYgBwwuiFvOYTKlDIBFKgkIUOIOi83Y1P5lFEMY9VVObAuAlVkSp2vi+sZdE10hrPgLoWenQfA3GtoY8nWn98BwvBKzOEZ7jVEGj1WZRUldfOgdbnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766529029; c=relaxed/simple;
	bh=Fsjn4kV1EgkkSfygfX3m/iD7nreZcr3DX+3eT1LR3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbLATpzYr6WNMLtMi5nos/6+S/XCPRqkWtXyx4WzK8zhZtggd3+jhV9WRslLdo1SmjzrdXRz65aD4DlP3tgalugXQB/vhKdQPm7js2CiT07NthAYa9Iq+GJ9YC/v64Xv4wui7D5BMNFE1ee0aaZ/t0j5e2vLXkKlu1S8FVO6Jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRQ24bOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493A2C116B1;
	Tue, 23 Dec 2025 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766529028;
	bh=Fsjn4kV1EgkkSfygfX3m/iD7nreZcr3DX+3eT1LR3nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRQ24bOzYdn115M1RgX5IExbfh4ZRz2WmXU5MgZAe/pbNINRA6/4LNHpgIJdpnIHE
	 fR/LC548fc8dTX+LHyeMLDyAwFNteQRh2t1gnZIDdy/Bnev89WrpNYV/UmclK9C4NM
	 ovfiMcUGD0514dhxnaec+FiDqqp96/WqrrhQ494wXqASR3PxqYSp3VENEAZBa5eh9i
	 qhphBM2l/NkKP5LTkTpgIqXA0d1PUKuKuTonumMUW65AgKLWBDJHzY3DQvVO6A1LLu
	 GV8dz6xeONKs58Opn1yYrDcPBV1KldCBcYmRJ4JnIHDXOsd0mp5Ad8vOCpt+smzmR0
	 CfP3fTYNVXVVw==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com
Cc: willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate and folio_end_read
Date: Tue, 23 Dec 2025 17:30:17 -0500
Message-ID: <20251223223018.3295372-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223223018.3295372-1-sashal@kernel.org>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iomap uses large folios, per-block uptodate tracking is managed via
iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
to become inconsistent with the folio's uptodate flag.

The race occurs because folio_end_read() uses XOR semantics to atomically
set the uptodate bit and clear the locked bit:

  Thread A (read completion):          Thread B (concurrent write):
  --------------------------------     --------------------------------
  iomap_finish_folio_read()
    spin_lock(state_lock)
    ifs_set_range_uptodate() -> true
    spin_unlock(state_lock)
                                       iomap_set_range_uptodate()
                                         spin_lock(state_lock)
                                         ifs_set_range_uptodate() -> true
                                         spin_unlock(state_lock)
                                         folio_mark_uptodate(folio)
    folio_end_read(folio, true)
      folio_xor_flags()  // XOR CLEARS uptodate!

Result: folio is NOT uptodate, but ifs says all blocks ARE uptodate.

Fix by checking read_bytes_pending in iomap_set_range_uptodate() under the
lock. If a read is in progress, skip calling folio_mark_uptodate() - the
read completion path will handle it via folio_end_read().

The warning was triggered during FUSE-based filesystem (e.g., NTFS-3G)
unmount when the LTP writev03 test was run:

  WARNING: fs/iomap/buffered-io.c at ifs_free
  Call trace:
   ifs_free
   iomap_invalidate_folio
   truncate_cleanup_folio
   truncate_inode_pages_range
   truncate_inode_pages_final
   fuse_evict_inode
   ...
   fuse_kill_sb_blk

Fixes: 7a4847e54cc1 ("iomap: use folio_end_read()")
Assisted-by: claude-opus-4-5-20251101
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c          |  3 +-
 fs/fuse/file.c         |  6 ++--
 fs/iomap/buffered-io.c | 65 +++++++++++++++++++++++++++++++++++++++---
 include/linux/iomap.h  |  2 ++
 4 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..50e84e913589 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -11,6 +11,7 @@
 #include "fuse_dev_i.h"
 
 #include <linux/init.h>
+#include <linux/iomap.h>
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
@@ -1820,7 +1821,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (nr_bytes == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, nr_bytes, folio_size(folio));
-			folio_mark_uptodate(folio);
+			iomap_set_range_uptodate(folio, 0, folio_size(folio));
 		}
 		folio_unlock(folio);
 		folio_put(folio);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..3abe38416199 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1216,13 +1216,13 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		struct folio *folio = ap->folios[i];
 
 		if (err) {
-			folio_clear_uptodate(folio);
+			iomap_clear_folio_uptodate(folio);
 		} else {
 			if (count >= folio_size(folio) - offset)
 				count -= folio_size(folio) - offset;
 			else {
 				if (short_write)
-					folio_clear_uptodate(folio);
+					iomap_clear_folio_uptodate(folio);
 				count = 0;
 			}
 			offset = 0;
@@ -1305,7 +1305,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full folio, mark it uptodate */
 		if (tmp == folio_size(folio))
-			folio_mark_uptodate(folio);
+			iomap_set_range_uptodate(folio, 0, folio_size(folio));
 
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d93..7ceda24cf6a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -74,8 +74,7 @@ static bool ifs_set_range_uptodate(struct folio *folio,
 	return ifs_is_fully_uptodate(folio, ifs);
 }
 
-static void iomap_set_range_uptodate(struct folio *folio, size_t off,
-		size_t len)
+void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	unsigned long flags;
@@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
 		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		/*
+		 * If a read is in progress, we must NOT call folio_mark_uptodate
+		 * here. The read completion path (iomap_finish_folio_read or
+		 * iomap_read_end) will call folio_end_read() which uses XOR
+		 * semantics to set the uptodate bit. If we set it here, the XOR
+		 * in folio_end_read() will clear it, leaving the folio not
+		 * uptodate while the ifs says all blocks are uptodate.
+		 */
+		if (uptodate && ifs->read_bytes_pending)
+			uptodate = false;
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
 	if (uptodate)
 		folio_mark_uptodate(folio);
 }
+EXPORT_SYMBOL_GPL(iomap_set_range_uptodate);
+
+void iomap_clear_folio_uptodate(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		struct inode *inode = folio->mapping->host;
+		unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+		unsigned long flags;
+
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		/*
+		 * If a read is in progress, don't clear the uptodate state.
+		 * The read completion path will handle the folio state, and
+		 * clearing here would race with iomap_finish_folio_read()
+		 * potentially causing ifs/folio uptodate state mismatch.
+		 */
+		if (ifs->read_bytes_pending) {
+			spin_unlock_irqrestore(&ifs->state_lock, flags);
+			return;
+		}
+		bitmap_clear(ifs->state, 0, nr_blocks);
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+	folio_clear_uptodate(folio);
+}
+EXPORT_SYMBOL_GPL(iomap_clear_folio_uptodate);
 
 /*
  * Find the next dirty block in the folio. end_blk is inclusive.
@@ -399,8 +436,17 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (finished)
+	if (finished) {
+		/*
+		 * If uptodate is true but the folio is already marked uptodate,
+		 * folio_end_read's XOR semantics would clear the uptodate bit.
+		 * This should never happen because iomap_set_range_uptodate()
+		 * skips calling folio_mark_uptodate() when read_bytes_pending
+		 * is non-zero, ensuring only the read completion path sets it.
+		 */
+		WARN_ON_ONCE(uptodate && folio_test_uptodate(folio));
 		folio_end_read(folio, uptodate);
+	}
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
@@ -481,8 +527,19 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 		if (end_read)
 			uptodate = ifs_is_fully_uptodate(folio, ifs);
 		spin_unlock_irq(&ifs->state_lock);
-		if (end_read)
+		if (end_read) {
+			/*
+			 * If uptodate is true but the folio is already marked
+			 * uptodate, folio_end_read's XOR semantics would clear
+			 * the uptodate bit. This should never happen because
+			 * iomap_set_range_uptodate() skips calling
+			 * folio_mark_uptodate() when read_bytes_pending is
+			 * non-zero, ensuring only the read completion path
+			 * sets it.
+			 */
+			WARN_ON_ONCE(uptodate && folio_test_uptodate(folio));
 			folio_end_read(folio, uptodate);
+		}
 	} else if (!bytes_submitted) {
 		/*
 		 * If there were no bytes submitted, this means we are
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb501..3c2ad88d16b6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -345,6 +345,8 @@ void iomap_read_folio(const struct iomap_ops *ops,
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
+void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t len);
+void iomap_clear_folio_uptodate(struct folio *folio);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
-- 
2.51.0


