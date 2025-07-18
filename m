Return-Path: <linux-fsdevel+bounces-55474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FCB0AAD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034D11AA109F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50E21C9E5;
	Fri, 18 Jul 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQy2+nnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326341DEFF5;
	Fri, 18 Jul 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868448; cv=none; b=jrwbN5NOgf/Sa1ZUnQrHxHaFm3WL1PmmQr735jiuxtRQOhOs5njNAc5FTOyUs6z3f9UwiMQT5QYxzvMyFgjsIJ759MYUId4d7i2lKDG9BwTjvheLTiDMmjdVm+YI8pUY1O2pAWXAOBvWAH2QN48FGs6JM2X8bjSTBEqNGI/QrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868448; c=relaxed/simple;
	bh=G909SxDe/q2RSmFJXU4N0BMvJWcUhkpfyYQ/oKFwIds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfKzOa+Rn9TFX11SKyeWR810PCMVQD2viOBBLMGaFo+Iw9huT6rtQW5W49XyIhMl8mPUXw6V6ChP78Jj4CbdcCRaVe6Wo1P/778yrE1zkEQNShNmFuCahRjCMbKR5JpNzBO1lRA5bag/tZT/1Ss7ongvWr2QeWaA6Nazqsd+FTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DQy2+nnM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5kLQ1rhcnSMcdti8qPcprWTeCZwAKX+lye7SqJvGDAs=; b=DQy2+nnMvoFRgrnwDHf+AIm5K9
	W2Es0EYklAK1Qr653+WCZ3cylY2ovpgnfrXK8x9Pj1GQGZRhF1YooTZibS2mk+gJ+OycrIhbBgYbv
	6/CRNoaSpvJ12CuirfBiMc0f89Z9qyTz1DAasuC5IvtboXL7KWONM+7qn5ZGc1QzI506ay63KoGSO
	1zsu8eCpBFUtwk6lWWjOqMIFOhO1jUCUVvQ/yyfHBGMTku2TLJGKA3Qh1woaE49XkKwjPXQgy/Gpm
	h9V4xtj28OyvYqMmmb8NMHy5Jm4w1iPnuI97nTrn4SFSFcRCNI2Z4anEBkfGdfRluWuWEs2izhSpT
	mYn8z9eg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucr9e-00000008FTP-0HwR;
	Fri, 18 Jul 2025 19:54:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] ntfs: Do not kmap pages used for reading from disk
Date: Fri, 18 Jul 2025 20:53:56 +0100
Message-ID: <20250718195400.1966070-2-willy@infradead.org>
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

These pages are accessed through DMA and vmap; they are not accessed
by calling page_address(), so they do not need to be kmapped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/frecord.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 37826288fbb0..c41968fcab00 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2590,7 +2590,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		}
 		pages_disk[i] = pg;
 		lock_page(pg);
-		kmap(pg);
 	}
 
 	/* Read 'ondisk_size' bytes from disk. */
@@ -2640,7 +2639,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	for (i = 0; i < npages_disk; i++) {
 		pg = pages_disk[i];
 		if (pg) {
-			kunmap(pg);
 			unlock_page(pg);
 			put_page(pg);
 		}
@@ -2735,7 +2733,6 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		}
 		pages_disk[i] = pg;
 		lock_page(pg);
-		kmap(pg);
 	}
 
 	/* To simplify compress algorithm do vmap for source and target pages. */
@@ -2823,7 +2820,6 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages_disk[i];
 		if (pg) {
-			kunmap(pg);
 			unlock_page(pg);
 			put_page(pg);
 		}
-- 
2.47.2


