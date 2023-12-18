Return-Path: <linux-fsdevel+bounces-6368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2F81756C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D68B2251C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327C498A2;
	Mon, 18 Dec 2023 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ef/z6OGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9A4236F;
	Mon, 18 Dec 2023 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fOpePqIlVODGcmo3HFeeBH3g3RORLTSl2mjzxWXksuo=; b=ef/z6OGiym6VMWNndQHzrgSssf
	EBETFKYXoYJJtNq1C9mH3HuQTgUYIICMzdd+RJk8f+bqPeZKgzvB9r5denj/kjl/6Rx1laQB+QPKl
	DO3ufG2jER5Chm9x/qyjOt395t6P9gk68QkXovUQH5R59J5O3aMBsHkdqZnw8EXlo+8WSOXh2CyCo
	mGbZti/G13+GR2IhJD4QsOC5HvnTbrBUPuDxuY/KTbu8mGypWYmtg04XB2h+fqEHuLSDGv7gKBIqB
	miSSHI1Dm4Q6uZ/1EpT8SkEKNlarqS5kEziIicr0rCyU/RxykqvJqeHnylZgKnTxUOQqQ9FAasDJQ
	4J/FaIDg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFev-00BEH0-0h;
	Mon, 18 Dec 2023 15:35:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] writeback: fix done_index when hitting the wbc->nr_to_write
Date: Mon, 18 Dec 2023 16:35:37 +0100
Message-Id: <20231218153553.807799-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218153553.807799-1-hch@lst.de>
References: <20231218153553.807799-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When write_cache_pages finishes writing out a folio, it fails to update
done_inde to account for the number of pages in the folio just written.
That means when range_cyclic writeback is restarted, it will be
restarted at this folio instead of after it as it should.  Fix that
by updating done_index before breaking out of the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ee2fd6a6af4072..b13ea243edb6b2 100644
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


