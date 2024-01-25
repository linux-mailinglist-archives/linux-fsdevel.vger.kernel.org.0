Return-Path: <linux-fsdevel+bounces-8860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6C83BCAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267C91F2BC51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD243AC5;
	Thu, 25 Jan 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvZnatM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9983D99E;
	Thu, 25 Jan 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173155; cv=none; b=MCwiRR9IypBUZKLZY2xG03Y9jpYhqFoltCVGFaAj2+nBW1aoUmRUhrECXGnmE+NT0bb7yODGtq8FZyXq+vFrT5Ko/9GdbOeVtchd+syBapu4Rzz8EebNoW/5cDHCihfc3/o41EHoG/j2WjWnM1SLw9lonUQpklEEzqUhS0Ss3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173155; c=relaxed/simple;
	bh=Uvk7e8gdVc1TWiqOS3CoJw4rNt5x5KZc4D/MwbS6LW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs41gZ5/ikEvGJZnfywsEfCM2K8WsV5rnUAphNWkvv6bHPrMlakAe3cL6MDgJq/JKkCd8HyHUCpa0XGFYLwVvmKO0+GjFzaEgs9OAX5VFB+xxhPxqvPHbgJtFy5LJIuCzutrRWk1diN/9awhcQwQpCed7RupFthf+kUJq8W9o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SvZnatM4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Nvs8NLSkqi3xoK+c7WXXiVGON/brvE1q1HDi04P3LYY=; b=SvZnatM4pQklWGScC9mHPuWxUK
	zxfxMuZE0VccNfw9iFHQXq7CfxUxAP3ayswkwOH9oGRTaHShpXQo8x1SxDbYTd7mqbAwOA+TMKjKq
	hFqcp396BhSwypZVLIY+aIZk/MYyndo49M7J+2iJ990Bde2fVU10Tq4MAZMh6cNa0ObpmVQ59XT4c
	V5x6rM0QRwa7q5KZapCVtfd0UIznQdMlmIPdNRIoInoFYPxjpyeqvOX7Y2/WKzxzcvsnp40odmxRT
	HKO8V+ScM19lkFJ5wwS0ys900HDBiaI5ZkBZa9PvX4+ed9Zhci+vKj4wc+tB7mNLpanWNElWcVxVI
	gdKbdCKA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZi-007QYC-2B;
	Thu, 25 Jan 2024 08:59:07 +0000
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
	Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 17/19] writeback: update the kerneldoc comment for tag_pages_for_writeback
Date: Thu, 25 Jan 2024 09:57:56 +0100
Message-Id: <20240125085758.2393327-18-hch@lst.de>
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

Don't refer to write_cache_pages, which now is just a wrapper for the
writeback iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 81034d5d72e1f4..2a4b5aee5decd9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2325,18 +2325,18 @@ void __init page_writeback_init(void)
 }
 
 /**
- * tag_pages_for_writeback - tag pages to be written by write_cache_pages
+ * tag_pages_for_writeback - tag pages to be written by writeback
  * @mapping: address space structure to write
  * @start: starting page index
  * @end: ending page index (inclusive)
  *
  * This function scans the page range from @start to @end (inclusive) and tags
- * all pages that have DIRTY tag set with a special TOWRITE tag. The idea is
- * that write_cache_pages (or whoever calls this function) will then use
- * TOWRITE tag to identify pages eligible for writeback.  This mechanism is
- * used to avoid livelocking of writeback by a process steadily creating new
- * dirty pages in the file (thus it is important for this function to be quick
- * so that it can tag pages faster than a dirtying process can create them).
+ * all pages that have DIRTY tag set with a special TOWRITE tag.  The caller
+ * can then use the TOWRITE tag to identify pages eligible for writeback.
+ * This mechanism is used to avoid livelocking of writeback by a process
+ * steadily creating new dirty pages in the file (thus it is important for this
+ * function to be quick so that it can tag pages faster than a dirtying process
+ * can create them).
  */
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end)
-- 
2.39.2


