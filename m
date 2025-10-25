Return-Path: <linux-fsdevel+bounces-65613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164DC089EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BA3BF1E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063852D6E5E;
	Sat, 25 Oct 2025 03:30:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2632C21D6;
	Sat, 25 Oct 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363015; cv=none; b=jVIy3JJlEm8OZtOZoRJp2W800SVzsDEBI8S7C8zUPK3JR9Lv+WSol//wr8T7roYzlvB7vt1GT8VYi9GBlAuDb9fIjYWu5rn9vq4GJnmCX3pFYrpOdYS41L3RPFmcvu0dchjM+w9MJGqi7rumFY2TY+GmJtDdP73YnXfrLPVbRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363015; c=relaxed/simple;
	bh=PZ0EZ1AQ4o8AyWlggtCntEpasjI9LjS9W3ettl6IstY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPEcYmOaAaue9Njql/AhfRbMN9je2qWWn2Sts86Gwpdww3TbBZPvowyEzy+wQxg6pSIovytR5GPWyoQSoQMjPGhMp+g74KLGlEyWgeltUTjkKlmAi03/kV8+oXO16h8L8whFIcnWtHnAn+y3LvKmhbMxnkHQAephWhK89Tj4mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT3Sp9zKHMQB;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 301BC1A1B4E;
	Sat, 25 Oct 2025 11:30:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S27;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 23/25] jbd2: prevent WARN_ON in __alloc_pages_slowpath() when BS > PS
Date: Sat, 25 Oct 2025 11:22:19 +0800
Message-Id: <20251025032221.2905818-24-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S27
X-Coremail-Antispam: 1UD129KBjvJXoWxJrykCF4fGr47trW3AryDtrb_yoW8Ar45pF
	WfK3WSkFWrZry7ta13A3Z0va43Wws5Ga18GF97Z345Zw45Ar90kr1ftFy5JF1jyFW8Wayr
	CFsavw4fGrnIvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJIwABsV

From: Baokun Li <libaokun1@huawei.com>

In __alloc_pages_slowpath(), allocating page units larger than order-1
with __GFP_NOFAIL may trigger an unexpected WARN_ON. To prevent this,
handle the case explicitly in jbd2_alloc(), ensuring that the warning
does not occur after enabling BS > PS support.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..9185f9e2b201 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2761,14 +2761,36 @@ static struct kmem_cache *get_slab(size_t size)
 void *jbd2_alloc(size_t size, gfp_t flags)
 {
 	void *ptr;
+	int order;
 
 	BUG_ON(size & (size-1)); /* Must be a power of 2 */
 
-	if (size < PAGE_SIZE)
+	if (size < PAGE_SIZE) {
 		ptr = kmem_cache_alloc(get_slab(size), flags);
-	else
-		ptr = (void *)__get_free_pages(flags, get_order(size));
+		goto out;
+	}
+
+	/*
+	 * Allocating page units greater than order-1 with __GFP_NOFAIL in
+	 * __alloc_pages_slowpath() can trigger an unexpected WARN_ON.
+	 * Handle this case separately to suppress the warning.
+	 */
+	order = get_order(size);
+	if (order <= 1) {
+		ptr = (void *)__get_free_pages(flags, order);
+		goto out;
+	}
 
+	while (1) {
+		ptr = (void *)__get_free_pages(flags & ~__GFP_NOFAIL, order);
+		if (ptr)
+			break;
+		if (!(flags & __GFP_NOFAIL))
+			break;
+		memalloc_retry_wait(flags);
+	}
+
+out:
 	/* Check alignment; SLUB has gotten this wrong in the past,
 	 * and this can lead to user data corruption! */
 	BUG_ON(((unsigned long) ptr) & (size-1));
-- 
2.46.1


