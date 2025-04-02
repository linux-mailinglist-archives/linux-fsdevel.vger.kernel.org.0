Return-Path: <linux-fsdevel+bounces-45549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2437A7951E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3742189409F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F91DB92A;
	Wed,  2 Apr 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoM2nfxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682085BAF0;
	Wed,  2 Apr 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618649; cv=none; b=N10yR8CrJLAsFElC3dGyoMcBM7yy7234tnNFB41dSughVEbGFclk8Nc/eRhOmQjG44AO7qMh3kc3vZXMgO1U+wlGEWn0lDdck5P6mstY044vdLMa4kZcwl62g8x08ZdTXuEiqOd/dzQSQkWTlCNSe3TCiNVhqAwb4ZYOWzeBpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618649; c=relaxed/simple;
	bh=nqBTxCC2NUDCnK7sn4JDYoP39Ov2NRsfzS96f6/D4II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcMtoL8ZQusIsF4apuJbsI2SA0i7HzegU2gyHOpLjDob6asD//TQb4ftaWXhZ8GufGkfTynKB3OgiSZS9jjOR/50PAT7z5PDhV0rz/OY+cf+j4DFkUyhxcQYWgqpDthVA39esfTNPvN53avbNFg+092D/blMbXkRmzA2ASUbQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoM2nfxT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2243803b776so2125375ad.0;
        Wed, 02 Apr 2025 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743618646; x=1744223446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn8oma1oVfEpH5Tkl+SwVuQnB82UdbanCKRmFjYR/qA=;
        b=RoM2nfxTYM2dmoBXsthxfjdkB22kJSshF3AHrwtZouo68+k3GC5MSkoowzfRzo9ARC
         EE/RrTIjCiOR+xs7mV0JOpp7rfBHuvJYqaTGZytap6RMJTkC1s3pWp11x7P8mVn3dMX4
         rxZmQwtgqRcIxPVhFMrmpVdeybBx/wqPYPijeYvEYv1f6PBh0oTFjSSS0DFOWFLupZQn
         8EA/XzmQtTvwflf86VYJQkl0qMpdrTpxgCWtLNQkGJ0uHE0+ayx+EskqYpQeQC4pfyDn
         4LXqEz7QGBwIdelO5swKLjMQLsEkRDB9xsll5oMCs+6x+qIviS4ixixkX7wUi5sbEZoy
         g0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618646; x=1744223446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn8oma1oVfEpH5Tkl+SwVuQnB82UdbanCKRmFjYR/qA=;
        b=L0kHotdpZA04Vuq6i3JhXasaVCXtx19cGOEMpivGPVDRp2Vx2euGUuvt3PpktroNiS
         Mh96AlzKRJiMBW8nxgFulYuAe9Sxa5jvyYDiCmRw0poZ5hY+ginjpgI/2h99C2CiA787
         SwpG9+xHbrWJ4ULEkxpnErIX1GXL6iTAREourH+IbVWXHDjIVX/LqWyrwvNXuqdlsEDY
         z1wg5Smd1rDcGp8HEvDkqPb9EIriF0IDR2RgC3/gfBjpD92B5DU1i3B/5fNWKuiIVxwl
         E8yLr59849Awxjc4/19u7G1IJ142v32Pd4sbGUj4hR/sPn5lwSgLbV/cW03Chk75OX6p
         9xLA==
X-Forwarded-Encrypted: i=1; AJvYcCUZtqgr1dpbSb0S3lACeWAIa1Y/9ZRe4iRTAwVUwnP0mOG8mxniLRkzH0H4idOMEnswrgTsmGTs@vger.kernel.org, AJvYcCUz+BmyG/4/yYA51BmSd0SMuYyy6om/Zq4hKN1iR6Yq+ytwiZwENIWrda14ub4VNSoZreYL3nn9TgHRLW4=@vger.kernel.org, AJvYcCV8wDFnbaVuKFDrJLRRtOevHAbDG6/Rw3hQ0+MB79fvS0sq4o83qivJ5kqD721gjp/sAnyEHVlkLrMYT3Oc0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR5FAdtj+Drjw7ltRpgx8PrgZcm1Gs6Fe7/rVhpP6c7JwqB3o
	4z1Pn8k9lgWU/Zm6M/kuJZfm8rbhtJww+J0xtZ7Y2yCaUyIXQYPAWeDCrQ==
