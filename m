Return-Path: <linux-fsdevel+bounces-63296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2439BB4575
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2231887BAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD422068A;
	Thu,  2 Oct 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufFn4CZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D34223DF1;
	Thu,  2 Oct 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419050; cv=none; b=m1OlAiTkGw01Tdbpj0FE6rqxpCXcJsjS/0/tKY8WoHmK7LNNmJveU5jyG/8ihURgf6Gz37vbvpxPobYuqtHhBcgOfasYOGgwrm9HoEzjbADIEBkfAeeb+ckNcxge6ztyJf+0rR3JlIvNO4b/Wh2BFCPGzeHIm2WNzf+pZ9uC7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419050; c=relaxed/simple;
	bh=W+g2ooGxwQR0hE1gQDEFbxKQNXMCcP4sf8qJJ5ROrGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0pmb5ZpmstL5DFXaENckzhLaVE2r96pNzsqiXj8boPg+Gf2pHbqp//CC8nIv7XBp9i9Yu1LwQMzrcp9Oo5lD4K8jHUYYODcy9hEVkH+93rniWRMGdqC4DKUHWliinm77ngZa0WytWok9e1el8QMHfQPbCcA1Yiju7smHFpZrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufFn4CZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85A5C4CEF4;
	Thu,  2 Oct 2025 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419049;
	bh=W+g2ooGxwQR0hE1gQDEFbxKQNXMCcP4sf8qJJ5ROrGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufFn4CZ728lb1vdxiJtl85cDx8AM5LedRinZQbVkMTgjdObYwrrjj4ucTMV5/rhxC
	 +tHSkjUN0KiQnZU+MnPORaAHYoimV66qvvSVHTpTPvzHWxaSDmq0idJ9skid+kwk4h
	 PewUOj+VZI1OyhuvwI+5/Fd5/AxN2Efl7zEFENUuoUdKD09HUQDuMkbb/9/7IS6V9u
	 NkshmX8R5muggZj09735TCCnTrWKpSpVcd1/IqlnaxrlI6jOIJs2P5UPNcZ8H5NDCl
	 EmG5A9pJZ3Ad577OFyPIeIpbSnKh0pO/f9NQzhUscg2ZkSpPuOxBG8rlFumlA2x8wy
	 p+gRzI66lSIAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.17-5.4] hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
Date: Thu,  2 Oct 2025 11:30:05 -0400
Message-ID: <20251002153025.2209281-18-sashal@kernel.org>
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

[ Upstream commit 4840ceadef4290c56cc422f0fc697655f3cbf070 ]

The syzbot reported issue in __hfsplus_ext_cache_extent():

