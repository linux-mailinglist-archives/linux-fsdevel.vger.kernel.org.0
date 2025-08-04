Return-Path: <linux-fsdevel+bounces-56688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A055B1A9D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6929317DED6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48876237704;
	Mon,  4 Aug 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="C2Zbtiq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496A1DF269
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754337080; cv=none; b=hZxwf+6+eEjpCl8L/j3LiBt1tc5lApbNlIjkA1pmHNT8RFnJgfch8a8wv/X+6BsAH21LeuUisURQmV+PgqoYPYwyrQBxctXm32y4N5iWwSuTl58JhitWjusfn6ND7ChotCV8ve75SY8XJUoiHAB0FzYVKeIOJh/ShXtQmbtcJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754337080; c=relaxed/simple;
	bh=6eE8FS7NWVhVrTdUgAGnI+aX2PndMrdCjYHv+IFAfLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/qEGvBStqaOOoSHGTCiBQ6jM2ZT4gy0oyqdffWrt5e/0dw2o2DEgawMVBLGcOKSP14p7ZD+7gy+HGD/Bdigu1gNChyBiWVFdaeFSfYxmjl8PFYGzjGgGgYZfk2V2pHJfsEagRbWD/gYesnZkR7k/wwXimlfqoMQtiypARMwdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=C2Zbtiq+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8fe55d4facso2432233276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754337077; x=1754941877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+KaFcIJVTV5oP2D+EEN+XDETRo8tiySW0snj8Arzlw=;
        b=C2Zbtiq+Wqp2ZMXH8gFQfcGd3TgH10lT2BUqWNQB0ucqZadFVxyFGnr5K6kdHpvzH5
         eQ3JrINnwd6s8cONtv18Y8GPnO8Hlo8PD1tCnClFPfYhOmDxmIlKh9hiNhACFMb0aU9P
         qKKNQhzieSDHM2szOs2mLfOlttuUQateUROFezBl42Kxrv7F8gihI6sTrzqPadZZtucH
         1YLvmmGNHCDhpZv6zV3hMJJz6upRFK+DUuS1cJjO1b97ZWyc8yPkwna9bssVa2kfsyY4
         /34wTzlPuZgVAOJkkm7VE3uZZKGZXllGmUu9L9+aoDJ+YjxNAiHL5DP0mtXxBOXbLkrD
         07NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754337077; x=1754941877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+KaFcIJVTV5oP2D+EEN+XDETRo8tiySW0snj8Arzlw=;
        b=c02w0rN6fVnLYBGrYKaHCpLTixwmHHPlxHagX29NcLX8GJX0t+mn+NMwXhwIGo1Bt4
         9HFuoz73Gqi4xQWN0c4Xm4WVufI4LLlAaQyggKArBje37l9JjugXyP23qGg/NO/AwfdV
         HMD6dZgbLCYR+REJmyovm9R5SA4g0L0V1G9tFoN6jMvYG8h/5Mx2tFcnPmTrFAJSenvS
         QpPFixs8pspJQZHG50aHbrN/teJJAOS3Vysad5eIwP3gwNb3MLVBp8L2f7xQJbEWP+u6
         glVSKmzTUpcMQcrCZ0W6B5x9Eqqzs2Tl6/8Cpex4bLuvqolXQts5xDMyjucNsxxFUmOS
         ZuCA==
X-Forwarded-Encrypted: i=1; AJvYcCWW9u3feZHbTymd5aT+2W/Os9qyG32UAF9ob30WrXgy9TAPFJ/6pw2Mh47JnE9ZjnBzL1iyUCoJqyFQBDse@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYIA01XbGFEhe7aqfwpnloX6tBFMa75dfrDpr//yMmdwXV1/B
	Z71Gvcq81uvelYQCY/qVkp4dVTsZ3rbkRoEfaXQ6FOjU8yr55ug05e2an/z93Iv7tsk=