X-Gm-Gg: ASbGncvdetCtTpKU46UOk2MZb2HtQtiViToSX/IYJoSKv/9Qiv0fRfQdvTp8J056Wrn
	8HQKY9fwBay1z/Kze9YalWpqZBtW/E8rM3HRyTflKs1R6CD7ju6X3+aakyWHI/K71DzcjiDwjMF
	51mhw+TGHlVEbKQ7LPefX7vuKhSk28W+ga9CTSwktZ8QWoHud8OBVuJn0/h3YsfDihUQqN0n0Jx
	JqAs4D1A5VtJ/giGRF2CiuumJ+MCI9tmv7OogKqdQGjnB+GmJAQfTwzV0qrSl3eNv/peXxYbBG7
	STd9ZEzzpDMo+arByu76Qou6SbtQgCywib5E0C44Krjj8XYNgHBtnhRVFXRLEGx/
X-Google-Smtp-Source: AGHT+IFlodV5atdixW6g8XhG2y808h6V4Y6H1em+6G+wGPpHH4a4gTVZIdNpHOFLnhE9SCdZ3XY68w==
X-Received: by 2002:a17:902:db04:b0:220:d078:eb33 with SMTP id d9443c01a7336-2296c85d9c0mr39636725ad.36.1743618646422;
        Wed, 02 Apr 2025 11:30:46 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f5774sm111211645ad.214.2025.04.02.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:30:45 -0700 (PDT)
From: Swarna Prabhu <sw.prabhu6@gmail.com>
X-Google-Original-From: Swarna Prabhu <s.prabhu@samsung.com>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	xiang@kernel.org,
	david@redhat.com,
	huang.ying.caritas@gmail.com,
	willy@infradead.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	dave@stgolabs.net,
	gost.dev@samsung.com,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH v2] generic/750 : add missing _fixed_by_git_commit line to the test
Date: Wed,  2 Apr 2025 18:30:34 +0000
Message-ID: <20250402183034.2334125-1-s.prabhu@samsung.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing generic/750 with older kernels indicated that more work has to
be done, since we were able to reproduce a hang with v6.10-rc7 with 2.5
hours soak duration. We tried to reproduce the same issue on v6.12 and could
no longer reproduce the original hang. This motivated us to identify the commit
2e6506e1c4ee ("mm/migrate: fix deadlock in migrate_pages_batch() on large folios")
that fixes the originally reported deadlock hang annotated as pending work
to evaluate on generic/750. Hence if you are using kernel older than v6.11-rc4
this commit is needed.

Below is the kernel trace collected on v6.10-rc7 without the above
commit and CONFGI_PROVE_LOCKING enabled:

[ 8942.920967]  ret_from_fork_asm+0x1a/0x30
[ 8942.921450]  </TASK>
[ 8942.921711] INFO: task 750:2532 blocked for more than 241 seconds.                                                                                         [ 8942.922413]       Not tainted 6.10.0-rc7 #9
[ 8942.922894] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.                                                                      [ 8942.923770] task:750             state:D stack:0     pid:2532  tgid:2532  ppid:2349   flags:0x00004002                                                     [ 8942.924820] Call Trace:
[ 8942.925109]  <TASK>
[ 8942.925362]  __schedule+0x465/0xe10
[ 8942.925756]  schedule+0x39/0x140
[ 8942.926114]  io_schedule+0x42/0x70
[ 8942.926493]  folio_wait_bit_common+0x10e/0x330
[ 8942.926986]  ? __pfx_wake_page_function+0x10/0x10
[ 8942.927506]  migrate_pages_batch+0x765/0xeb0
[ 8942.927986]  ? __pfx_compaction_alloc+0x10/0x10
[ 8942.928488]  ? __pfx_compaction_free+0x10/0x10
[ 8942.928983]  migrate_pages+0xbfd/0xf50
[ 8942.929377]  ? __pfx_compaction_alloc+0x10/0x10
[ 8942.929838]  ? __pfx_compaction_free+0x10/0x10
[ 8942.930553]  compact_zone+0xa4d/0x11d0
[ 8942.930936]  ? rcu_is_watching+0xd/0x40
[ 8942.931332]  compact_node+0xa9/0x120
[ 8942.931704]  sysctl_compaction_handler+0x71/0xd0
[ 8942.932177]  proc_sys_call_handler+0x1b8/0x2d0
[ 8942.932641]  vfs_write+0x281/0x530
[ 8942.932993]  ksys_write+0x67/0xf0
[ 8942.933381]  do_syscall_64+0x69/0x140
[ 8942.933822]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8942.934415] RIP: 0033:0x7f8a460215c7
[ 8942.934843] RSP: 002b:00007fff75cf7bb0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 8942.935720] RAX: ffffffffffffffda RBX: 00007f8a45f8f740 RCX: 00007f8a460215c7
[ 8942.936550] RDX: 0000000000000002 RSI: 000055e89e3a7790 RDI: 0000000000000001
[ 8942.937405] RBP: 000055e89e3a7790 R08: 0000000000000000 R09: 0000000000000000                                                                              [ 8942.938236] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[ 8942.939068] R13: 00007f8a4617a5c0 R14: 00007f8a46177e80 R15: 0000000000000000
[ 8942.939902]  </TASK>
[ 8942.940169] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[ 8942.941150] INFO: lockdep is turned off.

