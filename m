Return-Path: <linux-fsdevel+bounces-41943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13A1A39330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EE7165936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4341BEF8C;
	Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Em2r42ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B831ADFEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=YXc6NO8yHGAcp/TFTukwyqvJ3m5GypE5Ek7CskSTVfpMDXy39GhRGOGSWApMLp7dYQxNVy7DoZzKiumMiKPIqQ/8J+pF5GmRidzI/uCa639XeVjg8siyfdV5I+zrtcqeUpBAHHA5iAS8D5Gqk1TSWUNBg2noD/BRdj5Cj9Ej1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=EhrlG4PjKsij9R3+4bTjs2lH+diBRS7AXm5uas6BzeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAo2BCYp2PVrKR3NHiasWlB+CbQ5OawrJsnGdtkYpYi4Zz1uKtehdNSWzCQ86IcynQR8wOWXlgkzzKRoamB8JTx6MLiBDbdB3kTGlm97TdAwfoOcV0FTnmT4VNhEoHNNiUgWSNypecOs+K+ot7AuC87j7MdS6j82mPQszdssmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Em2r42ko; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8eCp/aYOgC7traLzeBHZGcZTwEdZmKw2uvFSR9Kleuc=; b=Em2r42koRd2AWlroXM3Gw+K6mU
	e9N5HW1/MIO6enKgzVwxbhWHB6LsdLDi47g3G+oeRXF/2Jx3vWVKz9vxT/bhWI4KPlXBp/q98LB3N
	+pf/DUXvD1dZx5bpp+Z73rIkpnoyIIQOjVPEzJuW9JntA8Qiu2i6qLGI05mODkE+yfUo5A0hNAQm7
	724EzKq0O0ex9tZCLxNvlIwI0NlwQeGjEtC+4FAKe6Z4WGmRklGQxuJRdFWv3XtaTkXcGnuN6w8Xp
	SfgRLQv3bDl/RCNZDfm2c0ygTWVNProN5hnjtX4mY1lBFrLjS5QgB4elUgqcdkDwEJmAzoBodEe8k
	U/ayr+WA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002Tr0-1wIX;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/27] mm: Remove wait_for_stable_page()
Date: Tue, 18 Feb 2025 05:51:36 +0000
Message-ID: <20250218055203.591403-3-willy@infradead.org>
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

The last caller has been converted to call folio_wait_stable(), so
we can remove this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..a19d8e334194 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1256,7 +1256,6 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
-void wait_for_stable_page(struct page *page);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 1d1832e2a599..5766d135af1e 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -28,12 +28,6 @@ void wait_on_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
 
-void wait_for_stable_page(struct page *page)
-{
-	return folio_wait_stable(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));
-- 
2.47.2


