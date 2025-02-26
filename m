Return-Path: <linux-fsdevel+bounces-42701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F490A46533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B6F17D324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039533EC;
	Wed, 26 Feb 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SmSBQJef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334722331C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584179; cv=none; b=EFR2NaeC2mzlmQSnzD8f+VSPjet06ReA9ld/gFJlo22tz02QHyHXZ0PnAwrkIhVYA4tY984g3QVzTWA5k8XwOJHFziAbRKF9RzM8rh/UHqMGnTxe5ZMSJDHgud/XBK1jnvFGfedielxxXJuXya7EsbQUYMvbt/JmEtvPeeoSid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584179; c=relaxed/simple;
	bh=cEiSe6LUVNBD9gkifEYU6njx5O5w/m8nu34Su41wV64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjsvnnlDSx4eiUmNmbjBnOPMSGyMM/aTLZ8nQZz167ZrNaaY2h3KgNdwO/NAAAVuJQiK9W4dH3kegG3+ail6YD+xm9hXJ9dtWRjtuIR7N0GAbpXGFz9sh85KJC2z3ZazJPoK3u/YYUF2oBSgxQThkalQTLPOh6IG1eyfG/MFIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SmSBQJef; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=R9ohynNflqiL+Hy+OPCOUojcnVbfULl1TMrUnV9t3iA=; b=SmSBQJefG/oiPWBllQfQn9BZ9T
	Tz0HZIra0vmrCedn8z5pN9MiwBSJF/FAsTSyDjL+tPt58ZOwCYBUfdFcd08ZPsu3lsCeO5LFBgIPh
	u9s+j9FGu5EViFK+YL2DyanKmBGQNugBmZwD1orb78tx0xE8SQS6XKVwIt477PU1IBM6TlBZVp1yw
	U/aRNPVNPwSm7/hp6qsrvVetikTqqNXSYYhb5rbbjA70WZ+N76qsdMfuPjDeJc+2zviPqBM7ab0o3
	tFGnXa2e32P38SbeMrn9rDo1ppJqWntthAmgcTUoCq8pUlDFrQT4YwgLulCC0qhWApGfVQsuQZIzc
	vbv3LU8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJSJ-0000000Fq1a-2Oyy;
	Wed, 26 Feb 2025 15:36:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: Assert the folio is locked in folio_start_writeback()
Date: Wed, 26 Feb 2025 15:36:12 +0000
Message-ID: <20250226153614.3774896-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The folio must be locked when we start writeback in order to
prevent writeback from being started twice on the same folio.
I don't expect this to catch any problems, but it should be
good documentation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb55ece39c56..8b325aa525eb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3109,6 +3109,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	int access_ret;
 
 	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
-- 
2.47.2


