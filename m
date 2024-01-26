Return-Path: <linux-fsdevel+bounces-9057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E781883D9F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 13:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F73B27255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B11B598;
	Fri, 26 Jan 2024 12:10:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872E1B271;
	Fri, 26 Jan 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271003; cv=none; b=rnb3lMMwc1ZACARN7qPXMtBr4WTAtCBflp3ROvsu8NqleJT0jLyZ21JXhuwYBf1PbfSMCLfQ0M7SFfyYm4uxIwKKqu6XEzLpRZ4Xj67sZsjbPSCaCoBLvOE51LH5oKX34nXnpnHPKfP8jFNyA2nPruSijB1rIoEzriZDS8gJNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271003; c=relaxed/simple;
	bh=bmo8hdx2XN2jnQkYfiUcM0OdVvC/Lx4pWgkdqTlmTzc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCgdRM4VF5NZPk43b+MAB51HbwI8D6o7ej8aPEkqK82a2dUWnNaYZ8urvPnyqsaPXGU031cxE52uYjcg1KCKog4QnwD2ieVWchDehbksRbfTewUFA5U6HKMvcYCSk7YMVmdZngJ5xiYXptRg8pyRoLdpVzOWvYMYKiDWx+qtamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40QC8DtD080237;
	Fri, 26 Jan 2024 20:08:13 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TLx9965zGz2SSFGN;
	Fri, 26 Jan 2024 20:00:45 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 26 Jan 2024 20:08:05 +0800
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
Subject: [PATCHv4 1/1] block: introduce content activity based ioprio
Date: Fri, 26 Jan 2024 20:08:00 +0800
Message-ID: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40QC8DtD080237

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

This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
by changing the bio_add_page/folio API in ext4 and f2fs.

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
androbench has no improvment as well as regression which supposed to be
its test time is short which MGLRU hasn't take effect yet.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: calculate page's activity via helper function
change of v3: solve layer violation by move API into mm
change of v4: keep block clean by removing the page related API
change of v4: introduce the macros of bio_add_folio/page
---
---
 include/linux/act_ioprio.h  | 50 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ioprio.h | 38 ++++++++++++++++++++++++++++
 mm/Kconfig                  |  8 ++++++
 3 files changed, 96 insertions(+)
 create mode 100644 include/linux/act_ioprio.h

diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
new file mode 100644
index 000000000000..0794e25ad028
--- /dev/null
+++ b/include/linux/act_ioprio.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ACT_IOPRIO_H
+#define _ACT_IOPRIO_H
+
+#include <linux/bio.h>
+
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#define bio_add_folio(bio, folio, len, off)		\
+	({						\
+		int class, level, hint, activity;		\
+		bool ret;					\
+		ret = bio_add_folio(bio, folio, len, off);	\
+		if (ret) {					\
+			class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);	\
+			level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);	\
+			hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);	\
+			activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);		\
+			activity += (bio->bi_vcnt + 1 <= IOPRIO_NR_ACTIVITY &&		\
+				folio_test_workingset(folio)) ? 1 : 0;			\
+			if (activity >= bio->bi_vcnt / 2)			\
+				class = IOPRIO_CLASS_RT;			\
+			else if (activity >= bio->bi_vcnt / 4)			\
+				class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);	\
+			bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);	\
+		}											\
+		ret;											\
+	})
+
+#define bio_add_page(bio, page, len, offset)	\
+	({					\
+		int class, level, hint, activity;	\
+		int ret = 0;				\
+		ret = bio_add_page(bio, page, len, offset);		\
+		if (ret > 0) {						\
+			class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);	\
+			level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);	\
+			hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);	\
+			activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);		\
+			activity += (bio->bi_vcnt + 1 <= IOPRIO_NR_ACTIVITY &&		\
+				PageWorkingset(&folio->page)) ? 1 : 0;			\
+			if (activity >= bio->bi_vcnt / 2)			\
+				class = IOPRIO_CLASS_RT;			\
+			else if (activity >= bio->bi_vcnt / 4)			\
+				class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);	\
+			bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);	\
+		}											\
+		ret;											\
+	})
+#endif
+#endif
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..64cf5ff0ac5f 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -71,12 +71,24 @@ enum {
  * class and level.
  */
 #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#define IOPRIO_HINT_NR_BITS		3
+#else
 #define IOPRIO_HINT_NR_BITS		10
+#endif
 #define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
 #define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
 #define IOPRIO_PRIO_HINT(ioprio)	\
 	(((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
 
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#define IOPRIO_ACTIVITY_SHIFT		(IOPRIO_HINT_NR_BITS + IOPRIO_LEVEL_NR_BITS)
+#define IOPRIO_ACTIVITY_NR_BITS		7
+#define IOPRIO_NR_ACTIVITY		(1 << IOPRIO_ACTIVITY_NR_BITS)
+#define IOPRIO_ACTIVITY_MASK		(IOPRIO_NR_ACTIVITY - 1)
+#define IOPRIO_PRIO_ACTIVITY(ioprio)	\
+	(((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
+#endif
 /*
  * I/O hints.
  */
@@ -104,6 +116,7 @@ enum {
 
 #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >= (max))
 
+#ifndef CONFIG_CONTENT_ACT_BASED_IOPRIO
 /*
  * Return an I/O priority value based on a class, a level and a hint.
  */
@@ -123,5 +136,30 @@ static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
 	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
 #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
 	ioprio_value(prioclass, priolevel, priohint)
+#else
+/*
+ * Return an I/O priority value based on a class, a level, a hint and
+ * content's activities
+ */
+static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
+		int priohint, int activity)
+{
+	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
+			IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
+			IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
+			IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
+		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
 
+	return (prioclass << IOPRIO_CLASS_SHIFT) |
+		(activity << IOPRIO_ACTIVITY_SHIFT) |
+		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
+}
+
+#define IOPRIO_PRIO_VALUE(prioclass, priolevel)			\
+	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
+#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
+	ioprio_value(prioclass, priolevel, priohint, 0)
+#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint, activity)	\
+	ioprio_value(prioclass, priolevel, priohint, activity)
+#endif
 #endif /* _UAPI_LINUX_IOPRIO_H */
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


