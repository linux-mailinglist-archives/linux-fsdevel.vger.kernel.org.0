Return-Path: <linux-fsdevel+bounces-73452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C3D19F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB20303C81C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37443939B4;
	Tue, 13 Jan 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rresUmZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5B3939CA;
	Tue, 13 Jan 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318796; cv=none; b=NJprii0he0csWsEBg3AGXXrYlxd376fDrCEPt+Rslc5+/sZZxofHgjGCmuBdvl14LDKwF9iIvthH9kqL1bBk6dw8GMmJnTlQD39W1H1+rsQj/1Y7DLN9uMRgbCv8YniGlmdrycI8ZAJO4N2IUzwZrHxLYzKMx+yYPd7eKCPL4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318796; c=relaxed/simple;
	bh=ru/29rNt06MvB1INLVO7jrWbbFewBOEUIER+YhQ4+wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmKT/HjIMGg5b4IAitTwfwAMpUCQCJm8kxuy8Z8yvoojcm9Bw61OG1MnDsG4zvuiuvCgiMn2rDGFdghdI1SsDQTAp+qUbt/l/n8X2nWGbUi8rL2fWqlZBqqTFHSRno/vkvAygMwsq2T0+byKBgQWICPDDUzm3MxWMPxSoUrWo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rresUmZj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7VLyLNf6NbqRM45hHt21uKpq7YSonqiuDKYfxbHru3w=; b=rresUmZjl2SLvfa9UCxfTQm0Tl
	HXwLoho5xF+bca7AxNK1o7+Qf5YjTepOU5tC2tfqi/rWpyRUvKCA2hxgrfxxUjTiHNoB3nAzC2+F9
	gVEcYHSo6DhWCGyxXm73zb8aedpHvF/U/0Gmql8t3aa2pabLdYdRuIPPlVgJA6z7r6/WTyawDfisj
	/68n2NGGktKOMkIEZISWmUcdorSQ/zU0eXV3Ljgtsg79s12NAClJK3Imu+mugTPycYdstvof/9U0P
	MCeSkngIOofVR1idhL8Y7+oUmw5+zUiWS7EZOQS2eRFPx1Yd5oeORXQNt/d45LpAZUzlW2qniuSwn
	Tn1n/yyA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgUl-00000007Olm-3iEU;
	Tue, 13 Jan 2026 15:39:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: bfoster@redhat.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: wait for batched folios to be stable in __iomap_get_folio
Date: Tue, 13 Jan 2026 16:39:17 +0100
Message-ID: <20260113153943.3323869-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

__iomap_get_folio needs to wait for writeback to finish if the file
requires folios to be stable for writes.  For the regular path this is
taken care of by __filemap_get_folio, but for the newly added batch
lookup it has to be done manually.

This fixes xfs/131 failures when running on PI-capable hardware.

Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd9a2cf95620..6beb876658c0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -851,6 +851,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
 		}
 
 		folio_get(folio);
+		folio_wait_stable(folio);
 		return folio;
 	}
 
-- 
2.47.3