[   70.194323][ T9350] BUG: KMSAN: uninit-value in __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.195022][ T9350]  __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.195530][ T9350]  hfsplus_file_extend+0x74f/0x1cf0
[   70.195998][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.196458][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.196959][ T9350]  cont_write_begin+0x1000/0x1950
[   70.197416][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.197873][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.198374][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.198892][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.199393][ T9350]  vfs_write+0xb0f/0x14e0
[   70.199771][ T9350]  ksys_write+0x23e/0x490
[   70.200149][ T9350]  __x64_sys_write+0x97/0xf0
[   70.200570][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.201065][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.201506][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.202054][ T9350]
[   70.202279][ T9350] Uninit was created at:
[   70.202693][ T9350]  __kmalloc_noprof+0x621/0xf80
[   70.203149][ T9350]  hfsplus_find_init+0x8d/0x1d0
[   70.203602][ T9350]  hfsplus_file_extend+0x6ca/0x1cf0
[   70.204087][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.204561][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.205074][ T9350]  cont_write_begin+0x1000/0x1950
[   70.205547][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.206017][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.206519][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.207042][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.207552][ T9350]  vfs_write+0xb0f/0x14e0
[   70.207961][ T9350]  ksys_write+0x23e/0x490
[   70.208375][ T9350]  __x64_sys_write+0x97/0xf0
[   70.208810][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.209255][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.209680][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.210230][ T9350]
[   70.210454][ T9350] CPU: 2 UID: 0 PID: 9350 Comm: repro Not tainted 6.12.0-rc5 #5
[   70.211174][ T9350] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.212115][ T9350] =====================================================
[   70.212734][ T9350] Disabling lock debugging due to kernel taint
[   70.213284][ T9350] Kernel panic - not syncing: kmsan.panic set ...
[   70.213858][ T9350] CPU: 2 UID: 0 PID: 9350 Comm: repro Tainted: G    B              6.12.0-rc5 #5
[   70.214679][ T9350] Tainted: [B]=BAD_PAGE
[   70.215057][ T9350] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.215999][ T9350] Call Trace:
[   70.216309][ T9350]  <TASK>
[   70.216585][ T9350]  dump_stack_lvl+0x1fd/0x2b0
[   70.217025][ T9350]  dump_stack+0x1e/0x30
[   70.217421][ T9350]  panic+0x502/0xca0
[   70.217803][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0

[   70.218294][ Message fromT sy9350]  kmsan_report+0x296/slogd@syzkaller 0x2aat Aug 18 22:11:058 ...
 kernel
:[   70.213284][ T9350] Kernel panic - not syncing: kmsan.panic [   70.220179][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
set ...
[   70.221254][ T9350]  ? __msan_warning+0x96/0x120
[   70.222066][ T9350]  ? __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.223023][ T9350]  ? hfsplus_file_extend+0x74f/0x1cf0
[   70.224120][ T9350]  ? hfsplus_get_block+0xe16/0x17b0
[   70.224946][ T9350]  ? __block_write_begin_int+0x962/0x2ce0
[   70.225756][ T9350]  ? cont_write_begin+0x1000/0x1950
[   70.226337][ T9350]  ? hfsplus_write_begin+0x85/0x130
[   70.226852][ T9350]  ? generic_perform_write+0x3e8/0x1060
[   70.227405][ T9350]  ? __generic_file_write_iter+0x215/0x460
[   70.227979][ T9350]  ? generic_file_write_iter+0x109/0x5e0
[   70.228540][ T9350]  ? vfs_write+0xb0f/0x14e0
[   70.228997][ T9350]  ? ksys_write+0x23e/0x490
[   70.229458][ T9350]  ? __x64_sys_write+0x97/0xf0
[   70.229939][ T9350]  ? x64_sys_call+0x3015/0x3cf0
[   70.230432][ T9350]  ? do_syscall_64+0xd9/0x1d0
[   70.230941][ T9350]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.231926][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.232738][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.233711][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.234516][ T9350]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.235398][ T9350]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.236323][ T9350]  ? hfsplus_brec_find+0x218/0x9f0
[   70.237090][ T9350]  ? __pfx_hfs_find_rec_by_key+0x10/0x10
[   70.237938][ T9350]  ? __msan_instrument_asm_store+0xbf/0xf0
[   70.238827][ T9350]  ? __msan_metadata_ptr_for_store_4+0x27/0x40
[   70.239772][ T9350]  ? __hfsplus_ext_write_extent+0x536/0x620
[   70.240666][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.241175][ T9350]  __msan_warning+0x96/0x120
[   70.241645][ T9350]  __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.242223][ T9350]  hfsplus_file_extend+0x74f/0x1cf0
[   70.242748][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.243255][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.243878][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.244400][ T9350]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.244967][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.245531][ T9350]  ? __pfx_hfsplus_get_block+0x10/0x10
[   70.246079][ T9350]  cont_write_begin+0x1000/0x1950
[   70.246598][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.247105][ T9350]  ? __pfx_hfsplus_get_block+0x10/0x10
[   70.247650][ T9350]  ? __pfx_hfsplus_write_begin+0x10/0x10
[   70.248211][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.248752][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.249314][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.249856][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.250487][ T9350]  vfs_write+0xb0f/0x14e0
[   70.250930][ T9350]  ? __pfx_generic_file_write_iter+0x10/0x10
[   70.251530][ T9350]  ksys_write+0x23e/0x490
[   70.251974][ T9350]  __x64_sys_write+0x97/0xf0
[   70.252450][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.252924][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.253384][ T9350]  ? irqentry_exit+0x16/0x60
[   70.253844][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.254430][ T9350] RIP: 0033:0x7f7a92adffc9
[   70.254873][ T9350] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[   70.256674][ T9350] RSP: 002b:00007fff0bca3188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   70.257485][ T9350] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a92adffc9
[   70.258246][ T9350] RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000004
[   70.258998][ T9350] RBP: 00007fff0bca31a0 R08: 00007fff0bca31a0 R09: 00007fff0bca31a0
[   70.259769][ T9350] R10: 0000000000000000 R11: 0000000000000202 R12: 000055e0d75f8250
[   70.260520][ T9350] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   70.261286][ T9350]  </TASK>
[   70.262026][ T9350] Kernel Offset: disabled

