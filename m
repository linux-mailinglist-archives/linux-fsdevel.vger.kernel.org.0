Return-Path: <linux-fsdevel+bounces-6370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B84817578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B228F1C248F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC73D576;
	Mon, 18 Dec 2023 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ZpRbR4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC34FF7C;
	Mon, 18 Dec 2023 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7163FLdiULRyCtlx5MbrRVNBpAWhlO7V2EZv7W3gfys=; b=3ZpRbR4dzIQW6XHwppDqZ0VacY
	/+zRsMPUMvnF7Sy5qNbH115aR7DDOQvaHRu710B91NeXzplfp3qTlgw7xfv0KrcyWORdshwnkkTmA
	wBgJWLmbwKN5wKEgBZ0dNa1dWgFi/CFzWBohlP/g028rqSTZvYH+R18Xwim7yG1K7ATbdoWKJVTTk
	eYplI3MAGnKoB0nLg8K150hBAhpd9H2ehkExYxakdZNWBLN5nTWldq39fKlzTGSPHfUsFl47/nG4W
	Kb5D26H9trc75XVfWUbmdH/gddMp2u//JG6HZRNz6kFm7Mt3YMVvl1fA/LFDPemXhHP/apthEfVde
	SioTXypQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFex-00BEI3-2w;
	Mon, 18 Dec 2023 15:36:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] writeback: also update wbc->nr_to_write on writeback failure
Date: Mon, 18 Dec 2023 16:35:38 +0100
Message-Id: <20231218153553.807799-3-hch@lst.de>
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

When exiting write_cache_pages early due to a non-integrity write
failure, wbc->nr_to_write currently doesn't account for the folio
we just failed to write.  This doesn't matter because the callers
always ingore the value on a failure, but moving the update to
common code will allow to simply the code, so do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b13ea243edb6b2..8e312d73475646 100644
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


