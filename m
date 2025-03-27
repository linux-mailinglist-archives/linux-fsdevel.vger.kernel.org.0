Return-Path: <linux-fsdevel+bounces-45115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E902A72A09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 06:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16281891377
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003081ACEB7;
	Thu, 27 Mar 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W/pZmpbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA818027;
	Thu, 27 Mar 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055054; cv=none; b=fZnWKoFCLqEoa8SCwKOLzqMDDeqnptTIlCOzZ/+zW+oO1OhbWyz4IeVy7Ej93ld6BYtaS8jEvESA+1WkPXFeSw4OfJHxacNUXxIxDSfFIDdbU7zqrRGwJugLXMMyDK0CjW3Fu3+1fv3XmLv08N8fWkpPJ0kU94DtvSm045oAvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055054; c=relaxed/simple;
	bh=dfOJt4VZsxDjQHbdacmRXA60dH+jdi0InNRBXeq652k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cL033CZpumC0ykfgyXO90T7mlV4jhIFG0weAtFdyuu7barjVPd2IOn4ktaSE1Bfmp6pTYrEtRUOyixxQo6oolLL49Zs0kCmHybu83L+sEuZQF3uBz2nq0rLqilHILSwThocvR0oL1x608f6r6DxZbSvelyKRQFyNrawW93BJhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W/pZmpbK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=asBGI
	gUyw+T6cskUQZ6NxJZpB5WfhcDaPgKOiFRAeEE=; b=W/pZmpbKrq+mesyob0yVH
	HOl4BbX+Y41XPNzxl65HfmYXMH+S7Mstssn0741O8vEap1+ITg8EpXtRim3KsMq9
	2uiGeWTNWyVEfAlFQpSo3LdStaAKBF+U6PGKnwOklDrNixzRba94ASMfLR8FLThP
	QYl3bAR6+ufMOqb9Yhfsos=
Received: from chi-Redmi-Book.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD34Z+16ORnmeqVCA--.5025S2;
	Thu, 27 Mar 2025 13:57:10 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: cem@kernel.org,
	djwong@kernel.org,
	brauner@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] iomap: Rename iomap_last_written_block to iomap_first_unchanged_block
Date: Thu, 27 Mar 2025 13:57:06 +0800
Message-ID: <20250327055706.3668207-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD34Z+16ORnmeqVCA--.5025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4fCFW5AF4UCFW3Aw1DKFg_yoW8WrW3pr
	WkK3WrGF4kW348u3WkGFW7Zw1av3Wvkr4UArWrKr13Z345XF1Iqw1vkF1Yk3W7Wws2ya17
	WrnFg3yUCw45urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWv35UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAsdnWfk5UUKaQABsK

From: Chi Zhiling <chizhiling@kylinos.cn>

This renames iomap_last_written_block() to iomap_first_unchanged_block()
to better reflect its actual behavior of finding the first unmodified
block after partial writes, improving code readability.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/xfs/xfs_iomap.c    | 2 +-
 include/linux/iomap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5dd0922fe2d1..d4b0358015ab 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1277,7 +1277,7 @@ xfs_buffered_write_iomap_end(
 		return 0;
 
 	/* Nothing to do if we've written the entire delalloc extent */
-	start_byte = iomap_last_written_block(inode, offset, written);
+	start_byte = iomap_first_unchanged_block(inode, offset, written);
 	end_byte = round_up(offset + length, i_blocksize(inode));
 	if (start_byte >= end_byte)
 		return 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2de7a5e7d67d..88d0da23426c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -308,7 +308,7 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
  * If nothing was written, round @pos down to point at the first block in
  * the range, else round up to include the partially written block.
  */
-static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
+static inline loff_t iomap_first_unchanged_block(struct inode *inode, loff_t pos,
 		ssize_t written)
 {
 	if (unlikely(!written))
-- 
2.43.0


