Return-Path: <linux-fsdevel+bounces-17182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D038A89FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550921C222DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27773172BBA;
	Wed, 17 Apr 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENoXTYFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BD172BC4;
	Wed, 17 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373796; cv=none; b=SYMrZSRiJZ9FX3tbjmSJhRbCxBIlMgo3Ei2izPCod1cHKkXNjQWP8SGktU4+EN8bgLYlIAwK/RIXw+OBqf3nzjXxxCvija2UcbX0WDzjg/JkgE3o9uGmYHGUI5/FA8mY53CCpiXIc+EwTAczbAd0nPMQx9o3OU+xm9Xr5D9/1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373796; c=relaxed/simple;
	bh=hhyT8NyjB+05U7DjUTa8gI8Gwbdxanhqbs9YNcx1xNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa92abCSWeLpNZcm7XG3zovtxZQOhM8zS9PfuWKORuPY3AZyhZZ8l/aIxCnNRES5BxSrMvbArlbpGo5xnPy/HDLV9NmXXSe5W4Y/CwB2XoeK031SJx0QLMyvFdjx6qLZ1/Dh87sAH/w97cjqoTpbeXWlE6CBN9recq6G06SbiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ENoXTYFU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fpKWg49bgezfZO5bk51+dX+JEDPDXpjRn8QsOv7hfOw=; b=ENoXTYFU6E2FrjCDoEwrWsVUdp
	TFdDmTmCnLFGhA1IvQk2JeQy/z2VLu92JJ9JhfL16Vi91HBJLbZv4eGCexHYT9uWyB3663asRiZYA
	wg2HvWKpmqJZ73wA3lJwJVgkuoD+mivojtHkToKG+j/h1JFXBLAFTU8oU5c2PH557zaNnO65HP44O
	fapPIMU0WE+XUj8yksctQ3DKt1/+8wbZD2pG+PilOkMkzYWkZe84lymSgxU/hMpuJWeQOjxKiDrx1
	c0e8fCgGEZRCO5bgBVHIf3FpLVxsgwFGw2v7PzwKDq61AEa3TXxDB2sjgysVKNEhFcw+MAAfZoWIS
	YnqBCoOw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8nB-00000003LO3-29MZ;
	Wed, 17 Apr 2024 17:09:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] ntfs3: Remove ntfs_map_page and ntfs_unmap_page
Date: Wed, 17 Apr 2024 18:09:38 +0100
Message-ID: <20240417170941.797116-11-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions have no more callers, so remove them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/ntfs_fs.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 1582cde21988..c3f71a47fd17 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -907,22 +907,6 @@ static inline bool ntfs_is_meta_file(struct ntfs_sb_info *sbi, CLST rno)
 	       rno == sbi->usn_jrnl_no;
 }
 
-static inline void ntfs_unmap_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
-static inline struct page *ntfs_map_page(struct address_space *mapping,
-					 unsigned long index)
-{
-	struct page *page = read_mapping_page(mapping, index, NULL);
-
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
-}
-
 static inline size_t wnd_zone_bit(const struct wnd_bitmap *wnd)
 {
 	return wnd->zone_bit;
-- 
2.43.0


