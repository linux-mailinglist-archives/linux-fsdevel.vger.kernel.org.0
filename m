Return-Path: <linux-fsdevel+bounces-34223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881979C3EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA14284AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D661AB52B;
	Mon, 11 Nov 2024 12:55:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B019D8A0;
	Mon, 11 Nov 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329702; cv=none; b=FiMHOvgqF3CF5ecAcpBtl4PDPXRnmPSUxTE4y6MSgykXMCaMO3WkV3d10lYtpSzU348oZMFTCeM+WfnD5zeKyfxttpm2HCRs9IDPPQbN6A2dOQ7tEk5iFFLjizDcBlvhEFd+OdU6ZauAuoTrIt+iFUaAU1RxeS5iLAP5fUQ7p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329702; c=relaxed/simple;
	bh=SEq7DKLBNmA29ldzeeouDHYzH9koQTD4ZArvWUUL63Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7dhxWbvr8qIy68uU4PNOFmknecuDzp8Uz9pOuaf0CPz0VLK0oiWzwi88vVEb+jQSdMHhNLuDTpMGiRfZOOvobwsseB7oRRPr5eJIAyBNivCvRqqSh5zfAfQMpCJHPMyNeSBX4V5DE98DO1AmwtfYa+RPxQT1ygoGQFGfuKIDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xn8dV1lj2z4f3jJ1;
	Mon, 11 Nov 2024 20:54:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 664F31A018C;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4Oe_jFnllryBQ--.36628S3;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND V2 1/5] Xarray: Do not return sibling entries from xas_find_marked()
Date: Tue, 12 Nov 2024 05:53:55 +0800
Message-Id: <20241111215359.246937-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB3n4Oe_jFnllryBQ--.36628S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrArW8Xr4rWF17uw1xKrg_yoW8KF15pF
	W8Ga40gF4xtr4jyry0yayUXayF9wn8XFWFyay8Gr1SyFnxJ3W0yr4jkryDtF9rZrW5Zw43
	C3WFq345Za1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUswZ2
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Similar to issue fixed in commit cbc02854331ed ("XArray: Do not return
sibling entries from xa_load()"), we may return sibling entries from
xas_find_marked as following:
    Thread A:               Thread B:
                            xa_store_range(xa, entry, 6, 7, gfp);
			    xa_set_mark(xa, 6, mark)
    XA_STATE(xas, xa, 6);
    xas_find_marked(&xas, 7, mark);
    offset = xas_find_chunk(xas, advance, mark);
    [offset is 6 which points to a valid entry]
                            xa_store_range(xa, entry, 4, 7, gfp);
    entry = xa_entry(xa, node, 6);
    [entry is a sibling of 4]
    if (!xa_is_node(entry))
        return entry;

Skip sibling entry like xas_find() does to protect caller from seeing
sibling entry from xas_find_marked().

Besides, load_race() test is modified to catch mentioned issue and modified
load_race() only passes after this fix is merged.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c                          | 2 ++
 tools/testing/radix-tree/multiorder.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94c..fa87949719a0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1382,6 +1382,8 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 		entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
 		if (!entry && !(xa_track_free(xas->xa) && mark == XA_FREE_MARK))
 			continue;
+		if (xa_is_sibling(entry))
+			continue;
 		if (!xa_is_node(entry))
 			return entry;
 		xas->xa_node = xa_to_node(entry);
diff --git a/tools/testing/radix-tree/multiorder.c b/tools/testing/radix-tree/multiorder.c
index cffaf2245d4f..eaff1b036989 100644
--- a/tools/testing/radix-tree/multiorder.c
+++ b/tools/testing/radix-tree/multiorder.c
@@ -227,6 +227,7 @@ static void *load_creator(void *ptr)
 			unsigned long index = (3 << RADIX_TREE_MAP_SHIFT) -
 						(1 << order);
 			item_insert_order(tree, index, order);
+			xa_set_mark(tree, index, XA_MARK_1);
 			item_delete_rcu(tree, index);
 		}
 	}
@@ -242,8 +243,11 @@ static void *load_worker(void *ptr)
 
 	rcu_register_thread();
 	while (!stop_iteration) {
+		unsigned long find_index = (2 << RADIX_TREE_MAP_SHIFT) + 1;
 		struct item *item = xa_load(ptr, index);
 		assert(!xa_is_internal(item));
+		item = xa_find(ptr, &find_index, index, XA_MARK_1);
+		assert(!xa_is_internal(item));
 	}
 	rcu_unregister_thread();
 
-- 
2.30.0


