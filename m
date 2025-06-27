Return-Path: <linux-fsdevel+bounces-53149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92683AEAFA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC063BF3A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8B21C166;
	Fri, 27 Jun 2025 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1je7bJWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A821CA13;
	Fri, 27 Jun 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007834; cv=none; b=JYbUWNJKSEbgRlTgXydiY05IpMRVQNtYD+stbTaLhXAPBdZKN6jyv0FfytIi/Xtor44ATnMaOWrZWmC0sYJkh+oK24kjC+UAFxpmg9yi1Ugo4AeSBY5WnjVpWff7kzIJpIZLX6iZQBfZbdQQtcp8QGeI65Q5xIz0arV6x0smsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007834; c=relaxed/simple;
	bh=lzlvxOb4yF1Rz4ZtSioDTuljiq0seyOAQlkz0v5grB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkAVKKrBtpV3KLinRnrTZcBtTbDb2diBpHZIZdsvB6CKvTMsBGmrCXe6qBQ6nAfPBQmzHoqO8r0lYBW9LFDSn1q4/nK2rmQVkMuQ9YspDeKsbpTDowll4lPBbpzXUqhtMK5mtCMWEqoj18iEKAk+5d/qkGbkZp3GoZ3oqtNLpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1je7bJWO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rdjzvtc17fmegsp3uWOy1/B16x0b+XyVX7bNWJDgpNE=; b=1je7bJWOCq0JtaQFDp46DAWeQS
	bwSg3BAHm34MpiMA+atDcFTzPdfKrh6fuLHTNRb/6XX96toNvY7mGyzpIWgRtEKU6zEU1KRf4rDsx
	lSZt+ZxG+3phjvG5eEDo1zGnBvAY47yLeKZLAxw1I45Q2eihV8isjlpPhdf/F8hNk1Qf/QMLJre1J
	s7XA2V/TX9KUvTkfEq/LuOyazq2A8Y6Lp21koA+OR8fjJ4uMC+M4YBxYPz98SFL9/SwoIbZvLI92G
	lySP5rCSPz1K+V1yin8WsY2q+6aiAQDS/cqTh5JNovP+XhCIZ1t76OKJ4XBdwRieQ5PnxToED6VQF
	F0kbw60w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37o-0000000DlyP-2bg4;
	Fri, 27 Jun 2025 07:03:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 08/12] iomap: move folio_unlock out of iomap_writeback_folio
Date: Fri, 27 Jun 2025 09:02:41 +0200
Message-ID: <20250627070328.975394-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627070328.975394-1-hch@lst.de>
References: <20250627070328.975394-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Joanne Koong <joannelkoong@gmail.com>

Move unlocking the folio out of iomap_writeback_folio into the caller.
This means the end writeback machinery is now run with the folio locked
when no writeback happend, or writeback completed extremely fast.

This prepares for exporting iomap_writeback_folio for use in folio
laundering.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c28eb6a6eee4..a1dccf4e7063 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1656,10 +1656,8 @@ static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1713,7 +1711,6 @@ static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1740,8 +1737,10 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
-	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
+		folio_unlock(folio);
+	}
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.2


