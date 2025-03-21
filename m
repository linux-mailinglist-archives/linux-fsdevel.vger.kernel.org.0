Return-Path: <linux-fsdevel+bounces-44678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA1EA6B484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 07:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B8E3B1479
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890331EB5E1;
	Fri, 21 Mar 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FN97etJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAF1E0E0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539088; cv=none; b=aUBGGLr1gklkbHnIx2LdBa39oq6aJqLnpaBK+E4vg5PNc4Kkha+uShOWKOYRD4pgWo4Vx2JrxTPbDZpGK0v8GvDvhL+aVpNYc9wLVAi8AbHTHC3t9pET+9nrtsbchf+Wb1UvqrTgaE/LdgGRvRUwWVkqtCAQEOFqAxtXyPmZamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539088; c=relaxed/simple;
	bh=meYjgWGxyLy6HJSfb0FdcX0Qg9YFgDlf0+iGbmC5AiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KMZDsxML42DRNs+H4yoZPzdWCQ8omtPxl9fLdhsDLg+3gUT2pH6OTc26ZB9YM/0NGf327noMWEevSxu/fymYYf551k1BfQN51hQMUpGD/IH0UQ0m31Mn8x/infX6o6XYsM+fhPpYiFhqj+HY/vdV0jqgIKMA0DMTMAj5qqb+k4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FN97etJi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250321063803epoutp02191d8e68b3dc62f3484e0552d2520d14~uvhB3fi6X2312423124epoutp02T
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 06:38:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250321063803epoutp02191d8e68b3dc62f3484e0552d2520d14~uvhB3fi6X2312423124epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742539083;
	bh=1NaBi+C3PclgJ/mik2KcHhq6pRjepmXkq91bXFQkaSM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=FN97etJilB83agYpgVeG6fB4CJVLrOtcBdX1Eac28evNXXSQpF8Zun1aMRgDoTW9s
	 coT3ZVVEm4LQhYRSLu4g9tRcrZLJPQg65ByTtE2fK5T2ErZlcM9ATOslb0hO0SO+bX
	 lOTpXfbx2BjjrXRV41ATivT0MavCOyAQjgnJuiBo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250321063803epcas1p323d78e004fb31160a2be117c1424eba5~uvhBZx-kU2185521855epcas1p3Y;
	Fri, 21 Mar 2025 06:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZJt6z1jp6z4x9QB; Fri, 21 Mar
	2025 06:38:03 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4~uveR3Y2Hk0882208822epcas1p21;
	Fri, 21 Mar 2025 06:34:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250321063454epsmtrp14197eafd8fdbbb6baef97afa109a7ce0~uveR2oz5u3110531105epsmtrp1t;
	Fri, 21 Mar 2025 06:34:54 +0000 (GMT)
X-AuditID: b6c32a29-63df970000004929-f0-67dd088ed88d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.56.18729.E880DD76; Fri, 21 Mar 2025 15:34:54 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250321063454epsmtip141edc3128a8e468552bbfa2505484223~uveRm9QBM1594915949epsmtip19;
	Fri, 21 Mar 2025 06:34:54 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: linkinjeon@kernel.org, yuezhang.mo@sony.com
Cc: sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cpgs@samsung.com, Sungjong Seo
	<sj1557.seo@samsung.com>, stable@vger.kernel.org, Yeongjin Gil
	<youngjin.gil@samsung.com>
Subject: [PATCH v2] exfat: fix random stack corruption after get_block
Date: Fri, 21 Mar 2025 15:34:42 +0900
Message-Id: <158453976.61742539083228.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnG4fx910g3kbtCxeHtK0mDhtKbPF
	nr0nWSwu75rDZrHl3xFWixcfNrBZLNj4iNFixv6n7BbX3zxkdeD02DnrLrvHplWdbB59W1Yx
	erRP2Mns8XmTXABrFJdNSmpOZllqkb5dAlfGvj83mQsmyFW8b5nN0sC4QbSLkZNDQsBEYvGr
	mcxdjFwcQgK7GSVO3X3K1MXIAZSQkji4TxPCFJY4fLgYoqSVSWLvrOvMIL1sAtoSy5uWgdki
	AoYSGxbvZQcpYha4xSgx7foEdpCEsICbxK3pO8CKWARUJRovrWMCsXkFbCWWnPzNCHGEvMTM
	S9/ZIeKCEidnPmEBsZmB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
	0rx0veT83E2M4LDV0tzBuH3VB71DjEwcjIcYJTiYlUR4RTpupwvxpiRWVqUW5ccXleakFh9i
	lOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgmnp5Ebu9/Qn5jecsssxnurTtX6Euu4K7
	4N3BfKvuznfer/ZmpE1M5/iTVL2EYzf31szH8yO5S33Lru9ar/JGNre13+9J5ZnFTFqHX6UZ
	Po2e/fjmb7P6Rdv4b7x6d4bjYUNR21afMy3m9U3tl4J3zChROrf46vWJd9T+zvhwU7pqk32o
	+Z/zWxqXHqi8nX1i3XQey6/ftnNef7CvdGnOv3bXiRrFwv9d2cMzgrcckwl80iu4KFj2M2ug
	/KlN/wUMqmT/hYUaGHbvFbCTurtYXPiW3bQkj81uwvGnX3Mya1+vsXwWwPHxq8yRD6kLpi0Q
	y5rEkH3JOODd7g9SGaxWG/7vf2jpoXBcXchve9aCqUosxRmJhlrMRcWJAKi5uDPKAgAA
