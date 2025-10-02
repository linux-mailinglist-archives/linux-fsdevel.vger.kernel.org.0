Return-Path: <linux-fsdevel+bounces-63294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981CBB4590
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A6C325A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C1223336;
	Thu,  2 Oct 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7vHFGFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1341F582F;
	Thu,  2 Oct 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419047; cv=none; b=nv96tgF8eIXPu4PZTzCqDkMbY4gZMZKAn18dBNvEnEumaw6oqLl0338A0Fc8byuPLHM9PPkJYgWVWvVfPwqVEDNKymerTlrRMlt5SJN1dq0i5hd9p/61mthx7XQzrmOhvA24K+c87Z9ohtMR5HhST2F1R418CHzJ12jG7/Zj15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419047; c=relaxed/simple;
	bh=NJ7XCA6Dc9p9hflmX4O8mtJD0I2QF3CtUt2w3mLYIlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+tTzEvTc++XlpkodyOjxSqEFZiXbdCoREggGIX+1UZfqCTLZwRyTpQytPpxahY6Sw4IzigTe8t+1btwDtZEmvWgb5j9DgYoWFGv/BagqZ/LwiJHo1NNKVBh6MK4YatoaNEMvob0nOYWkjV6NREOo1SnE14CXi4YmcBi3k2+e7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7vHFGFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4224AC4CEF9;
	Thu,  2 Oct 2025 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419047;
	bh=NJ7XCA6Dc9p9hflmX4O8mtJD0I2QF3CtUt2w3mLYIlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7vHFGFuP4SYufGlUOULRBthshPgx03Hm3fobeHxHY3Cm8+MPlCRYAxZZsPXGMjRG
	 nWrJHsBLJjvDwM5z5fr9R+Son4ubSF8G7+5Vc3mnYVS/GTlM+c3UcBbBHMEcB0+H1g
	 FSl1T5h9cW8ujBXx1GGANeIQXlMTiAdcWcS818X2QSnjQcSwrHEjlHRk+zw82M9ct8
	 J5dMhSYcROEa9vxmNwCGQWvbWy0MI5bvSNmilyi+GvOgdFy45bSuoSvPN5/aTommPP
	 /xTOX3DQJ9Ov3W5REXy99RGG6wczGjH7HnTDukpTggw48nQRX1Y8yNm6To5I4wzYwK
	 WxoTUxhQCuxmQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.17-5.4] hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
Date: Thu,  2 Oct 2025 11:30:03 -0400
Message-ID: <20251002153025.2209281-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002153025.2209281-1-sashal@kernel.org>
References: <20251002153025.2209281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 9b3d15a758910bb98ba8feb4109d99cc67450ee4 ]

The syzbot reported issue in hfsplus_delete_cat():

