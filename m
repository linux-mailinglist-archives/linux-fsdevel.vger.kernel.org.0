Return-Path: <linux-fsdevel+bounces-53474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B7AEF648
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C761BC837B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB123BD02;
	Tue,  1 Jul 2025 11:15:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74A8821;
	Tue,  1 Jul 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368553; cv=none; b=aElERXsC9AToqVQP8y4Gs5EGTKFRXPJrYRSIy/jFpZ64A9V+MpHNvHUXW6p3NBziV3qMpbInJAQW8B++BQLO0OPSyn2LsrVktikwUvQG5e5awU/V60H/gKyC4HWhBeJoqHe/66Pd78WJmR9B3hSz/mE0F7z/vTS2+3Vcazu0feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368553; c=relaxed/simple;
	bh=sIHLF/03qzznOY1kF3mGCrsDOoVA3PeIx2kY/q8U6zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5rMu9JAb6QCta5tYfJolPL3tPXVKqKjg0BalOHjy0kS/Jei2J7rsp0V7kEodbjBPJIUxy9VkVPXrV8fyM5Sq7ZCED69LxGUnkkfbgu6204CTDK/RZ0gt/1Nd4zsncreCOvR6AurNMCIObk5w9/gBu60MHwjrJdZJVYkC6gPWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bWgSH5QX1zKHMtp;
	Tue,  1 Jul 2025 19:15:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 295331A0F0F;
	Tue,  1 Jul 2025 19:15:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyRcw2NouS89AQ--.19855S4;
	Tue, 01 Jul 2025 19:15:41 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC] mm/readahead: improve randread performance with readahead disabled
Date: Tue,  1 Jul 2025 19:08:34 +0800
Message-Id: <20250701110834.3237307-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyRcw2NouS89AQ--.19855S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rWF18CrykCF47CFyUJrb_yoW8CF1fpr
	W3CF4xtr18XryrZrWxJa4UXr4fKFs3ZF4fJFy3J345Aw13Gr4akr97Xw4UuFW0yr1xXay2
	9r4DZF9xZr4jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

We have a workload of random 4k-128k read on a HDD, from iostat we observed
that average request size is 256k+ and bandwidth is 100MB+, this is because
readahead waste lots of disk bandwidth. Hence we disable readahead and
performance from user side is indeed much better(2x+), however, from
iostat we observed request size is just 4k and bandwidth is just around
40MB.

Then we do a simple dd test and found out if readahead is disabled,
page_cache_sync_ra() will force to read one page at a time, and this
really doesn't make sense because we can just issue user requested size
request to disk.

Fix this problem by removing the limit to read one page at a time from
page_cache_sync_ra(), this way the random read workload can get better
performance with readahead disabled.

PS: I'm not sure if I miss anything, so this version is RFC
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 mm/readahead.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 20d36d6b055e..1df85ccba575 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -561,13 +561,21 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
 	 * readahead will do the right thing and limit the read to just the
-	 * requested range, which we'll set to 1 page for this case.
+	 * requested range.
 	 */
-	if (!ra->ra_pages || blk_cgroup_congested()) {
+	if (blk_cgroup_congested()) {
 		if (!ractl->file)
 			return;
+		/*
+		 * If the cgroup is congested, ensure to do at least 1 page of
+		 * readahead to make progress on the read.
+		 */
 		req_count = 1;
 		do_forced_ra = true;
+	} else if (!ra->ra_pages) {
+		if (!ractl->file)
+			return;
+		do_forced_ra = true;
 	}
 
 	/* be dumb */
-- 
2.39.2


