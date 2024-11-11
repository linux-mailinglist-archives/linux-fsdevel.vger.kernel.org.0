Return-Path: <linux-fsdevel+bounces-34225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98A9C3EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22220B23808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F91AB6EB;
	Mon, 11 Nov 2024 12:55:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0719DF7A;
	Mon, 11 Nov 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329702; cv=none; b=R18QLaHJZQIjeNAsx/9oHIRW7tGk+c45g1EF0dNR69+3TyNBhuvuUbGyZp9h4ooj5HtvtB7qxMbZBTNkOa9rLfiREl64cA4rv+WgcP/rRK1oeJmi0Nxg9SJIWpXR+QUpKK14pTeLs0D7BggF95S9pBxJKFSsm1tjkpWUYiJhgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329702; c=relaxed/simple;
	bh=tyU/E7IdI0PoI6xnGSKBcD21KiHHsKL6ZTo0hZJt4KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8/Hx+ww3eTvWDmN9W7dSdRDFsWsVK/RhuTHTsFDUJjcP/gl1odhnS1NYCasMyCMc3k3DgIiubs1VR6c7nOM3w0RFUfrTzofD/hKjOJXihJQUmgwIZrXZ70sB5rgh2uFtDXayW1vgzw3lR1rtlVM3T7zqvGLapR+vlkSsGELEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xn8dc3l0Wz4f3kpP;
	Mon, 11 Nov 2024 20:54:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 94E4C1A06D7;
	Mon, 11 Nov 2024 20:54:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4Oe_jFnllryBQ--.36628S7;
	Mon, 11 Nov 2024 20:54:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND V2 5/5] Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent
Date: Tue, 12 Nov 2024 05:53:59 +0800
Message-Id: <20241111215359.246937-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241111215359.246937-1-shikemeng@huaweicloud.com>
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4Oe_jFnllryBQ--.36628S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UuF13JryrGFWxCFyfWFg_yoW8GrWkpF
	97C3s8Ka1xA3WUKrnFvan7t345Ja1kK3yjyr4xGwnayFZ8Gr1Yqay7tryjqFnxGFy8ZFy3
	Cr1Fg3y5Wa1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	s3kuDUUUU
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


