Return-Path: <linux-fsdevel+bounces-15817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D1893849
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 08:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6244281969
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62DE8F7A;
	Mon,  1 Apr 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="FHoaR+dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71782595;
	Mon,  1 Apr 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952198; cv=none; b=J1tuXCYZupSM3VdR7MiFNpLS3PaWSRUGRM/6OMdVqt9aWu1TP4sNEzhlmS1ePn+vnguJgViQtlBFKjpSfdu3UrpUpvyliIckzfnz8IPNtBgnpF1c5hbpi00+U5akWqy3DI6ISgeqe69fVfJVdK5oadlqF7/WSJBOqDR0S0tu35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952198; c=relaxed/simple;
	bh=Gf16/3ATwW5ymrwfxNotUxyAiehv1Nj7wPTQDzI+o1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6NNIoQdHL5kDf4rYEbprYhZOZroZ6gf1mvRW70m5HIhWvmGShgDU49XDPpUDxCNrCJfDiwFLbi+4qW8Aid9Qu7ZX4gp4eAM6dl6gWH1BbCG+EVVwbENCCBoWsdGkxqdFcRaaMOTRRWX2B9FYCH12jEIxcGk4+Xb0CKvYWyPYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=FHoaR+dr; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4314icou027716;
	Sun, 31 Mar 2024 23:16:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=b94hqPNHzJ06xjr7BdMuOoe9TJRdHoixRFvvRcdazSY=; b=
	FHoaR+drR9DxOd9KlI3Fm61PX0vt2htMGp3sC33+cd3bOC2vkt4V/z9Se3c3ljqx
	Zf5sMa216+TUFCcKDm4KUiwU8KgLOg8ZFj55lxbRZOJDz2sAbwfVgUTFPFW22zNf
	kcrkTfwoLUTo9FUkCme8gUqokOktRj4KGl2vMaMbnUCY4YMKct71jXfHXwePtP0z
	wZzwgSa3S7qQ9zVNuO7HKDLA1YjLLcB27gO4k3a+BQEiDNbKXxBPf0WvH9W86rrL
	YRu1k9Cb+RtivWJEN6VLkjAFdEgBLtpIgaeBjkpMxQoUZCyDfwDM25kY7yclw2jL
	Vbu1j2WVrkVb0ZKKsTxYOQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10heu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 31 Mar 2024 23:16:26 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 23:16:26 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Sun, 31 Mar 2024 23:16:24 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] fs/hfsplus: fix in hfsplus_read_wrapper
Date: Mon, 1 Apr 2024 14:16:19 +0800
Message-ID: <20240401061619.2995409-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001126200614f5c9c4@google.com>
References: <0000000000001126200614f5c9c4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SltEFJFXiS2Dxwb9z7AU2VZ-n3NLmiIA
X-Proofpoint-GUID: SltEFJFXiS2Dxwb9z7AU2VZ-n3NLmiIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_03,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010044

[Syzbot reported]
BUG: KASAN: slab-use-after-free in hfsplus_read_wrapper+0xf86/0x1070 fs/hfsplus/wrapper.c:226
Read of size 2 at addr ffff888024fba400 by task syz-executor204/5218

CPU: 1 PID: 5218 Comm: syz-executor204 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hfsplus_read_wrapper+0xf86/0x1070 fs/hfsplus/wrapper.c:226
 hfsplus_fill_super+0x352/0x1bc0 fs/hfsplus/super.c:419
 mount_bdev+0x1e6/0x2d0 fs/super.c:1658
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
 vfs_get_tree+0x92/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f706ca0c69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd3a1c1c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f706ca0c69a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcd3a1c210
RBP: 0000000000000004 R08: 00007ffcd3a1c250 R09: 0000000000000632
R10: 0000000000000050 R11: 0000000000000286 R12: 00007ffcd3a1c210
R13: 00007ffcd3a1c250 R14: 0000000000080000 R15: 0000000000000003
 </TASK>
[Fix] 
When the logical_block_size was changed from 512 to 2048, it resulted in 
insufficient space pre allocated to s_backup_vhdr_buf. To solve this problem, 
move the memory allocation of s_backup_vhdr_buf to after the logical_block_size
has been changed.

Reported-and-tested-by: syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/hfsplus/wrapper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index ce9346099c72..974786e30259 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -179,16 +179,13 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	sbi->s_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
 	if (!sbi->s_vhdr_buf)
 		goto out;
-	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
-	if (!sbi->s_backup_vhdr_buf)
-		goto out_free_vhdr;
 
 reread:
 	error = hfsplus_submit_bio(sb, part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, (void **)&sbi->s_vhdr,
 				   REQ_OP_READ);
 	if (error)
-		goto out_free_backup_vhdr;
+		goto out_free_vhdr;
 
 	error = -EINVAL;
 	switch (sbi->s_vhdr->signature) {
@@ -199,7 +196,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 		break;
 	case cpu_to_be16(HFSP_WRAP_MAGIC):
 		if (!hfsplus_read_mdb(sbi->s_vhdr, &wd))
-			goto out_free_backup_vhdr;
+			goto out_free_vhdr;
 		wd.ablk_size >>= HFSPLUS_SECTOR_SHIFT;
 		part_start += (sector_t)wd.ablk_start +
 			       (sector_t)wd.embed_start * wd.ablk_size;
@@ -212,10 +209,13 @@ int hfsplus_read_wrapper(struct super_block *sb)
 		 * (should do this only for cdrom/loop though)
 		 */
 		if (hfs_part_find(sb, &part_start, &part_size))
-			goto out_free_backup_vhdr;
+			goto out_free_vhdr;
 		goto reread;
 	}
 
+	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
+	if (!sbi->s_backup_vhdr_buf)
+		goto out_free_vhdr;
 	error = hfsplus_submit_bio(sb, part_start + part_size - 2,
 				   sbi->s_backup_vhdr_buf,
 				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ);
-- 
2.43.0


