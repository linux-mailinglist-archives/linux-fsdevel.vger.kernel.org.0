Return-Path: <linux-fsdevel+bounces-62261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F039FB8B101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9780172FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8F287250;
	Fri, 19 Sep 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="S9m159eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A3284B4C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309196; cv=none; b=AmbU9uqLq3596R5WBcfvkG48t+bgDkko3TXlwNZ/EMw9iIYh1LSgIlJIHQl4M4t4C9C2kB9u5WVmFp6kYjE1q0U8dldgCmUft7WK3WDbLrHS+VZ7SYEEl3L0kvEElLcHBDdGIya5cP0LFl2Z2MV2uhjrAktAyv0lcQfFFr33Dus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309196; c=relaxed/simple;
	bh=ez54BGJROdGhYyTFjQIxGAZjWXn17iU4Q4A9Vj9H5mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWII2A6UmRrwGPopHBMlZHHEtGyIBWtTgmiME8SJQ2LshXoYPtJOetZjMc6OCiIiabt8EuSnCm8f1B034Jj6rNlETSJB65lU65I239uhv7RdjLYlV5UaPkQ+NnmXOHm0TGFY7Z96xl0YwBU5ynJWzZtMlneC9zIuTc66jdqIxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=S9m159eV; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso2759007276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1758309193; x=1758913993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqZtH5BbhZkYrEC8+05XmAhFcU8RpANTNqQFiM/rtgo=;
        b=S9m159eVOI2MhtQ7M9cORS9LUwerZOF24EAjI+EcotTdNAEFfiIPiEUZF0cTjXmDmT
         rFud2oY4nqK605s1epaWZZWyvbW0UVUXA+HrabGtyckZupvJCYXjpg/Q+G2BFJTrENNk
         XUWYTDhwhnHO3AIEmIQjUk5X2Fga0POdxaJXvVsCJyIocoyMXOART1s8PwVmDpc0576h
         P8zpT0QkxL5wZlBGjKehK9rxD03sKq/Jm7wPkltYjQCnHR1jUGs+LRfeAFJgcJB66CVI
         /ocEVc0vehoM7F0QVJfFoz2KojKKlxzNsXa23tAJYKJP4UYMGMNimGpF57qmvj7IWLpK
         4G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758309193; x=1758913993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqZtH5BbhZkYrEC8+05XmAhFcU8RpANTNqQFiM/rtgo=;
        b=AIZncOofGgu8I3Y91ly5E9T5Hz87NTekkTu+4b87YUMl3VG1Rf/0xjvs4Fu/B3c8Ad
         Gc8w8iQmlqQInsMiN6ZLRmNOnuuH+af8GS3TuJGcjaD62C+7QKFh6NxlNv3npSWJEQp/
         2GjjEvm1SHe9GU3drfWTyOnQ/VtWVB2av833C8oxmoqkN8pcjexFz0zh6MCycyHzc6Hk
         53RltBNLfFaAYOtq7CArsGQlvWJE7SanO8NSM6XgD/KQ++IdUm73ITyVjJzr4KB95k9d
         y/L9Or6HnYhcxvWy/cDhwNEsjVVdIgDL6lkqwNXOdD0hT2Gcy5y6TC5jDeFk1HVMR8cX
         mLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3cgFmqLpOtmV/6VFEyuCTZmW+56CBAvMQ6YvWXyMpTcbKC7WV6gb3HWaZKc0UHOl02eAjC2lRLSpU8ttI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66hDZo4CKBqTdl3bLDRWRb2jvoUVfSMoWLxzj1OzmtCt+LsWn
	Inci36m8vr4R6Q79+WfIT/k0VfGe7XbhvzJxUAn+BkLiU9MAcJX1Ws6q3lLr4PU5cV23rCKQ0vH
	Q6Hwh86I=
X-Gm-Gg: ASbGncvyLRrGcxgRjLrYgU6v1RTBXrzb3ntlIQiB9VOVoJlGYlTUI1Z2yH1RYwW///l
	ZXV2x5VW8FL4mTkma2fp6733eFfc08KDClKJOn5yy+hmsHyXpoOndP4tEmPnSsgKbDsvc3Sdm1M
	Zqr7jsjHAXh0a6OWuZGRiOHD26ZJGKnExpUw4g+mM2ReSMT4823Kwxq1MP1DAsl03ws5XCr8u35
	CdbVdqZyghZ9ftx3IMRmA0d1b9+NKqexfUUJbU0fn5285NkmA+1uL5/TgXe6j1ZS9V1aie5GyP1
	UFAIO4EvEL/iEFJprj2eS0nPIwvUs+xzcJPCc1Tz4/q/zvPwTjswA21FmIQme9MEbrMRsoBrwuo
	cGY2NwuDTXdYI+iJBtwTwjYEA6FZpplBD
X-Google-Smtp-Source: AGHT+IHtIuMza5ZgldZbvHV1n3MCmzAJOqNYupyRpFUzpHfca72SDVjVXOovCQ3Cx4zwLdsoX56t+w==
X-Received: by 2002:a05:690e:249b:b0:634:94a:3e65 with SMTP id 956f58d0204a3-6347f567b49mr2920629d50.24.1758309192747;
        Fri, 19 Sep 2025 12:13:12 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:dc6d:9e5d:c44a:ee7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bf24dsm16479457b3.7.2025.09.19.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:13:12 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	r772577952@gmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	syzkaller@googlegroups.com
Subject: [PATCH v2] hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
Date: Fri, 19 Sep 2025 12:12:44 -0700
Message-Id: <20250919191243.1370388-1-slava@dubeyko.com>
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

v2
The string length correction has been added for hfsplus_strcmp().

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
cc: syzkaller@googlegroups.com
---
 fs/hfsplus/unicode.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..ebd326799f35 100644
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
 
@@ -74,6 +86,18 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
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
 	for (len = min(len1, len2); len > 0; len--) {
 		c1 = be16_to_cpu(*p1);
 		c2 = be16_to_cpu(*p2);
-- 
2.43.0


