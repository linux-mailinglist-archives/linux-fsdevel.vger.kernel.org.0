Return-Path: <linux-fsdevel+bounces-42993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C0A4CA9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CA169D0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE08217F40;
	Mon,  3 Mar 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MN/zpEt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B82153C4
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024702; cv=none; b=lixyilr+TcJ97jJtVPBSJT2yIjbqhxRGoGbXFtnSAXrVK02SNj+brQO1ib7rNd8B81n8v/pK3lAEqBjbfN6Q+WEopUKFX2xnkblzOjvdo/fb7RJfFsuzGd1RLdtaGM/UI4jG5m3RR7Ywm0E1nmIO8tWlB6go2M2zi/IRxyacfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024702; c=relaxed/simple;
	bh=NoqP4mZ/ulC73L6aQP6VwJZDLqV+gHGVcMEKjG+Z7RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIauRVp2GZPq62AW132DmKZzRx/zvYc/AfEe/R8Zf+TPbB5zmPB43lfwXCKps5SjI+flTbuxV+dlUqFDWM7I168oXskGhyyhsiIZMrnYM18JV4HiM4/sjBgJSPQ4AvSoLuaIg9Hw23hgluQP5leDO4l47S1nQj2ZZz1gTstU1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MN/zpEt8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oH16NlP8xxrt4wivtUXbkuoeB6TY0U2c9UggzJlO6Zg=; b=MN/zpEt80N0N2X5802zEZW1Gzc
	PSjSmw+iD24oea5D/lUoixIMhX9FS9A25h0R6T5x84JqkY/qyjiI7fKCc8jdDoZz8bp6HcP7UyAMk
	XIE/yCy4eXRICMs96FZZxnzRGWxRlG/3J+GX9VoIfOcl48LAi9XuqVMNYec07cZ4XjXCS5QgMdMC9
	feuDrqtpQhtHf/tFw+ZWMS36RARhb1g/ITtw3M+oRWf+K3F5uGXg0K5vWl8SR01bfEwp0Puq6zK38
	uRqmXA0DYDuAzSqwnaS5oFXFiHk2OlgMhXk9bRCPyQ06yGYq5UxCUlknVropgc/MF7VigJ3Mg9Txm
	JLpoKnmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9zg-0000000DlCl-0Xql;
	Mon, 03 Mar 2025 17:54:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] iov_iter: Convert iter_xarray_populate_pages() to use folios
Date: Mon,  3 Mar 2025 17:53:11 +0000
Message-ID: <20250303175317.3277891-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303175317.3277891-1-willy@infradead.org>
References: <20250303175317.3277891-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ITER_XARRAY is exclusively used with xarrays that contain folios,
not pages, so extract folio pointers from it, not page pointers.
Removes a hidden call to compound_head() and a use of find_subpage().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/iov_iter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..92642f517999 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1059,22 +1059,22 @@ static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa
 					  pgoff_t index, unsigned int nr_pages)
 {
 	XA_STATE(xas, xa, index);
-	struct page *page;
+	struct folio *folio;
 	unsigned int ret = 0;
 
 	rcu_read_lock();
-	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		if (xas_retry(&xas, page))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
 
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas))) {
+		/* Has the folio moved or been split? */
+		if (unlikely(folio != xas_reload(&xas))) {
 			xas_reset(&xas);
 			continue;
 		}
 
-		pages[ret] = find_subpage(page, xas.xa_index);
-		get_page(pages[ret]);
+		pages[ret] = folio_file_page(folio, xas.xa_index);
+		folio_get(folio);
 		if (++ret == nr_pages)
 			break;
 	}
-- 
2.47.2


