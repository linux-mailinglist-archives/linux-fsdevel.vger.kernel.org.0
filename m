Return-Path: <linux-fsdevel+bounces-17457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A988ADC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0C1F21D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB6225A2;
	Tue, 23 Apr 2024 03:46:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C118E1D;
	Tue, 23 Apr 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844013; cv=none; b=lHsXJHFA9cvUvA43aeP0G5oAgysAmBwev6KVdX0DsiCK0rrZ3uvTqi6pX8bbEUzV3W2joHm2CyxdiCtco6FzZvygV6V+B9T9l1PQpSeSIIT+E7gT7yMTfb74Uw5j98sYXOZhUq45yIy2KTabZlQS8ytVaLvj7QVr19PmQso8gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844013; c=relaxed/simple;
	bh=u6Vp1WdZoqKLc2edQMi9qKEIPFcXRKLys3K5tccU18s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOBY7v1N5OVWhIrBWBA7wXzTu4ix2VKNFojCFtef/Q3r61ZCEEkOhWFh4bqYNmCEhivVQ2/qExjkrn862gVhUBLD273Kopvc6dxHhtcKD9qHS0I/+HeQU8qDBHJakiEm5+FfLwqwYidO3c2X7Z8TY5kXNHIAtq1iuYScEvdQpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNp2N4xp5z4f3nTj;
	Tue, 23 Apr 2024 11:46:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CE1121A0572;
	Tue, 23 Apr 2024 11:46:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgA3Ww4kLydmKkDYKw--.11241S2;
	Tue, 23 Apr 2024 11:46:45 +0800 (CST)
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
Subject: [PATCH v5 0/5] Improve visibility of writeback
Date: Tue, 23 Apr 2024 11:46:38 +0800
Message-Id: <20240423034643.141219-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3Ww4kLydmKkDYKw--.11241S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5ur1UAF43ZrWUAw47urg_yoWrXr4fpF
	Z5Jw15tr4UZ3WxCFn3Ca42gry5Kw48J347Xr9xZrW293Z0qr1Dtr95Wa45AryUCwn3Ary7
	JFsxZry8Gr4vgaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v4->v5:
-Add new patch to fix build problem of "writeback: support retrieving
per group debug writeback stats of bdi". The new fix patch can be folded
into it's pre-patch if the pre-patch is not merge into tree or it could
be pick-up to apply.

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


Kemeng Shi (5):
  writeback: collect stats of all wb of bdi in bdi_debug_stats_show
  writeback: support retrieving per group debug writeback stats of bdi
  writeback: fix build problems of "writeback: support retrieving per
    group debug writeback stats of bdi"
  writeback: add wb_monitor.py script to monitor writeback info on bdi
  writeback: rename nr_reclaimable to nr_dirty in balance_dirty_pages

 include/linux/writeback.h     |   1 +
 mm/backing-dev.c              | 177 +++++++++++++++++++++++++++++-----
 mm/page-writeback.c           |  27 +++++-
 tools/writeback/wb_monitor.py | 172 +++++++++++++++++++++++++++++++++
 4 files changed, 348 insertions(+), 29 deletions(-)
 create mode 100644 tools/writeback/wb_monitor.py

-- 
2.30.0


