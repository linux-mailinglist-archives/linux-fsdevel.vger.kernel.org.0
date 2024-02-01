Return-Path: <linux-fsdevel+bounces-9934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1A8463BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEF528D926
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0D47A72;
	Thu,  1 Feb 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LuQf5K9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29653EA78
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827573; cv=none; b=AlKulZpuIBw00peMtJzTYt4MDIhWzRe+vCZ6ombhzHcJhSNFrTwwR5f9xVwL2hNzK/vtlVROL5TbHHp+BOdedj2jWDq9yZ4bBJpphIVfvnp2PMqn0fzLZ6CCFNhE0NEnGa3yBCY2crNioS9RVoHdBXa+XPJkCHMT15RZFNWl6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827573; c=relaxed/simple;
	bh=UfB2rawQ7HEUon+lcJIiNCRfQbmpfq4wBW48ha0bjbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjN4FVGXrJ5crTYzwb7oFvwAkyuDcam7Enw7+4In+HROMhM6Ac8PO1SGqJLCLJIp2H/yo8SpF/ZuSxvC7a0kjKOuMZ7P4PeD5ieMjFJgpHGHPgTF6G4ZN9zTYrCYoVBvkwxsiLfpf8Ha68fbYOWgoe8kTHFxrioC6uUhZRFxAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LuQf5K9s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+rP5ICDvTbI5VMpwtdpo9Ahba8V0v3bnPU9bI2PfmdQ=; b=LuQf5K9sX8Wddic2BnkR8LyutS
	QMn3xXje4s4ytgkA3VZR0S+IKrEg6lT+uO4AJL4vt5n+r8gAopg1zh8iAHnPljjjFdCl7HrMYjNDr
	sTMf8EGriFTi8RvvdH7wRixB8xGZVM6QQK7hibunj/O8tDm/okVMZXgjTlLduRO5/fHO83bJKQd0d
	uU6oEGiMPiuQhPmsJKLFjGsBpiar0YsHYliSkUJGe5BC3N8xGVLsFi7F8uvrC8du8MAhOP9NfPgUn
	NRynQRPykut9sQReT5HQd6zCBNQdPN0SiqP8h2lz6ureumaR9bcPKESJwoNMiLswQJrTTohkU7wqx
	sM7hf1+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfou-0000000H18n-00M3;
	Thu, 01 Feb 2024 22:46:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/13] jfs: Convert page_to_mp to folio_to_mp
Date: Thu,  1 Feb 2024 22:45:58 +0000
Message-ID: <20240201224605.4055895-10-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access folio->private directly instead of testing the page private flag.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 2eb9db0184c1..59729b9dd76f 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -80,11 +80,13 @@ struct meta_anchor {
 };
 #define mp_anchor(page) ((struct meta_anchor *)page_private(page))
 
-static inline struct metapage *page_to_mp(struct page *page, int offset)
+static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
-	if (!PagePrivate(page))
+	struct meta_anchor *anchor = folio->private;
+
+	if (!anchor)
 		return NULL;
-	return mp_anchor(page)->mp[offset >> L2PSIZE];
+	return anchor->mp[offset >> L2PSIZE];
 }
 
 static inline int insert_metapage(struct folio *folio, struct metapage *mp)
@@ -144,9 +146,9 @@ static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
 }
 
 #else
-static inline struct metapage *page_to_mp(struct page *page, int offset)
+static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
-	return PagePrivate(page) ? (struct metapage *)page_private(page) : NULL;
+	return folio->private;
 }
 
 static inline int insert_metapage(struct folio *folio, struct metapage *mp)
@@ -303,7 +305,7 @@ static void last_write_complete(struct folio *folio)
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 		if (mp && test_bit(META_io, &mp->flag)) {
 			if (mp->lsn)
 				remove_from_logsync(mp);
@@ -359,7 +361,7 @@ static int metapage_write_folio(struct folio *folio,
 	folio_start_writeback(folio);
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 
 		if (!mp || !test_bit(META_dirty, &mp->flag))
 			continue;
@@ -526,7 +528,7 @@ static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 	int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 
 		if (!mp)
 			continue;
@@ -620,7 +622,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		folio_lock(folio);
 	}
 
-	mp = page_to_mp(&folio->page, page_offset);
+	mp = folio_to_mp(folio, page_offset);
 	if (mp) {
 		if (mp->logical_size != size) {
 			jfs_error(inode->i_sb,
@@ -804,7 +806,7 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 		if (IS_ERR(folio))
 			continue;
 		for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-			mp = page_to_mp(&folio->page, offset);
+			mp = folio_to_mp(folio, offset);
 			if (!mp)
 				continue;
 			if (mp->index < addr)
-- 
2.43.0


