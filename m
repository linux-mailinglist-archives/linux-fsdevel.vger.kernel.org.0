Return-Path: <linux-fsdevel+bounces-37261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91F79F0313
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4020C284783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23B17BB25;
	Fri, 13 Dec 2024 03:27:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC713A26D;
	Fri, 13 Dec 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060436; cv=none; b=hpfHtIYwC1b1E78pLgnIhmm0nwiGvcMvoTySJSYiSMKL3v4or1884T5ogb9vMZWPD6mCG+B/C5YwaHAtHGsAoL0IOcnt0FBTM/syF9OdbLUOJBFt101CNAfCLLyIXC4cdT+4mOPmXEUf1EQqRENlkNzbVWBzEyqCszEUhlxfOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060436; c=relaxed/simple;
	bh=tyU/E7IdI0PoI6xnGSKBcD21KiHHsKL6ZTo0hZJt4KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4vxVdxBCh1X+ewMKLo/y/AVhOTMNpbxSPjhNQHSq2jZp2Kt+roaNvEZescDbllGJDjT7cSRfXxHIYuv8RCadhAppNoSDmIgSau6DffPa+DEV+Ui6aQEHk+FEWdSATtTLh9mOPwX98WCVRYhhf0lVANRdJrQlUwL4tBMmx9r12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y8ZWb67Slz4f3jrp;
	Fri, 13 Dec 2024 11:26:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 307181A018C;
	Fri, 13 Dec 2024 11:27:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgBHcISMqVtnfJ3KEQ--.55430S7;
	Fri, 13 Dec 2024 11:27:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 5/5] Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent
Date: Fri, 13 Dec 2024 20:25:23 +0800
Message-Id: <20241213122523.12764-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122523.12764-1-shikemeng@huaweicloud.com>
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHcISMqVtnfJ3KEQ--.55430S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UuF13JryrGFWxCFyfWFg_yoW8GrWkpF
	97C3s8Ka1xA3WUKrnFvan7t345Ja1kK3yjyr4xGwnayFZ8Gr1Yqay7tryjqFnxGFy8ZFy3
	Cr1Fg3y5Wa1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07ja
	g4hUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Besides xas_squash_marks(), all functions use xa_mark_t type to iterate
all possible marks. Use xa_mark_t in xas_squash_marks() to keep code
consistent.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 4231af284bd8..a74795911f1c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -125,16 +125,20 @@ static inline void node_mark_all(struct xa_node *node, xa_mark_t mark)
  */
 static void xas_squash_marks(const struct xa_state *xas)
 {
-	unsigned int mark = 0;
+	xa_mark_t mark = 0;
 	unsigned int limit = xas->xa_offset + xas->xa_sibs + 1;
 
-	do {
-		unsigned long *marks = xas->xa_node->marks[mark];
-		if (find_next_bit(marks, limit, xas->xa_offset + 1) == limit)
-			continue;
-		__set_bit(xas->xa_offset, marks);
-		bitmap_clear(marks, xas->xa_offset + 1, xas->xa_sibs);
-	} while (mark++ != (__force unsigned)XA_MARK_MAX);
+	for (;;) {
+		unsigned long *marks = node_marks(xas->xa_node, mark);
+
+		if (find_next_bit(marks, limit, xas->xa_offset + 1) != limit) {
+			__set_bit(xas->xa_offset, marks);
+			bitmap_clear(marks, xas->xa_offset + 1, xas->xa_sibs);
+		}
+		if (mark == XA_MARK_MAX)
+			break;
+		mark_inc(mark);
+	}
 }
 
 /* extracts the offset within this node from the index */
-- 
2.30.0


