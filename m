Return-Path: <linux-fsdevel+bounces-20580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1E8D53BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6EDB251A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B316EBED;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G5Q6Fj/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400B158DDF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100482; cv=none; b=CgsIG2WcNLyf6KEIbevNqFj7RN6QpclvC0ZjIHIMofEMXXPe30ziXv7e4K5C4QFUjM4FvN5I3uUeG2RFnPLuRI2OgJuFvw/ReVFwAe5J+6KG87AeChth7c64SYeVUFf0zGgU7j0owq8D+wq3cQrOTrRbOBpCX8co34cnSbF5Nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100482; c=relaxed/simple;
	bh=WdKGX7UsrMBGTyHTctOYjOqge8sOsjhllPvtQJOQZPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNIA8gtOK1vZaWJsM0LaMlRZXlZQVa+BxIewqGG5pS6Rz+OaLyzHAmwMxFY15Km610+pnkwXmMe04AJtTrPwT32yOjjsxMocGFo1ibmLm/o3wPq+HKLMXsWT8TPQ8L/voZepTVcHt+OiHuRLQ28qIcLzsGwQg5SJ2M/LQO4kntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G5Q6Fj/X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=a7yHNOZFt+0LQm68oxpHbAaQyBDUjkgZ9Hyez6IHxQc=; b=G5Q6Fj/Xu/L5wU8cnT9yooE1il
	WGQJ73jVWUjiHn5TJhMJEJs5pmFUu1VU2X5Md/3PbQW+JfFcDofEUieOy/wY6dKQ8hO/dz8kpQ2lF
	O3DVsTErmtqTaGNikzoNJkiU4eSNjfDb+/BCn7Gaj/hLqppRXif2ntctPdjGpYhmzdLAS5PwjIjIi
	oHO3Ho51/UNpx9uP0SEU2iF1yRlC+NW3Mhr+cvGuacjDPtsBl7w3zN6k5PrUtwFppbBS9xC/kwFjg
	byVf1hBKwsCuLqh8+tU8+LMLoVAAxIXzjgBQ8VsYUYEjkb6CkbWrmNIUbJfI92YdKEzZTFUyj2Ieq
	iyieFIPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8Lc-2cdF;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH 13/16] ufs: Remove call to set the folio error flag
Date: Thu, 30 May 2024 21:21:05 +0100
Message-ID: <20240530202110.2653630-14-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
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


