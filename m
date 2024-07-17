Return-Path: <linux-fsdevel+bounces-23844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72202933FED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C14E280EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317261822E2;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BIJizUfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B047A6A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=pi7MH3Fsu/uu3z5rsoh4ogkHMaVoXZDttmkKJSicxXLQQpU9NvmetCdDM9k6IAT1/7iinUb43ydgLESsU1BAUj/JfzaKmjodyRtxRTWi3OFzhS0WdhZ73kdq7PerZYi95waV/LhjXImAHlcyvU1WBr+4Bms+8X7sqpwi3suBzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=+VgVyJxjCw8ZFhVh7CjI7zfC0/aKWy8k72+sya6ji5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8GXQHn4lqd/+HoMewhroffvndL0osE9z8dZpJMtc57iU1KeTf0txi5HfRAbPPIj3F95gi/uSuGM1MMEHhS9gGo1jlUBFWrpgwjfVT34gX+JLmTvfir4VpR955YWsjY6LzfUtS1p2DEcd3bu9eI3dY3AUYHRESioATZOOHThFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BIJizUfb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wu2kHCkbuFNuuFSE/BTgFFOTPUjajjcysXiKnlnOy1s=; b=BIJizUfb8PievpsnQYPpNCJ/Nd
	XlNaqYzhvv0jcmjXYb0UWlIrOgaNyH/TUjjjmqjkIPG+PUlfIJZJq7h5thj7nAcKXx/Zn9GWbqJKc
	FQp3IF2z6pK1WkB9mfjwlDGw9Qq7eJhX/cTk06ZRSUbie+DcBusKQT9xLuEGuwpgBgd55ttxxezGC
	D1DBCLyF0ypT4kqC0whaU97hBAE7H5dpIiQ9nQomNSdNLZIaQnh0jPkNqom/mYorXrZIMeVrS9Rel
	AdV28stTcOoww9uxqUpsEN3Z/5b+DLD4vrvIxL1RKaNkVBTs76UI3xqZS4b1OLuMXu4qZIb3tb0Gr
	Y3B0cthQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zuJ-1jh4;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/23] nilfs2: Use a folio in nilfs_recover_dsync_blocks()
Date: Wed, 17 Jul 2024 16:46:55 +0100
Message-ID: <20240717154716.237943-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces four hidden calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/recovery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index b638dc06df2f..15653701b1c8 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -499,6 +499,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 	struct nilfs_recovery_block *rb, *n;
 	unsigned int blocksize = nilfs->ns_blocksize;
 	struct page *page;
+	struct folio *folio;
 	loff_t pos;
 	int err = 0, err2 = 0;
 
@@ -522,6 +523,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
+		folio = page_folio(page);
 		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
@@ -533,15 +535,15 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		block_write_end(NULL, inode->i_mapping, pos, blocksize,
 				blocksize, page, NULL);
 
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
 		(*nr_salvaged_blocks)++;
 		goto next;
 
  failed_page:
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
  failed_inode:
 		nilfs_warn(sb,
-- 
2.43.0


