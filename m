Return-Path: <linux-fsdevel+bounces-36769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127219E92B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0E1623F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F55221D86;
	Mon,  9 Dec 2024 11:46:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C441F931;
	Mon,  9 Dec 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744774; cv=none; b=ZHBTqxFLb89nEdQBVi5XmcSoMilq5F8lANJ5Pr1FvYebs6MmWq5iToV9510X/G4sj/+4Kx0fxPS3xzq79a6Ue2jVYW8adQRWddDqO8P5AgEZwqU0qBjCwU2eYzgxxsBARo/D3z/hwCoFfOx6zx5iL0AMQF5Lt9rBo7eudsKB4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744774; c=relaxed/simple;
	bh=S9ohGXGRH+w3yD9TTNM/UUkfLwwqfAKztzeMWyFiNeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXxGVsBLxbNeXrbO95PQev+6D+vx5aJysPhUzFmIGkoGuUdyiqRMll2QXGj4mpZ6oz3qtZGqKyc7e3yCIVyyAOXSvMVFIpyT2Zpfn6sNIGl0jxG6b+4kqWxNuEauIAQVEoUSC04wMcCQ4VblVr8V2GNXSSu2A4IiLKaGh4tcBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y6KlZ1M8NzRj23;
	Mon,  9 Dec 2024 19:44:26 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D4C0180102;
	Mon,  9 Dec 2024 19:46:09 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 19:46:08 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v6 1/3] iomap: pass byte granular end position to iomap_add_to_ioend
Date: Mon, 9 Dec 2024 19:42:39 +0800
Message-ID: <20241209114241.3725722-2-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241209114241.3725722-1-leo.lilong@huawei.com>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

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
---
 fs/iomap/buffered-io.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 955f19e27e47..bcc7831d03af 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1774,7 +1774,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, unsigned len)
+		struct inode *inode, loff_t pos, loff_t end_pos,
+		unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
@@ -1800,8 +1801,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, unsigned dirty_len,
-		unsigned *count)
+		struct inode *inode, u64 pos, u64 end_pos,
+		unsigned dirty_len, unsigned *count)
 {
 	int error;
 
@@ -1826,7 +1827,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			break;
 		default:
 			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					map_len);
+					end_pos, map_len);
 			if (!error)
 				(*count)++;
 			break;
@@ -1897,11 +1898,11 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
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
@@ -1914,6 +1915,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	struct inode *inode = folio->mapping->host;
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
+	u64 end_aligned = 0;
 	unsigned count = 0;
 	int error = 0;
 	u32 rlen;
@@ -1955,9 +1957,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
2.39.2


