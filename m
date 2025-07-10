Return-Path: <linux-fsdevel+bounces-54554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F4B00F45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E001890A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B12C08C1;
	Thu, 10 Jul 2025 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="dpydQPpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC1291142
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188929; cv=none; b=PiR7KZZyD2lrjwgKwtuZ/htvBe+v0SoCZTjA3RV5+hUhgAcdIkpI8WRJqNUUZpe3UFkGlsCfpuG0aIXG0uyJ6PeHGqio7AKP2vWb4yTy2NdzI8A2T6pcIW0lpW/YCDIhhmPODGaxpGotGq61x47DAl/4KdtChP4aMfDBnaIGqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188929; c=relaxed/simple;
	bh=0lQSxC5a3xFqb3Aid0qNfTs8tKsPPjJSEc6RcCL9PtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nxq7xgiW2niEIEBadYUQ9acCf4/F4xHxydOTanBFON8KkJptLsOzeKj+r5/DkAq4DpFng8QNiFx6kJQ8WVFwqJi9WvctKPxVODLjkZCbwCzVGzU6z9ZPJmi7m0O6Tc1zZToHw5jkVSzNC5qqQxq5KvrHc5esnW1wjXAe9jOcW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=dpydQPpi; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e75668006b9so1525096276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752188926; x=1752793726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDvy1x4mIaGUaNX/J7TQQTTn/WMhROYZZs1C9lS6HbA=;
        b=dpydQPpiYn1LM4J8fP1lvk8matEOHRD8wtmMa5StswPjqeecCMtWGkwiD3I0JJ5hfO
         xWh6EBzLhsoWFx4gWdznGJ+yT6sbQP9kPw67xthbVn+uZHU7b0ciNVg/MdNwNC+JGHzf
         4S06uk+NhzDQto1HHad+ned/wZGTJ9f+8WCbq8oxP30wkGtXNrXnj0F6JINr+fZA3061
         tXHECRA4YY91KFafHXicbn2mbDHKD06R5f+B3BVloED0SLQz/SHqGaLox35gIRdg+K2F
         So129IDyAGkX2B9nh9kLsRPoVvDFOM3ET5m1GRME/pXBM+uSYjqXI0KtWFoGetb27Gid
         OL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188926; x=1752793726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDvy1x4mIaGUaNX/J7TQQTTn/WMhROYZZs1C9lS6HbA=;
        b=kLyzIPiJ03fyFTey0mICpczJrdYarNqIXDicEkI3+HXN3jGCuAMPfQdjxP/wHbuLO+
         9zECQdSFOXbzn7GPIGoe68jO17rX0zypfqrHU+r1IUNd8PLrdL3+JUmfhbROKv/y8byt
         Z0QRTEucH9CK7sX/jaNYqHVTNyFll7jbbzlyjILRfczhxUoTQ1Ahy2h3byjkkgacJa3e
         d1cn39YlOsaSpRZZaQuFF4k2LjOUP9avLDafmoCX/r7TM+tSOrMwwbpJJIUktU6EuWfh
         byng7kw6Ca2okSo/wU/pRK6j0QWUCewa6kkbI+7PhF87SrE3Gr6+yewOlf+3ae/GkZuL
         rQwA==
X-Forwarded-Encrypted: i=1; AJvYcCUxn9fqPjeEdgL7qKaczw3uGN6eJ4dTxl6kdLVk/ftWN7mXTIuCh3bhliJwvtp7FiG7Q3ZoLZ2+4HYaQ9ds@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjsHcc1AaIJm6ZRtkfMqmjFPHDLInEtBk6js73ORSq8dZFQDh
	CrYGfR9D1/pPMsx+2CJYP8xMGBPfb68Fp1qymB1Nc6llAoyJQPwCQW2yUjVxLx6dnqQ=
X-Gm-Gg: ASbGncvnOWoPedrZLFTJB/MeC3t/0q/2K2LQ/BRYKZioLsQOZQl0mdWUFtT+tgnlVOL
	ME5EgLDQ5kreAsoWgDBXSyrninvwY4SkAIsXmU0CpT05x/mjstCwIkrUNwWzok0pff0zJ8IKk+1
	GrA3qE8JwP2KDvp4MsLLxHK5cHfJ5A34tHctFXaugDe9c72QIMusqrCj16VK0PhWepBybsyqgaX
	DjPK6ZJeNa4JUS/4JLp+F0bOX3CjJ2jHKF51SO8h+CRHOZevmeJRp7Dnh/P3o66tkhxfSknYKvm
	9UaWj+Frj0q9pgdaxQwI86CqUTekNvMte3aE9XzAgX8uLYkxTxAoDkBy7q3h22/iWl6uhB5WLr3
	R9dooItNFXHxGcvMnPwaaUHheZWg6kKf24w==
X-Google-Smtp-Source: AGHT+IEROmjJbVUOYR+ly6Xzhr+NRl4WAk239BToFMtrxTx22LzlV5nDhsHrqFw4ySHsxKY1oWJEgA==
X-Received: by 2002:a05:690c:700c:b0:714:397:a3ac with SMTP id 00721157ae682-717d786dc87mr16763157b3.8.1752188925517;
        Thu, 10 Jul 2025 16:08:45 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9e89:c5b3:9b71:4f51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d4f786sm5135417b3.15.2025.07.10.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:08:44 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	wenzhi.wang@uwaterloo.ca,
	liushixin2@huawei.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Thu, 10 Jul 2025 16:08:30 -0700
Message-Id: <20250710230830.110500-1-slava@dubeyko.com>
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
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
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
2.43.0


