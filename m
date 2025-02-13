Return-Path: <linux-fsdevel+bounces-41677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB2A34D92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1617E3A39C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AA24290C;
	Thu, 13 Feb 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pDvYcWzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71C11CAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471078; cv=none; b=ZhsUrChiOc4wkxgOJHL//FQEa/hUbk+fre58FWGU+m2HDebJy5gjTo4xEIzxtH6ruDRdcWoT/NP2Wp9hgJJ1vRRPa/o2hyqVQuckxkg5vmZBaQhy6wWS8qsNzTSqJ7Kiq+X9w2FUsi5Fd5NENZHQHuiQb6FTjXmUR5ro2aG0+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471078; c=relaxed/simple;
	bh=mjoANM03VAdo5z9LdQsZFU8cDb8+ve0UqbfICG4R69g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3aWocrFsosbJBEl3Dl7idjYsSZChUiCoM0u6uBYfc22lmcnxNOxi2y6B2Act0/kowRECVDoQwtnvF3FESG08JQX9VD2eI3iADha6vJ8VrhJ6YBOCaAYv+4y67Zd63Pcb1xSxlJw5qwuSj+bkRsWM1h0QvJn4EY9+3YiUEjBTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pDvYcWzm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ICtavEwqZ/HQUBOR5OBe539NOrRKsA/eVPbm9dzV1bE=; b=pDvYcWzm5/M+7Ez9805JdKQxUX
	hgbtTFx+SRGGUU9Xe1Csc+X08F0od9Tg0sQB4jn1kT5W5+p5grx7HuQcK/o5AXg7Td8llh9RK30E6
	QlBaHx533SgRm6vw0Py+e/dpazhR3Y1bjrc6ER+mxmcTUo2ktEl+feGtEkMhLAlsaLfmwc7M3qy3g
	qZwqLXuwasj3V27bEwb0vdSbYdsw9PFblAWNx5RtqT1stgQTSBtUEot0omyemz6Ztc+qcPcU6vUoJ
	TiV0k6uXViXqCxFJZSAIt5lNUPCX070O2p2F2w2/kEnWVicNVRH60DlE71AKHodbO+gQtGZSPnzPU
	RByXorPg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tidt5-00000008x5G-03oz;
	Thu, 13 Feb 2025 18:24:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] jfs: Remove reference to bh->b_page
Date: Thu, 13 Feb 2025 18:24:30 +0000
Message-ID: <20250213182432.2133727-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are attached to folios, not to pages.  Also
flush_dcache_page() is now deprecated in favour of flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 223d9ac59839..4bb42de33865 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -766,7 +766,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 		}
 		lock_buffer(bh);
 		memcpy(bh->b_data+offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
+		flush_dcache_folio(bh->b_folio);
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
-- 
2.47.2


