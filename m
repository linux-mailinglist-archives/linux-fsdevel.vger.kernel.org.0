Return-Path: <linux-fsdevel+bounces-39069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A9A0BFEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A052C3A4B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFD1CBEAA;
	Mon, 13 Jan 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0SPg3bY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66071CB31D;
	Mon, 13 Jan 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793278; cv=none; b=CM3494y/t3wB+gikYkm7F8mxj+ElUO6So9jDaeb7VHtCJSCzKmfhrCCtGdDZDFnVCAzIc0ZacyXiOsTHp87FGnt3lSfFbpjREZOnDEy3rrIXDdEagNJ0PXTqa3nHkQGVUrDy+8rWfUR5sDl0hpT3NSKvYJqswEP3lvMZNB6OAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793278; c=relaxed/simple;
	bh=RO2K/A1WLgozdd+jk2u3+vm63ZbUdlt03BE/GIpVO9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/riZjSaCjnWVk0kIBImxjf1uDemlTwoCa7Tp3lgD4s4LYwYNfyx3K1ouskG0vghD94iuCYSFvmn5CUJoqJAwSPYEWw3StFgOluj4tqP/7d1Cq0L0a65mSMO3it+gT/krm5HfPPzu6L3s+lnkwW+3wgNoG83/HQJlN4/HcquYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0SPg3bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770C1C4CED6;
	Mon, 13 Jan 2025 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793278;
	bh=RO2K/A1WLgozdd+jk2u3+vm63ZbUdlt03BE/GIpVO9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0SPg3bYtm9Elh+fuVa2JxAcV40PpTvb/hjhMLwpvD0jDPwyPBvHPweluUrt0EO76
	 Nx3uh2cn12gSK1/f1SdTSfjzAN4MtH654twNWH1CLJNGmcxWQioZXijmktHcjywojH
	 MHaozvT3D0D1QjayG08aj1C+n1zwb2lN6w0b6VsB75QXyoH8vAewZFG9FMlAoM497x
	 fNmNLIMAcybR6p1uDz/SOq0c3BLkngrYGiEAxNpxWi9+khmyzaOU+RwiBHe2O2Er2U
	 49joMMZKOPfPi/4dkoXA6a2lmOM9RJOhHzF8RUpABh5R3ZgJPREklIUpbGtSO1v1m2
	 8FE+uli9mDOEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/20] iomap: pass byte granular end position to iomap_add_to_ioend
Date: Mon, 13 Jan 2025 13:34:09 -0500
Message-Id: <20250113183425.1783715-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit b44679c63e4d3ac820998b6bd59fba89a72ad3e7 ]

This is a preparatory patch for fixing zero padding issues in concurrent
append write scenarios. In the following patches, we need to obtain
byte-granular writeback end position for io_size trimming after EOF
handling.

Due to concurrent writeback and truncate operations, inode size may
shrink. Resampling inode size would force writeback code to handle the
newly appeared post-EOF blocks, which is undesirable. As Dave
explained in [1]:

"Really, the issue is that writeback mappings have to be able to
handle the range being mapped suddenly appear to be beyond EOF.
This behaviour is a longstanding writeback constraint, and is what
iomap_writepage_handle_eof() is attempting to handle.

We handle this by only sampling i_size_read() whilst we have the
folio locked and can determine the action we should take with that
folio (i.e. nothing, partial zeroing, or skip altogether). Once
we've made the decision that the folio is within EOF and taken
action on it (i.e. moved the folio to writeback state), we cannot
then resample the inode size because a truncate may have started
and changed the inode size."

To avoid resampling inode size after EOF handling, we convert end_pos
to byte-granular writeback position and return it from EOF handling
function.

Since iomap_set_range_dirty() can handle unaligned lengths, this
conversion has no impact on it. However, iomap_find_dirty_range()
requires aligned start and end range to find dirty blocks within the
given range, so the end position needs to be rounded up when passed
to it.

LINK [1]: https://lore.kernel.org/linux-xfs/Z1Gg0pAa54MoeYME@localhost.localdomain/

Signed-off-by: Long Li <leo.lilong@huawei.com>
Link: https://lore.kernel.org/r/20241209114241.3725722-2-leo.lilong@huawei.com
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..3ffd9937dd51 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1764,7 +1764,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, unsigned len)
+		struct inode *inode, loff_t pos, loff_t end_pos,
+		unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
@@ -1790,8 +1791,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, unsigned dirty_len,
-		unsigned *count)
+		struct inode *inode, u64 pos, u64 end_pos,
+		unsigned dirty_len, unsigned *count)
 {
 	int error;
 
@@ -1816,7 +1817,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			break;
 		default:
 			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					map_len);
+					end_pos, map_len);
 			if (!error)
 				(*count)++;
 			break;
@@ -1887,11 +1888,11 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 		 *    remaining memory is zeroed when mapped, and writes to that
 		 *    region are not written out to the file.
 		 *
-		 * Also adjust the writeback range to skip all blocks entirely
-		 * beyond i_size.
+		 * Also adjust the end_pos to the end of file and skip writeback
+		 * for all blocks entirely beyond i_size.
 		 */
 		folio_zero_segment(folio, poff, folio_size(folio));
-		*end_pos = round_up(isize, i_blocksize(inode));
+		*end_pos = isize;
 	}
 
 	return true;
@@ -1904,6 +1905,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	struct inode *inode = folio->mapping->host;
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
+	u64 end_aligned = 0;
 	unsigned count = 0;
 	int error = 0;
 	u32 rlen;
@@ -1945,9 +1947,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	/*
 	 * Walk through the folio to find dirty areas to write back.
 	 */
-	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
+	end_aligned = round_up(end_pos, i_blocksize(inode));
+	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, rlen, &count);
+				pos, end_pos, rlen, &count);
 		if (error)
 			break;
 		pos += rlen;
-- 
2.39.5


