Return-Path: <linux-fsdevel+bounces-34722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34A9C805A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 03:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31D0281B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C01E47A4;
	Thu, 14 Nov 2024 02:04:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB817C20F;
	Thu, 14 Nov 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549873; cv=none; b=uDoe+fLVWciH0R1B4yRMhR66E+a3jYUuNPhOxh4+Z6k4+V34XNz4qcwmUkLJZDuVvCt0CVr95KGFH2UQCMn+6VyYoh6+YX/tv7Ei7+1bVEusuo1LWE4p4/SYoUuVWE3Uvi4UMuw3wH8y8cNVoX7k4XCRGX7Z2btuAaT9HYJFetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549873; c=relaxed/simple;
	bh=agwovk256vK4XfQ7Z5M3G5mwzl0v/uvmDiga3/uKxmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aas/k8bOoCT9IAerOA++c5x56EAp/8QZr64VQESnsFVk4J9hm6zRDM98eEIVlA4H5oXwTjCBrI8I/p7cC37u8TKAi0Auk+eXk6Ue6h880OqaIT943mxEBwT4xiSCZ85a/iYXmE+zKHqcdddpfSQRBKatho9OJtsOjcqIQkvv1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE0iAqZ012987;
	Thu, 14 Nov 2024 02:04:20 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwv4av3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Nov 2024 02:04:20 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 13 Nov 2024 18:04:19 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 13 Nov 2024 18:04:17 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <miklos@szeredi.hu>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] fuse: check file before running readpage
Date: Thu, 14 Nov 2024 10:04:16 +0800
Message-ID: <20241114020417.3524632-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
References: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hZiKppQXGaSippmVQxg-DczSrg-DQCTP
X-Authority-Analysis: v=2.4 cv=Ke6AshYD c=1 sm=1 tr=0 ts=67355aa4 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=_mVfgZgp1h17fTi5wYsA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: hZiKppQXGaSippmVQxg-DczSrg-DQCTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_01,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=756 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411140014

syzbot reported a null-ptr-deref in fuse_read_args_fill. [1]

About this case, calltrace is:
erofs_read_superblock()->
  erofs_read_metabuf()->
    erofs_bread()->
      read_mapping_folio()->
        do_read_cache_folio()->
          filemap_read_folio()->
            fuse_read_folio()->
              fuse_do_readpage()->
                fuse_read_args_fill()

erofs_bread() calls read_mapping_folio() passing NULL file, which causes a
NULL pointer dereference in fuse_read_args_fill.
To avoid this issue, need to add a check for file in fuse_read_folio().

[1]
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor314 Not tainted 6.12.0-rc5-syzkaller-00044-gc1e939a21eb1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fuse_read_args_fill fs/fuse/file.c:631 [inline]
RIP: 0010:fuse_do_readpage+0x276/0x640 fs/fuse/file.c:880
Code: e8 9f c7 91 fe 8b 44 24 10 89 44 24 78 41 89 c4 e8 8f c7 91 fe 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1d 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90006a0f820 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82fbb4c9
RDX: 000000000000000c RSI: ffffffff82fbb4f1 RDI: 0000000000000060
RBP: 0000000000000000 R08: 0000000000000007 R09: 7fffffffffffffff
R10: 0000000000000fff R11: ffffffff961d4b88 R12: 0000000000001000
R13: ffff8880382b8000 R14: ffff888025153780 R15: ffffc90006a0f8b8
FS:  00007f7583f3d6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 0000000030d30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_read_folio+0xb0/0x100 fs/fuse/file.c:905
 filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
 do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 erofs_bread+0x34d/0x7e0 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:281 [inline]
 erofs_fc_fill_super+0x2b9/0x2500 fs/erofs/super.c:625
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xda/0x190 fs/super.c:1299
 erofs_fc_get_tree+0x1fe/0x2e0 fs/erofs/super.c:723
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-and-tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index dafdf766b1d5..5ce37d1f617c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -899,7 +899,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 	int err;
 
 	err = -EIO;
-	if (fuse_is_bad(inode))
+	if (fuse_is_bad(inode) || !file)
 		goto out;
 
 	err = fuse_do_readpage(file, page);
-- 
2.43.0


