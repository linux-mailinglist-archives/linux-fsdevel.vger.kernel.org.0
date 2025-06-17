Return-Path: <linux-fsdevel+bounces-51887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0356ADC8DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD343BB63B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFD2DF3DF;
	Tue, 17 Jun 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0EhulS6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B72DA773;
	Tue, 17 Jun 2025 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157736; cv=none; b=cY9OU+IKPeyukgZWa7chW+2E0JsgAtbBc2xyIFhPXHA3eaVMZeROMv7rBAtji6xIZwxEvteRQhg2T2b/oBcilpSm57j4ykrCgI3xrnZ0v1RhaS7FzuWVHOnsfp+EQ7FE0RFraRMKNQA7UtWVwA0pxSmBdnSpUiv0Z4wvoX6XveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157736; c=relaxed/simple;
	bh=PgF9p+zc+w7USRNiqnY/zwONmKyTBkNdKisbUNA7Yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeA+HpKWZdf8Whrs36MgXMKpEwe/fhu/4hk96vAsp8myu3OpkHRVJ8RUxkMLn33rqteP5cldF5zP+edy73TvJzwoLe2D1ck3/xlw0h9lHLIN5+eLwslQUM6XW+uJ6SL2BPfBf6GEsqsTZB/mm8fDEz4AnCEXAuyQbao1JvJ3a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0EhulS6J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6ur2H6EflXwAkLEQfM+1DGYKxyrrBzzocpR4JVbqJU0=; b=0EhulS6JDOkftAY99zCr9Iuovs
	6lxhqwwTOaQOQvcPPqwQrmc/Hs1wyVWhYNQrEq+4YRzUmayHv/o6X/XkC35pIBd7Fss9oVqmZkIsX
	0gPDMZC7Lkf2Vr8ZnYi4obiLr3YoGHDXdcIB+AJNoPMtShge7PkoEjH60rYQ1SD795pC2oppgLWXm
	94Oj/lkNjBgMixa1h5b41Ap41dt5MyfF/OuQaZ/2McoyNnypPcCgOZHtXk5QL2dc86bJdQeg5v7+T
	w8GrtYcSICVFbBJE9XSrkItzI93Nr0TgUrxPNWFSZoz7HO2GkYzabG7ob23deUZBB+xuxynQv5rYj
	t8oKdt2w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTyX-00000006yp3-42ci;
	Tue, 17 Jun 2025 10:55:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 07/11] iomap: rename iomap_writepage_map to iomap_writeback_folio
Date: Tue, 17 Jun 2025 12:55:06 +0200
Message-ID: <20250617105514.3393938-8-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
References: <20250617105514.3393938-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

->writepage is gone, and our naming wasn't always that great to start
with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c262f883f9f9..c6bbee68812e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1656,7 +1656,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 		return -EIO;
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, folio);
+		error = iomap_writeback_folio(wpc, folio);
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.2


