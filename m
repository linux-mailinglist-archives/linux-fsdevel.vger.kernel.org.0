Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2211EDAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 23:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMWY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 17:24:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMWY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:24:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDMOO28155344;
        Fri, 13 Dec 2019 22:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=QUIXsOoy+ec+JNrRBMR7QrIHAGWn0KFprylci6Z6A0U=;
 b=F9NeOTKwf7Hz2yjtNi/QZXhCH3jMbEZGTH1RR1lom6OmoPuOrBhofOtm2T5IITwJgFKS
 nZLiXtW5ApPPbbgWlJdovxw3zHEjo6kYkBcXQrYsSHMdd24uQrorm/tGsTgs+Ez7o+Lw
 KQM16Tk4AnyZxwkL49B9ekJC8R/EfwTrQuYz/uDvuv7l1s7Sphm/FHDRpWfgYC9AOWRK
 brgSMamQf7rHCAGxKRAIWg5j8L+UyLjNvXEWH5SyW3ogYfaF8B3JqzDxhASfYDgO+X4X
 tTUUHJe+8wmZD+6KSCmnBLuqVg3hJiJGKYWEsVmP9MHo+0cXtyA7tZGdbro0cdLS4jWy UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qum4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 22:24:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDMNa9C077548;
        Fri, 13 Dec 2019 22:24:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wvdwr9hhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 22:24:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDMOMNs013254;
        Fri, 13 Dec 2019 22:24:22 GMT
Received: from jubi-laptop.us.oracle.com (/10.211.46.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 14:24:22 -0800
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCH] vfs: stop shrinker while fs is freezed
Date:   Fri, 13 Dec 2019 14:24:40 -0800
Message-Id: <20191213222440.11519-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=976
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shrinker could be blocked by freeze while dropping the last reference of
some inode that had been removed. As "s_umount" lock was acquired by the
Shrinker before blocked, the thaw will hung by this lock. This caused a
deadlock.

 crash7latest> set 132
     PID: 132
 COMMAND: "kswapd0:0"
    TASK: ffff9cdc9dfb5f00  [THREAD_INFO: ffff9cdc9dfb5f00]
     CPU: 6
   STATE: TASK_UNINTERRUPTIBLE
 crash7latest> bt
 PID: 132    TASK: ffff9cdc9dfb5f00  CPU: 6   COMMAND: "kswapd0:0"
  #0 [ffffaa5d075bf900] __schedule at ffffffff8186487c
  #1 [ffffaa5d075bf998] schedule at ffffffff81864e96
  #2 [ffffaa5d075bf9b0] rwsem_down_read_failed at ffffffff818689ee
  #3 [ffffaa5d075bfa40] call_rwsem_down_read_failed at ffffffff81859308
  #4 [ffffaa5d075bfa90] __percpu_down_read at ffffffff810ebd38
  #5 [ffffaa5d075bfab0] __sb_start_write at ffffffff812859ef
  #6 [ffffaa5d075bfad0] xfs_trans_alloc at ffffffffc07ebe9c [xfs]
  #7 [ffffaa5d075bfb18] xfs_free_eofblocks at ffffffffc07c39d1 [xfs]
  #8 [ffffaa5d075bfb80] xfs_inactive at ffffffffc07de878 [xfs]
  #9 [ffffaa5d075bfba0] __dta_xfs_fs_destroy_inode_3543 at ffffffffc07e885e [xfs]
 #10 [ffffaa5d075bfbd0] destroy_inode at ffffffff812a25de
 #11 [ffffaa5d075bfbe8] evict at ffffffff812a2b73
 #12 [ffffaa5d075bfc10] dispose_list at ffffffff812a2c1d
 #13 [ffffaa5d075bfc38] prune_icache_sb at ffffffff812a421a
 #14 [ffffaa5d075bfc70] super_cache_scan at ffffffff812870a1
 #15 [ffffaa5d075bfcc8] shrink_slab at ffffffff811eebb3
 #16 [ffffaa5d075bfdb0] shrink_node at ffffffff811f4788
 #17 [ffffaa5d075bfe38] kswapd at ffffffff811f58c3
 #18 [ffffaa5d075bff08] kthread at ffffffff810b75d5
 #19 [ffffaa5d075bff50] ret_from_fork at ffffffff81a0035e
 crash7latest> set 31060
     PID: 31060
 COMMAND: "safefreeze"
    TASK: ffff9cd292868000  [THREAD_INFO: ffff9cd292868000]
     CPU: 2
   STATE: TASK_UNINTERRUPTIBLE
 crash7latest> bt
 PID: 31060  TASK: ffff9cd292868000  CPU: 2   COMMAND: "safefreeze"
  #0 [ffffaa5d10047c90] __schedule at ffffffff8186487c
  #1 [ffffaa5d10047d28] schedule at ffffffff81864e96
  #2 [ffffaa5d10047d40] rwsem_down_write_failed at ffffffff81868f18
  #3 [ffffaa5d10047dd8] call_rwsem_down_write_failed at ffffffff81859367
  #4 [ffffaa5d10047e20] down_write at ffffffff81867cfd
  #5 [ffffaa5d10047e38] thaw_super at ffffffff81285d2d
  #6 [ffffaa5d10047e60] do_vfs_ioctl at ffffffff81299566
  #7 [ffffaa5d10047ee8] sys_ioctl at ffffffff81299709
  #8 [ffffaa5d10047f28] do_syscall_64 at ffffffff81003949
  #9 [ffffaa5d10047f50] entry_SYSCALL_64_after_hwframe at ffffffff81a001ad
     RIP: 0000000000453d67  RSP: 00007ffff9c1ce78  RFLAGS: 00000206
     RAX: ffffffffffffffda  RBX: 0000000001cbe92c  RCX: 0000000000453d67
     RDX: 0000000000000000  RSI: 00000000c0045878  RDI: 0000000000000014
     RBP: 00007ffff9c1cf80   R8: 0000000000000000   R9: 0000000000000012
     R10: 0000000000000008  R11: 0000000000000206  R12: 0000000000401fb0
     R13: 0000000000402040  R14: 0000000000000000  R15: 0000000000000000
     ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index cfadab2cbf35..adc18652302b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -80,6 +80,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
+	if (sb->s_writers.frozen != SB_UNFROZEN) {
+		up_read(&sb->s_umount);
+		return SHRINK_STOP;
+	}
+
 	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
-- 
2.17.1

