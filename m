Return-Path: <linux-fsdevel+bounces-17194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD98A8AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2621C23C68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DAB176FAC;
	Wed, 17 Apr 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYCsBaam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA42173356
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376625; cv=none; b=fVjvPV3pb/KnKknDswsf35vGy6lRDW0WBhC3hdC5WO1+I9kiQweFfN/N3wLIUd48EJHJ+6f4lzvJ88QaJUBEMeY+o1LGyXeJD8+9gst95U8AxCncQ/F95XqTWpRXMVTgP2w24iJu6dTp8XgnVRtSBO0vo1A85R3n46J56XJbQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376625; c=relaxed/simple;
	bh=di0glSRgzZpO7+XvJkzusQOo0xEhKsxIijv+gFjMppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0yttL+kZaim7ATXObDb8CZDnQDgOMk2lazgIDwaqeqjZ9Rnx4YVRiZcxmN69ZhiMSCW58ByUjHIjTG2ZEGN2oLPOXBMYRvMVSTqVgDjXfDejweGeZOrTiuVDfk0mzp+Gu0BcS7QmO6lyZJBdgl4LmzwAVKEkv1T6ArAoFugIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SYCsBaam; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+9qhI/cuhF7jFIDgVYs7N51KHwVBIUw5Dj+/SbDEonk=; b=SYCsBaamlioo00YrViUMIHeMtV
	l0+z62qaHrxEFLHjJpQS+kN/wk5URT0VB0VVFKnMM6E/HSpzi37DWHMDJwh+cRP4QkDk43qNU1NkE
	fi1SBSq+b07tmRc/72zx86gEVgqSRdy4/9vLSfi6t9QkdknAYxmquSrsCY+CuUumKOsSFkqLG7D2H
	aTVXiLzEWuCslmlakgFL//esk89IGRnF4GBeab18nRKt5mvLY2Kj9wS3nm6D/bd3af7cDjzVxbpxu
	AzBhvV8WSFBRhdbi3u8EBt00Hllk4GS9gfuyyswugYZ7HpeiWiZ4h+AXTEtkN5r2sNRUWWcObyE7c
	OI9F6QKw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wp-00000003Qu5-06QH;
	Wed, 17 Apr 2024 17:57:03 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/13] fs: Remove i_blocks_per_page
Date: Wed, 17 Apr 2024 18:56:57 +0100
Message-ID: <20240417175659.818299-14-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last caller has been converted to i_blocks_per_folio() so we
can remove this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e7222433a537..6b2bdaf27bbc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1540,10 +1540,4 @@ unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
-
-static inline
-unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
-{
-	return i_blocks_per_folio(inode, page_folio(page));
-}
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.43.0


