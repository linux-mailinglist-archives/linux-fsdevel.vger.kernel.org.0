Return-Path: <linux-fsdevel+bounces-56000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4900DB11647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C111CE203B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2B22A4FC;
	Fri, 25 Jul 2025 02:16:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78515E90;
	Fri, 25 Jul 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409772; cv=none; b=qo9nb6f0gosy0SMS8JUCM5yUwTSQAlgBHHYWBl+U7YV5iTOpNYWyfZelSUxkexlXvuGOuZ5+hWCzWG6A0OvfGz/XzqcDFGQEc09yv2K4kYPi9zcps0qy1IsJj2HD/+3+TH8XcFHxH2dJ2Y8xQ084oBlYrU/acj6LM0qrxgIGRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409772; c=relaxed/simple;
	bh=F9ymojQL1CCW/wojRr8agyGbTk24h4qtsutwPC3MN6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVcsT1EU5jaTZcjKKkUGRwSAvfBX6DXdwX/v18KOB/A5TG95Q/pgoRJ+3ObFIMSUGE1TE4GEgCeyH3LoRsh3+T0FIeeTW8e9xXX6S4JfFofZYZl6T0FxDXMAETCuKEFi0dQXVXWwjnMK6XkauKY7GyOiz3Q2nsDuWvcuT/8hPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bpBLb5QWNzKHMY8;
	Fri, 25 Jul 2025 10:16:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8078A1A0AD8;
	Fri, 25 Jul 2025 10:16:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBHc6IJoBQeYBQ--.38741S4;
	Fri, 25 Jul 2025 10:16:04 +0800 (CST)
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
Subject: [PATCH -next] ext4: fix crash on test_new_blocks_simple kunit tests
Date: Fri, 25 Jul 2025 10:15:50 +0800
Message-ID: <20250725021550.3177573-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBHc6IJoBQeYBQ--.38741S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1DKryUCF15Xr4ktF4xWFg_yoW5tF4kpa
	47CF18Kr4rZw1DCF4fGF1UGw18Gw4DZFW8WryfGw1UZF45Z34kAFyvyry7Kr4DJrW8X3WF
	y3Wqq34xtw1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_mb_avg_fragment_size_destroy() requires a valid sbi->s_sb,
mb_set_largest_free_order() requires the parameter bb_largest_free_order
to be initialized, and mb_update_avg_fragment_size() requires the
parameter bb_avg_fragment_size_order to be initialized. But the
test_new_blocks_simple kunit tests do not init these parameters, and
trigger the following crash issue.

 Pid: 20, comm: kunit_try_catch Tainted: G W N  6.16.0-rc4-ga8a47fa84cc2
 RIP: 0033:ext4_mb_release+0x1fc/0x400
 RSP: 00000000a0883ed0  EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000060a1e400 RCX: 0000000000000002
 RDX: 0000000060058fa0 RSI: 0000000000000002 RDI: 0000000000000001
 RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000002
 R10: 00000000a0883e68 R11: 0000000060374bb0 R12: 000000006012eff0
 R13: 00000000603763e0 R14: 0000000060ad92d8 R15: 0000000060c051c0
 Kernel panic - not syncing: Segfault with no mm
 CPU: 0 UID: 0 PID: 20 Comm: kunit_try_catch Tainted: G W N 6.16.0-rc4-ga8a47fa84cc2 #47 NONE
 Tainted: [W]=WARN, [N]=TEST
 Stack:
  60134c30 400000004 60864000 6092a3c0
  00000001 a0803d40 a0803b28 6012eff0
  605990e8 60085be0 60864000 602167aa
 Call Trace:
  [<60134c30>] ? kmem_cache_free+0x0/0x3d0
  [<6012eff0>] ? kfree+0x0/0x290
  [<60085be0>] ? to_kthread+0x0/0x40
  [<602167aa>] ? mbt_kunit_exit+0x2a/0xe0
  [<60085be0>] ? to_kthread+0x0/0x40
  [<602acd50>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
  [<60085be0>] ? to_kthread+0x0/0x40
  [<602aaa8a>] ? kunit_try_run_case_cleanup+0x2a/0x40
  [<602acd62>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
  [<600862c1>] ? kthread+0xf1/0x250
  [<6004a521>] ? new_thread_handler+0x41/0x60

Fixes: bbe11dd13a3f ("ext4: fix largest free orders lists corruption on mb_optimize_scan switch")
Fixes: 458bfb991155 ("ext4: convert free groups order lists to xarrays")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-ext4/b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net/
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/mballoc-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d634c12f1984..a9416b20ff64 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -155,6 +155,7 @@ static struct super_block *mbt_ext4_alloc_super_block(void)
 	bgl_lock_init(sbi->s_blockgroup_lock);
 
 	sbi->s_es = &fsb->es;
+	sbi->s_sb = sb;
 	sb->s_fs_info = sbi;
 
 	up_write(&sb->s_umount);
@@ -802,6 +803,8 @@ static void test_mb_mark_used(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 	for (i = 0; i < TEST_RANGE_COUNT; i++)
 		test_mb_mark_used_range(test, &e4b, ranges[i].start,
@@ -875,6 +878,8 @@ static void test_mb_free_blocks(struct kunit *test)
 	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	grp->bb_free = 0;
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
 	memset(bitmap, 0xff, sb->s_blocksize);
 
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
-- 
2.46.1


