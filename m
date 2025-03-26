Return-Path: <linux-fsdevel+bounces-45091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F804A719CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC42517B0E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D321EB5E5;
	Wed, 26 Mar 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZdKAIsiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4931A705C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001309; cv=none; b=Jp7peI+hH6OSjNl8Sq1ECjtCy9J3C0v5/HaiBTUkzOd1DsKs0Lfw8zZtERJrynL5s6nwftl7ky6z44aBtfd5LgJt4W9QCv1eyOaXSfHDAP4ulmk1/xx2enPKiF/po50LTz4Y4GvymNvp9tBn9qLQ3W+zh33Rlja8F71+m4De8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001309; c=relaxed/simple;
	bh=O76wFU1plWSkmdhoJgJqMscXb3dYt1MnIkBgvq0+lok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=dPzFBepbn3uo/jEUSxHhXeNOnro5fRJ9456kjibb5NQug6eSIIJ6RAxds1EieKKuKjzjqk5HZSxCrWorCyz8iMO6bGqs7c8snTJY9bH8VXORF9e4n2EEsdc3/veXdX3Wpg1nqfVcVbzETXP19K33zRrtZbRrTXfYW+FE8rbqgyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZdKAIsiz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250326150137epoutp04a46aed2c7b2d76acc5e54ff81cf14fb6~wYnIaT0l23225532255epoutp04X
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 15:01:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250326150137epoutp04a46aed2c7b2d76acc5e54ff81cf14fb6~wYnIaT0l23225532255epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743001298;
	bh=UBlH4A9rZcSc+ezo/kCacPWQ2jR/ev+s5zYEc/W0fZM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZdKAIsizDW3KUOzG48vvpyK0CkQvYlwN7ah4gZ5RM7pXN+HvY8nmAkcEm66i20U9F
	 8aLKxWBpiDs5gDO0zm3jAnitL+HN9Bp7iaxXZtvP+sXa0DWkbTNOgkfcwCfyEb3rpR
	 RN24LzE+IV+kBlEUm14Pn/8tICUYz37w3+kDOobo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250326150137epcas1p3fd814f73b37d68502de471bffb8171b1~wYnIJuvu61295312953epcas1p3p;
	Wed, 26 Mar 2025 15:01:37 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.225]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZN93j2WwTz4x9Pp; Wed, 26 Mar
	2025 15:01:37 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.76.19624.1D614E76; Thu, 27 Mar 2025 00:01:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950~wYnHdjB0Z2192821928epcas1p3t;
	Wed, 26 Mar 2025 15:01:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250326150136epsmtrp212708806960a1f480d3bff8bb220ba21~wYnHc6mmG2140821408epsmtrp2M;
	Wed, 26 Mar 2025 15:01:36 +0000 (GMT)
X-AuditID: b6c32a4c-079ff70000004ca8-c8-67e416d1c601
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.AB.08805.0D614E76; Thu, 27 Mar 2025 00:01:36 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250326150136epsmtip24d26b256780ee0e6374879b5d5e41afa~wYnHTuaGT2630826308epsmtip25;
	Wed, 26 Mar 2025 15:01:36 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: linkinjeon@kernel.org, yuezhang.mo@sony.com
Cc: sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cpgs@samsung.com, Sungjong Seo
	<sj1557.seo@samsung.com>
