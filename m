Return-Path: <linux-fsdevel+bounces-8843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578683BC71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB892B26A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D51BC44;
	Thu, 25 Jan 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPX9xF5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEB1B971;
	Thu, 25 Jan 2024 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173096; cv=none; b=qsswjLKQxG8DHnxDGZr54etjJusT7XCLl1qYrnBtuDKfuPkgCGNvMMLh/LRc7C+8381LNvPjfXIW9lgktvo7C6WNgR7TWapYOCQM0wRGZhg15OIwyqbZYmAIIjdh4RDRzTcMxLabtF3KNDRVrDgCsQ+hZhaGdw7d8YqqCwOWQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173096; c=relaxed/simple;
	bh=DGARGiV7zHVgbl0w4X98OfLc6PET/vZGhzOxvKGr62s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdidM8NExcYnA8cevWwBzQLIPYpUGqNym2+XN2KNT4/Jr5CtIYLMWU/vbE6RImehmTmRO/zyKNB9BaGFAMjP6Fa6DuMYksT3Iu46JoYgp2IlfpDrMEwKXLivL2WxcIHNM/cgUTxnf4N5gTRRE/iLuIu6ItVcp8x1YuGrutL+mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kPX9xF5+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pITNTbiyepqtlo8jP3CXnxlwUzR/Qf7OVM31pgQXB2c=; b=kPX9xF5+9DOPdosYkrB4Gr7OOk
	5ZlGLcIDUkax96vrJCDbY/nuuyGiD6tZpyCwUUKBzMPUI5/FUH27SCTQnbKcPPH6k4pfwzuHB/NnW
	KiUHwflreZCIKmAfCsS//LnMJoJ4efOoi4Qk90nWwqnrKIFkYhMKyCywz/0/wE6Blsoboh4A0cXJL
	6rZJlpqo6dJ1An7vfDAsSIWlqBdbYK5cAWqxNG+L+GTNFn5/gxRkOYOy0Of9iCKTXkeoH3GsUQFFG
	eugtxQofw3oW8cB3zk7+g7AX/EXuuPLtVV0s+b0Rb59uTXlN7SZWMh2Qq65VBgLd7ux0QqVdjPwWF
	WTjSr3mQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvYl-007Q8L-2u;
	Thu, 25 Jan 2024 08:58:08 +0000
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
Subject: [PATCH 01/19] writeback: fix done_index when hitting the wbc->nr_to_write
Date: Thu, 25 Jan 2024 09:57:40 +0100
Message-Id: <20240125085758.2393327-2-hch@lst.de>
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

When write_cache_pages finishes writing out a folio, it fails to update
done_index to account for the number of pages in the folio just written.
That means when range_cyclic writeback is restarted, it will be
restarted at this folio instead of after it as it should.  Fix that
by updating done_index before breaking out of the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40ae..ef2334291a7270 100644
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