X-CMS-MailID: 20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4
References: <CGME20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4@epcas1p2.samsung.com>

When get_block is called with a buffer_head allocated on the stack, such
as do_mpage_readpage, stack corruption due to buffer_head UAF may occur in
the following race condition situation.

     <CPU 0>                      <CPU 1>
mpage_read_folio
  <<bh on stack>>
  do_mpage_readpage
    exfat_get_block
      bh_read
        __bh_read
	  get_bh(bh)
          submit_bh
          wait_on_buffer
                              ...
                              end_buffer_read_sync
                                __end_buffer_read_notouch
                                   unlock_buffer
          <<keep going>>
        ...
      ...
    ...
  ...
<<bh is not valid out of mpage_read_folio>>
   .
   .
another_function
  <<variable A on stack>>
                                   put_bh(bh)
                                     atomic_dec(bh->b_count)
  * stack corruption here *

This patch returns -EAGAIN if a folio does not have buffers when bh_read
needs to be called. By doing this, the caller can fallback to functions
like block_read_full_folio(), create a buffer_head in the folio, and then
call get_block again.

Let's do not call bh_read() with on-stack buffer_head.

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: stable@vger.kernel.org
Tested-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
v2:
 - clear_buffer_mapped if there is any errors.
 - remove unnecessary BUG_ON()
---
 fs/exfat/inode.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 96952d4acb50..f3fdba9f4d21 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -344,7 +344,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			 * The block has been partially written,
 			 * zero the unwritten part and map the block.
 			 */
-			loff_t size, off, pos;
+			loff_t size, pos;
+			void *addr;
 
 			max_blocks = 1;
 
@@ -355,17 +356,41 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			if (!bh_result->b_folio)
 				goto done;
 
+			/*
+			 * No buffer_head is allocated.
+			 * (1) bmap: It's enough to fill bh_result without I/O.
+			 * (2) read: The unwritten part should be filled with 0
+			 *           If a folio does not have any buffers,
+			 *           let's returns -EAGAIN to fallback to
+			 *           per-bh IO like block_read_full_folio().
+			 */
+			if (!folio_buffers(bh_result->b_folio)) {
+				err = -EAGAIN;
+				goto done;
+			}
+
 			pos = EXFAT_BLK_TO_B(iblock, sb);
 			size = ei->valid_size - pos;
-			off = pos & (PAGE_SIZE - 1);
+			addr = folio_address(bh_result->b_folio) +
+			       offset_in_folio(bh_result->b_folio, pos);
+
+			/* Check if bh->b_data points to proper addr in folio */
+			if (bh_result->b_data != addr) {
+				exfat_fs_error_ratelimit(sb,
+					"b_data(%p) != folio_addr(%p)",
+					bh_result->b_data, addr);
+				err = -EINVAL;
+				goto done;
+			}
 
-			folio_set_bh(bh_result, bh_result->b_folio, off);
+			/* Read a block */
 			err = bh_read(bh_result, 0);
 			if (err < 0)
-				goto unlock_ret;
+				goto done;
 
-			folio_zero_segment(bh_result->b_folio, off + size,
-					off + sb->s_blocksize);
+			/* Zero unwritten part of a block */
+			memset(bh_result->b_data + size, 0,
+			       bh_result->b_size - size);
 		} else {
 			/*
 			 * The range has not been written, clear the mapped flag
@@ -376,6 +401,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	}
 done:
 	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
+	if (err < 0)
+		clear_buffer_mapped(bh_result);
 unlock_ret:
 	mutex_unlock(&sbi->s_lock);
 	return err;
-- 
2.25.1