Subject: [PATCH] exfat: call bh_read in get_block only when necessary
Date: Thu, 27 Mar 2025 00:01:16 +0900
Message-Id: <20250326150116.3223792-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmge5FsSfpBs3LeC1eHtK0mDhtKbPF
	nr0nWSwu75rDZrHl3xFWixcfNrBZXH/zkNWB3WPnrLvsHptWdbJ59G1ZxejRPmEns8fnTXIB
	rFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK0YaGRnqGBuZ6RkZGeqZGsVZG
	pkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIKfrFSfmFpfmpesl5+cq
	KZQl5pQCjVDST/jGmHHjyV/2ghdGFWfurWVrYOxV62Lk5JAQMJFYcv4NexcjF4eQwB5Gib7t
	y6GcT4wS887MYwKpEhL4xiixeW00TMe13otMEEV7GSWOHV7CAuG0M0l8P7SfBaSKTUBbYnnT
	MuYuRg4OEQF9iZamKpAaZoGJjBLX3h1kBakRFnCVmLB4PpjNIqAq8bh9AjuIzStgK9Hx/gUz
	xDZ5iZmXvkPFBSVOznwCNp8ZKN68dTYzyFAJgUvsEj+WvGWFaHCRmPT/DJQtLPHq+BZ2CFtK
	4vO7vWwQDd2MEsc/vmOBSMxglFjS4QBh20s0tzazgVzNLKApsX6XPsQyPol3X3ugZvJKNGz8
	DTVTUOL0tW6wJ0HiHW1CEGEVie8fdrLArL3y4yoThO0hcWJLIyskRGMlWqZOYJ/AqDALyWuz
	kLw2C+GIBYzMqxilUguKc9NTkw0LDHXzUsuRI3oTIzjBavnsYPy+/q/eIUYmDsZDjBIczEoi
	vMdYH6YL8aYkVlalFuXHF5XmpBYfYkwGBvhEZinR5Hxgis8riTc0M7O0sDQyMTQ2MzQkLGxi
	aWBiZmRiYWxpbKYkznthW0u6kEB6YklqdmpqQWoRzBYmDk6pBqbVIv/L/p2VX++ptM9feiJ7
	j/zBRU8elfb85Q98O6fI8/GFM9/27Tbrz+qq0L/ipnevn+nCjaVns/ly9qlHVHFVmKutyND4
	lmgbfUGFYbeVocjp4mXmS4/1ezbM4n+io3xz2u7QlP+xSpZFYeuYZqxPaz43jeHYn69nqx49
	T/6aIlYtwv5ikvBvJm+W9h/97xba2H7dVjj1n8T0aVsanZQ03/bf/ywzvaFrddh1ewm5w2ER
	rzbylfxr7TDq+XZGKUksLKromupP+7dt8ydPkl8lWTvFtDfFdb1Lz75DWucfzUh6eKNHa552
	WMAq1tV7ZVa9jdgk84PlXWC4hbHj7I7rMTPnzv76/4G3xt2CBX+VWIozEg21mIuKEwHxkeMR
	ZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvO4FsSfpBl8vmlu8PKRpMXHaUmaL
	PXtPslhc3jWHzWLLvyOsFi8+bGCzuP7mIasDu8fOWXfZPTat6mTz6NuyitGjfcJOZo/Pm+QC
	WKO4bFJSczLLUov07RK4Mm48+cte8MKo4sy9tWwNjL1qXYycHBICJhLXei8ydTFycQgJ7GaU
	2HNlFlsXIwdQQkri4D5NCFNY4vDhYoiSViaJvi8vGEF62QS0JZY3LWMGsUUEDCU2LN7LDlLE
	LDCVUeLLtV42kISwgKvEhMXzWUFsFgFVicftE9hBbF4BW4mO9y+YIY6Ql5h56TtUXFDi5Mwn
	LCA2M1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc
	olpaOxj3rPqgd4iRiYPxEKMEB7OSCO8x1ofpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5N
	ERJITyxJzU5NLUgtgskycXBKNTAZMOtJvjF7uXbnXq1rSvUSXReNmJM2bBRRrL6QY3n76OMT
	23atFfgVHVRfc631seXv7WnbsnsOVz0xn/x49ff9G5u2516f4NR7yCXXx+/ya567Hzx2Vv89
	dX7aFLPPE89qfPuw9Phe/W+Xf+VwuHxWiZUvC53Jem8Liy5z2RXvvTcYVju275206mfZ1r/z
	+FLbEqxymc6wL3pXwN8QtPtwkvP7y/+/rGyNOXEraY3LsU2xOnpSk4u7Z/Pf+SUvqFW9pFFr
	T5mUUFv7y0ufvgfcvsIU28gg9+Ve2V4bV35mNZvdveE8i/wrXlYs+fsv5JU3v9XhNbzfddPO
	z9n+5awLZ+6TsJg9mYpLnb+EPN6prcRSnJFoqMVcVJwIAJlY/qHAAgAA
X-CMS-MailID: 20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950
References: <CGME20250326150136epcas1p3f49bc4a05b976046214486d7aaa23950@epcas1p3.samsung.com>

With commit 11a347fb6cef ("exfat: change to get file size from DataLength"),
exfat_get_block() can now handle valid_size. However, most partial
unwritten blocks that could be mapped with other blocks are being
inefficiently processed separately as individual blocks.

Except for partial unwritten blocks that require independent processing,
let's handle them simply as before.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/inode.c | 159 +++++++++++++++++++++++------------------------
 1 file changed, 77 insertions(+), 82 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index a23677de4544..b22c02d6000f 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -274,9 +274,11 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	sector_t last_block;
 	sector_t phys = 0;
 	sector_t valid_blks;
+	loff_t i_size;
 
 	mutex_lock(&sbi->s_lock);
-	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
+	i_size = i_size_read(inode);
+	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size, sb);
 	if (iblock >= last_block && !create)
 		goto done;
 
@@ -305,102 +307,95 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	if (buffer_delay(bh_result))
 		clear_buffer_delay(bh_result);
 
