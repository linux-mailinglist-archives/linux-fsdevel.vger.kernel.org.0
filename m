Return-Path: <linux-fsdevel+bounces-17346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE68AB8FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C11C20F95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB31805A;
	Sat, 20 Apr 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEbyqyoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979A17BAE
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581463; cv=none; b=ArZ/ojZ4l3aAfFo/HJk+yMoOq1a5OHnCUVXYwLdkUsHx7MxrSnKabRrmLl0zVO+QBFx5APwacUSDzqwVFMUE+3Rbx+ogwP0qPmMgD9+wmVs1WeuxVsN2iIDwR7EJ59GmYQkRAQgj6UfqUhW0Rm7gqzcn9IIqP1WmdhbAEpQdebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581463; c=relaxed/simple;
	bh=WdKGX7UsrMBGTyHTctOYjOqge8sOsjhllPvtQJOQZPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYljDP23uZwJjV5E93VLjrMIiRwDXMbRbGy7uNYx//NPUKZrvSfxbe0MkjqGeO1eHMw0LD4B4GgMATHsjFM8wtq3Wn9/FR19HDWefU0/ZzWSQg1h84nzyPeRURpqgJ7LwaIam0WtelQCTQyxM7imXf+fslL2CY9tsX9G0A2M5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BEbyqyoC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=a7yHNOZFt+0LQm68oxpHbAaQyBDUjkgZ9Hyez6IHxQc=; b=BEbyqyoCId2WqYzoaJjWRb+qA5
	19iqFDbNtyxP81P0/448sKvcUwtmOEy6lcpHDCn/z9TttDxkRB6e6MOCLVzzvQnCF/CLGf5kkAOL/
	bCz6KiWshttU9WH4Mf+FvJ9tI9mnfdeid2SibhbSgblnqp909WRjPVHjy/RmEtKPj6z8bCks0Qht3
	IVdca2y2FiG+F4PqLqT5OMhn5pU2l7ZmiPz2TJgd3mZPomnR6A+JqX95A1EQNGfigZ+iyT5MDCoh/
	vkFBg1BWq+AIU+8m/wLhNUlNCg/0TyNQXtusYvQSPqh1tSUDGCdzIudMaVG5+0TgeEMtFuxOgiEgd
	NZx7T+8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0od-000000095gW-1JDd;
	Sat, 20 Apr 2024 02:50:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH 24/30] ufs: Remove call to set the folio error flag
Date: Sat, 20 Apr 2024 03:50:19 +0100
Message-ID: <20240420025029.2166544-25-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on ufs folios, so stop setting it.

Cc: Evgeniy Dushistov <dushistov@mail.ru>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 27c85d92d1dc..61f25d3cf3f7 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -188,7 +188,6 @@ static bool ufs_check_page(struct page *page)
 		   "offset=%lu",
 		   dir->i_ino, (page->index<<PAGE_SHIFT)+offs);
 fail:
-	SetPageError(page);
 	return false;
 }
 
-- 
2.43.0


