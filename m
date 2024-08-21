Return-Path: <linux-fsdevel+bounces-26541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A795A557
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2961C21E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7816FF37;
	Wed, 21 Aug 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrh9nS3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDD16E895
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268899; cv=none; b=po5nc+DFCLUoIhAzB8R0SzsCYCSkSqQWYTN9jM4tpy+mzOVLGgfv8/ZPfy5N5SdbtXpzVcsuPi8Ez1U9M0bIaqHy6V8FQcrfAmjvliYh86BOLRZ6hnNhB0JeoXDxrrn1Tq8wVS6X9yn5nhEuiQbeuteGql4GwpXXkkhT4k9uwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268899; c=relaxed/simple;
	bh=JCZlkY1ND/nCNh9+GRbF0Vkv4+eQhoD2emRZ2OYhmP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxJCdfakyCm91DnhBC/SRzfram6nj79xNShespLCcL2CPNT1xLNL6HeSvkbiXVmGaoSjpmOZQbF+1GOpSptiS9M9yAqqnCqR4GeL+bxWdqANxWMIVWhNAUJpkxujvUd5vdvNMvyP3+5hneZiZ+NzqkETuhokkH7sCpo5l3QJO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qrh9nS3i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aiK4+/NIkBbmyUkC/1o2gVxkfVM2L/hjCN9VBJXNw24=; b=qrh9nS3isTExJ/8+GAk0h/kJCs
	Vqe9DtD2xbzVF70UNONVui+RA5GNNtm+jyg8NTsI0SsFpM7tNBdvuHgtScHAXger2DZALm4bkEttn
	4vFKIkog43xURN/KBM/c/mR9tpNYRNDERwqLKAIr9NsFoJM5E8J8X0+6Bc9eifg8/5pnkyyGbe0d9
	XcDg3i2NfcvWNPdxJlL6WKvnE2+A98oAjf7IOTyRyu2AkmRUH3wtWMqV0MUjaUseX4ZlDN7e0/aZL
	oCBvDaPRLHLC65KGD98rSqdhxCglxAe/JFPNgNhjt4N2h+fH5eExDVROgq8Yecj53Ffv1MVZBrlWU
	uJjdGYRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6U-00000009cqf-4B2v;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 03/10] mm: Remove PageReadahead
Date: Wed, 21 Aug 2024 20:34:36 +0100
Message-ID: <20240821193445.2294269-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is now only used on folios, so we can remove all the page
accessors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5558d35cdcc3..2c2e6106682c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -553,8 +553,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, readahead, PF_NO_COMPOUND)
+FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
 #ifdef CONFIG_HIGHMEM
 /*
-- 
2.43.0


