Return-Path: <linux-fsdevel+bounces-45719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFAA7B768
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2674189D2A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731371632E6;
	Fri,  4 Apr 2025 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lEjdKZB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939DDDC1;
	Fri,  4 Apr 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745066; cv=none; b=R2FbgTYmo4rvS9lehGKP1ka46f2KtyCUDNVfHBwUtAVmngA370XYRAvH0tbCbDZEIqPOHncP3bGx+1wtIcC0u4V/288EBzNZoI2Any6PBO9vyWLI6XMccdtKfVC/9nhCWjKoLXST6kBm+cSnC0bATH1ZGZVgriu1EVk6rdJsyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745066; c=relaxed/simple;
	bh=v2K3Ci6Hqa/XaBgTwF7fn5YXxKcOQtRT8RTrXCQP4Cw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EwzXoj9dnjyP0Wst/vAntHYGtGeHusAnW8uXdwSN1hoEHbWTQttgOeWsG2pp4xOsfnGka3vt0VoeoPNMTmsZV1KiquKDuwyM3HAgKBn3ocUICrMQBuH2E/lok0kjYyET7wdEHLkqb3Zt8YPtNmy2fqft5oMuG5P/ep0BTcUNdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lEjdKZB1; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743745056; bh=wrSj9PzWh2wVzoWv3XkhoWrvov00Rs2DfdHlLI0RZ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEjdKZB11l3Mx7QWXWEFV84QBrUlzgPRk6ngIRu/ZAnVTJquac7Wkfm5D491TaPC4
	 bMf/5SqLd1BDuqpSjET/W8CCl0gNiUSeLW5z3EtSNxKSqWrcZ3ethUP1F+DnbvI+sH
	 u5EU9aCuwEoI7toUPi1maCZQT/t5eK8pDhuXAnpE=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 7DCAA611; Fri, 04 Apr 2025 13:31:28 +0800
X-QQ-mid: xmsmtpt1743744688tomd71bwx
Message-ID: <tencent_9C8CB8A7E7C6C512C7065DC98B6EDF6EC606@qq.com>
X-QQ-XMAILINFO: MiwL2wmyONS9vtXwWrRJ1j3yBQKHJJvDrdoSgeiSARMKVgikB3klDMnagz4rab
	 9Utwb0i2hGs0PnYpOh9ZFzfaYTj3VtD7g9zoPHIcamlzaHFIEjxD6wRx+NSMVsGsVg9bcHYxDSQv
	 gfUrXQRo/fncdt5xei+d8uML0vouOHMFLSaLIc35lbwzV9Hjd/66riDveY0t3H4ZhIuyyjXHLkMF
	 csUVT2Gijz/AY9rdDSfOGBhagWpPKFur8RVz58G/3NszzY3IwjoVS7yq7YdWRXsmd2mS+7DKK35N
	 QvmyjmZt3hkEedNUKLL9fYgOX+x6mGhjHHVfNCxi0c6NCMtjQCGOBnodHhQ/eWh7YQNW6IwxetZj
	 ZeCDmEn1PEnbNZZPNswUfYeccI4yS0hlvwuSkeuzPTp7oDEFbrV4H4rax7VY5JBKNVoGcmCEWwu3
	 msKkRd2dK5xn8UXPhmixWJJ0oVmzz2pDk0sIPdeV4+ECYJj7ja8WdjJsmFaC8/kSYakQ+SRuZx50
	 bp+mARe0uVOSdvs7fUNiSNvykVRHHu5Mqoi9MnfTsDKi3ANucO1+R5G1bgrg8qBNQIpEKcUBVuS9
	 CVLYdpUn4pCXga/eUPN7BcM9s4oZ6vnZB4fhNZjTAvyGVmBh2kFLOXa9TsrbFhuYmlYvDXu97N26
	 zRmEXgYrxqUb+25rilvfaFGW9Nhm7pARKbD4qun8dY8cQyJm3BX7mRgd11kd4zzRA3F7W6TOCa9J
	 AV6A16ctJd+DGWKNBa3XRjgHFxFMmwneUk4TYfQviThywESBxluedaAj9zI+7Nz+I/EqgszIiJkp
	 N5owYYKYYqqURgndfLBioxVvA8LuEg1ZeP/qMxl3fL68/8x5BnHL9a9vjNZVruf9XudNQNWOb4hW
	 BgrLSM3fCY/mA05dodmlt7JIuPTuzOKZfk10/7gyOxEYf+8alYur9kIZNW6GU8IlM1R+bFsc41
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] isofs: Prevent the use of too small fid
Date: Fri,  4 Apr 2025 13:31:29 +0800
X-OQ-MSGID: <20250404053128.2801269-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67eee51c.050a0220.9040b.0240.GAE@google.com>
References: <67eee51c.050a0220.9040b.0240.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a slab-out-of-bounds Read in isofs_fh_to_parent. [1]

The handle_bytes value passed in by the reproducing program is equal to 12.
In handle_to_path(), only 12 bytes of memory are allocated for the structure
file_handle->f_handle member, which causes an out-of-bounds access when
accessing the member parent_block of the structure isofs_fid in isofs,
because accessing parent_block requires at least 16 bytes of f_handle.
Here, fh_len is used to indirectly confirm that the value of handle_bytes
is greater than 3 before accessing parent_block.

[1]
BUG: KASAN: slab-out-of-bounds in isofs_fh_to_parent+0x1b8/0x210 fs/isofs/export.c:183
Read of size 4 at addr ffff0000cc030d94 by task syz-executor215/6466
CPU: 1 UID: 0 PID: 6466 Comm: syz-executor215 Not tainted 6.14.0-rc7-syzkaller-ga2392f333575 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x198/0x550 mm/kasan/report.c:521
 kasan_report+0xd8/0x138 mm/kasan/report.c:634
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 isofs_fh_to_parent+0x1b8/0x210 fs/isofs/export.c:183
 exportfs_decode_fh_raw+0x2dc/0x608 fs/exportfs/expfs.c:523
 do_handle_to_path+0xa0/0x198 fs/fhandle.c:257
 handle_to_path fs/fhandle.c:385 [inline]
 do_handle_open+0x8cc/0xb8c fs/fhandle.c:403
 __do_sys_open_by_handle_at fs/fhandle.c:443 [inline]
 __se_sys_open_by_handle_at fs/fhandle.c:434 [inline]
 __arm64_sys_open_by_handle_at+0x80/0x94 fs/fhandle.c:434
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 6466:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_noprof+0x32c/0x54c mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 handle_to_path fs/fhandle.c:357 [inline]
 do_handle_open+0x5a4/0xb8c fs/fhandle.c:403
 __do_sys_open_by_handle_at fs/fhandle.c:443 [inline]
 __se_sys_open_by_handle_at fs/fhandle.c:434 [inline]
 __arm64_sys_open_by_handle_at+0x80/0x94 fs/fhandle.c:434
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Reported-by: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4d7cd7dd0ce1aa8d5c65
Tested-by: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/isofs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..421d247fae52 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -180,7 +180,7 @@ static struct dentry *isofs_fh_to_parent(struct super_block *sb,
 		return NULL;
 
 	return isofs_export_iget(sb,
-			fh_len > 2 ? ifid->parent_block : 0,
+			fh_len > 3 ? ifid->parent_block : 0,
 			ifid->parent_offset,
 			fh_len > 4 ? ifid->parent_generation : 0);
 }
-- 
2.43.0


