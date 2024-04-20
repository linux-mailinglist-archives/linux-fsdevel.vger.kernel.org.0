Return-Path: <linux-fsdevel+bounces-17344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9208AB8FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352211F21C4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114317BD5;
	Sat, 20 Apr 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvmGBfbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038217735;
	Sat, 20 Apr 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581461; cv=none; b=NLN1LKPD8gtylfAfBH/TDyi1pGavSbZ+EPlXwR7Q/myAIIAyVXwqSu8X7r4Tr93pBbTmQMzMqmKkBlaZCO4Gct9gfsrZEnzwj/9mVsug7ezfUjei3+5JNv6pOuxVlB7baKPNrviwAqes+9HRgF1Ldc3/PHK7t4C1EmnJij1u73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581461; c=relaxed/simple;
	bh=gDoutF5VcemMF/fu9UMoD/j8LK8EcbrzcqGq7Swrmv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNIiMBp0OZRK+gD8Z5gVrXF1P2LUGtxvsF4xJNro8KqZYGXsOBJN+aCX9/DzXCeW5y+seFZiLXq8If481x9PTpD+4S9WIid2MjOAH70LXjwu4KqIt7I2zfEdMNkg1dRQ0nSJsVBQGnocTsSDoXYiQXYeHp/Px0YoSzFhLysNbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvmGBfbA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JJUtBb3Yt0yc+VEokI0uWtLP+ciqGPKTapKFG3xz7p0=; b=qvmGBfbAPWp4ZT0CzYcL5igk1q
	0aVXlXLl8g6cL4ELWaCjI6Nbr6e4lp2LKop5cApwBXgGhD0h10tgwQsTbU6oKntHok0qZWVM5liHW
	qhJz/FGPhspjUmc1D2t2qmGH+dho0V02jaqMstt8MYgVGbIt7+yjWM6i9hO6Fl+h5DUTxRzzJz1Ia
	+0I6cWbYKQSwdIbZByfJup0/XhyFZSHjPAVjGOTR0MpB/KIeXf5M/dxKmnNym1OEpoTf5oTb31l1U
	CJoFC9NCN8HbfrBMHJ+TTPCOjE/eainlmeDOJ17caw5JiMcm1XogMPzIq/FfsSHF32n8r2XQg/c/4
	HU/rwdxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0ob-000000095gA-2ir4;
	Sat, 20 Apr 2024 02:50:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 21/30] smb: Remove calls to set folio error flag
Date: Sat, 20 Apr 2024 03:50:16 +0100
Message-ID: <20240420025029.2166544-22-willy@infradead.org>
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

The folio error flag is never checked for smb folios, so remove
calls to set it.

Cc: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/smb/client/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index cf02d981fc13..dce121c5a86a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -124,7 +124,6 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 			continue;
 		}
 
-		folio_set_error(folio);
 		folio_end_writeback(folio);
 	}
 
@@ -3156,7 +3155,6 @@ cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
 			goto retry_write;
 		redirty_page_for_writepage(wbc, page);
 	} else if (rc != 0) {
-		SetPageError(page);
 		mapping_set_error(page->mapping, rc);
 	} else {
 		SetPageUptodate(page);
-- 
2.43.0


