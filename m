Return-Path: <linux-fsdevel+bounces-56603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FEB19651
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E93B712B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BEE221F39;
	Sun,  3 Aug 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn024xb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142F7E792;
	Sun,  3 Aug 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256170; cv=none; b=ksnM1Z1BQbB/vpu/RcYKAf6pTGtgmkI3jqhGMq7piZF6PQnAit+L61Yt/SomNgE4nFjwyYGV4EXgL4iqYBd2Cc34hvWlOBEmwfR80PLz4qGK9llKoAuy714sWHZCJZkDbU3jgu+hG+/SXUkQtB9/tWIvT/Hk5Oy166+M8DT9e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256170; c=relaxed/simple;
	bh=eQ849iF4KjP3D9Dc9qqlZhLI00wTAMm52Ieg9rHLMSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoCa7DM6S6oELs3mn0lTb+G6E9v8CbsCfXZR32edArHw29ZHZgW1rtMnTNVgQT84DQc1nDZ5wUSfbPodCXq2vgqrkQ+K/F0rmd2xJ0P/LDMmlJwtp9nsQ8qL7PwggB7svToFc9tjAMvNxiB7WpXnDX1nXpJnlG/AxMASsAyU/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn024xb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F06C4CEEB;
	Sun,  3 Aug 2025 21:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256170;
	bh=eQ849iF4KjP3D9Dc9qqlZhLI00wTAMm52Ieg9rHLMSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn024xb9RXKFynUw8VYdsqoGUr4QSTNzj5x/kBGSwLNwlVcyAjq3ExzeJhxQyy+kN
	 kqWtD7tIc88eBl7AEPSDBOYFVVxzIfuScKuMqqaFa/V1lOHY6cy9p42aUpz+GJlg1F
	 eWTef/X2yMz16F2P7px77tFG4ga1OZ5QyCuCBYVzF/5Ms/7U3wRL1dkwJYuxx+GkUF
	 P2/eZkq8TW8PIHrX8XYQJ8/qEe6NeIbq6LgI8M1gbHzBDt1+vpVsC5WBkx5dZLnA6n
	 FnVQDgubCYfWsl7ZpuF8gQv5a8varHTYfAwk5r/CvOEyTQn7JXMUtuJnhZTsbgBOt+
	 YTdgiCq4z+J+Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Wenzhi Wang <wenzhi.wang@uwaterloo.ca>,
	Liu Shixin <liushixin2@huawei.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 03/11] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Sun,  3 Aug 2025 17:22:33 -0400
Message-Id: <20250803212242.3549318-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212242.3549318-1-sashal@kernel.org>
References: <20250803212242.3549318-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 94458781aee6045bd3d0ad4b80b02886b9e2219b ]

The hfsplus_readdir() method is capable to crash by calling
hfsplus_uni2asc():

