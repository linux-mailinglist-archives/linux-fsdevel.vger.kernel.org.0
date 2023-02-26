Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C16A32AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBZQEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBZQD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:58 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E711177;
        Sun, 26 Feb 2023 08:03:44 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id C24538319D;
        Sun, 26 Feb 2023 16:03:39 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427424;
        bh=KGQkSC7uN8P5ShfcF5vnepkW95hzs86cm3yNydWOBj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6ld5PCKPWRl5RjCDcp2FJNpbcCCdOpbeexDCsQiRlWg9Dd559yFtlz35Be8FE+y9
         Ypk19EReL1hhTwCICrxgwI/tb65rCwZRbbvZ3kpfE4Bs2MzJ/21JvzsHZerdvDHHG0
         kdf1UL5KB9keGFhzVmGysuqNYF7VlreryhX6+J9ufrsn3/XlTqx8lf+3xKY8eTAUaN
         wQqk1nHXxNh3ja8g+EBUQJUsTqsfxpyocDQ/MahtwK1cpRoI54uBkv+NDxOHgXyGHh
         uOFw+OXISKSQ3HKIJNzciovBljZ3EE3HlrLqzcoDNMn6Py+ao1s71c2awvHBoWKysi
         aqej08/W5T5Uw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 5/6] btrfs: Adjust the default thread pool size when `wq_cpu_set` option is used
Date:   Sun, 26 Feb 2023 23:02:58 +0700
Message-Id: <20230226160259.18354-6-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If wq_cpu_set is specified, adjust thread_pool_size to the number of
CPUs in the set plus 2 to avoid the case where the number of CPUs in the
set is less than the default thread_pool_size + 2, which might cause the
thread pool to be starved. The thread_pool=%u mount option overrides
this adjusting behavior.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 fs/btrfs/super.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3e061ec977b014d1..34b7c5810d34d624 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -317,6 +317,32 @@ static int parse_wq_cpu_set(struct btrfs_fs_info *info, const char *mask_str)
 	return 0;
 }
 
+static void adjust_default_thread_pool_size(struct btrfs_fs_info *info)
+{
+	unsigned long old_thread_pool_size;
+	unsigned long new_thread_pool_size;
+	unsigned long total_usable_cpu = 0;
+	unsigned long cpu;
+
+	if (!btrfs_test_opt(info, WQ_CPU_SET))
+		return;
+
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, info->wq_cpu_set->mask))
+			total_usable_cpu++;
+	}
+
+	old_thread_pool_size = info->thread_pool_size;
+	new_thread_pool_size = min_t(unsigned long, total_usable_cpu + 2, 8);
+
+	if (old_thread_pool_size == new_thread_pool_size)
+		return;
+
+	info->thread_pool_size = new_thread_pool_size;
+	btrfs_info(info, "adjusting thread_pool_size to %lu due to wq_cpu_set (you can override this with thread_pool=%%u option)",
+		   new_thread_pool_size);
+}
+
 /*
  * Regular mount options parser.  Everything that is needed only when
  * reading in a new superblock is parsed here.
@@ -336,6 +362,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
+	bool has_thread_pool_opt = false;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -543,6 +570,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				goto out;
 			}
 			info->thread_pool_size = intarg;
+			has_thread_pool_opt = true;
 			break;
 		case Opt_max_inline:
 			num = match_strdup(&args[0]);
@@ -854,6 +882,16 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
+
+	/*
+	 * If wq_cpu_set is specified, adjust thread_pool_size to the number of
+	 * CPUs in the set plus 2 to avoid the case where the number of CPUs in
+	 * the set is less than the default thread_pool_size + 2, which might
+	 * cause the thread pool to be starved. The thread_pool=%u mount option
+	 * overrides this adjusting behavior.
+	 */
+	if (!ret && !has_thread_pool_opt)
+		adjust_default_thread_pool_size(info);
 	if (!ret && !remounting) {
 		if (btrfs_test_opt(info, SPACE_CACHE))
 			btrfs_info(info, "disk space caching is enabled");
-- 
Ammar Faizi

