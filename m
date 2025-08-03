Return-Path: <linux-fsdevel+bounces-56582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7317B19605
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A3F7AB98F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2D222586;
	Sun,  3 Aug 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOoJ0k5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726F1F561D;
	Sun,  3 Aug 2025 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256035; cv=none; b=KvCu9s1Q+3ghokYl+sp22NKjmDMVzzsWKwCQ1PS+3Kemh2HBvZsOE9MAvw/pTGSzZLQS4a+rmD5lDhVBKSrqgQqNGUb0EZQ2ExioGsgmA7o4rlPQJvz2dg98fYLtU2aV+V3bcrK5lnaw/vObb0jZPE14TLrhAYTSNWjYkRtf1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256035; c=relaxed/simple;
	bh=Ee902fUa6bbaaSWJt4bE9r5UBNbsDJ1soI7xXi/JtlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0WMkdEAnQXezqfb/TyW5dP5ztK1QUnNsKrihZDgneyZEy03XWSq5y7ed9ZP7O28mSspAYEFGm8IcGjTUU/37cHhMUntDDpG9g4RNvZWcvXzThLbB5i+kq67bDmUauRZr8j5In1P3irbt/ymyLTbpX5Cqwz14MMPhYk04vgfcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOoJ0k5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD14C4CEEB;
	Sun,  3 Aug 2025 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256035;
	bh=Ee902fUa6bbaaSWJt4bE9r5UBNbsDJ1soI7xXi/JtlA=;
	h=From:To:Cc:Subject:Date:From;
	b=UOoJ0k5usxlRauFueD7QEGpSz4Xj1TUzUQILWYWd0b3NKJjX/+6YdnJoxRuZcRNa0
	 0w7qgGZtY9yioXbQchsUvaOGxYUYKJ+VYRNBSQ/fEPHq0PulVQoQMm3+pvsICTXZ49
	 StuA/tQRDQlOzQ+248aYI9nAxcp2q7tpF4tblCv4FRSAHvTJ0/MjH8DvmarnE9lqxA
	 enV+/VCoIj0PBVwg3v8Zl8IYYCUQ6VGUZ+We6N2/oCb53fMESvMHf9Dbg4RfHBy1hu
	 NkGBUws36MKLEtN8rRZdOhXKCM2O66IxbjJdx84jCsICJaMFIpPFHKkNbOsEGRlGv6
	 DjOoD6ta9OBvQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Wenzhi Wang <wenzhi.wang@uwaterloo.ca>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/23] hfs: fix general protection fault in hfs_find_init()
Date: Sun,  3 Aug 2025 17:20:08 -0400
Message-Id: <20250803212031.3547641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 736a0516a16268995f4898eded49bfef077af709 ]

The hfs_find_init() method can trigger the crash
if tree pointer is NULL:

