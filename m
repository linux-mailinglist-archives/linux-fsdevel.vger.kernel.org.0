Return-Path: <linux-fsdevel+bounces-58414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E1B2E874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29FA1C881A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293092C21EA;
	Wed, 20 Aug 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Ik9mJkFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B636CE0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731233; cv=none; b=qxNaNMudk7ZRAEARfAUIercrZuW1k0DV+KzXmHb7FzTMLuEdc5umJI2ii39+YQHrtm+WfWPnxqkxSrKRmrRD7hSO7RZWfSAWPkEhSsKYGtpQKNWL3xV3Bq1NnW0ceT83v5Fpirpe3/odCE6Nha0NTvki7ItRzAynWnC/CwSml64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731233; c=relaxed/simple;
	bh=eu4K9BPfPMpWajlPHDxKCtKJIFb8MMTnD8A9Uf5ojgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HoovN1h4w6gPgVUXDAN78oBYKXUzUFssHV2pMBbdJEk55iOVMKm7H3oTPrXnQArmDuSE3hnEYjvcNcFSXpwjQ9H4kP8CuXF3+eiRJ5o1kpZVhKYJp+smVyWPQhq+e3mfN4Hss6lMmKo0kIhkQSLcSvf/7M3wblNjh+wtGXJkVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Ik9mJkFv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95026b33eeso591341276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1755731230; x=1756336030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJMnwFAoUK8fi5vLuEhOZdeebfJBc6a5q8PCtng4nG4=;
        b=Ik9mJkFvY7sIg/lizwHy8L/N+ibS6cykvxlcbwKgTd/eLiH4ixDEfGc2BgbAYZLjCb
         xN5LmPRNqkWjbkIC+7q1Kq74DozW9OqPngRTtkxHA9auHhHOgcGneJlDQDEvbVQ3/eEf
         4YuEPsbxepJl3MNS1sWF5DrpoIKcv1kf4fXUdbxojYS8x7jpf8SnAdWOpZ3tCD1vYFJ9
         wXD+8wyw/6apQRow3zmabpWDCdtf/JUX+wAN+jb1B8Ur6sal0PrgLRsTpNahFhY7sk/d
         C4K4fEJHxhaK5DXvy0pQPnT+/H3ZGpBTFbR+wpKSZ091VbJkAwO9OzNbhbKqvn/YaBMW
         S8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731230; x=1756336030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJMnwFAoUK8fi5vLuEhOZdeebfJBc6a5q8PCtng4nG4=;
        b=LTMBify68xrlDvr6J3hotgEwcg8QEpafFLaUV4dtQoy4a43rwwB9Rowe2Blc42AO1S
         5igoWOgwuzQSmlm+B9TcNRJdJ7dAztEdDP9AJ8gOGpfzuLjXqDYJs4ZEbiL2MoYrsGns
         33o2ijIPukp8a9oeyyke2upKI38EJggi3Adl34cCJu4XoMelFhgz6YCZQUa7NXBBrN/D
         pO0JozAMw8Zk+sZGelvvwqVjFLe0uDlEy3s+X40fsJ4VVbhZyLHumP9aVgS3EGygZ4pG
         hRyi6s1cRoE1VwNz/tRlxQgRrQuXEOZoFOZoJeq8xn7z6jWnoRBwmUjZ0XIEnyE6mUPN
         WK9A==
X-Forwarded-Encrypted: i=1; AJvYcCUrBQinUy2b15RRRDR1Dsukz1Bez8EW7XYMia4O1MPJ0J6JxNzvSdx0ZY+WqeMao7Fm82Ju9wa4/dRi2csu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9q75bS2IW51/nIzs3S/qHBlUkdysOxQXsviD6kiNEEI0KBN+
	bkqdNo/QpmRp7DxmOzpmN314VzyP9KQbRDmuMwI1dMZuKEPI4ytVhpiV4XxJZFgO/9s=
X-Gm-Gg: ASbGnct/1PsV3I0/lD7/zz7EUaUIu42w7+LatrkUFcYsPIj4VShPsUEy/bc+T4IhQ99
	t1cwvqNo4e6Z7Z+NWi/KJM4ZRHdFKArNJAJAbOMaxagRVCtkPG16h0viU1K2s56xobhrxTx4NG0
	VnNLqtFfn3nczbaRafoTkbDqxhzA08e7kEoJqrkNBvda2sPu6zL1eEx3Jbxt2C0Mg6B7pf6gHO+
	tjFGz3+yh04a1NQRTU8kGi95OodFQ4oXMlpGRRs5ZAlBE+ATBlhH7BIpVLfHKLafIyREJz2rIp6
	NxKOu/Jo5On8eKd3xSmyzI3zGECjqQTWe4M9V5lhlVOMSaUYw9Ugr4cQrwbmPFsyAMcB0bYbxBD
	gt0dx3Ybtfxs56F/DNuTQS8vRQw6rGK+l
