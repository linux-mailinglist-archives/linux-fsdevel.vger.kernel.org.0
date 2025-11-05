Return-Path: <linux-fsdevel+bounces-67071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1608C345AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225251880905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B6258CDC;
	Wed,  5 Nov 2025 07:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72E2D0C66;
	Wed,  5 Nov 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329076; cv=none; b=I7UUgREJ0x+bz8XQY/WPSq5OQGwHh5ICwpNX30Zf1tds+OR+byZcy4dqL6uXReilnhUw58lQ0YYKqooeu/zZxyHLF189kK5cQJAtO84D8MVCoF+29kWkUoZBEQm749w3RZgzMHKptSaGlfeZ6TrV/CRZMk+lGoYXtWanfC/Rfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329076; c=relaxed/simple;
	bh=T4KRU7/xX4d4AKmpIGymzoNZp4hUsJJtqb/A1Oi7eYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9cvqxYMt+kYpCwfOBdpSKAyQqlWJbYkXysCAM2ku/hgp9zwEgsBYfVEu7BXWxCXHMLsybIGNMOectzHkLGfpnLMuDN0Oh2cJI3U3MiH+h6FsPnaJvLJ3UmlfvfJ39CczgDIYAFyDhHbCilJqDSjogBFIeqw7m2nT+STgnDFO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1cvL61xQzYQvKB;
	Wed,  5 Nov 2025 15:50:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3409A1A07BB;
	Wed,  5 Nov 2025 15:51:11 +0800 (CST)
Received: from huawei.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXuAQtpwcIVCw--.9854S6;
	Wed, 05 Nov 2025 15:51:11 +0800 (CST)
From: Yongjian Sun <sunyongjian@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	sunyongjian1@huawei.com
Subject: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation
Date: Wed,  5 Nov 2025 15:42:50 +0800
Message-Id: <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
Reply-To: sunyongjian1@huawei.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXuAQtpwcIVCw--.9854S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Wr1rtrWDtw1DZrW5Wrg_yoW7Jr4rpF
	WagF1fJF18WF47XFsFgw18WFyFk34kXF45CryFvw1rC3ZxtrnIkw1kKryF9a45urWrJw15
	ZF1Y9r9rC3sF9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j0UDXUUUUU=
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

When the MB_CHECK_ASSERT macro is enabled, we found that the
current validation logic in __mb_check_buddy has a gap in
detecting certain invalid buddy states, particularly related
to order-0 (bitmap) bits.

The original logic consists of three steps:
1. Validates higher-order buddies: if a higher-order bit is
set, at most one of the two corresponding lower-order bits
may be free; if a higher-order bit is clear, both lower-order
bits must be allocated (and their bitmap bits must be 0).
2. For any set bit in order-0, ensures all corresponding
higher-order bits are not free.
3. Verifies that all preallocated blocks (pa) in the group
have pa_pstart within bounds and their bitmap bits marked as
allocated.

However, this approach fails to properly validate cases where
order-0 bits are incorrectly cleared (0), allowing some invalid
configurations to pass:

               corrupt            integral

order 3           1                  1
order 2       1       1          1       1
order 1     1   1   1   1      1   1   1   1
order 0    0 0 1 1 1 1 1 1    1 1 1 1 1 1 1 1

Here we get two adjacent free blocks at order-0 with inconsistent
higher-order state, and the right one shows the correct scenario.

The root cause is insufficient validation of order-0 zero bits.
To fix this and improve completeness without significant performance
cost, we refine the logic:

1. Maintain the top-down higher-order validation, but we no longer
check the cases where the higher-order bit is 0, as this case will
be covered in step 2.
2. Enhance order-0 checking by examining pairs of bits:
   - If either bit in a pair is set (1), all corresponding
     higher-order bits must not be free.
   - If both bits are clear (0), then exactly one of the
     corresponding higher-order bits must be free
3. Keep the preallocation (pa) validation unchanged.

This change closes the validation gap, ensuring illegal buddy states
involving order-0 are correctly detected, while removing redundant
checks and maintaining efficiency.

Fixes: c9de560ded61f ("ext4: Add multi block allocator for ext4")
Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 57 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 194a9f995c36..e6cd27507c3e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -682,6 +682,24 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * Perform buddy integrity check with the following steps:
+ *
+ * 1. Top-down validation (from highest order down to order 1, excluding order-0 bitmap):
+ *    For each pair of adjacent orders, if a higher-order bit is set (indicating a free block),
+ *    at most one of the two corresponding lower-order bits may be clear (free).
+ *
+ * 2. Order-0 (bitmap) validation, performed on bit pairs:
+ *    - If either bit in a pair is set (1, allocated), then all corresponding higher-order bits
+ *      must not be free (0).
+ *    - If both bits in a pair are clear (0, free), then exactly one of the corresponding
+ *      higher-order bits must be free (0).
+ *
+ * 3. Preallocation (pa) list validation:
+ *    For each preallocated block (pa) in the group:
+ *    - Verify that pa_pstart falls within the bounds of this block group.
+ *    - Ensure the corresponding bit(s) in the order-0 bitmap are marked as allocated (1).
+ */
 static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				const char *function, int line)
 {
@@ -723,15 +741,6 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				continue;
 			}
 
-			/* both bits in buddy2 must be 1 */
-			MB_CHECK_ASSERT(mb_test_bit(i << 1, buddy2));
-			MB_CHECK_ASSERT(mb_test_bit((i << 1) + 1, buddy2));
-
-			for (j = 0; j < (1 << order); j++) {
-				k = (i * (1 << order)) + j;
-				MB_CHECK_ASSERT(
-					!mb_test_bit(k, e4b->bd_bitmap));
-			}
 			count++;
 		}
 		MB_CHECK_ASSERT(e4b->bd_info->bb_counters[order] == count);
@@ -747,15 +756,29 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				fragments++;
 				fstart = i;
 			}
-			continue;
+		} else {
+			fstart = -1;
 		}
-		fstart = -1;
-		/* check used bits only */
-		for (j = 0; j < e4b->bd_blkbits + 1; j++) {
-			buddy2 = mb_find_buddy(e4b, j, &max2);
-			k = i >> j;
-			MB_CHECK_ASSERT(k < max2);
-			MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
+		if (!(i & 1)) {
+			int in_use, zero_bit_count;
+
+			in_use = mb_test_bit(i, buddy) || mb_test_bit(i + 1, buddy);
+			zero_bit_count = 0;
+			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
+				buddy2 = mb_find_buddy(e4b, j, &max2);
+				k = i >> j;
+				MB_CHECK_ASSERT(k < max2);
+				if (in_use) {
+					/* can not contain any 0 at all orders */
+					MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
+				} else {
+					/* there is and can only be one 0 at all orders */
+					if (!mb_test_bit(k, buddy2)) {
+						zero_bit_count++;
+						MB_CHECK_ASSERT(zero_bit_count == 1);
+					}
+				}
+			}
 		}
 	}
 	MB_CHECK_ASSERT(!EXT4_MB_GRP_NEED_INIT(e4b->bd_info));
-- 
2.39.2


