Return-Path: <linux-fsdevel+bounces-61838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B193B7D736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CFE7B1F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176C291C13;
	Tue, 16 Sep 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="wELO8UeZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72663BA45
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065539; cv=none; b=V/m8nNaHCr5GZdsGOeYhOhFxB5V13JnzROTGxsPK4zEVQUQtTHXNvYOCdKacHQLCaKnUABGIoTf+jvjJHKaJAIfCSKk6eZIPASOuSRCdjsQc4TVVRjCaqqiVyTSOA34yeZH+zlrAX4P0mWbJUCJa3LkuYwviS7+O5FYa9zFG0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065539; c=relaxed/simple;
	bh=Z3gyCZHLu16jlFYh+yPR9dLdk365GuoRe5XLxxHnSxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8Eb438Uz6+uoS3AZmVUmkQ3YrF4Bc0l1zlShl8mr6/41MuWm2DViXPSgTGN9ho4nCj3FY2YFBhoeCutp4spsMPp6CGu9DOG9+7qT9nV64iaWVae1G5gDCDRD4+larusn1xkTAfGZIbjZ/7PWOkh8IB3VCtW44CAFbHhJaB+U88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=wELO8UeZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051aeafso42881777b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1758065535; x=1758670335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKRT+4D+HWmF0sBtpWo5ny6tQB36hTeipKd1ERrLDq8=;
        b=wELO8UeZOqk0e0ukRylqfGjkH/E1dcDwgOw1+a/jz8kWznLqK4GnpIUjQo/Ge7UH23
         JZD/rSM1I7SQKQbMSiapilrSZSw74sL6PIlKgRFomgpgBTSbG3C/XZs3WQ81/edTjv3R
         7jIkei/Y27geNOZwEwFhxmKeIuwRa6NxV2GcI2unOIxGakR0v0jgShOWmzjjwHZEbACq
         EAPtI3bePZt3Q2GVCceMuRe5tbKBsNjD1s+02f7qrUrsGXZxr2mswbcHKElDwSUSgy2D
         VkEzRNfn67yMesUHPG9JNGmcG4ttyVKbZthNKnfnA9oWWv/vXTvTLfB6FYF+a7D1P8lG
         pK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065535; x=1758670335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKRT+4D+HWmF0sBtpWo5ny6tQB36hTeipKd1ERrLDq8=;
        b=FzbQvRwzFRBar/ntxD3NlQJzbtbH6dW09wc0WIecELTz5VRlCaOFMeDj3Xq/OrieHK
         D9Ylmkdu7P6OUW/bqmfqfvayES0dXZJK+QXlqcYI3Nxm2pDx6rsxu2AQ7TrzGuYhUR8C
         ryMG9LcutD49Lp3M//PB5ym+84VV4kVe0dIuw+pNocibyhOaemLbpp8fiKu/Mj8Bt5bw
         XaajgokneJbIEqcoPAFIEKlz//W/VnjXouvu4gZvk4dt7d5ON0cTm1mQiLF2Yjb4jTbR
         RD+Ha4TEGoRv2A0Vh30thf3Oi+LnJEt5AwU6lFthBUkGMrYjyESQNs9IhAsSxpp9e37X
         8XKA==
X-Forwarded-Encrypted: i=1; AJvYcCW3DpbsWNa4J2LWKIR8RivjAalSSklyE4ZJwT6K3js/2iCkY0gdqGEgf6GZtDWE+3inshcY2Rcs78l6xeLt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3/L6mKNOZi+peCPkT1me6c8X9UdDbu5ZyyP8DuQQ9uaCqT0i
	WudGZwlFJu+Y3noTPMZP+xggOwCKQvGt45uDQx7mnmTsjyH4sO9B/cejnXE/827M07Q=
X-Gm-Gg: ASbGncvhjphkVzYwWT/eBOjAx5nzskDDGiDFm80YvQSFtADn0rJDbV2PaKv0lQysrUV
	SCro56I+pVVOfdaVS97mYvqVD+i9fv8iPURT+mH4Z6kkUKW9yHxq1qGn11wWYYfQmW9+xrQxOki
	0W6HBqM+krhZHFO339GKHnElnPp1y/QXD8zCZA+Cb+WgIa4gFBJNjZnNJuJfggGf4i6oPtQ8XUc
	uBPYnGVmoQ0ChmGWBEC/UNBYlHZO/mAjfOhNsKeboqIB17SyrTkZFGg6TMjUz21PD7eq2Pr7AxM
	ACxJgrm9dtfbMMzZeJuzrLp9eHEBsraRIZpAGUJRpSWHfKCtwckv/2X8PoRXxXcLDKEwLBmqunO
	qRVd8Awz9uO60Ok0WmNu3sy6rsok40o/ezw==
