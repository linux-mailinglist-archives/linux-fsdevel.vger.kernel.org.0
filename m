Return-Path: <linux-fsdevel+bounces-56608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB9B19660
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098A33B6A8D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504F22F16C;
	Sun,  3 Aug 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY14nuqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF3222562;
	Sun,  3 Aug 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256195; cv=none; b=PPS2i51tOBkUEF/i5HqDcBrl+AhqnazkztAsqFku5xCRvji50rh9ZSI7Og+LPMUA/NyAf/1aaakNqsWlJDHH2xzIg+2fKd1RHIjstSE7LTS/n3dxpLUrDUoUS+KmJcvUnXS8UcWd7TCxdgOmUxV1cD7I6cQQF5PnzKZLsk8cFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256195; c=relaxed/simple;
	bh=TAbjMB7W3Ft+kXAprZeH0iLK8yBDsCM2OdPwJV/AF3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRNUqttf94WHIZBc++v61atiTkuyQ/KiKVvjbDjEzvoDSx2peKkMQ5Ok9zVXvLYx9HBQgfygkk7capoXH+7PaGTJNYEYZla3gl5LWA+S/jGPK/8NTp+NZEmW2JjpzdRHYe5G7BEwuKw7bhVqIgRjvAm8xuZb8wRQqHGYKs2YqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY14nuqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50214C4CEEB;
	Sun,  3 Aug 2025 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256195;
	bh=TAbjMB7W3Ft+kXAprZeH0iLK8yBDsCM2OdPwJV/AF3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cY14nuqLg1OZEZ8tejge4B99SqZOFsG8GO2w+hkPyzaSI4vIBXdqbZ1wsta7W/JhI
	 idM9MPVXwI6MFzeYTB5Yx26Dq9JUmX9gNukF3sYMezb74y2WLjfAAxC6nL6h04WiGa
	 g+EsdKAsT8v3GaxZvjef15hjb+ZR1Des7WZdC9G1ZMHfE5I6Tmh0U6TEJoO/l4MZdd
	 c8/W49ynd0eHnna2NQ8pNUVEomQM8D2icHlWSiyJ66ez3+S1rgOLPmhxerCe+iRmeS
	 NQQdQlx6nzhBoDFvkD9uItoJ5oKeqdH0ECdhjQAzUhL9qFaYxwkg+NW41VLNtcpxzB
	 5DvsurmFtBy/g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>,
	Shuoran Bai <baishuoran@hrbeu.edu.cn>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
Date: Sun,  3 Aug 2025 17:23:02 -0400
Message-Id: <20250803212309.3549683-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212309.3549683-1-sashal@kernel.org>
References: <20250803212309.3549683-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.296
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit c80aa2aaaa5e69d5219c6af8ef7e754114bd08d2 ]

The hfsplus_bnode_read() method can trigger the issue:

