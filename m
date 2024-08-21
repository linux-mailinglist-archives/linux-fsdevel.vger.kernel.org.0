Return-Path: <linux-fsdevel+bounces-26470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C4959C68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC9283712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E65196D9D;
	Wed, 21 Aug 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="gLb8NXB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-gcp.globallogic.com (smtp-gcp.globallogic.com [34.141.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C4155307;
	Wed, 21 Aug 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.141.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244784; cv=none; b=aolxKjBCkbozRvKp2T4npFLwGj1UXFaUqCK37V7GJ2BqB3s+WFyThLhMe3czPbScddNLtcioRRMY2LXAujXiUCQUJg/E8srk9DUPYSZ90dCOO2NtgwjbdJO4wVDpxnXSN4kDLOuVXUQzPYLpe9GMdEMC8QAAGzre2CqgO0z8J+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244784; c=relaxed/simple;
	bh=xTX0dfKj9i2Zw3FaQPO5WrbqDNt90N4k2QsnjUFhodc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cm03y6Bgdzn3JehAvCWs9wI3vj6AWMQtEjKP4ABSTqH/xnBJuQfjibpFmQajgDEB6InUeaBhL5H2K0UQliEBOkzlZ7iIigjk1Rd2YMb0E5s4mWqQPYGILhkioZ6DpBkN3p+RTk86iRU+lqwwyhMdCeW+1KgOGGk/wqH6cNSVf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=gLb8NXB9; arc=none smtp.client-ip=34.141.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
Received: from KBP1-LHP-A14474.synapse.com (unknown [172.22.130.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gcp.globallogic.com (Postfix) with ESMTPSA id 56C0610ACE0F;
	Wed, 21 Aug 2024 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=smtp-kbp; t=1724244774;
	bh=Z4AJKXft5S6EaREQvugvi4DFuawlzwtRcf2u4kApdo4=;
	h=From:To:Cc:Subject:Date:From;
	b=gLb8NXB9M3DEvRatqHu1NU7QhdZeGlFCObzj68wDz7TxODS7FGvH2+hUFaPPa2ogz
	 hNr0fd62RWxa9LuOqLpEldEMLp/sgUNjTQcyd78vYcUUBI7wwn/plDEnQ+lFCM1Bmv
	 IF4HdP/Pwmxymcw1f6m/2tjM6IPq7RUBWPGPxHs2Sq2YGUM+j3Ikxgm1yLYLKKnhab
	 WUDxrcuTFPI4vVRoR7MTfXJ7BavT6WCt3zFOKrBqWbsaqqjGzUVjdmrZJJGTwvAhcj
	 3oJGB+bYf3ei+WCr+t/UcHtZ25kHVMfW/UXhwsyOEG0evHdfxFdCRU2RKNLPwXlDMD
	 dnkENz5+sW1tA==
From: andrii.polianytsia@globallogic.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: zach.malinowski@garmin.com,
	artem.dombrovskyi@globallogic.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Andrii Polianytsia <andrii.polianytsia@globallogic.com>,
	Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
Subject: [PATCH v2] fs/exfat: add NFS export support
Date: Wed, 21 Aug 2024 15:51:37 +0300
Message-Id: <20240821125137.36304-1-andrii.polianytsia@globallogic.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Polianytsia <andrii.polianytsia@globallogic.com>

Add NFS export support to the exFAT filesystem by implementing
the necessary export operations in fs/exfat/super.c. Enable
exFAT filesystems to be exported and accessed over NFS, enhancing
their utility in networked environments.

Introduce the exfat_export_ops structure, which includes
functions to handle file handles and inode lookups necessary for NFS
operations.

Given the similarities between exFAT and FAT filesystems, and that FAT
supports exporting via NFS, this implementation is based on the existing logic
in the FAT filesystem's NFS export code (fs/fat/nfs.c).

Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
---
v2
Add information about similar implementation logic
from fs/fat/nfs.c to the commit message.

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


