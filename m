Return-Path: <linux-fsdevel+bounces-6210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E558150AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F21F27431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822875F850;
	Fri, 15 Dec 2023 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="miy2KdKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1B563A4;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eU+CKpTDHM2zoWr8Iu/6jTnTrmbE2V5dKmSdec4HmWI=; b=miy2KdKgA4utgsHuGUGwTLx0dz
	Acc625FaWDqz6kjwPvC6mTFGbM6or6mvD1tKGRypzGaSjQSazNrvrtT4smUCkPtOXXGU3z1hLrrPP
	XoRkZw5GUsiSIqEPKdGqy0b5sHNInqMxIQWNsM9HA8zI29JppKdLqhtbIE4PtbiUkolYkvm6Bs+/l
	/qhImewSf4uXpReKXXZz3p+/nn4XNoxsG6FvVGRc6egVPJR+rGlLAcA2JCW9Lkcul9/ckefuFRyd0
	fznqPAnejnkNGuvVfmTxuzv3tUHyXAg1oeyqyj4wPJVLQyLntLzU2Rm3/JgNpkjawemq6+nSsoAGD
	BprBoiuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOU-0038i6-UQ; Fri, 15 Dec 2023 20:02:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 01/14] fs: Remove clean_page_buffers()
Date: Fri, 15 Dec 2023 20:02:32 +0000
Message-Id: <20231215200245.748418-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function has been unused since the removal of bdev_write_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c                  | 10 ----------
 include/linux/buffer_head.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index ffb064ed9d04..63bf99856024 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -455,16 +455,6 @@ static void clean_buffers(struct page *page, unsigned first_unmapped)
 		try_to_free_buffers(page_folio(page));
 }
 
-/*
- * For situations where we want to clean all buffers attached to a page.
- * We don't need to calculate how many buffers are attached to the page,
- * we just need to specify a number larger than the maximum number of buffers.
- */
-void clean_page_buffers(struct page *page)
-{
-	clean_buffers(page, ~0U);
-}
-
 static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		      void *data)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5f23ee599889..94f6161eb45e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -270,7 +270,6 @@ int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
 void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
-void clean_page_buffers(struct page *page);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, struct page **, void **,
 			get_block_t *, loff_t *);
-- 
2.42.0


