Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930616A32A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBZQD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBZQDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:49 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19911148;
        Sun, 26 Feb 2023 08:03:39 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 8BF448319A;
        Sun, 26 Feb 2023 16:03:34 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427419;
        bh=Lh3FXdEhYYeO5gm8fhDvdFLZ3MyGY8XmpI1g+zO/bzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qS5tQrh8N7LynwYGLCSJ4ErfaCVhz7srFXQRwx5s89dmmINfJUqGPMtqWjaWj7CP9
         jiUUntXWfORMAAomVD/DOEkYxkS2ZybyexRCoMUCFjIHc2U9DAV92s5OQM74i2PHhc
         J7rHtmlHpokZfymAN6KJEQOnF+FCu/XfWh+R7y2frqDfNp+zYDKZPLVuvF4aEo+rn9
         lQliMIaVzM7szZp0BsFrQ8c68uVYLsHT36/4ZP12ZAmej4XdjJ45GlWeKiZD8tzlV/
         Or/1YuiCwYLX4KBn85DlUIIcjTKkSiCFX+mpPgFeo1eFQPaOpYy1DiLxRQ892Sr7my
         WfPG7bsFfZs5Q==
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
Subject: [RFC PATCH v1 4/6] btrfs: Add wq_cpu_set=%s mount option
Date:   Sun, 26 Feb 2023 23:02:57 +0700
Message-Id: <20230226160259.18354-5-ammarfaizi2@gnuweeb.org>
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

Btrfs workqueues can slow sensitive user tasks down because they can use
any online CPU to perform heavy workloads on an SMP system. Add a mount
option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.

This option is similar to the taskset bitmask except that the comma
separator is replaced with a dot. The reason for this is that the mount
option parser uses commas to separate mount options.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 fs/btrfs/async-thread.c | 51 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/async-thread.h |  1 +
 fs/btrfs/disk-io.c      |  3 ++-
 fs/btrfs/fs.h           |  3 +++
 fs/btrfs/super.c        | 44 +++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index aac240430efe1316..445c055304574653 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -11,6 +11,7 @@
 #include <linux/freezer.h>
 #include "async-thread.h"
 #include "ctree.h"
+#include "messages.h"
 
 enum {
 	WORK_DONE_BIT,
@@ -339,3 +340,53 @@ void btrfs_flush_workqueue(struct btrfs_workqueue *wq)
 {
 	flush_workqueue(wq->normal_wq);
 }
+
+static int apply_wq_cpu_set_notice(struct btrfs_fs_info *info,
+				   struct workqueue_struct *wq,
+				   const char *wq_name)
+{
+	const char *mask_str = info->wq_cpu_set->mask_str;
+	int ret;
+
+	ret = set_workqueue_cpumask(wq, info->wq_cpu_set->mask);
+	if (ret) {
+		btrfs_err(info, "failed to set cpu mask for %s wq: %d", wq_name,
+			  ret);
+		return ret;
+	}
+
+	btrfs_info(info, "set cpu mask for %s wq to %s", wq_name, mask_str);
+	return 0;
+}
+
+#define apply_wq_cpu_set(INFO, WQ) \
+	apply_wq_cpu_set_notice(INFO, (INFO)->WQ, # WQ)
+
+#define btrfs_apply_wq_cpu_set(INFO, WQ) \
+	apply_wq_cpu_set_notice(INFO, (INFO)->WQ->normal_wq, # WQ)
+
+
+void btrfs_apply_workqueue_cpu_set(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, WQ_CPU_SET))
+		return;
+
+	btrfs_apply_wq_cpu_set(fs_info, workers);
+	btrfs_apply_wq_cpu_set(fs_info, hipri_workers);
+	btrfs_apply_wq_cpu_set(fs_info, delalloc_workers);
+	btrfs_apply_wq_cpu_set(fs_info, flush_workers);
+	btrfs_apply_wq_cpu_set(fs_info, caching_workers);
+	btrfs_apply_wq_cpu_set(fs_info, fixup_workers);
+	apply_wq_cpu_set(fs_info, endio_workers);
+	apply_wq_cpu_set(fs_info, endio_meta_workers);
+	apply_wq_cpu_set(fs_info, rmw_workers);
+	btrfs_apply_wq_cpu_set(fs_info, endio_write_workers);
+	apply_wq_cpu_set(fs_info, compressed_write_workers);
+	btrfs_apply_wq_cpu_set(fs_info, endio_freespace_worker);
+	btrfs_apply_wq_cpu_set(fs_info, delayed_workers);
+	btrfs_apply_wq_cpu_set(fs_info, qgroup_rescan_workers);
+	apply_wq_cpu_set(fs_info, discard_ctl.discard_workers);
+}
+
+#undef apply_wq_cpu_set
+#undef btrfs_apply_wq_cpu_set
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 6e2596ddae1002ab..2b8a76fa75ef9e69 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -41,5 +41,6 @@ struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
 struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq);
 bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
 void btrfs_flush_workqueue(struct btrfs_workqueue *wq);
