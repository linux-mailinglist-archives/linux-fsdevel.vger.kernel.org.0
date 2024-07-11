Return-Path: <linux-fsdevel+bounces-23549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C792E13A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79203283581
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BD1514F0;
	Thu, 11 Jul 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jSvwbqw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D814B97D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684185; cv=none; b=oXMdE9HjFhPhMFOlTiz+K6058eRh7by3Y/vjaqZ1b/ToEGcArlIpKoIelutlJgDRuAAn1mK/Y5sxRj/NH6cOlUtI3FBmFE+y63eVSofHK7o67crfFGY/RRzxxa2Ho9kfH9w7DO9bs5Ogd9xlwj2meteZtJWPxxpwUJJsIxwFwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684185; c=relaxed/simple;
	bh=kSFRTa8cWH/vlSHnN9DUZZkdaba4iKL31E4sVSEpMEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euqEu26CGyevLh7OSVtiUzhLE666utTVGl2ZWeFUxpkvWd3QuXIY5ZVZDUlaApl01nLIe/N5nIz1f8eIellVX/bVc/p1CXW4ytvW9mpeI6fE5mcfi0k0dhOCDDWQiECCCZDShHrbh23MS7DQL2y167dyLNO6/FsJfp4CFCfTukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jSvwbqw3; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720684182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFljGRgWS+o+/FKeNHoSuAwsaBjm894r1O3P7vtGZus=;
	b=jSvwbqw3JyuWV/rQ+ZE2imPoy05s3NrdV5LAgLTjuyX+UDtp/EV2WTfYpEP+Emd5kSmXF7
	7gAa6C0nAliSpduOxjQsD12PSVsToOrc5CnXNaemS/16UIWhsZIz0T2CwNZuE4mbd8j9XI
	HtdV9C6O9Qu2SOKnoEJC1WSdobq3lP0=
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
Subject: [PATCH 2/3] ext4: make ext4 init/exit match their sequence
Date: Thu, 11 Jul 2024 15:48:58 +0800
Message-Id: <20240711074859.366088-3-youling.tang@linux.dev>
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
 fs/ext4/super.c | 175 +++++++++++++++++++++++++-----------------------
 1 file changed, 93 insertions(+), 82 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..ec1e63facb10 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7314,103 +7314,114 @@ static struct file_system_type ext4_fs_type = {
 };
 MODULE_ALIAS_FS("ext4");
 
-/* Shared across all ext4 file systems */
-wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
-
-static int __init ext4_init_fs(void)
+static int register_ext(void)
 {
-	int i, err;
-
-	ratelimit_state_init(&ext4_mount_msg_ratelimit, 30 * HZ, 64);
-	ext4_li_info = NULL;
+	register_as_ext3();
+	register_as_ext2();
+	return register_filesystem(&ext4_fs_type);
+}
 
-	/* Build-time check for flags consistency */
-	ext4_check_flag_values();
+static void unregister_ext(void)
+{
+	unregister_as_ext2();
+	unregister_as_ext3();
+	unregister_filesystem(&ext4_fs_type);
+}
 
-	for (i = 0; i < EXT4_WQ_HASH_SZ; i++)
-		init_waitqueue_head(&ext4__ioend_wq[i]);
+/* Helper structure for long init/exit functions. */
+struct init_sequence {
+	int (*init_func)(void);
+	/* Can be NULL if the init_func doesn't need cleanup. */
+	void (*exit_func)(void);
+};
 