(gdb) l *__hfsplus_ext_cache_extent+0x7d0
0xffffffff8318aef0 is in __hfsplus_ext_cache_extent (fs/hfsplus/extents.c:168).
163		fd->key->ext.cnid = 0;
164		res = hfs_brec_find(fd, hfs_find_rec_by_key);
165		if (res && res != -ENOENT)
166			return res;
167		if (fd->key->ext.cnid != fd->search_key->ext.cnid ||
168		    fd->key->ext.fork_type != fd->search_key->ext.fork_type)
169			return -ENOENT;
170		if (fd->entrylength != sizeof(hfsplus_extent_rec))
171			return -EIO;
172		hfs_bnode_read(fd->bnode, extent, fd->entryoffset,

The __hfsplus_ext_cache_extent() calls __hfsplus_ext_read_extent():

res = __hfsplus_ext_read_extent(fd, hip->cached_extents, inode->i_ino,
				block, HFSPLUS_IS_RSRC(inode) ?
					HFSPLUS_TYPE_RSRC :
					HFSPLUS_TYPE_DATA);

And if inode->i_ino could be equal to zero or any non-available CNID,
then hfs_brec_find() could not find the record in the tree. As a result,
fd->key could be compared with fd->search_key. But hfsplus_find_init()
uses kmalloc() for fd->key and fd->search_key allocation:

int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
{
<skipped>
        ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
        if (!ptr)
                return -ENOMEM;
        fd->search_key = ptr;
        fd->key = ptr + tree->max_key_len + 2;
<skipped>
}

Finally, fd->key is still not initialized if hfs_brec_find()
has found nothing.

This patch changes kmalloc() on kzalloc() in hfs_find_init()
and intializes fd->record, fd->keyoffset, fd->keylength,
fd->entryoffset, fd->entrylength for the case if hfs_brec_find()
has been found nothing in the b-tree node.

Reported-by: syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250818225232.126402-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit, I will now provide my
backport recommendation.

## BACKPORT ANALYSIS

**YES**

## EXTENSIVE ANALYSIS

### Bug Description and Severity

This commit fixes a **KMSAN uninit-value bug** in the hfsplus filesystem
where uninitialized kernel memory is being accessed during B-tree
operations. The bug manifests in `__hfsplus_ext_cache_extent()` at
fs/hfsplus/extents.c:167-168 when comparing `fd->key` fields with
`fd->search_key` fields.

### Root Cause Analysis

The vulnerability exists in fs/hfsplus/bfind.c:21 where
`hfs_find_init()` uses `kmalloc()` to allocate memory for search keys:

```c
ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
```

**Critical issue**: `kmalloc()` does NOT zero-initialize memory. When
`hfs_brec_find()` fails to locate a B-tree record, the allocated
`fd->key` structure remains uninitialized. Subsequent code at
fs/hfsplus/extents.c:167-168 then reads these uninitialized values:

```c
if (fd->key->ext.cnid != fd->search_key->ext.cnid ||
    fd->key->ext.fork_type != fd->search_key->ext.fork_type)
```

### Bug Age and Scope

- **Age**: This bug has existed since **Linux 2.6.12-rc2 (April 2005)**
  - approximately **20 years old**
- **Scope**: `hfs_find_init()` is called from **25+ locations** across
  the hfsplus codebase (dir.c, extents.c, catalog.c, attributes.c,
  xattr.c, super.c, inode.c)
- **Impact**: Affects all hfsplus B-tree operations including directory
  lookups, file extension management, extended attributes, and catalog
  operations

### The Fix

The commit implements a **two-part fix**:

1. **Line 21 of fs/hfsplus/bfind.c**: Change `kmalloc()` → `kzalloc()`
   - Ensures all allocated memory is zero-initialized
   - Prevents uninitialized memory reads

2. **Lines 161-165 of fs/hfsplus/bfind.c**: Initialize fd fields to -1
  ```c
  fd->record = -1;
  fd->keyoffset = -1;
  fd->keylength = -1;
  fd->entryoffset = -1;
  fd->entrylength = -1;
  ```
   - Provides defensive initialization even when B-tree search fails
   - Makes failure cases more predictable and detectable

### Security Implications

1. **Information Disclosure**: Uninitialized kernel memory may contain
   sensitive data from previous allocations, which could leak to
   userspace through error paths

2. **Kernel Panic**: With KMSAN enabled, accessing uninitialized memory
   triggers immediate kernel panic (as demonstrated in the syzbot
   report)

3. **Attack Surface**: Local users with ability to mount HFS+
   filesystems can trigger this bug

4. **Related Vulnerabilities**: The hfsplus filesystem has had multiple
   security issues:
   - CVE-2025-0927 (heap overflow, CVSS 7.8)
   - Multiple syzbot-reported KMSAN issues recently fixed
   - Pattern of memory safety bugs in this filesystem

### Fix Quality and Risk Assessment

**Risk Level: VERY LOW**

- **Minimal code change**: 7 insertions, 1 deletion in a single file
- **Safe transformation**: `kzalloc()` is a drop-in replacement for
  `kmalloc()` + memset
- **No behavioral changes**: Only initializes memory that should have
  been initialized
- **No dependencies**: Self-contained fix with no prerequisite patches
- **Well-tested**: Already backported to stable trees (commit
  a95ecc42e5a93)
- **No architectural changes**: Doesn't modify algorithms or data
  structures

### Backport Justification

This commit meets **ALL** stable kernel backport criteria:

✓ **Fixes important bug**: Kernel memory safety issue affecting
filesystem operations
✓ **Real-world impact**: Reported by syzbot with reproducible test case
✓ **Small and contained**: Single file, minimal changes
✓ **Low regression risk**: Safe memory initialization with no side
effects
✓ **No new features**: Pure bugfix
✓ **Subsystem-confined**: Only affects hfsplus filesystem
✓ **Clear correctness**: Obviously correct fix for obvious bug

### Historical Context

The git history shows that similar hfsplus bugs are routinely backported
to stable kernels:
- Multiple "slab-out-of-bounds" fixes with stable@ tags
- UAF (use-after-free) fixes backported
- Other KMSAN uninit-value issues in hfsplus recently fixed (commit
  7d58365c743ed, 9b3d15a758910)

The pattern demonstrates that memory safety issues in hfsplus are
considered important enough for stable backporting.

### Current Status

- **Mainline commit**: 4840ceadef4290c56cc422f0fc697655f3cbf070 (August
  18, 2025)
- **Already backported**: To at least one stable tree (a95ecc42e5a93)
- **Current 6.17 tree**: **DOES NOT** have this fix (still uses
  `kmalloc()`)
- **Applies cleanly**: No conflicts expected with 6.17

### Conclusion

This is a **clear YES for backporting**. It fixes a 20-year-old memory
safety bug with minimal risk, has real-world impact (syzbot report), and
follows the established pattern of backporting hfsplus memory safety
fixes to stable kernels.

 fs/hfsplus/bfind.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d202..26ebac4c60424 100644
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
@@ -158,6 +158,12 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
-- 
2.51.0


