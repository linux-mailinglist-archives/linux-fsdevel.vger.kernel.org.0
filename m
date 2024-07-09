Return-Path: <linux-fsdevel+bounces-23405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D763292BDD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D0B2E4D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E519D074;
	Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrnUgGSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5919CCEC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=OqkCWjhF7mIIzbgrhWNMINaA46dyCexs/viLFGC9wbIvPzDD7ZfggbpkMKgT0tcKWOgZhy/+0sXM1fXhcUcPVGYoOn99wBTsUtqven1uzfNtea0oYfYzWVB6sBncIm6eHbn1Bqk0u2IptEXup4CtrQbz/O6xBKKeK1I+FaXJUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=v2tNyUkP3KSJhx/1ZB1TFE/82Ojvyt/eXWK/VKhaTfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/7kHyJzr0Z3Ud1RdN2vmAAasb+vBGzFpHyqGrq7zrRsNX2QJEVWIQfGb3YC8YB37sPdhz7jNHn+j531Crn1qEwynwdwgQ4sC5jNp+ueZyGLVqiIwlvCImNrRq7K+r+XR59du0rr6mvcCYax60MgpP8DP+7aAphz6KklAG6CUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UrnUgGSs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=iXX71Zvhf734SndPuAiOuMl7U4rwU9SGjy7BFabuU4w=; b=UrnUgGSsos/oz2+OqIUtOaIHLM
	QrRh/YLr8KgvZKOtLzdNiQ/886yF+aBaBqtXKChk1qeonPQVFoa7kzNhhZD9OxlDEeFMtRaOxPoLo
	bkBgMWfIQWgN+p5jkuGXtz76yq34gX2rsDN4ZTYzSMSi9nESyL1aAAtpT5lLmOaZrGfc2Xgj931kw
	g4vVUS5CtMIDaem+fh/ibiE1nu2Y4Lw4YoTQLJJBme5mpUngCEVT2t5YwrP7LzvMEDoPTjNK5xrAD
	qNexKqiD7aKN+Zja7EIIEISbZVK+GOnTGHcqZb5uEzRrBpNqH0ohScz81Sdjz6rjXXzh+fpHZtYYH
	7yt9Nl8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCNA-00000007zsG-0BDF;
	Tue, 09 Jul 2024 15:03:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] sysv: Convert sysv_make_empty() to use a folio
Date: Tue,  9 Jul 2024 16:03:10 +0100
Message-ID: <20240709150314.1906109-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/sysv/dir.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 0b5727510bdd..5f91a82a2966 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -252,33 +252,33 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
 
 int sysv_make_empty(struct inode *inode, struct inode *dir)
 {
-	struct page *page = grab_cache_page(inode->i_mapping, 0);
+	struct folio *folio = filemap_grab_folio(inode->i_mapping, 0);
 	struct sysv_dir_entry * de;
-	char *base;
+	char *kaddr;
 	int err;
 
-	if (!page)
-		return -ENOMEM;
-	err = sysv_prepare_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	err = sysv_prepare_chunk(&folio->page, 0, 2 * SYSV_DIRSIZE);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto fail;
 	}
-	base = kmap_local_page(page);
-	memset(base, 0, PAGE_SIZE);
+	kaddr = kmap_local_folio(folio, 0);
+	memset(kaddr, 0, folio_size(folio));
 
-	de = (struct sysv_dir_entry *) base;
+	de = (struct sysv_dir_entry *)kaddr;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	strcpy(de->name,".");
 	de++;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
 
-	kunmap_local(base);
-	dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	kunmap_local(kaddr);
+	dir_commit_chunk(&folio->page, 0, 2 * SYSV_DIRSIZE);
 	err = sysv_handle_dirsync(inode);
 fail:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.43.0


