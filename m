Return-Path: <linux-fsdevel+bounces-44551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEECA6A49C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256551893383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE021D3ED;
	Thu, 20 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MThVMap2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937A21CA00;
	Thu, 20 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469223; cv=none; b=ldH4/2Yrz2nU7XqJgUccPSoEAszbJGcHCHhprA9bzDhhYppTb+zg/w74zyQE88NbGJ/7WDIDBbdwtmMI998O3mjFMZWgRR+LNclD4g78gHakV1Dj4bRc+K7LghMv0j6g6pHAJm5/6sDBwAAL6nrlMft3uvjlnDTqLrQcWnsfFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469223; c=relaxed/simple;
	bh=1FAMKOnw2nf7uzXfMqL7iBCFqmjuWjtZePNtB9EjmkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRpvI01kVIM3bZf72khLoeRPJesuAE/w4zunANehSGG292atyncMAep4QPiBjL+foV+C+hqM9Z1BIo+ADAX8vfh+2Th2XUqSFRTj0whKWD00pDwLIqRfvfkRSO3ajz1yFE0YJaXkBJixcuK5hPviNISRtYoQR1psePcGTv/++mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MThVMap2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BLnLLbicrTWFog6kQ28fdP0bkjVVSVc398B1zInJJCs=; b=MThVMap2jk+UZ2Ccgi50YbImvQ
	rpRcFTXCk6GDaic1nqElD9jqLc2R0U7i4oWXYFFmHHzyhnQW3ow6iiO5KlSMN3wGap4N2eHsyw2nf
	qerPxbcisn5RdWT702ZoFtRFiYbg/ZlUBnocITROFYnlAdfcw8juzW69qjopaD0b6420IdGbKG8Pq
	eXq1b0c2E8s36ED4JxHAjn+OLXTvcR/k+UvNSFvQakZ+buqMBHYd4UdIsVqIlEalwDmIWI5ShlcS4
	po41BQ60nKFFQdwvIDddB8ioPnnlQkYJL0OQCoN3diLTvMrGlDTZIwF43RE3l0iy/uVIFFt8eczTW
	e58r3InQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDqB-0000000BvGJ-0leR;
	Thu, 20 Mar 2025 11:13:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: leon@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joro@8bytes.org,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 1/4] iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
Date: Thu, 20 Mar 2025 04:13:25 -0700
Message-ID: <20250320111328.2841690-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320111328.2841690-1-mcgrof@kernel.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

There is no point in modifying two locations now that we have
a sensible BLK_MAX_BLOCK_SIZE defined which is only lifted once
we have tested and validated things.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 0e47da82b0c2..aa109f4ee491 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -30,7 +30,7 @@
 /*
  * Used for sub block zeroing in iomap_dio_zero()
  */
-#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
+#define IOMAP_ZERO_PAGE_SIZE (BLK_MAX_BLOCK_SIZE)
 #define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
 static struct page *zero_page;
 
-- 
2.47.2


