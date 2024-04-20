Return-Path: <linux-fsdevel+bounces-17334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF38AB8EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17578281C58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B7179CC;
	Sat, 20 Apr 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XX2gdXxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63379DE
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581455; cv=none; b=PyESao1XKaGmdvhtjJOJT+YGeyURO2gVQ8oyNc/a0PUqmt3tpgOMhT88zAHMqOiauEwcaigUbtgtwqwnipXGm6Usekx0AGqoNu89x2F5btqlHIduO3Yt6x1hN3RYN48SnhPqtMiWF0nq9Op5P4BvIDvVu1U6sqkn83EuUQZ2WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581455; c=relaxed/simple;
	bh=D0mLITYc67VFeEYU+H17Ni9bXDYOpEy3i7fXOO7W3Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOMZtxvIMcsGkLPNav8qjKy+pwK09kdd++jUI0gFOmYcn/IwJh/RE0+Ue9jwoiYpQo46n25E0PMJW2FAkQwz5b8oCzXLQ32HltV17/FWUqskr/vo5W8lqNRkZQfG2pnUYjY3bG+GYl8A4JCpPbcC+IbNRLuWMIbv149TjJIofbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XX2gdXxv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JCNUChKJkI8QTCzUepEtX3M4aIY9D4jEdCq5vjHw//M=; b=XX2gdXxv949Dj8HbAeWwj1gmw6
	LXwnU+FGo09l41O+udHjeBORw+yYshrImgR29EgZDyzdhpGEku5FwXgnAJyOoIdZDtPew0R0f7CKH
	Spa2Yfaxek2DSshhMXFmzmKlao+AWDQBz7QNDHO1pJxshDdiZsliGigad+BQAzsEKw6e/t9SK7wH1
	X+323blFh/MY6dEJt9CB6SykG6FsyXEaw+xx20RRXeRQnLWrrFgXbeZXLHAtl415/I3aT9RenBevc
	8EEeyNdgrunZybSFszuS95uwBQSqD3GPIwm87OY80V379q9iiJoh0diaQe9AIuAwmS5qMsK/sATqo
	oW76Tgkg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oV-000000095fE-1wU7;
	Sat, 20 Apr 2024 02:50:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/30] isofs: Remove calls to set/clear the error flag
Date: Sat, 20 Apr 2024 03:50:08 +0100
Message-ID: <20240420025029.2166544-14-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on isofs folios, so stop setting and
clearing it.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/isofs/compress.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index c4da3f634b92..34d5baa5d88a 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -346,8 +346,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	for (i = 0; i < pcount; i++, index++) {
 		if (i != full_page)
 			pages[i] = grab_cache_page_nowait(mapping, index);
-		if (pages[i])
-			ClearPageError(pages[i]);
 	}
 
 	err = zisofs_fill_pages(inode, full_page, pcount, pages);
@@ -356,8 +354,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	for (i = 0; i < pcount; i++) {
 		if (pages[i]) {
 			flush_dcache_page(pages[i]);
-			if (i == full_page && err)
-				SetPageError(pages[i]);
 			unlock_page(pages[i]);
 			if (i != full_page)
 				put_page(pages[i]);
-- 
2.43.0


