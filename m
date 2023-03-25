Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978E26C8C5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 09:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCYIOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYIN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:13:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74270F75C;
        Sat, 25 Mar 2023 01:13:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P5Htot025280;
        Sat, 25 Mar 2023 08:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=iaivLyuICFeGZytvyZej1d4JXtjY+23Vlgw9SCE1DSA=;
 b=IMxIiM0djk6husyDT/AQCgdeLvk4U1rIDXDlkLP9Zs0MznmQxID6pURtCXIhif5gv/Kd
 Hsl9TQ238WWQ1ptg4aje28IpbkJ7lbK+5f56CuDzbxoS//9963QQGIfLGrRsjsQ4im/u
 f6wlf/r9zLYSLw+LLGRcxN7ZjwQ1aMEynrJmFHRHkP1EaF0KgsfGgalDnCIo1q5AkueW
 btsxtTrrjVa1BwWYmKXnkw4U+tGcGj9VSjwNOaOZRC5WfPaXqj2bFbG7PZrXWhL595ed
 T4wPkDPR+gOhKdnHoQUZAA0HOofT+vL7kMB+m/wpXUtqrA0DLHgYtvOSgR2w8hipXL/P zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phtpg25n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:13:51 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32P8DpNb034563;
        Sat, 25 Mar 2023 08:13:51 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phtpg25mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:13:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2TNZr028880;
        Sat, 25 Mar 2023 08:13:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3phr7fg8yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:13:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32P8Dk5g28311994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 08:13:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE26320043;
        Sat, 25 Mar 2023 08:13:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D388420040;
        Sat, 25 Mar 2023 08:13:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.63.61])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 25 Mar 2023 08:13:44 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: [PATCH v6 0/9] ext4: Convert inode preallocation list to an rbtree
Date:   Sat, 25 Mar 2023 13:43:33 +0530
Message-Id: <cover.1679731817.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 12tilULreAvFTteEQu6hPVDZ_x2VBh94
X-Proofpoint-ORIG-GUID: uuWgdB-9OjKbg5-NUM95UGnZztI0G65Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series aim to improve the performance and scalability of
inode preallocation by changing inode preallocation linked list to an
rbtree. I've ran xfstests quick on this series and plan to run auto group
as well to confirm we have no regressions.

** Shortcomings of existing implementation **

Right now, we add all the inode preallocations(PAs) to a per inode linked
list ei->i_prealloc_list. To prevent the list from growing infinitely
during heavy sparse workloads, the length of this list was capped at 512
and a trimming logic was added to trim the list whenever it grew over
this threshold, in patch 27bc446e2. This was discussed in detail in the
following lore thread [1].

[1] https://lore.kernel.org/all/d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com/

But from our testing, we noticed that the current implementation still
had issues with scalability as the performance degraded when the PAs
stored in the list grew. Most of the degradation was seen in
ext4_mb_normalize_request() and ext4_mb_use_preallocated() functions as
they iterated the inode PA list.

** Improvements in this patchset **

To counter the above shortcomings, this patch series modifies the inode
PA list to an rbtree, which:

- improves the performance of functions discussed above due to the
  improved lookup speed.
  
- improves scalability by changing lookup complexity from O(n) to
  O(logn). We no longer need the trimming logic as well.

As a result, the RCU implementation was needed to be changed since
lockless lookups of rbtrees do have some issues like skipping
subtrees. Hence, RCU was replaced with read write locks for inode
PAs. More information can be found in Patch 7 (that has the core
changes).

** Performance Numbers **

Performance numbers were collected with and without these patches, using an
nvme device. Details of tests/benchmarks used are as follows:

Test 1: 200,000 1KiB sparse writes using (fio)
Test 2: Fill 5GiB w/ random writes, 1KiB burst size using (fio)
Test 3: Test 2, but do 4 sequential writes before jumping to random
        offset (fio)
Test 4: Fill 8GB FS w/ 2KiB files, 64 threads in parallel (fsmark)

+──────────+──────────────────+────────────────+──────────────────+──────────────────+
|          |            nodelalloc             |              delalloc               |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+
|          | Unpatched        | Patched        | Unpatched        | Patched          |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+
| Test 1   | 11.8 MB/s        | 23.3 MB/s      | 27.2 MB/s        | 63.7 MB/s        |
| Test 2   | 1617 MB/s        | 1740 MB/s      | 2223 MB/s        | 2208 MB/s        |
| Test 3   | 1715 MB/s        | 1823 MB/s      | 2346 MB/s        | 2364 MB/s        |
| Test 4   | 14284 files/sec  | 14347 files/s  | 13762 files/sec  | 13882 files/sec  |
+──────────+──────────────────+────────────────+──────────────────+──────────────────+

