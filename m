Return-Path: <linux-fsdevel+bounces-16771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28BF8A2650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1031C227E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164DF3C6A4;
	Fri, 12 Apr 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvzxukjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA438DE5;
	Fri, 12 Apr 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902581; cv=none; b=Ut181Egq56E0AjQL7WY/WakChOMbX1K2Z4NYgnORucMLF4fbCM0XkPWuBGmLUw1KakkOcqO/HpcUqlZs1WjRtzpXu/gecboljHFqfjlorHKk7trNONyc8YARF/jgBNoAPwa7ztLftHlngzwmyrmTtsFXJbLvJJMRfSXP4xv3dhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902581; c=relaxed/simple;
	bh=5ojncK9thYB3cyRAEkA3Oxn6nlyjbDtmB7Qq7adJis0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8jHIgUWC3RyuvIilpPEqbLRA/fIq6vZmtsrL2yL5O3OcogRsP5CtrG271fiXlTWxTK/i24VtsoBab4BaokOfwKrVLEIcDyhn2poWzXBWvd+1GYhv2Ia5AdKHBOFxQHSFPhnue9dAN/kRjKiqiwnUVYr38aUk4PeAymcBky7cPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bvzxukjS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cS6NJbOeLnGxomgY43urRvFHL003/Azud+VYYjPI/Ps=; b=bvzxukjSLekLD30vSC+f+9l7mc
	J5RuIgYkuXqWlBNQ7vIB/2ydj+dlkktUfmfE+9YnHOxpffP4nlHS9OZp7YwA+gzcgpnNuHQk87+WV
	lKCBQRfE7hwUME8/Qq+/m2tpkFuepv1+rCk/fM9whRF/fH5WfOXgJsnzbCWObVyG31bOEj9nzMsI7
	1YxOxieMHsGLxWwrB0CPHnFWDccEDmvucyYMono0Ce1nO5mPUqVuUzFR3stqsKUlfzlIXGBwvJ7Um
	2/Wbawvr6jD78h/KJcbKzrKvRpFPhQEFHgOjWQV/uVd1eUv/AzO11As1TsHuDMdfZWiNRgOXQzu7T
	VoKEl2gA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvACw-0000000FX9r-0B3p;
	Fri, 12 Apr 2024 06:16:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: convert iomap_writepages to writeack_iter
Date: Fri, 12 Apr 2024 08:16:14 +0200
Message-Id: <20240412061614.1511629-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This removes one indirect function call per folio, and adds type safety
by not casting through a void pointer.

Based on a patch by Matthew Wilcox.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0e4..e09441f4fceb6f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1958,18 +1958,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	return error;
 }
 
-static int iomap_do_writepage(struct folio *folio,
-		struct writeback_control *wbc, void *data)
-{
-	return iomap_writepage_map(data, wbc, folio);
-}
-
 int
 iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
-	int			ret;
+	struct folio *folio = NULL;
+	int error;
 
 	/*
 	 * Writeback from reclaim context should never happen except in the case
@@ -1980,8 +1975,9 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		return -EIO;
 
 	wpc->ops = ops;
-	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
-	return iomap_submit_ioend(wpc, ret);
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = iomap_writepage_map(wpc, wbc, folio);
+	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
-- 
2.39.2


