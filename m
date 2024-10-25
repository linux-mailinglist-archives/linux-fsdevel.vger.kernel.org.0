Return-Path: <linux-fsdevel+bounces-32941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C868F9B0DF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5311F25782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DD20F3E8;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOThyNEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AA20D51E;
	Fri, 25 Oct 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883308; cv=none; b=EgwtiiPejacq5U2O4LVkSsXJe0DEhAcxCrIoSIho0u8yq3gsbug/x0nUZdvAfOKWlJ2BZfiMWs/xAhDBwoExFs1IGs/vn4T1e0OmGXeFxNiE3Mx3qqU5YyB30X2QcKVuSDxYyJUVoUP3FxR5uUeMx4hkCRn128uRixnHVSQjv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883308; c=relaxed/simple;
	bh=Zf6IFeDThq7v2Y7xaFvMMf2OXdzzhK1pUHUjiCQJ+5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKcs6APUTb+cNRVM+ed7LWA4VHQnekdznX8EjofoRG1UKfv7q209AXVfbnFfRLbg5AealYTJSvi6jpCczo/2u1kRFD0P7hgyqr1jwBZdTlJzvKxIIMAJCuEH9xuwkPvN/pxJM+X4G2CA2Oh7PKw/Zt1Uo1ZP9PHwK3bn8jGC1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOThyNEo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6tUZAdyZshlb80tzJO64EAEmD350EUVJIOOAQNegrtw=; b=VOThyNEo6WelIa41NITLxPmQ0U
	Ej6HH9RG6bBaMzEgscsWlqJxaphsahgna+Dhh6RIP5TfQWxT4yz2jD62KdtuL+SBBk39Fj1ybaWgB
	j2P8lY7DsU3fHoHuBStZ2q02mZHFJm3g6oscYVjX730CbNkSsBdzohNQLMqbOfQ56uEybDgjoJyAD
	CWR42v089LXsIO3kz1WdOvYVD2FUbiykcpAR35NWKQuCJvfd7j4bPKuVD2R1sACp/O/qlnyj8/adA
	Sp94pjn4VHdF227OlJY948l6tttyRHkJf42SC8HkY3axkhEs1CTuVYN4OfIF3E9lKbvQJ8ZL+U8sw
	HqelW70A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfc-00000005XBk-2KIT;
	Fri, 25 Oct 2024 19:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/10] ecryptfs: Convert lower_offset_for_page() to take a folio
Date: Fri, 25 Oct 2024 20:08:19 +0100
Message-ID: <20241025190822.1319162-10-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, so pass it in and use folio->index instead of
page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 90d38da20f5c..bb65a3a5ee9b 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -328,10 +328,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
  * Convert an eCryptfs page index into a lower byte offset
  */
 static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
-				    struct page *page)
+				    struct folio *folio)
 {
 	return ecryptfs_lower_header_size(crypt_stat) +
-	       ((loff_t)page->index << PAGE_SHIFT);
+	       (loff_t)folio->index * PAGE_SIZE;
 }
 
 /**
@@ -440,7 +440,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
 		}
 	}
 
-	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	lower_offset = lower_offset_for_page(crypt_stat, folio);
 	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
@@ -489,7 +489,7 @@ int ecryptfs_decrypt_page(struct folio *folio)
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
-	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	lower_offset = lower_offset_for_page(crypt_stat, folio);
 	page_virt = kmap_local_folio(folio, 0);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
-- 
2.43.0


