Return-Path: <linux-fsdevel+bounces-8847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E325F83BC80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7AB22E51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543541C284;
	Thu, 25 Jan 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXlszTq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791121C288;
	Thu, 25 Jan 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173107; cv=none; b=eHoTFgclrsSWrhmqgfs+MoimpJ6vvVuNgdgXw5v+6/0pp/+CPS2n9am1cQMzAEwaxoIXZrUdWO0bPaKHRhOnOVP4cg0AfpTBJmF7K0QPzTdM/4aUv1HEheswAbtESCqIbEagfYu1CudnTyC7SM+u+H9Sxa3SAcE3MksdXYSAUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173107; c=relaxed/simple;
	bh=NDJY3QBfwPu+KI8BQUz90fu+4aBOpWSkWf+95LmB4qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3+hpDByYuYcmyzo2j75cP7Tt50QVuQa/Xe70DO0qaNCVSsM5GvEdDy/67q6s55Ke00rsqB4AYO3jo/Q56VjiJ7C3304z/bPjWoOyCLtA/fZV9DBmxPLfiAMMbD1OPekIVsotq2oWVsLqEnB9ZFHkwqTuhMldCQra6ZGDTp0pL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GXlszTq6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Taksxj6ldsIHACaAalkM9jooesWM/uwlc+qMiL84I/w=; b=GXlszTq66WVW6aNXlFQph8c9ec
	+uEY+GZCHqemFTAAG1dRDeShUFrgHZ886JX0tfhFtxQJ5IaaQrNNp8D3bk+EMuwcl34AbvvJM9l3J
	XS8A/YQ6Qhg9fsY7psv1wnOTtNFxk8ynFXa3yEGAJXJxnoPzO6kanY4MSDyepXIOpP4ttSUCJvALG
	icbVpuyEDb3zJBoekF8IPH5fBVW72ixdQpehxaJidncDc5Wq6S8fbyPITeP/8AHBYR5elWPXyzZDw
	gM/aWzH37d2eyg75230hwI9gEMGsl6+E0D09XvH7NE94ULvS3qmeFzXhs0osVgYjcWuUIPElZkuYB
	AUcJQ2Dg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvYz-007QFR-2f;
	Thu, 25 Jan 2024 08:58:22 +0000
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
Subject: [PATCH 05/19] writeback: remove a duplicate prototype for tag_pages_for_writeback
Date: Thu, 25 Jan 2024 09:57:44 +0100
Message-Id: <20240125085758.2393327-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125085758.2393327-1-hch@lst.de>
References: <20240125085758.2393327-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: split from a larger patch]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 453736fd1d23ce..4b8cf9e4810bad 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -363,8 +363,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
-- 
2.39.2


