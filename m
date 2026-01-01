Return-Path: <linux-fsdevel+bounces-72316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C24CED2E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE5D3009566
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A02EF652;
	Thu,  1 Jan 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Iqrzk0Zd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F31405F7;
	Thu,  1 Jan 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767286429; cv=none; b=OoFqshntEbS/V7nUu0UT1dB3S+4tWMqcQkagiK65s/KpkaN4s6jt7M1qVU6fiWYbZWDQtXJMmwFBjyVT82ICzDfJO7HvCLG96P2Vkq1aHWJOKKtBdu9Jm10iH9FHlJUqtaQkvZe1dmRty7SEfvzK/VKe8wz/3heTHZg4Kh4EOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767286429; c=relaxed/simple;
	bh=nUiR8tlB61/EDMT7ua0ENSVfre7fPhmklPwxBKG3Arw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZeVfE/Ae1xMTQUTVjupcnqU+MWGuZXtA6Jxhm4yVDZ+ENVr9gsyeuYv1nC5eKaaPimDFqtI2k/sQ2dB5S1f5s3odV7ws5Gfv04HHP9XOnNb92hRuYSkXHDBX3iVgP+wxcFrx/3mFxvhf5vnEYl2wsite+b8r8rXRBpGjGXbKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Iqrzk0Zd; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767286427; x=1798822427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LAVtQlZC10zFPaGdMLRK/+kEsvrHzMi+b8hRasifzt4=;
  b=Iqrzk0ZdSNrXHVA4xGgFTcoMKmB6ns5N6DPuj9BTDO+rgBpU4dz2fzMp
   8PLpcJeilB9avaKgWpQOmIc/uchOUlYC0WTaagvGolUe+F0PrkKIMvGKP
   9PusqjO40UH8sBt43w6Ag+VSH0ztFnufFaA4U/vTiQ2mPDxFB5MWsVTQQ
   FozOwMqePjVe4D9FhxyNiHkGvAMRHvHxajEPX9nZtHohCu6xLS0OIVArz
   CgkVuxTZOhbDze7oozVn54MiCAnWJS8Sn+NlpmiJcfCGlDKzsH/xj+Lgv
   eeyzWP6ixFoIZDL8cXqyXHAIz3dj9Ya+gaKN7Dy5xL2ccUC6wD3j+szU3
   A==;
X-CSE-ConnectionGUID: DqzLt4rnR8OGAwwJZEFtGg==
X-CSE-MsgGUID: +8vMQLFITaGwkGYM4rr4/g==
X-IronPort-AV: E=Sophos;i="6.21,194,1763424000"; 
   d="scan'208";a="9870697"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 16:53:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:13190]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.60:2525] with esmtp (Farcaster)
 id 0266ac70-848b-47b6-a643-6cc8eb55bc71; Thu, 1 Jan 2026 16:53:45 +0000 (UTC)
X-Farcaster-Flow-ID: 0266ac70-848b-47b6-a643-6cc8eb55bc71
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 1 Jan 2026 16:53:45 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.27) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 1 Jan 2026 16:53:43 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>
Subject: [PATCH v1] fs: improve dump_inode() to safely access inode fields.
Date: Thu, 1 Jan 2026 16:53:04 +0000
Message-ID: <20260101165304.34516-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use get_kernel_nofault() to safely access inode and related structures
(superblock, file_system_type) to avoid crashing when the inode pointer
is invalid. This allows the same pattern as dump_mapping().

Note: The original access method for i_state and i_count is preserved,
as get_kernel_nofault() is unnecessary once the inode structure is
verified accessible.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/inode.c | 59 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a..259ff49189af 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2984,24 +2984,57 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 EXPORT_SYMBOL(mode_strip_sgid);
 
 #ifdef CONFIG_DEBUG_VFS
-/*
- * Dump an inode.
- *
- * TODO: add a proper inode dumping routine, this is a stub to get debug off the
- * ground.
+/**
+ * dump_inode - dump an inode.
+ * @inode: inode to dump
+ * @reason: reason for dumping
  *
- * TODO: handle getting to fs type with get_kernel_nofault()?
- * See dump_mapping() above.
+ * If inode is an invalid pointer, we don't want to crash accessing it,
+ * so probe everything depending on it carefully with get_kernel_nofault().
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb;
+	struct file_system_type *s_type;
+	const char *fs_name_ptr;
+	char fs_name[32] = {};
+	umode_t mode;
+	unsigned short opflags;
+	unsigned int flags;
+	unsigned int state;
+	int count;
+
+	pr_warn("%s encountered for inode %px\n", reason, inode);
+
+	if (get_kernel_nofault(sb, &inode->i_sb) ||
+	    get_kernel_nofault(mode, &inode->i_mode) ||
+	    get_kernel_nofault(opflags, &inode->i_opflags) ||
+	    get_kernel_nofault(flags, &inode->i_flags)) {
+		pr_warn("invalid inode:%px\n", inode);
+		return;
+	}
 
-	pr_warn("%s encountered for inode %px\n"
-		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
-		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
-		inode->i_flags, inode_state_read_once(inode), atomic_read(&inode->i_count));
-}
+	state = inode_state_read_once(inode);
+	count = atomic_read(&inode->i_count);
 
+	if (!sb) {
+		pr_warn("mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
+			mode, opflags, flags, state, count);
+		return;
+	}
+
+	if (get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
+	    get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_ptr) {
+		pr_warn("invalid sb:%px mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
+			sb, mode, opflags, flags, state, count);
+		return;
+	}
+
+	if (strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_name) - 1) < 0)
+		strscpy(fs_name, "<invalid>");
+
+	pr_warn("fs:%s mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
+		fs_name, mode, opflags, flags, state, count);
+}
 EXPORT_SYMBOL(dump_inode);
 #endif
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




