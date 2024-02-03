Return-Path: <linux-fsdevel+bounces-10126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6DB848434
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C4B1F2898E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA64EB50;
	Sat,  3 Feb 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iE2Qy9x6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450614E1D3;
	Sat,  3 Feb 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944333; cv=none; b=h+tPRjH2v8Fly/Gt55zi2qHggBy5HccHjDs8mFFvW2H2UZKCKLibM8J9b/0jWd66+l1i1UOsSzB8uf/W8Vg+fv1/YKxdYOgoBg6zUpHwuLAg0MFuFU9lNROe+BK8vhncgYYRLGvNaR3y1W25WDDAhLEb6eRPAlLhsikH4PFFMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944333; c=relaxed/simple;
	bh=fd5z2BBVNn++M9QyH8w4N0hNZ9EZndHdM9R5JVwzQgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTsqkzrAWpy99CaWv2HF8oVusngBsOWkQZIER+0e2AbEJ7RmrtIiFCYunBI9zRevuCNXXJi7MeiRWA4RxEXuRyeGVXrMWpCOTrdpSBbZe/iELgMo7bmLouYqIZAEbxYD6PP38dMcZPs1ThTrJU7zQ8+S7ccL7aC16Oqkohcc8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iE2Qy9x6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ir6qdgwpiudHSGvIqZf3UZHrrrbsMgA9iIwYL6Ldf0U=; b=iE2Qy9x6Sg4y+wDEl3bj4dxn64
	gCZM+M5CKCFy/pvjW1p2OkT8q39b+HPLnqpeQFtfQGA7LIQT455VsNCXAFevt/ZFQdlwY6+lV/T08
	hi9wUOIqd5dzHOSzIBC2F2C1en3bkkET7N+8OxgSq2ZP6UymsXcY5AHMrDYarIBXr43S1FjEAqJwL
	tnWLV4DaRWtSn8qD6VOyT5NExzUXn7LolYKSrpLFNKsSD9ZMMwOWlGrlASjgnLrSgjA6/9i6nUia2
	SO3m5CYQbkwfuUV+eCZiDRKzYLJuG2c9DuxAxC2a3HR2vl2ucCFG25/X7aUlQeXm0S5RF82fcXR7Y
	9YjRd9ow==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWAC8-0000000Fjz1-3cgJ;
	Sat, 03 Feb 2024 07:12:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 02/13] writeback: fix done_index when hitting the wbc->nr_to_write
Date: Sat,  3 Feb 2024 08:11:36 +0100
Message-Id: <20240203071147.862076-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
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
index 02147b61712bc9..b4d978f77b0b69 100644
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


