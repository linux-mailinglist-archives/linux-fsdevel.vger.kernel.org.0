Return-Path: <linux-fsdevel+bounces-27089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4395E81F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9039B1F217B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E078297;
	Mon, 26 Aug 2024 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hXABBc2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258EB677;
	Mon, 26 Aug 2024 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651795; cv=none; b=SS+WyzSU9N2VBMrs8Y07mJEt68oryDOeFbARfGlQI0t8fP6nRoANSwVq6KYO3cxaOnR/+5yHOrXncobEJ/F8loqLuoWPMrKT+GsTwuH5UOVvHhOybFGqtdxRPUaE/HT2QhPmOpfF2ANfpcPi1dLBI6HE8pQnn3OCZGmfONcLmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651795; c=relaxed/simple;
	bh=5elzC00/kBs9eXIAOOM5M8qCnN0ZSMCWTIAh+lRMU6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCb34g95rDvW+tncXrJzDBNuYWWtH/bvtxDB5zkm0TEhWoR8Xvwu3zdIeOMUmkLGW2z8LRSrTC2A58KMzY5nJj5W1ksZW8PGe6A+C/JXjwgAthFu7WuHWTHGOFuHOSMgu7y3a92cvL7xVnLTUDuXsvatoA9/GBjPLwD5YZvUUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hXABBc2N; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1724651792; x=1756187792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5elzC00/kBs9eXIAOOM5M8qCnN0ZSMCWTIAh+lRMU6M=;
  b=hXABBc2Nc1mzv7wfan3/wvcZqM+AvRDK9nCCLM9b5RFxEj3c/C4cwTuH
   yoIygypLyGpFPYn9DSe5mWgvTKBaexuZMkkwmNNwr6XUjjg9WvEqyKfsJ
   Crnqz7fm6psqPwaJD98iwa4G4Z3gmEq3H5OWtpn0jWA1tiRbClIqu/XVU
   ctwO7fqaHK4JPP1MIPzExvuGl4dSp5z2AXo1y84s6r1BaweKPWsl2g8oB
   mTLWRStO18jzky8BdJ0oHQfak+lr7Bawg8pKrNUP8tt250si/Pp5iTJ4y
   ZhX8j3SwH+Rl8EekvidgSpiFM9Td16zcl0pigR/k0bHtGsxLLiFMYnKHO
   w==;
X-CSE-ConnectionGUID: JYaP96nuQ+SSu7Xn7XgrYw==
X-CSE-MsgGUID: F8JNJrZARkGJz+31cgviVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="171597301"
X-IronPort-AV: E=Sophos;i="6.10,176,1719846000"; 
   d="scan'208";a="171597301"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:55:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 159F2D800F;
	Mon, 26 Aug 2024 14:55:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4FD73D774F;
	Mon, 26 Aug 2024 14:55:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C17E72007AA9A;
	Mon, 26 Aug 2024 14:55:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id DD40B1A000B;
	Mon, 26 Aug 2024 13:55:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Mon, 26 Aug 2024 13:55:03 +0800
