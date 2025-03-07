Return-Path: <linux-fsdevel+bounces-43473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B77A57059
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0D18987C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E7241696;
	Fri,  7 Mar 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxuuq4CW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6621C17B
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371716; cv=none; b=mnZwmpehCgExQH2bodcrs8b1/7t7NyuPNllaMQ8b2kgrxNiFIeRLnJsH1IRDDSp/91KvCoabUrb5cpuWZotnI4wLZq1/n0ZfySaLyDjOLV/syH2uTEA4ohkm2qgc6STLzU0XSfb85ULUAsEoUUXXyDFOrAoIk0jIbDLUUuZQg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371716; c=relaxed/simple;
	bh=gter1NFbZ38ah1sF/59SYEtqogFPFh18jqqTiM64GFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB5xnv49qkUSGqC3SNOKscTXnXRlOgA208W+bjgTl96NEPmL7U0M5TMNtz/TmaEOoCIzgmHl1i+dOQTVNiPFmT9zIem98UByVGRYeWbQHp9tDyq87Kk3LHTrlBWzORQn+tRUmPm8vhHO232uiN749w/6E+bEa+CEgFk4Di638OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pxuuq4CW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gYAlq/IZDrN3gAui/tjJNHWS0bZWyHE15MvZlcNIc7w=; b=pxuuq4CW9Iqdi84kFmqDjILnCV
	6FAlDmRWy/ei0ycQzlm3+S+Y2ZkukBFrShMxfUcspswCkMVP5pwJ6ZrAC4+BR6Geu0CJylIRL2Aos
	OFrO8ZrSeP6GR3iMW+m7H+2gCi8EifCp9l+J9mQHSxANR1Rdy8xQRj1aAiJu1h/JURJD0TEoGn/8b
	V+c8qT3iUC6Qr/Tu0kP65Grf8jtJoT4jjdifftwSnZ1ftUrtdFWd2WPuydAY7FJhAxDekUqDqU+lv
	RF6Whu009Y9HnLxZT1K0x93jpqfJV4Ve0wtLULzlfiLsQkOAnfpXCH1ACt0ETb/OAQYmEdasUvmot
	ojzeikpw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqcKX-0000000EFjT-15dZ;
	Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] f2fs: Remove f2fs_write_data_page()
Date: Fri,  7 Mar 2025 18:21:48 +0000
Message-ID: <20250307182151.3397003-3-willy@infradead.org>
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
 fs/f2fs/data.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a80d5ef9acbb..cdd63e8ad42e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2935,29 +2935,6 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 	return err;
 }
 
-static int f2fs_write_data_page(struct page *page,
-					struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	struct inode *inode = folio->mapping->host;
-
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
-		goto out;
-
-	if (f2fs_compressed_file(inode)) {
-		if (f2fs_is_compressed_cluster(inode, folio->index)) {
-			folio_redirty_for_writepage(wbc, folio);
-			return AOP_WRITEPAGE_ACTIVATE;
-		}
-	}
-out:
-#endif
-
-	return f2fs_write_single_data_page(folio, NULL, NULL, NULL,
-						wbc, FS_DATA_IO, 0, true);
-}
-
 /*
  * This function was copied from write_cache_pages from mm/page-writeback.c.
  * The major change is making write step of cold data page separately from
@@ -4111,7 +4088,6 @@ static void f2fs_swap_deactivate(struct file *file)
 const struct address_space_operations f2fs_dblock_aops = {
 	.read_folio	= f2fs_read_data_folio,
 	.readahead	= f2fs_readahead,
-	.writepage	= f2fs_write_data_page,
 	.writepages	= f2fs_write_data_pages,
 	.write_begin	= f2fs_write_begin,
 	.write_end	= f2fs_write_end,
-- 
2.47.2