X-Gm-Gg: ASbGncuLajcBJWlTUBDksYqzFI6XDJ/5ss2/TO25Bjk70p7HLthy5RpKHAjqLXl+C6x
	CDmDSIbaSltWdCjhyZiK8WKnkFc8ajgIKbwE5MHMQK4v6gbH3fsQBONtFbcLbiCGyUhwJPkLuDi
	yWSoaZm1NzDoOJgC+qpNt4AZUw0L5FGxVI2oYbNjVNyDqlJiGjuPXNMEtf5LfQV4cuAAN7Cnw4v
	KdV3n89XoCMIP70npEdmnCIn/TswZEFsmN+nGkJZU9RlGyZ4dJ88ns830jhNYSGzlVC5tGArXsY
	H1aobSJCYk4pZUVjg3PbDd6rTCL7k94rmCU2OOdQWCili1hpGPW4N5JX6Fc3ImVyjMiptF979ib
	MYJDqPhFBFyNxJkJ9WNVhctbaYbC9coo6
X-Google-Smtp-Source: AGHT+IHq4jMLWdGuyiCwYkfiW6N82VE4Tz6S+eqfymYZ4sLMIB8N1u2a9Mwt6WCpJ5WWgqxe+2qgDw==
X-Received: by 2002:a05:6902:1887:b0:e90:ff8:b0de with SMTP id 3f1490d57ef6-e900ff8b7famr2788045276.40.1754337076720;
        Mon, 04 Aug 2025 12:51:16 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:74a3:544f:3c0:465e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fdec64fa6sm3473376276.11.2025.08.04.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:51:16 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
Subject: [PATCH] hfsplus: fix KMSAN: uninit-value in hfsplus_lookup()
Date: Mon,  4 Aug 2025 12:50:58 -0700
Message-Id: <20250804195058.2327861-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If Catalog File contains corrupted record for the case of
hidden directory (particularly, entry.folder.id is lesser
than HFSPLUS_FIRSTUSER_CNID), then it can trigger the issue:

