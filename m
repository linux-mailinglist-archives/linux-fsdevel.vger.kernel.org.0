Return-Path: <linux-fsdevel+bounces-11644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D42855A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF031F2C266
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7A134D3;
	Thu, 15 Feb 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4NXeWjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6611CB7;
	Thu, 15 Feb 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979030; cv=none; b=XPNI5HcPxIX2boHKmdKF2HHIzaEWLvkp9iebN9np/Zoue41cXVN6YiajS8IiOQ3smGqMHOWWiFNkEvwbr4c9EUm73XWIz5+ntTiaIX1WuTeKDam46TdoOHHinjOhOjYEAtpyP8h2SUN0/3/mzeH/i0ZwjQusHG2p7s/s/Bk0ZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979030; c=relaxed/simple;
	bh=YrbxompJLC2NEdH/sKq4Y99k6g3GcS3Q8+oO4FaLHis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uulWtHHFUylM1qXGKcIshGO4cqL3w45gdf3hCS5TNvnTXpmMjzmO+Urf8Qpx+9+IGEUxIa9vmXtYyyjyPm1XW2MbaOgwDcydX841lH0q5bTXRmstG7PLVag3ujtxYIvUFvY/FAQ2g+HFmwbJXWlc0iccnQOFK1RuPBQ5ZnDio8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4NXeWjC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kSMXi3gz5VM6F2g1+TWrPGgNlolETTCiIJzlQ/AveA4=; b=S4NXeWjCQySPi/zq4OM137aJ+6
	vVdn/P9suTKm0us/wsY/Fv8b/20hUhILA19+5Ue3hWr6rBBb3U7kL8pSAoAkwjXWcMicNhajbI6xX
	EbgO3XefR/t34tuSkYHtTd9Njp4hIN9viDPkgVx74GlSP8t3vk871RskDSii5HkIODE7I8U2HXivd
	o/kmDk4nmPf+yzU7vIYhIPxU9+NPRtsDIfpHNcjVE6BikfhfOu8KASo0OeOoQJP4XMhW44VXabbct
	6X7hYud0O18iDSb5usFsuDLPYY3c3E3ig71IflA7KenkTFNVBQ5bRbt0FEFfg19bw7GFC3u334/MT
	eleLva4A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMo-0000000F6rf-2Dq1;
	Thu, 15 Feb 2024 06:37:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 03/14] writeback: fix done_index when hitting the wbc->nr_to_write
Date: Thu, 15 Feb 2024 07:36:38 +0100
Message-Id: <20240215063649.2164017-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When write_cache_pages finishes writing out a folio, it fails to update
done_index to account for the number of pages in the folio just written.
That means when range_cyclic writeback is restarted, it will be
restarted at this folio instead of after it as it should.  Fix that
by updating done_index before breaking out of the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 703e83c69ffe08..2679176da316b3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2505,6 +2505,7 @@ int write_cache_pages(struct address_space *mapping,
 			 * keep going until we have written all the pages
 			 * we tagged for writeback prior to entering this loop.
 			 */
+			done_index = folio->index + nr;
 			wbc->nr_to_write -= nr;
 			if (wbc->nr_to_write <= 0 &&
 			    wbc->sync_mode == WB_SYNC_NONE) {
-- 
2.39.2


