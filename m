Return-Path: <linux-fsdevel+bounces-23548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6292E133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC720B21389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075F14883C;
	Thu, 11 Jul 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1czT8TX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B913B59F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684181; cv=none; b=usfWZwR4AMSI+GBR8R/SvlW4iyjJw0Z6E4V0Kefg0qA4yqtFkjEeNJItHAqT7ZYWYiw2L9/q70QkZZncXumQC6lgMiiv/mrDuT+Efb+a46YJMyRoGUyS6D7gUAEqZVz0bKRky5M20nMhMkq4YTu+S0fOX/3LfPn8EBOobaK3yHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684181; c=relaxed/simple;
	bh=t8D1/JWAZsYhyEFIpC9YhtGy7mBtuQi1FWOchWEysSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYeF/zbCV4tBkxQr+6XnSmGkezWsZu+zUZfyMZKkCSWnAvmJIsIL/xGOHLrz7HVE4hC44M0h/910sccBITQdXoP2pnhEJeqNKMzjjristisHFn0sbWgfVxF61DJbBTPFcWCgaHXaY2PInNNnvcK/5+B7O0NYOnEp7qyJEGBXg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1czT8TX; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720684177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0Pv6QDalGXk7IOv6qaWwK0TM7yMO9uy++QJx87szJ0=;
	b=V1czT8TX/qHoOVV8Aij2cRLFZZ5RmeOmF3oEKog+Us0DDoT3Ko9CoG+7KpK6NA0BPi8Ksb
	MGq3naYYb2Ev1uSSVGcMRHcKVdHMC5JjLTteuD/lCktVRzGvXZodevgWoQC9BWMC/QTuA0
	d52c0i65ghvF1bbDX4YkTEh+PKgKXOI=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/3] f2fs: make module init/exit match their sequence
Date: Thu, 11 Jul 2024 15:48:57 +0800
Message-Id: <20240711074859.366088-2-youling.tang@linux.dev>
In-Reply-To: <20240711074859.366088-1-youling.tang@linux.dev>
References: <20240711074859.366088-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Use init_sequence to ensure that modules init and exit are in sequence
and to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/f2fs/debug.c |   3 +-
 fs/f2fs/f2fs.h  |   4 +-
 fs/f2fs/super.c | 210 ++++++++++++++++++++++++------------------------
 3 files changed, 107 insertions(+), 110 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8b0e1e71b667..c08ecf807066 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -727,7 +727,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	kfree(si);
 }
 
-void __init f2fs_create_root_stats(void)
+int __init f2fs_create_root_stats(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
@@ -735,6 +735,7 @@ void __init f2fs_create_root_stats(void)
 	debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL,
 			    &stat_fops);
 #endif
+	return 0;
 }
 
 void f2fs_destroy_root_stats(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1974b6aff397..d546bd301565 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4086,7 +4086,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi);
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
-void __init f2fs_create_root_stats(void);
+int __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
@@ -4128,7 +4128,7 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 
 static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
-static inline void __init f2fs_create_root_stats(void) { }
+static inline int __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
 static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f1b3647a998..19509942b837 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4940,120 +4940,116 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(f2fs_inode_cachep);
 }
 
-static int __init init_f2fs_fs(void)
+static int register_f2fs(void)
 {
-	int err;
+	return register_filesystem(&f2fs_fs_type);
+}
 
