Return-Path: <linux-fsdevel+bounces-65787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE7C11003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD2B250130C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B632A3D7;
	Mon, 27 Oct 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nIivxPWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9F31D753;
	Mon, 27 Oct 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592847; cv=none; b=MiIgslNZiNTBeF2KRLiHzv03yuMprprdkq5SOe/7bD4SCta4qkU8DeSfmN03aT7lSVNFA4ulvWz3yOxcM/yfXzlT/qlFfK0c/eGllwsWMYuVljpcxoDLjeBpd541TBCLpa/02VPzOPb+gKLOTSJpexl7DtzhIky4e+OiZaYO32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592847; c=relaxed/simple;
	bh=rWaw++ZbAOi8LwgelYKBCsXBcElei1Le53olxrLLftY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGeGQ008GV79SekY77wGcH57PgatREBq8Hj7pjq7D8TxJLFP79gahnEAtpI9OKDEQ0AgfHQ0pd06PXphxDQzFeXa8xaHdc71C9oymXFwCCoSdHELQoV1MPMXYLkX8foGDYg/rNLphhQAt4ggIl4BB7k6CkzMr32zx07cmS0EDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nIivxPWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C9EC113D0;
	Mon, 27 Oct 2025 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592847;
	bh=rWaw++ZbAOi8LwgelYKBCsXBcElei1Le53olxrLLftY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIivxPWqK4nWauVEKeHn01ScXSkeVDxNovkRJBnEbuyYrk1vmp4Z6Z2mDUpw2ZRmg
	 0qqlBdLwUEeScvioN2SY1A6WWS2JN2iNjpRrWzPYl1Whs8Ca3TxqAFeMa1iK3sgFvx
	 4K3LRpZSDdNwQyAdgIVkg71XaIkC2S+DH+3VtR6s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 009/117] hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()
Date: Mon, 27 Oct 2025 19:35:35 +0100
Message-ID: <20251027183454.189345382@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 2048ec5b98dbdfe0b929d2e42dc7a54c389c53dd ]

The syzbot reported issue in hfs_find_set_zero_bits():

=====================================================
BUG: KMSAN: uninit-value in hfs_find_set_zero_bits+0x74d/0xb60 fs/hfs/bitmap.c:45
 hfs_find_set_zero_bits+0x74d/0xb60 fs/hfs/bitmap.c:45
 hfs_vbm_search_free+0x13c/0x5b0 fs/hfs/bitmap.c:151
 hfs_extend_file+0x6a5/0x1b00 fs/hfs/extent.c:408
 hfs_get_block+0x435/0x1150 fs/hfs/extent.c:353
 __block_write_begin_int+0xa76/0x3030 fs/buffer.c:2151
 block_write_begin fs/buffer.c:2262 [inline]
 cont_write_begin+0x10e1/0x1bc0 fs/buffer.c:2601
 hfs_write_begin+0x85/0x130 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2528 [inline]
 cont_write_begin+0x35a/0x1bc0 fs/buffer.c:2591
 hfs_write_begin+0x85/0x130 fs/hfs/inode.c:52
 hfs_file_truncate+0x1d6/0xe60 fs/hfs/extent.c:494
 hfs_inode_setattr+0x964/0xaa0 fs/hfs/inode.c:654
 notify_change+0x1993/0x1aa0 fs/attr.c:552
 do_truncate+0x28f/0x310 fs/open.c:68
 do_ftruncate+0x698/0x730 fs/open.c:195
 do_sys_ftruncate fs/open.c:210 [inline]
 __do_sys_ftruncate fs/open.c:215 [inline]
 __se_sys_ftruncate fs/open.c:213 [inline]
 __x64_sys_ftruncate+0x11b/0x250 fs/open.c:213
 x64_sys_call+0xfe3/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:78
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __kmalloc_cache_noprof+0x7f7/0xed0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 hfs_mdb_get+0x1cc8/0x2a90 fs/hfs/mdb.c:175
 hfs_fill_super+0x3d0/0xb80 fs/hfs/super.c:337
 get_tree_bdev_flags+0x6e3/0x920 fs/super.c:1681
 get_tree_bdev+0x38/0x50 fs/super.c:1704
 hfs_get_tree+0x35/0x40 fs/hfs/super.c:388
 vfs_get_tree+0xb0/0x5c0 fs/super.c:1804
 do_new_mount+0x738/0x1610 fs/namespace.c:3902
 path_mount+0x6db/0x1e90 fs/namespace.c:4226
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x6eb/0x7d0 fs/namespace.c:4427
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4427
 x64_sys_call+0xfa7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 12609 Comm: syz.1.2692 Not tainted 6.16.0-syzkaller #0 PREEMPT(none)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================

The HFS_SB(sb)->bitmap buffer is allocated in hfs_mdb_get():

HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);

Finally, it can trigger the reported issue because kmalloc()
doesn't clear the allocated memory. If allocated memory contains
only zeros, then everything will work pretty fine.
But if the allocated memory contains the "garbage", then
it can affect the bitmap operations and it triggers
the reported issue.

This patch simply exchanges the kmalloc() on kzalloc()
with the goal to guarantee the correctness of bitmap operations.
Because, newly created allocation bitmap should have all
available blocks free. Potentially, initialization bitmap's read
operation could not fill the whole allocated memory and
"garbage" in the not initialized memory will be the reason of
volume coruptions and file system driver bugs.

Reported-by: syzbot <syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250820230636.179085-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127cd..bf811347bb07d 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -172,7 +172,7 @@ int hfs_mdb_get(struct super_block *sb)
 		pr_warn("continuing without an alternate MDB\n");
 	}
 
-	HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);
+	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
 		goto out;
 
-- 
2.51.0




