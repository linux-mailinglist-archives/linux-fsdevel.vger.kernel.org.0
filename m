Return-Path: <linux-fsdevel+bounces-64204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1356DBDCBA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 08:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C858B3C8114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526D30FC19;
	Wed, 15 Oct 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLVl2tc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92C30F803;
	Wed, 15 Oct 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509660; cv=none; b=kSD2IIvytmZgFP8RnSLBieKq2drq7cnwViF6I4w6Q4qM2GVye1aWiSvVnhjYBrYE3JLt/qVWPi+j9R3qFstqm4q91P5Q3cq3MSMHw2E5OOoz5QJJWqnEanPyr6V1TO19/jurvJhbSvfw8mfsPMJ1G/Y6lnK1eYubKlt2t9nE8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509660; c=relaxed/simple;
	bh=5EW7bIlkZx+FyKFZBwA5w4t8uIlU2unOPcRLIdewAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXiBIJu7KHAMPTZFwbD1NuQTBQJGvcWJWuC4D24+PLn2OKybgmVpj1Apm281kcDO5UIGWQDtdXOhHcRrJUGw93daG6ivMUGEooyrQdh4YR7Cj5WAnw5Y8m9yfTLxLxRdKralbZpTs2TMulaDMxPok0i3D8qBVWRfowx7iglH9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VLVl2tc9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ekZhIfM5C/lWrCsA+6fzUl+4ua+pMgg/ooJWvANRBeM=; b=VLVl2tc9wlmvFwkZnVpSIOjJMh
	BTQAuCdxXuz2adRqEZaUoKBgcZga8MQHx3T/L4OJ1UA+Np4AWxA3SZR85bCwSHnRcB5M4uh+2aG/F
	xezJMZwgQlnMxE58pL0kOxVDXadZfHonEeCNvwGUZrXGl8i6AJklQifzLGtlfitQ39H0MG6kw8YF0
	QKe4STFy7qLJB3LdtZcMrvBhUqonycHKle+Q4DJKFfk8zoLiFVt7b6vtra+gJbkeY440vtFqGFIME
	zp1KZmDMPsYNfqS5FWJQ3ZaO9LH366qOct13oYgcujpfayNuIiuDp4o1vMBQGy9pUANjVkCVDQiHK
	GBn+oGpw==;
Received: from [38.87.93.141] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8uz2-00000000bCz-1TPX;
	Wed, 15 Oct 2025 06:27:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Date: Wed, 15 Oct 2025 15:27:14 +0900
Message-ID: <20251015062728.60104-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015062728.60104-1-hch@lst.de>
References: <20251015062728.60104-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Return the pages directly when calculated instead of first assigning
them back to a variable, and directly return for the data integrity /
tagged case instead of going through an else clause.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs-writeback.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..11fd08a0efb8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1893,16 +1893,12 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
 	 *                   (maybe slowly) sync all tagged pages
 	 */
 	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
-		pages = LONG_MAX;
-	else {
-		pages = min(wb->avg_write_bandwidth / 2,
-			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
-		pages = min(pages, work->nr_pages);
-		pages = round_down(pages + MIN_WRITEBACK_PAGES,
-				   MIN_WRITEBACK_PAGES);
-	}
+		return LONG_MAX;
 
-	return pages;
+	pages = min(wb->avg_write_bandwidth / 2,
+		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
+	pages = min(pages, work->nr_pages);
+	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
 }
 
 /*
-- 
2.47.3