-	err = init_inodecache();
-	if (err)
-		goto fail;
-	err = f2fs_create_node_manager_caches();
-	if (err)
-		goto free_inodecache;
-	err = f2fs_create_segment_manager_caches();
-	if (err)
-		goto free_node_manager_caches;
-	err = f2fs_create_checkpoint_caches();
-	if (err)
-		goto free_segment_manager_caches;
-	err = f2fs_create_recovery_cache();
-	if (err)
-		goto free_checkpoint_caches;
-	err = f2fs_create_extent_cache();
-	if (err)
-		goto free_recovery_cache;
-	err = f2fs_create_garbage_collection_cache();
-	if (err)
-		goto free_extent_cache;
-	err = f2fs_init_sysfs();
-	if (err)
-		goto free_garbage_collection_cache;
-	err = f2fs_init_shrinker();
-	if (err)
-		goto free_sysfs;
-	err = register_filesystem(&f2fs_fs_type);
-	if (err)
-		goto free_shrinker;
-	f2fs_create_root_stats();
-	err = f2fs_init_post_read_processing();
-	if (err)
-		goto free_root_stats;
-	err = f2fs_init_iostat_processing();
-	if (err)
-		goto free_post_read;
-	err = f2fs_init_bio_entry_cache();
-	if (err)
-		goto free_iostat;
-	err = f2fs_init_bioset();
-	if (err)
-		goto free_bio_entry_cache;
-	err = f2fs_init_compress_mempool();
-	if (err)
-		goto free_bioset;
-	err = f2fs_init_compress_cache();
-	if (err)
-		goto free_compress_mempool;
-	err = f2fs_create_casefold_cache();
-	if (err)
-		goto free_compress_cache;
-	return 0;
-free_compress_cache:
-	f2fs_destroy_compress_cache();
-free_compress_mempool:
-	f2fs_destroy_compress_mempool();
-free_bioset:
-	f2fs_destroy_bioset();
-free_bio_entry_cache:
-	f2fs_destroy_bio_entry_cache();
-free_iostat:
-	f2fs_destroy_iostat_processing();
-free_post_read:
-	f2fs_destroy_post_read_processing();
-free_root_stats:
-	f2fs_destroy_root_stats();
+static void unregister_f2fs(void)
+{
 	unregister_filesystem(&f2fs_fs_type);
-free_shrinker:
-	f2fs_exit_shrinker();
-free_sysfs:
-	f2fs_exit_sysfs();
-free_garbage_collection_cache:
-	f2fs_destroy_garbage_collection_cache();
-free_extent_cache:
-	f2fs_destroy_extent_cache();
-free_recovery_cache:
-	f2fs_destroy_recovery_cache();
-free_checkpoint_caches:
-	f2fs_destroy_checkpoint_caches();
-free_segment_manager_caches:
-	f2fs_destroy_segment_manager_caches();
-free_node_manager_caches:
-	f2fs_destroy_node_manager_caches();
-free_inodecache:
-	destroy_inodecache();
-fail:
-	return err;
+}
+
+/* Helper structure for long init/exit functions. */
+struct init_sequence {
+	int (*init_func)(void);
+	/* Can be NULL if the init_func doesn't need cleanup. */
+	void (*exit_func)(void);
+};
+
+static const struct init_sequence mod_init_seq[] = {
+	{
+		.init_func = init_inodecache,
+		.exit_func = destroy_inodecache,
+	}, {
+		.init_func = f2fs_create_node_manager_caches,
+		.exit_func = f2fs_destroy_node_manager_caches,
+	}, {
+		.init_func = f2fs_create_segment_manager_caches,
+		.exit_func = f2fs_destroy_segment_manager_caches,
+	}, {
+		.init_func = f2fs_create_checkpoint_caches,
+		.exit_func = f2fs_destroy_checkpoint_caches,
+	}, {
+		.init_func = f2fs_create_recovery_cache,
+		.exit_func = f2fs_destroy_recovery_cache,
+	}, {
+		.init_func = f2fs_create_extent_cache,
+		.exit_func = f2fs_destroy_extent_cache,
+	}, {
+		.init_func = f2fs_create_garbage_collection_cache,
+		.exit_func = f2fs_destroy_garbage_collection_cache,
+	}, {
+		.init_func = f2fs_init_sysfs,
+		.exit_func = f2fs_exit_sysfs,
+	}, {
+		.init_func = f2fs_init_shrinker,
+		.exit_func = f2fs_exit_shrinker,
+	}, {
+		.init_func = register_f2fs,
+		.exit_func = unregister_f2fs,
+	}, {
+		.init_func = f2fs_create_root_stats,
+		.exit_func = f2fs_destroy_root_stats,
+	}, {
+		.init_func = f2fs_init_post_read_processing,
+		.exit_func = f2fs_destroy_post_read_processing,
+	}, {
+		.init_func = f2fs_init_iostat_processing,
+		.exit_func = f2fs_destroy_iostat_processing,
+	}, {
+		.init_func = f2fs_init_bio_entry_cache,
+		.exit_func = f2fs_destroy_bio_entry_cache,
+	}, {
+		.init_func = f2fs_init_bioset,
+		.exit_func = f2fs_destroy_bioset,
+	}, {
+		.init_func = f2fs_init_compress_mempool,
+		.exit_func = f2fs_destroy_compress_mempool,
+	}, {
+		.init_func = f2fs_init_compress_cache,
+		.exit_func = f2fs_destroy_compress_cache,
+	}, {
+		.init_func = f2fs_create_casefold_cache,
+		.exit_func = f2fs_destroy_casefold_cache,
+	}
+};
+
+static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
+
+static __always_inline void f2fs_exit_f2fs_fs(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
+		if (!mod_init_result[i])
+			continue;
+		if (mod_init_seq[i].exit_func)
+			mod_init_seq[i].exit_func();
+		mod_init_result[i] = false;
+	}
 }
 
 static void __exit exit_f2fs_fs(void)
 {
-	f2fs_destroy_casefold_cache();
-	f2fs_destroy_compress_cache();
-	f2fs_destroy_compress_mempool();
-	f2fs_destroy_bioset();
-	f2fs_destroy_bio_entry_cache();
-	f2fs_destroy_iostat_processing();
-	f2fs_destroy_post_read_processing();
-	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
-	f2fs_exit_shrinker();
-	f2fs_exit_sysfs();
-	f2fs_destroy_garbage_collection_cache();
-	f2fs_destroy_extent_cache();
-	f2fs_destroy_recovery_cache();
-	f2fs_destroy_checkpoint_caches();
-	f2fs_destroy_segment_manager_caches();
-	f2fs_destroy_node_manager_caches();
-	destroy_inodecache();
+	f2fs_exit_f2fs_fs();
+}
+
+static int __init init_f2fs_fs(void)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
+		BUG_ON(mod_init_result[i]);
+		ret = mod_init_seq[i].init_func();
+		if (ret < 0) {
+			f2fs_exit_f2fs_fs();
+			return ret;
+		}
+		mod_init_result[i] = true;
+	}
+	return 0;
 }
 
 module_init(init_f2fs_fs)
-- 
2.34.1


