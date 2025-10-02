Return-Path: <linux-fsdevel+bounces-63324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E979BB510A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91EE1887FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DAB287245;
	Thu,  2 Oct 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="LQSsrrbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBE224AF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435259; cv=none; b=i9J04RDH8RVuaM+gNLpcJHSmt5jbutjNXJOILGhomjDYd+pDxvRsn4HQVwvw7g0MOE2Xg4OQZPMJ9nDYhB4CRfLid11Wc7ddhwDIwUABRvdyF8rXNqPtKuc+HvuIU+EEQ/9f3awpKfdvq2iHcKvRP+LMVJT6zwL6sjxX2I9TcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435259; c=relaxed/simple;
	bh=qUyFZ38BRsLYkXNahvNFkokuvYgDizRrmtHHkxPr+Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0A1kw8PuI7zr1HVZUQ2c7VvD3XSCdVszwbtlbf2zfnq5HBd44I42v+9z/dz2qbKT4cPKMVTt4VMBfPPO3uAJyTPJMuVB580JgWGP7VmSo5KZZx7bDR+f9KvEKOs6kvgEbrHAltZ6FZN7B82OqTf0hUePdQVEW7h2/9Ld4DgRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=LQSsrrbP; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72ce9790ab3so17232427b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1759435254; x=1760040054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo9mujan1hqeVIuLXm6A5yy9gB9fvmXd6ekbyYO8KPc=;
        b=LQSsrrbPx6S3kx9f3eQQKbPOwDpZC1op58yUejztSPG/wnrGdj5L86emPtt1gNsDrE
         rUU2gG4NPFUBPV+UOH6DVOmV/9xdtagZ96fGk++QNDYd516+hn724Fr6Kckf/fPIZxVp
         9PN5o+BLDBTwof5SLEKw0B6LmiK66zxZ6Bu7DhtTyUEIhYnf2w8w2gntt5r5xSajojfU
         g2W9jlPGXXzo4p2zSqojgChxmGUa0B3Bia1dxpgezSa84QLyZbEkMn/yZCRnMdO/6DOK
         8HmSdx8Vcdcorx60w6NCPKbOglHtSDqRKfgMKSkMDKe6KSkuMK9SoItARJPqOyRbTU+Q
         u3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435254; x=1760040054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xo9mujan1hqeVIuLXm6A5yy9gB9fvmXd6ekbyYO8KPc=;
        b=JBSOoea1pK6Ej4BfX5yWzM9IngvBdDn5ypSMnYpSVLVqMOLDRo/2uZN4ULkoLtx7kP
         urKvuCXPCdUfgmr1ITzXpdfinq7neu28OWp82yJ9OZhCCVtOsqmf7a5rCk3dJ6Kow9Df
         SD23ZmVSbgq5mf60QyY/WY5Nk6/EhSQBi+hFn2l36ul85GjdT2BnlKQP+3S+pK4ib8Qs
         ohei//LntKR6uNlzKt883gJPXW1EL9YfYVvwuTb++2h76YXwC8C7wJYXPsQCg9IQkwZd
         0H4CiJVEoyiUnj6ySmV7063ua1EvjX+bwXd5VwsqIG3iUlwk/bskKROp83/hQr/Rs2na
         u2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTChgcq1XE218JeyAms7cW1lAB9BBOaNWWAuv3JH2gzIIOtIL4VJqoDlU6dr1Kr0T2Rnj4bxsWwqF76a5c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lpJ+BoaBAN78HoTDI8nMM5YovzQfGifibbh4hc1K7C6wh4vZ
	ifxeg8zw6Q3fkYunGoh1l/pSiR9JoPoClS3BxwqLACZDRb+/U5uFEz8GPt92NQwXHjtBFgLYvbi
	zgclY
X-Gm-Gg: ASbGncvStDh+GIzdsxbC1E1aL9W83Rvkx7ua42tVDZS5P2Os3+SsyQSnIIhXTJtkbRM
	5ELnlIRtB9jzqFGlSUVGEvJDTeHhRH9feBXGHPNswbuUpFz6BZ2ds/Czf45E4Gm3Kh1vwASLHjQ
	4AM6NARXS2XlBYhqprBtPb3E+KYPJKCq06YhJtJO7w9/2eSFUt5gUJfbXQy6javfvsvkFSdacIF
	n5ex0SgeFSZKAUVtq4V28umTo+xnrsMjH3I9rqrsqFb6xaEJq1ixp/fytOFnL3M8VBU3tnF7az3
	ye7/LQP4juSk/IAvpZVGtfCUeGuvZpIIWiXIl3iuMdmFRSXMRXYxrw4fNqWyl0X6safORpGhHmC
	3eSIZXIa1ANvZmrfgHU8EhY9Gl8Wzvx3y5gJDkWAWTNSsJEFuatSejAN/6Q==
