Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC9C115D70
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 17:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLGQQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 11:16:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58984 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfLGQQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 11:16:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB7G5Uwd104906;
        Sat, 7 Dec 2019 16:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=Z1g6ETTgditdnaxVzYZyvy9YazZMEqW70B3znyg7hMM=;
 b=cmCB3BJqMlZVXlsjfjysBdPSgu+zWNVQZXzaaVmS8LO6pLh8XOjcK06pIM0EPZ8/GFpi
 F38V+aA55LkZMtZ18OdrUEEguHfz+y3CWU+opDksttJvVEgfu6frJVw/LKcML8LpzZcs
 UMeTZXLMngynXMRQYUcF1tyGeZ4P9+AqtNW7imuKXz1U+vsWBNhupTmd7u12OPkpfgA2
 a0ENKDFDBRwge52xh1qxlA0Nejo57aq0PKLR3PAcZDNVXKdyfSu2Kydyw5MZA4cUkmc/
 kD2/39CAoBCSYIYyqjuWtNKtfR/kqgXCS5/f8El2q1WSTsQNtinlbGPXKjaZ4WhsjYva AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41psk04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Dec 2019 16:16:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB7GAatn058986;
        Sat, 7 Dec 2019 16:16:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wr17cv8t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Dec 2019 16:16:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB7GGGHZ001543;
        Sat, 7 Dec 2019 16:16:16 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Dec 2019 08:16:16 -0800
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, dhowells@redhat.com, matthewgarrett@google.com,
        jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        eric.snowberg@oracle.com
Subject: [PATCH v2] debugfs: Return -EPERM when locked down
Date:   Sat,  7 Dec 2019 11:16:03 -0500
Message-Id: <20191207161603.35907-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912070139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9463 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912070139
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
to remove the warning above. Also rename debugfs_is_locked_down to
debugfs_locked_down to make it sound less like it returns a boolean.

Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2 changes:
- debugfs_locked_down rename - recommended by Matthew Wilcox

 fs/debugfs/file.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dede25247b81..18eeeb093a68 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -142,18 +142,21 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
  */
-static bool debugfs_is_locked_down(struct inode *inode,
-				   struct file *filp,
-				   const struct file_operations *real_fops)
+static int debugfs_locked_down(struct inode *inode,
+			       struct file *filp,
+			       const struct file_operations *real_fops)
 {
 	if ((inode->i_mode & 07777) == 0444 &&
 	    !(filp->f_mode & FMODE_WRITE) &&
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
@@ -168,7 +171,7 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 
 	real_fops = debugfs_real_fops(filp);
 
-	r = debugfs_is_locked_down(inode, filp, real_fops);
+	r = debugfs_locked_down(inode, filp, real_fops);
 	if (r)
 		goto out;
 
@@ -298,7 +301,7 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 
 	real_fops = debugfs_real_fops(filp);
 
-	r = debugfs_is_locked_down(inode, filp, real_fops);
+	r = debugfs_locked_down(inode, filp, real_fops);
 	if (r)
 		goto out;
 
-- 
2.18.1