Message-Id: <20240826055503.1522320-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28620.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28620.005
X-TMASE-Result: 10--13.559800-10.000000
X-TMASE-MatchedRID: GSiycdxM5vtbit9mT6uGeH4iswX+GH/YMVx/3ZYby7/TL2GRHAc9cYre
	5xUTEbm3PhG3C4bJ9ud4W1pIycz0ojMgY9HFnYXeWFHKJ2wSViRqPM1MUyVAI8Y/bS1zXTHAB2R
	dQAZSzdBfrgqNHWErOssSTjDnjl5d/6VeF+1cPSvwlvzzUUaf2Vvh1cEykiSGYD4HoIFcAhbr5/
	zvfXByhaq3s2gpsjK10S+10ZS8XXYqr12s6iu4vEhwlOfYeSqxlDt5PQMgj00szGQ0fro1hOs1X
	iKPajyAnC7F+qVaTtqHbDioRPJc9CL4kdme+P63TuctSpiuWyU2ZWOmuJUS2R0zI+Wuf+4mUdvJ
	i65mrYugGWyVYSar+kdklyK6qs5Jr78SC5iivxwURSScn+QSXq0hbOeGOMG1+gtHj7OwNO3Ix3I
	cp6zuWwkHZGlhRAFby5yDtjIzLoCPm75F8q0WIenI14gCfR2M
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It's observed that a crash occurs during hot-remove a memory device,
in which user is accessing the hugetlb. See calltrace as following:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14045 at arch/x86/mm/fault.c:1278 do_user_addr_fault+0x2a0/0x790
Modules linked in: kmem device_dax cxl_mem cxl_pmem cxl_port cxl_pci dax_hmem dax_pmem nd_pmem cxl_acpi nd_btt cxl_core crc32c_intel nvme virtiofs fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc s
mirror dm_region_hash dm_log dm_mod
CPU: 1 PID: 14045 Comm: daxctl Not tainted 6.10.0-rc2-lizhijian+ #492
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:do_user_addr_fault+0x2a0/0x790
Code: 48 8b 00 a8 04 0f 84 b5 fe ff ff e9 1c ff ff ff 4c 89 e9 4c 89 e2 be 01 00 00 00 bf 02 00 00 00 e8 b5 ef 24 00 e9 42 fe ff ff <0f> 0b 48 83 c4 08 4c 89 ea 48 89 ee 4c 89 e7 5b 5d 41 5c 41 5d 41
RSP: 0000:ffffc90000a575f0 EFLAGS: 00010046
RAX: ffff88800c303600 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000001000 RSI: ffffffff82504162 RDI: ffffffff824b2c36
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a57658
R13: 0000000000001000 R14: ffff88800bc2e040 R15: 0000000000000000
FS:  00007f51cb57d880(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001000 CR3: 00000000072e2004 CR4: 00000000001706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn+0x8d/0x190
 ? do_user_addr_fault+0x2a0/0x790
 ? report_bug+0x1c3/0x1d0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? do_user_addr_fault+0x2a0/0x790
 ? exc_page_fault+0x31/0x200
 exc_page_fault+0x68/0x200
<...snip...>
BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 ---[ end trace 0000000000000000 ]---
 BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 14045 Comm: daxctl Kdump: loaded Tainted: G        W          6.10.0-rc2-lizhijian+ #492
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 RIP: 0010:dentry_name+0x1f4/0x440
<...snip...>
? dentry_name+0x2fa/0x440
vsnprintf+0x1f3/0x4f0
vprintk_store+0x23a/0x540
vprintk_emit+0x6d/0x330
_printk+0x58/0x80
dump_mapping+0x10b/0x1a0
? __pfx_free_object_rcu+0x10/0x10
__dump_page+0x26b/0x3e0
? vprintk_emit+0xe0/0x330
? _printk+0x58/0x80
? dump_page+0x17/0x50
dump_page+0x17/0x50
do_migrate_range+0x2f7/0x7f0
? do_migrate_range+0x42/0x7f0
? offline_pages+0x2f4/0x8c0
offline_pages+0x60a/0x8c0
memory_subsys_offline+0x9f/0x1c0
? lockdep_hardirqs_on+0x77/0x100
? _raw_spin_unlock_irqrestore+0x38/0x60
device_offline+0xe3/0x110
state_store+0x6e/0xc0
kernfs_fop_write_iter+0x143/0x200
vfs_write+0x39f/0x560
ksys_write+0x65/0xf0
do_syscall_64+0x62/0x130

Previously, some sanity check have been done in dump_mapping() before
the print facility parsing '%pd' though, it's still possible to run into
an invalid dentry.d_name.name.

Since dump_mapping() only needs to dump the filename only, retrieve it
by itself in a safer way to prevent an unnecessary crash.

Note that either retrieving the filename with '%pd' or
strncpy_from_kernel_nofault(), the filename could be unreliable.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 fs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..d3f9d73d59d0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -562,6 +562,7 @@ void dump_mapping(const struct address_space *mapping)
 	struct hlist_node *dentry_first;
 	struct dentry *dentry_ptr;
 	struct dentry dentry;
+	char fname[64] = {};
 	unsigned long ino;
 
 	/*
@@ -598,11 +599,14 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
+	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
+		strscpy(fname, "<invalid>");
 	/*
-	 * if dentry is corrupted, the %pd handler may still crash,
-	 * but it's unlikely that we reach here with a corrupt mapping
+	 * Even if strncpy_from_kernel_nofault() succeeded,
+	 * the fname could be unreliable
 	 */
-	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
+	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
+		a_ops, ino, fname);
 }
 
 void clear_inode(struct inode *inode)
-- 
2.29.2


