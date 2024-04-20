Return-Path: <linux-fsdevel+bounces-17343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D38AB8FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A880DB221AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAC17BCF;
	Sat, 20 Apr 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubi+VSlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FA1773D
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581461; cv=none; b=cWBlje0kRuQpWe5jHpy5m8dbF/yui6WQRwa2D0+1me3dThxzUStpwGNXEKUGlnXIdW0/nlwaxqCxz0vIX1ssxdn7msOs2rD8U75N4dCSpj1H6+fN20tYtjOfNfXHLc4LQOlJXrNXminLrqsQXtZpdotc+MJZZO/vX2FcoHMY0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581461; c=relaxed/simple;
	bh=BKV41FpzXQN+Fwf0Q86zXKTmVIYTkt83bZpcdl3/PRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VemZYNS9aICnJHXBEf2AynxVuRp3l2LGLDHkkicdwSIZ/Ad26WUi+SB4WezCZ2ARBcYWr8oFlFfWIkEvEw/yfaWFii0gJ4kZ8TFVWPs0dre8dTMzGvql2dveHFVXXWa4UFQoVEcjf1xIHe0kC+/mrQBOA2Ex3tFs8XRvB0WUuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubi+VSlC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=ubi+VSlCphTsd5AtD9cNNkb+HS
	nB/FMrouSxmA1uW+1Vxn+g98ve7pogJOK8MnjiaX3HIupI/wSrLZ3Sk0vyNgLubyrkD9i5YRmAmeX
	NsaMUr0g4f4Qp3IOBnTR1yCAi1HQ16jImzYPH91cMfTfFN2Z3rvEgIxhmYf6Flk95MtWplsxJaB/J
	ZKW/niTOR7NdHbEKV1qUkEtdncbL91pWCOZPe1fhsLW/K4r3wt5dsHyyRpM0yHuFsCUkk0LnhEXW9
	699fPezQifdLcWOPNiyQ87VmwvgFRoL4cwBVcu6yVn533CSmzwg7CQdJG4o/3xBiCynO8D4/Xeibt
	SPmp2suA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oU-000000095f0-2u7G;
	Sat, 20 Apr 2024 02:50:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 12/30] hostfs: Convert hostfs_read_folio() to use a folio
Date: Sat, 20 Apr 2024 03:50:07 +0100
Message-ID: <20240420025029.2166544-13-willy@infradead.org>
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

Remove the use of page APIs, including setting/clearing the error flag
which is never checked on hostfs folios.  This does not include support
for large folios as kmap_local_folio() maps only one page at a time.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..e7c72f2634f6 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -432,31 +432,20 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 
 static int hostfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	char *buffer;
-	loff_t start = page_offset(page);
+	loff_t start = folio_pos(folio);
 	int bytes_read, ret = 0;
 
-	buffer = kmap_local_page(page);
+	buffer = kmap_local_folio(folio, 0);
 	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_SIZE);
-	if (bytes_read < 0) {
-		ClearPageUptodate(page);
-		SetPageError(page);
+	if (bytes_read < 0)
 		ret = bytes_read;
-		goto out;
-	}
-
-	memset(buffer + bytes_read, 0, PAGE_SIZE - bytes_read);
-
-	ClearPageError(page);
-	SetPageUptodate(page);
-
- out:
-	flush_dcache_page(page);
+	else
+		buffer = folio_zero_tail(folio, bytes_read, buffer);
 	kunmap_local(buffer);
-	unlock_page(page);
 
+	folio_end_read(folio, ret == 0);
 	return ret;
 }
 
-- 
2.43.0


