Return-Path: <linux-fsdevel+bounces-15383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0388D6F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B48D29F104
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6C2D045;
	Wed, 27 Mar 2024 07:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCD23769;
	Wed, 27 Mar 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522915; cv=none; b=PQxagzAG8ISpW2AAiSzUFB73xxQjEqCsyuLBdUUIDMoi5SgS3O3i2jpNXKVskwnrOuziTymLYcS7ntlfDnkB37/5xp+Cs/IjaMMZ/ES6sCjpEIrS8MRatGJ9DIlN+1gYts+GS4kiaH8Z1V+Czr0PY3uAt4tYln5Xml6sq3ZaoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522915; c=relaxed/simple;
	bh=CkC3VNLiVGQTPsZ5+M78GJ0AAg2gKmLXE4XsXtjV3lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxPbFlAD2TEEMIjD+y3AkgEFP8uL9+wxOWoYdloPmV/krzJem1KADjoGqxlQEt5aiO6K26/Jg+tE2XZEs6yeGOtdgql9q8RwtUsc9jW85oqT5VwaswQmeGrkrwjNiJYUfUKDtvoDASOP4C3l1jvS3nvb6LjGky5bRhnKZEXAVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4Hdz0jtPz4f3kJr;
	Wed, 27 Mar 2024 15:01:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 252BF1A016E;
	Wed, 27 Mar 2024 15:01:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxYxANmi6+LIQ--.50310S2;
	Wed, 27 Mar 2024 15:01:45 +0800 (CST)
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
Subject: [PATCH v2 0/6] Improve visibility of writeback
Date: Wed, 27 Mar 2024 23:57:45 +0800
Message-Id: <20240327155751.3536-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQxYxANmi6+LIQ--.50310S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4DGFWDKFy7Ary3Xr4kCrg_yoW5tF18pF
	Z5Aw15tr4UAw1xCr93Ca42gryrtw48ta47XrZrZrW2vrn0gr1UtF95Wa4rAr15Gr9xJFy3
	JFsxZry0gr4vqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUIf-PUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Send cleanup to wq_monitor.py separately.
-Add patch to avoid use after free of bdi.
-Rename wb_calc_cg_thresh to cgwb_calc_thresh as Tejun suggested.
-Use rcu walk to avoid use after free.
-Add debug output to each related patches.

This series tries to improve visilibity of writeback. Patch 1 make
/sys/kernel/debug/bdi/xxx/stats show writeback info of whole bdi
instead of only writeback info in root cgroup. Patch 2 add a new
debug file /sys/kernel/debug/bdi/xxx/wb_stats to show per wb writeback
info. Patch 4 add wb_monitor.py to monitor basic writeback info
of running system, more info could be added on demand. Rest patches
are some random cleanups. More details can be found in respective
patches. Thanks!
This series is on top of patchset [1].

[1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76

Following domain hierarchy is tested:
                global domain (320G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2

/* all writeback info of bdi is successfully collected */
# cat /sys/kernel/debug/bdi/252:16/stats:
BdiWriteback:              448 kB
BdiReclaimable:        1303904 kB
BdiDirtyThresh:      189914124 kB
DirtyThresh:         195337564 kB
BackgroundThresh:     32516508 kB
BdiDirtied:            3591392 kB
BdiWritten:            2287488 kB
BdiWriteBandwidth:      322248 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   2
b_dirty_time:                0
bdi_list:                    1
state:                       1

/* per wb writeback info is collected */
# cat /sys/kernel/debug/bdi/252:16/wb_stats:
cat wb_stats
WbCgIno:                    1
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1
WbCgIno:                 4284
WbWriteback:              448 kB
WbReclaimable:         818944 kB
WbDirtyThresh:        3096524 kB
WbDirtied:            2266880 kB
WbWritten:            1447936 kB
WbWriteBandwidth:      214036 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  1
b_dirty_time:               0
state:                      5
WbCgIno:                 4325
WbWriteback:              224 kB
WbReclaimable:         819392 kB
WbDirtyThresh:        2920088 kB
WbDirtied:            2551808 kB
WbWritten:            1732416 kB
WbWriteBandwidth:      201832 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  1
b_dirty_time:               0
state:                      5

/* monitor writeback info */
# ./wb_monitor.py 252:16 -c
                  writeback  reclaimable   dirtied   written    avg_bw
252:16_1                  0            0         0         0    102400
252:16_4284             672       820064   9230368   8410304    685612
252:16_4325             896       819840  10491264   9671648    652348
252:16                 1568      1639904  19721632  18081952   1440360


                  writeback  reclaimable   dirtied   written    avg_bw
252:16_1                  0            0         0         0    102400
252:16_4284             672       820064   9230368   8410304    685612
252:16_4325             896       819840  10491264   9671648    652348
252:16                 1568      1639904  19721632  18081952   1440360
...

Kemeng Shi (6):
  writeback: protect race between bdi release and bdi_debug_stats_show
  writeback: collect stats of all wb of bdi in bdi_debug_stats_show
  writeback: support retrieving per group debug writeback stats of bdi
  writeback: add wb_monitor.py script to monitor writeback info on bdi
  writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages
  writeback: define GDTC_INIT_NO_WB to null

 include/linux/writeback.h     |   1 +
 mm/backing-dev.c              | 203 ++++++++++++++++++++++++++++++----
 mm/page-writeback.c           |  31 ++++--
 tools/writeback/wb_monitor.py | 172 ++++++++++++++++++++++++++++
 4 files changed, 378 insertions(+), 29 deletions(-)
 create mode 100644 tools/writeback/wb_monitor.py

-- 
2.30.0