X-Google-Smtp-Source: AGHT+IF9T2wIfEzOlD9KSCDOFj4rlkh5gisMBjFDR61BmP/m8ESM/kXt4/rTwJKAPhZgX4ZhM9iCiw==
X-Received: by 2002:a05:690c:9a8d:b0:774:2bc1:4aa with SMTP id 00721157ae682-77f9471ffe4mr11397127b3.36.1759435253336;
        Thu, 02 Oct 2025 13:00:53 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:167c:5ae8:ef2a:c622])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81d342basm11004377b3.48.2025.10.02.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:00:52 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs/hfsplus: prevent getting negative values of offset/length
Date: Thu,  2 Oct 2025 13:00:21 -0700
Message-Id: <20251002200020.2578311-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reported KASAN out-of-bounds issue in
hfs_bnode_move():

[   45.588165][ T9821] hfs: dst 14, src 65536, len -65536
[   45.588895][ T9821] ==================================================================
[   45.590114][ T9821] BUG: KASAN: out-of-bounds in hfs_bnode_move+0xfd/0x140
[   45.591127][ T9821] Read of size 18446744073709486080 at addr ffff888035935400 by task repro/9821
[   45.592207][ T9821]
[   45.592420][ T9821] CPU: 0 UID: 0 PID: 9821 Comm: repro Not tainted 6.16.0-rc7-dirty #42 PREEMPT(full)
[   45.592428][ T9821] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   45.592431][ T9821] Call Trace:
[   45.592434][ T9821]  <TASK>
[   45.592437][ T9821]  dump_stack_lvl+0x1c1/0x2a0
[   45.592446][ T9821]  ? __virt_addr_valid+0x1c8/0x5c0
[   45.592454][ T9821]  ? __pfx_dump_stack_lvl+0x10/0x10
[   45.592461][ T9821]  ? rcu_is_watching+0x15/0xb0
[   45.592469][ T9821]  ? lock_release+0x4b/0x3e0
[   45.592476][ T9821]  ? __virt_addr_valid+0x1c8/0x5c0
[   45.592483][ T9821]  ? __virt_addr_valid+0x4a5/0x5c0
[   45.592491][ T9821]  print_report+0x17e/0x7c0
[   45.592497][ T9821]  ? __virt_addr_valid+0x1c8/0x5c0
[   45.592504][ T9821]  ? __virt_addr_valid+0x4a5/0x5c0
[   45.592511][ T9821]  ? __phys_addr+0xd3/0x180
[   45.592519][ T9821]  ? hfs_bnode_move+0xfd/0x140
[   45.592526][ T9821]  kasan_report+0x147/0x180
[   45.592531][ T9821]  ? _printk+0xcf/0x120
[   45.592537][ T9821]  ? hfs_bnode_move+0xfd/0x140
[   45.592544][ T9821]  ? hfs_bnode_move+0xfd/0x140
[   45.592552][ T9821]  kasan_check_range+0x2b0/0x2c0
[   45.592557][ T9821]  ? hfs_bnode_move+0xfd/0x140
[   45.592565][ T9821]  __asan_memmove+0x29/0x70
[   45.592572][ T9821]  hfs_bnode_move+0xfd/0x140
[   45.592580][ T9821]  hfs_brec_remove+0x473/0x560
[   45.592589][ T9821]  hfs_cat_move+0x6fb/0x960
[   45.592598][ T9821]  ? __pfx_hfs_cat_move+0x10/0x10
[   45.592607][ T9821]  ? seqcount_lockdep_reader_access+0x122/0x1c0
[   45.592614][ T9821]  ? lockdep_hardirqs_on+0x9c/0x150
[   45.592631][ T9821]  ? __lock_acquire+0xaec/0xd80
[   45.592641][ T9821]  hfs_rename+0x1dc/0x2d0
[   45.592649][ T9821]  ? __pfx_hfs_rename+0x10/0x10
[   45.592657][ T9821]  vfs_rename+0xac6/0xed0
[   45.592664][ T9821]  ? __pfx_vfs_rename+0x10/0x10
[   45.592670][ T9821]  ? d_alloc+0x144/0x190
[   45.592677][ T9821]  ? bpf_lsm_path_rename+0x9/0x20
[   45.592683][ T9821]  ? security_path_rename+0x17d/0x490
[   45.592691][ T9821]  do_renameat2+0x890/0xc50
[   45.592699][ T9821]  ? __pfx_do_renameat2+0x10/0x10
[   45.592707][ T9821]  ? getname_flags+0x1e5/0x540
[   45.592714][ T9821]  __x64_sys_rename+0x82/0x90
[   45.592720][ T9821]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.592725][ T9821]  do_syscall_64+0xf3/0x3a0
[   45.592741][ T9821]  ? exc_page_fault+0x9f/0xf0
[   45.592748][ T9821]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.592754][ T9821] RIP: 0033:0x7f7f73fe3fc9
[   45.592760][ T9821] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[   45.592765][ T9821] RSP: 002b:00007ffc7e116cf8 EFLAGS: 00000283 ORIG_RAX: 0000000000000052
[   45.592772][ T9821] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f73fe3fc9
[   45.592776][ T9821] RDX: 0000200000000871 RSI: 0000200000000780 RDI: 00002000000003c0
[   45.592781][ T9821] RBP: 00007ffc7e116d00 R08: 0000000000000000 R09: 00007ffc7e116d30
[   45.592784][ T9821] R10: fffffffffffffff0 R11: 0000000000000283 R12: 00005557e81f8250
[   45.592788][ T9821] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   45.592795][ T9821]  </TASK>
[   45.592797][ T9821]
[   45.619721][ T9821] The buggy address belongs to the physical page:
[   45.620300][ T9821] page: refcount:1 mapcount:1 mapping:0000000000000000 index:0x559a88174 pfn:0x35935
[   45.621150][ T9821] memcg:ffff88810a1d5b00
[   45.621531][ T9821] anon flags: 0xfff60000020838(uptodate|dirty|lru|owner_2|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
[   45.622496][ T9821] raw: 00fff60000020838 ffffea0000d64d88 ffff888021753e10 ffff888029da0771
[   45.623260][ T9821] raw: 0000000559a88174 0000000000000000 0000000100000000 ffff88810a1d5b00
[   45.624030][ T9821] page dumped because: kasan: bad access detected
[   45.624602][ T9821] page_owner tracks the page as allocated
[   45.625115][ T9821] page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO0
[   45.626685][ T9821]  post_alloc_hook+0x240/0x2a0
[   45.627127][ T9821]  get_page_from_freelist+0x2101/0x21e0
[   45.627628][ T9821]  __alloc_frozen_pages_noprof+0x274/0x380
[   45.628154][ T9821]  alloc_pages_mpol+0x241/0x4b0
[   45.628593][ T9821]  vma_alloc_folio_noprof+0xe4/0x210
[   45.629066][ T9821]  folio_prealloc+0x30/0x180
[   45.629487][ T9821]  __handle_mm_fault+0x34bd/0x5640
[   45.629957][ T9821]  handle_mm_fault+0x40e/0x8e0
[   45.630392][ T9821]  do_user_addr_fault+0xa81/0x1390
[   45.630862][ T9821]  exc_page_fault+0x76/0xf0
[   45.631273][ T9821]  asm_exc_page_fault+0x26/0x30
[   45.631712][ T9821] page last free pid 5269 tgid 5269 stack trace:
[   45.632281][ T9821]  free_unref_folios+0xc73/0x14c0
[   45.632740][ T9821]  folios_put_refs+0x55b/0x640
[   45.633177][ T9821]  free_pages_and_swap_cache+0x26d/0x510
[   45.633685][ T9821]  tlb_flush_mmu+0x3a0/0x680
[   45.634105][ T9821]  tlb_finish_mmu+0xd4/0x200
[   45.634525][ T9821]  exit_mmap+0x44c/0xb70
[   45.634914][ T9821]  __mmput+0x118/0x420
[   45.635286][ T9821]  exit_mm+0x1da/0x2c0
[   45.635659][ T9821]  do_exit+0x652/0x2330
[   45.636039][ T9821]  do_group_exit+0x21c/0x2d0
[   45.636457][ T9821]  __x64_sys_exit_group+0x3f/0x40
[   45.636915][ T9821]  x64_sys_call+0x21ba/0x21c0
[   45.637342][ T9821]  do_syscall_64+0xf3/0x3a0
[   45.637756][ T9821]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.638290][ T9821] page has been migrated, last migrate reason: numa_misplaced
[   45.638956][ T9821]
[   45.639173][ T9821] Memory state around the buggy address:
[   45.639677][ T9821]  ffff888035935300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   45.640397][ T9821]  ffff888035935380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   45.641117][ T9821] >ffff888035935400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   45.641837][ T9821]                    ^
[   45.642207][ T9821]  ffff888035935480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   45.642929][ T9821]  ffff888035935500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   45.643650][ T9821] ==================================================================

