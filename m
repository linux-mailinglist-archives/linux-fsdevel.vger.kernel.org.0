Return-Path: <linux-fsdevel+bounces-48142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42169AAA4DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 01:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CACD7ADF42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95D30721C;
	Mon,  5 May 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfg4B70f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A2307206;
	Mon,  5 May 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484085; cv=none; b=JbElGbkrE+t0PGSRV4fyCceFSqRzxskyzCbUGJwgMQ74T3LYwnzltWLSlo4UYxHrU2LskK+uafGcpninOtBJNbzXqXIfEZ5OqIRbAVr+ja8C9FGC4/XajH3RaYlwWRTxrrSXr/QJD60/mXyLhf9zMZfNL2eK4HKfL/k9XmBopa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484085; c=relaxed/simple;
	bh=LZ+fiuu8BZam2Vg/JHkRs5Bbuh7skjVBcr05ofEBWew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYCnH5r0iFT6t7BHkqqg5MBw7po1nlGdJqPl31QMyhupT9w0TUQOnJQUS7WwjW/m96lMlqY/d8Skxu9zGqenrCmCo5X+gccJu/L+LLDNRkxy2DFpnZmfm5wEea4mvn3KNfyz7WNjguKlbs4ZailTEsWBg058x0b5ZjubTKKvj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfg4B70f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A46C4CEE4;
	Mon,  5 May 2025 22:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484085;
	bh=LZ+fiuu8BZam2Vg/JHkRs5Bbuh7skjVBcr05ofEBWew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mfg4B70fqyYx01kcOav+I0cXu1a10UuK0dSj2TxhzhJ1tDgZKrZbElOtIUZREf/yJ
	 yuolueRw/RVixVp8dj52eC91o84C5r7HajMPtPWg3A9S2qEmqm7PW8wnoEbAjRoFZP
	 fcr4XxJI9E2ymMCa+9QMCjbSwlkb4YbfwstYj060WXN1p61Yq3Do3YBQMxco6AngOk
	 dbG1AtS7p7EEgbk9jyTkzH+N0N11KxyLa1pCP1KFnGNBCfRZW69NZ/2tu0SW6/5lQL
	 Aqt+/+aGgBt1se0Qqwbx49p6R3slbhOhZJh3ZmUVaL4c5zEPPKC9wdc44LuHmcm0x3
	 5vspgCvWvZu4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 342/642] fs/mpage: avoid negative shift for large blocksize
Date: Mon,  5 May 2025 18:09:18 -0400
Message-Id: <20250505221419.2672473-342-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 86c60efd7c0ede43bd677f2eee1d84200528df1e ]

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so calculate the sector number from the byte offset instead. This is
required to enable large folios with buffer-heads.

Reviewed-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Link: https://lore.kernel.org/r/20250221223823.1680616-4-mcgrof@kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 82aecf3727437..a3c82206977f6 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -527,7 +527,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.39.5