[   45.746290][ T9787] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KAI
[   45.747287][ T9787] KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
[   45.748716][ T9787] CPU: 2 UID: 0 PID: 9787 Comm: repro Not tainted 6.16.0-rc3 #10 PREEMPT(full)
[   45.750250][ T9787] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   45.751983][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
[   45.752834][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
[   45.755574][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
[   45.756432][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
[   45.757457][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
[   45.758282][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
[   45.758943][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
[   45.759619][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
[   45.760293][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
[   45.761050][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.761606][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
[   45.762286][ T9787] Call Trace:
[   45.762570][ T9787]  <TASK>
[   45.762824][ T9787]  hfs_ext_read_extent+0x190/0x9d0
[   45.763269][ T9787]  ? submit_bio_noacct_nocheck+0x2dd/0xce0
[   45.763766][ T9787]  ? __pfx_hfs_ext_read_extent+0x10/0x10
[   45.764250][ T9787]  hfs_get_block+0x55f/0x830
[   45.764646][ T9787]  block_read_full_folio+0x36d/0x850
[   45.765105][ T9787]  ? __pfx_hfs_get_block+0x10/0x10
[   45.765541][ T9787]  ? const_folio_flags+0x5b/0x100
[   45.765972][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
[   45.766415][ T9787]  filemap_read_folio+0xbe/0x290
[   45.766840][ T9787]  ? __pfx_filemap_read_folio+0x10/0x10
[   45.767325][ T9787]  ? __filemap_get_folio+0x32b/0xbf0
[   45.767780][ T9787]  do_read_cache_folio+0x263/0x5c0
[   45.768223][ T9787]  ? __pfx_hfs_read_folio+0x10/0x10
[   45.768666][ T9787]  read_cache_page+0x5b/0x160
[   45.769070][ T9787]  hfs_btree_open+0x491/0x1740
[   45.769481][ T9787]  hfs_mdb_get+0x15e2/0x1fb0
[   45.769877][ T9787]  ? __pfx_hfs_mdb_get+0x10/0x10
[   45.770316][ T9787]  ? find_held_lock+0x2b/0x80
[   45.770731][ T9787]  ? lockdep_init_map_type+0x5c/0x280
[   45.771200][ T9787]  ? lockdep_init_map_type+0x5c/0x280
[   45.771674][ T9787]  hfs_fill_super+0x38e/0x720
[   45.772092][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
[   45.772549][ T9787]  ? snprintf+0xbe/0x100
[   45.772931][ T9787]  ? __pfx_snprintf+0x10/0x10
[   45.773350][ T9787]  ? do_raw_spin_lock+0x129/0x2b0
[   45.773796][ T9787]  ? find_held_lock+0x2b/0x80
[   45.774215][ T9787]  ? set_blocksize+0x40a/0x510
[   45.774636][ T9787]  ? sb_set_blocksize+0x176/0x1d0
[   45.775087][ T9787]  ? setup_bdev_super+0x369/0x730
[   45.775533][ T9787]  get_tree_bdev_flags+0x384/0x620
[   45.775985][ T9787]  ? __pfx_hfs_fill_super+0x10/0x10
[   45.776453][ T9787]  ? __pfx_get_tree_bdev_flags+0x10/0x10
[   45.776950][ T9787]  ? bpf_lsm_capable+0x9/0x10
[   45.777365][ T9787]  ? security_capable+0x80/0x260
[   45.777803][ T9787]  vfs_get_tree+0x8e/0x340
[   45.778203][ T9787]  path_mount+0x13de/0x2010
[   45.778604][ T9787]  ? kmem_cache_free+0x2b0/0x4c0
[   45.779052][ T9787]  ? __pfx_path_mount+0x10/0x10
[   45.779480][ T9787]  ? getname_flags.part.0+0x1c5/0x550
[   45.779954][ T9787]  ? putname+0x154/0x1a0
[   45.780335][ T9787]  __x64_sys_mount+0x27b/0x300
[   45.780758][ T9787]  ? __pfx___x64_sys_mount+0x10/0x10
[   45.781232][ T9787]  do_syscall_64+0xc9/0x480
[   45.781631][ T9787]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.782149][ T9787] RIP: 0033:0x7ffb7265b6ca
[   45.782539][ T9787] Code: 48 8b 0d c9 17 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
[   45.784212][ T9787] RSP: 002b:00007ffc0c10cfb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[   45.784935][ T9787] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffb7265b6ca
[   45.785626][ T9787] RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007ffc0c10d100
[   45.786316][ T9787] RBP: 00007ffc0c10d190 R08: 00007ffc0c10d000 R09: 0000000000000000
[   45.787011][ T9787] R10: 0000000000000048 R11: 0000000000000206 R12: 0000560246733250
[   45.787697][ T9787] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   45.788393][ T9787]  </TASK>
[   45.788665][ T9787] Modules linked in:
[   45.789058][ T9787] ---[ end trace 0000000000000000 ]---
[   45.789554][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
[   45.790028][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01 00 00 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
[   45.792364][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 00010202
[   45.793155][ T9787] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff819a4d09
[   45.794123][ T9787] RDX: 0000000000000008 RSI: ffffffff819acd3a RDI: ffffc900151576e8
[   45.795105][ T9787] RBP: ffffc900151576d0 R08: 0000000000000005 R09: 0000000000000000
[   45.796135][ T9787] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000004
[   45.797114][ T9787] R13: 0000000000000040 R14: ffff88802c50814a R15: 0000000000000000
[   45.798024][ T9787] FS:  00007ffb72734540(0000) GS:ffff8880cec64000(0000) knlGS:0000000000000000
[   45.799019][ T9787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.799822][ T9787] CR2: 00007f9bd8225000 CR3: 000000010979a000 CR4: 00000000000006f0
[   45.800747][ T9787] Kernel panic - not syncing: Fatal exception

The hfs_fill_super() calls hfs_mdb_get() method that tries
to construct Extents Tree and Catalog Tree:

HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
if (!HFS_SB(sb)->ext_tree) {
	pr_err("unable to open extent tree\n");
	goto out;
}
HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
if (!HFS_SB(sb)->cat_tree) {
	pr_err("unable to open catalog tree\n");
	goto out;
}

However, hfs_btree_open() calls read_mapping_page() that
calls hfs_get_block(). And this method calls hfs_ext_read_extent():

static int hfs_ext_read_extent(struct inode *inode, u16 block)
{
	struct hfs_find_data fd;
	int res;

	if (block >= HFS_I(inode)->cached_start &&
	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
		return 0;

	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
	if (!res) {
		res = __hfs_ext_cache_extent(&fd, inode, block);
		hfs_find_exit(&fd);
	}
	return res;
}

The problem here that hfs_find_init() is trying to use
HFS_SB(inode->i_sb)->ext_tree that is not initialized yet.
It will be initailized when hfs_btree_open() finishes
the execution.

The patch adds checking of tree pointer in hfs_find_init()
and it reworks the logic of hfs_btree_open() by reading
the b-tree's header directly from the volume. The read_mapping_page()
is exchanged on filemap_grab_folio() that grab the folio from
mapping. Then, sb_bread() extracts the b-tree's header
content and copy it into the folio.

Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250710213657.108285-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Critical Bug Fix Analysis

This commit fixes a **critical kernel panic** (general protection fault)
that can be triggered during normal HFS filesystem operations. The bug
represents a serious stability issue that meets stable kernel criteria.

## Root Cause Analysis

The crash occurs due to a **use-before-initialization bug** in the HFS
filesystem code:

1. **Initialization Order Issue**: When `hfs_fill_super()` is called, it
   tries to construct the Extents Tree via:
  ```c
  HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID,
  hfs_ext_keycmp);
  ```

2. **Circular Dependency**: During `hfs_btree_open()` execution:
   - It calls `read_mapping_page()` to read the btree header
   - This triggers `hfs_get_block()`
   - Which calls `hfs_ext_read_extent()`
   - Which tries to use `HFS_SB(inode->i_sb)->ext_tree` via
     `hfs_find_init()`
   - But `ext_tree` is NULL because we're still in the process of
     initializing it!

3. **NULL Pointer Dereference**: The crash stack trace shows:
  ```
  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  ```
  This occurs when trying to access `tree->max_key_len` at offset 0x40
  from a NULL tree pointer.

## Fix Implementation

The patch implements two key fixes:

1. **Defensive Programming**: Adds NULL checks in `hfs_find_init()`:
  ```c
  +       if (!tree || !fd)
  +               return -EINVAL;
  ```

2. **Breaking the Circular Dependency**: Reworks `hfs_btree_open()` to
   avoid the problematic code path:
   - Replaces `read_mapping_page()` with `filemap_grab_folio()`
   - Uses `sb_bread()` to read the btree header directly from disk
   - Avoids going through the extent management code during
     initialization

## Backport Justification

This commit meets all stable kernel criteria:

1. **Fixes a Real Bug**: Prevents a kernel panic that can be triggered
   during normal filesystem operations
2. **Small and Contained**: The changes are limited to HFS filesystem
   code with no impact on other subsystems
3. **Clear Fix**: The solution directly addresses the root cause without
   architectural changes
4. **No New Features**: Only fixes the existing bug without adding
   functionality
5. **High Impact**: Kernel panics are critical issues that affect system
   stability
6. **Minimal Risk**: Changes are confined to HFS subsystem with clear
   boundaries

## Additional Context

- The commit includes a detailed crash trace showing this is a real-
  world issue
- Recent commit history shows HFS has had multiple similar stability
  fixes (slab-out-of-bounds, OOB reads/writes)
- The fix follows established patterns for handling initialization order
  issues
- The reporter is credited (Wenzhi Wang from University of Waterloo),
  indicating this was found through testing/research

This is exactly the type of bug fix that stable kernels exist to
incorporate - preventing kernel crashes without introducing new risks.

 fs/hfs/bfind.c  |  3 +++
 fs/hfs/btree.c  | 57 +++++++++++++++++++++++++++++++++++++++----------
 fs/hfs/extent.c |  2 +-
 fs/hfs/hfs_fs.h |  1 +
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..34e9804e0f36 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree || !fd)
+		return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2fa4b1f8cc7f..e86e1e235658 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -21,8 +21,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
-	struct page *page;
+	struct folio *folio;
+	struct buffer_head *bh;
 	unsigned int size;
+	u16 dblock;
+	sector_t start_block;
+	loff_t offset;
 
 	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
@@ -75,12 +79,40 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	unlock_new_inode(tree->inode);
 
 	mapping = tree->inode->i_mapping;
-	page = read_mapping_page(mapping, 0, NULL);
-	if (IS_ERR(page))
+	folio = filemap_grab_folio(mapping, 0);
+	if (IS_ERR(folio))
 		goto free_inode;
 
+	folio_zero_range(folio, 0, folio_size(folio));
+
+	dblock = hfs_ext_find_block(HFS_I(tree->inode)->first_extents, 0);
+	start_block = HFS_SB(sb)->fs_start + (dblock * HFS_SB(sb)->fs_div);
+
+	size = folio_size(folio);
+	offset = 0;
+	while (size > 0) {
+		size_t len;
+
+		bh = sb_bread(sb, start_block);
+		if (!bh) {
+			pr_err("unable to read tree header\n");
+			goto put_folio;
+		}
+
+		len = min_t(size_t, folio_size(folio), sb->s_blocksize);
+		memcpy_to_folio(folio, offset, bh->b_data, sb->s_blocksize);
+
+		brelse(bh);
+
+		start_block++;
+		offset += len;
+		size -= len;
+	}
+
+	folio_mark_uptodate(folio);
+
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_folio(folio, 0) +
 					       sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
@@ -95,22 +127,22 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 
 	size = tree->node_size;
 	if (!is_power_of_2(size))
-		goto fail_page;
+		goto fail_folio;
 	if (!tree->node_count)
-		goto fail_page;
+		goto fail_folio;
 	switch (id) {
 	case HFS_EXT_CNID:
 		if (tree->max_key_len != HFS_MAX_EXT_KEYLEN) {
 			pr_err("invalid extent max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+			goto fail_folio;
 		}
 		break;
 	case HFS_CAT_CNID:
 		if (tree->max_key_len != HFS_MAX_CAT_KEYLEN) {
 			pr_err("invalid catalog max_key_len %d\n",
 			       tree->max_key_len);
-			goto fail_page;
+			goto fail_folio;
 		}
 		break;
 	default:
@@ -121,12 +153,15 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->pages_per_bnode = (tree->node_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	kunmap_local(head);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return tree;
 
-fail_page:
+fail_folio:
 	kunmap_local(head);
-	put_page(page);
+put_folio:
+	folio_unlock(folio);
+	folio_put(folio);
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
 	iput(tree->inode);
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 6d1878b99b30..941c92525815 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -71,7 +71,7 @@ int hfs_ext_keycmp(const btree_key *key1, const btree_key *key2)
  *
  * Find a block within an extent record
  */
-static u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
+u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off)
 {
 	int i;
 	u16 count;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 49d02524e667..f1402d71b092 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -190,6 +190,7 @@ extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
 extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
+extern u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off);
 extern int hfs_free_fork(struct super_block *, struct hfs_cat_file *, int);
 extern int hfs_ext_write_extent(struct inode *);
 extern int hfs_extend_file(struct inode *);
-- 
2.39.5


