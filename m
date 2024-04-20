Return-Path: <linux-fsdevel+bounces-17342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C78AB8F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4701F21AA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD818F6A;
	Sat, 20 Apr 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5+TgAjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F4175B1
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581461; cv=none; b=uiGh8sMdJlN5Kb65IWUPoO8EHnjNgv2yaK2caEWk87QgRZzx11DQq09nmJgioDBMsipJjWlDOzQoy9KCfcBFD5JSlANmiMCnh4yh8RK5Q0Xn6uGWPmvInYIy0EfL3v2Ygc4FcuY0+QeiZowgAiy6ih4i4d9lv3EoUGQBi2dF8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581461; c=relaxed/simple;
	bh=TvqLSu2qo0lh/b1fZFV6UNHbkBv75iclu0kdDFZ9yG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGhK7A6Mu/VH1F8Z22ZCVkBhUNs25zf5Rn3jrLjkNasuxNdUwzFhUlIrWnVEWx483M5zg2B+yuSzTbOGEYeDjBYbXBrT2sEG504+OS6qwZxONj2eIMBAbJsomaJIQAg5qrcGNAJZLsucCvgB6VwedJYSwNwnw2q8AQHKl1lKth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S5+TgAjD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FOaktHNmxMd+cZ/fUyKcI80t1QsvXs7Jj3EI/hp2RVs=; b=S5+TgAjD6hrJluFct7n5ncCee3
	IAY5RChLf4XDLdw0Ip2ZpGIosRDF8zrKPgGAz7o87C+ox353HukxEGo8Oa3RYAjxg1bsyz8XnY1/M
	V6o05uFf/YvLk5suAvLSnBbConzUa1TS+xWZPWbLDZraIYez0hAvMImTcN9S39kAOrxgObNtNOhmX
	xFOv+TeEtTsEfQPP/SaqRJF4Hy19E3qTobzGipD3KTmDMdxosETWa4Lvy/OJzgtpqONb+PYYdfXZv
	VcwkHmWznwtIeqhEBJKAlphgyZxjCz5kVmjYrHRo4fNSlutVMw3imD7VVdzybWuOkha9WuCOivoAt
	z5wm97Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oU-000000095ey-1okc;
	Sat, 20 Apr 2024 02:50:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 11/30] fuse: Convert fuse_readpages_end() to use folio_end_read()
Date: Sat, 20 Apr 2024 03:50:06 +0100
Message-ID: <20240420025029.2166544-12-willy@infradead.org>
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

Nobody checks the error flag on fuse folios, so stop setting it.
Optimise the (optional) setting of the uptodate flag and clearing
of the lock flag by using folio_end_read().

Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce4157640..f39456c65ed7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -935,14 +935,10 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_pages; i++) {
-		struct page *page = ap->pages[i];
+		struct folio *folio = page_folio(ap->pages[i]);
 
-		if (!err)
-			SetPageUptodate(page);
-		else
-			SetPageError(page);
-		unlock_page(page);
-		put_page(page);
+		folio_end_read(folio, !err);
+		folio_put(folio);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
-- 
2.43.0


