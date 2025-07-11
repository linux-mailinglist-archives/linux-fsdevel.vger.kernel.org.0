Return-Path: <linux-fsdevel+bounces-54588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C42B01315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2553A1FD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7891CDA3F;
	Fri, 11 Jul 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrAkh1/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6541B87C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213384; cv=none; b=fj8n1amAD4g0Eo4BR5Rqxixi70ZYw5A7OSUQpyMZb8VYZWN+rmI3lqaNdea+oXSoslhDUfzLRnttYxlGqamrFyPsz2WoJ29G5+8Zj0/E0OptB/5czWR6vXGR4wOVRq7OTlfQddSRK7UvkihRln2g+CrIazwA2Wmy4yUe05lzRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213384; c=relaxed/simple;
	bh=E1uqYY1smKK/3YssRHuwbYZ2z7OHLkmojyBrinRHozg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LbdpyLJ+9eIwOAqPMbzPREQpQOCu/D0Fp+UCG6u8z66Mo/lmsLrvkWC6y2m37c9nnwduvEC57QseHFH2MMVJY1azf4KDvypU5jGmiu0qAmUQYw15gDo98Q3v8AEAQsHFp0g8BaKd0h+68Dp02/hDDPNA2Z2H0TC66QvRh2UTC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrAkh1/Z; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752213378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hm+HZ9v47mDt2xf4klE6BqylD3gvRDVDrg6ZEcP7nTg=;
	b=jrAkh1/ZPPqVij9ltNshn1/iP/1H/ZAWWSDdVHgm9RPpCPeHLGVZ4ySyA0vAcQ+oOcyefc
	zmRKGikgoNerEp4s4NP984rSbjRf6M8M8oi7eCZ/zm7VLCkP05scvLWq+FYvjcxE4r/dPt
	uslPM7KPoBTLnVeKtZrnDWiWlUTO7h0=
From: Youling Tang <youling.tang@linux.dev>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chizhiling@163.com,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] mm/filemap: Align last_index to folio size
Date: Fri, 11 Jul 2025 13:55:09 +0800
Message-Id: <20250711055509.91587-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
enabled, We observed the following readahead behaviors:
 # echo 3 > /proc/sys/vm/drop_caches
 # dd if=test of=/dev/null bs=64k count=1
 # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
 foffset	offset	flags
 0	136d4c	__RU_l_________H______t_________________F_1
 1	136d4d	__RU_l__________T_____t_________________F_1
 2	136d4e	__RU_l__________T_____t_________________F_1
 3	136d4f	__RU_l__________T_____t_________________F_1
 ...
 c	136bb8	__RU_l_________H______t_________________F_1
 d	136bb9	__RU_l__________T_____t_________________F_1
 e	136bba	__RU_l__________T_____t_________________F_1
 f	136bbb	__RU_l__________T_____t_________________F_1   <-- first read
 10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
 11	13c2cd	___U_l__________T_____t______________I__F_1
 12	13c2ce	___U_l__________T_____t______________I__F_1
 13	13c2cf	___U_l__________T_____t______________I__F_1
 ...
 1c	1405d4	___U_l_________H______t_________________F_1
 1d	1405d5	___U_l__________T_____t_________________F_1
 1e	1405d6	___U_l__________T_____t_________________F_1
 1f	1405d7	___U_l__________T_____t_________________F_1
 [ra_size = 32, req_count = 16, async_size = 16]

 # echo 3 > /proc/sys/vm/drop_caches
 # dd if=test of=/dev/null bs=60k count=1
 # ./page-types -r -L -f  /mnt/xfs/test
 foffset	offset	flags
 0	136048	__RU_l_________H______t_________________F_1
 ...
 c	110a40	__RU_l_________H______t_________________F_1
 d	110a41	__RU_l__________T_____t_________________F_1
 e	110a42	__RU_l__________T_____t_________________F_1   <-- first read
 f	110a43	__RU_l__________T_____t_________________F_1   <-- first readahead flag
 10	13e7a8	___U_l_________H______t_________________F_1
 ...
 20	137a00	___U_l_________H______t_______P______I__F_1   <-- second readahead flag (20 - 2f)
 21	137a01	___U_l__________T_____t_______P______I__F_1
 ...
 3f	10d4af	___U_l__________T_____t_______P_________F_1
 [first readahead: ra_size = 32, req_count = 15, async_size = 17]

When reading 64k data (same for 61-63k range, where last_index is page-aligned
in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
and the PG_readahead flag is set on the next folio (the one containing 0x10 page).

When reading 60k data, 128k readahead is also triggered via page_cache_sync_ra().
However, in this case the readahead flag is set on the 0xf page. Although the
requested read size (req_count) is 60k, the actual read will be aligned to
folio size (64k), which triggers the readahead flag and initiates asynchronous
readahead via page_cache_async_ra(). This results in two readahead operations
totaling 256k.

The root cause is that when the requested size is smaller than the actual read
size (due to folio alignment), it triggers asynchronous readahead. By changing
last_index alignment from page size to folio size, we ensure the requested size
matches the actual read size, preventing the case where a single read operation
triggers two readahead operations.

After applying the patch:
 # echo 3 > /proc/sys/vm/drop_caches
 # dd if=test of=/dev/null bs=60k count=1
 # ./page-types -r -L -f  /mnt/xfs/test
 foffset	offset	flags
 0	136d4c	__RU_l_________H______t_________________F_1
 1	136d4d	__RU_l__________T_____t_________________F_1
 2	136d4e	__RU_l__________T_____t_________________F_1
 3	136d4f	__RU_l__________T_____t_________________F_1
 ...
 c	136bb8	__RU_l_________H______t_________________F_1
 d	136bb9	__RU_l__________T_____t_________________F_1
 e	136bba	__RU_l__________T_____t_________________F_1   <-- first read
 f	136bbb	__RU_l__________T_____t_________________F_1
 10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
 11	13c2cd	___U_l__________T_____t______________I__F_1
 12	13c2ce	___U_l__________T_____t______________I__F_1
 13	13c2cf	___U_l__________T_____t______________I__F_1
 ...
 1c	1405d4	___U_l_________H______t_________________F_1
 1d	1405d5	___U_l__________T_____t_________________F_1
 1e	1405d6	___U_l__________T_____t_________________F_1
 1f	1405d7	___U_l__________T_____t_________________F_1
 [ra_size = 32, req_count = 16, async_size = 16]

The same phenomenon will occur when reading from 49k to 64k. Set the readahead
flag to the next folio.

Because the minimum order of folio in address_space equals the block size (at
least in xfs and bcachefs that already support bs > ps), having request_count
aligned to block size will not cause overread.

Co-developed-by: Chi Zhiling <chizhiling@kylinos.cn>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/linux/pagemap.h | 6 ++++++
 mm/filemap.c            | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..447bb264fd94 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -480,6 +480,12 @@ mapping_min_folio_nrpages(struct address_space *mapping)
 	return 1UL << mapping_min_folio_order(mapping);
 }
 
+static inline unsigned long
+mapping_min_folio_nrbytes(struct address_space *mapping)
+{
+	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
+}
+
 /**
  * mapping_align_index() - Align index for this mapping.
  * @mapping: The address_space.
diff --git a/mm/filemap.c b/mm/filemap.c
index 765dc5ef6d5a..56a8656b6f86 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	unsigned int flags;
 	int err = 0;
 
-	/* "last_index" is the index of the page beyond the end of the read */
-	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
+	/* "last_index" is the index of the folio beyond the end of the read */
+	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
+	last_index >>= PAGE_SHIFT;
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
-- 
2.34.1


