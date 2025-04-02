Return-Path: <linux-fsdevel+bounces-45564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C324AA7971F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D5C3A72D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E61F4168;
	Wed,  2 Apr 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="raE6Hpsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCE19ABB6
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627980; cv=none; b=iNV4xIsfigl0V4P3bZ84DhLB3WKuhD6aUMoad4MX/OmY6f6D7EhhUAG597I5AMob/zWaIl5k1jNv8oJlDUS2fJVLzbbIaorGdtL6ErAJ5k6vkZGRFaNCt0yKmPbRSR3ZCbNxugFH/IdGraKoCdEwqoeFXPJKC4T3msvuuDhCCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627980; c=relaxed/simple;
	bh=ghC5CeXHos5lEeSNJ1c2Ou1sXLAxzYxl/Bw2ImzIzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMw3zjHMuMqyEzE4WRnkB42K7M5610Q0777Zjuc0X/AnpvLXDtX7HFmh/MOvxrbNBqFIxoNlqoTmypZxPJSesQcazt4iB536ltYdyk91hhYDvDAXKCfh0wh8CMpnATO8OuWhsk/OETQjPRqff+oAWdCNKBdkMsB04sypXDf5dus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=raE6Hpsr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pe0Pjjm6xDZZPKUtc3KMY1jXMbHe2FmknyFtlN8EIWI=; b=raE6HpsrueXDb9uqvPB13rISbE
	KJAnPg1e81yzYuuxSGT+g7ro58lEysOfYQPl+VoCHzDhvYglzXvH/MlolRyXNbvbwcxMwJgsKbALl
	Wb/hP2jxBEYndgJDgEwGKcs4BtDIwYh0zyO/UbcpFRf/W0crLPKqh+KZ6W+eam+JNTUFQ821m/vZQ
	9ex28ont48t2jNgurc4aA59N4EM8da5J6CeC3YAY5LrEgi3z3f+spwedf+WzDBOe6BduPhcW6cm8E
	5NaRUc8dEg9F+aRAKBKPDVMl/y/L91BP3TuONymRuaIwr1p80Jr3k4QmDF5ttVDSuxXVQgY8QAaSH
	kC/JJw7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hq-0000000AFqQ-410d;
	Wed, 02 Apr 2025 21:06:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] iov_iter: Convert iter_xarray_populate_pages() to use folios
Date: Wed,  2 Apr 2025 22:06:05 +0100
Message-ID: <20250402210612.2444135-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402210612.2444135-1-willy@infradead.org>
References: <20250402210612.2444135-1-willy@infradead.org>
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
index 8c7fdb7d8c8f..7c50691fc5bb 100644
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


