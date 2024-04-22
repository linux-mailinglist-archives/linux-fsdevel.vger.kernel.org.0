Return-Path: <linux-fsdevel+bounces-17429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C488AD4E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD251F212E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0021553B3;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RudlPpTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AE155337;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=STXJJPG3U/ar5kkNQG04kmHsvQ5jnTVAaWF8uygndbt12Jy/B0te/sR+C8cC01BvJsnixXyCHpLwZUUEDsKrseNdAuz51n8AA5mLHcSLRD+NNv+lFNmDvUf0Q16mVTlXPZJPOYHEcpGbSX7fkt3DhBWISYfnol2cj1EuMknTons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=tERkkz+OidP4hJG26tVfRmFrV25vThKw4AzSVjA4s3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7tklOoZXW/Eap75lynnUyR+MQXVqrT9O74dTW+tSgqTy3xj5Diyc1g9dNVUTyCE0ahtjsyce57iAPzDUal9RyieoMSYLYcPmF0AuNYNyxpYim80t8YFTEpNwCFgkbhtbxpak0srt0FZ+2a3OYRR3UGZnJGPGl3ECR4NZqAUKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RudlPpTN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Xhs9YsoqkfzNBPKy6dIZioGoUpWLhADU0Aa2P/wM/Pc=; b=RudlPpTNXlFaF5s/xfcZw6eFrV
	Ei/qgOADD0PsDE9CkTuPyqf2x2W3cSuqyE6H/LhrAoqqoU29pOJj4YLgA3e5FgkdVcu7XDf+tmctQ
	uTZo5KUaZrLJxuxccR38c6xznYizgLFAdHkiCwP5W5SneAXHmhxYQVIoR+fLnrZAVIRBeNkAgSp/W
	46MqyBio9ikeyHCDaKjay/BQ2Sk+4zztp4aj7HikaaQsvDZOykkZYxFv7On8NbJbPpeDq5Hu/G8qc
	a4IkUxG+mxP4qu6jaetXPnUZc3+BjN3VG+P8DUKaebfs4SP1UOQsE2W4J3779aT1h4289yV4eTH0U
	ExeU/64A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOj-3S2V;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/11] ntfs3: Remove calls to set/clear the error flag
Date: Mon, 22 Apr 2024 20:31:58 +0100
Message-ID: <20240422193203.3534108-9-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on ntfs3 folios, so stop setting and
clearing it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/frecord.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 0008670939a4..04a7509c749a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2143,9 +2143,6 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame);
 
 out1:
-	if (err)
-		SetPageError(page);
-
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
 		if (i == idx || !pg)
@@ -2718,7 +2715,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
 		kunmap(pg);
-		ClearPageError(pg);
 		SetPageUptodate(pg);
 	}
 
-- 
2.43.0