-	if (create) {
+	/*
+	 * In most cases, we just need to set bh_result to mapped, unmapped
+	 * or new status as follows:
+	 *  1. i_size == valid_size
+	 *  2. write case (create == 1)
+	 *  3. direct_read (!bh_result->b_folio)
+	 *     -> the unwritten part will be zeroed in exfat_direct_IO()
+	 *
+	 * Otherwise, in the case of buffered read, it is necessary to take
+	 * care the last nested block if valid_size is not equal to i_size.
+	 */
+	if (i_size == ei->valid_size || create || !bh_result->b_folio)
 		valid_blks = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
+	else
+		valid_blks = EXFAT_B_TO_BLK(ei->valid_size, sb);
 
-		if (iblock + max_blocks < valid_blks) {
-			/* The range has been written, map it */
-			goto done;
-		} else if (iblock < valid_blks) {
-			/*
-			 * The range has been partially written,
-			 * map the written part.
-			 */
-			max_blocks = valid_blks - iblock;
-			goto done;
-		}
+	/* The range has been fully written, map it */
+	if (iblock + max_blocks < valid_blks)
+		goto done;
 
-		/* The area has not been written, map and mark as new. */
-		set_buffer_new(bh_result);
+	/* The range has been partially written, map the written part */
+	if (iblock < valid_blks) {
+		max_blocks = valid_blks - iblock;
+		goto done;
+	}
 
+	/* The area has not been written, map and mark as new for create case */
+	if (create) {
+		set_buffer_new(bh_result);
 		ei->valid_size = EXFAT_BLK_TO_B(iblock + max_blocks, sb);
 		mark_inode_dirty(inode);
-	} else {
-		valid_blks = EXFAT_B_TO_BLK(ei->valid_size, sb);
+		goto done;
+	}
 
-		if (iblock + max_blocks < valid_blks) {
-			/* The range has been written, map it */
-			goto done;
-		} else if (iblock < valid_blks) {
-			/*
-			 * The area has been partially written,
-			 * map the written part.
-			 */
-			max_blocks = valid_blks - iblock;
+	/*
+	 * The area has just one block partially written.
+	 * In that case, we should read and fill the unwritten part of
+	 * a block with zero.
+	 */
+	if (bh_result->b_folio && iblock == valid_blks &&
+	    (ei->valid_size & (sb->s_blocksize - 1))) {
+		loff_t size, pos;
+		void *addr;
+
+		max_blocks = 1;
+
+		/*
+		 * No buffer_head is allocated.
+		 * (1) bmap: It's enough to set blocknr without I/O.
+		 * (2) read: The unwritten part should be filled with zero.
+		 *           If a folio does not have any buffers,
+		 *           let's returns -EAGAIN to fallback to
+		 *           block_read_full_folio() for per-bh IO.
+		 */
+		if (!folio_buffers(bh_result->b_folio)) {
+			err = -EAGAIN;
 			goto done;
-		} else if (iblock == valid_blks &&
-			   (ei->valid_size & (sb->s_blocksize - 1))) {
-			/*
-			 * The block has been partially written,
-			 * zero the unwritten part and map the block.
-			 */
-			loff_t size, pos;
-			void *addr;
-
-			max_blocks = 1;
-
-			/*
-			 * For direct read, the unwritten part will be zeroed in
-			 * exfat_direct_IO()
-			 */
-			if (!bh_result->b_folio)
-				goto done;
-
-			/*
-			 * No buffer_head is allocated.
-			 * (1) bmap: It's enough to fill bh_result without I/O.
-			 * (2) read: The unwritten part should be filled with 0
-			 *           If a folio does not have any buffers,
-			 *           let's returns -EAGAIN to fallback to
-			 *           per-bh IO like block_read_full_folio().
-			 */
-			if (!folio_buffers(bh_result->b_folio)) {
-				err = -EAGAIN;
-				goto done;
-			}
+		}
 
-			pos = EXFAT_BLK_TO_B(iblock, sb);
-			size = ei->valid_size - pos;
-			addr = folio_address(bh_result->b_folio) +
-			       offset_in_folio(bh_result->b_folio, pos);
+		pos = EXFAT_BLK_TO_B(iblock, sb);
+		size = ei->valid_size - pos;
+		addr = folio_address(bh_result->b_folio) +
+			offset_in_folio(bh_result->b_folio, pos);
 
-			/* Check if bh->b_data points to proper addr in folio */
-			if (bh_result->b_data != addr) {
-				exfat_fs_error_ratelimit(sb,
+		/* Check if bh->b_data points to proper addr in folio */
+		if (bh_result->b_data != addr) {
+			exfat_fs_error_ratelimit(sb,
 					"b_data(%p) != folio_addr(%p)",
 					bh_result->b_data, addr);
-				err = -EINVAL;
-				goto done;
-			}
-
-			/* Read a block */
-			err = bh_read(bh_result, 0);
-			if (err < 0)
-				goto done;
+			err = -EINVAL;
+			goto done;
+		}
 
-			/* Zero unwritten part of a block */
-			memset(bh_result->b_data + size, 0,
-			       bh_result->b_size - size);
+		/* Read a block */
+		err = bh_read(bh_result, 0);
+		if (err < 0)
+			goto done;
 
-			err = 0;
-		} else {
-			/*
-			 * The range has not been written, clear the mapped flag
-			 * to only zero the cache and do not read from disk.
-			 */
-			clear_buffer_mapped(bh_result);
-		}
+		/* Zero unwritten part of a block */
+		memset(bh_result->b_data + size, 0, bh_result->b_size - size);
+		err = 0;
+		goto done;
 	}
+
+	/*
+	 * The area has not been written, clear mapped for read/bmap cases.
+	 * If so, it will be filled with zero without reading from disk.
+	 */
+	clear_buffer_mapped(bh_result);
 done:
 	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
 	if (err < 0)
-- 
2.25.1


