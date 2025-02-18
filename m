Return-Path: <linux-fsdevel+bounces-41935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F21A39324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAA53AB01D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C21B6CEC;
	Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vOfuj+V8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4A1B043A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857929; cv=none; b=eFAf+hVPspvLMNq7RA6+/ZFPkMLTr2XOpupDP8QZmK13c3fRRguqJ4EL2l2RcgcbPQdLuTm11fiSzIS4nFsjp+TrymAgDUShHWAvyN8jZTV3L5Gl85yr4infkk1yo9fFoWSby1whNR7s2nS+vAizA1EHyXha9bjSr0f6HHLI3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857929; c=relaxed/simple;
	bh=lRpEwQm7hGIok1JBZSUEB1DdfbcJLYi5nP9JZ54elv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPo9V+bFtTPu6+gcKuiASJYInU6CqH+zltjuoKYVVysWsn0VmXlvzGPXDiAADEArE7yw+ObFMJcMp+PLkJW/GGLdvA430vmmlxc1DPLm3ixj/Q2CE6IvUzsFj3moJJcMMrG+KESPEtwz5B2zwVs+PK1CwK4CKcJNj9tiXvEK48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vOfuj+V8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fDqWscxPRQ0KKXzzEQ5kU80x7n6q8Fvwr29XIj71fLI=; b=vOfuj+V8/kOdy/6eNxnEzL+bil
	CHlpYCBeaX/LgRZINmxL4HsYv9ySbzjcbNsXkcKOHlGWWCtov4KZGJ4DaLQJb0c+FG33A9nOJgYca
	4OEvSjoPKusJhYwbi0jnYbFUC0ECAoQQI8kB5v3BPEo8SLgscmkaqU/yJX1uBZowfhiqBNBxiatc9
	e4VLsTWvTl8WWuL1Q4NdfOytupc8XUZBWbo+dVOehrnMvKe3vABMf/1L4Mpmg0kDoj59rtNGLihqK
	TgrZbDeeKZPwaDNIQhnopX1ntnlnE8Yd/0gwP2f5Y7pquaUOPR2iOWUMy1V5PfvzbDAuvflnyCIwi
	N57TkQnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002TrW-0HmO;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/27] f2fs: Pass a folio to flush_dirty_inode()
Date: Tue, 18 Feb 2025 05:51:40 +0000
Message-ID: <20250218055203.591403-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its one caller now has a folio; pass it in and do page conversions where
necessary inside flush_dirty_inode().  Saves two hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6022f9200f4c..1ff6f5888950 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1920,18 +1920,18 @@ static int f2fs_match_ino(struct inode *inode, unsigned long ino, void *data)
 	return 1;
 }
 
-static bool flush_dirty_inode(struct page *page)
+static bool flush_dirty_inode(struct folio *folio)
 {
-	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct inode *inode;
-	nid_t ino = ino_of_node(page);
+	nid_t ino = ino_of_node(&folio->page);
 
 	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL);
 	if (!inode)
 		return false;
 
-	f2fs_update_inode(inode, page);
-	unlock_page(page);
+	f2fs_update_inode(inode, &folio->page);
+	folio_unlock(folio);
 
 	iput(inode);
 	return true;
@@ -2054,7 +2054,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(&folio->page) && flush_dirty_inode(&folio->page))
+			if (IS_INODE(&folio->page) && flush_dirty_inode(folio))
 				goto lock_node;
 write_node:
 			f2fs_folio_wait_writeback(folio, NODE, true, true);
-- 
2.47.2


