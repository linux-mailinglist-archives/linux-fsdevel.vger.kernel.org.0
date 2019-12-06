Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA7115976
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 23:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFW7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 17:59:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFW7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:59:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6MtA04038392;
        Fri, 6 Dec 2019 22:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=W9YZ2rymUJpYEmDlZSgJzhgM8ZEHSIB+08WzqtebW+0=;
 b=qTSxMpHcOXv99EC5aFHowyfk/zDDTJXRnoeUBWjIsTca9NdP+PgDOYKOehxmb1V0gx5k
 Y7Vijl7pHdq7Wt6UKnWndZ5vzC4db0obCcL8Yk3I2XDcxdSBsw//kR1MsHvYmgXi2dn0
 XkZ6PPBSz5aUN+5VxIhlVm/Up4PYFz6Gf9fJb1Eohr7j54lquGvakRfc2CWHOCSOsF5G
 LtaGlUj7jkFl9E01vjQTP/HFRFGCxzWUSXGEfUY+sHw2MZ91gMOpnnXvnz412Mynit4X
 Q1ClveREjU8uoeLha/swpLbn0nxmvCa6XiaKaHBV2X6TbJFgLHXD4AOQewpLtncFo+j+ Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wkgcqxqa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 22:59:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6MxGFp122666;
        Fri, 6 Dec 2019 22:59:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wqt45h15w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 22:59:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB6MxUwO023092;
        Fri, 6 Dec 2019 22:59:30 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 14:59:30 -0800
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, dhowells@redhat.com, matthewgarrett@google.com,
        jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.snowberg@oracle.com
Subject: [PATCH] debugfs: Return -EPERM when locked down
Date:   Fri,  6 Dec 2019 17:59:09 -0500
Message-Id: <20191206225909.46721-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When lockdown is enabled, debugfs_is_locked_down returns 1. It will then
trigger the following:

WARNING: CPU: 48 PID: 3747
CPU: 48 PID: 3743 Comm: bash Not tainted 5.4.0-1946.x86_64 #1
Hardware name: Oracle Corporation ORACLE SERVER X7-2/ASM, MB, X7-2, BIOS 41060400 05/20/2019
RIP: 0010:do_dentry_open+0x343/0x3a0
Code: 00 40 08 00 45 31 ff 48 c7 43 28 40 5b e7 89 e9 02 ff ff ff 48 8b 53 28 4c 8b 72 70 4d 85 f6 0f 84 10 fe ff ff e9 f5 fd ff ff <0f> 0b 41 bf ea ff ff ff e9 3b ff ff ff 41 bf e6 ff ff ff e9 b4 fe
RSP: 0018:ffffb8740dde7ca0 EFLAGS: 00010202
RAX: ffffffff89e88a40 RBX: ffff928c8e6b6f00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff928dbfd97778 RDI: ffff9285cff685c0
RBP: ffffb8740dde7cc8 R08: 0000000000000821 R09: 0000000000000030
R10: 0000000000000057 R11: ffffb8740dde7a98 R12: ffff926ec781c900
R13: ffff928c8e6b6f10 R14: ffffffff8936e190 R15: 0000000000000001
FS:  00007f45f6777740(0000) GS:ffff928dbfd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff95e0d5d8 CR3: 0000001ece562006 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 vfs_open+0x2d/0x30
 path_openat+0x2d4/0x1680
 ? tty_mode_ioctl+0x298/0x4c0
 do_filp_open+0x93/0x100
 ? strncpy_from_user+0x57/0x1b0
 ? __alloc_fd+0x46/0x150
 do_sys_open+0x182/0x230
 __x64_sys_openat+0x20/0x30
 do_syscall_64+0x60/0x1b0
 entry_SYSCALL_64_after_hwframe+0x170/0x1d5
RIP: 0033:0x7f45f5e5ce02
Code: 25 00 00 41 00 3d 00 00 41 00 74 4c 48 8d 05 25 59 2d 00 8b 00 85 c0 75 6d 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a2 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
RSP: 002b:00007fff95e0d2e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000561178c069b0 RCX: 00007f45f5e5ce02
RDX: 0000000000000241 RSI: 0000561178c08800 RDI: 00000000ffffff9c
RBP: 00007fff95e0d3e0 R08: 0000000000000020 R09: 0000000000000005
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000001 R15: 0000561178c08800

Change the return type to int and return -EPERM when lockdown is enabled
to remove the warning above.

Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 fs/debugfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dede25247b81..f31698f9b586 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
  */
-static bool debugfs_is_locked_down(struct inode *inode,
+static int debugfs_is_locked_down(struct inode *inode,
 				   struct file *filp,
 				   const struct file_operations *real_fops)
 {
@@ -151,9 +151,12 @@ static bool debugfs_is_locked_down(struct inode *inode,
 	    !real_fops->unlocked_ioctl &&
 	    !real_fops->compat_ioctl &&
 	    !real_fops->mmap)
-		return false;
+		return 0;
 
-	return security_locked_down(LOCKDOWN_DEBUGFS);
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
+	return 0;
 }
 
 static int open_proxy_open(struct inode *inode, struct file *filp)
-- 
2.18.1

