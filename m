Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3796A32A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBZQDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBZQDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:45 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11912A5D6;
        Sun, 26 Feb 2023 08:03:34 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 4F8AF831A3;
        Sun, 26 Feb 2023 16:03:28 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427413;
        bh=Myw3hByCu9lylJKDc0tVPW8sdVob9FBj4sLqjc1V50w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tr4VLw5aC8ArluOFX0XvTmPqY4tIRGeOer0XOLd/mKyollc+09Q5iH1xYOgfph3Ge
         XywUJAaYIplTR0M/AhYE1lhc/ldNDpXO5KXGnlLk5iG+/WesuX7n1Jfl6CzkbWXETN
         /e0xtyi+ypKwPih3XkFwovwB6vJT/BFM2etoV+zGHN2FBHcclQ+nt44kiFF/yxuRc6
         b4Bg4JLsVu7ZfR4K1o37ZNxxx3B2WWg6Z5Xja545mbBx/ygCPCc+UK60W+feYbxRy9
         emnIJlf/YdeshvtZ7LavzpxQFjlzaaYzUa5zEEEK4ooYIhljce5+YyvvKkglUCsoya
         c5IT3+9s2k0sQ==
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
Subject: [RFC PATCH v1 3/6] btrfs: Create btrfs CPU set struct and helpers
Date:   Sun, 26 Feb 2023 23:02:56 +0700
Message-Id: <20230226160259.18354-4-ammarfaizi2@gnuweeb.org>
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

It's a preparation to add Btrfs CPU affinity support. First, create a
new struct named `btrfs_cpu_set` to contain CPU affinity information.
Then, create helpers to allocate, parse, and free them.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 fs/btrfs/fs.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h |  7 ++++
 2 files changed, 104 insertions(+)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 31c1648bc0b46922..283d153d4491289c 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -96,3 +96,100 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
+
+/*
+ * The user can't use the taskset pattern because ',' is used as
+ * the mount option delimiter. They can use the same taskset pattern,
+ * but replace the ',' with '.' and we will replace it back to
+ * ',', so the cpulist_parse() can recognize it.
+ *
+ * For example, in taskset cmd, they do:
+ * taskset -c 1,4,7 /bin/ls
+ *
+ * The equivalent CPU mask for the btrfs mount option will be:
+ * wq_cpu_set=1.4.7
+ *
+ * Mark these as __cold to avoid the code bloat from overoptimizing
+ * the loop.
+ */
+__cold static void cpulist_dot_to_comma(char *set)
+{
+	while (*set) {
+		if (*set == '.')
+			*set = ',';
+		set++;
+	}
+}
+
+__cold static void cpulist_comma_to_dot(char *set)
+{
+	while (*set) {
+		if (*set == ',')
+			*set = '.';
+		set++;
+	}
+}
+
+void btrfs_destroy_cpu_set(struct btrfs_cpu_set *cpu_set)
+{
+	if (!cpu_set)
+		return;
+
+	free_cpumask_var(cpu_set->mask);
+	kfree(cpu_set->mask_str);
+	kfree(cpu_set);
+}
+
+/*
+ * Only called from btrfs_parse_cpu_set().
+ */
+static struct btrfs_cpu_set *btrfs_alloc_cpu_set(void)
+{
+	struct btrfs_cpu_set *cpu_set;
+
+	cpu_set = kmalloc(sizeof(*cpu_set), GFP_KERNEL);
+	if (!cpu_set)
+		return NULL;
+
+	if (!alloc_cpumask_var(&cpu_set->mask, GFP_KERNEL)) {
+		kfree(cpu_set);
+		return NULL;
+	}
+
+	cpu_set->mask_str = NULL;
+	return cpu_set;
+}
+
+int btrfs_parse_cpu_set(struct btrfs_cpu_set **cpu_set_p, const char *mask_str)
+{
+	struct btrfs_cpu_set *cpu_set;
+	int ret;
+
+	cpu_set = btrfs_alloc_cpu_set();
+	if (!cpu_set)
+		return -ENOMEM;
+
+	cpu_set->mask_str = kstrdup(mask_str, GFP_KERNEL);
+	if (!cpu_set->mask_str) {
+		ret = -ENOMEM;
+		goto out_fail;
+	}
+
+	cpulist_dot_to_comma(cpu_set->mask_str);
+	ret = cpulist_parse(cpu_set->mask_str, cpu_set->mask);
+	if (ret)
+		goto out_fail;
+
+	if (cpumask_empty(cpu_set->mask)) {
+		ret = -EINVAL;
+		goto out_fail;
+	}
+
+	cpulist_comma_to_dot(cpu_set->mask_str);
+	*cpu_set_p = cpu_set;
+	return 0;
+
+out_fail:
+	btrfs_destroy_cpu_set(cpu_set);
+	return ret;
+}
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 6de61367b6686197..cbad856df197ccfd 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -356,6 +356,11 @@ struct btrfs_commit_stats {
 	u64 total_commit_dur;
 };
 
+struct btrfs_cpu_set {
+	cpumask_var_t mask;
+	char *mask_str;
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -876,6 +881,8 @@ void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 			  enum btrfs_exclusive_operation op);
+int btrfs_parse_cpu_set(struct btrfs_cpu_set **cpu_set_p, const char *mask_str);
+void btrfs_destroy_cpu_set(struct btrfs_cpu_set *cpu_set);
 
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
-- 
Ammar Faizi

