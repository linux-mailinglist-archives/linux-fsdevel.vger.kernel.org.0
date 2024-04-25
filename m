Return-Path: <linux-fsdevel+bounces-17765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD718B2267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1605BB26F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F858149DED;
	Thu, 25 Apr 2024 13:17:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088D149C43;
	Thu, 25 Apr 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051052; cv=none; b=i9oLm9a5W05AMtpAXlgulUgPbqblU1MMez21IX64Wz2Cxz7qdbzST6Uq7ilXn8VOIRzC+tmWHMZYCpWAjeC+5PLdnQKTcH/EuaHCkPx6Shd+wPtwcfHrmuiV1uEAqvRMklv+ffKh2m3lleT38XDt8J6LDnGAC/HlE9izxDBNDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051052; c=relaxed/simple;
	bh=ad+FmBznYdhSoqpHmRBLx6Z+itP7k9cDQBCrii+GBQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvaIiHyd8LLl0DriLWYIxXGlFgz6qNnNf3MbkVrh/CqVEySpoEHwSfqqo1NxJryQjjqIB2WzlBIIAJT4pqlXuLU7kDrRwXztNH3EqdDnRU4Hg9+tiy5W3C229sKWae05jBwmRG3HHfd+doClH2NGvDwt5do5376ksbhU1K66tN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGbx5b5dz4f3n6l;
	Thu, 25 Apr 2024 21:17:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0B3FD1A0568;
	Thu, 25 Apr 2024 21:17:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgA3+J_kVypmFDcOKw--.42283S4;
	Thu, 25 Apr 2024 21:17:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	jack@suse.cz,
	hcochran@kernelspring.com,
	axboe@kernel.dk,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mm: correct calculation of wb's bg_thresh in cgroup domain
Date: Thu, 25 Apr 2024 21:17:22 +0800
Message-Id: <20240425131724.36778-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240425131724.36778-1-shikemeng@huaweicloud.com>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3+J_kVypmFDcOKw--.42283S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy5Zr13Wry7tF1DXw4kCrg_yoW5Gw13pF
	WkGr1jvr4UJF1xtrsxKa4qgryfta1rtFW7XFZxJw17tw13Gr18Kr17CFWqgFW8AF13J345
	ZFs8C397Xr1Dtw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2GYLDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The wb_calc_thresh is supposed to calculate wb's share of bg_thresh in
global domain. To calculate wb's share of bg_thresh in cgroup domain,
it's more reasonable to use __wb_calc_thresh in which way we calculate
dirty_thresh in cgroup domain in balance_dirty_pages().

Consider following domain hierarchy:
                global domain (> 20G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2
Assume wb1 and wb2 has the same bandwidth.
We have global domain bg_thresh > 2G, cgroup domain bg_thresh 1G.
Then we have:
wb's thresh in global domain = 2G * (wb bandwidth) / (system bandwidth)
= 2G * 1/2 = 1G
wb's thresh in cgroup domain = 1G * (wb bandwidth) / (system bandwidth)
= 1G * 1/2 = 0.5G
At last, wb1 and wb2 will be limited at 0.5G, the system will be limited
at 1G which is less than global domain bg_thresh 2G.

Test as following:
/* make it easier to observe the issue */
echo 300000 > /proc/sys/vm/dirty_expire_centisecs
echo 100 > /proc/sys/vm/dirty_writeback_centisecs

/* run fio in wb1 */
cd /sys/fs/cgroup
echo "+memory +io" > cgroup.subtree_control
mkdir group1
cd group1
echo 10G > memory.high
echo 10G > memory.max
echo $$ > cgroup.procs
mkfs.ext4 -F /dev/vdb
mount /dev/vdb /bdi1/
fio -name test -filename=/bdi1/file -size=600M -ioengine=libaio -bs=4K \
-iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0

/* run fio in wb2 with a new shell */
cd /sys/fs/cgroup
mkdir group2
cd group2
echo 10G > memory.high
echo 10G > memory.max
echo $$ > cgroup.procs
mkfs.ext4 -F /dev/vdc
mount /dev/vdc /bdi2/
fio -name test -filename=/bdi2/file -size=600M -ioengine=libaio -bs=4K \
-iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0

Before fix, the wrttien pages of wb1 and wb2 reported from
toos/writeback/wb_monitor.py keep growing. After fix, rare written pages
are accumulated.
There is no obvious change in fio result.

Fixes: 74d369443325 ("writeback: Fix performance regression in wb_over_bg_thresh()")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2a3b68aae336..14893b20d38c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2137,7 +2137,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 		if (mdtc->dirty > mdtc->bg_thresh)
 			return true;
 
-		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
+		thresh = __wb_calc_thresh(mdtc, mdtc->bg_thresh);
 		if (thresh < 2 * wb_stat_error())
 			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
 		else
-- 
2.30.0