X-Google-Smtp-Source: AGHT+IG8K8mRi8hdNofEF66rJX3rQqvk6LouMbe26PP4yMprayeQPWJZn0r/gTNaGQgPp8JkY2mSDg==
X-Received: by 2002:a05:690c:7002:b0:721:64ec:bc64 with SMTP id 00721157ae682-73892a48a08mr903767b3.35.1758065535068;
        Tue, 16 Sep 2025 16:32:15 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:98b2:dfdb:a51f:9339])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-736ad7b2aafsm10903037b3.5.2025.09.16.16.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:32:14 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	r772577952@gmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	syzkaller@googlegroups.com
Subject: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
Date: Tue, 16 Sep 2025 16:31:45 -0700
Message-Id: <20250916233144.1251879-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hfsplus_strcasecmp() logic can trigger the issue:

[  117.317703][ T9855] ==================================================================
[  117.318353][ T9855] BUG: KASAN: slab-out-of-bounds in hfsplus_strcasecmp+0x1bc/0x490
[  117.318991][ T9855] Read of size 2 at addr ffff88802160f40c by task repro/9855
[  117.319577][ T9855]
[  117.319773][ T9855] CPU: 0 UID: 0 PID: 9855 Comm: repro Not tainted 6.17.0-rc6 #33 PREEMPT(full)
[  117.319780][ T9855] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  117.319783][ T9855] Call Trace:
[  117.319785][ T9855]  <TASK>
[  117.319788][ T9855]  dump_stack_lvl+0x1c1/0x2a0
[  117.319795][ T9855]  ? __virt_addr_valid+0x1c8/0x5c0
[  117.319803][ T9855]  ? __pfx_dump_stack_lvl+0x10/0x10
[  117.319808][ T9855]  ? rcu_is_watching+0x15/0xb0
[  117.319816][ T9855]  ? lock_release+0x4b/0x3e0
[  117.319821][ T9855]  ? __kasan_check_byte+0x12/0x40
[  117.319828][ T9855]  ? __virt_addr_valid+0x1c8/0x5c0
[  117.319835][ T9855]  ? __virt_addr_valid+0x4a5/0x5c0
[  117.319842][ T9855]  print_report+0x17e/0x7e0
[  117.319848][ T9855]  ? __virt_addr_valid+0x1c8/0x5c0
[  117.319855][ T9855]  ? __virt_addr_valid+0x4a5/0x5c0
[  117.319862][ T9855]  ? __phys_addr+0xd3/0x180
[  117.319869][ T9855]  ? hfsplus_strcasecmp+0x1bc/0x490
[  117.319876][ T9855]  kasan_report+0x147/0x180
[  117.319882][ T9855]  ? hfsplus_strcasecmp+0x1bc/0x490
[  117.319891][ T9855]  hfsplus_strcasecmp+0x1bc/0x490
[  117.319900][ T9855]  ? __pfx_hfsplus_cat_case_cmp_key+0x10/0x10
[  117.319906][ T9855]  hfs_find_rec_by_key+0xa9/0x1e0
[  117.319913][ T9855]  __hfsplus_brec_find+0x18e/0x470
[  117.319920][ T9855]  ? __pfx_hfsplus_bnode_find+0x10/0x10
[  117.319926][ T9855]  ? __pfx_hfs_find_rec_by_key+0x10/0x10
[  117.319933][ T9855]  ? __pfx___hfsplus_brec_find+0x10/0x10
[  117.319942][ T9855]  hfsplus_brec_find+0x28f/0x510
[  117.319949][ T9855]  ? __pfx_hfs_find_rec_by_key+0x10/0x10
[  117.319956][ T9855]  ? __pfx_hfsplus_brec_find+0x10/0x10
[  117.319963][ T9855]  ? __kmalloc_noprof+0x2a9/0x510
[  117.319969][ T9855]  ? hfsplus_find_init+0x8c/0x1d0
[  117.319976][ T9855]  hfsplus_brec_read+0x2b/0x120
[  117.319983][ T9855]  hfsplus_lookup+0x2aa/0x890
[  117.319990][ T9855]  ? __pfx_hfsplus_lookup+0x10/0x10
[  117.320003][ T9855]  ? d_alloc_parallel+0x2f0/0x15e0
[  117.320008][ T9855]  ? __lock_acquire+0xaec/0xd80
[  117.320013][ T9855]  ? __pfx_d_alloc_parallel+0x10/0x10
[  117.320019][ T9855]  ? __raw_spin_lock_init+0x45/0x100
[  117.320026][ T9855]  ? __init_waitqueue_head+0xa9/0x150
[  117.320034][ T9855]  __lookup_slow+0x297/0x3d0
[  117.320039][ T9855]  ? __pfx___lookup_slow+0x10/0x10
[  117.320045][ T9855]  ? down_read+0x1ad/0x2e0
[  117.320055][ T9855]  lookup_slow+0x53/0x70
[  117.320065][ T9855]  walk_component+0x2f0/0x430
[  117.320073][ T9855]  path_lookupat+0x169/0x440
[  117.320081][ T9855]  filename_lookup+0x212/0x590
[  117.320089][ T9855]  ? __pfx_filename_lookup+0x10/0x10
[  117.320098][ T9855]  ? strncpy_from_user+0x150/0x290
[  117.320105][ T9855]  ? getname_flags+0x1e5/0x540
[  117.320112][ T9855]  user_path_at+0x3a/0x60
[  117.320117][ T9855]  __x64_sys_umount+0xee/0x160
[  117.320123][ T9855]  ? __pfx___x64_sys_umount+0x10/0x10
[  117.320129][ T9855]  ? do_syscall_64+0xb7/0x3a0
[  117.320135][ T9855]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  117.320141][ T9855]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  117.320145][ T9855]  do_syscall_64+0xf3/0x3a0
[  117.320150][ T9855]  ? exc_page_fault+0x9f/0xf0
[  117.320154][ T9855]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  117.320158][ T9855] RIP: 0033:0x7f7dd7908b07
[  117.320163][ T9855] Code: 23 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 08
[  117.320167][ T9855] RSP: 002b:00007ffd5ebd9698 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
[  117.320172][ T9855] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7dd7908b07
[  117.320176][ T9855] RDX: 0000000000000009 RSI: 0000000000000009 RDI: 00007ffd5ebd9740
[  117.320179][ T9855] RBP: 00007ffd5ebda780 R08: 0000000000000005 R09: 00007ffd5ebd9530
[  117.320181][ T9855] R10: 00007f7dd799bfc0 R11: 0000000000000202 R12: 000055e2008b32d0
[  117.320184][ T9855] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  117.320189][ T9855]  </TASK>
[  117.320190][ T9855]
[  117.351311][ T9855] Allocated by task 9855:
[  117.351683][ T9855]  kasan_save_track+0x3e/0x80
[  117.352093][ T9855]  __kasan_kmalloc+0x8d/0xa0
[  117.352490][ T9855]  __kmalloc_noprof+0x288/0x510
[  117.352914][ T9855]  hfsplus_find_init+0x8c/0x1d0
[  117.353342][ T9855]  hfsplus_lookup+0x19c/0x890
[  117.353747][ T9855]  __lookup_slow+0x297/0x3d0
[  117.354148][ T9855]  lookup_slow+0x53/0x70
[  117.354514][ T9855]  walk_component+0x2f0/0x430
[  117.354921][ T9855]  path_lookupat+0x169/0x440
[  117.355325][ T9855]  filename_lookup+0x212/0x590
[  117.355740][ T9855]  user_path_at+0x3a/0x60
[  117.356115][ T9855]  __x64_sys_umount+0xee/0x160
[  117.356529][ T9855]  do_syscall_64+0xf3/0x3a0
[  117.356920][ T9855]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  117.357429][ T9855]
[  117.357636][ T9855] The buggy address belongs to the object at ffff88802160f000
[  117.357636][ T9855]  which belongs to the cache kmalloc-2k of size 2048
[  117.358827][ T9855] The buggy address is located 0 bytes to the right of
[  117.358827][ T9855]  allocated 1036-byte region [ffff88802160f000, ffff88802160f40c)
[  117.360061][ T9855]
[  117.360266][ T9855] The buggy address belongs to the physical page:
[  117.360813][ T9855] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21608
[  117.361562][ T9855] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  117.362285][ T9855] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[  117.362929][ T9855] page_type: f5(slab)
[  117.363282][ T9855] raw: 00fff00000000040 ffff88801a842f00 ffffea0000932000 dead000000000002
[  117.364015][ T9855] raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
[  117.364750][ T9855] head: 00fff00000000040 ffff88801a842f00 ffffea0000932000 dead000000000002
[  117.365491][ T9855] head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
[  117.366232][ T9855] head: 00fff00000000003 ffffea0000858201 00000000ffffffff 00000000ffffffff
[  117.366968][ T9855] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  117.367711][ T9855] page dumped because: kasan: bad access detected
[  117.368259][ T9855] page_owner tracks the page as allocated
[  117.368745][ T9855] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN1
[  117.370541][ T9855]  post_alloc_hook+0x240/0x2a0
[  117.370954][ T9855]  get_page_from_freelist+0x2101/0x21e0
[  117.371435][ T9855]  __alloc_frozen_pages_noprof+0x274/0x380
[  117.371935][ T9855]  alloc_pages_mpol+0x241/0x4b0
[  117.372360][ T9855]  allocate_slab+0x8d/0x380
[  117.372752][ T9855]  ___slab_alloc+0xbe3/0x1400
[  117.373159][ T9855]  __kmalloc_cache_noprof+0x296/0x3d0
[  117.373621][ T9855]  nexthop_net_init+0x75/0x100
[  117.374038][ T9855]  ops_init+0x35c/0x5c0
[  117.374400][ T9855]  setup_net+0x10c/0x320
[  117.374768][ T9855]  copy_net_ns+0x31b/0x4d0
[  117.375156][ T9855]  create_new_namespaces+0x3f3/0x720
[  117.375613][ T9855]  unshare_nsproxy_namespaces+0x11c/0x170
[  117.376094][ T9855]  ksys_unshare+0x4ca/0x8d0
[  117.376477][ T9855]  __x64_sys_unshare+0x38/0x50
[  117.376879][ T9855]  do_syscall_64+0xf3/0x3a0
[  117.377265][ T9855] page last free pid 9110 tgid 9110 stack trace:
[  117.377795][ T9855]  __free_frozen_pages+0xbeb/0xd50
[  117.378229][ T9855]  __put_partials+0x152/0x1a0
[  117.378625][ T9855]  put_cpu_partial+0x17c/0x250
[  117.379026][ T9855]  __slab_free+0x2d4/0x3c0
[  117.379404][ T9855]  qlist_free_all+0x97/0x140
[  117.379790][ T9855]  kasan_quarantine_reduce+0x148/0x160
[  117.380250][ T9855]  __kasan_slab_alloc+0x22/0x80
[  117.380662][ T9855]  __kmalloc_noprof+0x232/0x510
[  117.381074][ T9855]  tomoyo_supervisor+0xc0a/0x1360
[  117.381498][ T9855]  tomoyo_env_perm+0x149/0x1e0
[  117.381903][ T9855]  tomoyo_find_next_domain+0x15ad/0x1b90
[  117.382378][ T9855]  tomoyo_bprm_check_security+0x11c/0x180
[  117.382859][ T9855]  security_bprm_check+0x89/0x280
[  117.383289][ T9855]  bprm_execve+0x8f1/0x14a0
[  117.383673][ T9855]  do_execveat_common+0x528/0x6b0
[  117.384103][ T9855]  __x64_sys_execve+0x94/0xb0
[  117.384500][ T9855]
[  117.384706][ T9855] Memory state around the buggy address:
[  117.385179][ T9855]  ffff88802160f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  117.385854][ T9855]  ffff88802160f380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  117.386534][ T9855] >ffff88802160f400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  117.387204][ T9855]                       ^
[  117.387566][ T9855]  ffff88802160f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  117.388243][ T9855]  ffff88802160f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  117.388918][ T9855] ==================================================================

The issue takes place if the length field of struct hfsplus_unistr
is bigger than HFSPLUS_MAX_STRLEN. The patch simply checks
the length of comparing strings. And if the strings' length
is bigger than HFSPLUS_MAX_STRLEN, then it is corrected
to this value.

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
cc: syzkaller@googlegroups.com
---
 fs/hfsplus/unicode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..fbd414eb9dd3 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -40,6 +40,18 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	while (1) {
 		c1 = c2 = 0;
 
-- 
2.43.0


