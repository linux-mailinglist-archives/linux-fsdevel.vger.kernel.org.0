Return-Path: <linux-fsdevel+bounces-11078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67D850DBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FBA1F232C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C3C135;
	Mon, 12 Feb 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fBxYIBr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5A7462;
	Mon, 12 Feb 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722042; cv=none; b=RYbz1SUWyBFa7VEYPhkGGRU4an3dPgYzAS33bBTS6YwaX7cbnunIj5HnhdefE7o47kW7xsUtKjVOa01tT244l2B+MD2qhoN5+88lkYucuQb6AAiJRrYurnwEnEtWclVCVrTqPXs7IwioMEZUE0XBBRg6Onw4vDIDntgqpY3OvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722042; c=relaxed/simple;
	bh=rP1TPgcHWkhJLnsYeLGXh3XxbkZLo6v2aWpQwVYAC9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1qKTr2hASxOIemq++07bTCbls2SpDa7uM14UMex7A7Tpx1WRfZgHyP74NgKL4OrRJJhbxoXs595B3+8sNwZSRut3PmTIvDg2PCrY9ayeJBIkluY/3+pXwyTaeQYwIf5FsgeMqgRmrd4GNQagwr2C32ahhsXVQy6qGvg3AM/y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fBxYIBr5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UWZt1qWFcFm+fzPf8IEKeJSyXZf+l++RirmcZF+UAzI=; b=fBxYIBr50i75typXVRTy376Pn/
	CQXblV/zQ6YusIu7nNdSNa4irkybtfukPQvmp93qD0JxWc9W6DZVzThYo50vrOq4Dwr7te99PFh3f
	vzYWhbE86of4eVstB9bX6ZqvUGSxRZlf5jabXXILmkHa2L17gOEj110mYC4ev4VI7z2JOVfYNksqC
	UEmRO/qWjT+mPYRCr6o514Qc2Y0rZlBM7rt6vQCVvmVi8GiGqCDnxmdlvCsfOWIi00QRG37mlCH50
	DOtT3lNEwJoy+DtTN1lTNFOgaru1s+ViQ62OBfv0b/y3Sxwc5zWfuVV8e3nM9aGaGzHJh0tqVNpmV
	eVw6Q71w==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQVr-00000004Smh-1CN2;
	Mon, 12 Feb 2024 07:13:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] writeback: don't call mapping_set_error in writepage_cb
Date: Mon, 12 Feb 2024 08:13:35 +0100
Message-Id: <20240212071348.1369918-2-hch@lst.de>
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

writepage_cb is the iterator callback for write_cache_pages, which
already tracks all errors and returns them to the caller.  There is
no need to additionally cal mapping_set_error which is intended
for contexts where the error can't be directly returned (e.g. the
I/O completion handlers).

Remove the mapping_set_error call in writepage_cb which is not only
superfluous but also buggy as it can be called with the error argument
set to AOP_WRITEPAGE_ACTIVATE, which is not actually an error but a
magic return value asking the caller to unlock the page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3f255534986a2f..62901fa905f01e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2534,9 +2534,8 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
 		void *data)
 {
 	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
+
+	return mapping->a_ops->writepage(&folio->page, wbc);
 }
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
-- 
2.39.2


