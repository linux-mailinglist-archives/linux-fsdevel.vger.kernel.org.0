Return-Path: <linux-fsdevel+bounces-65549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50302C077DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C91C48486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9E3451CD;
	Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTVy/EQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6733507E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325712; cv=none; b=hB21M5hnrrXZU+C03MuUlSideSSfpR3KeJN8mW9nDtwqrKRMKZtAinXqaC3fHaf+mJnTe0+i6KU5dBKv3vyKdo7zdwNx2827b4ZCXQKt4JyN9ebe19ycSP1NeS9MkVImv6DAwGaJ05ksqY2nOkZez/73h3NCDcClt2UMMPmFy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325712; c=relaxed/simple;
	bh=dmI7PR7qP2iFgYX0qecO0nO65Fodf2KV5fKnWYJ4A1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgaRFHYngc0/sFAOKmyXEUK3kJJU2N3XViw3XibSMUNPmfOCZXODE//CvUuSExSg6dAyJnJikFyJ6T7ByLsn19eGOwGAHtzMcpRCZ+VCExndoXN/kiwdL4ynZFnc9oggNv5d3eWsffPrww1BoG9VG9LmTBFyozz+mvoEC/MFww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTVy/EQe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+8hZqJctSF26P38xr9kbPElhutn46n+QzGOEa8OjEo0=; b=JTVy/EQeEPKaB2OWVNfWy1LLO/
	2YvL7yNm0p8x+sSdxFvYAOCbfDfica7QiNPYIoZ2SgBTyrLuf+iG1qrvgwqGnHMqj2SnVw38zaKcG
	xP2B/17suVGU2eoWQ5pomRvDUuQAkSgjI282sqwxeima5a/tRegASeR8LU2GOpL6cq1aNGdYerDuQ
	bcM0h87PeF2mYEgluehwO8axZfr1DxT9iDxGNQehyDRgGL67W1yH19jok96K1I0/tcuH0eweZpRxz
	gLiH6ZLvvXK2I5+NTeq3r6D3smRxiG0lVcAU6/1whfFVtFVJQ2lVl/GY3K4C6hMDkOVLZAM8dT7vj
	B25M1gxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zLP-0eAf;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 05/10] f2fs: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:13 +0100
Message-ID: <20251024170822.1427218-6-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6ad8d3bc6df7..be53e06caf3d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1329,7 +1329,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	}
 
 	folio = page_folio(cc->rpages[last_index]);
-	psize = folio_pos(folio) + folio_size(folio);
+	psize = folio_next_pos(folio);
 
 	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni, false);
 	if (err)
-- 
2.47.2


