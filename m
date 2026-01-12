Return-Path: <linux-fsdevel+bounces-73303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93CD14B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FB6304A93B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170D3815C6;
	Mon, 12 Jan 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="exa8uE5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921531ED70;
	Mon, 12 Jan 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241702; cv=none; b=N06vIokZKyAEEUoX2a3Tv3FxqxVRdM8Ugd8c3sGnjYZ0jq3Zo1YK1bXIOhVRwdycdcU88ctS0gvXkrFOjdstSWA0uEECEKxiZS0mOeyZH7NO0BNCCRRQjT/y+tNvLqVC2DV62kR9n6BHRM3tcSy3yJw83LCNyqRWZzf92kRBI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241702; c=relaxed/simple;
	bh=buH0bQVMOvUI+ZdmWpQnA6yWfLI3xisWvb7aqYiOnX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4qZkbAiLZVouk6SGGVPT16gpsGC0NbzfOeILG2prYRQqfFGB7eAsAAzUSYrItkWyXDjeANX0IheowqAupL2xHAAJEdevNfIn+Nl4gCAWhWrJivTDbViW2AnGtLNsnxFbu3OQ1fT40ojED63Paq+UumIb/ejGLacREDDmQJYQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=exa8uE5V; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768241699; x=1799777699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nJ2cUXZVN1Lgav5ozugpbdPe5cvs20NP4NjrqDq1PL0=;
  b=exa8uE5VsPjSpP3gj7N5ltdRh4QCTG52IU8eWq9mKtP+UGbLt8qQiL1t
   gg3p2mnzZLMS1NpQJ/NvwNwVvEIQ8TNwdCOtIyefCEjkgt7K0Qx7Y7Ziw
   wzxTbFGmZpZqcAnH7AcFmnNGfvHBUGAJrMqyeW6vCG/EsjAVQ1d2J4v5k
   OIXNktQ8X9/R0YAEqmsp8L14t7ve14pRcm7Q079OO/+a2bkKlDQ/hkg1w
   xYQwagDGmbBf7ZIn02OVJnUWcrccPrT+QrCsiJd0R3sXeVIZSnINyK3lF
   3XnzBBk8SpSPjCUAUaJMTjTnZieAQXmu2McFoCEWAhQUNGVlJ56vmnDDu
   Q==;
X-CSE-ConnectionGUID: K+WI6SGMTWK11CukQRlsDw==
X-CSE-MsgGUID: tXZoLzY5RK2AZLZ0Z5PR6w==
X-IronPort-AV: E=Sophos;i="6.21,221,1763424000"; 
   d="scan'208";a="10698711"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:14:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:30790]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.8:2525] with esmtp (Farcaster)
 id 90a3c1a4-a935-4b28-877b-78dadc267009; Mon, 12 Jan 2026 18:14:55 +0000 (UTC)
X-Farcaster-Flow-ID: 90a3c1a4-a935-4b28-877b-78dadc267009
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:14:55 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.21) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:14:53 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: Mateusz Guzik <mjguzik@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH v3] fs: improve dump_inode() to safely access inode fields
Date: Mon, 12 Jan 2026 18:14:43 +0000
Message-ID: <20260112181443.81286-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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
Changes in v3:
- Avoided pr_warn duplication for long-term maintainability.
- Changed "invalid inode" to "unreadable inode", and clearly denote the
  situation where sb is unreadable as suggested by Mateusz Guzik.
- Added passed reason to all pr_warn outputs.
- Used %# format specifier for printing hex values, verified to
  work as expected.
- Link to v2: https://lore.kernel.org/linux-fsdevel/20260109154019.74717-1-ytohnuki@amazon.com/

Changes in v2:
- Merged NULL inode->i_sb check with invalid sb check as pointed out
  by Jan Kara.
- Link to v1: https://lore.kernel.org/linux-fsdevel/20260101165304.34516-1-ytohnuki@amazon.com/
---
 fs/inode.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a..440ae05f9df5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2984,24 +2984,45 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
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
+	if (get_kernel_nofault(sb, &inode->i_sb) ||
+	    get_kernel_nofault(mode, &inode->i_mode) ||
+	    get_kernel_nofault(opflags, &inode->i_opflags) ||
+	    get_kernel_nofault(flags, &inode->i_flags)) {
+		pr_warn("%s: unreadable inode:%px\n", reason, inode);
+		return;
+	}
 
-	pr_warn("%s encountered for inode %px\n"
-		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
-		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
-		inode->i_flags, inode_state_read_once(inode), atomic_read(&inode->i_count));
-}
+	state = inode_state_read_once(inode);
+	count = atomic_read(&inode->i_count);
 
+	if (!sb ||
+	    get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
+	    get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_ptr ||
+	    strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_name) - 1) < 0)
+		strscpy(fs_name, "<unknown, sb unreadable>");
+
+	pr_warn("%s: inode:%px fs:%s mode:%ho opflags:%#x flags:%#x state:%#x count:%d\n",
+		reason, inode, fs_name, mode, opflags, flags, state, count);
+}
 EXPORT_SYMBOL(dump_inode);
 #endif
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




