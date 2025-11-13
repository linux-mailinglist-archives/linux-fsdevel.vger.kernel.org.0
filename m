Return-Path: <linux-fsdevel+bounces-68175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B60C55CD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 06:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38C2C4E21AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 05:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82D284684;
	Thu, 13 Nov 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UVX/kacM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BC8248C;
	Thu, 13 Nov 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011462; cv=none; b=PRq8B3n9Jq+3rf1Vmm4oVBkA08YjxAN3qEQc9bD3774kf3n2XBCRsH1Rp5Ya/9gZQX4BGufehKd2fOrQv6l3LSQaX/P+bc9ZzVOvoGE5a/s4+qUBRCiq3lFvPfYudykH9F1XbiIcODdb7Q/ChxDloR5KL9WEPyid8367bEyslXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011462; c=relaxed/simple;
	bh=b9ABffOv/cH7SFVh8RKYB+PWGLNj2Y0+b2R3LnzAw84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqPTphULrkkQbBmTPnfogxEqymV45QxFBIX4EQvPhKPZsgd8WOXxoTV6yALLUbPHTzVHQmL1Q/HG4woQNwRJCYQvgHCzuecA3DfathOF/JYP+bnW0E2gaipaOLmD5JWN5ey/eux+/B8F5KqHzyzVqVjt+lh140oNSce37bmPHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UVX/kacM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WY
	2FpZw6svj8X3Onv9ZtcmZTMHe+hfBT0p28fJxGQ68=; b=UVX/kacMFIwMHl/tL0
	23nlcqkA7twGabQH/qoDi48fVIaTBn/u1ZOg/vmKRzKhi76vBWaZVUDazvtVK4aa
	nwiXPr0A5GjAJmT8H2RVDKiI+e61XJjhM51G6cZa6O+Ss9a2fSPhpzhR1xASFTl4
	TdOBG+DqIVF6jJgzhtCbf88yc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHpMJvaxVpLV6zDg--.140S2;
	Thu, 13 Nov 2025 13:23:59 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: lexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] libfs: Fix NULL pointer access in simple_recursive_removal
Date: Thu, 13 Nov 2025 13:23:57 +0800
Message-Id: <20251113052357.41868-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHpMJvaxVpLV6zDg--.140S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4UGryDuFW3KrW5KF48JFb_yoW8tFyrpr
	47tF15CF48Jr45Jr4Iyr45Xw1Uta9rCF4UXr1xAr17tF1DG345try8tF42qw1DZr48Jr43
	tr4kWw4ktr12qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO189UUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/1tbiYBYFdWkVZ55hFwAAs1

From: Yufeng Wang <wangyufeng@kylinos.cn>

There is an issue in the kernel:
if inode is NULL pointer. the function "inode_lock_nested"
(or function "inode_lock" before)
a crash will happen at code "&inode->i_rwsem".
[292618.520532] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
[...]
[292618.560398] RIP: 0010:down_write+0x12/0x30
[292618.565580] Code: 83 f8 01 74 08 48 c7 47 20 01 00 00 00 f3 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 ba 01 00 00 00 ff ff ff ff 48 89 f8 <f0> 48 0f c1 10 85 d2 74 05 e8 00 43 ff ff 65 48 8b 04 25 80 5c 01
[292618.587219] RSP: 0018:ffffb898dc86fc20 EFLAGS: 00010246
[292618.593666] RAX: 00000000000000a0 RBX: ffff94c84f363950 RCX: ffffff8000000000
[292618.602255] RDX: ffffffff00000001 RSI: 0000000000000063 RDI: 00000000000000a0
[292618.610844] RBP: ffffb898dc86fc78 R08: 0000000000000000 R09: 0000000000000000
[292618.619434] R10: ffffb898dc86fca8 R11: 0000000000000000 R12: 0000000000000000
[292618.628022] R13: ffff94c84f362a20 R14: ffff954d3f2fb4a0 R15: ffff954c3afa5010
[292618.636612] FS:  0000555555989cc0(0000) GS:ffff956dbf900000(0000) knlGS:0000000000000000
[292618.646271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[292618.653300] CR2: 00000000000000a0 CR3: 000000fc7f25a000 CR4: 00000000003406e0
[292618.661888] Call Trace:
[292618.665225]  simple_recursive_removal+0x4f/0x230
[292618.670994]  ? debug_fill_super+0xe0/0xe0
[292618.676079]  debugfs_remove+0x40/0x60
[292618.680799]  kvm_vcpu_release+0x19/0x30 [kvm]

Fixes: a3d1e7eb5abe ("simple_recursive_removal(): kernel-side rm -rf for ramfs-style filesystems")
Cc: stable@vger.kernel.org

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 fs/libfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 1661dcb7d983..9090cd1f97c4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -611,6 +611,8 @@ static void __simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
+		if (!inode)
+			return;
 		inode_lock_nested(inode, I_MUTEX_CHILD);
 		if (d_is_dir(this))
 			inode->i_flags |= S_DEAD;
-- 
2.34.1


