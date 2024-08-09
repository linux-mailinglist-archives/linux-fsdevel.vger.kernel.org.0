Return-Path: <linux-fsdevel+bounces-25547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E973794D48D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCD51F229A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60C1991B0;
	Fri,  9 Aug 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Veef+2gs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89925168B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220554; cv=none; b=sdb0riU/XEtuZDAQTg+VwVfNWjF/lporxjhH71zb1XYEyeZWBgNv7nfUTBUrtqvdZVZVN5bLq2ZdjFI43qcgGZ27fR5sRrxAezN9QNpjGjD7UB5WeXKjk23l/oeuQerhZBNqscjiqdTlp0c2/38gpyLu6Kn5Q4GTLlCOPqp+St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220554; c=relaxed/simple;
	bh=O/gvwbAEv3Jm3XJ9mPRTXbtgnhUu38xOfeNWFNPDFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sox+58xKSyGCkugSGn5rhxQKRdEhaibzVdQ8rPIyRQ5Rit2KpiF9/Q2iCOgh+I9WNJYizwINCo5H26c8xhs8Lfmq1gRbXanTmPcrDwKkBQ4oMBKlfSu7zSfI3Bb9nHO4rqWpeCyvINbE7kgX5OJIV/Fw9EAToZcWVPkE7YXfYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Veef+2gs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6vrGMu6lrEHtXM6oaKmgXSYk9hVv6RyJn8fRBBSHz58=; b=Veef+2gsqyeXc8s9T3ZjSdLKwZ
	q9U/Fa1pi+hR0djsDc9gozd0EGzYXumu5rznsjExSi16k2e03Dltg94JhhkUi500pjRzoSXyUSovd
	k5w0GAk0uYQO8dHIlI0hAbpfPBN2Y1xY2DLANWkRzTDfeHN8uQ/z1QvctnOwHukwS6tGffBAMhFZq
	72Ya3Km/lijU2DzAyBtY3OZES3dkD98u2k5stHNStLqoddBWCYKWhWnrKHRIq4oddhJSO7bzY4+EG
	6qvH/kMRfNiX8Hc8vUQDjSSZw41G2s5e77cPn/NEn5QfuuSxaTfLcjwN+GK3GJ+iGe2BUSXbbj/8F
	QdIoY2qA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scSNq-0000000Apoj-16pf;
	Fri, 09 Aug 2024 16:22:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fuse: Use a folio instead of a page
Date: Fri,  9 Aug 2024 17:22:19 +0100
Message-ID: <20240809162221.2582364-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

part two

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4bf452d5ba9d..2b5533e41a62 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -935,12 +935,12 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_pages; i++) {
-		struct page *page = ap->pages[i];
+		struct folio *folio = page_folio(ap->pages[i]);
 
 		if (!err)
-			SetPageUptodate(page);
-		unlock_page(page);
-		put_page(page);
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
-- 
2.43.0