This commit [1] fixes the issue if an offset inside of b-tree node
or length of the request is bigger than b-tree node. However,
this fix is still not ready for negative values
of the offset or length. Moreover, negative values of
the offset or length doesn't make sense for b-tree's
operations. Because we could try to access the memory address
outside of the beginning of memory page's addresses range.
Also, using of negative values make logic very complicated,
unpredictable, and we could access the wrong item(s)
in the b-tree node.

This patch changes b-tree interface by means of converting
signed integer arguments of offset and length on u32 type.
Such conversion has goal to prevent of using negative values
unintentionally or by mistake in b-tree operations.

[1] 'commit a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")'

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/bfind.c          |  2 +-
 fs/hfs/bnode.c          | 52 ++++++++++++------------
 fs/hfs/brec.c           |  2 +-
 fs/hfs/btree.c          |  2 +-
 fs/hfs/btree.h          | 71 +++++++++++++++++----------------
 fs/hfs/hfs_fs.h         | 88 ++++++++++++++++++++++++-----------------
 fs/hfs/inode.c          |  3 +-
 fs/hfsplus/bfind.c      |  2 +-
 fs/hfsplus/bnode.c      | 60 ++++++++++++++--------------
 fs/hfsplus/brec.c       |  2 +-
 fs/hfsplus/btree.c      |  2 +-
 fs/hfsplus/hfsplus_fs.h | 38 +++++++++---------
 12 files changed, 171 insertions(+), 153 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index c2f840c49e60..d56e47bdc517 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -167,7 +167,7 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	return res;
 }
 
