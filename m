Return-Path: <linux-fsdevel+bounces-50738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46019ACF02B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59284178DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334123C51B;
	Thu,  5 Jun 2025 13:17:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E75230D35;
	Thu,  5 Jun 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129429; cv=none; b=SmveJKKGBm1LJqtLZBLwnMcb+APLSOg4u1Ih85xQ9H0qNKiBNX6AJIs+1/WMC1/XjshcIQHQd+NJgpuacjNz77XzCufRvzoI45tz5XClU9hJZBMlK97tbuIuLmbBnI6JVUy/xTAxkrPRrwx+puQcI1dUrHyK8qNN23g9Chbh2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129429; c=relaxed/simple;
	bh=5Cz93IxqRdgLk6dXKax3WOl99BnT6SF31MyUBLILXUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHz9E18qLTurIXcf38C6843vOHVdz+pXX0Nb4sNkL1WoAmSdHMV4UbrAJU8+UgHqAHOde1x0n4dCxluyx2M9POzeqXvti+lG1lEsP4INdwdqr/OeNW6H/pUpb1SswkvzXzMYClaoxyJqFa4T8VhkWqfNLR6I/LyAYpmZpXG3Ws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bClNF0cTjzKHNGR;
	Thu,  5 Jun 2025 21:17:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 70FCA1A09DF;
	Thu,  5 Jun 2025 21:16:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S8;
	Thu, 05 Jun 2025 21:16:59 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] mm: shmem: simplify error flow in thpsize_shmem_enabled_store()
Date: Fri,  6 Jun 2025 06:10:36 +0800
Message-Id: <20250605221037.7872-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250605221037.7872-1-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S8
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4fKrWkJF4UWw1Dtr1UJrb_yoWDtFc_CF
	yjqF9rWr47Ww4kKF1Ykw42qr9YgFWDuryqgry8tFWak34DXrZ7Jr4DXrWYvryxXayrWF95
	Canavasagw1DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
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

Simplify error flow in thpsize_shmem_enabled_store().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/shmem.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e3e05bbb6db2..c6ea45d542d2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5601,7 +5601,7 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
 					   const char *buf, size_t count)
 {
 	int order = to_thpsize(kobj)->order;
-	ssize_t ret = count;
+	int err;
 
 	if (sysfs_streq(buf, "always")) {
 		spin_lock(&huge_shmem_orders_lock);
@@ -5644,16 +5644,14 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
 		clear_bit(order, &huge_shmem_orders_madvise);
 		spin_unlock(&huge_shmem_orders_lock);
 	} else {
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
-	if (ret > 0) {
-		int err = start_stop_khugepaged();
+	err = start_stop_khugepaged();
+	if (err)
+		return err;
 
-		if (err)
-			ret = err;
-	}
-	return ret;
+	return count;
 }
 
 struct kobj_attribute thpsize_shmem_enabled_attr =
-- 
2.30.0