[   65.773760][ T9320] BUG: KMSAN: uninit-value in hfsplus_lookup+0xcd7/0x11f0
[   65.774362][ T9320]  hfsplus_lookup+0xcd7/0x11f0
[   65.774756][ T9320]  __lookup_slow+0x525/0x720
[   65.775160][ T9320]  lookup_slow+0x6a/0xd0
[   65.775513][ T9320]  walk_component+0x393/0x680
[   65.775896][ T9320]  path_lookupat+0x257/0x6c0
[   65.776313][ T9320]  filename_lookup+0x2ac/0x800
[   65.776693][ T9320]  user_path_at+0x8f/0x3c0
[   65.777078][ T9320]  __x64_sys_umount+0x146/0x250
[   65.777484][ T9320]  x64_sys_call+0x2806/0x3d90
[   65.777851][ T9320]  do_syscall_64+0xd9/0x1e0
[   65.778263][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.778716][ T9320]
[   65.778906][ T9320] Uninit was created at:
[   65.779294][ T9320]  __alloc_frozen_pages_noprof+0x714/0xe60
[   65.779750][ T9320]  alloc_pages_mpol+0x295/0x890
[   65.780148][ T9320]  alloc_frozen_pages_noprof+0xf8/0x1f0
[   65.780597][ T9320]  allocate_slab+0x216/0x1190
[   65.780961][ T9320]  ___slab_alloc+0x104c/0x33c0
[   65.781543][ T9320]  kmem_cache_alloc_lru_noprof+0x8f6/0xe70
[   65.782135][ T9320]  hfsplus_alloc_inode+0x5a/0xd0
[   65.782608][ T9320]  alloc_inode+0x82/0x490
[   65.783055][ T9320]  iget_locked+0x22e/0x1320
[   65.783495][ T9320]  hfsplus_iget+0xc9/0xd70
[   65.783944][ T9320]  hfsplus_btree_open+0x12b/0x1de0
[   65.784456][ T9320]  hfsplus_fill_super+0xc1c/0x27b0
[   65.784922][ T9320]  get_tree_bdev_flags+0x6e6/0x920
[   65.785403][ T9320]  get_tree_bdev+0x38/0x50
[   65.785819][ T9320]  hfsplus_get_tree+0x35/0x40
[   65.786275][ T9320]  vfs_get_tree+0xb3/0x5c0
[   65.786674][ T9320]  do_new_mount+0x73e/0x1630
[   65.787135][ T9320]  path_mount+0x6e3/0x1eb0
[   65.787564][ T9320]  __se_sys_mount+0x73a/0x830
[   65.787944][ T9320]  __x64_sys_mount+0xe4/0x150
[   65.788346][ T9320]  x64_sys_call+0x3904/0x3d90
[   65.788707][ T9320]  do_syscall_64+0xd9/0x1e0
[   65.789090][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.789557][ T9320]
[   65.789744][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro Not tainted 6.14.0-rc5 #5
[   65.790355][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.791197][ T9320] =====================================================
[   65.791814][ T9320] Disabling lock debugging due to kernel taint
[   65.792419][ T9320] Kernel panic - not syncing: kmsan.panic set ...
[   65.793000][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro Tainted: G    B              6.14.0-rc5 #5
[   65.793830][ T9320] Tainted: [B]=BAD_PAGE
[   65.794235][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.795211][ T9320] Call Trace:
[   65.795519][ T9320]  <TASK>
[   65.795797][ T9320]  dump_stack_lvl+0x1fd/0x2b0
[   65.796256][ T9320]  dump_stack+0x1e/0x25
[   65.796677][ T9320]  panic+0x505/0xca0
[   65.797112][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.797625][ T9320]  kmsan_report+0x299/0x2a0
[   65.798105][ T9320]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   65.798696][ T9320]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   65.799291][ T9320]  ? __msan_warning+0x96/0x120
[   65.799785][ T9320]  ? hfsplus_lookup+0xcd7/0x11f0
[   65.800294][ T9320]  ? __lookup_slow+0x525/0x720
[   65.800772][ T9320]  ? lookup_slow+0x6a/0xd0
[   65.801239][ T9320]  ? walk_component+0x393/0x680
[   65.801730][ T9320]  ? path_lookupat+0x257/0x6c0
[   65.802225][ T9320]  ? filename_lookup+0x2ac/0x800
[   65.802720][ T9320]  ? user_path_at+0x8f/0x3c0
[   65.803202][ T9320]  ? __x64_sys_umount+0x146/0x250
[   65.803683][ T9320]  ? x64_sys_call+0x2806/0x3d90
[   65.804177][ T9320]  ? do_syscall_64+0xd9/0x1e0
[   65.804634][ T9320]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.805251][ T9320]  ? kmsan_get_metadata+0x70/0x150
[   65.805764][ T9320]  ? vprintk_default+0x3f/0x50
[   65.806256][ T9320]  ? vprintk+0x36/0x50
[   65.806659][ T9320]  ? _printk+0x17e/0x1b0
[   65.807107][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.807621][ T9320]  __msan_warning+0x96/0x120
[   65.808103][ T9320]  hfsplus_lookup+0xcd7/0x11f0
[   65.808587][ T9320]  ? kmsan_get_metadata+0x70/0x150
[   65.809108][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.809627][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.810142][ T9320]  ? __pfx_hfsplus_lookup+0x10/0x10
[   65.810669][ T9320]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   65.811258][ T9320]  ? __pfx_hfsplus_lookup+0x10/0x10
[   65.811787][ T9320]  __lookup_slow+0x525/0x720
[   65.812258][ T9320]  lookup_slow+0x6a/0xd0
[   65.812700][ T9320]  walk_component+0x393/0x680
[   65.813178][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.813697][ T9320]  path_lookupat+0x257/0x6c0
[   65.814196][ T9320]  filename_lookup+0x2ac/0x800
[   65.814677][ T9320]  ? strncpy_from_user+0x255/0x470
[   65.815193][ T9320]  ? kmsan_get_metadata+0xf9/0x150
[   65.815706][ T9320]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   65.816290][ T9320]  ? __msan_metadata_ptr_for_load_8+0x24/0x40
[   65.816886][ T9320]  user_path_at+0x8f/0x3c0
[   65.817342][ T9320]  ? __x64_sys_umount+0x6d/0x250
[   65.817834][ T9320]  __x64_sys_umount+0x146/0x250
[   65.818333][ T9320]  ? kmsan_internal_set_shadow_origin+0x79/0x110
[   65.818945][ T9320]  x64_sys_call+0x2806/0x3d90
[   65.819420][ T9320]  do_syscall_64+0xd9/0x1e0
[   65.819876][ T9320]  ? irqentry_exit+0x16/0x60
[   65.820353][ T9320]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.820951][ T9320] RIP: 0033:0x7f822cb8fb07
[   65.821427][ T9320] Code: 23 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 08
[   65.823225][ T9320] RSP: 002b:00007fff4858f038 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
[   65.824037][ T9320] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f822cb8fb07
[   65.824818][ T9320] RDX: 0000000000000009 RSI: 0000000000000009 RDI: 00007fff4858f0e0
[   65.825568][ T9320] RBP: 00007fff48590120 R08: 00007f822cc23040 R09: 00007fff4858eed0
[   65.826329][ T9320] R10: 00007f822cc22fc0 R11: 0000000000000202 R12: 000055bd891e22d0
[   65.827086][ T9320] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   65.827850][ T9320]  </TASK>
[   65.828677][ T9320] Kernel Offset: disabled
[   65.829095][ T9320] Rebooting in 86400 seconds..