-int hfs_brec_read(struct hfs_find_data *fd, void *rec, int rec_len)
+int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
 {
 	int res;
 
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index fcfffe75d84e..13d58c51fc46 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -16,14 +16,14 @@
 #include "btree.h"
 
 static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 {
 	bool is_valid = off < node->tree->node_size;
 
 	if (!is_valid) {
 		pr_err("requested invalid offset: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
+		       "node_size %u, offset %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off);
 	}
@@ -32,7 +32,7 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
 }
 
 static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 {
 	unsigned int node_size;
 
@@ -42,12 +42,12 @@ int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
 	node_size = node->tree->node_size;
 
 	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
+		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
+		       "node_size %u, offset %u, "
+		       "requested_len %u, corrected_len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len, new_len);
 
@@ -57,12 +57,12 @@ int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
 	return len;
 }
 
-void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
+void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page *page;
-	int pagenum;
-	int bytes_read;
-	int bytes_to_read;
+	u32 pagenum;
+	u32 bytes_read;
+	u32 bytes_to_read;
 
 	if (!is_bnode_offset_valid(node, off))
 		return;
@@ -70,7 +70,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -86,7 +86,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 		if (pagenum >= node->tree->pages_per_bnode)
 			break;
 		page = node->page[pagenum];
-		bytes_to_read = min_t(int, len - bytes_read, PAGE_SIZE - off);
+		bytes_to_read = min_t(u32, len - bytes_read, PAGE_SIZE - off);
 
 		memcpy_from_page(buf + bytes_read, page, off, bytes_to_read);
 
@@ -95,7 +95,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	}
 }
 
-u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
+u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
 	__be16 data;
 	// optimize later...
@@ -103,7 +103,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 	return be16_to_cpu(data);
 }
 
-u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
+u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
 	u8 data;
 	// optimize later...
@@ -111,10 +111,10 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 {
 	struct hfs_btree *tree;
-	int key_len;
+	u32 key_len;
 
 	tree = node->tree;
 	if (node->type == HFS_NODE_LEAF ||
@@ -125,14 +125,14 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 
 	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
 		memset(key, 0, sizeof(hfs_btree_key));
-		pr_err("hfs: Invalid key length: %d\n", key_len);
+		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
 
 	hfs_bnode_read(node, key, off, key_len);
 }
 
-void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
+void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page *page;
 
@@ -142,7 +142,7 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -157,20 +157,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	set_page_dirty(page);
 }
 
-void hfs_bnode_write_u16(struct hfs_bnode *node, int off, u16 data)
+void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data)
 {
 	__be16 v = cpu_to_be16(data);
 	// optimize later...
 	hfs_bnode_write(node, &v, off, 2);
 }
 
-void hfs_bnode_write_u8(struct hfs_bnode *node, int off, u8 data)
+void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8 data)
 {
 	// optimize later...
 	hfs_bnode_write(node, &data, off, 1);
 }
 
-void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
+void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len)
 {
 	struct page *page;
 
@@ -180,7 +180,7 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -195,8 +195,8 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	set_page_dirty(page);
 }
 
-void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
-		struct hfs_bnode *src_node, int src, int len)
+void hfs_bnode_copy(struct hfs_bnode *dst_node, u32 dst,
+		    struct hfs_bnode *src_node, u32 src, u32 len)
 {
 	struct page *src_page, *dst_page;
 
@@ -216,7 +216,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	set_page_dirty(dst_page);
 }
 
-void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
+void hfs_bnode_move(struct hfs_bnode *node, u32 dst, u32 src, u32 len)
 {
 	struct page *page;
 	void *ptr;
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index e49a141c87e5..5a2f740ddefd 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -62,7 +62,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 	return retval;
 }
 
-int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
+int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 22e62fe7448b..b8be01809b63 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -259,7 +259,7 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 }
 
 /* Make sure @tree has enough space for the @rsvd_nodes */
