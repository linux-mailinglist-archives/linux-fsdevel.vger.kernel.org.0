Return-Path: <linux-fsdevel+bounces-51502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94326AD745C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA018934C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324224DD1A;
	Thu, 12 Jun 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdFJGAfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455C24DD01
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739152; cv=none; b=HMD5XIGhLWWtzK9UTdbFrgEMfNz01p624HmHbd0MecmCbDt5+jGh68OkwSwJ+mD2lHOf+ftjK8KKHMa7/x72+mafoWjlNnAa0onKoFCEgSUzA4CcGzeHcVtDW8SOC3eowkgmUS1ybg+ZUHVMzDYszCBIJ8CmxsA0UWghyCkWe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739152; c=relaxed/simple;
	bh=GVn9U8rwjOrDSM+qlf6RO8wXspGvuhLKYkRwSuzTsXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py6gMp5JE57eDp2Ie98qwblQ88ON+1VO4OfS44fexfFHipavA/8pRc+M9QyEg9kB27FicDh0Cwak7xkrxmZQZrXqGFDQLVgk22QvT9iKKHBsD44pG/ZEN6ZaUiNjq82tGP38fE6ug/8aFPzuqfIHAv81KK/HVokVKC9eotAs9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MdFJGAfR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=icJ6rwOX2sQfLBzV9+kTzVoN6wgbaWVtGUEDZBqCuHQ=; b=MdFJGAfR8G9uy3ma28FVU5bmma
	wkk2kx0zyHHs0dKjvEVyVhM7aUupHr68U9AuWodqsY10309UGFecusDfy59pdnbUlz+WlpZ73cpOS
	K9SJk+sc94SIFBna7PxLsxbGxpJvwG5EDNNl3qVB72TWEir0o/Mo5na9+0fUEvpXaCq4t5zwZAHwJ
	6IRaGk0/zSVpPGlz4PyMHa28p+qc+M4tQTUb7wKUCJwFXPGGmN3O7lLlXsDDOXt4gr9U17HyqW1Ka
	/ZZVIyGTF5whPPrBk2bFu7avoGPf0zGxPkObNGnW9m+dfQs3+BYcqSHV/aZmeqi9gTaFDEmcATEoV
	xaTVndIA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj57-0000000BxEb-0vbK;
	Thu, 12 Jun 2025 14:39:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Phillip Lougher <phillip@squashfs.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] squashfs: Pass the inode to squashfs_readahead_fragment()
Date: Thu, 12 Jun 2025 15:39:00 +0100
Message-ID: <20250612143903.2849289-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143903.2849289-1-willy@infradead.org>
References: <20250612143903.2849289-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate a reference to page->mapping by passing the inode from
the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 5ca2baa16dc2..ce7d661d5ad8 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -493,10 +493,9 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return res;
 }
 
-static int squashfs_readahead_fragment(struct page **page,
+static int squashfs_readahead_fragment(struct inode *inode, struct page **page,
 	unsigned int pages, unsigned int expected, loff_t start)
 {
-	struct inode *inode = page[0]->mapping->host;
 	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
 		squashfs_i(inode)->fragment_block,
 		squashfs_i(inode)->fragment_size);
@@ -605,8 +604,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		if (start >> msblk->block_log == file_end &&
 				squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
-			res = squashfs_readahead_fragment(pages, nr_pages,
-							  expected, start);
+			res = squashfs_readahead_fragment(inode, pages,
+					nr_pages, expected, start);
 			if (res)
 				goto skip_pages;
 			continue;
-- 
2.47.2


