Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1B28E859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 23:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgJNVYN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 17:24:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51996 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgJNVYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:24:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09ELFXmt005550
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:24:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 345ff5qtrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:24:11 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 14:24:10 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 625582EC7F57; Wed, 14 Oct 2020 13:46:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
Date:   Wed, 14 Oct 2020 13:45:28 -0700
Message-ID: <20201014204529.934574-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
might re-read the pointer again which could be NULL already, if in between
reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
to NULL.

This is seen in production with the following stack trace:

[22942.418012] BUG: kernel NULL pointer dereference, address: 0000000000000048
...
[22942.976884] RIP: 0010:prepend_path.isra.4+0x1ce/0x2e0
[22943.037706] Code: 89 c6 e9 0d ff ff ff 49 8b 85 c0 00 00 00 48 85 c0 0f 84 9d 00 00 00 48 3d 00 f0 ff ff 0f 87 91 00 00 00 49 8b 86 e0 00 00 00 <48> 83 78 48 00 0f 94 c0 0f b6 c0 83 c0 01 e9 3b ff ff ff 39 0d 29
[22943.264141] RSP: 0018:ffffc90020d6fd98 EFLAGS: 00010283
[22943.327058] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000007e5ee
[22943.413041] RDX: ffff889fb56ac0c0 RSI: ffffffd05dc8147e RDI: ffff88b1f845ab7b
[22943.499015] RBP: ffff889fbf8100c0 R08: ffffc90020d6fe30 R09: ffffc90020d6fe2c
[22943.584992] R10: ffffc90020d6fe2c R11: ffffea00095836c0 R12: ffffc90020d6fe30
[22943.670968] R13: ffff88b7d336bea0 R14: ffff88b7d336be80 R15: ffff88aeb78db980
[22943.756944] FS:  00007f228447e980(0000) GS:ffff889fc00c0000(0000) knlGS:0000000000000000
[22943.854448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22943.923653] CR2: 0000000000000048 CR3: 0000001ed235e001 CR4: 00000000007606e0
[22944.009630] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[22944.095604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[22944.181581] PKRU: 55555554
[22944.214100] Call Trace:
[22944.243485]  d_path+0xe6/0x150
[22944.280202]  proc_pid_readlink+0x8f/0x100
[22944.328449]  vfs_readlink+0xf8/0x110
[22944.371456]  ? touch_atime+0x33/0xd0
[22944.414466]  do_readlinkat+0xfd/0x120
[22944.458522]  __x64_sys_readlinkat+0x1a/0x20
[22944.508868]  do_syscall_64+0x42/0x110
[22944.552928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: f2683bd8d5bd ("[PATCH] fix d_absolute_path() interplay with fsmount()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/d_path.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..a69e2cd36e6e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -102,6 +102,8 @@ static int prepend_path(const struct path *path,
 
 		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
 			struct mount *parent = READ_ONCE(mnt->mnt_parent);
+			struct mnt_namespace *mnt_ns;
+
 			/* Escaped? */
 			if (dentry != vfsmnt->mnt_root) {
 				bptr = *buffer;
@@ -116,7 +118,9 @@ static int prepend_path(const struct path *path,
 				vfsmnt = &mnt->mnt;
 				continue;
 			}
-			if (is_mounted(vfsmnt) && !is_anon_ns(mnt->mnt_ns))
+			mnt_ns = READ_ONCE(mnt->mnt_ns);
+			/* open-coded is_mounted() to use local mnt_ns */
+			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
 				error = 1;	// absolute root
 			else
 				error = 2;	// detached or not attached yet
-- 
2.24.1