With the commit cherry picked to v6.10-rc7 , the test passes
successfully without any hang/deadlock, however
with CONFIG_PROVE_LOCKING enabled we do see the below trace for the
passing case:

 BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
 turning off the locking correctness validator.
 CPU: 1 PID: 2959 Comm: kworker/u34:5 Not tainted 6.10.0-rc7+ #12
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
 Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x68/0x90
  __lock_acquire.cold+0x186/0x1b1
  lock_acquire+0xd6/0x2e0
  ? btrfs_get_alloc_profile+0x27/0x90 [btrfs]
  seqcount_lockdep_reader_access+0x70/0x90 [btrfs]
  ? btrfs_get_alloc_profile+0x27/0x90 [btrfs]
  btrfs_get_alloc_profile+0x27/0x90 [btrfs]
  btrfs_reserve_extent+0xa9/0x290 [btrfs]
  btrfs_alloc_tree_block+0xa5/0x520 [btrfs]
  ? lockdep_unlock+0x5e/0xd0
  ? __lock_acquire+0xc6f/0x1fa0
  btrfs_force_cow_block+0x111/0x5f0 [btrfs]
  btrfs_cow_block+0xcc/0x2d0 [btrfs]
  btrfs_search_slot+0x502/0xd00 [btrfs]
  ? stack_depot_save_flags+0x24/0x8a0
  btrfs_lookup_file_extent+0x48/0x70 [btrfs]
  btrfs_drop_extents+0x108/0xce0 [btrfs]
  ? _raw_spin_unlock_irqrestore+0x35/0x60
  ? __create_object+0x5e/0x90
  ? rcu_is_watching+0xd/0x40
  ? kmem_cache_alloc_noprof+0x280/0x320
  insert_reserved_file_extent+0xea/0x3a0 [btrfs]
  ? btrfs_init_block_rsv+0x51/0x60 [btrfs]
  btrfs_finish_one_ordered+0x3ea/0x840 [btrfs]
  btrfs_work_helper+0x103/0x4b0 [btrfs]
  ? lock_release+0x177/0x2e0
  process_one_work+0x21a/0x590
  ? lock_is_held_type+0xd5/0x130
  worker_thread+0x1bf/0x3c0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xdd/0x110
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2d/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Started fstests-check.scope - [systemd-run] /usr/bin/bash -c "exit 77".
 fstests-check.scope: Deactivated successfully.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
---
 tests/generic/750 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/750 b/tests/generic/750
index a0828b50..6606593c 100755
--- a/tests/generic/750
+++ b/tests/generic/750
@@ -26,11 +26,12 @@ _cleanup()
 _require_scratch
 _require_vm_compaction
 
-# We still deadlock with this test on v6.10-rc2, we need more work.
-# but the below makes things better.
 _fixed_by_git_commit kernel d99e3140a4d3 \
 	"mm: turn folio_test_hugetlb into a PageType"
 
+_fixed_by_git_commit kernel 2e6506e1c4ee \
+    "mm/migrate: fix deadlock in migrate_pages_batch() on large folios"
+
 echo "Silence is golden"
 
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.47.2


