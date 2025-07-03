Return-Path: <linux-fsdevel+bounces-53822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA1AF805C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293E16E87A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F482F235D;
	Thu,  3 Jul 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="rHeecDSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452C1AF0C1
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568133; cv=none; b=i5h7T9sAIcUsY9BSVwP814NmycQtrZVyYSDq0vS6PsVPrQEVDRlPDt47OlGZz++5UjyG72IoHCJv94bnq3CDdYIM6vbR7IXTbX87iRCY4YTblL2fXRaTVrDp9FlK66O1K10H+8IY7kqExWvVFKd3q25xm3K5UfT1iPcRqtlT31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568133; c=relaxed/simple;
	bh=Ggeemf4umk1FR90yEdIk8idGcIZ6XbCaKk91+ofcsEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Avuyp+i+HmH5nDdc5oPfJVTBrUm1pfsLT/5u5BRfjmClh/JrIdNhl+nooVxtpP6Op9FqizUxO6a2siJNvl4B2clYTlXL2J6lxjzhnBx0V4ypDNDRTlIQtaGie5if0WcsvdJcp/IhAS8sEokFFwe2bBj3cHbB77RL8QU0gC6ZRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=rHeecDSE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so105624276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751568130; x=1752172930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TvASgQaHHZT9Ej3MadO5evAKJ7rxgonamNr5/aM9XE=;
        b=rHeecDSEUsQrRcPnnoudMgDras+LcpA3f3YwZGGSHnHXUZl9wxo12cVT0Xt9GAJUNF
         HrVXI2OD7da6JuPXd/LEOm5kd6TuR4v4aQr+yInj/qb+mRVlpQYfCAiGa6nntgOvoYqe
         Zx44vQRUlQKtkrq/kBd9545a5mB3RElEkUry4TaiWIBfFJRKeH4ZESbKREvrQlkfjSZA
         GDZiQENa2E6kh7fXuKOnX8Z3tfKW5+wbFsTJzg9DHvpwI8xa1EOqJ19u34XVTt0SjhvT
         Dl8jvKSo9aqzrHaWygLNIDFyM5nTbhhqmvXfUOw3CGWmzZOZ4xOdXbqooQm1AqWzJ2nJ
         0ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568130; x=1752172930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TvASgQaHHZT9Ej3MadO5evAKJ7rxgonamNr5/aM9XE=;
        b=TYaNVzYr5NuOGhlUeD6ChBVdaAqu0mJKU9CZGVQrPy4AM+FSCSUSmbxoPC72NIQyMg
         T1/AyF/VmMO8+gwo/wvgpXLDuEHWN/oN+6d3ThwRzxBwKeIVLsBXTKITkNrun9a6O3ts
         Ybz0WYCGlFFBQ+N/TpV/fCp7yXkJ9kXSYYb0srfbljkzOAM5DR3vevy1fR9ClnuJKMfV
         XfWSCMeo+mZSRFbxkaI1G8onL2kTHrMh91SjCrQCqHkSbE9FTW1klJ+M0xxQEbLyxm1T
         tXAZrwNp0ylPNBSTFiNT1E/JMzVx8Pu2a3GJ9/2zNK7Lao+lwqZ2LoloDcGcw4Jx3FCg
         kLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF7M9bZNO3LLw/xywRNQ5KE5pYcuWcddcNgAK0xJpIBPdBYzUBxxsYIjjHBaggURXs6kniRVN8Bbtoq4Ia@vger.kernel.org
X-Gm-Message-State: AOJu0YzudiOzMyAJl7LZGkDP/1V0T72qUAzvMU0AqDZST1qxeACcbArV
	Dj6h/zrOIjoPLXi9sBzj43AA3SMsIWWjF7e0hpYiHimEgBdkx0I1SLl/PIqc6ZPYg9I=
X-Gm-Gg: ASbGnctvsJCHMaBU+dD15Eily58/zLHwKsL+WTKn1fQPs40EQemZlnGpcrrrPP7mUza
	fQ6+uL+gRZiZB/aDfdxgdoT4VxPXQGhUJm3+qxbum1LA7SMMaQtjD9WWxcQge/kJUyq8xlorv4O
	DCHpP2URvXoug6bkGDcJzpyJM/sqM1uii9s42rviLbjonZpNN7Z4BCyCw3WbkLU/EnSY4ufkBT4
	3+IMgHrNFHeAqO0JOyrqHNNG4UvGwQmbNLbzKS/GnEm5urWRS1Zql1vW5zplHUKxqMfuGQjuu8n
	QA5qe9eB43PNByF1cMVpHgrqwVsNH/WL+/mC1tW3RyGH0qm85OeL4fCzfL6zoJ2QecxLVJFj
X-Google-Smtp-Source: AGHT+IFEDZoF5lIsbSw9Qj9aSzmBosTRrIRXcZfxdRmZ/NqhLY2ClMwRrx4l9R59CvE31d8YC91Yhg==
X-Received: by 2002:a05:690c:4802:b0:714:268:a9f8 with SMTP id 00721157ae682-716590ec815mr67518107b3.27.1751568130346;
        Thu, 03 Jul 2025 11:42:10 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:38f:e803:4bcd:b8f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659b63cfsm672797b3.53.2025.07.03.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:42:09 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Thu,  3 Jul 2025 11:41:50 -0700
Message-Id: <20250703184150.239589-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/unicode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..7e62b3630fcd 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -132,7 +132,11 @@ int hfsplus_uni2asc(struct super_block *sb,
 
 	op = astr;
 	ip = ustr->unicode;
+
 	ustrlen = be16_to_cpu(ustr->length);
+	if (ustrlen > HFSPLUS_MAX_STRLEN)
+		ustrlen = HFSPLUS_MAX_STRLEN;
+
 	len = *len_p;
 	ce1 = NULL;
 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-- 
2.43.0


