Return-Path: <linux-fsdevel+bounces-48149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4BAAAEEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 05:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E516FB9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105692F416F;
	Mon,  5 May 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXXX7bKq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106B2DEB90;
	Mon,  5 May 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486130; cv=none; b=l1dYTwmu2Jq8CHSZcdUK5cmng6ZddhTz8a+XjseZTTX7rysS8a/lT0Mu0iZZ4fj1zmPS6MHvCRsCmPAuPaCUnNW5uXsUdhMc6k89rtBFvuCh7bzvqVNFIx4BUJ9/C6PefP3jgR7ipeyDY+sTCRjJwtK1+lqonblK/mN6x6RHlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486130; c=relaxed/simple;
	bh=0We8GRXcI7HnshvKBE6iRQPL9Sf7PA5irmmYeuOgsuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY4x8H/Fwy6Hyo+CG0NUDIY7SwAnSoPn3HNLtBvPtfTkmaeatzH0YI4zK7VaVzEJiwvi9Xzwakhzk7/371dZI+u/sJPnDz5GXOzO9jYQu34DeuUaFfGXvaBMb0LFfGTh1/AIagZyQJbQVcjROXB4yCIlPjKJP4cmwicFuOWn4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXXX7bKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E8C4CEE4;
	Mon,  5 May 2025 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486128;
	bh=0We8GRXcI7HnshvKBE6iRQPL9Sf7PA5irmmYeuOgsuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXXX7bKqwiuaCFTL2LLtOYvXkyWqWlHAWVrCsop3gyvz3V6Orbt6sOnLY2VGdUT9g
	 ovbw+6Nsz6Aikc9yMnC3nley7YB7+VAP0ioBwEc4DStY0jZR+1KtqLCmahMcYzNQlr
	 eTWMvG4TktndVJ+OUGeVmU2Qk+p+ov26y2R+Zn2+Hf2h6fZjU8+uDxjX+QVWxyDF4O
	 8vu9tU0avQfMB6TasbNLfR56hKiT5ak0yYbDe5Tvy5d9M9GF5LDgKHMnRDcrxfBLsz
	 AMg0baE/fa3gFwPj5CLXXIxrCjvfwktcacgzitD6FEo3Py9A3US4Urw4USXFuZxNeu
	 jgyE3DpCfvRzw==
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
Subject: [PATCH AUTOSEL 6.6 167/294] fs/mpage: avoid negative shift for large blocksize
Date: Mon,  5 May 2025 18:54:27 -0400
Message-Id: <20250505225634.2688578-167-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 242e213ee0644..20d95847666b6 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -189,7 +189,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -543,7 +543,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
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