[  174.852007][ T9784] ==================================================================
[  174.852709][ T9784] BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x2f4/0x360
[  174.853412][ T9784] Read of size 8 at addr ffff88810b5fc6c0 by task repro/9784
[  174.854059][ T9784]
[  174.854272][ T9784] CPU: 1 UID: 0 PID: 9784 Comm: repro Not tainted 6.16.0-rc3 #7 PREEMPT(full)
[  174.854281][ T9784] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  174.854286][ T9784] Call Trace:
[  174.854289][ T9784]  <TASK>
[  174.854292][ T9784]  dump_stack_lvl+0x10e/0x1f0
[  174.854305][ T9784]  print_report+0xd0/0x660
[  174.854315][ T9784]  ? __virt_addr_valid+0x81/0x610
[  174.854323][ T9784]  ? __phys_addr+0xe8/0x180
[  174.854330][ T9784]  ? hfsplus_bnode_read+0x2f4/0x360
[  174.854337][ T9784]  kasan_report+0xc6/0x100
[  174.854346][ T9784]  ? hfsplus_bnode_read+0x2f4/0x360
[  174.854354][ T9784]  hfsplus_bnode_read+0x2f4/0x360
[  174.854362][ T9784]  hfsplus_bnode_dump+0x2ec/0x380
[  174.854370][ T9784]  ? __pfx_hfsplus_bnode_dump+0x10/0x10
[  174.854377][ T9784]  ? hfsplus_bnode_write_u16+0x83/0xb0
[  174.854385][ T9784]  ? srcu_gp_start+0xd0/0x310
[  174.854393][ T9784]  ? __mark_inode_dirty+0x29e/0xe40
[  174.854402][ T9784]  hfsplus_brec_remove+0x3d2/0x4e0
[  174.854411][ T9784]  __hfsplus_delete_attr+0x290/0x3a0
[  174.854419][ T9784]  ? __pfx_hfs_find_1st_rec_by_cnid+0x10/0x10
[  174.854427][ T9784]  ? __pfx___hfsplus_delete_attr+0x10/0x10
[  174.854436][ T9784]  ? __asan_memset+0x23/0x50
[  174.854450][ T9784]  hfsplus_delete_all_attrs+0x262/0x320
[  174.854459][ T9784]  ? __pfx_hfsplus_delete_all_attrs+0x10/0x10
[  174.854469][ T9784]  ? rcu_is_watching+0x12/0xc0
[  174.854476][ T9784]  ? __mark_inode_dirty+0x29e/0xe40
[  174.854483][ T9784]  hfsplus_delete_cat+0x845/0xde0
[  174.854493][ T9784]  ? __pfx_hfsplus_delete_cat+0x10/0x10
[  174.854507][ T9784]  hfsplus_unlink+0x1ca/0x7c0
[  174.854516][ T9784]  ? __pfx_hfsplus_unlink+0x10/0x10
[  174.854525][ T9784]  ? down_write+0x148/0x200
[  174.854532][ T9784]  ? __pfx_down_write+0x10/0x10
[  174.854540][ T9784]  vfs_unlink+0x2fe/0x9b0
[  174.854549][ T9784]  do_unlinkat+0x490/0x670
[  174.854557][ T9784]  ? __pfx_do_unlinkat+0x10/0x10
[  174.854565][ T9784]  ? __might_fault+0xbc/0x130
[  174.854576][ T9784]  ? getname_flags.part.0+0x1c5/0x550
[  174.854584][ T9784]  __x64_sys_unlink+0xc5/0x110
[  174.854592][ T9784]  do_syscall_64+0xc9/0x480
[  174.854600][ T9784]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  174.854608][ T9784] RIP: 0033:0x7f6fdf4c3167
[  174.854614][ T9784] Code: f0 ff ff 73 01 c3 48 8b 0d 26 0d 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 08
[  174.854622][ T9784] RSP: 002b:00007ffcb948bca8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[  174.854630][ T9784] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6fdf4c3167
[  174.854636][ T9784] RDX: 00007ffcb948bcc0 RSI: 00007ffcb948bcc0 RDI: 00007ffcb948bd50
[  174.854641][ T9784] RBP: 00007ffcb948cd90 R08: 0000000000000001 R09: 00007ffcb948bb40
[  174.854645][ T9784] R10: 00007f6fdf564fc0 R11: 0000000000000206 R12: 0000561e1bc9c2d0
[  174.854650][ T9784] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  174.854658][ T9784]  </TASK>
[  174.854661][ T9784]
[  174.879281][ T9784] Allocated by task 9784:
[  174.879664][ T9784]  kasan_save_stack+0x20/0x40
[  174.880082][ T9784]  kasan_save_track+0x14/0x30
[  174.880500][ T9784]  __kasan_kmalloc+0xaa/0xb0
[  174.880908][ T9784]  __kmalloc_noprof+0x205/0x550
[  174.881337][ T9784]  __hfs_bnode_create+0x107/0x890
[  174.881779][ T9784]  hfsplus_bnode_find+0x2d0/0xd10
[  174.882222][ T9784]  hfsplus_brec_find+0x2b0/0x520
[  174.882659][ T9784]  hfsplus_delete_all_attrs+0x23b/0x320
[  174.883144][ T9784]  hfsplus_delete_cat+0x845/0xde0
[  174.883595][ T9784]  hfsplus_rmdir+0x106/0x1b0
[  174.884004][ T9784]  vfs_rmdir+0x206/0x690
[  174.884379][ T9784]  do_rmdir+0x2b7/0x390
[  174.884751][ T9784]  __x64_sys_rmdir+0xc5/0x110
[  174.885167][ T9784]  do_syscall_64+0xc9/0x480
[  174.885568][ T9784]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  174.886083][ T9784]
[  174.886293][ T9784] The buggy address belongs to the object at ffff88810b5fc600
[  174.886293][ T9784]  which belongs to the cache kmalloc-192 of size 192
[  174.887507][ T9784] The buggy address is located 40 bytes to the right of
[  174.887507][ T9784]  allocated 152-byte region [ffff88810b5fc600, ffff88810b5fc698)
[  174.888766][ T9784]
[  174.888976][ T9784] The buggy address belongs to the physical page:
[  174.889533][ T9784] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10b5fc
[  174.890295][ T9784] flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
[  174.890927][ T9784] page_type: f5(slab)
[  174.891284][ T9784] raw: 057ff00000000000 ffff88801b4423c0 ffffea000426dc80 dead000000000002
[  174.892032][ T9784] raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
[  174.892774][ T9784] page dumped because: kasan: bad access detected
[  174.893327][ T9784] page_owner tracks the page as allocated
[  174.893825][ T9784] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c00(GFP_NOIO|__GFP_NOWARN|__GFP_NO1
[  174.895373][ T9784]  post_alloc_hook+0x1c0/0x230
[  174.895801][ T9784]  get_page_from_freelist+0xdeb/0x3b30
[  174.896284][ T9784]  __alloc_frozen_pages_noprof+0x25c/0x2460
[  174.896810][ T9784]  alloc_pages_mpol+0x1fb/0x550
[  174.897242][ T9784]  new_slab+0x23b/0x340
[  174.897614][ T9784]  ___slab_alloc+0xd81/0x1960
[  174.898028][ T9784]  __slab_alloc.isra.0+0x56/0xb0
[  174.898468][ T9784]  __kmalloc_noprof+0x2b0/0x550
[  174.898896][ T9784]  usb_alloc_urb+0x73/0xa0
[  174.899289][ T9784]  usb_control_msg+0x1cb/0x4a0
[  174.899718][ T9784]  usb_get_string+0xab/0x1a0
[  174.900133][ T9784]  usb_string_sub+0x107/0x3c0
[  174.900549][ T9784]  usb_string+0x307/0x670
[  174.900933][ T9784]  usb_cache_string+0x80/0x150
[  174.901355][ T9784]  usb_new_device+0x1d0/0x19d0
[  174.901786][ T9784]  register_root_hub+0x299/0x730
[  174.902231][ T9784] page last free pid 10 tgid 10 stack trace:
[  174.902757][ T9784]  __free_frozen_pages+0x80c/0x1250
[  174.903217][ T9784]  vfree.part.0+0x12b/0xab0
[  174.903645][ T9784]  delayed_vfree_work+0x93/0xd0
[  174.904073][ T9784]  process_one_work+0x9b5/0x1b80
[  174.904519][ T9784]  worker_thread+0x630/0xe60
[  174.904927][ T9784]  kthread+0x3a8/0x770
[  174.905291][ T9784]  ret_from_fork+0x517/0x6e0
[  174.905709][ T9784]  ret_from_fork_asm+0x1a/0x30
[  174.906128][ T9784]
[  174.906338][ T9784] Memory state around the buggy address:
[  174.906828][ T9784]  ffff88810b5fc580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  174.907528][ T9784]  ffff88810b5fc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  174.908222][ T9784] >ffff88810b5fc680: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
[  174.908917][ T9784]                                            ^
[  174.909481][ T9784]  ffff88810b5fc700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  174.910432][ T9784]  ffff88810b5fc780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  174.911401][ T9784] ==================================================================

