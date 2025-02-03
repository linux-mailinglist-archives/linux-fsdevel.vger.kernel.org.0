Return-Path: <linux-fsdevel+bounces-40583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E364A25622
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E36164067
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F820101D;
	Mon,  3 Feb 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YAKFcexV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E21FF7D9;
	Mon,  3 Feb 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575820; cv=none; b=QHtudFy0EC5W+USluk/+INQplDu/FC/A7kC6GpYOXo/PWkNW47CLfFRiAUZhiJjGGQYgbTB0RjcLHqUpFI1cgfrBuvS9m7zmSsEuIsll16GzjlPtAdtVVY/+Qez985su8fDb6Dw9ODxRLRBXqsrci/jIqWuWhP7rW9p4ZV5/zpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575820; c=relaxed/simple;
	bh=0H7R/32qBR1ABcEaLP7uvDEdcLC7fV1gh8NLN+pNmEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc/q2ygAQXibmEx56qhq9LCRBmjyz5ijbjyH0j7NZ0KHdGUXUouPE4b/Qtgd/WKx4oxowzwwpR4dT5voX5ShaWGoaba/ZgRNU0Lt3y5RJFggwZ8/c+kz+wZb7zlwc7+9Wwene+5sWRmq1bGGq/wCX3DNJ0sjv06++2Mm4pMUPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YAKFcexV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6K5gePAiaQ8jDiZJyI7dOxfUjMmC+tI4lc9G9PArXnY=; b=YAKFcexVM0Gjs5Y8o3MVjlaJwI
	K/8jSb5D5y9VzAS4OUBEo5eSLGq+ckNOCiz8BO6ndSpAf+e5hO4DRakhcxMcbXOS7y+dT9Coa2krQ
	v4SS7XsaQKGvmnIeQdkgLts+8dhLoLH/Ko7lEZQ3lsvvSrgYv0p8qI7sgDt3EI61WeaV01V3l16of
	dQsg6YKoq/v+7fXKw7tpB2KMjdvdG/Er3KBX2IuhFDlGies7RxJEDOgPWheKUTfJAUDU73CK9y1hV
	hIw0WBUDhCk5I42YBJ8ApNcJZK5sYH/x1rvHUBkhQgZtbP/ONwEnkyjcmo1oAnPO9JiCPzuSql88P
	Sf+nDSlw==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszS-0000000F1iQ-2hRv;
	Mon, 03 Feb 2025 09:43:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 5/7] iomap: limit buffered I/O size to 128M
Date: Mon,  3 Feb 2025 10:43:09 +0100
Message-ID: <20250203094322.1809766-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently iomap can build extremely large bios (I've seen sizes
up to 480MB).  Limit this to a lower bound so that the soon to
be added per-ioend integrity buffer doesn't go beyond what the
page allocator can support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 06990e012884..71bb676d4998 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -456,6 +456,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
+	    ctx->bio->bi_iter.bi_size > SZ_128M ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		if (ctx->bio)
 			iomap_read_submit_bio(iter, ctx);
@@ -1674,6 +1675,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 		u16 ioend_flags)
 {
+	if (wpc->ioend->io_bio.bi_iter.bi_size > SZ_128M)
+		return false;
 	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
 	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-- 
2.45.2


