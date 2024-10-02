Return-Path: <linux-fsdevel+bounces-30648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C105B98CBDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738A61F25A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE174413;
	Wed,  2 Oct 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mciO33gZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72855C0A;
	Wed,  2 Oct 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841686; cv=none; b=RhyS/WXTZPFblYH4XVlobaoawUqXWZ71zC8LhsfrgUqmmWcebqk3TDVKJa7Vm7DgVwaDGxaXIiW8SHwhGWvr8U2bOyHJK288Gq68beQE4aM+DpgwHJ3elGqP6888fU9wAfgZohRDhezeJ8a5drW6glSrjcUKduUuCfujxXhaHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841686; c=relaxed/simple;
	bh=+IvZr+9MNld7cvhsUD/d19bLAd63YphMOfrOEDroHs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCzuZSndQpy3Ex3lXTYm5rFRxkLffnCasS78CKgu1OiThA4DuDaTwBcHv9g++HJ9zP4jfT1obYhNmOZ5JrbYQeRrk/BrsadQkHFV4UT/cSqERHrjs7Rq0AkYQMiQbn+/i3KT0WG1eza+XPDNwS8gN7GX91+RYnvE3gP1Fg8X+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mciO33gZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IS+o70XI9H6xAbtwLOTIZ3eCVSzAnaR0y6//eiVhID0=; b=mciO33gZCfuz25EaGN6Yu3qDbL
	/m9SVAj5Ircnf11Vk607Z4G9g5Js9S8IjTN2R7t8FZgM/oR+jMao/T7iU2DyEvno2TcH60m6VyJzU
	0bkX9v75/BiT15C/N3HU8JmwDW9u9VoZj8cwfbPCFr/zEReWz7/8sIweOFzi6K+XuT4cnNlhNvpdd
	3dMtYf9wyJNc5D/YmZwM9h0ZduNNRPpB8V5rbKVH0pSAxO8iLf8sYNpZklbGLALAYNZqBnk/NmBEe
	zkqpZHVfwhfFgtc2+dr0xsg3/YHdczfTERn/MuHIkZHFNftHqgxFN53cpGhUt1rbJ018C6hgqBrHi
	Znk/b9xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY5-00000004I8T-2ivo;
	Wed, 02 Oct 2024 04:01:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] fs: Move clearing of mappedtodisk to buffer.c
Date: Wed,  2 Oct 2024 05:01:03 +0100
Message-ID: <20241002040111.1023018-2-willy@infradead.org>
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

The mappedtodisk flag is only meaningful for buffer head based
filesystems.  It should not be cleared for other filesystems.  This allows
us to reuse the mappedtodisk flag to have other meanings in filesystems
that do not use buffer heads.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c   | 1 +
 mm/truncate.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..35f9af799e0a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1649,6 +1649,7 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	if (length == folio_size(folio))
 		filemap_release_folio(folio, 0);
 out:
+	folio_clear_mappedtodisk(folio);
 	return;
 }
 EXPORT_SYMBOL(block_invalidate_folio);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..870af79fb446 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -166,7 +166,6 @@ static void truncate_cleanup_folio(struct folio *folio)
 	 * Hence dirty accounting check is placed after invalidation.
 	 */
 	folio_cancel_dirty(folio);
-	folio_clear_mappedtodisk(folio);
 }
 
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
-- 
2.43.0


