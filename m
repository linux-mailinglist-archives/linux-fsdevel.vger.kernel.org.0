Return-Path: <linux-fsdevel+bounces-46153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7DA83610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DD2465E59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B241E2843;
	Thu, 10 Apr 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewoFzbvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C61991DB;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249793; cv=none; b=SlBwwovPcSs585OCLqXRHIOluBsAKgp3AE9TvrP8Gtq7Y1w+1zj5f4S2zTDDqXn/iR2k6XWuIe5zPOXuK0lA3aMTa7oYvm5zdXJYKw8haY7BcKBAndJF4sE1YADUkxm4YDEE8G5oNMc9h4q4RujzQ63Pzeja4Pp+abnxjTMcafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249793; c=relaxed/simple;
	bh=WxZ1ENIkDUorMda0aZ6BTZiU7BtJJXWHNlFF1GnZUbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ori8X4Ci6EJqp+7T3CjURE4cBFhrCLsX//X1ERBfsnAblsw0iKuCXYjO06hjYckMtb0a/3DqW1zAq6RfB/Rd82mEVgI8UzBWLWunc0hWh3l1s6vubWn2Eczwci3AE8VoKuFEZSIxHPWhsxvlCzkjciZ8mU+OE4dA5b4UMpTbkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ewoFzbvy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lo+mNNCNF0Kcn2O97aAamvTUH5kTxQV3YmJyIlBZZYM=; b=ewoFzbvyobG0uDxAjVoFDwjHWk
	WuZ/3S9yAjfKR2FmAUSEeXkkrkoEv+JUrk7lOQjdFVWExzB7lNCFT/WwVAeEYTqA/sy2xN3HQia6i
	/ghOVN2nNtzpBl+oOAfTpEl6qx2iF9VVGH+99o+w8iKGr0xEC5ojaCJ2SSQGhESiqnCkB87He/3r8
	G+O96d8oiH4BoJHjpRwltFGCAvF/VC5EJEDVr5tvE1SIwBCillDTlLlrPdDeGASJydAFVQnvBxvOZ
	YZQBbE6LPTYlsCm4iSU/5Xr+xRWoVGrXbzvRonVbCbxo2U5PhfpawzAmeQ726cHZZIDKTeO97pgca
	Rfa3HOOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h36-00000008yvU-0WmT;
	Thu, 10 Apr 2025 01:49:48 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 8/8] mm: add migration buffer-head debugfs interface
Date: Wed,  9 Apr 2025 18:49:45 -0700
Message-ID: <20250410014945.2140781-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

If you are working on enhancing folio migration it is easy to not
be certain on improvements. This debugfs interface enables you to
evaluate gains on improvements on buffer-head folio migration.

This can easily tell you *why* folio migration might fail, for example,
here is the output of a generic/750 run for 18 hours:

root@e3-ext4-2k ~ # cat /sys/kernel/debug/mm/migrate/bh/stats

[buffer_migrate_folio]
                    calls       50160811
                  success       50047572
                    fails       113239

[buffer_migrate_folio_norefs]
                    calls       23577082468
                  success       2939858
                    fails       23574142610
                 jbd-meta       23425956714
          no-head-success       102
            no-head-fails       0
                  invalid       147919982
                    valid       2939881
            valid-success       2939756
              valid-fails       125

Success ratios:
buffer_migrate_folio: 99% success (50047572/50160811)
buffer_migrate_folio_norefs: 0% success (2939858/23577082468)

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 178 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8fed2655f2e8..c478e8218cb0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -44,6 +44,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/debugfs.h>
 
 #include <asm/tlbflush.h>
 