-	err = ext4_init_es();
-	if (err)
-		return err;
+static const struct init_sequence mod_init_seq[] = {
+	{
+		.init_func = ext4_init_es,
+		.exit_func = ext4_exit_es,
+	}, {
+		.init_func = ext4_init_pending,
+		.exit_func = ext4_exit_pending,
+	}, {
+		.init_func = ext4_init_post_read_processing,
+		.exit_func = ext4_exit_post_read_processing,
+	}, {
+		.init_func = ext4_init_pageio,
+		.exit_func = ext4_exit_pageio,
+	}, {
+		.init_func = ext4_init_system_zone,
+		.exit_func = ext4_exit_system_zone,
+	}, {
+		.init_func = ext4_init_sysfs,
+		.exit_func = ext4_exit_sysfs,
+	}, {
+		.init_func = ext4_init_mballoc,
+		.exit_func = ext4_exit_mballoc,
+	}, {
+		.init_func = init_inodecache,
+		.exit_func = destroy_inodecache,
+	}, {
+		.init_func = ext4_fc_init_dentry_cache,
+		.exit_func = ext4_fc_destroy_dentry_cache,
+	}, {
+		.init_func = register_ext,
+		.exit_func = unregister_ext,
+	}
+};
 
-	err = ext4_init_pending();
-	if (err)
-		goto out7;
+static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-	err = ext4_init_post_read_processing();
-	if (err)
-		goto out6;
+static __always_inline void ext4_exit_ext4_fs(void)
+{
+	int i;
 
-	err = ext4_init_pageio();
-	if (err)
-		goto out5;
+	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
+		if (!mod_init_result[i])
+			continue;
+		if (mod_init_seq[i].exit_func)
+			mod_init_seq[i].exit_func();
+		mod_init_result[i] = false;
+	}
+}
 
-	err = ext4_init_system_zone();
-	if (err)
-		goto out4;
+static void __exit ext4_exit_fs(void)
+{
+	ext4_destroy_lazyinit_thread();
+	ext4_exit_ext4_fs();
+}
 
-	err = ext4_init_sysfs();
-	if (err)
-		goto out3;
+static __always_inline int ext4_init_ext4_fs(void)
+{
+	int ret;
+	int i;
 
-	err = ext4_init_mballoc();
-	if (err)
-		goto out2;
-	err = init_inodecache();
-	if (err)
-		goto out1;
+	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
+		ASSERT(!mod_init_result[i]);
+		ret = mod_init_seq[i].init_func();
+		if (ret < 0) {
+			ext4_exit_ext4_fs();
+			return ret;
+		}
+		mod_init_result[i] = true;
+	}
+	return 0;
+}
 
-	err = ext4_fc_init_dentry_cache();
-	if (err)
-		goto out05;
+/* Shared across all ext4 file systems */
+wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
 
-	register_as_ext3();
-	register_as_ext2();
-	err = register_filesystem(&ext4_fs_type);
-	if (err)
-		goto out;
+static int __init ext4_init_fs(void)
+{
+	ratelimit_state_init(&ext4_mount_msg_ratelimit, 30 * HZ, 64);
+	ext4_li_info = NULL;
 
-	return 0;
-out:
-	unregister_as_ext2();
-	unregister_as_ext3();
-	ext4_fc_destroy_dentry_cache();
-out05:
-	destroy_inodecache();
-out1:
-	ext4_exit_mballoc();
-out2:
-	ext4_exit_sysfs();
-out3:
-	ext4_exit_system_zone();
-out4:
-	ext4_exit_pageio();
-out5:
-	ext4_exit_post_read_processing();
-out6:
-	ext4_exit_pending();
-out7:
-	ext4_exit_es();
+	/* Build-time check for flags consistency */
+	ext4_check_flag_values();
 
-	return err;
-}
+	for (int i = 0; i < EXT4_WQ_HASH_SZ; i++)
+		init_waitqueue_head(&ext4__ioend_wq[i]);
 
-static void __exit ext4_exit_fs(void)
-{
-	ext4_destroy_lazyinit_thread();
-	unregister_as_ext2();
-	unregister_as_ext3();
-	unregister_filesystem(&ext4_fs_type);
-	ext4_fc_destroy_dentry_cache();
-	destroy_inodecache();
-	ext4_exit_mballoc();
-	ext4_exit_sysfs();
-	ext4_exit_system_zone();
-	ext4_exit_pageio();
-	ext4_exit_post_read_processing();
-	ext4_exit_es();
-	ext4_exit_pending();
+	return ext4_init_ext4_fs();
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
-- 
2.34.1


