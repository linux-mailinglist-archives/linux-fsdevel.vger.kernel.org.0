Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A91F38C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFIKx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 06:53:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgFIKxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:53:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059AXCI9107631;
        Tue, 9 Jun 2020 06:53:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31j59u7yk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:53:20 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059AXOf6108484;
        Tue, 9 Jun 2020 06:53:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31j59u7yj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:53:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059AfOQV013020;
        Tue, 9 Jun 2020 10:53:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7wsa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:53:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059ArFaD58851400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 10:53:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D2DFAE055;
        Tue,  9 Jun 2020 10:53:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33063AE053;
        Tue,  9 Jun 2020 10:53:13 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.37.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 10:53:13 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.com, tytso@mit.edu, Hillf Danton <hdanton@sina.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
Subject: [PATCHv2 1/1] ext4: mballoc: Use this_cpu_read instead of this_cpu_ptr
Date:   Tue,  9 Jun 2020 16:23:10 +0530
Message-Id: <534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_03:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 cotscore=-2147483648 phishscore=0
 mlxlogscore=907 bulkscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090081
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify reading a seq variable by directly using this_cpu_read API
instead of doing this_cpu_ptr and then dereferencing it.

This also avoid the below kernel BUG: which happens when
CONFIG_DEBUG_PREEMPT is enabled

BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6927
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 6927 Comm: syz-fuzzer Not tainted 5.7.0-next-20200602-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
 ext4_append+0x153/0x360 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
 vfs_mkdir+0x419/0x690 fs/namei.c:3632
 do_mkdirat+0x21e/0x280 fs/namei.c:3655
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 42f56b7a4a7d ("ext4: mballoc: introduce pcpu seqcnt for freeing PA
to improve ENOSPC handling")
Suggested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9083113a8c0..c0a331e2feb0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4708,7 +4708,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
-	seq = *this_cpu_ptr(&discard_pa_seq);
+	seq = this_cpu_read(discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
-- 
2.25.4

