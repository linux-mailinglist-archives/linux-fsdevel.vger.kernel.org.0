Return-Path: <linux-fsdevel+bounces-43426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F67A5698E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F1F3B5C30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46D21C172;
	Fri,  7 Mar 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K0rUlg3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8821ABA6
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355659; cv=none; b=B1mFNBPSJWJ0CQmSvlXAiAJsQGtzZn5tGwk7wSkwnIz+9+DqaMFm9D1jec1arSw5bSuHlK1YD8a+RkgAtuwPiBz+eVjSQLVNOErQ6j5S/z0Njs1j56xVzE7KsiDmPoCiLYq1enQNLPU0yWVLiI1dbvbmXdEZDWBzWqySMCT0YS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355659; c=relaxed/simple;
	bh=gter1NFbZ38ah1sF/59SYEtqogFPFh18jqqTiM64GFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJMGJR6bt5QuED4q3dYvidj13B3le2Xba+rO6F9WnGpPHv0KFEmNuwWD7z7DaE/67CSY7Z/FFvYeItNAqik22xGrJek6q3cP9YispmHpoFg0aa1xXSz/PCUoV2wNQIqJhNcURS94PTGWYJ7b8KGxgx984BrH9m+KDa/fiP+Rb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K0rUlg3+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gYAlq/IZDrN3gAui/tjJNHWS0bZWyHE15MvZlcNIc7w=; b=K0rUlg3+uTjZX3ud/LW+9LOept
	eIWClltyGb551+sTtSjHCSZEBJNGkuChoXa74eq4oYYIuEdEAfgeArfvO3oklLkFCn/EYC7h2mCqI
	E75wHlKErYegjFzgWWReHWhUTQqWQ2FhM1ffcbZgz4t1t3Z7Tnu3hFNPX72K23UrXm1Oyka/m4Ymu
	vOjmwRLhefSEPrfeUv0U9xEZLAmnegRAjGVleZzIUtp00VM2cT/JnPGqEZzXEAyA3nCx5In+W7si8
	K4V51BwGYhJgz2F/Pbnsyc3xyQ0uwSUWzyVps7NBtGXl7vNBcGZ79Mfg4Lgzs6lW8WsUWx55917/c
	pqF/8D4w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9X-0000000CXFt-2gHs;
	Fri, 07 Mar 2025 13:54:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] f2fs: Remove f2fs_write_data_page()
Date: Fri,  7 Mar 2025 13:54:02 +0000
Message-ID: <20250307135414.2987755-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
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


