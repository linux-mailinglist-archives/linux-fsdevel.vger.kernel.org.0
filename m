Return-Path: <linux-fsdevel+bounces-25548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6B94D48E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B827B1F226CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AB1990A7;
	Fri,  9 Aug 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJYJBgzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C4168B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220557; cv=none; b=G5jNJH6zQaGKgwpeyTxu4R53s+QeWKJoIKrsnwA/mB+3IoDQZB8Oad5R8x6R4crjDOBgVVIhtkn4LKrt9LHhQhfqVr/phDvDomp8nns8gR1y8oV6NysVVEqhBaNAasMUbvZpgHHsi61c3BuNP5fEbIPAaFyiyfGy6cUHYTJZrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220557; c=relaxed/simple;
	bh=lBFip/OuPo4B2ewzZjk+bP83dKeM72UuwHF/Wz/6C+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZegmgP38LCpXZSmHxSCy33vKTNdlXQygVBIiiz/3sSE03fB1AGNt8S0lYvzS91+lc3wKf2uX7DeXqHFoEDidAKfnZx2JzG3xqwKcUkPvNotH6kkxGCsVDxGrWhUEgFRVwyAZP0eVEbj+sXrsLy9fsSkREkbqjwgd+MlrAyx2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jJYJBgzC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=53Rxo86R+BN2sFnnh2A5u1wr0g2YNpASVq0Z55mCL48=; b=jJYJBgzCPZ/hED2RhSYgD8wqHJ
	1LDErYkDNHjt0gz+AP1s5EIBNmd0NEsCJ3KorBqSCPY9m+W4lxoRNkG7fIZnEFwkpvWqiTt9bqb1u
	7BoMYVUvIbKSkghewXVQEGkkFHnkT/S1EhQ6hTEps2zLQDxljxJ2MsgL8eUbkdHVg2n2KdRzpTuPE
	42xQXnXnLcbRJL6gyxQiOIe4fenN1IncxtzNJU2JLqghv6lz2XZKgSQDu6IU9JAuJObkDatmaI2Vp
	2tfUntshWIfxbn1/ZfNRxGngdAfL5w83229webN7p1/dNvuYRGmIFokVgViTtWMFuQsOLprDjDtHZ
	S713Y/Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scSNq-0000000Apol-1ba6;
	Fri, 09 Aug 2024 16:22:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] fuse: use folio_end_read
Date: Fri,  9 Aug 2024 17:22:20 +0100
Message-ID: <20240809162221.2582364-3-willy@infradead.org>
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

part three

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2b5533e41a62..f39456c65ed7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -937,9 +937,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	for (i = 0; i < ap->num_pages; i++) {
 		struct folio *folio = page_folio(ap->pages[i]);
 
-		if (!err)
-			folio_mark_uptodate(folio);
-		folio_unlock(folio);
+		folio_end_read(folio, !err);
 		folio_put(folio);
 	}
 	if (ia->ff)
-- 
2.43.0


