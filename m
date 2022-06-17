Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5ED54F4C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381502AbiFQKCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiFQKCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:02:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDF692A4;
        Fri, 17 Jun 2022 03:02:06 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LPZM46LC4zDrMM;
        Fri, 17 Jun 2022 18:01:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 18:02:04 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] exec: remove recheck path_noexec in do_open_execat and uselib
Date:   Fri, 17 Jun 2022 18:15:06 +0800
Message-ID: <20220617101506.2743155-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We got issue as follows:
may_open [pid=1900]: path=file0 mode=1 exec=0
path_mount [pid = 1901]: mnt_flags=0x64 sb_flags=0x1 flags=0x4029 name=/
do_open_execat [pid=1900]: file=./file0 mode = 8828 exec=1 mnt_flags=1064 s_iflags=0, path=file0
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1900 at fs/exec.c:943 do_open_execat+0x24a/0x570
Modules linked in:
CPU: 3 PID: 1900 Comm: rep Not tainted 5.19.0-rc2-next-20220615+ #240
RIP: 0010:do_open_execat+0x24a/0x570
RSP: 0018:ffff88810243fcf8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff11020487fa4 RCX: ffff888126db6900
RDX: 0000000000000000 RSI: ffff888126db6900 RDI: 0000000000000002
RBP: ffff88810c022200 R08: ffffffff86a52a3a R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1075e5e4e2 R12: ffff8881098c23c0
R13: 0000000000000001 R14: ffff8881098c23e0 R15: ffff8881098c23d0
FS:  00007fd72a66c700(0000) GS:ffff8883af2c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200013c0 CR3: 0000000123548000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bprm_execve+0x2c7/0xd70
 do_execveat_common.isra.0+0x338/0x420
 __x64_sys_execveat+0x71/0x80
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The above issue is caused by remount the file system as noexec concurrently.
As commit 0fd338b2d2cd move path_noexec to may_open, and add recheck at end.
This kind of repeated check is unnecessary, because it also occurs in some
scenarios. Even if we guarantee the order of the file opening and remounting
process, there will still be binaries executing under the noexec file system.
The current process can at least ensure that binary files cannot be executed
after the file system is remounted into noexec. So it is safe to delete this
check

Fixes:0fd338b2d2cd("exec: move path_noexec() check earlier")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/exec.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f2cde361bdb1..3419c4158a70 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -140,16 +140,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
-	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
-	 */
-	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
-
 	fsnotify_open(file);
 
 	error = -ENOEXEC;
@@ -168,7 +158,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 			break;
 	}
 	read_unlock(&binfmt_lock);
-exit:
 	fput(file);
 out:
   	return error;
@@ -925,16 +914,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		goto out;
 
-	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
-	 */
-	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
-
 	err = deny_write_access(file);
 	if (err)
 		goto exit;
-- 
2.31.1

