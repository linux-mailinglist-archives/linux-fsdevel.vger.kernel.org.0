Return-Path: <linux-fsdevel+bounces-13426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E333886F9A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35D2B21162
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5ABA37;
	Mon,  4 Mar 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NQm3wyKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737DBA27;
	Mon,  4 Mar 2024 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530781; cv=none; b=kEN9+/xpoDq1rShHozMQXhnvaR832UmMjE41ebpGTRIJNlWgFsP+7OPg8XvE4WJFc9o6UoIpA91CmVyVMqUgpqw4wOKeTEY7PStzNzSaJFMtLcZehoqwoiTNKRnwL/OdSUyrYv5XBZ82OM4L5TRngXO5hOH6XMexPGTARx2I3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530781; c=relaxed/simple;
	bh=Tpaq8N4Av+5b7UEGdG8PwgpDYuzB6CY0twmRaDGvc9c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bcAL1+6dHxErXmOt3PASSj1RMxgK4wS0ado+BnrKNNydahuJXRE3ZrIKzMMZbfvQEIMwuy/s3tYJJYk6Gys4zifE0f/F0D56jQS7FUWfXTPN0MScwX0102G4Rp5iZUUakZhgAib6PL4ot3LfwOT0hO83uzwnpvmKanPValfcXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NQm3wyKg; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709530768; bh=9uK2GXZq/8xku+2xavhS19lwiemprvBmG1eFe+2OCLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQm3wyKgm5Aqp3NDC8DWg2gOSmyDwHzkhFJ1bXea7QCGni4yID8HjoSwByoaoyrb1
	 2vhD1VGFS1xV+4UvgAz5bDPTY/2NuuhnAZpWWSGHhYK/U9mzO34vnBab/nyynkULzN
	 F5gKA0r+uyXZItFICYRo8Rv9Hc+Kx39VA4JUPLmc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 8519C245; Mon, 04 Mar 2024 13:33:17 +0800
X-QQ-mid: xmsmtpt1709530397t95cf53rs
Message-ID: <tencent_55ACA4583763B77466C5B36C637569638305@qq.com>
X-QQ-XMAILINFO: MCBt/x1q9XETxrFVo/g+iR8gh3Ugc6QxMk3Dka791CH3s4c66cR8rXCdzN/7lV
	 PRCDITTWKfntfxPgWWTm+nbPDap91lTwj+SFBL+zISZ/50EgeaoENMj5tPNHpE5r6slE92H3dsb7
	 rmx5P3zIDMXPyRENfZqcVqpJeR9qIXQJMIDGnaQaBqSACVASAO1+ik9TeNRitDfbEWcZ1K2e2q+2
	 43hTcsnzypTVNZcFvHUFoa1kpDNYup50rIQeuj3ew7EvcAM/GDLB9aRWwUEqIMrFamKq97X/fl4o
	 shJPC1F+VFP+t33gsLOt6sVogYDL+SnWB6/W43BUtqDtFzhCgoGC+m8Pu6iVs5Bl6x6UhKZD/ZXs
	 KGEqw8+u0+jKpm7/98PEyfigpGhkDw2zjF+WqU71CcI7Kl93OHqZpS1JWkUIU2XgA6yAnNVPUj0H
	 aafEJp9virIkmuih3E1hJimKl4y2OQQft9fbYRwsuWoYKSWvt7p6IaWIN+V/d8vmjVs7sKByAQv6
	 lYW5+L3Q5ba9F+ZqknLINOdYw/UQVeLtYMYEjVAzKRe2zt3ZFy13f0E+HS3oAbg/lpRP7+8UFUED
	 kyhOePvnWgpKRgTOJ2pgtKrGUIo8AfByIrEButrSVvxAi7nDFZa7uYo9piBxS3sE+MmQFcEcHDpL
	 62NiFz8PN2Jr0PPE+BoQBOaDb1krpKD4YyOB6s7oJOSW1+VIX6p0k9px2ykYqd9yoBM2EgWaRzHv
	 jH3Nw5oxJzBlx5d0C9wVBcRy0010yJUyk6LWS6y0g9uG3YK3dwfqg1/zmMb2NgMw0jYfDvspkWBL
	 WmLctm5RgXynGVFQ/Jmps3RKlQlHZ74nl3iK9ILrjMk0RcoXrzDiSjQOHnVPnrY/W5ogObURLRfm
	 G5DcYm9VR9TbGKmDalVuXOj6orEKdG22Pa09MXrD8DUMgBw0QRNHevFeS43CBy+90I/dX4/Gpp
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com
Cc: glider@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: fix uninit-value in hfsplus_attr_bin_cmp_key
Date: Mon,  4 Mar 2024 13:33:18 +0800
X-OQ-MSGID: <20240304053317.1237946-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000037444e0612c39434@google.com>
References: <00000000000037444e0612c39434@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KMSAN: uninit-value in hfsplus_attr_bin_cmp_key+0xf1/0x190 fs/hfsplus/attributes.c:42
 hfsplus_attr_bin_cmp_key+0xf1/0x190 fs/hfsplus/attributes.c:42
 hfs_find_rec_by_key+0xb0/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26b/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_find_attr+0x30c/0x390
 hfsplus_attr_exists+0x1c6/0x260 fs/hfsplus/attributes.c:182
 __hfsplus_setxattr+0x510/0x3580 fs/hfsplus/xattr.c:336
 hfsplus_setxattr+0x129/0x1e0 fs/hfsplus/xattr.c:434
 hfsplus_trusted_setxattr+0x55/0x70 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 path_setxattr+0x1f5/0x3c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xf7/0x180 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_attr_exists+0xde/0x260 fs/hfsplus/attributes.c:178
 __hfsplus_setxattr+0x510/0x3580 fs/hfsplus/xattr.c:336
 hfsplus_setxattr+0x129/0x1e0 fs/hfsplus/xattr.c:434
 hfsplus_trusted_setxattr+0x55/0x70 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 path_setxattr+0x1f5/0x3c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xf7/0x180 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

[Fix]
Let's clear all search_key fields at alloc time.

Reported-and-tested-by: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..b939dc879dac 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-- 
2.43.0