@@ -791,6 +792,126 @@ int migrate_folio(struct address_space *mapping, struct folio *dst,
 EXPORT_SYMBOL(migrate_folio);
 
 #ifdef CONFIG_BUFFER_HEAD
+
+static const char * const bh_routine_names[] = {
+	"buffer_migrate_folio",
+	"buffer_migrate_folio_norefs",
+};
+
+#define BH_STATS(X)							       \
+	X(bh_migrate_folio, 0, "calls")					       \
+	X(bh_migrate_folio_success, 0, "success")			       \
+	X(bh_migrate_folio_fails, 0, "fails")				       \
+	X(bh_migrate_folio_norefs, 1, "calls")				       \
+	X(bh_migrate_folio_norefs_success, 1, "success")		       \
+	X(bh_migrate_folio_norefs_fails, 1, "fails")			       \
+	X(bh_migrate_folio_norefs_meta, 1, "jbd-meta")			       \
+	X(bh_migrate_folio_norefs_nohead_success, 1, "no-head-success")	       \
+	X(bh_migrate_folio_norefs_nohead_fails, 1, "no-head-fails")	       \
+	X(bh_migrate_folio_norefs_invalid, 1, "invalid")		       \
+	X(bh_migrate_folio_norefs_valid, 1, "valid")			       \
+	X(bh_migrate_folio_norefs_valid_success, 1, "valid-success")	       \
+	X(bh_migrate_folio_norefs_valid_fails, 1, "valid-fails")
+
+
+#define DECLARE_STAT(name, routine_idx, meaning) static atomic_long_t name;
+BH_STATS(DECLARE_STAT)
+
+#define BH_STAT_PTR(name, routine_idx, meaning) &name,
+static atomic_long_t * const bh_stat_array[] = {
+	BH_STATS(BH_STAT_PTR)
+};
+
+#define BH_STAT_ROUTINE_IDX(name, routine_idx, meaning) routine_idx,
+static const int bh_stat_routine_index[] = {
+	BH_STATS(BH_STAT_ROUTINE_IDX)
+};
+
+#define BH_STAT_MEANING(name, routine_idx, meaning) meaning,
+static const char * const bh_stat_meanings[] = {
+	BH_STATS(BH_STAT_MEANING)
+};
+
+#define NUM_BH_STATS ARRAY_SIZE(bh_stat_array)
+
+static ssize_t read_file_bh_migrate_stats(struct file *file,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	char *buf;
+	unsigned int i, len = 0, size = NUM_BH_STATS * 128;
+	int ret, last_routine = -1;
+	unsigned long total, success, rate;
+
+	BUILD_BUG_ON(ARRAY_SIZE(bh_stat_array) != ARRAY_SIZE(bh_stat_meanings));
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < NUM_BH_STATS; i++) {
+		int routine_idx = bh_stat_routine_index[i];
+
+		if (routine_idx != last_routine) {
+			len += scnprintf(buf + len, size - len, "\n[%s]\n",
+					 bh_routine_names[routine_idx]);
+			last_routine = routine_idx;
+		}
+
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n",
+				 bh_stat_meanings[i],
+				 atomic_long_read(bh_stat_array[i]));
+
+	}
+
+	len += scnprintf(buf + len, size - len, "\nSuccess ratios:\n");
+
+	total = atomic_long_read(&bh_migrate_folio);
+	success = atomic_long_read(&bh_migrate_folio_success);
+	rate = total ? (success * 100) / total : 0;
+	len += scnprintf(buf + len, size - len,
+		"%s: %lu%% success (%lu/%lu)\n",
+		"buffer_migrate_folio", rate, success, total);
+
+	total = atomic_long_read(&bh_migrate_folio_norefs);
+	success = atomic_long_read(&bh_migrate_folio_norefs_success);
+	rate = total ? (success * 100) / total : 0;
+	len += scnprintf(buf + len, size - len,
+		"%s: %lu%% success (%lu/%lu)\n",
+		"buffer_migrate_folio_norefs", rate, success, total);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations fops_bh_migrate_stats = {
+	.read = read_file_bh_migrate_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static void mm_migrate_bh_init(struct dentry *migrate_debug_root)
+{
+	struct dentry *parent_dirs[ARRAY_SIZE(bh_routine_names)] = { NULL };
+	struct dentry *root = debugfs_create_dir("bh", migrate_debug_root);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bh_routine_names); i++)
+		parent_dirs[i] = debugfs_create_dir(bh_routine_names[i], root);
+
+	for (i = 0; i < NUM_BH_STATS; i++) {
+		int routine = bh_stat_routine_index[i];
+		debugfs_create_ulong(bh_stat_meanings[i], 0400,
+		                     parent_dirs[routine],
+		                     (unsigned long *)
+				     &bh_stat_array[i]->counter);
+	}
+
+	debugfs_create_file("stats", 0400, root, root, &fops_bh_migrate_stats);
+}
+
 /* Returns true if all buffers are successfully locked */
 static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 							enum migrate_mode mode)
