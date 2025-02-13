Return-Path: <linux-fsdevel+bounces-41675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C6A34D82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287BE18872F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFD3245008;
	Thu, 13 Feb 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f7tqWJi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566C2036FF;
	Thu, 13 Feb 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470858; cv=none; b=f3EGyzNqqH8wLWW1u1ETvNTj3+C2rn6fbPOj4dztANkpVCfxvur6UBwZ8MYmEU5+3y1saa6+PiMvNJJcge390E1mp8ocuN4t+hCc9sDuXE8KpuZQtd87/p7EdhO48iE3FbKy8F8l7XuMkA8lIM7pai9dlf24fwyADpmezy3Pd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470858; c=relaxed/simple;
	bh=4Vg82AC/5gDtPXGykDauQPdymUd43FQ3195zRfcKIko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlX6/faMubghZOZVuRE+Wl6nA+8gKH/wndqx/26x6UQPcoTLXJdqoVM/XVeQxLYIqVHnMgcM3QkHGC2fqecxgGqjCFC/bCcLj380dUegsUtVMJ8fxLhwZLk1fz/qtKuobrfabITOiB6AoFdxC2dhusQJkQ5jDQXuc5mSxbtn6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f7tqWJi+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7/aIj9xuYsDybw9On8Ao7mbYiCDQk1kEHDh39AlhraQ=; b=f7tqWJi+snhkvMGnoM+NwLlSVK
	kRQ6ikNXNCTdTebrgq07PfmhiahbYmZCx6UN3Kg9TyMMdkliSXLDGf6HJlmc8TE0tWonk4tQJlLDB
	Wd1X8x+C9EQ6tFLLhluM4lJDRENUEFUblmms3SUz6KqtbUTbkXYb8GyeuKCFwFxFfAm/Ep66sfR61
	vwwBkboD3EGWmaFaieK+b+IUl6Pz8N4M7jF0eWjg5Db7ufXVeHSqG6ti4X1oujp/MXb7T9biZu16f
	PBzEeE9mCmF2I2/Ii5SiV5scgN8eO24PVFG4CsLlN8uBr9gSQNt2lLZlFveGwUYI3bwd7DEzYkTpn
	WuWnmg0A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tidpQ-00000008wTr-3E54;
	Thu, 13 Feb 2025 18:20:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ext2: Remove reference to bh->b_page
Date: Thu, 13 Feb 2025 18:20:43 +0000
Message-ID: <20250213182045.2131356-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
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
 fs/ext2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..21bea926e0ee 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1556,7 +1556,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 		}
 		lock_buffer(bh);
 		memcpy(bh->b_data+offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
+		flush_dcache_folio(bh->b_folio);
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
-- 
2.47.2


