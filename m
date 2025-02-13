Return-Path: <linux-fsdevel+bounces-41676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1580A34D97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B852C163650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86524292F;
	Thu, 13 Feb 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aakdUFVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADA24292A;
	Thu, 13 Feb 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470998; cv=none; b=V9454mGVuPD/aHig/i7VX9/KInvWbHXaz7dDMFQJR70hIjNH7VnFSHyEAg/IjLmcDcJJi+wYBjPadgNAsGBBZ+4k9ywFVULHkhVSRMg6Jshu2sU8YWmg5kmM9ehy98118Wwsh/2RvWUNO4JOlJ8m+gOj192ej6kL6kkgwiaC1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470998; c=relaxed/simple;
	bh=i/rfAX0LkReKYTYCGLUCM7KMGLOrXYDASByFgX5ufwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQin5pEprBO97olS8Tz40EUYRhuSnszJSDQ3PsUtbQJ33NfufzX+VXYOZXSpXvPhuaOM/HG/O7av3ojOh8rpEl792YAX5wIBuWpGBjUB5EldpqhM7BImwsPzSqXUYrkv6bApykO1AB8783HqY3jQ+AfreLbzCF2fVDhUwW35dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aakdUFVo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=h1uZYi6ABbUB9DnVhYscPgvASRPncF2QfFm5tsKbnwI=; b=aakdUFVoWAftqX4H91sKyVpS5/
	DJZMgd8bM+DzdLpf6B2Qp0R/fDHZNI8gWGCXHpGT1CgZByyb7kfFbF0z5sFfNQkvdynZ3sFz6jxlO
	e0GnlG6Gu5cUbQFaQdof4/KglBybJev9jcwaHzDQUnO8syy1hPtUJQtZS09+G46s00v7dY4OtmiGA
	f+EDk2ksVXtr1tImlomp3OOzUy6zfzbOrOe5CT4wcQgoTgD+GJTSTk8mFrdiW+TFe8wS3zcFjtRa6
	joaZV2wd5T+WsLT4L96vZXunSTYV7CAmGyxeFzQ/CxSFN8fFaQvb0b7E6PxK7IvrV/jrv53f5dSvU
	S+T9nZ7g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tidrg-00000008wy3-1Xlu;
	Thu, 13 Feb 2025 18:23:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ext4: Remove references to bh->b_page
Date: Thu, 13 Feb 2025 18:23:01 +0000
Message-ID: <20250213182303.2133205-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are attached to folios, not to pages.  Also
flush_dcache_page() is now deprecated in favour of flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c   | 2 +-
 fs/ext4/super.c   | 2 +-
 fs/jbd2/journal.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..bd579f46c7f3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -751,7 +751,7 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
 	flags &= EXT4_MAP_FLAGS;
 
 	/* Dummy buffer_head? Set non-atomically. */
-	if (!bh->b_page) {
+	if (!bh->b_folio) {
 		bh->b_state = (bh->b_state & ~EXT4_MAP_FLAGS) | flags;
 		return;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a50e5c31b937..366ce891bcc3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7288,7 +7288,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	}
 	lock_buffer(bh);
 	memcpy(bh->b_data+offset, data, len);
-	flush_dcache_page(bh->b_page);
+	flush_dcache_folio(bh->b_folio);
 	unlock_buffer(bh);
 	err = ext4_handle_dirty_metadata(handle, NULL, bh);
 	brelse(bh);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d8084b31b361..e5a4e4ba7837 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -947,7 +947,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
  * descriptor blocks we do need to generate bona fide buffers.
  *
  * After the caller of jbd2_journal_get_descriptor_buffer() has finished modifying
- * the buffer's contents they really should run flush_dcache_page(bh->b_page).
+ * the buffer's contents they really should run flush_dcache_folio(bh->b_folio).
  * But we don't bother doing that, so there will be coherency problems with
  * mmaps of blockdevs which hold live JBD-controlled filesystems.
  */
-- 
2.47.2


