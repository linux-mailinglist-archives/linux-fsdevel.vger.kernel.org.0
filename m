Return-Path: <linux-fsdevel+bounces-65548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5FBC07811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2921D42169F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF873446B5;
	Fri, 24 Oct 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQeI0DLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5532C336;
	Fri, 24 Oct 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325711; cv=none; b=tht5mJsrdwKoGIA9QdeGnn0SBZJv3P4zkUkjDWe1tzcSNrUSsvLztLEPvp3i6LS4hL7ukb3CaOMO/foF4BWWMSVoTiA0JfJiXn+L93qfncdl061TXr0oWIPyHfZnlhiF/F3U4E2JsUV26sd2Bv0yUgbBqdhBKoguX776r5zmLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325711; c=relaxed/simple;
	bh=4aiaAafKEVRS7oHBnZTynjzAfar+CKWpPEkMbVdkenM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDBlpmitrSCD/YHivO/9GmCxkInQ6ZGdsS5oExQGSaCCRLhFIi26YfLFvATTUfpKJODmpn6bL6OXlBFa1puF6ZIOomGAkicmSwA8uo9dV+HqUyqgzmt57Reofl/19ZSOhdhzOX1uNLXj+N2o1JU/7yxU4ewqDyRGLFKq5RhngMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQeI0DLc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c9w3k6oN10/YYLz0pCBh1czWnhC78y/fwRY6lGvnJe4=; b=qQeI0DLcEiyMMgwCG3Jy+ikP+7
	nTGTTO63bk+a1gmbjuDA3z87bpG9GKGvKlbewWH03CzY74ffBiT5XD/XjWUXRc7ZncefEGUoBY9Qs
	aC9agdq7OQDeV5mr4Z3fs2fgLMzbzhnFGENVZNCSV2R4lH0+Dft2oT3wlH/BluEal9Xy28RspBMgb
	XPbKmo2XUTj5jtkx0+z1G7+co3X0m52mTmDytd7+oJ3fMMMktsKTXYXacMg2jqaTwDwiUqaHzfZUe
	eMRR/hEUFlslwpZUzD6G89Q2lEvnmk4K2OAMdQ+ktuhAI0BzVAtk4GkKy+pqQCdHHzlmq7JGdUQON
	5//QeIWg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH6-00000005zLI-2OEt;
	Fri, 24 Oct 2025 17:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 04/10] ext4: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:12 +0100
Message-ID: <20251024170822.1427218-5-willy@infradead.org>
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
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..1b22e9516db4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1319,8 +1319,8 @@ static int ext4_write_begin(const struct kiocb *iocb,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	if (pos + len > folio_pos(folio) + folio_size(folio))
-		len = folio_pos(folio) + folio_size(folio) - pos;
+	if (len > folio_next_pos(folio) - pos)
+		len = folio_next_pos(folio) - pos;
 
 	from = offset_in_folio(folio, pos);
 	to = from + len;
@@ -2704,7 +2704,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 
 			if (mpd->map.m_len == 0)
 				mpd->start_pos = folio_pos(folio);
-			mpd->next_pos = folio_pos(folio) + folio_size(folio);
+			mpd->next_pos = folio_next_pos(folio);
 			/*
 			 * Writeout when we cannot modify metadata is simple.
 			 * Just submit the page. For data=journal mode we
@@ -3146,8 +3146,8 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	if (pos + len > folio_pos(folio) + folio_size(folio))
-		len = folio_pos(folio) + folio_size(folio) - pos;
+	if (len > folio_next_pos(folio) - pos)
+		len = folio_next_pos(folio) - pos;
 
 	ret = ext4_block_write_begin(NULL, folio, pos, len,
 				     ext4_da_get_block_prep);
-- 
2.47.2


