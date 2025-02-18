Return-Path: <linux-fsdevel+bounces-41944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B979A39332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED00189184C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC941C1F0D;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZyrIhcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D81B21B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=OIkj1bIWr90b8OmqIMRrMBrU+6mnkkonNlvxruDMrRuUJ/pS1gN/+7zWVHkEmLtUPh5p0r486Nf6T3K1yDdvnefFWEpw45jj7JqANUSWUOsyLVxKMeIwsHREh/yDW/oGHfC6QVxKuXt7+xnfpGewOb1Y9EUQ03nqJ6d+gME6Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=2FBRVOUolLZ0ToE3BWuYkgPAdEvPoeqWSFcPo/N7Chw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kp0DHRUgrQgQAHf2NO7084u6hWDdiWshH3dzDlELW+J2kGhcCEfAjkyFAOJ9lBPpOy/ywgJMhsqzfHsNsiEb17JUP+g4RumgVouSnFEVDq/cq57mYXuHnSXErOcYbp2eayM0bez7LaPZyh8WB8YKRrnJeg4f6vt17cAt3RYEsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZyrIhcc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mxcT87qzqMqEF0E5qIM4Iboa5YWipVr/RZOEFYdP3iw=; b=DZyrIhccJeGOJDnCE/gaJLJMWD
	if7gTSLmZYa//ywHTpcVaZB2YmZ89Fhz3VbFEouF+LGLEBRzP0ApRxWltndG2gfi0xMRvV5BBn6iy
	CDVIDBl4e0OJOVrcANv/VQ9owsyjR1P5jBauGX0q277lXZ8hbycxXgcU02sjgIz6nTP/7m+njcDTm
	exmn2qi7VV7R4iTovbZQiU99XuAtaXL4y8Vr1xKIvspqSscK4pxAvbgwxlRxS1TGevaFe3WCdpuJQ
	QrxF3DLnM7Rn6+aMJ9bERqapxfXOVyE4xB6tgJoA2b7D/yQwRioMOSlyub07NW5wjj+qTYm0TPHQj
	7rG/wC0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002TsJ-04dY;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/27] f2fs: Use a folio in do_write_page()
Date: Tue, 18 Feb 2025 05:51:47 +0000
Message-ID: <20250218055203.591403-14-willy@infradead.org>
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

Convert fio->page to a folio then use it where folio APIs exist.
Removes a reference to page->mapping and a hidden call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a29da14c5f19..088b4ad81771 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3902,6 +3902,7 @@ static int log_type_to_seg_type(enum log_type type)
 
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
+	struct folio *folio = page_folio(fio->page);
 	enum log_type type = __get_segment_type(fio);
 	int seg_type = log_type_to_seg_type(type);
 	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
@@ -3912,9 +3913,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 
 	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio)) {
-		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
+		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
-		end_page_writeback(fio->page);
+		folio_end_writeback(folio);
 		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
 			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
 		goto out;
-- 
2.47.2