It means that if hfsplus_iget() receives inode ID lesser than
HFSPLUS_FIRSTUSER_CNID, then it treats it as system inode and
hfsplus_system_read_inode() will be called. As result,
struct hfsplus_inode_info is not initialized properly for
the case of hidden directory. The hidden directory is the record of
Catalog File and hfsplus_cat_read_inode() should be called
for the proper initalization of hidden directory's inode.

This patch adds checking of entry.folder.id for the case of
hidden directory in hfsplus_fill_super(). The CNID of hidden folder
cannot be lesser than HFSPLUS_FIRSTUSER_CNID. And if we receive
such invalid CNID, then record is corrupted and hfsplus_fill_super()
returns the EIO error. Also, patch adds invalid CNID declaration and
declarations of another reserved CNIDs.

Reported-by: syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/hfsplus_raw.h | 7 +++++++
 fs/hfsplus/super.c       | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 68b4240c6191..bdd4deab46c6 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -194,6 +194,7 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
 
 /* Some special File ID numbers (stolen from hfs.h) */
+#define HFSPLUS_INVALID_CNID		0	/* Invalid id */
 #define HFSPLUS_POR_CNID		1	/* Parent Of the Root */
 #define HFSPLUS_ROOT_CNID		2	/* ROOT directory */
 #define HFSPLUS_EXT_CNID		3	/* EXTents B-tree */
@@ -202,6 +203,12 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_ALLOC_CNID		6	/* ALLOCation file */
 #define HFSPLUS_START_CNID		7	/* STARTup file */
 #define HFSPLUS_ATTR_CNID		8	/* ATTRibutes file */
+#define HFSPLUS_RESERVED_CNID_9		9
+#define HFSPLUS_RESERVED_CNID_10	10
+#define HFSPLUS_RESERVED_CNID_11	11
+#define HFSPLUS_RESERVED_CNID_12	12
+#define HFSPLUS_RESERVED_CNID_13	13
+#define HFSPLUS_REPAIR_CAT_CNID		14	/* Repair CATalog File id */
 #define HFSPLUS_EXCH_CNID		15	/* ExchangeFiles temp id */
 #define HFSPLUS_FIRSTUSER_CNID		16	/* first available user id */
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc8985..8f2790a78e08 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -527,6 +527,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			err = -EINVAL;
 			goto out_put_root;
 		}
+		if (be32_to_cpu(entry.folder.id) < HFSPLUS_FIRSTUSER_CNID) {
+			err = -EIO;
+			goto out_put_root;
+		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
-- 
2.43.0


