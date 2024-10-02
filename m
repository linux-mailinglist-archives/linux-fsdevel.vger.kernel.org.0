Return-Path: <linux-fsdevel+bounces-30646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207D98CBD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEBBB2414E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C574EB51;
	Wed,  2 Oct 2024 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMtIe9YM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CF482E4;
	Wed,  2 Oct 2024 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841681; cv=none; b=Pa59myK3ZnTPmslgg+Jc95lTzCIZS9j4UJBO8L1xQPuHRhOFD8JLZaZ0vC2OS2KMYZDOVSmrqY8QmQoM6u7eaE8exFi1mOKHqb6Gum9url92pfN2d3wGjyoAXmDqF+PvvZ6wIfoA8CKO9Slft0GAmRhyIEds5B/7QXDnuM58JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841681; c=relaxed/simple;
	bh=eBhcOcMbrLy9/fehR74PUakwF/9049yDkRIeCHnPKZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOvdBApFAb5veYZDRfovsZVqiFnyPl1MrDmDoyl9zEAIRZjsw52dftcgcsg/2kyE0Qt3sMp4Ogqw3k+gLjD+vkgGUBXuXqw70GkN1iTpqoVFXiluDPyFQnZCp/WhFMJRE/+wGd24tzEcvau7bbeoQHEUwxjszPGzvQJuiJKWKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMtIe9YM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jm1g6XtuabKqm9/JIMlSTf6MikBfRVYmTm8EFY+uDyU=; b=DMtIe9YMNkx31KhDVNPCTySp1x
	pXXraeUTSuORncN9UhAdmxtUQ8bt5st5ctV3seN3YE7qCDfDzL4HB/QqvtEKCX39BJsrmELrtr9CW
	+daJ720l9aLvJ+RMK24+79cTk7PD65qaKAH4Nro1VTW/YpcPpQyGtYM84yUXydyromE3/CWfGIqK+
	qzi7b9t6ZKLHb4eEcCBeMInvSa9UrrrhU7bkWlLrtmGFsP0FY5SICdK90ofGWBi1/tqbEKqi6UVtW
	vGSOo0uqu+hPAYjEEF0SufgLYzBJCCJCZmTDGy0+965MEKyevWlEI6vUfAYGk8H9b4bbrKctu1ltA
	kxEmSWBg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY5-00000004I8V-3AQG;
	Wed, 02 Oct 2024 04:01:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] nilfs2: Convert nilfs_copy_buffer() to use folios
Date: Wed,  2 Oct 2024 05:01:04 +0100
Message-ID: <20241002040111.1023018-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002040111.1023018-1-willy@infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio APIs instead of page APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/page.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 9c0b7cddeaae..16bb82cdbc07 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -98,16 +98,16 @@ void nilfs_forget_buffer(struct buffer_head *bh)
  */
 void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 {
-	void *kaddr0, *kaddr1;
+	void *saddr, *daddr;
 	unsigned long bits;
-	struct page *spage = sbh->b_page, *dpage = dbh->b_page;
+	struct folio *sfolio = sbh->b_folio, *dfolio = dbh->b_folio;
 	struct buffer_head *bh;
 
-	kaddr0 = kmap_local_page(spage);
-	kaddr1 = kmap_local_page(dpage);
-	memcpy(kaddr1 + bh_offset(dbh), kaddr0 + bh_offset(sbh), sbh->b_size);
-	kunmap_local(kaddr1);
-	kunmap_local(kaddr0);
+	saddr = kmap_local_folio(sfolio, bh_offset(sbh));
+	daddr = kmap_local_folio(dfolio, bh_offset(dbh));
+	memcpy(daddr, saddr, sbh->b_size);
+	kunmap_local(daddr);
+	kunmap_local(saddr);
 
 	dbh->b_state = sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
 	dbh->b_blocknr = sbh->b_blocknr;
@@ -121,13 +121,13 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 		unlock_buffer(bh);
 	}
 	if (bits & BIT(BH_Uptodate))
-		SetPageUptodate(dpage);
+		folio_mark_uptodate(dfolio);
 	else
-		ClearPageUptodate(dpage);
+		folio_clear_uptodate(dfolio);
 	if (bits & BIT(BH_Mapped))
-		SetPageMappedToDisk(dpage);
+		folio_set_mappedtodisk(dfolio);
 	else
-		ClearPageMappedToDisk(dpage);
+		folio_clear_mappedtodisk(dfolio);
 }
 
 /**
-- 
2.43.0


