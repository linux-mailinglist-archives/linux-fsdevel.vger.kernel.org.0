Return-Path: <linux-fsdevel+bounces-42875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D805A4A858
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 04:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF767AA245
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9A91AF0BC;
	Sat,  1 Mar 2025 03:40:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779E2CA8
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740800434; cv=none; b=IzRlOE2EyDusQyrXUU0yMiszeW6OiifAl6mC7mlPo51P2naOSLNFEHFSNv4rdfEZXfb3Z76x191QBRzl1s5vMphTXs8iu/J+9PnB+VQXLilJriwe1DUFv+Pw5Ee7CB+l3I3nUXbbwiqirMs8tMbzrGEBv6D2bmksWUygE26tPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740800434; c=relaxed/simple;
	bh=42Ea0BricQ9UP33t0fvdgIhpj12r35qnLiRudvtPWmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YHaJJ7drpkAKdgPy5oFzQPmOKdmspexXmjOX2xxogTIzLHto7F59ouivIYoX1YVDHMlfTNfrpNXpH6iEGACGHABOUMEmL00C13CnSSeF+kXDYao7tG/RY3y/sNJDtzEY/bB9HQcs3DU1MwPRh0PGctlVa6UyVivbG5XTmZOAgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z4W6r3Z0Xz4f3kns
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 11:40:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 729241A092F
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 11:40:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+ogcJnsHDPFA--.63778S4;
	Sat, 01 Mar 2025 11:40:26 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: akpm@linux-foundation.org,
	rick.p.edgecombe@intel.com,
	ast@kernel.org,
	adobriyan@gmail.com,
	kirill.shutemov@linux.intel.com,
	linux-fsdevel@vger.kernel.org
Cc: yebin10@huawei.com
Subject: [PATCH] proc: fix use-after-free in proc_get_inode()
Date: Sat,  1 Mar 2025 11:40:24 +0800
Message-Id: <20250301034024.277290-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+ogcJnsHDPFA--.63778S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF43ZFyxZr4ftr48XryrJFb_yoW5Ar43pF
	W7tryUCr4kurn8CF18JF1UCr1jga1j9F47Jrs7Zr17AF15G340qF1rAF4ayryDJr4rX34S
	qF4Dt39avry5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's a issue as follows:
BUG: unable to handle page fault for address: fffffbfff80a702b
PGD 817fc4067 P4D 817fc4067 PUD 817fc0067 PMD 102ef4067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 26 UID: 0 PID: 2667 Comm: ls Tainted: G
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:proc_get_inode+0x302/0x6e0
RSP: 0018:ffff88811c837998 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffffc0538140 RCX: 0000000000000007
RDX: 1ffffffff80a702b RSI: 0000000000000001 RDI: ffffffffc0538158
RBP: ffff8881299a6000 R08: 0000000067bbe1e5 R09: 1ffff11023906f20
R10: ffffffffb560ca07 R11: ffffffffb2b43a58 R12: ffff888105bb78f0
R13: ffff888100518048 R14: ffff8881299a6004 R15: 0000000000000001
FS:  00007f95b9686840(0000) GS:ffff8883af100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff80a702b CR3: 0000000117dd2000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_lookup_de+0x11f/0x2e0
 __lookup_slow+0x188/0x350
 walk_component+0x2ab/0x4f0
 path_lookupat+0x120/0x660
 filename_lookup+0x1ce/0x560
 vfs_statx+0xac/0x150
 __do_sys_newstat+0x96/0x110
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Above issue may happen as follows:
      rmmod                         lookup
sys_delete_module
                         proc_lookup_de
                           read_lock(&proc_subdir_lock);
			   pde_get(de);
			   read_unlock(&proc_subdir_lock);
			   proc_get_inode(dir->i_sb, de);
  mod->exit()
    proc_remove
      remove_proc_subtree
       write_lock(&proc_subdir_lock);
       write_unlock(&proc_subdir_lock);
       proc_entry_rundown(de);
  free_module(mod);

                               if (S_ISREG(inode->i_mode))
	                         if (de->proc_ops->proc_read_iter)
                           --> As module is already freed, will trigger UAF

To solve above issue there's need to get 'in_use' before use proc_dir_entry
in proc_get_inode().

Fixes: fd5a13f4893c ("proc: add a read_iter method to proc proc_ops")
Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/proc/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 626ad7bd94f2..decfb3d9a632 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -644,6 +644,11 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		return inode;
 	}
 
+	if (!pde_is_permanent(de) && !use_pde(de)) {
+		pde_put(de);
+		return NULL;
+	}
+
 	if (de->mode) {
 		inode->i_mode = de->mode;
 		inode->i_uid = de->uid;
@@ -677,5 +682,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 	} else {
 		BUG();
 	}
+
+	if (!pde_is_permanent(de))
+		unuse_pde(de);
+
 	return inode;
 }
-- 
2.34.1