In test 1, we almost see 100 to 200% increase in performance due to the high number
of sparse writes highlighting the bottleneck in the unpatched kernel. Further, on running
"perf diff patched.data unpatched.data" for test 1, we see something as follows:

     2.83%    +29.67%  [kernel.vmlinux]          [k] _raw_spin_lock
												...
               +3.33%  [ext4]                    [k] ext4_mb_normalize_request.constprop.30
     0.25%     +2.81%  [ext4]                    [k] ext4_mb_use_preallocated

Here we can see that the biggest different is in the _raw_spin_lock() function
of unpatched kernel, that is called from `ext4_mb_normalize_request()` as seen
here:

    32.47%  fio              [kernel.vmlinux]            [k] _raw_spin_lock
            |
            ---_raw_spin_lock
               |          
                --32.22%--ext4_mb_normalize_request.constprop.30

This is coming from the spin_lock(&pa->pa_lock) that is called for
each PA that we iterate over, in ext4_mb_normalize_request(). Since in rbtrees,
we lookup log(n) PAs rather than n PAs, this spin lock is taken less frequently,
as evident in the perf. 

Furthermore, we see some improvements in other tests however since they don't
exercise the PA traversal path as much as test 1, the improvements are relatively
smaller. 

** Summary of patches **

- Patch 1-5: Abstractions/Minor optimizations
- Patch 6: Change bex lstart adjustment logic to avoid overflow from goal
- Patch 7: Split common inode & locality group specific fields to a union
- Patch 8: Core changes to move inode PA logic from list to rbtree
- Patch 9: Remove the trim logic as it is not needed

** Changes since PATCH v5 [6] **
- Rebased on ted/dev.
- No functional changes, just made sure
  to add a few Suggested-by tags that I 
  had missed earlier.

** Changes since PATCH v4 [4] **
- ./checkpatch fixes
- Picked up RVBs by Ritesh and Jan
- Rebased over ted/dev which includes Kemeng's mballoc cleanup v3 patches [5]

** Changes since PATCH v3 [2] **
- Patch 6 fixes a bug in current best extent adjustment logic by
  introducing a new logic.
- Patch 8 - ext4_mb_pa_adjust_overlap functions uses a modified logic to
  trim the normalized range, which also takes care of presence deleted
  PAs in the preallocation tree.
- Ran xfstests -c all quick and everything seems good. Performance
  numbers seem similar to previous improvements as well.

Both the above changes are based on discussion here [3]

** Changes since PATCH v2 [1] **
- In patch 7, include a design change related to 
  encountering deleted PAs in inode rbtree that overlap with to be
  inserted PA, when adjusting overlap. More details in the patch.
  (Removed Jan's RVB for this patch)

** Changes since PATCH v1 **
- fixed styling issue
- merged ext4_mb_rb_insert() and ext4_mb_pa_cmp()

** Changes since RFC v3 **
- Changed while loops to for loops in patch 7
- Fixed some data types
- Made rbtree comparison logic more intuitive. The
  rbtree insertion function still kept separate from
  comparison function for reusability.

** Changes since RFC v2 **
- Added a function definition that was deleted during v2 rebase

** Changes since RFC v1 **
- Rebased over ext4 dev branch which includes Jan's patchset
  that changed some code in mballoc.c

[1] https://lore.kernel.org/linux-ext4/cover.1665776268.git.ojaswin@linux.ibm.com/
[2] https://lore.kernel.org/all/20230116080216.249195-1-ojaswin@linux.ibm.com/
[3]
https://lore.kernel.org/all/20230116080216.249195-8-ojaswin@linux.ibm.com/
[4]
https://lore.kernel.org/all/cover.1676634592.git.ojaswin@linux.ibm.com/
[5]
https://lore.kernel.org/r/20230303172120.3800725-1-shikemeng@huaweicloud.com
[6]
https://lore.kernel.org/all/cover.1679042083.git.ojaswin@linux.ibm.com/

Ojaswin Mujoo (9):
  ext4: Stop searching if PA doesn't satisfy non-extent file
  ext4: Refactor code related to freeing PAs
  ext4: Refactor code in ext4_mb_normalize_request() and
    ext4_mb_use_preallocated()
  ext4: Move overlap assert logic into a separate function
  ext4: Abstract out overlap fix/check logic in
    ext4_mb_normalize_request()
  ext4: Fix best extent lstart adjustment logic in
    ext4_mb_new_inode_pa()
  ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
  ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
  ext4: Remove the logic to trim inode PAs

 Documentation/admin-guide/ext4.rst |   3 -
 fs/ext4/ext4.h                     |   5 +-
 fs/ext4/mballoc.c                  | 536 ++++++++++++++++++++---------
 fs/ext4/mballoc.h                  |  17 +-
 fs/ext4/super.c                    |   4 +-
 fs/ext4/sysfs.c                    |   2 -
 6 files changed, 377 insertions(+), 190 deletions(-)

-- 
2.31.1

