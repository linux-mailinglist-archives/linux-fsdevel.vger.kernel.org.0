Return-Path: <linux-fsdevel+bounces-11642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D5855A87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C701C22667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B1D51D;
	Thu, 15 Feb 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q7MD1s/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D1B67E;
	Thu, 15 Feb 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979026; cv=none; b=FqT2/fz4Bcjlo2uUvY9ohnN0qgR66kYGeuV5+5zOHH/qd/dRG6Nn+E0nz5tKyiKg+NZWt/206+v8TRngtKbUZq949kjT4xJXiJ7KuY06fnHBg4IXKn5CfXi2EddkSQ6xZnTD/20+FUaEXBUMxtk66WyFL63s5pNHxxiwvHepjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979026; c=relaxed/simple;
	bh=jt9l7liAr8Tzw3htgWauiN648rS7CE21DZGkIgEDjQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3/qp1LcDUBqA+gy7nhhVwxmcWkNVBj40hb2Kae7VDmnixQqMk1eb79i0zTPYBIVXiawlPqxM/U3Eh2dtPeEDllaIi4azcpP0Lu+tENdSQ4s8CxMYXCsfhcyXINn56Dsh793MFU5lMcTcFpw7iljFPTZHI/4R2aXaoV/p37wgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q7MD1s/u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UJh+PesZmsu6jGo4CJstKu5HORejXqiKtJp5m+bTSkE=; b=q7MD1s/u22UXzodFg16cvPL1LC
	4mR8jjvKPzzb1WE2g3gE7ivDBDUKhA+tmRhfL29mt/JywbF+xBOXdBElDU8HcYqxnZRCHZ8Z/Q4Rs
	4R6Vl+7bWIMLtzKxFcO8IMZH6eQDA8tW+yViHoo2Rje4cB41NmrIiGcJh9+InRSqYAuDUa1Vr+X8b
	ZBMaOFeqqOOGzE18C0H2urIKqIWuAxD0Dkn85zVNCNbjEamG0BG2IN9NDH9wRwIN3MaPtFGoc+HNU
	gPSqbkNZTxp7jLIrkRlSvatpbUg8NBNOqKLqgVTlSyRytp58dyUgdOoDGX61Va0+LVl4PIgiPE9IT
	nnOwbEnw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMh-0000000F6qz-2N9y;
	Thu, 15 Feb 2024 06:36:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: convert write_cache_pages() to an iterator v8
Date: Thu, 15 Feb 2024 07:36:35 +0100
Message-Id: <20240215063649.2164017-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is an evolution of the series Matthew Wilcox originally sent in June
2023, which has changed quite a bit since and now has a while based
iterator.

Note that in this version two patches are so different from the previous
version that I've not kept any Reviews or Acks for them, even if the
final result look almost the same as the previous patches with the
incremental patch on the list.

Changes since v7:
 - drop the mapping_set_error removal in writepage_cb for now to get this
   series merged.  I'll do a full audit of mapping_set_error.

Changes since v6:
 - don't access folio->index after releasing the folio batch
 - add a new patch to fix a pre-existing bug where a positive value is
   passed to mapping_set_error

Changes since v5:
 - completely reshuffle the series to directly prepare for the
   writeback_iter() style.
 - don't require *error to be initialized on first call
 - improve various comments
 - fix a bisection hazard where write_cache_pages don't return delayed
   error for a few commits
 - fix a whitespace error
 - drop the iomap patch again for now as the iomap map multiple blocks
   series isn't in mainline yet

Changes since v4:
 - added back the (rebased) iomap conversion now that the conflict is in
   mainline
 - add a new patch to change the iterator

Changes since v3:
 - various commit log spelling fixes
 - remove a statement from a commit log that isn't true any more with the
   changes in v3
 - rename a function
 - merge two helpers

Diffstat:
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   12 +
 mm/page-writeback.c       |  390 ++++++++++++++++++++++++++--------------------
 3 files changed, 250 insertions(+), 170 deletions(-)