-int hfs_bmap_reserve(struct hfs_btree *tree, int rsvd_nodes)
+int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 {
 	struct inode *inode = tree->inode;
 	u32 count;
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..97f88035b224 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -86,48 +86,49 @@ struct hfs_find_data {
 
 
 /* btree.c */
-extern struct hfs_btree *hfs_btree_open(struct super_block *, u32, btree_keycmp);
-extern void hfs_btree_close(struct hfs_btree *);
-extern void hfs_btree_write(struct hfs_btree *);
-extern int hfs_bmap_reserve(struct hfs_btree *, int);
-extern struct hfs_bnode * hfs_bmap_alloc(struct hfs_btree *);
+extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
+					btree_keycmp keycmp);
+extern void hfs_btree_close(struct hfs_btree *tree);
+extern void hfs_btree_write(struct hfs_btree *tree);
+extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes);
+extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
 extern void hfs_bmap_free(struct hfs_bnode *node);
 
 /* bnode.c */
-extern void hfs_bnode_read(struct hfs_bnode *, void *, int, int);
-extern u16 hfs_bnode_read_u16(struct hfs_bnode *, int);
-extern u8 hfs_bnode_read_u8(struct hfs_bnode *, int);
-extern void hfs_bnode_read_key(struct hfs_bnode *, void *, int);
-extern void hfs_bnode_write(struct hfs_bnode *, void *, int, int);
-extern void hfs_bnode_write_u16(struct hfs_bnode *, int, u16);
-extern void hfs_bnode_write_u8(struct hfs_bnode *, int, u8);
-extern void hfs_bnode_clear(struct hfs_bnode *, int, int);
-extern void hfs_bnode_copy(struct hfs_bnode *, int,
-			   struct hfs_bnode *, int, int);
-extern void hfs_bnode_move(struct hfs_bnode *, int, int, int);
-extern void hfs_bnode_dump(struct hfs_bnode *);
-extern void hfs_bnode_unlink(struct hfs_bnode *);
-extern struct hfs_bnode *hfs_bnode_findhash(struct hfs_btree *, u32);
-extern struct hfs_bnode *hfs_bnode_find(struct hfs_btree *, u32);
-extern void hfs_bnode_unhash(struct hfs_bnode *);
-extern void hfs_bnode_free(struct hfs_bnode *);
-extern struct hfs_bnode *hfs_bnode_create(struct hfs_btree *, u32);
-extern void hfs_bnode_get(struct hfs_bnode *);
-extern void hfs_bnode_put(struct hfs_bnode *);
+extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
+extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
+extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
+extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
+extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
+extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8 data);
+extern void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
+extern void hfs_bnode_copy(struct hfs_bnode *dst_node, u32 dst,
+			   struct hfs_bnode *src_node, u32 src, u32 len);
+extern void hfs_bnode_move(struct hfs_bnode *node, u32 dst, u32 src, u32 len);
+extern void hfs_bnode_dump(struct hfs_bnode *node);
+extern void hfs_bnode_unlink(struct hfs_bnode *node);
+extern struct hfs_bnode *hfs_bnode_findhash(struct hfs_btree *tree, u32 cnid);
+extern struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num);
+extern void hfs_bnode_unhash(struct hfs_bnode *node);
+extern void hfs_bnode_free(struct hfs_bnode *node);
+extern struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num);
+extern void hfs_bnode_get(struct hfs_bnode *node);
+extern void hfs_bnode_put(struct hfs_bnode *node);
 
 /* brec.c */
-extern u16 hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *);
-extern u16 hfs_brec_keylen(struct hfs_bnode *, u16);
-extern int hfs_brec_insert(struct hfs_find_data *, void *, int);
-extern int hfs_brec_remove(struct hfs_find_data *);
+extern u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off);
+extern u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec);
+extern int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len);
+extern int hfs_brec_remove(struct hfs_find_data *fd);
 
 /* bfind.c */
-extern int hfs_find_init(struct hfs_btree *, struct hfs_find_data *);
-extern void hfs_find_exit(struct hfs_find_data *);
-extern int __hfs_brec_find(struct hfs_bnode *, struct hfs_find_data *);
-extern int hfs_brec_find(struct hfs_find_data *);
-extern int hfs_brec_read(struct hfs_find_data *, void *, int);
-extern int hfs_brec_goto(struct hfs_find_data *, int);
+extern int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd);
+extern void hfs_find_exit(struct hfs_find_data *fd);
+extern int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd);
+extern int hfs_brec_find(struct hfs_find_data *fd);
+extern int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len);
+extern int hfs_brec_goto(struct hfs_find_data *fd, int cnt);
 
 
 struct hfs_bnode_desc {
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..38854df4c1b4 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -140,74 +140,90 @@ struct hfs_sb_info {
 #define HFS_FLG_ALT_MDB_DIRTY	2
 
 /* bitmap.c */
-extern u32 hfs_vbm_search_free(struct super_block *, u32, u32 *);
-extern int hfs_clear_vbm_bits(struct super_block *, u16, u16);
+extern u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u32 *num_bits);
+extern int hfs_clear_vbm_bits(struct super_block *sb, u16 start, u16 count);
 
 /* catalog.c */
-extern int hfs_cat_keycmp(const btree_key *, const btree_key *);
+extern int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2);
 struct hfs_find_data;
