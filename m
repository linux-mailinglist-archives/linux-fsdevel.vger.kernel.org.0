Return-Path: <linux-fsdevel+bounces-17453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E288ADC65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06C6B2184F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB31D531;
	Tue, 23 Apr 2024 03:46:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503471C2AD;
	Tue, 23 Apr 2024 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844012; cv=none; b=DtFbFroFsD+PdOFkGxt2PZPueHpjjTlH1LvNEiGERMEbXA2Ri+QDaYgP7dQ8OWKgKaCYoCzUaiO2Wf6nnbaanDjvztaJN+AiEEZyrOd0q7wfDowv6cbGp1AVROg556IRyB9iGiAsLoOKEey4WkE2YL6TXh15fR62kQDqQ8+QVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844012; c=relaxed/simple;
	bh=Oyn7Q/Z8KOp/GJK2P/SS60hLeCHJaTrxuzeGkcub8ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2Uk+6O8fXzOIIQssxv239/pJeJP154RqolkD5vW+ZC4DHWaokmpygLIah1iOf94A7/Dc1AqUZiNqF3BenaJv/aZw0AfOCC3logrgWaf4BtTseEeRtwAP/Ny+Gima4oglZsWSqaQQTBpI43zb/gj/z3ql+xHPLOZ5PYzZBQZQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNp2V2Rbpz4f3kpB;
	Tue, 23 Apr 2024 11:46:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 283661A016E;
	Tue, 23 Apr 2024 11:46:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgA3Ww4kLydmKkDYKw--.11241S5;
	Tue, 23 Apr 2024 11:46:46 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	bfoster@redhat.com,
	tj@kernel.org
Cc: dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 3/5] writeback: fix build problems of "writeback: support retrieving per group debug writeback stats of bdi"
Date: Tue, 23 Apr 2024 11:46:41 +0800
Message-Id: <20240423034643.141219-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423034643.141219-1-shikemeng@huaweicloud.com>
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3Ww4kLydmKkDYKw--.11241S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13JrWUWryrCFy8Cw47twb_yoW8WF43p3
	W3Gw40kw1UZF9FgFZxCayUWr98tw45ta47XFyDArW3t3WFqrnrGFyfGay8Zry7ZF93Jay3
	ZanYvryxJrZFyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Fix two build problems:
1. implicit declaration of function 'cgroup_ino'.
2. unused variable 'stats'.

After this fix, No build problem is found when CGROUPS is disabled.
The wb_stats could be successfully retrieved when CGROUP_WRITEBACK is
disabled:
cat wb_stats
WbCgIno:                    1
WbWriteback:                0 kB
WbReclaimable:         685440 kB
WbDirtyThresh:      195530960 kB
WbDirtied:             691488 kB
WbWritten:               6048 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    2
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

cat wb_stats
WbCgIno:                    1
WbWriteback:                0 kB
WbReclaimable:         818944 kB
WbDirtyThresh:      195527484 kB
WbDirtied:             824992 kB
WbWritten:               6048 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    2
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/backing-dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 6ecd11bdce6e..e61bbb1bd622 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -172,7 +172,11 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 		   "b_more_io:         %10lu\n"
 		   "b_dirty_time:      %10lu\n"
 		   "state:             %10lx\n\n",
+#ifdef CONFIG_CGROUP_WRITEBACK
 		   cgroup_ino(wb->memcg_css->cgroup),
+#else
+		   1ul,
+#endif
 		   K(stats->nr_writeback),
 		   K(stats->nr_reclaimable),
 		   K(stats->wb_thresh),
@@ -192,7 +196,6 @@ static int cgwb_debug_stats_show(struct seq_file *m, void *v)
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	struct bdi_writeback *wb;
-	struct wb_stats stats;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
 
-- 
2.30.0