X-Google-Smtp-Source: AGHT+IG0jBZc/J7E8q0mResKxUfwGEs7jeUVT2UU93RV5mF42S7fBH5jNA5STWCCDsA/oJI4lo9ttA==
X-Received: by 2002:a05:690c:708d:b0:71f:9a36:d333 with SMTP id 00721157ae682-71fc9f6aa89mr3378207b3.22.1755731229770;
        Wed, 20 Aug 2025 16:07:09 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:3803:c8a:daa8:762e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0c1a39sm39966747b3.67.2025.08.20.16.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:07:09 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot <syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com>
Subject: [PATCH] hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()
Date: Wed, 20 Aug 2025 16:06:38 -0700
Message-Id: <20250820230636.179085-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reported issue in hfs_find_set_zero_bits():

=====================================================
BUG: KMSAN: uninit-value in hfs_find_set_zero_bits+0x74d/0xb60 fs/hfs/bitmap.c:45
 hfs_find_set_zero_bits+0x74d/0xb60 fs/hfs/bitmap.c:45
 hfs_vbm_search_free+0x13c/0x5b0 fs/hfs/bitmap.c:151
 hfs_extend_file+0x6a5/0x1b00 fs/hfs/extent.c:408
 hfs_get_block+0x435/0x1150 fs/hfs/extent.c:353
 __block_write_begin_int+0xa76/0x3030 fs/buffer.c:2151
 block_write_begin fs/buffer.c:2262 [inline]
 cont_write_begin+0x10e1/0x1bc0 fs/buffer.c:2601
 hfs_write_begin+0x85/0x130 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2528 [inline]
 cont_write_begin+0x35a/0x1bc0 fs/buffer.c:2591
 hfs_write_begin+0x85/0x130 fs/hfs/inode.c:52
 hfs_file_truncate+0x1d6/0xe60 fs/hfs/extent.c:494
 hfs_inode_setattr+0x964/0xaa0 fs/hfs/inode.c:654
 notify_change+0x1993/0x1aa0 fs/attr.c:552
 do_truncate+0x28f/0x310 fs/open.c:68
 do_ftruncate+0x698/0x730 fs/open.c:195
 do_sys_ftruncate fs/open.c:210 [inline]
 __do_sys_ftruncate fs/open.c:215 [inline]
 __se_sys_ftruncate fs/open.c:213 [inline]
 __x64_sys_ftruncate+0x11b/0x250 fs/open.c:213
 x64_sys_call+0xfe3/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:78
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __kmalloc_cache_noprof+0x7f7/0xed0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 hfs_mdb_get+0x1cc8/0x2a90 fs/hfs/mdb.c:175
 hfs_fill_super+0x3d0/0xb80 fs/hfs/super.c:337
 get_tree_bdev_flags+0x6e3/0x920 fs/super.c:1681
 get_tree_bdev+0x38/0x50 fs/super.c:1704
 hfs_get_tree+0x35/0x40 fs/hfs/super.c:388
 vfs_get_tree+0xb0/0x5c0 fs/super.c:1804
 do_new_mount+0x738/0x1610 fs/namespace.c:3902
 path_mount+0x6db/0x1e90 fs/namespace.c:4226
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x6eb/0x7d0 fs/namespace.c:4427
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4427
 x64_sys_call+0xfa7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 12609 Comm: syz.1.2692 Not tainted 6.16.0-syzkaller #0 PREEMPT(none)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================

The HFS_SB(sb)->bitmap buffer is allocated in hfs_mdb_get():

HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);

Finally, it can trigger the reported issue because kmalloc()
doesn't clear the allocated memory. If allocated memory contains
only zeros, then everything will work pretty fine.
But if the allocated memory contains the "garbage", then
it can affect the bitmap operations and it triggers
the reported issue.

This patch simply exchanges the kmalloc() on kzalloc()
with the goal to guarantee the correctness of bitmap operations.
Because, newly created allocation bitmap should have all
available blocks free. Potentially, initialization bitmap's read
operation could not fill the whole allocated memory and
"garbage" in the not initialized memory will be the reason of
volume coruptions and file system driver bugs.

Reported-by: syzbot <syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127c..bf811347bb07 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -172,7 +172,7 @@ int hfs_mdb_get(struct super_block *sb)
 		pr_warn("continuing without an alternate MDB\n");
 	}
 
-	HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);
+	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
 		goto out;
 
-- 
2.43.0