[  667.121659][ T9805] ==================================================================
[  667.122651][ T9805] BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x902/0xa10
[  667.123627][ T9805] Read of size 2 at addr ffff88802592f40c by task repro/9805
[  667.124578][ T9805]
[  667.124876][ T9805] CPU: 3 UID: 0 PID: 9805 Comm: repro Not tainted 6.16.0-rc3 #1 PREEMPT(full)
[  667.124886][ T9805] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  667.124890][ T9805] Call Trace:
[  667.124893][ T9805]  <TASK>
[  667.124896][ T9805]  dump_stack_lvl+0x10e/0x1f0
[  667.124911][ T9805]  print_report+0xd0/0x660
[  667.124920][ T9805]  ? __virt_addr_valid+0x81/0x610
[  667.124928][ T9805]  ? __phys_addr+0xe8/0x180
[  667.124934][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
[  667.124942][ T9805]  kasan_report+0xc6/0x100
[  667.124950][ T9805]  ? hfsplus_uni2asc+0x902/0xa10
[  667.124959][ T9805]  hfsplus_uni2asc+0x902/0xa10
[  667.124966][ T9805]  ? hfsplus_bnode_read+0x14b/0x360
[  667.124974][ T9805]  hfsplus_readdir+0x845/0xfc0
[  667.124984][ T9805]  ? __pfx_hfsplus_readdir+0x10/0x10
[  667.124994][ T9805]  ? stack_trace_save+0x8e/0xc0
[  667.125008][ T9805]  ? iterate_dir+0x18b/0xb20
[  667.125015][ T9805]  ? trace_lock_acquire+0x85/0xd0
[  667.125022][ T9805]  ? lock_acquire+0x30/0x80
[  667.125029][ T9805]  ? iterate_dir+0x18b/0xb20
[  667.125037][ T9805]  ? down_read_killable+0x1ed/0x4c0
[  667.125044][ T9805]  ? putname+0x154/0x1a0
[  667.125051][ T9805]  ? __pfx_down_read_killable+0x10/0x10
[  667.125058][ T9805]  ? apparmor_file_permission+0x239/0x3e0
[  667.125069][ T9805]  iterate_dir+0x296/0xb20
[  667.125076][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
[  667.125084][ T9805]  ? __pfx___x64_sys_getdents64+0x10/0x10
[  667.125091][ T9805]  ? __x64_sys_openat+0x141/0x200
[  667.125126][ T9805]  ? __pfx_filldir64+0x10/0x10
[  667.125134][ T9805]  ? do_user_addr_fault+0x7fe/0x12f0
[  667.125143][ T9805]  do_syscall_64+0xc9/0x480
[  667.125151][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  667.125158][ T9805] RIP: 0033:0x7fa8753b2fc9
[  667.125164][ T9805] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[  667.125172][ T9805] RSP: 002b:00007ffe96f8e0f8 EFLAGS: 00000217 ORIG_RAX: 00000000000000d9
[  667.125181][ T9805] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8753b2fc9
[  667.125185][ T9805] RDX: 0000000000000400 RSI: 00002000000063c0 RDI: 0000000000000004
[  667.125190][ T9805] RBP: 00007ffe96f8e110 R08: 00007ffe96f8e110 R09: 00007ffe96f8e110
[  667.125195][ T9805] R10: 0000000000000000 R11: 0000000000000217 R12: 0000556b1e3b4260
[  667.125199][ T9805] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  667.125207][ T9805]  </TASK>
[  667.125210][ T9805]
[  667.145632][ T9805] Allocated by task 9805:
[  667.145991][ T9805]  kasan_save_stack+0x20/0x40
[  667.146352][ T9805]  kasan_save_track+0x14/0x30
[  667.146717][ T9805]  __kasan_kmalloc+0xaa/0xb0
[  667.147065][ T9805]  __kmalloc_noprof+0x205/0x550
[  667.147448][ T9805]  hfsplus_find_init+0x95/0x1f0
[  667.147813][ T9805]  hfsplus_readdir+0x220/0xfc0
[  667.148174][ T9805]  iterate_dir+0x296/0xb20
[  667.148549][ T9805]  __x64_sys_getdents64+0x13c/0x2c0
[  667.148937][ T9805]  do_syscall_64+0xc9/0x480
[  667.149291][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  667.149809][ T9805]
[  667.150030][ T9805] The buggy address belongs to the object at ffff88802592f000
[  667.150030][ T9805]  which belongs to the cache kmalloc-2k of size 2048
[  667.151282][ T9805] The buggy address is located 0 bytes to the right of
[  667.151282][ T9805]  allocated 1036-byte region [ffff88802592f000, ffff88802592f40c)
[  667.152580][ T9805]
[  667.152798][ T9805] The buggy address belongs to the physical page:
[  667.153373][ T9805] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25928
[  667.154157][ T9805] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  667.154916][ T9805] anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[  667.155631][ T9805] page_type: f5(slab)
[  667.155997][ T9805] raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
[  667.156770][ T9805] raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
[  667.157536][ T9805] head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
[  667.158317][ T9805] head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
[  667.159088][ T9805] head: 00fff00000000003 ffffea0000964a01 00000000ffffffff 00000000ffffffff
[  667.159865][ T9805] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  667.160643][ T9805] page dumped because: kasan: bad access detected
[  667.161216][ T9805] page_owner tracks the page as allocated
[  667.161732][ T9805] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN9
[  667.163566][ T9805]  post_alloc_hook+0x1c0/0x230
[  667.164003][ T9805]  get_page_from_freelist+0xdeb/0x3b30
[  667.164503][ T9805]  __alloc_frozen_pages_noprof+0x25c/0x2460
[  667.165040][ T9805]  alloc_pages_mpol+0x1fb/0x550
[  667.165489][ T9805]  new_slab+0x23b/0x340
[  667.165872][ T9805]  ___slab_alloc+0xd81/0x1960
[  667.166313][ T9805]  __slab_alloc.isra.0+0x56/0xb0
[  667.166767][ T9805]  __kmalloc_cache_noprof+0x255/0x3e0
[  667.167255][ T9805]  psi_cgroup_alloc+0x52/0x2d0
[  667.167693][ T9805]  cgroup_mkdir+0x694/0x1210
[  667.168118][ T9805]  kernfs_iop_mkdir+0x111/0x190
[  667.168568][ T9805]  vfs_mkdir+0x59b/0x8d0
[  667.168956][ T9805]  do_mkdirat+0x2ed/0x3d0
[  667.169353][ T9805]  __x64_sys_mkdir+0xef/0x140
[  667.169784][ T9805]  do_syscall_64+0xc9/0x480
[  667.170195][ T9805]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  667.170730][ T9805] page last free pid 1257 tgid 1257 stack trace:
[  667.171304][ T9805]  __free_frozen_pages+0x80c/0x1250
[  667.171770][ T9805]  vfree.part.0+0x12b/0xab0
[  667.172182][ T9805]  delayed_vfree_work+0x93/0xd0
[  667.172612][ T9805]  process_one_work+0x9b5/0x1b80
[  667.173067][ T9805]  worker_thread+0x630/0xe60
[  667.173486][ T9805]  kthread+0x3a8/0x770
[  667.173857][ T9805]  ret_from_fork+0x517/0x6e0
[  667.174278][ T9805]  ret_from_fork_asm+0x1a/0x30
[  667.174703][ T9805]
[  667.174917][ T9805] Memory state around the buggy address:
[  667.175411][ T9805]  ffff88802592f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  667.176114][ T9805]  ffff88802592f380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  667.176830][ T9805] >ffff88802592f400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  667.177547][ T9805]                       ^
[  667.177933][ T9805]  ffff88802592f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  667.178640][ T9805]  ffff88802592f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  667.179350][ T9805] ==================================================================