-extern int hfs_cat_find_brec(struct super_block *, u32, struct hfs_find_data *);
-extern int hfs_cat_create(u32, struct inode *, const struct qstr *, struct inode *);
-extern int hfs_cat_delete(u32, struct inode *, const struct qstr *);
-extern int hfs_cat_move(u32, struct inode *, const struct qstr *,
-			struct inode *, const struct qstr *);
-extern void hfs_cat_build_key(struct super_block *, btree_key *, u32, const struct qstr *);
+extern int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
+			     struct hfs_find_data *fd);
+extern int hfs_cat_create(u32 cnid, struct inode *dir,
+			  const struct qstr *str, struct inode *inode);
+extern int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str);
+extern int hfs_cat_move(u32 cnid, struct inode *src_dir,
+			const struct qstr *src_name,
+			struct inode *dst_dir,
+			const struct qstr *dst_name);
+extern void hfs_cat_build_key(struct super_block *sb, btree_key *key,
+			      u32 parent, const struct qstr *name);
 
 /* dir.c */
 extern const struct file_operations hfs_dir_operations;
 extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
-extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
+extern int hfs_ext_keycmp(const btree_key *key1, const btree_key *key2);
 extern u16 hfs_ext_find_block(struct hfs_extent *ext, u16 off);
-extern int hfs_free_fork(struct super_block *, struct hfs_cat_file *, int);
-extern int hfs_ext_write_extent(struct inode *);
-extern int hfs_extend_file(struct inode *);
-extern void hfs_file_truncate(struct inode *);
+extern int hfs_free_fork(struct super_block *sb,
+			 struct hfs_cat_file *file, int type);
+extern int hfs_ext_write_extent(struct inode *inode);
+extern int hfs_extend_file(struct inode *inode);
+extern void hfs_file_truncate(struct inode *inode);
 
-extern int hfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
+extern int hfs_get_block(struct inode *inode, sector_t block,
+			 struct buffer_head *bh_result, int create);
 
 /* inode.c */
 extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
 int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
-		loff_t pos, unsigned len, struct folio **foliop, void **fsdata);
-extern struct inode *hfs_new_inode(struct inode *, const struct qstr *, umode_t);
-extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, __be32 *, __be32 *);
-extern int hfs_write_inode(struct inode *, struct writeback_control *);
-extern int hfs_inode_setattr(struct mnt_idmap *, struct dentry *,
-			     struct iattr *);
+		    loff_t pos, unsigned int len, struct folio **foliop,
+		    void **fsdata);
+extern struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name,
+				   umode_t mode);
+extern void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
+				 __be32 *log_size, __be32 *phys_size);
+extern int hfs_write_inode(struct inode *inode, struct writeback_control *wbc);
+extern int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			     struct iattr *attr);
 extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
-			__be32 log_size, __be32 phys_size, u32 clump_size);
-extern struct inode *hfs_iget(struct super_block *, struct hfs_cat_key *, hfs_cat_rec *);
-extern void hfs_evict_inode(struct inode *);
-extern void hfs_delete_inode(struct inode *);
+				__be32 __log_size, __be32 phys_size,
+				u32 clump_size);
+extern struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key,
+				hfs_cat_rec *rec);
+extern void hfs_evict_inode(struct inode *inode);
+extern void hfs_delete_inode(struct inode *inode);
 
 /* attr.c */
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
-extern int hfs_mdb_get(struct super_block *);
-extern void hfs_mdb_commit(struct super_block *);
-extern void hfs_mdb_close(struct super_block *);
-extern void hfs_mdb_put(struct super_block *);
+extern int hfs_mdb_get(struct super_block *sb);
+extern void hfs_mdb_commit(struct super_block *sb);
+extern void hfs_mdb_close(struct super_block *sb);
+extern void hfs_mdb_put(struct super_block *sb);
 
 /* part_tbl.c */
-extern int hfs_part_find(struct super_block *, sector_t *, sector_t *);
+extern int hfs_part_find(struct super_block *sb,
+			 sector_t *part_start, sector_t *part_size);
 
 /* string.c */
 extern const struct dentry_operations hfs_dentry_operations;
 
-extern int hfs_hash_dentry(const struct dentry *, struct qstr *);
-extern int hfs_strcmp(const unsigned char *, unsigned int,
-		      const unsigned char *, unsigned int);
+extern int hfs_hash_dentry(const struct dentry *dentry, struct qstr *this);
+extern int hfs_strcmp(const unsigned char *s1, unsigned int len1,
+		      const unsigned char *s2, unsigned int len2);
 extern int hfs_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name);
