Return-Path: <linux-fsdevel+bounces-17455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2D8ADC68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34DA1F21D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039972032D;
	Tue, 23 Apr 2024 03:46:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0871C2AF;
	Tue, 23 Apr 2024 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844012; cv=none; b=T80fH21H9ffGa6v2TmtcLiRnEatVH3d4blmxbURASH88itPRhEO0l9WGKnNx+7a1Usuh8WQsMVg73sAlxdltulT5ZVvgfeEkymvSZEhWIRqAMA6PYkO/GHkSwo/1RdXwaMUenquUJcs8A6xNEztVItIpyiTUfkH6r9Q+K9voTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844012; c=relaxed/simple;
	bh=pfLch2OejLM4oDnUXJbhjI+xBddLixTBWgSUFwg26LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5sNScQ5UZjaSOznrrnBZDjuU5Wdi3ipOa5TrES+JjneFWf1UzHevf3RNGWYPpOnQ9wkIfcmfC5iYKCDBEAYuBe/1btVFskaahJJvrJP4rREGL4yXRQWLr740IYzMd996eQQbQbzJOD5/BTjyIryPol4j34HrL7pFLbiszcPL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNp2S0kzJz4f3kpM;
	Tue, 23 Apr 2024 11:46:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 917F21A10FA;
	Tue, 23 Apr 2024 11:46:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgA3Ww4kLydmKkDYKw--.11241S6;
	Tue, 23 Apr 2024 11:46:47 +0800 (CST)
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
Subject: [PATCH v5 4/5] writeback: add wb_monitor.py script to monitor writeback info on bdi
Date: Tue, 23 Apr 2024 11:46:42 +0800
Message-Id: <20240423034643.141219-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3Ww4kLydmKkDYKw--.11241S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1UCrWrWFWxXw1DJFy7Jrb_yoWxJr1fpF
	s8Aw13Ar1xZa4xJrnY9a40vry5Cws5Cr17XrW7ArWakan8Wa4FyryrCFyUAry3Cr9rJ39x
	X3ya93y8KFWjgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add wb_monitor.py script to monitor writeback information on backing dev
which makes it easier and more convenient to observe writeback behaviors
of running system.

The wb_monitor.py script is written based on wq_monitor.py.

