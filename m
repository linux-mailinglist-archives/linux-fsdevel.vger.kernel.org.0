Return-Path: <linux-fsdevel+bounces-73151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B875D0E8C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4F0300EA28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422D330655;
	Sun, 11 Jan 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B8YrixWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBF238C3A
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126381; cv=none; b=ReeKRA0WTFmfW21HYqMyGhNlAreyw2p88iE1eZZRNnq8S2prVz0wpzTeqWsx6VdP3Nnu/RMWlUhB7etHfRyYOHKaV6K6SjDoSrXQ6bg4SoaOisl2FnqARbq4hgakGYLpWmTcfRP7p5/WswnYOp1zfj+xWQjIxbvuAFDqHvVcs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126381; c=relaxed/simple;
	bh=eycNygkDY1EyI8QvCTMocrXNAPQ2Jr/gIft/pWMaLqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y73Znf+uX/q0j0GumHENdsz62clZ1SLMJSJpC8YZKBCH0B6BwsYSRmMC9qDsO/gyuu9B+1oIYNqvg5hwWpzYbcCal6K+UuLrDJyJ0f+Ad1IisK073GfcrnrYKLLWDdG3lJBHq+KJ7i6CExh3RSSCGoyQa3cxmvjCc7hHfP7lrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B8YrixWz; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vz
	Vndx28vpRx956/VNzPxMUArdQCxma2/Zzy9dSi7H4=; b=B8YrixWzj3kwhmNwfu
	BByk6LIsXQLQLxgeE0GG4fEEVIWMKc0xuBehAWGRhEPFT/C1oOpRrnkD2CZLPjIB
	enx/h+qRy50y1ilovCOI/dRP6jVzRHXzzdNBO56TJlK4kdWcNoGWufNhnAucJ4/q
	X4NMDpMgQ+r1b96iYg4zoi45A=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3lx+Ad2Np0FddBg--.65279S4;
	Sun, 11 Jan 2026 18:12:21 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: advance index and offset after zeroing in large folio read
Date: Sun, 11 Jan 2026 18:09:41 +0800
Message-Id: <20260111100941.119765-3-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111100941.119765-1-nzzhao@126.com>
References: <20260111100941.119765-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lx+Ad2Np0FddBg--.65279S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF43Zr4fGw18Ary3tr1UZFb_yoW8Gr1fpF
	yDKr1FkFn8G3yFvw10v3WkCw10y34kWay7GFWxCw1fA3Z8Xr93CFy8ta4F9F17t395Aw10
	qa1FgFy8WFn0qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4T5dUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQUyAmljd4WZNQAA3Q

In f2fs_read_data_large_folio(), the block zeroing path calls
folio_zero_range() and then continues the loop. However, it fails to
advance index and offset before continuing.

This can cause the loop to repeatedly process the same subpage of the
folio, leading to stalls/hangs and incorrect progress when reading large
folios with holes/zeroed blocks.

Fix it by advancing index and offset unconditionally in the loop
iteration, so they are updated even when the zeroing path continues.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ddabcb1b9882..18952daa8d8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2458,7 +2458,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	ffs = NULL;
 	nrpages = folio_nr_pages(folio);

-	for (; nrpages; nrpages--) {
+	for (; nrpages; nrpages--, index++, offset++) {
 		sector_t block_nr;
 		/*
 		 * Map blocks using the previous result first.
@@ -2543,8 +2543,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
 				F2FS_BLKSIZE);
 		last_block_in_bio = block_nr;
-		index++;
-		offset++;
 	}
 	trace_f2fs_read_folio(folio, DATA);
 	if (rac) {
--
2.34.1


