Return-Path: <linux-fsdevel+bounces-43474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70CA5705A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3831898AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666D241698;
	Fri,  7 Mar 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpXKwVnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9423F411
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371716; cv=none; b=Na7CMAJk3qDhc8+jfKB1GItRc78vHW9mL3oXLnYwDCtg79VXNW0wIL7j62ah0uetV7ErDyFWxkhChk+xd6IghR6vMkToA6ZeGSoQsYoK9vP24JxDAcmy/DrhQYstcaZtwxUfsa05eImnjpcZDzBrjPrzlSvuYGEKC4ONpAMODwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371716; c=relaxed/simple;
	bh=xqaO8oqNncJyRRJ4jaLixe2YEvyiUrNlle1x9vdAEW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7R709NGwjZZtyaLhbTfSwW4yDDuGFTmteik3A2FBn5bVU8WDoq2uUS2nOYEOZ+97rgF3hYv8VUxVgUBIcAF4racW/m5uvOdmSDbM2GS2GsjwkLfH9qvEgBlziKJN0QhJnYFj6Txxgw/O02oPwJky2zq4cgzGg1RPnsLiCzaUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rpXKwVnb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BT6OjbtDCOFHHAijJpjMRbh4BDIQM0uytaFHqbNbas4=; b=rpXKwVnb0knBI4GHlLAYlc+0As
	1r+wS9W1bNGX5vr3dqANb97Ev4egsqiYcBMrZMpcMHdxvXeOT+GlGLRqOauWrC/fOToQHAB6wAMkQ
	LLeQ1Fe97u6BfTv3oi9qmBjI8AoQOfNQLfqex9XvOdCyeOVNb+tK/q+bcpCdIZxR+VJ1shsmlH37+
	INDzO5AFPaDBkief51jGwTswtyDWYk3DpZMZvwkUT2HXJjk9BsvjUtFB/WaDSafbKA579GLfszW9Y
	1szDmqnP0vNbSUSJWYWXQ55V7NBuOCrZaeSV/GcuxiEtkzA6Zsl3niMGDFb7SBL3zJYzVz2g4MDXC
	WOMGnKQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqcKX-0000000EFjm-2Iim;
	Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] f2fs: Remove f2fs_write_node_page()
Date: Fri,  7 Mar 2025 18:21:50 +0000
Message-ID: <20250307182151.3397003-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 36614a1c2590..b78c1f95bc04 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1784,13 +1784,6 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 	return err;
 }
 
-static int f2fs_write_node_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __write_node_page(page, false, NULL, wbc, false,
-						FS_NODE_IO, NULL);
-}
-
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)
@@ -2217,7 +2210,6 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
  * Structure of the f2fs node operations
  */
 const struct address_space_operations f2fs_node_aops = {
-	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
 	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2


