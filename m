Return-Path: <linux-fsdevel+bounces-31068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3B991928
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870A282F6C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CF15A85E;
	Sat,  5 Oct 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4Jjw6YF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92FA31
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151348; cv=none; b=O8QMsgusWm2wMRSbZuHLnVzc6ZJp7FRYrUyWXK9N29hwD+TUZYdTdhxBDpiC9aad4EUyBLxHamSCWmqnPumEHQlZsL/Qraq7+W6OLCNmfu68ZZCR4wyGXePF4xcqGXa0JK9e6cBkwXxsToylCpmElf30sSARCcnUg7+gTR6+MCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151348; c=relaxed/simple;
	bh=ZwlmAZjrMhJhmWdLSlfce+9A5uWV1PsoltGGEEexdIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CShYcXGB6aM/9tKyglqjYGYJXpNhOyzOutcsLUCMsgVbkG8sn58T7UExJtgvw+/Oc8UwD8i0795rdZx++8j1ro1HsiNlScTuNmITlAmvBy8m2HaHK6bJU4yjS2Tie5ea6KOBPt29EB8ajhMPC0m4LUc9c6h0sLj3ulwTZHSkuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4Jjw6YF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Rg6wGH/NhIcH6md67KX9ylJkRcAUN2LArvAx9tPJs94=; b=W4Jjw6YFW3hD8GeLMruxziwmFG
	pu5ZePKaJMxF3cMZw+g9IYUeR7/CIWoFapGfXjVygsk3KuSdBtNsjd9md4jb/TIEc52Dwq3XZ8cpe
	qubtuk2glWa7vS0eCos4/Cj8gi1kseK1jATKnqYspbMICsAHNpvhznVO9zoWYo5UqC7QkHVTNo/+G
	ZRNxvRU5bbc2PKHGogECjCDX6ncTLlDAiW7zYVNmJ/pWbIkfQP37zDmlETbarEGr6L1srWvbr01ef
	PKfAS2B7zDy4/s1R3KsxFweISvNJKGGqF3/Zex8hkZ7YQrYj6jtX5k0uB/p8dXIZEfS4dM0PqD3El
	oPk2QfyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96g-0000000DLlc-00iA;
	Sat, 05 Oct 2024 18:02:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] ufs: Convert ufs_change_blocknr() to take a folio
Date: Sat,  5 Oct 2024 19:02:08 +0100
Message-ID: <20241005180214.3181728-6-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005180214.3181728-1-willy@infradead.org>
References: <20241005180214.3181728-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ufs_new_fragments() has a folio, pass it to ufs_change_blocknr()
as a folio instead of converting it from folio to page to folio.
This removes the last use of struct page in UFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/balloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 2abe13d07f85..8709954adb2a 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -234,13 +234,13 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
  * situated at the end of file.
  *
  * We can come here from ufs_writepage or ufs_prepare_write,
- * locked_page is argument of these functions, so we already lock it.
+ * locked_folio is argument of these functions, so we already lock it.
  */
 static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			       unsigned int count, sector_t oldb,
-			       sector_t newb, struct page *locked_page)
+			       sector_t newb, struct folio *locked_folio)
 {
-	struct folio *folio, *locked_folio = page_folio(locked_page);
+	struct folio *folio;
 	const unsigned blks_per_page =
 		1 << (PAGE_SHIFT - inode->i_blkbits);
 	const unsigned mask = blks_per_page - 1;
@@ -466,7 +466,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		ufs_change_blocknr(inode, fragment - oldcount, oldcount,
 				   uspi->s_sbbase + tmp,
-				   uspi->s_sbbase + result, &locked_folio->page);
+				   uspi->s_sbbase + result, locked_folio);
 		*err = 0;
 		write_seqlock(&UFS_I(inode)->meta_lock);
 		ufs_cpu_to_data_ptr(sb, p, result);
-- 
2.43.0