+void btrfs_apply_workqueue_cpu_set(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b53f0e30ce2b3bbb..1bb1db461a30fa71 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1498,6 +1498,7 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	btrfs_destroy_cpu_set(fs_info->wq_cpu_set);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -2231,7 +2232,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->discard_ctl.discard_workers)) {
 		return -ENOMEM;
 	}
-
+	btrfs_apply_workqueue_cpu_set(fs_info);
 	return 0;
 }
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cbad856df197ccfd..a8bd1414b2520ea4 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -177,6 +177,7 @@ enum {
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
+	BTRFS_MOUNT_WQ_CPU_SET			= (1ULL << 32),
 };
 
 /*
@@ -807,6 +808,8 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+
+	struct btrfs_cpu_set *wq_cpu_set;
 };
 
 static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 581845bc206ad28b..3e061ec977b014d1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -139,6 +139,7 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	Opt_wq_cpu_set,
 	Opt_err,
 };
 
@@ -213,6 +214,7 @@ static const match_table_t tokens = {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
 #endif
+	{Opt_wq_cpu_set, "wq_cpu_set=%s"},
 	{Opt_err, NULL},
 };
 
@@ -298,6 +300,23 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 	return ret;
 }
 
+static int parse_wq_cpu_set(struct btrfs_fs_info *info, const char *mask_str)
+{
+	struct btrfs_cpu_set *cpu_set;
+	int ret;
+
+	ret = btrfs_parse_cpu_set(&cpu_set, mask_str);
+	if (ret) {
+		btrfs_err(info, "failed to parse wq_cpu_set: %d", ret);
+		return ret;
+	}
+
+	info->wq_cpu_set = cpu_set;
+	btrfs_info(info, "using wq_cpu_set=%s", mask_str);
+	btrfs_set_opt(info->mount_opt, WQ_CPU_SET);
+	return 0;
+}
+
 /*
  * Regular mount options parser.  Everything that is needed only when
  * reading in a new superblock is parsed here.
@@ -803,6 +822,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_wq_cpu_set:
+			ret = parse_wq_cpu_set(info, args[0].from);
+			if (ret < 0)
+				goto out;
+			break;
 		case Opt_err:
 			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -1319,6 +1343,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, WQ_CPU_SET))
+		seq_printf(seq, ",wq_cpu_set=%s", info->wq_cpu_set->mask_str);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
@@ -1686,6 +1712,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
+	struct btrfs_cpu_set *old_wq_cpu_set = fs_info->wq_cpu_set;
 	int ret;
 
 	sync_filesystem(sb);
@@ -1838,6 +1865,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	}
 out:
+	/*
+	 * The remount operation changes the wq_cpu_set.
+	 */
+	if (fs_info->wq_cpu_set != old_wq_cpu_set) {
+		btrfs_destroy_cpu_set(old_wq_cpu_set);
+		btrfs_apply_workqueue_cpu_set(fs_info);
+	}
+
 	/*
 	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
 	 * since the absence of the flag means it can be toggled off by remount.
@@ -1852,6 +1887,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 
 restore:
+	/*
+	 * The remount operation changes the wq_cpu_set, but we hit an error,
+	 * destroy the new value and roll it back to the previous value.
+	 */
+	if (fs_info->wq_cpu_set != old_wq_cpu_set) {
+		btrfs_destroy_cpu_set(fs_info->wq_cpu_set);
+		fs_info->wq_cpu_set = old_wq_cpu_set;
+	}
+
 	/* We've hit an error - don't reset SB_RDONLY */
 	if (sb_rdonly(sb))
 		old_flags |= SB_RDONLY;
-- 
Ammar Faizi

