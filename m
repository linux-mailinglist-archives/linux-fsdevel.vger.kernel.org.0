Return-Path: <linux-fsdevel+bounces-20578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801308D53BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E41F214F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234D16D9AC;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hp4lnncA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B575158DD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100481; cv=none; b=j6Y0NJLA1LzjxsQsrxLQ9tGx0+fDtmnF5wJfIqdFU9Bo9KTBaZHeCHQbGQoHhsiwZwNULS9peTlpzJE/IPbWZ4MrYPQcdmTqY7hXT84ulSOl63yUIaz7sZAKAZIYNwRCUKcOcBXT8B9nKK94wdaA8SXURCVN8NU9QGYx0AjKyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100481; c=relaxed/simple;
	bh=BKV41FpzXQN+Fwf0Q86zXKTmVIYTkt83bZpcdl3/PRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls74WQB1NFCPaL1/KJKOsSasPcEXN7RdEDLGJ0K5hsVd/Y8BaWP9/ztQ85UXoAhP3LGYBndBursXRCYHYxk3BFWddum2VdAR2/vD6r2V84I2r0zr5M1NGweExP/o+s4CZMfWLwBg3eWe88mJK7RALyin5bA63cKH26mBoNK1os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hp4lnncA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=Hp4lnncAb+Y7qAWyMQC8y9C3cL
	1NE/tUm4Y+Bo0u5NH1N7c/K1DmobVe+Xgy/2Pw+5tNH/vf0JVZy0rJDldTrmytERkfOR1brelldAV
	t47mdAehl7tkopV60hxaOakAJILKD5HLz2LniSl1Oap+ePGfnVll1h/T8FdvPyBDJBPzbj2fS2OOs
	skaFYUvb2LMTzTFheYdUlwRyyLKDA/JBkBxzu6/igLRf5TI41ELdqED1RMhgiXVRrAY3lYj5eRxjQ
	2/wRD+VjLyaGbwKPy5S72ZGpy00eIx7PL5XGrcRMC/kliJlSbk0P7aZpt+oR6+mjrWYh3Ots1Trmr
	44w3qShg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8LI-3CbL;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 07/16] hostfs: Convert hostfs_read_folio() to use a folio
Date: Thu, 30 May 2024 21:20:59 +0100
Message-ID: <20240530202110.2653630-8-willy@infradead.org>
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


