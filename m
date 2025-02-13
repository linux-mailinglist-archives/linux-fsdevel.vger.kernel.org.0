Return-Path: <linux-fsdevel+bounces-41688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778CA3509C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 22:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2868F16DAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2545269805;
	Thu, 13 Feb 2025 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cyG2EoIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19B1714B7;
	Thu, 13 Feb 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483142; cv=none; b=Z8VaxnUTZ2CJAeDoM0t4pP8IEG4MaWjRN4LRoVluMDKxKhCCRxBQCXWnBXEiNDTCshungzeB6+/yUHuHQrSP1sBNN1BKv4rZB06UF6Dp9eSvTfPZkMqbQ8szEP47N6/UmsL7Uncy6KN4+t4B/lYuFFm6PCjXJPh9rAmrLOkAYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483142; c=relaxed/simple;
	bh=yBr5n64/ykMjm6l699ntGDgQuyR6cT5PkvcbbqbzmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNdao16aypN0QX8ZEy5jVKydbwawvR0xLrqE7qVqagvUy21X8ZymL/+bgcL0SmcXGIU2Yn1JumcDdaODTEUTrT9O7fome3ziYn/NPWAGLn6SP2+F3cuWhtYXZyP1pqFNNh5z+bnJ/6XysQ42HMYUjMqUaMOW/ej27CpzFt9id8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cyG2EoIW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=p9WBGnIqtnFeSuvIK0AsG0uMMrdub4bF1vsPcqX4HAQ=; b=cyG2EoIWONYhj7peuUCs4NAsL1
	tmsMbZw+7Y7C9MYhSACypSFmY6pR6NmdoohrXiQ1DZqaeI7l48ewCFqZQWK4dAbOdqAuPV7Tymdfl
	S4LcXf+V1v6go5UPfhcqiUzEyvDbp5xR/9TY5GJ4yZADJBguNHbxrh+b6jgmY1Cgint1vH+d7SFuN
	hxfyvDVZBSZdPnzDlCjOqpPbaDgiaRWe4PLgCL20i0isarjE6rO4zZm//cGg44jWQ2l6vP8/Wmxf9
	KTSS6eaHAHCaN0Mj6rx9dkiQp5cGcdw7La1cP6IXiKvwxvkQdpPmE7b8O3HmOMWAxVcvXKOW44yEB
	toifb11g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tih1c-00000009PJ5-0zjo;
	Thu, 13 Feb 2025 21:45:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Tinguely <mark.tinguely@oracle.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ocfs2: Remove reference to bh->b_page
Date: Thu, 13 Feb 2025 21:45:31 +0000
Message-ID: <20250213214533.2242224-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213214533.2242224-1-willy@infradead.org>
References: <20250213214533.2242224-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are attached to folios, not to pages.  Also
flush_dcache_page() is now deprecated in favour of flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/quota_global.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 15d9acd456ec..e85b1ccf81be 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -273,7 +273,7 @@ ssize_t ocfs2_quota_write(struct super_block *sb, int type,
 	if (new)
 		memset(bh->b_data, 0, sb->s_blocksize);
 	memcpy(bh->b_data + offset, data, len);
-	flush_dcache_page(bh->b_page);
+	flush_dcache_folio(bh->b_folio);
 	set_buffer_uptodate(bh);
 	unlock_buffer(bh);
 	ocfs2_set_buffer_uptodate(INODE_CACHE(gqinode), bh);
-- 
2.47.2


