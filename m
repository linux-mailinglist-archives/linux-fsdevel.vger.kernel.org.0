Return-Path: <linux-fsdevel+bounces-20575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245D8D53B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E605B1F21C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBBC15B96F;
	Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYv2onoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB38158DD5;
	Thu, 30 May 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100481; cv=none; b=MKZ5ryX3qk72jv825te1/otHrb5pYpY6PSuOAmeJLz2CtFXNhNin5bFVdaSXHL0DvRSmdjLC1qzCRDMRmsPQZB75lKaH0rn5Dy2hkWA75zQ4/gUIrFuU3Fls//SOKty8dzhIFOj6MAsTpekL9LSV4PYfNb0RmZf5fWlkpRoY5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100481; c=relaxed/simple;
	bh=MNGQdCHzW25/+wHhXwXH/NMqYp82RBGV7NnH0nnxDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p84n0VVpj84AWshTWq/s+hBrcNTEZZoI2gIKPAbILZmBISoql8UABnz98pzBi8Fp5YsRmegxIrj5ZdFAM2rAjn9JbI/EigjUp4UqE8nsmedCOFWCvrbS21QLseOVGVq4EtrBex2NLscIf6DClscZk9RMb5R0yvY0lvGX1+9iRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XYv2onoa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sKwEaDMykkWblPGLhfvrNLPmAWo/K3PNSs0OffOfMK8=; b=XYv2onoaar6xJLef6854BH5CWr
	kqBYB0uQUlqkI6Q9nnOVj4zVLHrP96PcvJCzdPDEn8D57SkzesW1n1JlN94PN6CNGwr6+3Pw3NNwh
	03nJjKiFlwxZf/SGM/jelbXhImYTKSsFYOUfUhPmxtLPgq07rZwlArlua0FaZHQK5KEHpEBI1ZsJ0
	xkzr000/ZKjj5IxEwxac67kTwTVOopvX/AOxrssbLR9nY12EVYax02HKrdka23D9qSp4UiRGwZ8Af
	EqMiLT1R7iGzVIIPRMKQO0HlCWlIp/MRiwdYC5WaKckBiY/xZGOlb7Bjp8ZYq7kK3LKxlBAb1A0Ja
	HYYL+lpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8LU-1Jr7;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: [PATCH 11/16] reiserfs: Remove call to folio_set_error()
Date: Thu, 30 May 2024 21:21:03 +0100
Message-ID: <20240530202110.2653630-12-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error flag is never tested for reiserfs folios, so stop setting it.

Cc: reiserfs-devel@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c1daedc50f4c..9b43a81a6488 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2699,7 +2699,6 @@ static int reiserfs_write_folio(struct folio *folio,
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	folio_set_error(folio);
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-- 
2.43.0


