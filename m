Return-Path: <linux-fsdevel+bounces-56001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64983B1164F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2600D4E00DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020322A7E9;
	Fri, 25 Jul 2025 02:17:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FE12EBE7;
	Fri, 25 Jul 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409834; cv=none; b=C8eLpryidjPCYVL0zmHgyz7qVQhnWCmNL76TUhwOuD45d5/pomiQjeBNDfggxk8ez70JrcOLr9S4sDRTdp1h7Oq1+3bt9+hw6NG+cNV8yuN2Mm2nd8q304SpFXJjtisQ8AcalvuAAyGF/csI6z+YRITnEZ6yGA2YiR2NegoSbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409834; c=relaxed/simple;
	bh=F5wFBAyOipz82vVg8SiBeKX7QDsomIOxOvnKO7R8Ru8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xv2ts3oHRnyxkWTI65oEEuLB+5o5G0OUvozKlMfhYs2rHMa6kAPPBXjUqQwh+JShPHEh6pEzt5vJ9O1lFoPh22mSqw5gES0TAsUQdUj3B1kOeLgC7fV5TW36GXRf8fTtX4kLtaVCTqHwIrts2G+KxACpgr+oyoVNUhFV98Im7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpBMn6dZrzYQtJF;
	Fri, 25 Jul 2025 10:17:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D8AB1A06DD;
	Fri, 25 Jul 2025 10:17:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBHERIc6YJo2RyYBQ--.2848S4;
	Fri, 25 Jul 2025 10:17:08 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	linux@roeck-us.net,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Date: Fri, 25 Jul 2025 10:16:54 +0800
Message-ID: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERIc6YJo2RyYBQ--.2848S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48WrWxJrW3JF4rCrykZrb_yoWrJF1fpa
	4UKF18KrW8Zr1DAr4fGa4jqw45Kw4DAFW8W34fJ3WUW3ZrA34vyFy8try7Gr45Ar48X3W0
	yF12v345twn29aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

mb_set_largest_free_order() requires the parameter bb_largest_free_order
and the list bb_largest_free_order_node to be initialized, and
mb_update_avg_fragment_size() requires the parameter
bb_avg_fragment_size_order and bb_avg_fragment_size_node to be
initialized too. But the test_mb_mark_used kunit tests do not init these
parameters, and trigger the following crash issue.

 Pid: 35, comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-00031-gbbe11dd13a3f-dirty
 RIP: 0033:mb_set_largest_free_order+0x5c/0xc0
 RSP: 00000000a0883d98  EFLAGS: 00010206
 RAX: 0000000060aeaa28 RBX: 0000000060a2d400 RCX: 0000000000000008
 RDX: 0000000060aea9c0 RSI: 0000000000000000 RDI: 0000000060864000
 RBP: 0000000060aea9c0 R08: 0000000000000000 R09: 0000000060a2d400
 R10: 0000000000000400 R11: 0000000060a9cc00 R12: 0000000000000006
 R13: 0000000000000400 R14: 0000000000000305 R15: 0000000000000000
 Kernel panic - not syncing: Segfault with no mm
 CPU: 0 UID: 0 PID: 35 Comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-00031-gbbe11dd13a3f-dirty #36 NONE
 Tainted: [W]=WARN, [N]=TEST
 Stack:
  60210c60 00000200 60a9e400 00000400
  40060300280 60864000 60a9cc00 60a2d400
  00000400 60aea9c0 60a9cc00 60aea9c0
 Call Trace:
  [<60210c60>] ? ext4_mb_generate_buddy+0x1f0/0x230
  [<60215c3b>] ? test_mb_mark_used+0x28b/0x4e0
  [<601df5bc>] ? ext4_get_group_desc+0xbc/0x150
  [<600bf1c0>] ? ktime_get_ts64+0x0/0x190
  [<60086370>] ? to_kthread+0x0/0x40
  [<602b559b>] ? kunit_try_run_case+0x7b/0x100
  [<60086370>] ? to_kthread+0x0/0x40
  [<602b7850>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
  [<602b7862>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
  [<60086a51>] ? kthread+0xf1/0x250
  [<6004a541>] ? new_thread_handler+0x41/0x60
 [ERROR] Test: test_mb_mark_used: 0 tests run!

Fixes: bbe11dd13a3f ("ext4: fix largest free orders lists corruption on mb_optimize_scan switch")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Closes: https://lore.kernel.org/linux-ext4/20250724145437.GD80823@mit.edu/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
This patch applies to the kernel that has only merged bbe11dd13a3f
("ext4: fix largest free orders lists corruption on mb_optimize_scan
switch"), but not merged 458bfb991155 ("ext4: convert free groups order
lists to xarrays").

 fs/ext4/mballoc-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d634c12f1984..ba939be0ec55 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -802,6 +802,10 @@ static void test_mb_mark_used(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
+	INIT_LIST_HEAD(&grp->bb_largest_free_order_node);
+	INIT_LIST_HEAD(&grp->bb_avg_fragment_size_node);
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 	for (i = 0; i < TEST_RANGE_COUNT; i++)
 		test_mb_mark_used_range(test, &e4b, ranges[i].start,
@@ -875,6 +879,10 @@ static void test_mb_free_blocks(struct kunit *test)
 	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	grp->bb_free = 0;
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
+	INIT_LIST_HEAD(&grp->bb_largest_free_order_node);
+	INIT_LIST_HEAD(&grp->bb_avg_fragment_size_node);
 	memset(bitmap, 0xff, sb->s_blocksize);
 
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
-- 
2.46.1


