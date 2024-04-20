Return-Path: <linux-fsdevel+bounces-17339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39908AB8F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106611C20D7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C8C1D;
	Sat, 20 Apr 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZhBD66V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA979DE;
	Sat, 20 Apr 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581458; cv=none; b=nOM8umJWEzrN4h04B6BijLPKo1k3Q79tb6Me/SGMYeacq+daSz5qoLgpTk+p75n1frrmbZNYmwe57AkjWwsUKJgDc2neAFIUPkLX1aDLYRvQmvoqw2cCuaKrWiC9ayi7f77UUmVOv6JiXw1wwcWsKgXuPEtzQ4/PN0/RMQTCitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581458; c=relaxed/simple;
	bh=JBMHCx32+MTaoX7pOxHoZ5qOitImkwXWOh6ZhtrER3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL557nS3YW0PcB7gTq0BlbMwNffb2aayHt2c0Ds4GHnQUe5t0r3QgyIM4TrqUACxByVAfjCxh/Rlds+NNahF5oujRtSi+Ax4utuhJsIcafpsHCg6y19wD1IwIF7eJOkiSkehFmsXmeuOYq8s4n9EFwi1vwSOcKf67oD3s9vcmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZhBD66V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eKSk8yOHrxF1A9Pm7zaTg06pb1+chA0GVOIhlKSs7/U=; b=DZhBD66V6uyJoQYNETjLIY/kK4
	mKFWQksvSsiGu/W/Xn8nwRV9zPVlcfgUte6XCZ1Y52oS1eFQEVP1hCTbRqSxAREZGXjxoWnV2uiXU
	h46uL9FSwGfEie2ljwWuUCPz7aGn3oxt4OdWqUV6RgejwsQRRGJMRrZP6A7uT8LgvBC0J0ETq37H6
	64SziAE10YRclVd3+Xeq7updwW1StfBcCsMw8mNU/ai2ox1Yv2JGkC7on4b/eYx1rVCDe4ZcGZkkW
	ZKx2NLSNQbrJgqYtKBCKKn57ZY9TXllQRjs5OJ/SiRzVFqvLBYXw6AxWAzBeXFREwfDXfCz5FHgh8
	nATKLSMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oY-000000095fh-2Dz8;
	Sat, 20 Apr 2024 02:50:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Subject: [PATCH 17/30] ntfs3: Remove calls to set/clear the error flag
Date: Sat, 20 Apr 2024 03:50:12 +0100
Message-ID: <20240420025029.2166544-18-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on ntfs3 folios, so stop setting and
clearing it.

Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/frecord.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7f27382e0ce2..e9836170e2be 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2143,9 +2143,6 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame);
 
 out1:
-	if (err)
-		SetPageError(page);
-
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
 		if (i == idx || !pg)
@@ -2718,7 +2715,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
 		kunmap(pg);
-		ClearPageError(pg);
 		SetPageUptodate(pg);
 	}
 
-- 
2.43.0


