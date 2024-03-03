Return-Path: <linux-fsdevel+bounces-13383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6886F39A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 05:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC21C20FC4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4157494;
	Sun,  3 Mar 2024 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IFnbXCvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E076FB2;
	Sun,  3 Mar 2024 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709439246; cv=none; b=hch6WH/JQ1kNUoAiwQgYYsCSmsvjLRzmLf+O6dUyLiho/yZ+rE56yX/+mQDjxI93xPrsd8L7SFSo73WfbjYsSwvHefwCa3yXxwtlgq8FNO9tr4ptdDxvOrMRtyKcfpQvJoKXYqBsQQr/ufAFFfnWaXfv1CSHoaqg5Eu5P8s8k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709439246; c=relaxed/simple;
	bh=rf5fal84uJ2jOLoroYcA/kvOKu5iirvX8PqRYGkfhWg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=O06+DCwcLKVGmrpVoFqXz7PY8wbxFocjyviLjRGvOcL32g1IRwwGy8EkrmYuxoSeMSObdAI/cM+WxIgz9dcR4g93ByHltsdwOAi2QONFoSGu+L8vv5kwUKK/EtOZ/HTK8lJQynNmiGe5ALWiT+y5wpACCEi3sp80GD/PsruLqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IFnbXCvd; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709439241; bh=pQE/OFAzfDGdmp5SC5XpXEyv/mDUk2/vmhd8gjt2QaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IFnbXCvdrBJUgjDkOCI9Xpnp2oVjzZ+YFQBop1yT9TzV/Ay5Yy7R2AA2DUdpznLuY
	 ZjNYX9f+MRwAO7RUUmoFd2Rogl4MHKal+KAqnGGYkb2WYzgeyYGobvwOqqKE9VxipA
	 INz4U7oE7V82k2tN/ot4AhKAQ55/dBSVs4WsWfQI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 37B01A6A; Sun, 03 Mar 2024 12:13:59 +0800
X-QQ-mid: xmsmtpt1709439239t6d0dh5z2
Message-ID: <tencent_12A5D80DB512365D805DB9195CCFA88D9A07@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiedauoAo0FVnxfWOK8zPUzNjfK5wRkfs+6Y6ayx4OSdfHtUWnmQr
	 S44er8JSj1nTJADaCXfD5VSDI7LUUz080gzPs0cqZWt3lhcObYkolWxmIgbeMfWKiiFpDkfVcT5K
	 le/nXIZeZut1VD+lYQ7fQK9PddmDTk6czYA9Z9FehjQe4RJU69Lur3fC2loY5w0wBgopCg2a2XYO
	 6o2yx73GgUJaC1sXhaRKVmVZIYdrr+q65Y4BwUZMM7b/AQfFGj4WeEPSr5n/fxEEgjnctnJCKa9E
	 pUhVE5j/owYPF+fEQnNrLTPOy1LcmaAMeri67PtD3CPrACjAccLNgbrTj+c5XYtDPzXevv6WK0Cv
	 WNW2G0aHy943jfn5V1WQEnU8xyFJVFpphbSELGZ9qHfLfPI1sclr1djZ0bxFkLgU3DXZHL2i1Fxp
	 ijKjFGSa4nDzcMfRTmbnJSFFgjqtJH0L4psIgo3javl93ljlxvqQNI2BRu+F52VY9TUZDic1r28I
	 V+v36+fkhJgvjcrqqxXhBMVYKCVKSnlfzfRzpFFxb8m+5pJR9MJDLM9YQVU/Vtf28BBWm/Z4Kh5H
	 7tDbkHOigoc0gj/I/MLEJKJODd2ngkQ8WrKu5dnWeH1hA9nt1O/KmkNrD7Q67GFJAI7V5XPTZXPx
	 /eWdiMlDryHiskgHtTRtbifpMDtP/gjVvFcUnpeiJy23IwCf0KpDKj5ET0ond+FXOexQuqfa+Sb9
	 o8S8C8IOZYOYTyz/spKbSljf1Qmuaj0ovNj2O7/hTKM5M9edOLm1FI2n3VutUopgfR81uA7HarRe
	 i4HMYiPGDVwRUPRBa2QR8cyG7IgF4NliJ+ErY9w+KVpWKrqjzr0ZysQBRwa07EErvcsY8B3PlbpZ
	 Pg0m+rKYBkuImFnLeTzPTfL/UyfyQSrgrp3Wzd/fs/itF9TuhIpAVAraWe9a5be6cojGPMQwqm12
	 mlSr5zdh0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfs: fix uninit-value in hfs_cat_keycmp
Date: Sun,  3 Mar 2024 12:14:00 +0800
X-OQ-MSGID: <20240303041359.26168-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000098b3700612b5ee0f@google.com>
References: <00000000000098b3700612b5ee0f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot Reported]
=====================================================
BUG: KMSAN: uninit-value in hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 __hfs_brec_find+0x250/0x820 fs/hfs/bfind.c:75
 hfs_brec_find+0x436/0x970 fs/hfs/bfind.c:138
 hfs_brec_read+0x3f/0x1a0 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0xe6/0x400 fs/hfs/catalog.c:194
 hfs_fill_super+0x1f27/0x23c0 fs/hfs/super.c:419
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_fill_super+0x1eb9/0x23c0 fs/hfs/super.c:416
 mount_bdev+0x38f/0x510 fs/super.c:1658
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x560 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x73d/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

[Fix]
Let's clear all search_key fields at alloc time.

Reported-and-tested-by: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfs/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..c74d864bc29e 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
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


