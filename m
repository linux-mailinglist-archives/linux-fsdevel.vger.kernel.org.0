Return-Path: <linux-fsdevel+bounces-24650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B3194247F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 04:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72511C2100A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89175125D6;
	Wed, 31 Jul 2024 02:29:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4B101C4;
	Wed, 31 Jul 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392994; cv=none; b=EVGlvCKPXXKXnSkeT/p+yIN277j9Wxts+7HcUUCmjLudjl11c8iTBIPwSmQleDTrQN6mxL5RhQ6agK6/Sso6NlvjVKiYI20L+pVALbH75vNToRQUoOutKlnYPHykmdXlq+IFUM87/m3ip26laEZFxvda/TnH03w4RtbRHlfZeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392994; c=relaxed/simple;
	bh=LlnuslYaQ8KhVwTZAdfKpQYUoDOj4pvU43UCsUm8Vsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EyLpMcwIZaUX3XqiFVBSZ3GCDBS4fXxeKJYOHunYMlybjxv5XxW7t6ZV/2EQ2oLeaTjdWIJ7veRWVapo1qFwd7WrK1RSKc/aa9U/Np4+Uut3aqgQqRkm3MYxJ8M6uZ4D2ybpKTzcUylWdukKAZrFnGLRfWZbWfpbbH65nmFk8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46V2RVdo047322;
	Wed, 31 Jul 2024 10:27:31 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WYbSg58Mvz2MNxgJ;
	Wed, 31 Jul 2024 10:21:39 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jul 2024 10:27:28 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>, <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
        <dongliang.cui@unisoc.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH v3] exfat: check disk status during buffer write
Date: Wed, 31 Jul 2024 10:27:15 +0800
Message-ID: <20240731022715.4044482-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 46V2RVdo047322

We found that when writing a large file through buffer write, if the
disk is inaccessible, exFAT does not return an error normally, which
leads to the writing process not stopping properly.

To easily reproduce this issue, you can follow the steps below:

1. format a device to exFAT and then mount (with a full disk erase)
2. dd if=/dev/zero of=/exfat_mount/test.img bs=1M count=8192
3. eject the device

You may find that the dd process does not stop immediately and may
continue for a long time.

The root cause of this issue is that during buffer write process,
exFAT does not need to access the disk to look up directory entries
or the FAT table (whereas FAT would do) every time data is written.
Instead, exFAT simply marks the buffer as dirty and returns,
delegating the writeback operation to the writeback process.

If the disk cannot be accessed at this time, the error will only be
returned to the writeback process, and the original process will not
receive the error, so it cannot be returned to the user side.

When the disk cannot be accessed normally, an error should be returned
to stop the writing process.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
Changes in v3:
 - Implement .shutdown to monitor disk status.
---
 fs/exfat/exfat_fs.h | 10 ++++++++++
 fs/exfat/inode.c    |  3 +++
 fs/exfat/super.c    | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index ecc5db952deb..c6cf36070aa3 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -148,6 +148,9 @@ enum {
 #define DIR_CACHE_SIZE		\
 	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
 
+/* Superblock flags */
+#define EXFAT_FLAGS_SHUTDOWN	1
+
 struct exfat_dentry_namebuf {
 	char *lfn;
 	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
@@ -267,6 +270,8 @@ struct exfat_sb_info {
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
 
+	unsigned long s_exfat_flags; /* Exfat superblock flags */
+
 	struct mutex s_lock; /* superblock lock */
 	struct mutex bitmap_lock; /* bitmap lock */
 	struct exfat_mount_options options;
@@ -338,6 +343,11 @@ static inline struct exfat_inode_info *EXFAT_I(struct inode *inode)
 	return container_of(inode, struct exfat_inode_info, vfs_inode);
 }
 
+static inline int exfat_forced_shutdown(struct super_block *sb)
+{
+	return test_bit(EXFAT_FLAGS_SHUTDOWN, &EXFAT_SB(sb)->s_exfat_flags);
+}
+
 /*
  * If ->i_mode can't hold 0222 (i.e. ATTR_RO), we use ->i_attrs to
  * save ATTR_RO instead of ->i_mode.
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index dd894e558c91..b1b814183494 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -452,6 +452,9 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
+	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	ret = block_write_begin(mapping, pos, len, pagep, exfat_get_block);
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 323ecebe6f0e..9d7d9c4ba55a 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -167,6 +167,16 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static void exfat_shutdown(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (exfat_forced_shutdown(sb))
+		return;
+
+	set_bit(EXFAT_FLAGS_SHUTDOWN, &sbi->s_exfat_flags);
+}
+
 static struct inode *exfat_alloc_inode(struct super_block *sb)
 {
 	struct exfat_inode_info *ei;
@@ -193,6 +203,7 @@ static const struct super_operations exfat_sops = {
 	.sync_fs	= exfat_sync_fs,
 	.statfs		= exfat_statfs,
 	.show_options	= exfat_show_options,
+	.shutdown	= exfat_shutdown,
 };
 
 enum {
-- 
2.25.1


