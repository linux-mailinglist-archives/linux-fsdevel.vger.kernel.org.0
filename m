Return-Path: <linux-fsdevel+bounces-23494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BF92D598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF142289997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8279194AF8;
	Wed, 10 Jul 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HN2BCEMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF6194A65
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627192; cv=none; b=F+90jCGrIE5+vGASY7+Azp2oT1R4/MLSQZuVO5awXtin5KrRjL3QwruArC1qiKt4BTDXDoVoFwauv2F8oubIsWrZsYMIR/JXAp+77ZeimMzqB3xeOufeos38ubmVbcfwvZbjWQCdMDM32hL4iK3YCv9exUPQHSxWAIOX/UYrBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627192; c=relaxed/simple;
	bh=yLKSiht6JtNy7AHKZksYh/3kFxspZHhdNnHY6wgTXis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtSCZujkmxHnokVz6WLITqkHoNkJWPLfEj5diqQZGS0gy+yzs21nggmV+RakP4M8pPKkx1HXprglD/EDDCpTmhGtEYYvMmy/q2bpZizw1X7f3ss9U6cr0Z+6BB422+nE3Zq2nTmL/VyIw0YVIc849f2qOqQvO+aHk3c4+y7iOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HN2BCEMt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=k6RnHamUZ6b+LcV0tbmEv9uSxqKfCSEP0g9O0xkGKFI=; b=HN2BCEMt3eUSuUwCy+Z+FvfV+o
	qZR3nwHo4EKHDERnmNad77If8MkRqEnprx60woll7Y/2zBgB8GIEAWIPr5bYGOkTJY431W5NLtvUr
	BqGCKeGqjXNwp7YJjjDvSsTnfgeoB4RutQG0zxdY4IrzD+3VoqqznBppruZDCFb8WMCgKivL2chOo
	9pJXq1wxLwcJ9IeAiV7kHH40fUA8InkBm47qZ1OIzGkQYKnjbQCa2rg9A8VNbT2TDdibvQSokGGIy
	0FIcFR5SsqUTw2eG/GnsKiX4m1z8+qtnGQrVwlP7KbmjoFRY6+9yRlOm5YMNUja2JaOV6q9fltcKt
	nAZ4k+0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjR-00000009TEV-13g9;
	Wed, 10 Jul 2024 15:59:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] qnx6: Convert qnx6_checkroot() to use a folio
Date: Wed, 10 Jul 2024 16:59:42 +0100
Message-ID: <20240710155946.2257293-5-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a use of kmap and removes a conversion from folio to page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/qnx6/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 4f1735b882b1..6adee850278e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -184,17 +184,17 @@ static const char *qnx6_checkroot(struct super_block *s)
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);
 	struct address_space *mapping = root->i_mapping;
-	struct page *page = read_mapping_page(mapping, 0, NULL);
-	if (IS_ERR(page))
+	struct folio *folio = read_mapping_folio(mapping, 0, NULL);
+
+	if (IS_ERR(folio))
 		return "error reading root directory";
-	kmap(page);
-	dir_entry = page_address(page);
+	dir_entry = kmap_local_folio(folio, 0);
 	for (i = 0; i < 2; i++) {
 		/* maximum 3 bytes - due to match_root limitation */
 		if (strncmp(dir_entry[i].de_fname, match_root[i], 3))
 			error = 1;
 	}
-	qnx6_put_page(page);
+	folio_release_kmap(folio, dir_entry);
 	if (error)
 		return "error reading root directory.";
 	return NULL;
-- 
2.43.0


