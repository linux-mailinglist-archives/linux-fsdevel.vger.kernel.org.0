Return-Path: <linux-fsdevel+bounces-53849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051AAF82D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF74A056A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F431FFC46;
	Thu,  3 Jul 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="fsVFThGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98092DE701
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579315; cv=none; b=Rydz5VtipOCQpzNDdeQCoEtWy4Oh1vjFHbHQWp0CVcwOBVvNll3DYUOne135pOgcHWHXCiur18uQKI03i0IDqI+Dwi6vnO7k84pYQzPbJ51Hb50Bzn0voOWUUVVRR5gDsl7di+kh47fkcIuB1y7zW3hUk7/ACkmHafkOsGBIeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579315; c=relaxed/simple;
	bh=DFTVZnAhe4VxtUDnrUdQ8G/0SKOGKvsZ7gEEKKb8XoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eHzXLDrW3Eq9Haqm5MsrhWxAkCjZuvPY/Bh5B5EmvvzK6B3Dy1ygdr4gCM/zRtIRfFYQXuHYfBy7k7hALAPJQa/Z9XicP1J5qJzI9mKqutgzu98Zdt1HgPoqcPerx0qEYDTN0Fro4T3H7pYQtMVj1Bm9Ioxgfw+xRG7sWnzl1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=fsVFThGV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7387d4a336so228934276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751579312; x=1752184112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXyY6A+74yrnn8ImUBkt4JZRUeMQfy0kC2P0uJW9UYQ=;
        b=fsVFThGV89l5jS//UULUrkYfaY9psE4cUqE7bVztx2uWzsOixq14LgJzSfuPpSTDZx
         Dd7vfoQ/ISGHjYXLxj9xpgaa6ecv66jyme8ll0KMzLuzpA+ngHa9o/kvwH4vzU5Cnf2a
         vp5aTJKCSja+eUMFs+rFnPYZpQ0YcY6mfCFHGM9RoNmNSHXGoiaZMBccqRY8/2cs+p1B
         qbSBLZyU/UfIoTlsuvviJKOILqfKpLiojJbHCSdKqVteG4t7B/5L/CIy197C4pcgUTe+
         e8xelVd1vZNVPESOWZvGGsqRc9T0lr8I1iregpwep/vzXD5nznGkKCaGWbegjFj1jhZO
         WrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579312; x=1752184112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXyY6A+74yrnn8ImUBkt4JZRUeMQfy0kC2P0uJW9UYQ=;
        b=jHpAG8+m2wqdVbgvedsB+McME/F7RuGtiwjnGXfJvLo29GeONgOyA1HeAKIq/U1hMz
         8XVoNO+80pqMrOVgmfEVNnrlYPaVs8HwWgBOnnTFuqFJzxzbdcrv7i+NrwjA+4P+wTDE
         7o0xEV7R/q4dK5fPoP26Y9lVjuPk0Rewlisj4mZscCx5IWxlwBdOgXQ4nt4+0YS0OiN4
         kWxX3v5/Lx4bHtOTqgLbUuWZJDt1vUdU5d5EU0n6uO5+dxbj3GqLAr+cdg1ZQWGCZdLz
         JjvWnyTJXgQXpyjWNJA8oEV/u1LYaqNAUma9hppl4XacjTwR5pVLxzlhVbAP1BgAQXnk
         SIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXChgc33UbtB++MayQLvS0CvlvClRZY7JTIYokbh+hmFY5pg8fjW4DtOACoCxJnv1u1AHuT9QwmDQLKXVYo@vger.kernel.org
X-Gm-Message-State: AOJu0YwzF7A8fhacW9pYFOYB2jbKWa4dXSd7ZjHyjh74RS4sa6i/GKzT
	KY9JLKgpIpHOpYJwJ5vf4cXpqv4ARYuBBJh+khw2de8e3Xswha9EdUDSQMpL54P8bgw=
X-Gm-Gg: ASbGncuHGLXUkDEuCAtGjV9j9TU7WkipfRzn7nvQpIBTZQJrbGp1bErqcJsqh31hW1C
	Til4gktFok8s0UDRYi4HlN341VkrFUp8/z2IKA9NnXnDFToTi0aa44BSNcS55BTEC9mDBnRcuVL
	5Z/hByaIY6XFrwVD0GpXQONKa3B+KoAx8+vJELLL3EIS5ZliyojVN1hmvN9DjAE0L82Yy9pMB/m
	IyELxB2m/KL144IVmMBzcAc0Wi6PsLXr5qbOsCsLkyNK5+LvANTeI2ND5K0SWGejB1ddNi/4u5Z
	UvumUvbcdqWEx5ggjT5ruBOLEbbXtsvYpSSdip4jZY4LPUCHoTqh4RPHf5hFD2X9U3EviimbXPQ
	shZY/8II=
X-Google-Smtp-Source: AGHT+IFkkr+rrwpa63znhXhWVbAG8hzUgFZkOSSE0XXz4yuqWKiB6yNkVpSAcpGB3FOnPVFHc2NJ7w==
X-Received: by 2002:a05:6902:2301:b0:e89:8425:8972 with SMTP id 3f1490d57ef6-e899e4ab0aamr446481276.11.1751579311717;
        Thu, 03 Jul 2025 14:48:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:38f:e803:4bcd:b8f6])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c3024cfsm178322276.10.2025.07.03.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:48:30 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	huk23@m.fudan.edu.cn,
	jjtan24@m.fudan.edu.cn,
	baishuoran@hrbeu.edu.cn,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
Date: Thu,  3 Jul 2025 14:48:04 -0700
Message-Id: <20250703214804.244077-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/hfsplus/bnode.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 079ea80534f7..14f4995588ff 100644
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
@@ -81,6 +137,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
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
@@ -109,6 +179,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
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
@@ -133,6 +217,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
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
@@ -187,6 +275,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
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
2.43.0


