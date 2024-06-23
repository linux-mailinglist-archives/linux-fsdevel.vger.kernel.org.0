Return-Path: <linux-fsdevel+bounces-22208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98764913B64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D511B22A4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2019AD88;
	Sun, 23 Jun 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxaaOFCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86B19A29E;
	Sun, 23 Jun 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150333; cv=none; b=Si1JiutcVKGkIG+p1ijGje1OUPqn+1wSyF+yJtoizx+wbR9eqxcVVhpRY7C1m3PnFkJRSmC2BZnkDQJ+aWevG2cFoz55PYKrY3or7XFepYFjAjEDNpR9NZac18olKoD2DQ+txhQXcEzNhYTQkc2cxHZ1c0TzbeKxfqgevTr/KTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150333; c=relaxed/simple;
	bh=F67RnmI+jkofkly71Rolh+kSsp4d9JMNis+yTNfDAuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PET2xpmElGJzUIz/lSIscxhJb2E+ivdrbTFQhkvEsw00MJDYUoLUV68L/dyR06nz6sFPG3VhYBRDb5mNo0GQP3VwdAsMljlWHHG5hkj0fb8ZVnlt4YJYlzaycxEu2etUOVn7Eb+PhGk/ptxSIXM87HMv0aBOEvwyTrTrRNIz0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxaaOFCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3267FC32781;
	Sun, 23 Jun 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150332;
	bh=F67RnmI+jkofkly71Rolh+kSsp4d9JMNis+yTNfDAuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxaaOFCkO8nyX41ESIgjkSEF8JW/rBWPREpcstx6GXVa/Hqi7PxDK1f6mwFyUHaAy
	 APokLg1uYaKROvi8E1s2yz2nLR0+z27ks1FJKXW4zAoRHW5bYNBascaERrDWvAIz9I
	 RosHfnubuE37aSsA0n08pJXOQmIJ1Av0BunlVpn8kKAJFmHDUz0SJ5ea0ws779JY01
	 qvipmlkCmYRQvcv4oGXj/GBd16zX3y/7Re58kDEadMtGE1GUCohKIX4yuoZNl09cmf
	 ZcOg7GQ5wbVncoulrPOIZQqCGrE0F8Dap4HKBJRhi1rWzI19n/bW1SOORQglVup6PF
	 9TScPkId7Vx9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/12] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Sun, 23 Jun 2024 09:45:12 -0400
Message-ID: <20240623134518.809802-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit f5ceb1bbc98c69536d4673a97315e8427e67de1b ]

If the extent spans the block that contains i_size, we need to handle
both halves separately so that we properly zero data in the page cache
for blocks that are entirely outside of i_size. But this is needed only
when i_size is within the current folio under processing.
"orig_pos + length > isize" can be true for all folios if the mapped
extent length is greater than the folio size. That is making plen to
break for every folio instead of only the last folio.

So use orig_plen for checking if "orig_pos + orig_plen > isize".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dac1a5c110c0e..0f7dabc6c764e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -97,6 +97,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
+	size_t orig_plen = plen;
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -133,7 +134,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
+	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-- 
2.43.0