+				unsigned int len, const char *str,
+				const struct qstr *name);
 
 /* trans.c */
-extern void hfs_asc2mac(struct super_block *, struct hfs_name *, const struct qstr *);
-extern int hfs_mac2asc(struct super_block *, char *, const struct hfs_name *);
+extern void hfs_asc2mac(struct super_block *sb,
+			struct hfs_name *out, const struct qstr *in);
+extern int hfs_mac2asc(struct super_block *sb,
+			char *out, const struct hfs_name *in);
 
 /* super.c */
 extern void hfs_mark_mdb_dirty(struct super_block *sb);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..cd43eff72d13 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -45,7 +45,8 @@ static void hfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
-		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
+		    loff_t pos, unsigned int len, struct folio **foliop,
+		    void **fsdata)
 {
 	int ret;
 
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index afc9c89e8c6a..336d654861c5 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -210,7 +210,7 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	return res;
 }
 
-int hfs_brec_read(struct hfs_find_data *fd, void *rec, int rec_len)
+int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
 {
 	int res;
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 63e652ad1e0d..f3a454b2c716 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -20,10 +20,10 @@
 
 
 /* Copy a specified range of bytes from the raw data of a node */
-void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
+void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page **pagep;
-	int l;
+	u32 l;
 
 	if (!is_bnode_offset_valid(node, off))
 		return;
@@ -31,7 +31,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -43,17 +43,17 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
 
-	l = min_t(int, len, PAGE_SIZE - off);
+	l = min_t(u32, len, PAGE_SIZE - off);
 	memcpy_from_page(buf, *pagep, off, l);
 
 	while ((len -= l) != 0) {
 		buf += l;
-		l = min_t(int, len, PAGE_SIZE);
+		l = min_t(u32, len, PAGE_SIZE);
 		memcpy_from_page(buf, *++pagep, 0, l);
 	}
 }
 
-u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
+u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
 	__be16 data;
 	/* TODO: optimize later... */
@@ -61,7 +61,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 	return be16_to_cpu(data);
 }
 
-u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
+u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
 	u8 data;
 	/* TODO: optimize later... */
@@ -69,10 +69,10 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 {
 	struct hfs_btree *tree;
-	int key_len;
+	u32 key_len;
 
 	tree = node->tree;
 	if (node->type == HFS_NODE_LEAF ||
@@ -84,17 +84,17 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 
 	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
 		memset(key, 0, sizeof(hfsplus_btree_key));
-		pr_err("hfsplus: Invalid key length: %d\n", key_len);
+		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}
 
 	hfs_bnode_read(node, key, off, key_len);
 }
 
-void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
+void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page **pagep;
-	int l;
+	u32 l;
 
 	if (!is_bnode_offset_valid(node, off))
 		return;
@@ -102,7 +102,7 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -114,29 +114,29 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
 
-	l = min_t(int, len, PAGE_SIZE - off);
+	l = min_t(u32, len, PAGE_SIZE - off);
 	memcpy_to_page(*pagep, off, buf, l);
 	set_page_dirty(*pagep);
 
 	while ((len -= l) != 0) {
 		buf += l;
-		l = min_t(int, len, PAGE_SIZE);
+		l = min_t(u32, len, PAGE_SIZE);
 		memcpy_to_page(*++pagep, 0, buf, l);
 		set_page_dirty(*pagep);
 	}
 }
 
-void hfs_bnode_write_u16(struct hfs_bnode *node, int off, u16 data)
+void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data)
 {
 	__be16 v = cpu_to_be16(data);
 	/* TODO: optimize later... */
 	hfs_bnode_write(node, &v, off, 2);
 }
 
