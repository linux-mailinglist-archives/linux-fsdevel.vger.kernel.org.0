Return-Path: <linux-fsdevel+bounces-11081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FB850DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8051C21575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206712B77;
	Mon, 12 Feb 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJIvNT8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F91119F;
	Mon, 12 Feb 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722054; cv=none; b=CKfGHveq/6Gr/Sy4His1NWDbRY/hqLLxrFoVJPKcSUggytalHG8B4TTduHPtP2uPDjml4NLFqjXcjMQuxi1TmODTwcRniczNALWMgzhaj7EOOOOIXCHVoAQIuZJSYL2T1xLmuyfeQTKJdSs5h8W4WOvpZ6bQdZmtNx1XTW3IP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722054; c=relaxed/simple;
	bh=GL1mB2qr1ND5+ILCIRB0lCKQZDgTWyOuUcvG6Wq3oDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFbZowERhwS4NcupDOy2eX8nLRSf5URhhQJ3BRHQ113/KbHuyedvaJcd+dKikIq3r/iDuYV+M1h5COI19IWSW1aqAI5WokMH+DeerjNiG1Vr96u3ld0OlPpDwmIan9qonUpoGMZ0WR7vymQvhFc9WjaF8SGFzWmJb4IdVG7VyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dJIvNT8i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2QW1YOpfZggQarO2hJ9pUOEEOVq5PMz3pyBHLyK4cac=; b=dJIvNT8iPWSyPAEA1cLuE0R6F/
	+MI3j0k2PaFmoed7PIV31w4cjyiO/A9tRJ1wuYiDzg0P6+2xn9yGpkqkoU84H/uyqGDD8/8PxBBfQ
	AFkG/svjPlhqN9q9KovsSyxhMQnnhYP6eKBcGdGQ7cpErALum72bOaABOLi3nWI08NNWV6YIRTDM4
	XaZWfmZtuFb7tRrSdMIatAztr8Wku7CuRHPn8WD52iMGkhxkDKK2RFyyLSDnYhpbrmDbaWIBV1wEY
	EM+HyvMdvT7MosOnjNsAmMCaAYPWgIVZa2GMzHwxyB+/wjpNd1Fa1LR87khgeDjw5xO/CjND/s9mR
	/fh/xOzA==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQW1-00000004Sqd-1p3o;
	Mon, 12 Feb 2024 07:14:09 +0000
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
Subject: [PATCH 04/14] writeback: also update wbc->nr_to_write on writeback failure
Date: Mon, 12 Feb 2024 08:13:38 +0100
Message-Id: <20240212071348.1369918-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When exiting write_cache_pages early due to a non-integrity write
failure, wbc->nr_to_write currently doesn't account for the folio
we just failed to write.  This doesn't matter because the callers
always ingore the value on a failure, but moving the update to
common code will allow to simplify the code, so do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index aa3b432f77e37a..06afba8f078515 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2473,6 +2473,7 @@ int write_cache_pages(struct address_space *mapping,
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 			error = writepage(folio, wbc, data);
 			nr = folio_nr_pages(folio);
+			wbc->nr_to_write -= nr;
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2506,7 +2507,6 @@ int write_cache_pages(struct address_space *mapping,
 			 * we tagged for writeback prior to entering this loop.
 			 */
 			done_index = folio->index + nr;
-			wbc->nr_to_write -= nr;
 			if (wbc->nr_to_write <= 0 &&
 			    wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
-- 
2.39.2


