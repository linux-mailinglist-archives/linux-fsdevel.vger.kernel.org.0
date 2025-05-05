Return-Path: <linux-fsdevel+bounces-48152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C693AAB114
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 05:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE59F7A2FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201E32DA99;
	Tue,  6 May 2025 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvIKVFST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBC37642C;
	Mon,  5 May 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485324; cv=none; b=pqpUCP3+4kfCjBryYqUQb3YU6IY317JCUScjoy+YyQe4WmvoM4WGlVd8GFPi/Q4G3+BHzhZCbSlh3xhZjeopN3yJle1NtXNF3AfhNE6tmN5ymqTLakEbmWfqoiVO98s9g/z0U+34+kUsaYNx+FU+g8kLqHl0ptBZJ+pAL2Cn7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485324; c=relaxed/simple;
	bh=LZ+fiuu8BZam2Vg/JHkRs5Bbuh7skjVBcr05ofEBWew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4EmJSrBkVTEDDDMSQj3ejs82iLqhv4dEkg+UT/F/EqKyjqKDBtbp7qKqWOrr4e6X3Ee12NHk0/3Jbr2Zc7AmeW5bVy5EAK+Bzym+EGCO7AmQRERmq6J30FlcJkerUQwu5D2SaEcmMA/964Va1dK0QQ8D+6Obn1x2SGb2oyiFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvIKVFST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0068C4CEF2;
	Mon,  5 May 2025 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485324;
	bh=LZ+fiuu8BZam2Vg/JHkRs5Bbuh7skjVBcr05ofEBWew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvIKVFST9l03vZ1+8uw0dNEQ3wcjSsg85wWzpIVt7W/9mSLWU8sfBHO54VLvj5sO5
	 JrWpOfl+xg3yfZHYc5t+bC18gaDvTpNphBnBq7XQc++IxiRqqfwX8gmHSVP1PA0ttL
	 QMthO/JhXrP4CDf9At6yIULK32LeN0DNayqDse0j/Vh1zdtm9ZeMra1MTbRK12VttH
	 CkT5zg9Ay71vQjMTMODneCzmxuznOo3kG7m63mobH49t2sxPpZgtFJr5ltCVSpL9Gs
	 OAT0vkBSUSGP+h8cB+xPKBJutn4ZaYklEGu6jzsHl4Jqp6TnBw1q96z/w3RtJ+arOu
	 RJwYF/EPBvIWw==
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
Subject: [PATCH AUTOSEL 6.12 268/486] fs/mpage: avoid negative shift for large blocksize
Date: Mon,  5 May 2025 18:35:44 -0400
Message-Id: <20250505223922.2682012-268-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


