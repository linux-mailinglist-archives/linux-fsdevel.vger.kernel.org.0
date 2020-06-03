Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851421ECD5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFCKS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:18:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgFCKSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:18:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053A1wQ1048704;
        Wed, 3 Jun 2020 06:18:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31e3rj2rng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 06:18:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053AGEhO018640;
        Wed, 3 Jun 2020 10:18:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47ytcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 10:18:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053AIgbA2490716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jun 2020 10:18:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AE3DAE053;
        Wed,  3 Jun 2020 10:18:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E03ACAE045;
        Wed,  3 Jun 2020 10:18:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.36.151])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jun 2020 10:18:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] ext4: mballoc: Use raw_cpu_ptr instead of this_cpu_ptr
Date:   Wed,  3 Jun 2020 15:48:27 +0530
Message-Id: <20200603101827.2824-1-riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200602134721.18211-1-riteshh@linux.ibm.com>
References: <20200602134721.18211-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_06:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=986 cotscore=-2147483648 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=1 priorityscore=1501 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It doesn't really matter in ext4_mb_new_blocks() about whether the code
is rescheduled on any other cpu due to preemption. Because we care
about discard_pa_seq only when the block allocation fails and then too
we add the seq counter of all the cpus against the initial sampled one
to check if anyone has freed any blocks while we were doing allocation.

So just use raw_cpu_ptr instead of this_cpu_ptr to avoid this BUG.

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
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9083113a8c0..b79b32dbe3ea 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4708,7 +4708,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
-	seq = *this_cpu_ptr(&discard_pa_seq);
+	seq = *raw_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
-- 
2.21.3

