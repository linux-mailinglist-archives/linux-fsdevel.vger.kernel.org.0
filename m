Return-Path: <linux-fsdevel+bounces-41636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7804A3390A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4D1885300
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53944208984;
	Thu, 13 Feb 2025 07:40:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24F12BF24;
	Thu, 13 Feb 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432430; cv=none; b=uHOSq6JbnRRDvTsiUQJHq67qbhQByWKr1NF1R6YP07VvZrYI2XAPsSxo8NOa9xqYzZzlq1Ru/9GOpfmHAi90mMR0TbQ1EOAjwfECWKxpnhMzzBDILmzHVJHXA7yoEy4pFU8pS6ACxXl0ML3fr+OrfndXI/fW0p3ZCt9wV1laD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432430; c=relaxed/simple;
	bh=LCaCKoBbqnfW10Dhp71lZqFMwhbW5s29S+SnKD/4N9g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GAN6UTiB6LPNUoc7eXwATQLtR1tXTI6lavtxt15FU5MPuMVMOY2tXWBV/htgVEov+h3A4Rgou7YNjECYs2IxHZ8XG++kHdBNtkGJ6pz2GUNuxuibQYRPaTkKn8o8v3kJbBfdFtVnLoQRtSj6XW0zynwepLILLZyOC3lRtgSJFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YtnCB75MZz4f3jt0;
	Thu, 13 Feb 2025 15:40:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 192EB1A0838;
	Thu, 13 Feb 2025 15:40:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgDnpGfloa1nx+vHDg--.7502S2;
	Thu, 13 Feb 2025 15:40:22 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	geert@linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] test_xarray: fix failure in check_pause when CONFIG_XARRAY_MULTI is not defined
Date: Fri, 14 Feb 2025 00:36:59 +0800
Message-Id: <20250213163659.414309-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnpGfloa1nx+vHDg--.7502S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47tFyktFykZr1DuF17KFg_yoW8uFyfpF
	W7Wa4Ivry8Jrn2yw1DAa1xu34Fgw1rWa13KrW5Gr10yF9xur12yw1UKFyqvr9rCFW0vay5
	AanYgrnFganrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAa
	w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	jSYL9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In case CONFIG_XARRAY_MULTI is not defined, xa_store_order can store a
multi-index entry but xas_for_each can't tell sbiling entry from valid
entry. So the check_pause failed when we store a multi-index entry and
wish xas_for_each can handle it normally. Avoid to store multi-index
entry when CONFIG_XARRAY_MULTI is disabled to fix the failure.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/test_xarray.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 6932a26f4927..0e865bab4a10 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1418,7 +1418,7 @@ static noinline void check_pause(struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
 	void *entry;
-	unsigned int order;
+	int order;
 	unsigned long index = 1;
 	unsigned int count = 0;
 
@@ -1450,7 +1450,7 @@ static noinline void check_pause(struct xarray *xa)
 	xa_destroy(xa);
 
 	index = 0;
-	for (order = XA_CHUNK_SHIFT; order > 0; order--) {
+	for (order = order_limit - 1; order >= 0; order--) {
 		XA_BUG_ON(xa, xa_store_order(xa, index, order,
 					xa_mk_index(index), GFP_KERNEL));
 		index += 1UL << order;
@@ -1462,24 +1462,25 @@ static noinline void check_pause(struct xarray *xa)
 	rcu_read_lock();
 	xas_for_each(&xas, entry, ULONG_MAX) {
 		XA_BUG_ON(xa, entry != xa_mk_index(index));
-		index += 1UL << (XA_CHUNK_SHIFT - count);
+		index += 1UL << (order_limit - count - 1);
 		count++;
 	}
 	rcu_read_unlock();
-	XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
+	XA_BUG_ON(xa, count != order_limit);
 
 	index = 0;
 	count = 0;
-	xas_set(&xas, XA_CHUNK_SIZE / 2 + 1);
+	/* test unaligned index */
+	xas_set(&xas, 1 % (1UL << (order_limit - 1)));
 	rcu_read_lock();
 	xas_for_each(&xas, entry, ULONG_MAX) {
 		XA_BUG_ON(xa, entry != xa_mk_index(index));
-		index += 1UL << (XA_CHUNK_SHIFT - count);
+		index += 1UL << (order_limit - count - 1);
 		count++;
 		xas_pause(&xas);
 	}
 	rcu_read_unlock();
-	XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
+	XA_BUG_ON(xa, count != order_limit);
 
 	xa_destroy(xa);
 
-- 
2.30.0


