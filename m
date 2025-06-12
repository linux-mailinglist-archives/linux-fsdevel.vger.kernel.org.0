Return-Path: <linux-fsdevel+bounces-51498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F18AD7405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475263A5040
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52E25291F;
	Thu, 12 Jun 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLuuL16v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5A24C07F;
	Thu, 12 Jun 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738902; cv=none; b=rVM94W2ziEveZabfbjqCwh7Ly9LCB5MCmsdXEM7r3mP+0shVNELir91xcBVnBlYGYz1hD9hRdL+KYfDdGMCJHDdcN9jE8phgZmUEUds874KTSmMx7JqmLXAFiORAjG77ifm0xir9gJMen27ORrghoHeUfnYM/FNDmFmOBZbIJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738902; c=relaxed/simple;
	bh=4MmNA5BZdOQOnitkomeZF4NYKNmNE9GMkeI/2XTLvts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA0ZcU5+KnEg7gWQltksYtcvD9fMX+1O0CKaJgSrvRkeLO0eExOumYiiXQyQKgtnSIJ+H7PujVz4h1dVm693m77mBNe5swuOZCOM3RV4+KvVUQUsUMfwLe29LaxfXRZR9Ve9WI0vHixervL26a8iqfEyJDJc0jfbhgC6vjaEnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FLuuL16v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YhafpK/MwcH33DVcaMQJ8GgYcX9/vr8J3pJt/UJJDxY=; b=FLuuL16vUOr+RYWfGX6esQYtiO
	sis29RMXcqZz9k5vq29PcjhgxwnKo+CutdV1Wbjlh0qaN4CVQrOcLphvANHNPKPtHU8bE0eyzn3kf
	RgCi0LAW/bDa7VMdSNs9UWfVIjEZ2MmS0DgwszENUv65nRAZaypsBeUzuQ5eIBkUnDWhzqN/pHe2Y
	7P5n0/ZHzi0gWpuq5sojSBBE5fRLFkIgcVjTqYPIYsuPNDljZ5bEjLTdXIxkbmcQR+tupq71x0NoN
	kWhXH1wMUMXmQZ01MKpNq9hHpjYm03PmZNgTZZDycYrw7VYzZzxpgDUfbpjhB8c04UsE8BLBUpy/r
	sn5iYa3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000Bwx0-1fNW;
	Thu, 12 Jun 2025 14:34:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] null_blk: Use memzero_page()
Date: Thu, 12 Jun 2025 15:34:38 +0100
Message-ID: <20250612143443.2848197-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143443.2848197-1-willy@infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memzero_page() is the new name for zero_user().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..91642c9a3b29 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1179,7 +1179,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 			memcpy_page(dest, off + count, t_page->page, offset,
 				    temp);
 		else
-			zero_user(dest, off + count, temp);
+			memzero_page(dest, off + count, temp);
 
 		count += temp;
 		sector += temp >> SECTOR_SHIFT;
-- 
2.47.2