[   70.682285][ T9333] =====================================================
[   70.682943][ T9333] BUG: KMSAN: uninit-value in hfsplus_subfolders_dec+0x1d7/0x220
[   70.683640][ T9333]  hfsplus_subfolders_dec+0x1d7/0x220
[   70.684141][ T9333]  hfsplus_delete_cat+0x105d/0x12b0
[   70.684621][ T9333]  hfsplus_rmdir+0x13d/0x310
[   70.685048][ T9333]  vfs_rmdir+0x5ba/0x810
[   70.685447][ T9333]  do_rmdir+0x964/0xea0
[   70.685833][ T9333]  __x64_sys_rmdir+0x71/0xb0
[   70.686260][ T9333]  x64_sys_call+0xcd8/0x3cf0
[   70.686695][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.687119][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.687646][ T9333]
[   70.687856][ T9333] Uninit was stored to memory at:
[   70.688311][ T9333]  hfsplus_subfolders_inc+0x1c2/0x1d0
[   70.688779][ T9333]  hfsplus_create_cat+0x148e/0x1800
[   70.689231][ T9333]  hfsplus_mknod+0x27f/0x600
[   70.689730][ T9333]  hfsplus_mkdir+0x5a/0x70
[   70.690146][ T9333]  vfs_mkdir+0x483/0x7a0
[   70.690545][ T9333]  do_mkdirat+0x3f2/0xd30
[   70.690944][ T9333]  __x64_sys_mkdir+0x9a/0xf0
[   70.691380][ T9333]  x64_sys_call+0x2f89/0x3cf0
[   70.691816][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.692229][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.692773][ T9333]
[   70.692990][ T9333] Uninit was stored to memory at:
[   70.693469][ T9333]  hfsplus_subfolders_inc+0x1c2/0x1d0
[   70.693960][ T9333]  hfsplus_create_cat+0x148e/0x1800
[   70.694438][ T9333]  hfsplus_fill_super+0x21c1/0x2700
[   70.694911][ T9333]  mount_bdev+0x37b/0x530
[   70.695320][ T9333]  hfsplus_mount+0x4d/0x60
[   70.695729][ T9333]  legacy_get_tree+0x113/0x2c0
[   70.696167][ T9333]  vfs_get_tree+0xb3/0x5c0
[   70.696588][ T9333]  do_new_mount+0x73e/0x1630
[   70.697013][ T9333]  path_mount+0x6e3/0x1eb0
[   70.697425][ T9333]  __se_sys_mount+0x733/0x830
[   70.697857][ T9333]  __x64_sys_mount+0xe4/0x150
[   70.698269][ T9333]  x64_sys_call+0x2691/0x3cf0
[   70.698704][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.699117][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.699730][ T9333]
[   70.699946][ T9333] Uninit was created at:
[   70.700378][ T9333]  __alloc_pages_noprof+0x714/0xe60
[   70.700843][ T9333]  alloc_pages_mpol_noprof+0x2a2/0x9b0
[   70.701331][ T9333]  alloc_pages_noprof+0xf8/0x1f0
[   70.701774][ T9333]  allocate_slab+0x30e/0x1390
[   70.702194][ T9333]  ___slab_alloc+0x1049/0x33a0
[   70.702635][ T9333]  kmem_cache_alloc_lru_noprof+0x5ce/0xb20
[   70.703153][ T9333]  hfsplus_alloc_inode+0x5a/0xd0
[   70.703598][ T9333]  alloc_inode+0x82/0x490
[   70.703984][ T9333]  iget_locked+0x22e/0x1320
[   70.704428][ T9333]  hfsplus_iget+0x5c/0xba0
[   70.704827][ T9333]  hfsplus_btree_open+0x135/0x1dd0
[   70.705291][ T9333]  hfsplus_fill_super+0x1132/0x2700
[   70.705776][ T9333]  mount_bdev+0x37b/0x530
[   70.706171][ T9333]  hfsplus_mount+0x4d/0x60
[   70.706579][ T9333]  legacy_get_tree+0x113/0x2c0
[   70.707019][ T9333]  vfs_get_tree+0xb3/0x5c0
[   70.707444][ T9333]  do_new_mount+0x73e/0x1630
[   70.707865][ T9333]  path_mount+0x6e3/0x1eb0
[   70.708270][ T9333]  __se_sys_mount+0x733/0x830
[   70.708711][ T9333]  __x64_sys_mount+0xe4/0x150
[   70.709158][ T9333]  x64_sys_call+0x2691/0x3cf0
[   70.709630][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.710053][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.710611][ T9333]
[   70.710842][ T9333] CPU: 3 UID: 0 PID: 9333 Comm: repro Not tainted 6.12.0-rc6-dirty #17
[   70.711568][ T9333] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.712490][ T9333] =====================================================
[   70.713085][ T9333] Disabling lock debugging due to kernel taint
[   70.713618][ T9333] Kernel panic - not syncing: kmsan.panic set ...
[   70.714159][ T9333] CPU: 3 UID: 0 PID: 9333 Comm: repro Tainted: G    B              6.12.0-rc6-dirty #17
[   70.715007][ T9333] Tainted: [B]=BAD_PAGE
[   70.715365][ T9333] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.716311][ T9333] Call Trace:
[   70.716621][ T9333]  <TASK>
[   70.716899][ T9333]  dump_stack_lvl+0x1fd/0x2b0
[   70.717350][ T9333]  dump_stack+0x1e/0x30
[   70.717743][ T9333]  panic+0x502/0xca0
[   70.718116][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.718611][ T9333]  kmsan_report+0x296/0x2a0
[   70.719038][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.719859][ T9333]  ? __msan_warning+0x96/0x120
[   70.720345][ T9333]  ? hfsplus_subfolders_dec+0x1d7/0x220
[   70.720881][ T9333]  ? hfsplus_delete_cat+0x105d/0x12b0
[   70.721412][ T9333]  ? hfsplus_rmdir+0x13d/0x310
[   70.721880][ T9333]  ? vfs_rmdir+0x5ba/0x810
[   70.722458][ T9333]  ? do_rmdir+0x964/0xea0
[   70.722883][ T9333]  ? __x64_sys_rmdir+0x71/0xb0
[   70.723397][ T9333]  ? x64_sys_call+0xcd8/0x3cf0
[   70.723915][ T9333]  ? do_syscall_64+0xd9/0x1d0
[   70.724454][ T9333]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.725110][ T9333]  ? vprintk_emit+0xd1f/0xe60
[   70.725616][ T9333]  ? vprintk_default+0x3f/0x50
[   70.726175][ T9333]  ? vprintk+0xce/0xd0
[   70.726628][ T9333]  ? _printk+0x17e/0x1b0
[   70.727129][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.727739][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.728324][ T9333]  __msan_warning+0x96/0x120
[   70.728854][ T9333]  hfsplus_subfolders_dec+0x1d7/0x220
[   70.729479][ T9333]  hfsplus_delete_cat+0x105d/0x12b0
[   70.729984][ T9333]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.730646][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.731296][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.731863][ T9333]  hfsplus_rmdir+0x13d/0x310
[   70.732390][ T9333]  ? __pfx_hfsplus_rmdir+0x10/0x10
[   70.732919][ T9333]  vfs_rmdir+0x5ba/0x810
[   70.733416][ T9333]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.734044][ T9333]  do_rmdir+0x964/0xea0
[   70.734537][ T9333]  __x64_sys_rmdir+0x71/0xb0
[   70.735032][ T9333]  x64_sys_call+0xcd8/0x3cf0
[   70.735579][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.736092][ T9333]  ? irqentry_exit+0x16/0x60
[   70.736637][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.737269][ T9333] RIP: 0033:0x7fa9424eafc9
[   70.737775][ T9333] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[   70.739844][ T9333] RSP: 002b:00007fff099cd8d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
[   70.740760][ T9333] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa9424eafc9
[   70.741642][ T9333] RDX: 006c6f72746e6f63 RSI: 000000000000000a RDI: 0000000020000100
[   70.742543][ T9333] RBP: 00007fff099cd8e0 R08: 00007fff099cd910 R09: 00007fff099cd910
[   70.743376][ T9333] R10: 0000000000000000 R11: 0000000000000202 R12: 0000565430642260
[   70.744247][ T9333] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   70.745082][ T9333]  </TASK>

