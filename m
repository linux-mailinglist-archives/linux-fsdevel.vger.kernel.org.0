Return-Path: <linux-fsdevel+bounces-33872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A39BFF22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BAB283CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CA1D79B4;
	Thu,  7 Nov 2024 07:30:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62C193074;
	Thu,  7 Nov 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964624; cv=none; b=O7rC192rB/ZTuWfWAmmi7n5twfLqLkJoewyQUn+D0r4WugjIuxxYpnpVcznyVVRJDKMvyLMjII6igIw2fPVj5WqW2PAtPq59fK9fmSVa8ST3nKS0HPBeypeC8pFSkZSXIYU30xISjO1aaeyCK8AsWhB9e1wO99gTsB4umQ1mk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964624; c=relaxed/simple;
	bh=tyU/E7IdI0PoI6xnGSKBcD21KiHHsKL6ZTo0hZJt4KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qsblzGc7DHepxz2fV5NH4CjIcLD+pTXS6ghBYZWzu+s95waOV1wjejTrEQ+/c7vzdyMsJEoyD1TdxgFxFVCIr7/VJl8wqt3CqLahrkCQ7XyaU1tBG2BWrCtqYDuH0gLQrLqMnFpzuYwromyl/QpfhbajwlQI4T4V5ObDO5DHojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XkYcd1cx7z4f3mJ4;
	Thu,  7 Nov 2024 15:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1CEC61A018D;
	Thu,  7 Nov 2024 15:30:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgB3Ha+BbCxnnlhABA--.55387S7;
	Thu, 07 Nov 2024 15:30:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/5] Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent
Date: Fri,  8 Nov 2024 00:29:20 +0800
Message-Id: <20241107162920.208796-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241107162920.208796-1-shikemeng@huaweicloud.com>
References: <20241107162920.208796-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3Ha+BbCxnnlhABA--.55387S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UuF13JryrGFWxCFyfWFg_yoW8GrWkpF
	97C3s8Ka1xA3WUKrnFvan7t345Ja1kK3yjyr4xGwnayFZ8Gr1Yqay7tryjqFnxGFy8ZFy3
	Cr1Fg3y5Wa1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
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


