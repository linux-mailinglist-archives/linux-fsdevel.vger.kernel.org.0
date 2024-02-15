Return-Path: <linux-fsdevel+bounces-11643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD320855A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9581C23E76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8512B9D;
	Thu, 15 Feb 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQy5ZP4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D7DDDC;
	Thu, 15 Feb 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979029; cv=none; b=Ela6schlzn0bL4ZDlyJWW4NJ2PQaeGSR7aLgsDia8+Di4mm7UoVZNmWj/r+iDjRf9ZgrmpKENaxkbB+xz6Nk0IXDo83OkiTvv5C+jtuRyab8FNxwniGAtmSyMNi7vAehI6OSs9j6gvLQxA1JQlzDD1jgrnL+88O/Pi73jzg4kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979029; c=relaxed/simple;
	bh=Zp3cCLINEokOiPdXtcRCwweX4H6+xgszIGGxoW504HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gkbQPNKmpaozSc9zQmtTB/98N9/YPuYp5k1miq6qbJCWKQ3xnVq3WOVoqCcC7bv0O0ttAiH5PmNPOoX8bJv8hCBwSKQ19AoQGX6g9Xh/jps1hu8eKEFyQrjunE4sD/2YTHhbDL4E0Xy2WXMZOPMBKJnwawD7ExGcO4H1/CrvIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQy5ZP4K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+lqvdXiJyeUBbv4RbCH+VsOF1ziPvzDxge6GroiRQvo=; b=RQy5ZP4K+MfZPbgvfHc/NQ8KKg
	/6kUwQ2DirErEZ02NYbD0SuZEXTN3xFdk4RRZgNfUoghQCegfesZxeVsgjgZuqljlaTeehhhryRws
	H8jn4iZs9OkXYFWnHUUKPoobWTwYzUUqEDUvFFwISJtD0CL3ljuJimr8QWkLNiJ3PZ+d9lzt00uqT
	CH+gSCJeBoj9W/Tu06EUGk+0rt5X8l+aleBGY15DXdZ1jKJjezRErCB5Yjwex3fP4Igr8mavIXIJ3
	VQI5RStF7Dma1XC8/Lq4JqxK0xzV5sLj1ucujTbSmsrHvq80FRAY5npC3+SOcKP1qUJkQ7acIERdO
	u/QgPIkw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMm-0000000F6rU-0x11;
	Thu, 15 Feb 2024 06:37:04 +0000
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
Subject: [PATCH 02/14] writeback: remove a duplicate prototype for tag_pages_for_writeback
Date: Thu, 15 Feb 2024 07:36:37 +0100
Message-Id: <20240215063649.2164017-3-hch@lst.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: split from a larger patch]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
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


