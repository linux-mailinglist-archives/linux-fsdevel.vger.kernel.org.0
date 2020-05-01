Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049DE1C0E12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEAGac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4244 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgEAGa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04161sTj090469;
        Fri, 1 May 2020 02:30:23 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r821rn9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:22 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AvNq001466;
        Fri, 1 May 2020 06:30:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7y8qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416U9se59703398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8D8CA4069;
        Fri,  1 May 2020 06:30:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BB0DA4068;
        Fri,  1 May 2020 06:30:07 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 00/20] ext4: Fix ENOSPC error, improve mballoc dbg, other cleanups
Date:   Fri,  1 May 2020 11:59:42 +0530
Message-Id: <cover.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

v2 -> v3:
v3 changes the code design to fix ENOSPC error. This patch uses the percpu
discard pa seq counter (which was as discussed with Jan & Aneesh).
Patch-2 commit msg describes both the problem and the new algorithm in
great detail. Rest of the patches are mostly either refactoring, code
cleanups or debug logs improvements.

Posting this for early review comments.
For now I have done some basic testing on this patch to test
for ENOSPC reported errors, using a smaller filesystem (~240MB, 64K bs)
a. Tested multi-thread file writes which only allocates group PAs.
b. Tested multi-thread file writes which only allocates inode PAs.
c. Tested multi-thread file writes doing combination of both of the above.

[May Not be Ready for Merge yet, until below are properly discussed]
==================================================================

1. There is a query asked in Patch-2 commit msg itself, regarding
   rcu_barrier() usage.

2. AFAICT, even if we reduce the PA size based on available FS size to avoid
   this ENOSPC error, this issue could still potentially happen since the race
   has mostly to do with 1st thread freeing up all the PAs while 2nd thread
   returning 0 as freed (since PA list was empty). Hence 2nd thread fails
   with ENOSPC even though there were free blocks freed by 1st thread.

3. I would like to know if there is any stress-ng test case or any other use
   case which measures multi-thread performance of write while FS is close to
   ENOSPC? If yes - instead of regressing this later, I would like to know
   such test case so that it can be tested at my end while we are still
   at it.

4. I do see that with 64K blocksize the performance of multi-thread < 1 MB
   file size writes becomes very slow. But without this patch, it anyways fails
   with ENOSPC error. On doing below the performance does improve close to 5x.
   echo 32 > /sys/fs/ext4/loop3/mb_group_prealloc
   I was thinking instead of 512 blocks as default value for
   'MB_DEFAULT_GROUP_PREALLOC', we could make it 64K as the default size and
   decide the no. of blocks based on the blocksize. But I haven't got to it
   yet. But thought to capture it in this email though. We can get to it
   after these patches.

5. Started fstests testing. Will let you know the results soon.

[RFCv2]: https://patchwork.ozlabs.org/project/linux-ext4/patch/533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com/
         - Problems with v2 are captured in Patch-2 commit msg itself.


Ritesh Harjani (20):
  ext4: mballoc: Refactor ext4_mb_discard_preallocations()
  ext4: Introduce percpu seq counter for freeing blocks(PA) to avoid
    ENOSPC err
  ext4: mballoc: Do print bb_free info even when it is 0
  ext4: mballoc: Refactor ext4_mb_show_ac()
  ext4: mballoc: Add more mb_debug() msgs
  ext4: mballoc: Correct the mb_debug() format specifier for pa_len var
  ext4: mballoc: Fix few other format specifier in mb_debug()
  ext4: mballoc: Simplify error handling in ext4_init_mballoc()
  ext4: mballoc: Make ext4_mb_use_preallocated() return type as bool
  ext4: mballoc: Remove EXT4_MB_HINT_GOAL_ONLY and it's related code
  ext4: mballoc: Refactor code inside DOUBLE_CHECK into separate
    function
  ext4: mballoc: Fix possible NULL ptr dereference from mb_cmp_bitmaps()
  ext4: mballoc: Don't BUG if kmalloc or read blk bitmap fail for
    DOUBLE_CHECK
  ext4: balloc: Use task_pid_nr() helper
  ext4: Use BIT() macro for BH_** state bits
  ext4: Improve ext_debug() msg in case of block allocation failure
  ext4: Replace EXT_DEBUG with __maybe_unused in
    ext4_ext_handle_unwritten_extents()
  ext4: mballoc: Make mb_debug() implementation to use pr_debug()
  ext4: Make ext_debug() implementation to use pr_debug()
  ext4: Add process name and pid in ext4_msg()

 fs/ext4/Kconfig             |   3 +-
 fs/ext4/balloc.c            |   5 +-
 fs/ext4/ext4.h              |  38 ++--
 fs/ext4/extents.c           | 150 ++++++++--------
 fs/ext4/inode.c             |  15 +-
 fs/ext4/mballoc.c           | 347 +++++++++++++++++++++++-------------
 fs/ext4/mballoc.h           |  16 +-
 fs/ext4/super.c             |   3 +-
 include/trace/events/ext4.h |   1 -
 9 files changed, 335 insertions(+), 243 deletions(-)

-- 
2.21.0

