Return-Path: <linux-fsdevel+bounces-18080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB148B5360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57905281CA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFE179BC;
	Mon, 29 Apr 2024 08:47:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B45C2C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380427; cv=none; b=FmkWVqJA3GNUF9Mjw01Isesoz0tJw+9hmQvTX1ckD0nWtcpc9XDp0FDJ8fQY6kfCT9XriAqfZJ7qTghmcJs0YVKyS1yAbs3Dsv1mAiUKAfYiP7p6PrGuachOYE1NQ9JAu0a6a0CK2pqGWZUZyAHeMhtt4ZRhPRhJFFDvhRuKOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380427; c=relaxed/simple;
	bh=4yneeJLx+f0bOXwRDzrvGNhavRWvgBVi9UZ/ywkUr3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FBcYDaKNAhSbtpGAkUvemJmSv0xY4hwICYEl85ZjBtxyyxiVZ2ZT4n65+r1cOnaW9OysOZU8LBLsvSGgsZsbXZg+W/axTR+FIATvYrQNNU35cAIojxg3VbxJGVVkWwSqVjRkk7SzBC5NQPsz0EaN/KC9A3Hi2KDBwuCBX38mBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43T8kltI069189;
	Mon, 29 Apr 2024 16:46:47 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VScLm0mpmz2K1r9q;
	Mon, 29 Apr 2024 16:44:00 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 29 Apr 2024 16:46:45 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <akpm@linux-foundation.org>, <oleg@redhat.com>, <longman@redhat.com>,
        <peterz@infradead.org>
CC: <dylanbhatch@google.com>, <rick.p.edgecombe@intel.com>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] sched/proc: Print user_cpus_ptr for task status
Date: Mon, 29 Apr 2024 16:46:33 +0800
Message-ID: <20240429084633.9800-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 43T8kltI069189

The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
would clear the user_cpus_ptr when call the do_set_cpus_allowed.

In order to determine whether the user_cpus_ptr is taking effect,
it is better to print the task's user_cpus_ptr.

For top-cpuset:
ums9621_1h10:/ # while true; do done&
[1] 6786
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

bind the task to 6-7：
ums9621_1h10:/ # taskset -p c0 6786
pid 6786's current affinity mask: ff
pid 6786's new affinity mask: c0
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7

Offline cpu7:
ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7

Offline cpu6, and then the do_set_cpus_allowed will clear the user_ptr:
ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

Bringup the core6,7:
ums9621_1h10:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
ums9621_1h10:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 fs/proc/array.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..084bee2a2e2b 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -409,6 +409,10 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
 		   cpumask_pr_args(&task->cpus_mask));
+	seq_printf(m, "Cpus_user_allowed:\t%*pb\n",
+		   cpumask_pr_args(task->user_cpus_ptr));
+	seq_printf(m, "Cpus_user_allowed_list:\t%*pbl\n",
+		   cpumask_pr_args(task->user_cpus_ptr));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
-- 
2.25.1