-void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
+void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len)
 {
 	struct page **pagep;
-	int l;
+	u32 l;
 
 	if (!is_bnode_offset_valid(node, off))
 		return;
@@ -144,7 +144,7 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	if (len == 0) {
 		pr_err("requested zero length: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
+		       "node_size %u, offset %u, len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
 		return;
@@ -156,22 +156,22 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
 
-	l = min_t(int, len, PAGE_SIZE - off);
+	l = min_t(u32, len, PAGE_SIZE - off);
 	memzero_page(*pagep, off, l);
 	set_page_dirty(*pagep);
 
 	while ((len -= l) != 0) {
-		l = min_t(int, len, PAGE_SIZE);
+		l = min_t(u32, len, PAGE_SIZE);
 		memzero_page(*++pagep, 0, l);
 		set_page_dirty(*pagep);
 	}
 }
 
-void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
-		    struct hfs_bnode *src_node, int src, int len)
+void hfs_bnode_copy(struct hfs_bnode *dst_node, u32 dst,
+		    struct hfs_bnode *src_node, u32 src, u32 len)
 {
 	struct page **src_page, **dst_page;
-	int l;
+	u32 l;
 
 	hfs_dbg("dst %u, src %u, len %u\n", dst, src, len);
 	if (!len)
@@ -188,12 +188,12 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	dst &= ~PAGE_MASK;
 
 	if (src == dst) {
-		l = min_t(int, len, PAGE_SIZE - src);
+		l = min_t(u32, len, PAGE_SIZE - src);
 		memcpy_page(*dst_page, src, *src_page, src, l);
 		set_page_dirty(*dst_page);
 
 		while ((len -= l) != 0) {
-			l = min_t(int, len, PAGE_SIZE);
+			l = min_t(u32, len, PAGE_SIZE);
 			memcpy_page(*++dst_page, 0, *++src_page, 0, l);
 			set_page_dirty(*dst_page);
 		}
@@ -225,11 +225,11 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	}
 }
 
-void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
+void hfs_bnode_move(struct hfs_bnode *node, u32 dst, u32 src, u32 len)
 {
 	struct page **src_page, **dst_page;
 	void *src_ptr, *dst_ptr;
-	int l;
+	u32 l;
 
 	hfs_dbg("dst %u, src %u, len %u\n", dst, src, len);
 	if (!len)
@@ -299,7 +299,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 		dst &= ~PAGE_MASK;
 
 		if (src == dst) {
-			l = min_t(int, len, PAGE_SIZE - src);
+			l = min_t(u32, len, PAGE_SIZE - src);
 
 			dst_ptr = kmap_local_page(*dst_page) + src;
 			src_ptr = kmap_local_page(*src_page) + src;
@@ -309,7 +309,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 			kunmap_local(dst_ptr);
 
 			while ((len -= l) != 0) {
-				l = min_t(int, len, PAGE_SIZE);
+				l = min_t(u32, len, PAGE_SIZE);
 				dst_ptr = kmap_local_page(*++dst_page);
 				src_ptr = kmap_local_page(*++src_page);
 				memmove(dst_ptr, src_ptr, l);
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index b4645102feec..6796c1a80e99 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -60,7 +60,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 	return retval;
 }
 
-int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
+int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node;
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 7cc5aea14572..229f25dc7c49 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -344,7 +344,7 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 }
 
 /* Make sure @tree has enough space for the @rsvd_nodes */
-int hfs_bmap_reserve(struct hfs_btree *tree, int rsvd_nodes)
+int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 {
 	struct inode *inode = tree->inode;
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 89e8b19c127b..5ce9efe966af 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -357,21 +357,21 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size, u64 sectors,
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id);
 void hfs_btree_close(struct hfs_btree *tree);
 int hfs_btree_write(struct hfs_btree *tree);
-int hfs_bmap_reserve(struct hfs_btree *tree, int rsvd_nodes);
+int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes);
 struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
 void hfs_bmap_free(struct hfs_bnode *node);
 
 /* bnode.c */
-void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len);
-u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off);
-u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off);
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off);
-void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len);
-void hfs_bnode_write_u16(struct hfs_bnode *node, int off, u16 data);
-void hfs_bnode_clear(struct hfs_bnode *node, int off, int len);
-void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
-		    struct hfs_bnode *src_node, int src, int len);
-void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len);
+void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
+u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
+u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
+void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
+void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
+void hfs_bnode_copy(struct hfs_bnode *dst_node, u32 dst,
+		    struct hfs_bnode *src_node, u32 src, u32 len);
+void hfs_bnode_move(struct hfs_bnode *node, u32 dst, u32 src, u32 len);
 void hfs_bnode_dump(struct hfs_bnode *node);
 void hfs_bnode_unlink(struct hfs_bnode *node);
 struct hfs_bnode *hfs_bnode_findhash(struct hfs_btree *tree, u32 cnid);
@@ -386,7 +386,7 @@ bool hfs_bnode_need_zeroout(struct hfs_btree *tree);
 /* brec.c */
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off);
 u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec);
-int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len);
+int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len);
 int hfs_brec_remove(struct hfs_find_data *fd);
 
 /* bfind.c */
@@ -399,7 +399,7 @@ int hfs_find_rec_by_key(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 		    search_strategy_t rec_found);
 int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare);
-int hfs_brec_read(struct hfs_find_data *fd, void *rec, int rec_len);
+int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len);
 int hfs_brec_goto(struct hfs_find_data *fd, int cnt);
 
 /* catalog.c */
@@ -549,14 +549,14 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 }
 
 static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 {
 	bool is_valid = off < node->tree->node_size;
 
 	if (!is_valid) {
 		pr_err("requested invalid offset: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
+		       "node_size %u, offset %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off);
 	}
@@ -565,7 +565,7 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
 }
 
 static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 {
 	unsigned int node_size;
 
@@ -575,12 +575,12 @@ int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
 	node_size = node->tree->node_size;
 
 	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
+		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
 		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
+		       "node_size %u, offset %u, "
+		       "requested_len %u, corrected_len %u\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len, new_len);
 
-- 
2.43.0


