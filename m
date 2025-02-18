Return-Path: <linux-fsdevel+bounces-41933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8428A3930C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8AC165275
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EBF1B4246;
	Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JNgieV2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484681B041F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857928; cv=none; b=gE3nQtSh4b7Gm3dsBSRoc7EZpCGqr/ZzbTsKtdUCN/Nph2g3JPHSWCaqWtmGssu8nHT4Lvynt5hHu8wmTc6mnYwJFEorlWmMNHeHUh6H8067R9/QHOOYO2LL+zV7X9SOH+MW16NBgGimoe2AsPcycIbR3r/BFN0+KO1zHj1uGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857928; c=relaxed/simple;
	bh=RkPiz/4RpQU+lX6zc39/PYaacFfDTTs7KMTq/v3knuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7C4hAh6H+q99jRFyxhxvyvxNZSdUYojCNa2x+lGvncECOnW7mz4RqJGzfyJCV/uAJqgVjDty9EMwskq/c5WElK/wUnEhCVCw3gyLf7qFly1M81ftrAd0uwOEPEHdsI5hOId8hdO9+hGIe3IF3UCWh5/2SNBVlxfoojIm3mOohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JNgieV2K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OilBiweMkMqZCoG/raqSrzctqggQhymMRjnJ0jCfGlo=; b=JNgieV2Kpn2C52ubSYAes7KG/k
	OtMoaHRiQ6X4T6Dm6d+g431niqQ5VwOvEOq15tuThPoAQS4ZeeF1hTtedLo3LBzQybPs4tHdEkqhY
	v5xGGrTRlvbrjjvHX+BOeTpYV9ktQa2iqb6y+xI9ObsdMcR/vTYjdLsxj0QhNi/gdHR23sEzSVUIM
	4T/5ZUUCxJg/lqiRe7hOvpVFxugRTx/mn8s/LH6X2ZY7oLGI3enAubDtFHr1zaPBkMbUQ3Vq1LBoJ
	eqZOQ8KdfC8shsJcxozsCGaN2hd/UQn+C316abVqXU6QtxsXm/4FX02vJYwowymA2HDlXmadxImhv
	fcecopyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002TrB-2R3b;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/27] f2fs: Add f2fs_folio_put()
Date: Tue, 18 Feb 2025 05:51:37 +0000
Message-ID: <20250218055203.591403-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs_put_page() to f2fs_folio_put() and add a wrapper.
Replaces three calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b05653f196dd..5e01a08afbd7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2806,16 +2806,21 @@ static inline struct page *f2fs_pagecache_get_page(
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
 
-static inline void f2fs_put_page(struct page *page, int unlock)
+static inline void f2fs_folio_put(struct folio *folio, bool unlock)
 {
-	if (!page)
+	if (!folio)
 		return;
 
 	if (unlock) {
-		f2fs_bug_on(F2FS_P_SB(page), !PageLocked(page));
-		unlock_page(page);
+		f2fs_bug_on(F2FS_F_SB(folio), !folio_test_locked(folio));
+		folio_unlock(folio);
 	}
-	put_page(page);
+	folio_put(folio);
+}
+
+static inline void f2fs_put_page(struct page *page, int unlock)
+{
+	f2fs_folio_put(page_folio(page), unlock);
 }
 
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
-- 
2.47.2