Following domain hierarchy is tested:
                global domain (320G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2

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

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Tejun Heo <tj@kernel.org>
---
 tools/writeback/wb_monitor.py | 172 ++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 tools/writeback/wb_monitor.py

diff --git a/tools/writeback/wb_monitor.py b/tools/writeback/wb_monitor.py
new file mode 100644
index 000000000000..5e3591f1f9a9
--- /dev/null
+++ b/tools/writeback/wb_monitor.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2024 Kemeng Shi <shikemeng@huaweicloud.com>
+# Copyright (C) 2024 Huawei Inc
+
+desc = """
+This is a drgn script based on wq_monitor.py to monitor writeback info on
+backing dev. For more info on drgn, visit https://github.com/osandov/drgn.
+
+  writeback(kB)     Amount of dirty pages are currently being written back to
+                    disk.
+
+  reclaimable(kB)   Amount of pages are currently reclaimable.
+
+  dirtied(kB)       Amount of pages have been dirtied.
+
+  wrttien(kB)       Amount of dirty pages have been written back to disk.
+
+  avg_wb(kBps)      Smoothly estimated write bandwidth of writing dirty pages
+                    back to disk.
+"""
+
+import signal
+import re
+import time
+import json
+
+import drgn
+from drgn.helpers.linux.list import list_for_each_entry
+
+import argparse
+parser = argparse.ArgumentParser(description=desc,
+                                 formatter_class=argparse.RawTextHelpFormatter)
+parser.add_argument('bdi', metavar='REGEX', nargs='*',
+                    help='Target backing device name patterns (all if empty)')
+parser.add_argument('-i', '--interval', metavar='SECS', type=float, default=1,
+                    help='Monitoring interval (0 to print once and exit)')
+parser.add_argument('-j', '--json', action='store_true',
+                    help='Output in json')
+parser.add_argument('-c', '--cgroup', action='store_true',
+                    help='show writeback of bdi in cgroup')
+args = parser.parse_args()
+
+bdi_list                = prog['bdi_list']
+
+WB_RECLAIMABLE          = prog['WB_RECLAIMABLE']
+WB_WRITEBACK            = prog['WB_WRITEBACK']
+WB_DIRTIED              = prog['WB_DIRTIED']
+WB_WRITTEN              = prog['WB_WRITTEN']
+NR_WB_STAT_ITEMS        = prog['NR_WB_STAT_ITEMS']
+
+PAGE_SHIFT              = prog['PAGE_SHIFT']
+
+def K(x):
+    return x << (PAGE_SHIFT - 10)
+
+class Stats:
+    def dict(self, now):
+        return { 'timestamp'            : now,
+                 'name'                 : self.name,
+                 'writeback'            : self.stats[WB_WRITEBACK],
+                 'reclaimable'          : self.stats[WB_RECLAIMABLE],
+                 'dirtied'              : self.stats[WB_DIRTIED],
+                 'written'              : self.stats[WB_WRITTEN],
+                 'avg_wb'               : self.avg_bw, }
+
+    def table_header_str():
+        return f'{"":>16} {"writeback":>10} {"reclaimable":>12} ' \
+                f'{"dirtied":>9} {"written":>9} {"avg_bw":>9}'
+
+    def table_row_str(self):
+        out = f'{self.name[-16:]:16} ' \
+              f'{self.stats[WB_WRITEBACK]:10} ' \
+              f'{self.stats[WB_RECLAIMABLE]:12} ' \
+              f'{self.stats[WB_DIRTIED]:9} ' \
+              f'{self.stats[WB_WRITTEN]:9} ' \
+              f'{self.avg_bw:9} '
+        return out
+
+    def show_header():
+        if Stats.table_fmt:
+            print()
+            print(Stats.table_header_str())
+
+    def show_stats(self):
+        if Stats.table_fmt:
+            print(self.table_row_str())
+        else:
+            print(self.dict(Stats.now))
+
+class WbStats(Stats):
+    def __init__(self, wb):
+        bdi_name = wb.bdi.dev_name.string_().decode()
+        # avoid to use bdi.wb.memcg_css which is only defined when
+        # CONFIG_CGROUP_WRITEBACK is enabled
+        if wb == wb.bdi.wb.address_of_():
+            ino = "1"
+        else:
+            ino = str(wb.memcg_css.cgroup.kn.id.value_())
+        self.name = bdi_name + '_' + ino
+
+        self.stats = [0] * NR_WB_STAT_ITEMS
+        for i in range(NR_WB_STAT_ITEMS):
+            if wb.stat[i].count >= 0:
+                self.stats[i] = int(K(wb.stat[i].count))
+            else:
+                self.stats[i] = 0
+
+        self.avg_bw = int(K(wb.avg_write_bandwidth))
+
+class BdiStats(Stats):
+    def __init__(self, bdi):
+        self.name = bdi.dev_name.string_().decode()
+        self.stats = [0] * NR_WB_STAT_ITEMS
+        self.avg_bw = 0
+
+    def collectStats(self, wb_stats):
+        for i in range(NR_WB_STAT_ITEMS):
+            self.stats[i] += wb_stats.stats[i]
+
+        self.avg_bw += wb_stats.avg_bw
+
+exit_req = False
+
+def sigint_handler(signr, frame):
+    global exit_req
+    exit_req = True
+
+def main():
+    # handle args
+    Stats.table_fmt = not args.json
+    interval = args.interval
+    cgroup = args.cgroup
+
+    re_str = None
+    if args.bdi:
+        for r in args.bdi:
+            if re_str is None:
+                re_str = r
+            else:
+                re_str += '|' + r
+
+    filter_re = re.compile(re_str) if re_str else None
+
+    # monitoring loop
+    signal.signal(signal.SIGINT, sigint_handler)
+
+    while not exit_req:
+        Stats.now = time.time()
+
+        Stats.show_header()
+        for bdi in list_for_each_entry('struct backing_dev_info', bdi_list.address_of_(), 'bdi_list'):
+            bdi_stats = BdiStats(bdi)
+            if filter_re and not filter_re.search(bdi_stats.name):
+                continue
+
+            for wb in list_for_each_entry('struct bdi_writeback', bdi.wb_list.address_of_(), 'bdi_node'):
+                wb_stats = WbStats(wb)
+                bdi_stats.collectStats(wb_stats)
+                if cgroup:
+                    wb_stats.show_stats()
+
+            bdi_stats.show_stats()
+            if cgroup and Stats.table_fmt:
+                print()
+
+        if interval == 0:
+            break
+        time.sleep(interval)
+
+if __name__ == "__main__":
+    main()
-- 
2.30.0


