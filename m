Return-Path: <linux-fsdevel+bounces-6967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF281F0CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB81C2243A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520F46556;
	Wed, 27 Dec 2023 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQu7/lTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E946524;
	Wed, 27 Dec 2023 17:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E073BC433C9;
	Wed, 27 Dec 2023 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703697443;
	bh=UyjBwW0wkBL1qZTGRKDJoSDef6ohi3jee7V8AMdA4uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQu7/lTIHfd75ne/sZPgjpyc/3bfqgWFPzfyQMdqUvuXrwoDPgwM7phinskqLWQMi
	 uLoQhRNHLb17IcTT0Do1M8fDVSXZZDpJxB2bsRC24STR4FXpvg1IcYPLK9s7D/UECM
	 flRtpxML1xFv3R9sNj9pLlLFdVlmSXi0EoegJXzbLTBTKhdV1Rro9IAA7tkR4Me9jd
	 kgIP+CBKu/OPte/qRzzufoAgAuQxfm6+E0gOFbWaKn90IwtFmc5CecF/5RlOyDTUyy
	 vD6U7MAuytD2CcVqoCh9iNMVJKntlOzPgvdJZxN4x0+qgUBjcEqBFSjE0+OzTdigVu
	 XBU2xoE3fARTg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/2] f2fs: move release of block devices to after kill_block_super()
Date: Wed, 27 Dec 2023 11:14:28 -0600
Message-ID: <20231227171429.9223-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227171429.9223-1-ebiggers@kernel.org>
References: <20231227171429.9223-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Call destroy_device_list() and free the f2fs_sb_info from
kill_f2fs_super(), after the call to kill_block_super().  This is
necessary to order it after the call to fscrypt_destroy_keyring() once
generic_shutdown_super() starts calling fscrypt_destroy_keyring() just
after calling ->put_super.  This is because fscrypt_destroy_keyring()
may call into f2fs_get_devices() via the fscrypt_operations.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/super.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1d..d66e0692ac02e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1710,42 +1710,39 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_segment_manager(sbi);
 
 	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
 
 	f2fs_destroy_post_read_wq(sbi);
 
 	kvfree(sbi->ckpt);
 
-	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 	kfree(sbi->raw_super);
 
-	destroy_device_list(sbi);
 	f2fs_destroy_page_array_cache(sbi);
 	f2fs_destroy_xattr_caches(sbi);
 	mempool_destroy(sbi->write_io_dummy);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
 	destroy_percpu_info(sbi);
 	f2fs_destroy_iostat(sbi);
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
 }
 
 int f2fs_sync_fs(struct super_block *sb, int sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int err = 0;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return 0;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
@@ -4895,23 +4892,23 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 			const char *dev_name, void *data)
 {
 	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
 }
 
 static void kill_f2fs_super(struct super_block *sb)
 {
-	if (sb->s_root) {
-		struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
+	if (sb->s_root) {
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
 		f2fs_stop_gc_thread(sbi);
 		f2fs_stop_discard_thread(sbi);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		/*
 		 * latter evict_inode() can bypass checking and invalidating
 		 * compress inode cache.
 		 */
 		if (test_opt(sbi, COMPRESS_CACHE))
@@ -4924,20 +4921,26 @@ static void kill_f2fs_super(struct super_block *sb)
 				.reason = CP_UMOUNT,
 			};
 			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			f2fs_write_checkpoint(sbi, &cpc);
 		}
 
 		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && f2fs_readonly(sb))
 			sb->s_flags &= ~SB_RDONLY;
 	}
 	kill_block_super(sb);
+	/* Release block devices last, after fscrypt_destroy_keyring(). */
+	if (sbi) {
+		destroy_device_list(sbi);
+		kfree(sbi);
+		sb->s_fs_info = NULL;
+	}
 }
 
 static struct file_system_type f2fs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
 	.kill_sb	= kill_f2fs_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("f2fs");
-- 
2.43.0