The reason of the issue that code doesn't check the correctness
of the requested offset and length. As a result, incorrect value
of offset or/and length could result in access out of allocated
memory.

This patch introduces is_bnode_offset_valid() method that checks
the requested offset value. Also, it introduces
check_and_correct_requested_length() method that checks and
correct the requested length (if it is necessary). These methods
are used in hfsplus_bnode_read(), hfsplus_bnode_write(),
hfsplus_bnode_clear(), hfsplus_bnode_copy(), and hfsplus_bnode_move()
with the goal to prevent the access out of allocated memory
and triggering the crash.

Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
Reported-by: Shuoran Bai <baishuoran@hrbeu.edu.cn>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20250703214804.244077-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I notice I was analyzing the wrong commit. Let me analyze the actual
commit about hfsplus that was provided.

**YES** - This commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **Critical Security Bug Fix**
This commit fixes a serious **slab-out-of-bounds** vulnerability in the
HFS+ filesystem driver. The KASAN report shows:
```
BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x2f4/0x360
Read of size 8 at addr ffff88810b5fc6c0 by task repro/9784
```
This is a memory safety bug that can lead to kernel crashes and
potentially security exploits.

### 2. **Root Cause Analysis**
The commit message clearly identifies the root cause:
> "The reason of the issue that code doesn't check the correctness of
the requested offset and length. As a result, incorrect value of offset
or/and length could result in access out of allocated memory."