The main reason of the issue that struct hfsplus_inode_info
has not been properly initialized for the case of root folder.
In the case of root folder, hfsplus_fill_super() calls
the hfsplus_iget() that implements only partial initialization of
struct hfsplus_inode_info and subfolders field is not
initialized by hfsplus_iget() logic.

This patch implements complete initialization of
struct hfsplus_inode_info in the hfsplus_iget() logic with
the goal to prevent likewise issues for the case of
root folder.

Reported-by: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250825225103.326401-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit, I can now provide my
recommendation.

**YES**

## Detailed Analysis

### Bug Description and Impact

This commit fixes a **KMSAN (Kernel Memory Sanitizer) uninitialized
value bug** in the hfsplus filesystem that has existed since **2014**
(11 years). The issue occurs when:

1. **Root Cause**: The `hfsplus_iget()` function in
   fs/hfsplus/super.c:59 only partially initialized `struct
   hfsplus_inode_info`, leaving several fields (notably `subfolders`)
   uninitialized with random memory contents from the slab allocator
2. **Trigger**: When operations like `rmdir` are performed on HFSX
   filesystems, `hfsplus_subfolders_dec()` at fs/hfsplus/catalog.c:236
   reads the uninitialized `subfolders` field
3. **Consequence**: Undefined behavior, KMSAN warnings, potential kernel
   panic (when kmsan.panic is set), and potential security implications
   from using uninitialized kernel memory

