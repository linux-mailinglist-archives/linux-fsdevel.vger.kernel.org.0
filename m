Return-Path: <linux-fsdevel+bounces-41938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF78A3932D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C901890BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149B1B043A;
	Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDgJOe83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFE7482
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=dv4YdvIWvqcmii+vXUcYC/aZFSITCs9lCJQ3mV5JPC8LzjrWkXwzoP1OdYte8bYnvK+94WPQV64f6OxkuTQCQdSuGoUGGeJMcCHc38DH60h1pFsjF6wc5wBhAvkhgjEexrhnbho4MgDZb2J5XeBQFGHg16n7HuVLoCwYak53Roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=uL38O1R8SF6xT9zEeJv5DENjSF6b4R89wsanuT8e3Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APOnYyWfN9QCL/LUZwnZTKoFPjZyfd/ZW+RckPfkRHmWCf4gO4Id5QrkiaTsNhgT+cRSEZrddX6++HSac7ptMFtfNhhhQC1q14lM4+1WQSj9UEUexTRzX5MjqLe2bb2IdFkA1aebfUU0qQf8xWzt5f5JDzA6+8zsCn85BzekF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDgJOe83; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mK1rK9VHgwCXb2pvCWp3vRM3/SS+G08uY5YQR+MXCiI=; b=HDgJOe83+MqhmfuCiBO4cn9hoN
	0tDDAGK8VgMvIJubPAbNGh+3jpCx4fXB9+PpeQWr/1gZBXLlRFNUQGqZaOLaiLwD+uRNHvJ8qMLOB
	aRcyiFj+svn6+HkI2OHPplU9eM2yjkKO5zpXivSQyFirdIUV9biB24uh1bVelAqK9ZVh14rDKqixc
	XgqEkPjuke7puapm4hWCZ+8e4eOvKwlfB8BNRfq+6P0p7G5P0sPUq0c2iuh5Y4ESmsBpaI2N15a4K
	jSgL1IogdQgi33ubg85+DOvPDISq+AvM+DDHOr35QM3pX5vzWaOOEACgmVj5G6A0t6WCTTY0FvNeU
	jfi8HxEg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002Tqx-1YKP;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/27] f2fs: Add f2fs_folio_wait_writeback()
Date: Tue, 18 Feb 2025 05:51:35 +0000
Message-ID: <20250218055203.591403-2-willy@infradead.org>
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

Convert f2fs_wait_on_page_writeback() to f2fs_folio_wait_writeback()
and add a compatibiility wrapper.  Replaces five calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h    |  6 ++++--
 fs/f2fs/segment.c | 19 +++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 395f9d37449c..b05653f196dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3760,8 +3760,10 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			struct f2fs_io_info *fio);
 void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 					block_t blkaddr, unsigned int blkcnt);
-void f2fs_wait_on_page_writeback(struct page *page,
-			enum page_type type, bool ordered, bool locked);
+void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
+		bool ordered, bool locked);
+#define f2fs_wait_on_page_writeback(page, type, ordered, locked)	\
+		f2fs_folio_wait_writeback(page_folio(page), type, ordered, locked)
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ebe25eafafa..a29da14c5f19 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4154,22 +4154,21 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	f2fs_update_data_blkaddr(dn, new_addr);
 }
 
-void f2fs_wait_on_page_writeback(struct page *page,
-				enum page_type type, bool ordered, bool locked)
+void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
+		bool ordered, bool locked)
 {
-	if (folio_test_writeback(page_folio(page))) {
-		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	if (folio_test_writeback(folio)) {
+		struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 
 		/* submit cached LFS IO */
-		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
+		f2fs_submit_merged_write_cond(sbi, NULL, &folio->page, 0, type);
 		/* submit cached IPU IO */
-		f2fs_submit_merged_ipu_write(sbi, NULL, page);
+		f2fs_submit_merged_ipu_write(sbi, NULL, &folio->page);
 		if (ordered) {
-			wait_on_page_writeback(page);
-			f2fs_bug_on(sbi, locked &&
-				folio_test_writeback(page_folio(page)));
+			folio_wait_writeback(folio);
+			f2fs_bug_on(sbi, locked && folio_test_writeback(folio));
 		} else {
-			wait_for_stable_page(page);
+			folio_wait_stable(folio);
 		}
 	}
 }
-- 
2.47.2