The hfsplus_uni2asc() method operates by struct hfsplus_unistr:

struct hfsplus_unistr {
	__be16 length;
	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
} __packed;

where HFSPLUS_MAX_STRLEN is 255 bytes. The issue happens if length
of the structure instance has value bigger than 255 (for example,
65283). In such case, pointer on unicode buffer is going beyond of
the allocated memory.

The patch fixes the issue by checking the length value of
hfsplus_unistr instance and using 255 value in the case if length
value is bigger than HFSPLUS_MAX_STRLEN. Potential reason of such
situation could be a corruption of Catalog File b-tree's node.

Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Yangtao Li <frank.li@vivo.com>
Link: https://lore.kernel.org/r/20250710230830.110500-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Critical Security Vulnerability**: The commit fixes a slab-out-of-
   bounds read vulnerability in `hfsplus_uni2asc()` that can be
   triggered when processing malformed HFS+ filesystem data. The KASAN
   report shows this causes memory corruption with reads beyond
   allocated bounds.

2. **Exploitable Attack Vector**: The vulnerability can be triggered
   through normal filesystem operations (readdir) on a crafted/corrupted
   HFS+ filesystem. An attacker could craft a malicious HFS+ image with
   `ustr->length` values exceeding `HFSPLUS_MAX_STRLEN` (255) to trigger
   out-of-bounds reads.

3. **Simple and Contained Fix**: The fix is minimal and straightforward
   - it adds a bounds check that limits `ustrlen` to
   `HFSPLUS_MAX_STRLEN` before using it in the loop that reads from the
   `unicode` array. The change is only 7 lines of code addition with no
   architectural changes.

4. **Low Risk of Regression**: The fix only adds a defensive check and
   doesn't change normal operation for valid HFS+ filesystems. It simply
   prevents reading beyond the allocated buffer when corrupted data is
   encountered.

5. **Pattern of Similar Issues**: The git history shows multiple similar
   slab-out-of-bounds fixes in HFS+ recently (`ac7825c41213`,
   `bb5e07cb9277`), indicating this filesystem has ongoing boundary
   checking issues that need to be addressed in stable kernels.

6. **User Impact**: HFS+ filesystems are commonly used for compatibility
   with macOS systems. Users mounting untrusted HFS+ media (USB drives,
   disk images) could be vulnerable to crashes or potential exploitation
   without this fix.

The commit clearly meets stable kernel criteria: it fixes a real bug
that affects users, the fix is small and contained, and the risk of
regression is minimal while the security benefit is significant.

 fs/hfsplus/unicode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..36b6cf2a3abb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -132,7 +132,14 @@ int hfsplus_uni2asc(struct super_block *sb,
 
 	op = astr;
 	ip = ustr->unicode;
+
 	ustrlen = be16_to_cpu(ustr->length);
+	if (ustrlen > HFSPLUS_MAX_STRLEN) {
+		ustrlen = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(ustr->length), ustrlen);
+	}
+
 	len = *len_p;
 	ce1 = NULL;
 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-- 
2.39.5