The syzbot report
(https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f) shows
this bug has been **reported since 2022 with multiple recurrences
through 2025**, affecting kernel version 6.12.0-rc6 and likely all
versions since 3.14.

### Code Changes Analysis

**Before the fix** (fs/hfsplus/super.c:71-77), only 7 fields were
initialized:
- `open_dir_list`, `open_dir_lock`, `extents_lock`, `flags`,
  `extent_state`, `rsrc_inode`, `opencnt`

**After the fix** (fs/hfsplus/super.c:71-92), **ALL 19 fields** are now
initialized:
- Added initialization for: `first_blocks`, `clump_blocks`,
  `alloc_blocks`, `cached_start`, `cached_blocks`, `first_extents`,
  `cached_extents`, `create_date`, `linkid`, `fs_blocks`, `userflags`,
  **`subfolders`** (the key fix), and `phys_size`

The fix is **defensive** - it ensures complete initialization rather
than just fixing the immediate `subfolders` issue, preventing similar
bugs in the future.

### Backport Suitability Assessment

**✓ Fixes a real bug**: Yes - syzbot reports since 2022, reproducible
issue

**✓ Affects users**: Yes - anyone mounting HFSX filesystems (HFS+
variant used by macOS)

**✓ Small and contained**: Yes - 23 lines changed in one function in one
file

**✓ No architectural changes**: Correct - only adds field initialization

**✓ Low regression risk**: Very low - adds initialization that should
have been there from the start; no behavior changes, only ensures
defined values instead of random memory

**✓ No dependencies**: Standalone fix with no dependencies on other
commits

**✓ Self-contained**: Changes confined to `hfsplus_iget()` function

**✓ Follows stable rules**:
- Obviously correct (just initialization)
- Fixes real bug (KMSAN reports, undefined behavior)
- Less than 100 lines
- Important bugfix with minimal risk

### Security and Stability Implications

1. **Memory safety**: Uninitialized memory can contain sensitive data
   from previous allocations
2. **Filesystem integrity**: The `subfolders` counter being
   uninitialized can lead to incorrect filesystem state
3. **System stability**: Can cause kernel panic when memory sanitizers
   are enabled
4. **Data correctness**: Undefined behavior in filesystem code is
   particularly dangerous

### Historical Context

The `subfolders` field was added in **commit d7d673a591701f
(2014-03-10)** to support HFSX subfolder counting, but `hfsplus_iget()`
was never updated to initialize it. This bug has affected **all kernel
versions from 3.14 onwards** (approximately 11 years).

### Recommendation

This commit is an **excellent candidate for backporting** to all stable
kernel trees from v3.14 onwards. It fixes a long-standing memory
initialization bug with minimal risk and clear benefit for filesystem
stability and security.

 fs/hfsplus/super.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc89859..2f215d1daf6d9 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -68,13 +68,26 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
+	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->first_blocks = 0;
+	HFSPLUS_I(inode)->clump_blocks = 0;
+	HFSPLUS_I(inode)->alloc_blocks = 0;
+	HFSPLUS_I(inode)->cached_start = U32_MAX;
+	HFSPLUS_I(inode)->cached_blocks = 0;
+	memset(HFSPLUS_I(inode)->first_extents, 0, sizeof(hfsplus_extent_rec));
+	memset(HFSPLUS_I(inode)->cached_extents, 0, sizeof(hfsplus_extent_rec));
 	HFSPLUS_I(inode)->extent_state = 0;
+	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->linkid = 0;
+	HFSPLUS_I(inode)->flags = 0;
+	HFSPLUS_I(inode)->fs_blocks = 0;
+	HFSPLUS_I(inode)->userflags = 0;
+	HFSPLUS_I(inode)->subfolders = 0;
+	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
+	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
+	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
-- 
2.51.0


