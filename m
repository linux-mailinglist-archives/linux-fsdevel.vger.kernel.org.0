Return-Path: <linux-fsdevel+bounces-51710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20622ADA7CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BBC16BC2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D91DBB13;
	Mon, 16 Jun 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WU/F4j/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578F2E11CF;
	Mon, 16 Jun 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052884; cv=none; b=RWJZTopeh34JuNxJmv1ToV2YVu6Xf8BNu22JFo3k080u52X/oJCnDjlPXtLXVDsMqCbEZF+y64pBNY5NnxPD85b76InkWaC5B32HFAff9a+ScB24LICrdRadltYunUeO8+BKWnuMV2zHi+QjaW+RGItYYV6qI0iXS4kIDqzm2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052884; c=relaxed/simple;
	bh=R1R7XJL/dhzJf9/hmRHHVbhhwCBr0Ta41EznGtut0IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuA7BFICfbJUcbVJc+of/g2IUXzHxC2XGILy7uc6KXSjBvclNzMTrJ2Qv5SgYngLE6d0FdITnijxeGWTIvIkhTEojbrtZHRRpSA4Imgr9TBLDdM5Hvk982JHUafz5YbUD6WQ4bvbskYoe+Yv2Yxw3rTKd2UVJjp8RFN5OvMyMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WU/F4j/Z; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jk
	/BDnEMpsNlCN3FFv58EfDt4wHUty9REFl4NR/+Vps=; b=WU/F4j/ZQzxlOsOOTQ
	KWFObuTa5MDsw4q+mg9BpFm6xC2SvVyNNbbfcI7rHQlID/vWi5rUSz/W4Ezavxmm
	jqGN8jaaowDZS1unCTLJcIoRPEjXqSO7vEKKG3CCjOB0DmKC6DBQ7Ixes7N73evO
	wnvfUS0bwTEIOnyIqLo2CFH+Q=
Received: from chi-Redmi-Book.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXv+X5r09oXaT+IQ--.5361S2;
	Mon, 16 Jun 2025 13:47:39 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] iomap: Reduce some calculations in iomap_adjust_read_range()
Date: Mon, 16 Jun 2025 13:47:22 +0800
Message-ID: <20250616054722.142310-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv+X5r09oXaT+IQ--.5361S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1kKryxCr1xuFWxArW7XFb_yoW8Ar13pr
	yvkFWqkr4DWry09F10kFySqr95Ka97Wr45CFyfW34xXFZ8JrnIgr97Ga1Y9FW0vFs7XFnF
	vr1kKryUZF4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP73PUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiKRZmnWhE8HbdegACsL

From: Chi Zhiling <chizhiling@kylinos.cn>

It's unnecessary to update the poff and plen in every loop, delay the
calculations until return stage.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/iomap/buffered-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..0a1be45f7b96 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -233,7 +233,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
-	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
 	size_t orig_plen = plen;
@@ -252,16 +251,12 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		for (i = first; i <= last; i++) {
 			if (!ifs_block_is_uptodate(ifs, i))
 				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
 			first++;
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
-				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
 			}
@@ -277,9 +272,13 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-			plen -= (last - end) * block_size;
+			last = end;
 	}
 
+	poff = first << block_bits;
+	plen = (last - first + 1) << block_bits;
+	*pos = folio_pos(folio) + poff;
+
 	*offp = poff;
 	*lenp = plen;
 }
-- 
2.43.0


