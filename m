Return-Path: <linux-fsdevel+bounces-9637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8548843DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C228BFEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA2768F4;
	Wed, 31 Jan 2024 11:02:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EA6EB66;
	Wed, 31 Jan 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698949; cv=none; b=h5qGujd2l9uDxXfi0VVfvsZ6GfNRe18EHQ+bvedG2SqRXPRropQmAen+ywMJAhdPiM8/QIEzA/TtF+0gkD4Ipy3d8ACAol/sg77WY6lEdPbYA4bZcugBqTIJXODCIp8s3zjF7SYU+I19F1Kv6XtUFS+ywQuHF/fsAZ+7t00FjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698949; c=relaxed/simple;
	bh=GwdHJedowxMYfa/OQlb6Jxhq7XuL1egOIohA03EK7FY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvBhENWNsaiFRxdVXMuQv4B6gvwo6MuNxwG0pgGvrHtmC8GY1o5hHCULx55jnJ4ePHx5wlVMDwnHx8beEgBymcSe0FHvoNcTvuSxkfbS+HqhzjpDnrrlD8oRy442lz9sEaVl53SDutKLsrRQaAWcpLswxXKYom1SknHBWMKSTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40VAxH5X019223;
	Wed, 31 Jan 2024 18:59:17 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TPzP76bvWz2Shwd6;
	Wed, 31 Jan 2024 18:51:39 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jan 2024 18:59:14 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
        Damien Le
 Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Linus
 Walleij <linus.walleij@linaro.org>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv6 1/1] block: introduce content activity based ioprio
Date: Wed, 31 Jan 2024 18:59:12 +0800
Message-ID: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40VAxH5X019223

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, request's ioprio are set via task's schedule priority(when no
blkcg configured), which has high priority tasks possess the privilege on
both of CPU and IO scheduling.
This commit works as a hint of original policy by promoting the request ioprio
based on the page/folio's activity. The original idea comes from LRU_GEN
which provides more precised folio activity than before. This commit try
to adjust the request's ioprio when certain part of its folios are hot,
which indicate that this request carry important contents and need be
scheduled ealier.

This commit just provide the mechanism(a subsitution maro) which need to
be replaced by each fs for the file page's bio while keep others use the
legacy one.

This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
by changing the bio_add_page/folio API in erofs, ext4 and f2fs in
another commit.

Case 1:
script[a] which get significant improved fault time as expected[b]
where dd's cost also shrink from 55s to 40s.
(1). fault_latency.bin is an ebpf based test tool which measure all task's
   iowait latency during page fault when scheduled out/in.
(2). costmem generate page fault by mmaping a file and access the VA.
(3). dd generate concurrent vfs io.

[a]
./fault_latency.bin 1 5 > /data/dd_costmem &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
dd if=/dev/block/sda of=/data/ddtest bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest1 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest2 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest3 bs=1024 count=2048000
[b]
                       mainline		commit
io wait                836us            156us

Case 2:
fio -filename=/dev/block/by-name/userdata -rw=randread -direct=0 -bs=4k -size=2000M -numjobs=8 -group_reporting -name=mytest
mainline: 513MiB/s
READ: bw=531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=15.6GiB (16.8GB), run=30137-30137msec
READ: bw=543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=15.6GiB (16.8GB), run=29469-29469msec
READ: bw=474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=15.6GiB (16.8GB), run=33724-33724msec
READ: bw=535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=15.6GiB (16.8GB), run=29928-29928msec
READ: bw=523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=15.6GiB (16.8GB), run=30617-30617msec
READ: bw=492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=15.6GiB (16.8GB), run=32518-32518msec
READ: bw=533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=15.6GiB (16.8GB), run=29993-29993msec
READ: bw=524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=15.6GiB (16.8GB), run=30526-30526msec
READ: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=15.6GiB (16.8GB), run=30269-30269msec
READ: bw=449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=15.6GiB (16.8GB), run=35629-35629msec

commit: 633MiB/s
READ: bw=668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=15.6GiB (16.8GB), run=23952-23952msec
READ: bw=589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=15.6GiB (16.8GB), run=27164-27164msec
READ: bw=638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=15.6GiB (16.8GB), run=25071-25071msec
READ: bw=714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=15.6GiB (16.8GB), run=22409-22409msec
READ: bw=600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=15.6GiB (16.8GB), run=26669-26669msec
READ: bw=592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=15.6GiB (16.8GB), run=27036-27036msec
READ: bw=691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=15.6GiB (16.8GB), run=23150-23150msec
READ: bw=569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=15.6GiB (16.8GB), run=28142-28142msec
READ: bw=563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=15.6GiB (16.8GB), run=28429-28429msec
READ: bw=712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=15.6GiB (16.8GB), run=22478-22478msec

Case 3:
This commit is also verified by the case of launching camera APP which is
usually considered as heavy working load on both of memory and IO, which
shows 12%-24% improvement.

		ttl = 0		ttl = 50	ttl = 100
mainline        2267ms		2420ms		2316ms
commit          1992ms          1806ms          1998ms

case 4:
androbench has no improvment as well as regression in RD/WR test item
while make a 3% improvement in sqlite items.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: calculate page's activity via helper function
change of v3: solve layer violation by move API into mm
change of v4: keep block clean by removing the page related API
change of v5: introduce the macros of bio_add_folio/page for read dir.
change of v6: replace the macro of bio_add_xxx by submit_bio which
		iterating the bio_vec before launching bio to block layer
---
---
 include/linux/act_ioprio.h | 35 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                 |  8 ++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/linux/act_ioprio.h

diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
new file mode 100644
index 000000000000..797304acdabc
--- /dev/null
+++ b/include/linux/act_ioprio.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ACT_IOPRIO_H
+#define _ACT_IOPRIO_H
+
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#include <linux/bio.h>
+
+static __maybe_unused
+void act_submit_bio(struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	struct page *page;
+	int class, level, hint;
+	int activity = 0;
+	int cnt = 0;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	bio_for_each_bvec(bv, bio, iter) {
+		page = bv.bv_page;
+		activity += PageWorkingset(page) ? 1 : 0;
+		cnt++;
+	}
+	if (activity >= cnt / 2)
+		class = IOPRIO_CLASS_RT;
+	else if (activity >= cnt / 4)
+		class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_HINT(class, level, hint);
+	submit_bio(bio);
+}
+#define submit_bio(bio) act_submit_bio(bio)
+#endif
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..e0e5a5a44ded 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1240,6 +1240,14 @@ config LRU_GEN_STATS
 	  from evicted generations for debugging purpose.
 
 	  This option has a per-memcg and per-node memory overhead.
+
+config CONTENT_ACT_BASED_IOPRIO
+	bool "Enable content activity based ioprio"
+	depends on LRU_GEN
+	default n
+	help
+	  This item enable the feature of adjust bio's priority by
+	  calculating its content's activity.
 # }
 
 config ARCH_SUPPORTS_PER_VMA_LOCK
-- 
2.25.1