The code changes confirm this by adding two new validation functions:
- `is_bnode_offset_valid()` - validates that offsets don't exceed node
  boundaries
- `check_and_correct_requested_length()` - ensures length doesn't cause
  reads beyond allocated memory

### 3. **Widespread Impact**
The fix is applied to multiple critical HFS+ bnode operations:
- `hfs_bnode_read()`
- `hfs_bnode_write()`
- `hfs_bnode_clear()`
- `hfs_bnode_copy()`
- `hfs_bnode_move()`

This indicates the vulnerability affects core filesystem operations that
are commonly used.

### 4. **Meets Stable Criteria**
According to stable kernel rules, this commit qualifies because:
- **Fixes a real bug**: Out-of-bounds memory access that crashes the
  kernel
- **Small and contained**: The fix adds simple bounds checking (~150
  lines)
- **Already in mainline**: Has been accepted into Linus's tree
- **No new features**: Only adds safety checks, no functionality changes
- **Security implications**: Memory corruption bugs are security-
  relevant

### 5. **Minimal Risk of Regression**
The fix is conservative:
- Only adds validation checks before existing operations
- Logs errors when invalid parameters are detected
- Attempts to correct lengths rather than failing operations
- Doesn't change the fundamental behavior of working code

### 6. **Clear Reproducer**
The commit includes a detailed KASAN trace from a reproducer, showing:
- The exact call path through HFS+ deletion operations
- Memory allocation details
- The specific out-of-bounds access location

This indicates the bug is reproducible and the fix can be verified.

### 7. **Defensive Programming**
The added checks follow good defensive programming practices:
```c
if (!is_bnode_offset_valid(node, off))
    return;

len = check_and_correct_requested_length(node, off, len);
```
These prevent crashes while maintaining compatibility.

### 8. **Critical Subsystem**
Filesystem drivers are critical kernel components. Bugs in filesystem
code can:
- Lead to data corruption
- Cause system crashes
- Be exploited for privilege escalation
- Affect any user mounting HFS+ filesystems

### Conclusion
This commit fixes a serious memory safety vulnerability in the HFS+
filesystem driver that can cause kernel crashes and has potential
security implications. The fix is well-contained, adds only necessary
validation checks, and meets all criteria for stable kernel backporting.
It should be backported to all stable kernels that include the HFS+
driver to protect users from this vulnerability.

 fs/hfsplus/bnode.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index cf6e5de7b9da..c9c38fddf505 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,12 +18,68 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -83,6 +139,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -113,6 +183,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -139,6 +223,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page + (src >> PAGE_SHIFT);
@@ -196,6 +284,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	if (dst > src) {
-- 
2.39.5


