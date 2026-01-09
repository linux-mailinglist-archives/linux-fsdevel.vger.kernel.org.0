Return-Path: <linux-fsdevel+bounces-73061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB96D0B072
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6F530D3907
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587C35A95F;
	Fri,  9 Jan 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fdZvOxom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405627465C;
	Fri,  9 Jan 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973236; cv=none; b=EOj1XWRGyx/NJmAxUisK8wDg3pgz6rFXqWJXzHbmqUQQJRPLR9JSy6Ga9q67sDg6CLJ8Jb9s5utQTTdvV0SmNrBO0ykKGnpMXiKD51fmYIpBbHz2e0MmNvaBRTVBc2pTtljbVCcsGbU9nAYHtmkgER+nHp9G33Ze8dKUer2R6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973236; c=relaxed/simple;
	bh=eh9Z13OxdbWcMFGEnLH65zzle87POO+3UbWZFU1/bmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F8QXkPbzFFkoEOSAxICofDf+XD/eNMt6Btbw+/TJ+f7yk6q5XUlCASxYnIwzILgoCGSWUHA3RVYMqrWsokiVdqlPdTVgxrLXt+BztNO/uGQk8sr0lF1cnjoQHNZXN9Ig4jNLbAsYlI+3ELAhG8nCrfxmgDEjpvDsbrS6u4bAhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fdZvOxom; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767973234; x=1799509234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDzMPGyWBDk+hSOxcjk4oUCpR5+XNKgzNX0Lyg90NRI=;
  b=fdZvOxom4O8fgD3sQuztYZHCY+BMiPevC9EypqPx9s4C90k23DOduhz3
   VOz/WvPIZWP1AQ7BUnTCTr8xM8z2RAE161TShNxEWDos7aM1i8GyJC2MW
   JfmfT+9Brw/VWJJMieMuhdEBtVEryI8hh/Xq+twd1Z6s5it0IxW0zMMBQ
   X6+FniC1I8/wHtu2zHpQD+ZXbLiTQjfZlVMU7ktp/r5RwgXzbSof3jj3M
   JNbS3Ux3MI1SPjOjHLzf4Be0sFh8z9g+awkvWQ5a8yI2u2o2TZ+qW+QXe
   hTzO7r++78vkIcRoYiog9yxScFWmEy4kkeBq43tWYlcA7FKoYvGdh8Ire
   A==;
X-CSE-ConnectionGUID: Z3iLcROmQNSQwhXpipHeIQ==
X-CSE-MsgGUID: s6stXg3gS/mAG6dW7RIn0g==
X-IronPort-AV: E=Sophos;i="6.21,214,1763424000"; 
   d="scan'208";a="10341621"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 15:40:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.68:2525] with esmtp (Farcaster)
 id 92338339-d074-45d5-ab44-818720947caf; Fri, 9 Jan 2026 15:40:31 +0000 (UTC)
X-Farcaster-Flow-ID: 92338339-d074-45d5-ab44-818720947caf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 9 Jan 2026 15:40:31 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.18) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 9 Jan 2026 15:40:29 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>
Subject: [PATCH v2] fs: improve dump_inode() to safely access inode fields.
Date: Fri, 9 Jan 2026 15:40:19 +0000
Message-ID: <20260109154019.74717-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use get_kernel_nofault() to safely access inode and related structures
(superblock, file_system_type) to avoid crashing when the inode pointer
is invalid. This allows the same pattern as dump_mapping().

Note: The original access method for i_state and i_count is preserved,
as get_kernel_nofault() is unnecessary once the inode structure is
verified accessible.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
Changes in v2:
- Merged NULL inode->i_sb check with invalid sb check as pointed out
  by Jan Kara;
- Link to v1: https://lore.kernel.org/linux-fsdevel/20260101165304.34516-1-ytohnuki@amazon.com/
---
 fs/inode.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a..c2113e4a9a6a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2984,24 +2984,52 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
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
+
+	if (!sb ||
+	    get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
+	    get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_ptr) {
+		pr_warn("invalid sb:%px mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
+			sb, mode, opflags, flags, state, count);
+		return;
+	}
+
+	if (strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_name) - 1) < 0)
+		strscpy(fs_name, "<invalid>");
 
+	pr_warn("fs:%s mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
+		fs_name, mode, opflags, flags, state, count);
+}
 EXPORT_SYMBOL(dump_inode);
 #endif
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




