Return-Path: <linux-fsdevel+bounces-17375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888DC8AC5FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF08281645
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320E4DA0C;
	Mon, 22 Apr 2024 07:52:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D34CE13;
	Mon, 22 Apr 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772369; cv=none; b=dTK7rgJ/eF1k6fRoy016f0VEJdD6/J0frF3wR57yKQAykE9UScD4CWYXkGCWCs+tySQMBri5HvJ4IuqqHbUUZiZGc7c8Bd9UXUGrhN71HG6efzrvkCvBKThPCq74Yb6/uPKDLiIE5+YwEcZ+0//mZIC73i4aBI08u9t7W5eK/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772369; c=relaxed/simple;
	bh=K+yBo92cD+lAgXA7FM1xxyn1BRBfLeWbO92MCJtjobI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQ9w8W/AA0cw3S9BniiCjve5WU5sMX9tLsJcXVYpnY4ldHaddRUqojToGAAy9LZqpzGVnuXMiO5yiEOAGlJEmZNsL2LXkrpHxlKlZ0+WzVTmIcZLizs1mph+w6pwfUSTdRk7ltNxFfs8g934w5F9dUy7slfwCMGerMwEG3CSMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNHXk2MGqz4f3jqr;
	Mon, 22 Apr 2024 15:52:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1EBED1A016E;
	Mon, 22 Apr 2024 15:52:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCHqg1JFyZmCViLKw--.3978S2;
	Mon, 22 Apr 2024 15:52:42 +0800 (CST)
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
Subject: [PATCH v4 0/4] Improve visibility of writeback
Date: Tue, 23 Apr 2024 00:48:04 +0800
Message-Id: <20240422164808.13627-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHqg1JFyZmCViLKw--.3978S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5ur1UAF43ZrWUAw47urg_yoW5KryDpF
	Z5Jw15Kr1UZw1xCFn3Ca42gry5K3y8Ja47Xr9xZrW2qwn0qryDtr95Wa48Ary5C3s3AFy3
	JFsxZry8Gr4v9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0VBT5UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v3->v4:
-Fix build warning that filepages, headroom and writeback in
cgwb_calc_thresh is used uninitialized when CONFIG_CGROUP_WRITEBACK
is not enabled.

v2->v3:
-Drop patches to protect non-exist race and to define GDTC_INIT_NO_WB to
null.
-Add wb_tryget to wb from which we collect stats to bdi stats.
-Create wb_stats when CONFIG_CGROUP_WRITEBACK is not enabled.
-Add a blank line between two wb stats in wb_stats.

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
info. Patch 3 add wb_monitor.py to monitor basic writeback info
of running system, more info could be added on demand. Patch 4
is a random cleanup. More details can be found in respective
patches. Thanks!

Following domain hierarchy is tested:
                global domain (320G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2

/* all writeback info of bdi is successfully collected */
cat stats
BdiWriteback:             4704 kB
BdiReclaimable:        1294496 kB
BdiDirtyThresh:      204208088 kB
DirtyThresh:         195259944 kB
BackgroundThresh:     32503588 kB
BdiDirtied:           48519296 kB
BdiWritten:           47225696 kB
BdiWriteBandwidth:     1173892 kBps
b_dirty:                     1
b_io:                        0
b_more_io:                   1
b_dirty_time:                0
bdi_list:                    1
state:                       1

/* per wb writeback info of bdi is collected */
cat /sys/kernel/debug/bdi/252:16/wb_stats
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

WbCgIno:                 4208
WbWriteback:            59808 kB
WbReclaimable:         676480 kB
WbDirtyThresh:        6004624 kB
WbDirtied:           23348192 kB
WbWritten:           22614592 kB
WbWriteBandwidth:      593204 kBps
b_dirty:                    1
b_io:                       1
b_more_io:                  0
b_dirty_time:               0
state:                      7

WbCgIno:                 4249
WbWriteback:           144256 kB
WbReclaimable:         432096 kB
WbDirtyThresh:        6004344 kB
WbDirtied:           25727744 kB
WbWritten:           25154752 kB
WbWriteBandwidth:      577904 kBps
b_dirty:                    0
b_io:                       1
b_more_io:                  0
b_dirty_time:               0
state:                      7

The wb_monitor.py script output is as following:
./wb_monitor.py 252:16 -c
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

Kemeng Shi (4):
  writeback: collect stats of all wb of bdi in bdi_debug_stats_show
  writeback: support retrieving per group debug writeback stats of bdi
  writeback: add wb_monitor.py script to monitor writeback info on bdi
  writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages

 include/linux/writeback.h     |   1 +
 mm/backing-dev.c              | 174 +++++++++++++++++++++++++++++-----
 mm/page-writeback.c           |  27 +++++-
 tools/writeback/wb_monitor.py | 172 +++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+), 29 deletions(-)
 create mode 100644 tools/writeback/wb_monitor.py

-- 
2.30.0


