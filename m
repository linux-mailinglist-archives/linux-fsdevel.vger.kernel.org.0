Return-Path: <linux-fsdevel+bounces-41934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B6A39320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9647E3AAF63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B861B5ED1;
	Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxlS5iHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484051AF0B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857929; cv=none; b=crUrvS+Gz2qBkMnuiWybHDx7BiqJvTT0SLGiHPj0lUJ96rL7dFPfwNPsc0bGmlSKDck+8RKXPTaO5hSTTq4RqC25X0LyvBwxD3bThbHZW38jARXHx7oLDvPWoihI/LgYIfwvkoyLgYuA6r+S5ak5Vd3APyVzwaa05tjYybO/6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857929; c=relaxed/simple;
	bh=xm9+8F5t5SnHsJ7C0KbWtACD+FI9parFtUT+D7rNomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eigZuFxgDpJIb9r/VZM6Joo11DGNokqU8c/d2bHLp0NDJdFKybfq94kQWQJ9GsJ0hPBJAOle+tcpEzMWpqzuubzpC8ezlla47ziE09GzxVGP1sCR0ClI1u6qA/AjtOp3F5t2+cpV/56Q7uw+aO3o35xUNuzJunYVpsv5h/Okh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OxlS5iHs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8fsH5DarnIkPPvANleakPOl+/DHdlSsWPg4cSSBvLV4=; b=OxlS5iHsxCBRvfY85wh4IGvPLF
	Vn8XUCIiVvmwtwfQg8HIrr5uUoDj2gBhIO9AyU4a9d7D/cRnOjnv/9/BU7zSI1EKyNwOuJ5Yx4IX2
	R9KcKC37ANhB1RGK5EM6hfpm5KES+7lPUy3i9Mp13y9A1jy+9dgG6mpoud56CExCiphE0BPaqPlAD
	//TW8Iwd3cSw/6MphORR0Ndj62ifPnoimkngDXyNRPzxVewrtWQOXOM94iHu/LP9X54bFbONvLW3m
	EafFhtRy+CsreuEGfF0qdEwsW3L+aBnMy7tEU841Tn0B7VTOkYch8hdAc7rhDL+V2Iri9bdgj3dk2
	cFM9j4VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002TrI-3Lw2;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/27] f2fs: Convert f2fs_flush_inline_data() to use a folio
Date: Tue, 18 Feb 2025 05:51:38 +0000
Message-ID: <20250218055203.591403-5-willy@infradead.org>
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

Use the folio APIs where they exist.  Saves several hidden calls to
compound_head().  Also removes a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f88392fc4ba9..522bf84c0209 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1951,32 +1951,27 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 		int i;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 
-			if (!IS_INODE(page))
+			if (!IS_INODE(&folio->page))
 				continue;
 
-			lock_page(page);
+			folio_lock(folio);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-continue_unlock:
-				unlock_page(page);
-				continue;
-			}
-
-			if (!PageDirty(page)) {
-				/* someone wrote it for us */
-				goto continue_unlock;
-			}
+			if (unlikely(folio->mapping != NODE_MAPPING(sbi)))
+				goto unlock;
+			if (!folio_test_dirty(folio))
+				goto unlock;
 
 			/* flush inline_data, if it's async context. */
-			if (page_private_inline(page)) {
-				clear_page_private_inline(page);
-				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+			if (page_private_inline(&folio->page)) {
+				clear_page_private_inline(&folio->page);
+				folio_unlock(folio);
+				flush_inline_data(sbi, ino_of_node(&folio->page));
 				continue;
 			}
-			unlock_page(page);
+unlock:
+			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.47.2


