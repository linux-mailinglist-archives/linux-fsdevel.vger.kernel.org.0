Return-Path: <linux-fsdevel+bounces-51499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5CAD7408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA0516AB3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFC254875;
	Thu, 12 Jun 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MPMcgDdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12824C07F;
	Thu, 12 Jun 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738905; cv=none; b=EwNmbaP2V4/7DDwwyYa1If66F0a71jS/vnjwbCfKRrPmdTAMNCED1Hwppr9CJX4xiWO3+/uPHdmE6X1zGzZZX6NnfdYp4PQNjWBvJQ4nzIktmjLu2bM2lKTESsNasha3b2Pc8z2loJm2W3jbUUyjuh0zZwxvo2S1UfOztWeZIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738905; c=relaxed/simple;
	bh=/wBPfTYhsR8bD++3AMho+FO72wFGN9A4d4VwwUOtXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpwTpgGXIxYQkEzhepAJIuMiJpmf4GESy9Rtu8OFnRP+xvDiM+AcUjZsQk8/Adi6OH5jxsmKIUz2O4MvUVY4FuOm8hCGaY0zbcozBAzjcAwUqdPHEDX/tjsSFdBVyrFrA7sIaDvvVtIkP1XZI/EZNtOPqGv2JpM0vSZA+d2URz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MPMcgDdG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=F7O+qEqSWYuJ9K47PPf3wKY8hNXy10Wqu63XI23RWYg=; b=MPMcgDdGzeOByBj5zugTSsssYO
	u2aAkV/If+T9VkgEZo3NKmGQ8xSmcKqSpSE3vHS6d7J9vXZyD6i0N1QbSs4rAuIYGBm24vkooT8iG
	P8LuqIWv9Y8gpGM/hXh2Y1/fLJQhtVk4QcPDam4oz5CLb7es79y7fsuJtK6YG7Xy01gBkXLR4GX/m
	Cyb7cZ/CxmGOoCO0Q01B5HBepgsgpgJG4uNw7gfM3CV+etV3f8DfauPtpLQmpyG45ffskHysmAg9m
	8rRcrGRVA9EOLH90ArKJE4DTWj1w8unSK8qkrg8ix4I9PZOQIbXD9Vaik0cdvSgGzN3HLeZmQgHFC
	KFjb/nHA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000Bwwy-1HXc;
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
Subject: [PATCH 1/5] bio: Use memzero_page() in bio_truncate()
Date: Thu, 12 Jun 2025 15:34:37 +0100
Message-ID: <20250612143443.2848197-2-willy@infradead.org>
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
 block/bio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..ce16c34ec6de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -653,13 +653,13 @@ static void bio_truncate(struct bio *bio, unsigned new_size)
 
 	bio_for_each_segment(bv, bio, iter) {
 		if (done + bv.bv_len > new_size) {
-			unsigned offset;
+			size_t offset;
 
 			if (!truncated)
 				offset = new_size - done;
 			else
 				offset = 0;
-			zero_user(bv.bv_page, bv.bv_offset + offset,
+			memzero_page(bv.bv_page, bv.bv_offset + offset,
 				  bv.bv_len - offset);
 			truncated = true;
 		}
-- 
2.47.2


