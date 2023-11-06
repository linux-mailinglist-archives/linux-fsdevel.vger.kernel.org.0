Return-Path: <linux-fsdevel+bounces-2140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127E7E2B51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20331C20D39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293A2E3EB;
	Mon,  6 Nov 2023 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXXCFxDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3692D025
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:18 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF810DD;
	Mon,  6 Nov 2023 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=h6bp/fpI9MZt0dEiyzYk9ugleWMsOz4HzORTtXlfGKw=; b=FXXCFxDjk7qTLQVqVDLIR/rpAL
	aLEHHFEtJribXy0gOL56NoNA5Zs9slJpnYjHXetQsOnuidyl2b3H9f5zg7zcbzmgD21+tHRzskFgQ
	UOYNsgeFLLLNnPJDH+phuhddBzXQZHRgNC7bk9ZsWxFA0PmKHxYfvozhizCeQsORhJZLrKreMWkaM
	4S3ykDn/v1gp7HdLIf6g6RtTcLckvx4CAtKg4Y4qmzXmyn0MaXxqc0Fwu4tfuaPQfYzdPxml1AMqC
	m9Vwunj17gd3+YTWscU6QRed/3Irm4CN1dY8Ppf56+j52QkgG+HdhZh3O+3MA7vrt44dXtFB4ntcV
	mH4WhetA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z6-007HAH-Oz; Mon, 06 Nov 2023 17:39:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/35] nilfs2: Remove page_address() from nilfs_delete_entry
Date: Mon,  6 Nov 2023 17:38:51 +0000
Message-Id: <20231106173903.1734114-24-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing kmap from directory handling, mask
the directory entry pointer to discover the start address of the
page.  Matches ext2.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 0cf4fe91aebe..07a906d0c786 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -539,7 +539,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
-	char *kaddr = page_address(page);
+	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
 	unsigned int from, to;
 	struct nilfs_dir_entry *de, *pde = NULL;
 	int err;
@@ -559,7 +559,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		de = nilfs_next_entry(de);
 	}
 	if (pde)
-		from = (char *)pde - (char *)page_address(page);
+		from = (char *)pde - kaddr;
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
 	BUG_ON(err);
-- 
2.42.0