@@ -833,16 +954,26 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	int expected_count;
 
 	head = folio_buffers(src);
-	if (!head)
-		return migrate_folio(mapping, dst, src, mode);
+	if (!head) {
+		rc = migrate_folio(mapping, dst, src, mode);
+		if (check_refs) {
+			if (rc == 0)
+				atomic_long_inc(&bh_migrate_folio_norefs_nohead_success);
+			else
+				atomic_long_inc(&bh_migrate_folio_norefs_nohead_fails);
+		}
+		return rc;
+	}
 
 	/* Check whether page does not have extra refs before we do more work */
 	expected_count = folio_expected_refs(mapping, src);
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	if (buffer_meta(head))
+	if (buffer_meta(head)) {
+		atomic_long_inc(&bh_migrate_folio_norefs_meta);
 		return -EAGAIN;
+	}
 
 	if (!buffer_migrate_lock_buffers(head, mode))
 		return -EAGAIN;
@@ -868,17 +999,23 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
+				atomic_long_inc(&bh_migrate_folio_norefs_invalid);
 				goto unlock_buffers;
 			}
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
 		}
+		atomic_long_inc(&bh_migrate_folio_norefs_valid);
 	}
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc != MIGRATEPAGE_SUCCESS) {
+		if (check_refs)
+			atomic_long_inc(&bh_migrate_folio_norefs_valid_fails);
 		goto unlock_buffers;
+	} else if (check_refs)
+		atomic_long_inc(&bh_migrate_folio_norefs_valid_success);
 
 	bh = head;
 	do {
@@ -915,7 +1052,16 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 int buffer_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	return __buffer_migrate_folio(mapping, dst, src, mode, false);
+	int ret;
+	atomic_long_inc(&bh_migrate_folio);
+
+	ret = __buffer_migrate_folio(mapping, dst, src, mode, false);
+	if (ret == 0)
+		atomic_long_inc(&bh_migrate_folio_success);
+	else
+		atomic_long_inc(&bh_migrate_folio_fails);
+
+	return ret;
 }
 EXPORT_SYMBOL(buffer_migrate_folio);
 
@@ -936,9 +1082,21 @@ EXPORT_SYMBOL(buffer_migrate_folio);
 int buffer_migrate_folio_norefs(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	return __buffer_migrate_folio(mapping, dst, src, mode, true);
+	int ret;
+
+	atomic_long_inc(&bh_migrate_folio_norefs);
+
+	ret = __buffer_migrate_folio(mapping, dst, src, mode, true);
+	if (ret == 0)
+		atomic_long_inc(&bh_migrate_folio_norefs_success);
+	else
+		atomic_long_inc(&bh_migrate_folio_norefs_fails);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
+#else
+static inline void mm_migrate_bh_init(struct dentry *migrate_debug_root) { }
 #endif /* CONFIG_BUFFER_HEAD */
 
 int filemap_migrate_folio(struct address_space *mapping,
@@ -2737,3 +2895,17 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
+
+static __init int mm_migrate_debugfs_init(void)
+{
+	struct dentry *mm_debug_root;
+	struct dentry *migrate_debug_root;
+
+	mm_debug_root = debugfs_create_dir("mm", NULL);
+	migrate_debug_root = debugfs_create_dir("migrate", mm_debug_root);
+
+	mm_migrate_bh_init(migrate_debug_root);
+
+	return 0;
+}
+fs_initcall(mm_migrate_debugfs_init);
-- 
2.47.2


