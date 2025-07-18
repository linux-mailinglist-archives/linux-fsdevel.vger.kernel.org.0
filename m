Return-Path: <linux-fsdevel+bounces-55472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431EFB0AAD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86101898640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E021018A;
	Fri, 18 Jul 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TP5NkauN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136641DF970;
	Fri, 18 Jul 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868445; cv=none; b=E6jRIVUr+9xSkFyUMqoCirYvks4AO/CHdjWrwWyIRnYkH4zTbL3T27oQ4qqS070j88ENiPNfVbSnvFd5EQG5cx8pty1Razap8j45IO7y2MZdrmNU4bnnB/AXc5KHmrHNeng009EsasmoB9NUMAAABWh68gfJFuFnM7XelJMadbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868445; c=relaxed/simple;
	bh=UR3dsJcjwK/7uRF8cd0zYm9NTSrI+3S0SRX8cT+gqf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AawXgzUlOGPL40Xyoi5zkEl6jPL/isIqQo1ZfZ8dj7rY1zQULr3rgwfe3WNK5IPHAD11c35nTstuHGBGeAZ45czx1EO6CzEVG1ehhZleKnVrc6KbRw04AYU7bgtmwwtMFkqStTRUM0Z5WKbCr1lL5k4ed8lg7U7DQTOfdQA1gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TP5NkauN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0em7PvLpCPC34x5KxU2WXcMZ46kbNZjZaiv9JvP0hEA=; b=TP5NkauNi+OkR/J0YfvmSbaSyT
	slLfJqGsp+ihDjYlOMiZW5SSD/nhPt4jT3ceOOiUZg9hikrqylRNcTxJIyceEhgDm4PMRkWOtjo5N
	ED7XgmP1Q5duwPW8gIFUP9BxPtMe9PFfq8vSgqNQpoGvjzeAtl4qfjSyOAFM07lS/Mf9b8kUWhjFY
	DeB/E/cAductTchMLeiMOlGf5cdGfW3ltEShJ5fjU+GaAt/a5QKH5gUWMdd0I5vWzfhN7K5niuURL
	zAH+FJdKTllgXTa6y9GWwMf111lI+n8m3k1AIt7d2Ii4gknLIP/NeQPqCurjCRG3rBuVkA3MEx1C4
	r3OLsurQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucr9e-00000008FTR-0bNc;
	Fri, 18 Jul 2025 19:54:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] ntfs: Do not kmap page cache pages for compression
Date: Fri, 18 Jul 2025 20:53:57 +0100
Message-ID: <20250718195400.1966070-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250718195400.1966070-1-willy@infradead.org>
References: <20250718195400.1966070-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These pages are accessed through vmap; they are not accessed
by calling page_address(), so they do not need to be kmapped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/frecord.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c41968fcab00..6fc7b2281fed 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2407,9 +2407,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	 * To simplify decompress algorithm do vmap for source
 	 * and target pages.
 	 */
-	for (i = 0; i < pages_per_frame; i++)
-		kmap(pages[i]);
-
 	frame_size = pages_per_frame << PAGE_SHIFT;
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL);
 	if (!frame_mem) {
@@ -2655,7 +2652,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 out:
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		kunmap(pg);
 		SetPageUptodate(pg);
 	}
 
@@ -2742,9 +2738,6 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		goto out1;
 	}
 
-	for (i = 0; i < pages_per_frame; i++)
-		kmap(pages[i]);
-
 	/* Map in-memory frame for read-only. */
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL_RO);
 	if (!frame_mem) {
@@ -2810,11 +2803,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 
 out3:
 	vunmap(frame_mem);
-
 out2:
-	for (i = 0; i < pages_per_frame; i++)
-		kunmap(pages[i]);
-
 	vunmap(frame_ondisk);
 out1:
 	for (i = 0; i < pages_per_frame; i++) {
-- 
2.47.2


