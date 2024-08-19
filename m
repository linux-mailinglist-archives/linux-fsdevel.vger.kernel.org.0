Return-Path: <linux-fsdevel+bounces-26259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC7956AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1A71F22AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782A16B749;
	Mon, 19 Aug 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="HU33gL+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-gcp.globallogic.com (smtp-gcp.globallogic.com [34.141.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AA16B397;
	Mon, 19 Aug 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.141.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070145; cv=none; b=JEzygXa5nO9oOKDheb9c2DFEbTRFcHdBC37gpDNNCNVAdzPKZSqLwqYFk2nrSUOABcZVVDbmYe6cPiCgdT/Z5z6mKMmQT0/hNNHCuHASK7gh0Ev42MHn3fOv38IuXvS3gGyoISo63z/9Jf0h/N+666ZhzTovkCAgvJPziOMiOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070145; c=relaxed/simple;
	bh=l3rnuOVeuDgXuBMCSynPabSVDMK1NVcIBJ15TwJZBmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIbQ8+B+58+O2ULw5T3iLLPo7/iF19qKFHwM/06fbo15VdpwHWYJXgpbFbNWE3rVKElLE2onA6VX4HiMKGswZdLWlprqu2dArkIpPYvizP30xAN2UrUOoL0mLrTnnfieQyUT4ZdZfkLO8rV6BgChwx0MWwafXOyuJ/nFA4mGIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=HU33gL+C; arc=none smtp.client-ip=34.141.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
Received: from KBP1-LHP-A14474.synapse.com (unknown [172.22.130.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gcp.globallogic.com (Postfix) with ESMTPSA id 7BB5810AA16C;
	Mon, 19 Aug 2024 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=smtp-kbp; t=1724069742;
	bh=0LJeP7LSGwMpodtCsRzZk4Ldvm/eC1mSXQdjUTuOMhY=;
	h=From:To:Cc:Subject:Date:From;
	b=HU33gL+CCKD3S+HWb7z0PdOiAPOacb69CJ7EIGnWdobSBt9W1cSnndKYluKSvlYcg
	 nlxzsDk4iIJcQplhpT5RO2sAXAev+KQp9kqywL9XRtWUAAHBU4OKMIObesRirCJT2G
	 O0zZCOYlaPy7W6vSRAUeYvxEevd+CQ2bOZFwaSLQ2rPGBeY2FoLX6e5tCELuROtzbJ
	 EEth+znH9jTig2UGdWw/zElSkHtAdNHbKBJrbmjWL1kERJqAZ4xmJwHHs3YDP/a5qL
	 D2Be5fa3FUyr/fp/KGfCaYn68Y0WxS1quDl7eeppZMQhzQw72hpVMwZFuTnwVeVK4H
	 JkAyR9MReCcdg==
From: andrii.polianytsia@globallogic.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: zach.malinowski@garmin.com,
	artem.dombrovskyi@globallogic.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>,
	Andrii Polianytsia <andrii.polianytsia@globallogic.com>
Subject: [PATCH] fs/exfat: add NFS export support
Date: Mon, 19 Aug 2024 15:15:28 +0300
Message-Id: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NFS export support to the exFAT filesystem by implementing
the necessary export operations in fs/exfat/super.c. Enable
exFAT filesystems to be exported and accessed over NFS, enhancing
their utility in networked environments.

Introduce the exfat_export_ops structure, which includes
functions to handle file handles and inode lookups necessary for NFS
operations.

Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
---
 fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 323ecebe6f0e..cb6dcafc3007 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include <linux/exportfs.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
 	.show_options	= exfat_show_options,
 };
 
+/**
+ * exfat_export_get_inode - Get inode for export operations
+ * @sb: Superblock pointer
+ * @ino: Inode number
+ * @generation: Generation number
+ *
+ * Returns pointer to inode or error pointer in case of an error.
+ */
+static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
+	u32 generation)
+{
+	struct inode *inode = NULL;
+
+	if (ino == 0)
+		return ERR_PTR(-ESTALE);
+
+	inode = ilookup(sb, ino);
+	if (inode && generation && inode->i_generation != generation) {
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+
+	return inode;
+}
+
+/**
+ * exfat_fh_to_dentry - Convert file handle to dentry
+ * @sb: Superblock pointer
+ * @fid: File identifier
+ * @fh_len: Length of the file handle
+ * @fh_type: Type of the file handle
+ *
+ * Returns dentry corresponding to the file handle.
+ */
+static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
+	struct fid *fid, int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+		exfat_export_get_inode);
+}
+
+/**
+ * exfat_fh_to_parent - Convert file handle to parent dentry
+ * @sb: Superblock pointer
+ * @fid: File identifier
+ * @fh_len: Length of the file handle
+ * @fh_type: Type of the file handle
+ *
+ * Returns parent dentry corresponding to the file handle.
+ */
+static struct dentry *exfat_fh_to_parent(struct super_block *sb,
+	struct fid *fid, int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+		exfat_export_get_inode);
+}
+
+static const struct export_operations exfat_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
+	.fh_to_dentry = exfat_fh_to_dentry,
+	.fh_to_parent = exfat_fh_to_parent,
+};
+
 enum {
 	Opt_uid,
 	Opt_gid,
@@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = EXFAT_SUPER_MAGIC;
 	sb->s_op = &exfat_sops;
+	sb->s_export_op = &exfat_export_ops;
 
 	sb->s_time_gran = 10 * NSEC_PER_MSEC;
 	sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
-- 
2.25.1


